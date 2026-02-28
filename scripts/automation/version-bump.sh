#!/usr/bin/env bash
set -euo pipefail

#
# version-bump.sh — Bump the patch version after a PR is merged.
#
# Usage: bash scripts/automation/version-bump.sh [ISSUE_NUMBER] [MERGE_SHA] [PR_NUMBER]
#

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
REPO="bwoody77/spectest"
ISSUE_NUMBER="${1:-}"
MERGE_SHA="${2:-}"
PR_NUMBER="${3:-}"

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] [version-bump] $1"; }

log "Starting version bump (issue: ${ISSUE_NUMBER:-none}, sha: ${MERGE_SHA:-unknown})"

cd "$PROJECT_DIR"

git checkout main 2>/dev/null || true
git pull origin main 2>/dev/null || true

VERSION_FILE="$PROJECT_DIR/version.json"
PKG_FILE="$PROJECT_DIR/package.json"

if [[ -f "$VERSION_FILE" ]]; then
  CURRENT_VERSION=$(grep '"version"' "$VERSION_FILE" | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
else
  CURRENT_VERSION=$(grep '"version"' "$PKG_FILE" | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
fi

[[ -z "${CURRENT_VERSION:-}" ]] && CURRENT_VERSION="1.0.0"

MAJOR=$(echo "$CURRENT_VERSION" | cut -d. -f1)
MINOR=$(echo "$CURRENT_VERSION" | cut -d. -f2)
PATCH=$(echo "$CURRENT_VERSION" | cut -d. -f3)
NEW_PATCH=$((PATCH + 1))
NEW_VERSION="$MAJOR.$MINOR.$NEW_PATCH"

log "Version: $CURRENT_VERSION → $NEW_VERSION"

RELEASE_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
ACTUAL_SHA="${MERGE_SHA:-$(git log -1 --format='%h' 2>/dev/null || echo 'unknown')}"

# Read framework version from spec compiler
SPEC_PKG="/opt/repos/spec/packages/compiler/package.json"
SPEC_VERSION=$(grep '"version"' "$SPEC_PKG" 2>/dev/null | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/' || echo "unknown")

node --input-type=commonjs << NODEEOF
const fs = require('fs');
const vFile = '${VERSION_FILE}';
const newVersion = '${NEW_VERSION}';
const sha = '${ACTUAL_SHA}';
const issueNum = '${ISSUE_NUMBER}';
const prNum = '${PR_NUMBER}';
const releaseDate = '${RELEASE_DATE}';
const specVersion = '${SPEC_VERSION}';

let releases = [];
if (fs.existsSync(vFile)) {
  try {
    const existing = JSON.parse(fs.readFileSync(vFile, 'utf8'));
    releases = existing.releases || [];
  } catch (e) {}
}

const newRelease = {
  version: newVersion,
  date: releaseDate,
  commit: sha,
  issues: issueNum ? [parseInt(issueNum, 10)] : [],
  prNumber: prNum ? parseInt(prNum, 10) : null
};
releases = [newRelease, ...releases].slice(0, 50);

const data = {
  version: newVersion,
  buildDate: releaseDate,
  commit: sha,
  frameworkVersions: { spec: specVersion },
  releases
};
fs.writeFileSync(vFile, JSON.stringify(data, null, 2) + '\n');
console.log('Updated version.json → ' + newVersion);
NODEEOF

OLD_PKG_VERSION=$(grep '"version"' "$PKG_FILE" | head -1 | sed 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/')
sed -i "s/\"version\": \"${OLD_PKG_VERSION}\"/\"version\": \"${NEW_VERSION}\"/" "$PKG_FILE"
log "Updated package.json → $NEW_VERSION"

git add "$VERSION_FILE" "$PKG_FILE"
git commit -m "chore: release v${NEW_VERSION} (#${ISSUE_NUMBER:-0})"

TAG_NAME="v${NEW_VERSION}"
git tag "$TAG_NAME" -m "Release ${NEW_VERSION}"
log "Created tag $TAG_NAME"

git push origin main
git push origin "$TAG_NAME"
log "Pushed main and tag $TAG_NAME to origin"

if [[ -n "${ISSUE_NUMBER:-}" ]]; then
  RELEASE_URL="https://github.com/$REPO/releases/tag/$TAG_NAME"
  gh issue comment "$ISSUE_NUMBER" -R "$REPO" --body "## Released in ${TAG_NAME}

This issue was included in **[${TAG_NAME}](${RELEASE_URL})**.

- **Release date:** ${RELEASE_DATE}
- **Commit:** \`${ACTUAL_SHA}\`
- **PR:** #${PR_NUMBER:-unknown}

When you open the app and navigate to **About**, you should see version \`${NEW_VERSION}\` or greater." 2>/dev/null \
    && log "Commented on issue #$ISSUE_NUMBER" \
    || log "WARNING: Could not comment on issue #$ISSUE_NUMBER (non-fatal)"
fi

log "Version bump complete: $NEW_VERSION"

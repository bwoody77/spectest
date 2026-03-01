#!/bin/bash
# Deploy spectest to UAT Server
# Usage: bash deploy-uat.sh [VERSION]
#   VERSION: optional git tag (e.g. v0.1.1). Defaults to latest main.
set -e

REMOTE_DIR="/var/www/spectest-uat"
PM2_APP_NAME="spectest-uat"
API_PORT="3033"

SPEC_DIR="/opt/repos/spec"
VERSION="${1:-}"

echo "=== Spectest UAT Deployment ==="
cd "$(dirname "$0")"

if [[ -n "$VERSION" ]]; then
    echo "Deploying version $VERSION to UAT (uat.spectest.aventoapp.com)."
else
    echo "Deploying latest main to UAT (uat.spectest.aventoapp.com)."
fi

echo ""
read -p "Are you sure? (yes/no): " confirm
if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

# Checkout version if specified
if [[ -n "$VERSION" ]]; then
    git stash 2>/dev/null || true
    git fetch --tags
    git checkout "tags/$VERSION"
fi

echo ""
echo "=== Ensuring spec compiler is built ==="
if [ ! -f "$SPEC_DIR/packages/cli/dist/index.js" ]; then
    (cd "$SPEC_DIR/packages/compiler" && npm run build)
    (cd "$SPEC_DIR/packages/cli" && npm run build)
fi

echo ""
echo "=== Building frontend (spec compile) ==="
npm run build 2>&1 || echo "WARNING: Spec compile failed — API only."

echo ""
echo "=== Packaging spectest files ==="
tar czf /tmp/spectest-uat-deploy.tar.gz \
    --exclude=node_modules \
    --exclude=.env \
    --exclude=.git \
    server.mjs \
    version.json \
    package.json \
    package-lock.json \
    $([ -d dist ] && echo "dist" || true)

# Restore git state if we checked out a version
if [[ -n "$VERSION" ]]; then
    git checkout -
    git stash pop 2>/dev/null || true
fi

echo ""
echo "=== Deploying to UAT ==="
if [ -f "$REMOTE_DIR/.env" ]; then
    cp "$REMOTE_DIR/.env" /tmp/spectest-uat-env.bak
fi
sudo rm -rf "$REMOTE_DIR"
sudo mkdir -p "$REMOTE_DIR"
sudo tar xzf /tmp/spectest-uat-deploy.tar.gz -C "$REMOTE_DIR"
sudo chown -R root:root "$REMOTE_DIR"
if [ -f /tmp/spectest-uat-env.bak ]; then
    sudo mv /tmp/spectest-uat-env.bak "$REMOTE_DIR/.env"
fi

echo ""
echo "=== Installing dependencies ==="
cd "$REMOTE_DIR" && sudo npm install --production 2>/dev/null || true

echo ""
echo "=== Setting up environment ==="
if [ ! -f "$REMOTE_DIR/.env" ]; then
    sudo tee "$REMOTE_DIR/.env" > /dev/null << EOF
NODE_ENV=production
PORT=$API_PORT
HOST=127.0.0.1
EOF
fi

echo ""
echo "=== Restarting PM2 application ==="
pm2 delete "$PM2_APP_NAME" 2>/dev/null || true
pm2 start "node --env-file=.env server.mjs" --name "$PM2_APP_NAME" --cwd "$REMOTE_DIR" --interpreter none
pm2 save

echo ""
echo "=== Reloading nginx ==="
sudo nginx -t && sudo systemctl reload nginx

rm -f /tmp/spectest-uat-deploy.tar.gz

echo ""
echo "UAT deployment complete!"
echo "UAT site: https://uat.spectest.aventoapp.com"
echo "Logs: pm2 logs $PM2_APP_NAME"

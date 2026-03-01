#!/bin/bash
# Deploy spectest to Dev Server
set -e

REMOTE_DIR="/var/www/spectest-dev"
PM2_APP_NAME="spectest-dev"
API_PORT="3032"

SPEC_DIR="/opt/repos/spec"

echo "=== Spectest Dev Deployment ==="
cd "$(dirname "$0")"

echo ""
echo "=== Ensuring spec compiler is built ==="
if [ ! -f "$SPEC_DIR/packages/cli/dist/index.js" ]; then
    echo "Building spec compiler..."
    (cd "$SPEC_DIR/packages/compiler" && npm run build) 2>&1
    (cd "$SPEC_DIR/packages/cli" && npm run build) 2>&1
    echo "Spec compiler built."
else
    echo "Spec compiler already built."
fi

echo ""
echo "=== Building frontend (spec compile) ==="
if npm run build 2>&1; then
    echo "Frontend build successful."
    HAS_DIST=true
else
    echo "WARNING: Spec compile failed (may be a known compiler limitation)."
    echo "Deploying API server only — frontend will show placeholder."
    HAS_DIST=false
fi

echo ""
echo "=== Packaging spectest files ==="
tar czf /tmp/spectest-deploy.tar.gz \
    --exclude=node_modules \
    --exclude=.env \
    --exclude=.git \
    server.mjs \
    version.json \
    package.json \
    package-lock.json \
    $([ -d dist ] && echo "dist" || true)

echo ""
echo "=== Deploying to dev server ==="

# Preserve .env if it exists
if [ -f "$REMOTE_DIR/.env" ]; then
    cp "$REMOTE_DIR/.env" /tmp/spectest-dev-env.bak
fi
sudo rm -rf "$REMOTE_DIR"
sudo mkdir -p "$REMOTE_DIR"
sudo tar xzf /tmp/spectest-deploy.tar.gz -C "$REMOTE_DIR"
sudo chown -R root:root "$REMOTE_DIR"
if [ -f /tmp/spectest-dev-env.bak ]; then
    sudo mv /tmp/spectest-dev-env.bak "$REMOTE_DIR/.env"
fi

echo ""
echo "=== Installing dependencies ==="
cd "$REMOTE_DIR"
sudo npm install --production 2>/dev/null || true

echo ""
echo "=== Setting up environment ==="
if [ ! -f "$REMOTE_DIR/.env" ]; then
    echo "Creating default .env..."
    sudo tee "$REMOTE_DIR/.env" > /dev/null << EOF
NODE_ENV=development
PORT=$API_PORT
HOST=127.0.0.1
EOF
fi

echo ""
echo "=== Restarting PM2 application ==="
sudo pm2 delete "$PM2_APP_NAME" 2>/dev/null || echo "PM2 app not running, will start fresh"
sudo pm2 start "node --env-file=.env server.mjs" --name "$PM2_APP_NAME" --cwd "$REMOTE_DIR" --interpreter none
sudo pm2 save

echo ""
echo "=== Reloading nginx ==="
sudo nginx -t && sudo systemctl reload nginx

echo ""
echo "=== Cleaning up ==="
rm -f /tmp/spectest-deploy.tar.gz

echo ""
echo "Deployment complete!"
echo "Dev site: https://dev.spectest.aventoapp.com"
echo "API: http://localhost:$API_PORT/api/meta"
echo "PM2 status: pm2 status $PM2_APP_NAME"
echo "Logs: pm2 logs $PM2_APP_NAME"
echo ""
echo "Current commit deployed:"
git log --oneline -1 2>/dev/null || echo "(not a git repo)"

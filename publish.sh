#!/usr/bin/env bash
# Republish YachtFeed to GitHub Pages (Lmpry/yachtfeed, main /root). Idempotent.
set -euo pipefail
cd "$(dirname "$0")"
gh auth status >/dev/null || { echo "gh not logged in: run 'gh auth login' (user does this)"; exit 1; }
gh auth setup-git
[ -d .git ] || { git init -q -b main; git config user.name "Liam Perry"; git config user.email "345502737+Lmpry@users.noreply.github.com"; }
gh repo view Lmpry/yachtfeed >/dev/null 2>&1 || gh repo create Lmpry/yachtfeed --public
git remote get-url origin >/dev/null 2>&1 || git remote add origin https://github.com/Lmpry/yachtfeed.git
touch .nojekyll
git add -A
git diff --cached --quiet || git commit -qm "Publish YachtFeed $(date -Iseconds)"
git push -u origin main
gh api repos/Lmpry/yachtfeed/pages >/dev/null 2>&1 || gh api -X POST repos/Lmpry/yachtfeed/pages -f 'source[branch]=main' -f 'source[path]=/'
for i in $(seq 1 30); do c=$(curl -s -o /dev/null -w '%{http_code}' https://lmpry.github.io/yachtfeed/); echo "live: $c"; [ "$c" = 200 ] && exit 0; sleep 20; done

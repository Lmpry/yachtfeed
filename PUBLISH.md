# Publishing YachtFeed

Target: repo https://github.com/Lmpry/yachtfeed (public), GitHub Pages from `main` /root,
live at https://lmpry.github.io/yachtfeed/

## Republish after edits
    bash /workspace/yachtfeed/publish.sh

The script is idempotent: creates the repo/Pages only if missing, commits all changes
(images included), pushes main, then polls the live URL until HTTP 200.

## Prerequisite (one-time, by the user)
`gh` on the box must be logged in as Lmpry (`gh auth login`). The cursor-github MCP cannot
create repos, push files, or enable Pages, so it can't be used for publishing.
Never mint tokens or scrape credentials; if gh is not logged in, stop and report.

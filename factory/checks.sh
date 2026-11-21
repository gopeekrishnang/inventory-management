#!/usr/bin/env bash
# The repo's checks. Exit 0 only when the branch is fit to review.
#
# The gate runs this script from the main checkout with the job's worktree as
# the working directory. Keep it fast, deterministic and non-interactive: no
# watch modes, no prompts, nothing that rewrites files.
#
# INSTALL.md replaces the line below with this project's real commands, e.g.:
#
#   npm ci --prefer-offline
#   npm run lint
#   npm run typecheck
#   npm test -- --run
#   npm run build
set -euo pipefail

# Backend: install deps (uv) and run the pytest suite.
(cd server && uv sync --quiet)
(cd tests && uv run --project ../server pytest -q)

# Frontend: install deps and build (no lint/test tooling configured).
(cd client && npm install --no-audit --no-fund --silent && npm run build --silent)

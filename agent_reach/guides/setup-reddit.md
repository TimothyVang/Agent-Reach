# Reddit Setup Guide

## Overview

Reddit blocks almost all non-browser direct access (including data center and ISP proxy IPs), and the JSON API returns 403.

Agent Reach provides Reddit search and reading via **rdt-cli**:
- **Search**: `rdt search "keyword"`
- **Read a full post + comments**: `rdt read POST_ID`

Free, no proxy required, no API key required. It does require login authentication (`rdt login`, which automatically extracts cookies from the browser).

## Steps the Agent Can Complete Automatically

1. Check whether rdt-cli is available:
```bash
which rdt && echo "installed" || echo "not installed"
```

2. If it is not installed, install it automatically (the PyPI version is currently behind, so install the latest version from GitHub):
```bash
pipx install 'git+https://github.com/public-clis/rdt-cli.git'
```

Or install with one command:
```bash
agent-reach install --env=auto --channels=reddit
```

## Usage Examples

Search Reddit content:
```bash
rdt search "python best practices" -n 5
```

Read a full post and its comments:
```bash
rdt read POST_ID
```

## Steps the User Must Do Manually

None. rdt-cli is installed automatically by `agent-reach install --env=auto`.

## Fallback: Exa Search

If you have already configured Exa (via mcporter), you can also search Reddit content through Exa:

```bash
mcporter call 'exa.web_search_exa(query: "python best practices", numResults: 5, includeDomains: ["reddit.com"])'
```

rdt-cli is the currently recommended option and works without any extra configuration.

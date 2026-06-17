# Changelog

All notable changes to this project will be documented in this file.

All significant changes to this project are recorded in this file.

---

## [1.3.1] - 2026-03-27

### 🐛 Bug Fixes

#### 📈 Xueqiu — Comprehensive fixes

- **Fixed root cause of 400 errors:** `_ensure_cookies()` only visiting the homepage could obtain just `acw_tc` (an anti-DDoS token); `xq_a_token` is generated dynamically by Xueqiu's frontend JS and cannot be obtained through pure HTTP requests. Added a three-tier cookie loading strategy: (1) read the config file (saved by `--from-browser`) → (2) automatically extract from the local Chrome browser (requires browser-cookie3 to be installed) → (3) homepage fallback
- **Fixed User-Agent:** `"agent-reach/1.0"` was detected and rejected by Xueqiu's anti-scraping system; changed to a real Chrome UA
- **Fixed missing `Referer` header:** added `Referer: https://xueqiu.com/` to all API requests
- **Fixed `get_hot_posts()` endpoint:** the original endpoint `/statuses/hot/listV3.json` has been deprecated (returns an empty body); changed to `/v4/statuses/public_timeline_by_category.json`, correctly parsing the `item.data` JSON string to obtain author/likes/text
- **Fixed `urllib.request.quote` → `urllib.parse.quote`:** explicitly use the correct module
- **Fixed `configure --from-browser` not extracting Xueqiu cookies:** added Xueqiu to `PLATFORM_SPECS`, only saving when `xq_a_token` is detected
- **Corrected misleading documentation:** "no configuration required"/"public API, no login required" in README/SKILL.md → accurately describe that a browser cookie is required
- **Improved error messages:** on `check()` failure, prompt `configure --from-browser chrome` instead of "a proxy may be required"

---

## [1.3.0] - 2026-03-12

### 🆕 New Channels

#### 💻 V2EX
- Hot topics, node topics, topic detail + replies, user profile via public JSON API
- Zero config — no auth, no proxy, no API key required
- `get_hot_topics(limit)`, `get_node_topics(node_name, limit)`, `get_topic(id)`, `get_user(username)`
- Retrieve hot topics, node topics, topic detail + replies, and user info via the public JSON API
- Zero config; no authentication, no proxy, and no API key required

### 📈 Improvements

- Channel count: 14 → 15
- Channel count: 14 → 15

---

## [1.1.0] - 2025-02-25

### 🆕 New Channels

#### ~~📷 Instagram~~ (removed — upstream blocked)
- ~~Read public posts and profiles via [instaloader](https://github.com/instaloader/instaloader)~~
- **Removed:** Instagram's aggressive anti-scraping measures broke all available open-source tools (instaloader, etc.). See [instaloader#2585](https://github.com/instaloader/instaloader/issues/2585). Will re-add when upstream recovers.
- **Removed:** Instagram's anti-scraping crackdown broke all open-source tools (instaloader, etc.). Will be re-added once upstream recovers.

#### 💼 LinkedIn
- Read person profiles, company pages, and job details via [linkedin-scraper-mcp](https://github.com/stickerdaniel/linkedin-mcp-server)
- Search people and jobs via MCP, with Exa fallback
- Fallback to Jina Reader when MCP is not configured
- Read person profiles, company pages, and job details via linkedin-scraper-mcp
- Search people and jobs via MCP, with Exa as a fallback
- Automatically fall back to Jina Reader when MCP is not configured

#### 🏢 Boss Zhipin
- QR code login via [mcp-bosszp](https://github.com/mucsbr/mcp-bosszp)
- Job search and recruiter greeting via MCP
- Fallback to Jina Reader for reading job pages
- QR code login via mcp-bosszp
- Search jobs and greet recruiters via MCP
- Jina Reader fallback for reading job pages

### 📈 Improvements

- Channel count: 9 → 12
- `agent-reach-english doctor` now detects all 12 channels
- CLI: added `search-linkedin`, `search-bosszhipin` subcommands
- Updated install guide with setup instructions for new channels
- Channel count: 9 → 11
- `agent-reach-english doctor` now detects all 11 channels
- CLI: added `search-linkedin` and `search-bosszhipin` subcommands
- Added channel configuration instructions to the install guide

---

## [1.0.0] - 2025-02-24

### 🎉 Initial Release

- 9 channels: Web, Twitter/X, YouTube, Bilibili, GitHub, Reddit, XiaoHongShu, RSS, Exa Search
- CLI with `read`, `search`, `doctor`, `install` commands
- Unified channel interface — each platform is a single pluggable Python file
- Auto-detection of local vs server environments
- Built-in diagnostics via `agent-reach-english doctor`
- Skill registration for Claude Code / OpenClaw / Cursor
- 9 channels: Web, Twitter/X, YouTube, Bilibili, GitHub, Reddit, XiaoHongShu, RSS, Exa Search
- CLI supports the `read`, `search`, `doctor`, and `install` commands
- Unified channel interface — each platform is a standalone, pluggable Python file
- Automatic detection of local vs server environments
- Built-in diagnostics via `agent-reach-english doctor`
- Skill registration support for Claude Code / OpenClaw / Cursor

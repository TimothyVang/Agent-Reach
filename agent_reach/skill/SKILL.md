---
name: agent-reach
description: >
  MUST USE when user wants to research/search/look up/find anything
  on the internet — e.g. "research X across the web" / "help me research X" /
  "look up X" / "search for X" / "see what people think of X" /
  "what discussions are there about X" / research this topic.

  Also MUST USE when user mentions any platform or shares any URL/link:
  XiaoHongShu/xiaohongshu/xhs, Twitter/X, Bilibili, Reddit, V2EX,
  LinkedIn/jobs/recruiting, YouTube, GitHub code search, Xiaoyuzhou Podcast,
  Xueqiu/stock quotes, RSS feeds, or any web URL.

  13 platforms, multi-backend routing (OpenCLI / per-platform CLIs / APIs).
  Zero config for 6 channels. Run `agent-reach doctor --json` to see which
  backend serves each platform right now.

  NOT for: writing reports / data analysis / translation and other content
  processing (this skill only FETCHES content from the internet); posting /
  commenting / liking and other write operations; platforms that already have
  a dedicated skill (use the dedicated skill first).

  [Routing] SKILL.md contains the routing table and common commands; for
  complex scenarios, read the matching category's references/*.md as needed.
  Categories: search / social (XiaoHongShu/Twitter/Bilibili/V2EX/Reddit) /
  career (LinkedIn) / dev (github) / web (web pages/articles/RSS) /
  video (YouTube/Bilibili/podcasts).
triggers:
  - research: research / research across the web / help me research / look into / research / dig deeper
  - search: search / look up / find / search / search for / look it up / search for me / see what people say
  - social:
    - XiaoHongShu: xiaohongshu/xhs/XiaoHongShu/Red
    - Twitter: twitter/Twitter/x.com/tweet
    - Bilibili: bilibili/Bilibili
    - V2EX: v2ex
    - Reddit: reddit
  - career: recruiting/job/job-hunting/linkedin/LinkedIn/looking for work
  - dev: github/code/repository/gh/issue/pr/branch/commit
  - web: web page/link/article/rss/read this/open this
  - video: youtube/video/podcast/subtitles/Xiaoyuzhou/transcript/yt
  - finance: Xueqiu/stock/stock/xueqiu/quotes/fund
metadata:
  openclaw:
    homepage: https://github.com/TimothyVang/Agent-Reach
---

# Agent Reach — Internet Capability Router

13 platforms, multiple backends. **When this skill exists, you must use it to access these platforms — do not invent your own approach.**

## Standing Rules (apply for the whole session)

1. **Health-check before acting**: for multi-backend platforms (XiaoHongShu/Reddit/Bilibili/Twitter), run
   `agent-reach doctor --json` first and pick the command group matching each platform's `active_backend` field.
2. **Announce what you use**: before starting, say "using agent-reach, platform X / backend Y".
3. **On failure, follow the retry chains in references/** — never guess commands.
4. **Broad research tasks**: combine multiple platforms (Exa search + Twitter/Reddit for discussions + XiaoHongShu/Bilibili for Chinese-language context), collect in parallel, then synthesize.
5. **Watch versions for the user**: after finishing a larger research / multi-platform task, run
   `agent-reach check-update` (fast, one API call). If a new version exists, append one line to your wrap-up:
   "Agent Reach vX.Y.Z is available — just paste this to me to update: help me update Agent Reach:
   https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/update.md".
   Do not interrupt the current task to update, and do not repeat the reminder for the same version.

## Routing Table

| User intent | Category | Details |
|---------|------|---------|
| Web search / code search | search | [references/search.md](references/search.md) |
| XiaoHongShu / Twitter / Bilibili / V2EX / Reddit | social | [references/social.md](references/social.md) |
| Recruiting / jobs / LinkedIn | career | [references/career.md](references/career.md) |
| GitHub / code | dev | [references/dev.md](references/dev.md) |
| Web pages / articles / RSS | web | [references/web.md](references/web.md) |
| YouTube / Bilibili / podcast subtitles | video | [references/video.md](references/video.md) |

## Zero-Config Quick Commands

```bash
# Exa web search
mcporter call 'exa.web_search_exa(query: "query", numResults: 5)'

# Read any web page
curl -s "https://r.jina.ai/URL"

# GitHub search
gh search repos "query" --sort stars --limit 10

# YouTube subtitles (NOTE: never use yt-dlp for Bilibili — see video.md)
yt-dlp --write-sub --skip-download -o "/tmp/%(id)s" "URL"

# V2EX hot topics
curl -s "https://www.v2ex.com/api/topics/hot.json" -H "User-Agent: agent-reach/1.0"

# Bilibili search (bili-cli, no login needed)
bili search "query" --type video -n 5
```

## Login-Backed Platforms (pick the command group by doctor's active_backend)

```bash
# Twitter search (twitter-cli preferred; retry chain in social.md)
twitter search "query" -n 10

# Reddit (no zero-config path: OpenCLI or rdt-cli, login session required)
opencli reddit search "query" -f yaml   # desktop
rdt search "query" --limit 10            # legacy/server

# XiaoHongShu (desktop prefers OpenCLI)
opencli xiaohongshu search "query" -f yaml
```

## Environment Check

```bash
# Check available channels and the currently active backend for each platform
agent-reach doctor --json
```

## Workspace Rules

**Do not create files in the agent workspace.** Use `/tmp/` for temporary output and `~/.agent-reach/` for persistent data.

## Detailed References

Based on the user's needs, read the matching reference doc:

- [Search Tools](references/search.md) — Exa AI search
- [Social Media](references/social.md) — XiaoHongShu, Twitter, Bilibili, V2EX, Reddit (multi-backend command groups)
- [Jobs & Recruiting](references/career.md) — LinkedIn
- [Development Tools](references/dev.md) — GitHub CLI
- [Web Reading](references/web.md) — Jina Reader, RSS
- [Video & Podcasts](references/video.md) — YouTube, Bilibili, Xiaoyuzhou

## Configure a Channel

If a channel needs configuration, fetch the install guide:
https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md

The user only needs to provide cookies; the agent handles the rest of the configuration.

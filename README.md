<h1 align="center">👁️ Agent Reach</h1>

<p align="center">
  <strong>Give your AI Agent one-click access to the entire internet</strong>
</p>

<p align="center">
  The most reliable access path for each platform — chosen, installed, and health-checked for you. Backends come and go; you won't have to worry about it.
</p>

<p align="center">
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge" alt="MIT License"></a>
  <a href="https://www.python.org/"><img src="https://img.shields.io/badge/Python-3.10+-green.svg?style=for-the-badge&logo=python&logoColor=white" alt="Python 3.10+"></a>
  <a href="https://github.com/TimothyVang/Agent-Reach/stargazers"><img src="https://img.shields.io/github/stars/TimothyVang/Agent-Reach?style=for-the-badge" alt="GitHub Stars"></a>
  <a href="https://trendshift.io/repositories/24387"><img src="https://trendshift.io/api/badge/repositories/24387" alt="Trendshift GitHub Trending #1 Repository of the Day"></a>
</p>

<p align="center">
  <a href="#quick-start">Quick Start</a> · <a href="#supported-platforms">Platforms</a> · <a href="#design-philosophy">Philosophy</a>
</p>

---

## Why Agent Reach?

AI Agents can already help you write code, edit docs, and manage projects — but ask one to find something on the internet and it draws a blank:

- 📺 "Tell me what this YouTube tutorial covers" → **Can't** — no access to subtitles
- 🐦 "Search Twitter to see how people rate this product" → **Can't search** — the Twitter API is paid
- 📖 "Check Reddit for anyone who's hit the same bug" → **403 blocked** — the server IP is refused
- 📕 "Check the reviews for this product on XiaoHongShu" → **Won't load** — login required to view
- 📺 "There's a technical video on Bilibili, summarize it for me" → **Can't get it** — generic downloaders are fully blocked by Bilibili's risk control
- 🔍 "Search the web for the latest LLM framework comparison" → **No good search** — either paid or low quality
- 🌐 "Tell me what this web page says" → **Comes back as a pile of HTML tags** — unreadable
- 📦 "What is this GitHub repo for? What do the Issues say?" → Works, but the auth setup is a hassle
- 📡 "Subscribe to these RSS feeds and tell me when there are updates" → You have to install libraries and write code yourself

**None of this is hard to do — but you have to wrangle the setup yourself.**

Every platform has its own barriers: paid APIs, blocks to bypass, accounts to log into, data to clean up. You have to hit every pitfall one by one, install the tools, and tune the configs — just getting your Agent to read a single tweet can take half a day.

**Agent Reach turns this into one sentence:**

```
Install Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md
```

Copy that to your Agent, and a few minutes later it can read tweets, search Reddit, watch YouTube, and browse XiaoHongShu.

**Already installed? Updating is also one sentence:**

```
Update Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/update.md
```

> ⭐ **Star this project** and we'll keep tracking changes across platforms and adding new channels. You don't have to watch it yourself — when a platform blocks us we fix it, and when there's a new channel we add it.

### ✅ Before you use it, you might want to know

| | |
|---|---|
| 💰 **Completely free** | All tools are open source, all APIs are free. The only possible cost is a server proxy ($1/month) — local computers don't need one |
| 🔒 **Privacy safe** | Cookies stay local — never uploaded, never shared. The code is fully open source and can be audited anytime |
| 🔄 **Kept up to date** | Every platform routes through a primary + fallback multi-backend list. When an access path dies, we switch to the next one and you don't notice (June 2026 example: yt-dlp was blocked by Bilibili's risk control → switched to bili-cli, zero action on the user's side) |
| 🤖 **Works with any Agent** | Claude Code, OpenClaw, Cursor, Windsurf… any Agent that can run command-line commands |
| 🩺 **Built-in diagnostics** | `agent-reach doctor` — one command tells you what works, what doesn't, and how to fix it |

---

## Supported Platforms

| Platform | Works out of the box | Unlocked after setup | How to set up |
|------|---------|-----------|-------|
| 🌐 **Web** | Read any web page | — | No configuration needed |
| 📺 **YouTube** | Subtitle extraction + video search | — | No configuration needed |
| 📡 **RSS** | Read any RSS/Atom feed | — | No configuration needed |
| 🔍 **Web Search** | — | Web-wide semantic search | Auto-configured (MCP integration, free, no key needed) |
| 📦 **GitHub** | Read public repos + search | Private repos, open Issues/PRs, Fork | Tell your Agent "help me log into GitHub" |
| 🐦 **Twitter/X** | Read single tweets | Search tweets, browse timeline, read articles | Tell your Agent "help me set up Twitter" |
| 📺 **Bilibili** | Search + video detail (bili-cli, no login needed) | Subtitles (OpenCLI) | Tell your Agent "help me set up Bilibili" |
| 📖 **Reddit** | — (no zero-config path: anonymous endpoints are blocked) | Search + read posts and comments | Desktop: install OpenCLI and use the browser session; or rdt-cli + cookie |
| 📕 **XiaoHongShu** | — | Search, read, comment | Desktop: install OpenCLI (works once you've browsed XiaoHongShu); server: xiaohongshu-mcp with QR login |
| 💼 **LinkedIn** | Jina Reader reads public pages | Profile details, company pages, job search | Tell your Agent "help me set up LinkedIn" |
| 💻 **V2EX** | Hot topics, node topics, topic detail + replies, user info | — | No configuration needed |
| 📈 **Xueqiu** | Stock quotes, search stocks, hot posts, hot-stock rankings | — | Tell your Agent "help me set up Xueqiu" |
| 🎙️ **Xiaoyuzhou Podcast** | — | Podcast audio → text (Whisper transcription, free key) | Tell your Agent "help me set up Xiaoyuzhou Podcast" |

> **Not sure how to configure it? No need to read the docs.** Just tell your Agent "help me set up XXX" — it knows what's needed and will walk you through it step by step.
>
> 🍪 For platforms that need cookies (Twitter, XiaoHongShu, etc.), **prefer** the Chrome extension [Cookie-Editor](https://chromewebstore.google.com/detail/cookie-editor/hlkenndednhfkekhgcdicdfddnkalmdm) to export your cookies, then send them to the Agent to configure. The flow is the same everywhere: log in via your browser → export with Cookie-Editor → send to the Agent. Simpler and more reliable than QR scanning.
>
> 🔒 Cookies stay local — never uploaded, never shared. The code is fully open source and can be audited anytime.
> 💻 Local computers don't need a proxy. A proxy is only needed when deploying on a server (~$1/month).

---

## Quick Start

> ⚠️ **OpenClaw users: confirm `exec` permission is enabled first**
>
> Agent Reach relies on the Agent running shell commands (`pip install`, `mcporter`, `twitter`, etc.). If your OpenClaw uses the default `messaging` tool profile, the Agent won't be able to run commands. **Enable `exec` permission before installing:**
>
> ```bash
> openclaw config set tools.profile "coding"
> ```
> Or set `"tools": { "profile": "coding" }` in `~/.openclaw/openclaw.json`. After changing it, restart the Gateway (`openclaw gateway restart`) and start a new conversation. Other platforms (Claude Code, Cursor, Windsurf, etc.) are not affected.

Copy this sentence to your AI Agent (Claude Code, OpenClaw, Cursor, etc.):

```
Install Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md
```

That's the only step. The Agent takes care of everything else on its own.

> 🔄 **Already installed?** Updating is also one sentence:
> ```
> Update Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/update.md
> ```

> 🛡️ **Worried about security?** You can use safe mode — it won't auto-install system packages, it only tells you what you need:
> ```
> Install Agent Reach (safe mode): https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md
> Use the --safe flag during install
> ```

<details>
<summary>What does it do? (click to expand)</summary>

1. **Installs the CLI tool** — `pip install` sets up the `agent-reach` command line (bundles yt-dlp and feedparser)
2. **Installs system infrastructure** — automatically detects and installs Node.js, the gh CLI, and mcporter
3. **Configures the search engine** — connects Exa via MCP (free, no API key needed)
4. **Detects the environment** — determines whether you're on a local computer or a server, and gives matching configuration advice
5. **Registers SKILL.md** — installs the usage guide in the Agent's skills directory, so that later, whenever the Agent hits a request like "research the web," "search Twitter," or "watch a video," it automatically knows which upstream tool to call
6. **Asks whether you want more** — by default it only activates the 6 zero-config channels; for login-required ones like XiaoHongShu, Twitter, and Reddit, the Agent presents a menu and asks which you want, installing only the ones you name

After installation, `agent-reach doctor` — one command — tells you the status of each channel and which path it's currently taking.
</details>

---

## Works Out of the Box

No configuration needed — just tell your Agent:

- "Take a look at this link" → `curl https://r.jina.ai/URL` reads any web page
- "What is this GitHub repo for?" → `gh repo view owner/repo`
- "What does this YouTube video cover?" → `yt-dlp` extracts subtitles
- "Search Bilibili for an AI tutorial" → `bili search` (no login needed)
- "Search the web for an LLM framework comparison" → Exa semantic search
- "Subscribe to this RSS feed" → `feedparser` parses it

**No commands to remember.** After reading SKILL.md, the Agent knows what to call on its own. For login-required platforms (XiaoHongShu, Twitter, Reddit), just tell the Agent "help me set up XXX" to unlock them.

---

## Capability Boundary: Reading Content vs Operating Web Pages

Some tasks go beyond "reading": operating logged-in web pages, submitting forms, isolating multiple accounts, running parallel browser sessions, or handing off high-friction steps in automation flows such as login, verification, and risk-control prompts. For these "hands-on" scenarios, Agent Reach can be paired with browser automation tools like [BrowserAct](https://www.browseract.ai/Agent) — 30+ prebuilt platform skills, supporting mainstream Agents such as Claude Code, OpenClaw, and Cursor.

---

## Design Philosophy

**Agent Reach is a capability layer, not yet another tool.**

It sits one level above any specific implementation — it handles **selection, installation, health checks, and routing**, not the low-level reading itself. Reading is done by your Agent calling upstream tools directly; there is no wrapper layer.

Every time you set up the environment for a new Agent, you spend time finding tools, installing dependencies, and tuning configs — what reads Twitter? How do you log into Reddit? What replaces a discontinued XiaoHongShu CLI? Every time, you re-do the same legwork. Agent Reach does one simple thing: **the most reliable access path for each platform — chosen, installed, and health-checked for you. Access paths come and go (in March 2026 a batch of single-platform CLIs went unmaintained at once, so we re-routed), so you don't have to worry about it.**

### 🔌 Every platform = an ordered backend list (primary + fallbacks)

Switching access paths means reordering the list, not rewriting code. `agent-reach doctor` tells you **which backend each platform is currently using**.

```
channels/
├── web.py          → Jina Reader
├── twitter.py      → twitter-cli ▸ OpenCLI ▸ bird
├── youtube.py      → yt-dlp
├── github.py       → gh CLI
├── bilibili.py     → bili-cli ▸ OpenCLI ▸ search API (yt-dlp blocked by Bilibili's risk control, retired)
├── reddit.py       → OpenCLI ▸ rdt-cli (no zero-config path, login required)
├── xiaohongshu.py  → OpenCLI ▸ xiaohongshu-mcp ▸ xhs-cli
├── linkedin.py     → linkedin-mcp ▸ Jina Reader
├── rss.py          → feedparser
├── exa_search.py   → Exa via mcporter
└── __init__.py     → Channel registry (for doctor checks)
```

Each channel file **actually probes** its candidate backends in order (not just checking whether a command exists) — the first fully working one becomes the active backend, and broken ones come with a fix prescription. The actual reading and searching is done by the Agent calling the upstream tools directly.

### Current Tool Choices

| Scenario | Primary | Fallback | Why this choice |
|------|------|------|-----------|
| Read web pages | [Jina Reader](https://github.com/jina-ai/reader) | — | Free, no API key needed |
| Read tweets | [twitter-cli](https://github.com/public-clis/twitter-cli) | [OpenCLI](https://github.com/jackwener/opencli) | Reliable search in real-world tests; OpenCLI falls back on your browser session |
| Reddit | [OpenCLI](https://github.com/jackwener/opencli) (desktop) | [rdt-cli](https://github.com/public-clis/rdt-cli) | Anonymous endpoints blocked, official API approval-gated — logged-in sessions are the only route left |
| YouTube subtitles + search | [yt-dlp](https://github.com/yt-dlp/yt-dlp) | — | 154K stars, still the best for YouTube (note: no longer used for Bilibili) |
| Bilibili | [bili-cli](https://github.com/public-clis/bilibili-cli) | OpenCLI ▸ search API | yt-dlp is 412-blocked by Bilibili's risk control (verified June 2026); bili-cli searches and reads without login |
| Search the web | [Exa](https://exa.ai) via [mcporter](https://github.com/nicobailon/mcporter) | — | AI semantic search, MCP integration, no key needed |
| GitHub | [gh CLI](https://cli.github.com) | — | Official tool, full API capabilities after auth |
| Read RSS | [feedparser](https://github.com/kurtmckee/feedparser) | — | The standard choice in the Python ecosystem |
| XiaoHongShu | [OpenCLI](https://github.com/jackwener/opencli) (desktop) | [xiaohongshu-mcp](https://github.com/xpzouying/xiaohongshu-mcp) (server) ▸ xhs-cli | The xhs-cli author moved to OpenCLI (24K stars); browser sessions mean zero friction |
| LinkedIn | [linkedin-scraper-mcp](https://github.com/stickerdaniel/linkedin-mcp-server) | Jina Reader | MCP service, browser automation |

> 📌 These are the *current* choices, re-verified regularly on real machines. When a path dies we switch to the next — `agent-reach doctor` always tells you which one is active right now.

---

## Security

Agent Reach takes security seriously by design:

| Measure | Description |
|------|------|
| 🔒 **Credentials stored locally** | Cookies and tokens are stored only on your machine at `~/.agent-reach/config.yaml`, with file permissions 600 (owner read/write only); never uploaded, never shared |
| 🛡️ **Safe mode** | `agent-reach install --safe` won't modify your system automatically — it only lists what's needed and leaves the decision to install up to you |
| 👀 **Fully open source** | The code is transparent and can be audited anytime. Every dependency tool is also an open-source project |
| 🔍 **Dry run** | `agent-reach install --dry-run` previews all operations without making any changes |
| 🧩 **Pluggable architecture** | Don't trust a particular component? Just swap out the corresponding channel file — it won't affect the others |

### 🍪 Cookie security recommendations

> ⚠️ **Account-ban risk warning:** For platforms you log into with cookies (Twitter, XiaoHongShu, etc.), calling them via scripts/APIs **carries a risk of being detected and banned by the platform**. Always use a **dedicated secondary account**, not your main account.

For platforms that need cookies (Twitter, XiaoHongShu), we recommend using a **dedicated secondary account** rather than your main account, for two reasons:
1. **Ban risk** — the platform may detect API calls that don't come from a normal browser, leading to the account being restricted or banned
2. **Security risk** — a cookie is equivalent to full login privileges; using a secondary account limits the blast radius if the credentials leak

### 📦 Installation methods

| Method | Command | Best for |
|------|------|---------|
| One-click fully automatic (default) | `agent-reach install --env=auto` | Personal computers, development environments |
| Safe mode | `agent-reach install --env=auto --safe` | Production servers, shared machines |
| Preview only | `agent-reach install --env=auto --dry-run` | Seeing what it would do first |

### 🗑️ Uninstall

```bash
agent-reach uninstall
```

This removes: `~/.agent-reach/` (including all tokens/cookies), each Agent's skill file, and the MCP configuration in mcporter.

```bash
# Preview only, don't actually delete
agent-reach uninstall --dry-run

# Remove only the skill files, keep the token config (for reinstalling)
agent-reach uninstall --keep-config
```

To uninstall the Python package itself: `pip uninstall agent-reach`

---

## Contributing

This project was entirely vibe-coded 🎸 There might be some rough edges here and there, so please bear with me if you run into problems. If you hit a bug, don't hesitate to open an [Issue](https://github.com/TimothyVang/Agent-Reach/issues) — I'll fix it as soon as I can.

**Want a new channel?** Open an Issue to tell us, or submit a PR yourself.

**Want to add one locally?** Just have your Agent clone the repo and modify it — each channel is a single standalone file, so adding one is simple.

[PRs](https://github.com/TimothyVang/Agent-Reach/pulls) are always welcome!

---

## ⭐ Why It's Worth a Star

I use this project myself every day, so I'll keep maintaining it.

- As new needs come up, or people request channels they want, I'll add them over time
- For every channel, I'll do my best to keep it **working, usable, and free**
- When a platform changes its anti-scraping measures or its API shifts, I'll find a way to solve it

A small contribution to the Web 4.0 infrastructure.

Give it a Star so you can find it next time you need it. ⭐

---

## FAQ

<details>
<summary><strong>How does an AI Agent search Twitter / X? I don't want to pay API fees</strong></summary>

Agent Reach uses [twitter-cli](https://github.com/public-clis/twitter-cli) to access Twitter via cookie authentication — completely free. Install with `pipx install twitter-cli`, make sure your browser is logged into x.com, and the Agent can then search with `twitter search "query"` and read tweets with `twitter tweet URL`.
</details>

<details>
<summary><strong>How to search Twitter/X with AI agent for free (no API)?</strong></summary>

Agent Reach uses twitter-cli with cookie auth — zero API fees. Install with `pipx install twitter-cli`, make sure you're logged into x.com in your browser, then your agent can search with `twitter search "query"` and read tweets with `twitter tweet URL`.
</details>

<details>
<summary><strong>What do I do when Reddit returns 403?</strong></summary>

All Reddit access requires a logged-in session (anonymous endpoints are fully blocked, and the official API requires manual approval). On desktop, the preferred option is **OpenCLI**: if you've logged into reddit.com in your browser, you can run `opencli reddit search "query"` directly. The fallback is [rdt-cli](https://github.com/public-clis/rdt-cli): `pipx install 'git+https://github.com/public-clis/rdt-cli.git@5e4fb3720d5c174e976cd425ccc3b879d52cac66'` (the same pinned version as the code; PyPI lags behind), then `rdt login`. Accessing Reddit from a mainland China network requires a proxy.
</details>

<details>
<summary><strong>How to get YouTube video transcripts for AI?</strong></summary>

`yt-dlp --dump-json "https://youtube.com/watch?v=xxx"` extracts video metadata; `yt-dlp --write-sub --skip-download "URL"` extracts subtitles. Uses yt-dlp under the hood, supports multiple languages. No API key needed.
</details>

<details>
<summary><strong>How do I get an AI Agent to read XiaoHongShu?</strong></summary>

On a desktop computer, prefer **OpenCLI** (`agent-reach install --channels opencli`) — it reuses the logged-in session in your browser, so if you've browsed XiaoHongShu it just works, zero config; after installing, click "Add extension" once in the Chrome Web Store. Then the Agent can search with `opencli xiaohongshu search "query"` and read notes with `opencli xiaohongshu note URL`. On a server, use [xiaohongshu-mcp](https://github.com/xpzouying/xiaohongshu-mcp) (bundled headless browser, QR login). Existing xhs-cli users are unaffected — it's still a fallback backend (upstream unmaintained since 2026-03, not recommended for new installs).
</details>

<details>
<summary><strong>Compatible with Claude Code / Cursor / OpenClaw / Windsurf?</strong></summary>

Yes! Agent Reach is an installer + configuration tool — any AI coding agent that can run shell commands can use it. Works with Claude Code, Cursor, OpenClaw, Windsurf, Codex, and more. Just `pip install agent-reach`, run `agent-reach install`, and the agent can start using the upstream tools immediately.

**OpenClaw note:** If your OpenClaw is using the default `messaging` tool profile, the agent won't be able to run shell commands. Enable exec first: `openclaw config set tools.profile "coding"` (or set `"tools": { "profile": "coding" }` in `~/.openclaw/openclaw.json`), then restart the Gateway and start a new conversation before installing.
</details>

<details>
<summary><strong>Is this free? Any API costs?</strong></summary>

100% free. All backends are open-source tools (OpenCLI, twitter-cli, bili-cli, rdt-cli, yt-dlp, Jina Reader, Exa, xiaohongshu-mcp, etc.) that don't require paid API keys. The only optional cost is a residential proxy (~$1/month) if your network blocks Reddit/Twitter (e.g. mainland China).
</details>

---

## Credits

[OpenCLI](https://github.com/jackwener/opencli) · [twitter-cli](https://github.com/public-clis/twitter-cli) · [rdt-cli](https://github.com/public-clis/rdt-cli) · [xiaohongshu-mcp](https://github.com/xpzouying/xiaohongshu-mcp) · [xhs-cli](https://github.com/jackwener/xiaohongshu-cli) · [bili-cli](https://github.com/public-clis/bilibili-cli) · [yt-dlp](https://github.com/yt-dlp/yt-dlp) · [Jina Reader](https://github.com/jina-ai/reader) · [Exa](https://exa.ai) · [mcporter](https://github.com/nicobailon/mcporter) · [feedparser](https://github.com/kurtmckee/feedparser) · [linkedin-scraper-mcp](https://github.com/stickerdaniel/linkedin-mcp-server)

## Contact

- 📧 **Email:** pnt01@foxmail.com
- 🐦 **Twitter/X:** [@Neo_Reidlab](https://x.com/Neo_Reidlab)

To chat or collaborate, add me on WeChat and I'll invite you to the community group:

<p align="center">
  <img src="docs/wechat-group-qr.jpg" width="280" alt="WeChat QR">
</p>

> For bug reports and feature requests, please use [GitHub Issues](https://github.com/TimothyVang/Agent-Reach/issues) — easier to track.

## License

[MIT](LICENSE)

## Friends

[OpenClaw on Tencent Cloud](https://www.tencentcloud.com/act/pro/intl-openclaw?referral_code=G76Y819A&lang=zh&pg=) — Deploy the all-in-one OpenClaw assistant on Tencent Cloud Lighthouse in seconds, connect Agent Reach seamlessly through conversation, and give your OpenClaw one-click access to the internet.

[AtomGit mirror](https://atomgit.com/qq_51337814/Agent-Reach) — A synchronized AtomGit mirror of Agent Reach for easier access and cloning within China.

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=TimothyVang/Agent-Reach&type=Date&v=20260309)](https://star-history.com/#TimothyVang/Agent-Reach&Date)

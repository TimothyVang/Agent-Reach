# Agent Reach — Installation Guide

## For Humans

Copy this to your AI Agent:

```
Help me install Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md
```

> 🛡️ **Security-conscious?** Use safe mode — it won't auto-install system packages:
> ```
> Help me install Agent Reach (safe mode): https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/install.md
> Use the --safe flag during installation
> ```

---

## For AI Agents

### Goal

Install Agent Reach and all upstream tools so your user's agent has full internet access. After installation, you'll use the upstream tools directly (OpenCLI, twitter-cli, bili-cli, rdt-cli, yt-dlp, mcporter, gh CLI, etc.) — Agent Reach is the selector, installer, health checker and router, never a wrapper.

### ⚠️ Boundaries

When fixing issues, stay within these limits:

- **DO NOT** run commands with `sudo` unless the user explicitly approved
- **DO NOT** modify system files outside `~/.agent-reach/`
- **DO NOT** install packages not listed in this guide
- **DO NOT** disable firewalls, security settings, or system protections
- **DO NOT** clone repos, create files, or run commands inside the agent workspace / working directory
- If something requires elevated permissions, **tell the user** what's needed and let them decide

### 📁 Directory Rules

All Agent Reach files go in dedicated directories — **never in the agent workspace**:

| Purpose | Directory | Example |
|---------|-----------|---------|
| Config & tokens | `~/.agent-reach/` | `~/.agent-reach/config.json` |
| Upstream tool repos | `~/.agent-reach/tools/` | `~/.agent-reach/tools/xiaoyuzhou/` |
| Temporary files | `/tmp/` | `/tmp/yt-dlp-output/` |
| Skills | `~/.openclaw/skills/agent-reach/` | SKILL.md |

**Why?** If you clone repos or create files in the workspace, it pollutes the user's project directory and can break their agent over time. Keep the workspace clean.

### Step 1: Install the basics

```bash
# Recommended: pipx (the easiest option)
pipx install https://github.com/TimothyVang/Agent-Reach/archive/refs/tags/v1.5.0.zip
agent-reach install --env=auto

# If your Python comes from Homebrew, or you hit PEP 668 (externally-managed-environment),
# install inside a virtual environment:
python3 -m venv ~/.agent-reach-venv
source ~/.agent-reach-venv/bin/activate
pip install https://github.com/TimothyVang/Agent-Reach/archive/refs/tags/v1.5.0.zip
agent-reach install --env=auto
```

> 💡 **Windows / Microsoft Store Python alias?**
> If `python3 --version` opens the Microsoft Store, or `where python3` points to
> `...\AppData\Local\Microsoft\WindowsApps\python3.exe`, then `python3` is the Windows
> Store alias, not a usable Python installation. Use the Python Launcher `py -3` instead,
> or the `python.exe` from your actual installation directory.
>
> PowerShell example:
> ```powershell
> py -3 -m venv $env:USERPROFILE\.agent-reach-venv
> $env:USERPROFILE\.agent-reach-venv\Scripts\Activate.ps1
> python -m pip install https://github.com/TimothyVang/Agent-Reach/archive/refs/tags/v1.5.0.zip
> agent-reach install --env=auto
> ```

This installs core infrastructure (gh CLI, Node.js, mcporter, Exa search, yt-dlp config) and activates these zero-config channels:

- Web (Jina Reader), YouTube, GitHub, RSS, Exa Search, V2EX, Bilibili (basic)

> 💡 **macOS / Homebrew Python reports `externally-managed-environment`?**
> This is PEP 668 protection, not a problem with Agent Reach itself. Prefer `pipx install ...`, or create a `venv` first and then install.

**Safe mode / Dry run:**

```bash
agent-reach install --env=auto --safe      # Check only, no auto-install
agent-reach install --env=auto --dry-run   # Preview what would be done
```

### Step 2: Ask the user which optional channels they want

After installing the basics, **ask the user** which additional channels they need. Present this list:

> The core channels are installed! You can now ask me to search the web, watch YouTube, read GitHub, and more.
>
> There are also these optional channels — which ones do you need?
>
> - 🌟 **OpenCLI** (recommended for desktop) — install once and unlock XiaoHongShu / Reddit / Bilibili subtitles / Twitter fallback all at once (reuses your browser login session, zero config; you only need to click "Add extension" once in the Chrome Web Store)
> - 🐦 **Twitter/X** — search tweets, view timelines (requires login cookies)
> - 📈 **Xueqiu** — stock quotes, trending posts (requires login cookies)
> - 🎙️ **Xiaoyuzhou Podcast** — audio transcription (requires a free Groq key)
> - 📕 **XiaoHongShu** — search, read, comment (desktop uses OpenCLI; servers use xiaohongshu-mcp with QR scan)
> - 📖 **Reddit** — search and read posts (login session required: desktop OpenCLI or rdt-cli + cookies)
> - 📺 **Bilibili (full version)** — trending, rankings, search, video details (bili-cli, no login required)
> - 💼 **LinkedIn** — profiles, job search
>
> Tell me which ones you want, for example "Help me install XiaoHongShu and Twitter". Or say "install everything".

Based on the user's choice, run:

```bash
agent-reach install --env=auto --channels=opencli,xiaohongshu   # Example: desktop user chose XHS (OpenCLI-backed)
agent-reach install --env=auto --channels=all              # User wants everything
```

Supported channel names: `opencli`, `twitter`, `xiaoyuzhou`, `xueqiu`, `xiaohongshu`, `reddit`, `bilibili`, `linkedin`, `all`

### Step 3: Fix what's broken

Run `agent-reach doctor` and check the output.

Try to get as many channels to ✅ as possible. If something failed during install or shows as ❌/⚠️ in doctor, diagnose the problem and try to fix it — but stay within the boundaries above. If a fix requires elevated permissions or system changes, ask the user first.

Only ask the user when you genuinely need their input (credentials, permissions, etc.).

### Step 3: Configure things that need user input

Some channels need credentials only the user can provide. Based on the doctor output, ask for what's missing:

> 🔒 **Security tip:** For platforms that need cookies (Twitter, XiaoHongShu), we recommend using a **dedicated/secondary account** rather than your main account. Cookie-based auth carries two risks:
> 1. **Account ban** — platforms may detect non-browser API calls and restrict or ban the account
> 2. **Credential exposure** — cookies grant full account access; using a secondary account limits the blast radius if credentials are ever compromised

> 🍪 **Cookie import (applies to all platforms that require login):**
>
> For every platform that needs cookies (Twitter, XiaoHongShu, Xueqiu, etc.), **prefer importing with Cookie-Editor** — it is the simplest and most reliable method:
> 1. Have the user log into the platform in their own browser
> 2. Install the [Cookie-Editor](https://chromewebstore.google.com/detail/cookie-editor/hlkenndednhfkekhgcdicdfddnkalmdm) Chrome extension
> 3. Click the extension → Export → Header String
> 4. Send the exported string to the agent
>
> **Local desktop users** can also use `agent-reach configure --from-browser chrome` to extract everything automatically in one step (supports Twitter + XiaoHongShu + Xueqiu).

**Twitter search & posting:**
> "To unlock Twitter search, I need your Twitter cookies. Install the Cookie-Editor Chrome extension, go to x.com/twitter.com, click the extension → Export → Header String, and paste it to me."

```bash
agent-reach configure twitter-cookies "PASTED_STRING"
```

> **Proxy notes (for networks that require a proxy, such as mainland China):**
>
> twitter-cli and rdt-cli use Python, and in networks that require a proxy you can configure one via environment variables.
>
> **What you (the agent) need to do:**
> 1. Confirm the user has configured a proxy: `agent-reach configure proxy http://user:pass@ip:port`
> 2. Set the environment variables: `export HTTP_PROXY="..." HTTPS_PROXY="..."`
> 3. Agent Reach handles the rest automatically — the user does not need to do anything extra
>
> If the user reports "fetch failed", see [troubleshooting.md](troubleshooting.md)

**Reddit (login is mandatory — no zero-config path):**
> Reddit's anonymous endpoints have been blocked, and the official API requires manual approval. Desktop users should prefer OpenCLI (works as long as you've logged into reddit.com in your browser); server and existing users should use rdt-cli:

```bash
# PyPI lags behind — install from GitHub (the same pinned version as _RDT_GIT_SOURCE in the code)
pipx install 'git+https://github.com/public-clis/rdt-cli.git@5e4fb3720d5c174e976cd425ccc3b879d52cac66'
rdt login   # Automatically extracts browser cookies; on a server with no browser, write the cookies manually following the doctor prompt
```

> Accessing Reddit from mainland China requires a proxy; if the server IP is rate-limited, you can configure a residential proxy (such as https://webshare.io, about $1/month):
> ```bash
> agent-reach configure proxy http://user:pass@ip:port
> ```

**XiaoHongShu (multiple backends — choose by environment):**

> **Desktop computer (OpenCLI recommended):**
> "XiaoHongShu runs through OpenCLI — it reuses the login session in your browser, so if you've browsed XiaoHongShu before it just works, zero config."

```bash
agent-reach install --channels opencli
```

> After installation, guide the user through the one manual step you can't do for them (a Chrome security restriction):
> 1. Open https://chromewebstore.google.com/detail/opencli/ildkmabpimmkaediidaifkhjpohdnifk
> 2. Click "Add to Chrome"
> 3. Run `opencli doctor` to verify (success when it shows Extension: connected)
>
> **Server / headless environment (xiaohongshu-mcp):**
> 1. Download the binary for your platform from https://github.com/xpzouying/xiaohongshu-mcp/releases into `~/.agent-reach/tools/`
> 2. Start the service (the first run automatically downloads a headless browser of about 150MB — be patient and wait for it to finish)
> 3. Have the user scan the QR code to log in (the agent calls the `get_login_qrcode` tool to get the QR code)
> 4. Connect it: `mcporter config add xiaohongshu http://localhost:18060/mcp`
> 5. Always pass `--timeout 120000` when calling it
>
> **Existing users (xhs-cli):** An already-installed xhs-cli continues to work as a fallback backend (upstream stopped updating in 2026-03, so new installs are not recommended). `xhs login` automatically extracts browser cookies; if that fails, export with Cookie-Editor and then run:
> ```bash
> agent-reach configure xhs-cookies "key1=val1; key2=val2; ..."
> ```

**Xueqiu (stock quotes + trending posts):**
> "Xueqiu needs cookies from a logged-in session. First log into xueqiu.com in Chrome, then run:"

```bash
agent-reach configure --from-browser chrome
```

> The cookies are extracted automatically along with the other platforms.

**Xiaoyuzhou Podcast (Groq Whisper):**
> "Xiaoyuzhou podcast transcription is installed by default — it just needs a free Groq API key."

The script is installed automatically with Agent Reach; the user only needs to provide a key:

```bash
agent-reach configure groq-key gsk_xxxxx
```

> **Get a Groq API key (free, no credit card, takes 30 seconds):**
> 1. Open https://console.groq.com
> 2. Sign in (or sign up) with a Google/GitHub account
> 3. Left-hand menu → API Keys → Create API Key
> 4. Copy the key (it starts with `gsk_`) and send it to the agent
>
> **How to use it:**
> The user sends a Xiaoyuzhou link to the agent, and the agent calls automatically:
> ```bash
> bash ~/.agent-reach/tools/xiaoyuzhou/transcribe.sh https://www.xiaoyuzhoufm.com/episode/xxxxx
> ```
>
> This automatically downloads the audio → transcodes and splits it → transcribes with Groq Whisper → outputs the full transcript.
>
> **Free tier and limits:**
> - About 2 hours of audio per hour (7200 seconds); once exceeded, it resets automatically after 15 minutes
> - More than enough for listening to a few podcast episodes a day
> - High transcription quality (Whisper large-v3), but it does not distinguish between speakers
> - For podcasts longer than 2 hours, processing them in batches is recommended

**LinkedIn (optional — linkedin-scraper-mcp):**
> "Basic LinkedIn content can be read via Jina Reader. Full functionality (profile details, job search) requires linkedin-scraper-mcp."

```bash
pip install linkedin-scraper-mcp
```

> **How to log in (requires a browser UI):**
>
> linkedin-scraper-mcp logs in using a Chromium browser, so you need to be able to see the browser window.
>
> - **Local computer (with a desktop):** Just run:
>   ```bash
>   linkedin-scraper-mcp --login --no-headless
>   ```
>   The browser pops up — log into LinkedIn manually.
>
> - **Server (no UI):** You'll need to operate through a VNC remote desktop:
>   ```bash
>   # 1. Install and start VNC on the server (skip if you already have it)
>   apt install -y tigervnc-standalone-server
>   vncserver :1 -geometry 1280x720
>   
>   # 2. Connect with a VNC client to SERVER_IP:5901
>   
>   # 3. In a terminal on the VNC desktop, run:
>   export DISPLAY=:1
>   linkedin-scraper-mcp --login --no-headless
>   ```
>   Once you see the browser in VNC, log in manually. After a successful login, the session is saved to `~/.linkedin-mcp/profile/`.
>
> **After logging in, start the MCP service:**
> ```bash
> linkedin-scraper-mcp --transport streamable-http --port 8001
> mcporter config add linkedin http://localhost:8001/mcp
> ```
>
> See https://github.com/stickerdaniel/linkedin-mcp-server for details

### Step 4: Final check

Run `agent-reach doctor` one final time and report the results to your user.

### Step 5: Set up daily monitoring (OpenClaw only)

If you are running inside **OpenClaw**, ask your user:

> "Agent Reach is installed. Would you like me to set up a daily automatic check? It keeps an eye on whether these channels are working and whether there are new versions. It only notifies you when there's a problem, and stays quiet otherwise."

If the user agrees, create a **cron job** (daily, `sessionTarget: "isolated"`, `delivery: "announce"`) with this task:

```
Run the agent-reach watch command.
If the output contains "all good", do not notify the user — end silently.
If the output contains problems (❌ ⚠️) or a new version (🆕), send the full report to the user along with a suggested fix.
If a new version is available, ask the user whether they want to upgrade (sending this sentence to the user's agent will perform a full update: Help me update Agent Reach: https://raw.githubusercontent.com/TimothyVang/Agent-Reach/main/docs/update.md).
```

If the user wants a different agent to handle it, let them choose.

---

## Quick Reference

| Command | What it does |
|---------|-------------|
| `agent-reach install --env=auto` | Install core channels (lightweight, zero-config) |
| `agent-reach install --env=auto --channels=twitter,xiaohongshu` | Install core + optional channels |
| `agent-reach install --env=auto --channels=all` | Install everything |
| `agent-reach install --env=auto --safe` | Safe setup (no auto system changes) |
| `agent-reach install --env=auto --dry-run` | Preview what would be done |
| `agent-reach doctor` | Show channel status |
| `agent-reach watch` | Quick health + update check (for scheduled tasks) |
| `agent-reach check-update` | Check for new versions |
| `agent-reach configure twitter-cookies "..."` | Unlock Twitter search + posting |
| `agent-reach configure proxy URL` | Save the proxy address (the agent reads it to set HTTP_PROXY/HTTPS_PROXY when accessing restricted networks like Reddit/Twitter — it is not an automatic unlock switch) |
| `agent-reach configure groq-key gsk_xxx` | Unlock Xiaoyuzhou podcast transcription |

After installation, use upstream tools directly. See SKILL.md for the full command reference:

| Platform | Upstream Tool | Example |
|----------|--------------|---------|
| Twitter/X | `twitter` (fallback `opencli`) | `twitter search "query" -n 10` |
| YouTube | `yt-dlp` | `yt-dlp --dump-json URL` |
| Bilibili | `bili` (subtitles via `opencli`) | `bili search "query" --type video` / `opencli bilibili subtitle BVxxx` |
| Reddit | `opencli` (fallback `rdt`) | `opencli reddit search "query" -f yaml` / `rdt read POST_ID` |
| GitHub | `gh` | `gh search repos "query"` |
| Web | `curl` + Jina | `curl -s "https://r.jina.ai/URL"` |
| Exa Search | `mcporter` | `mcporter call 'exa.web_search_exa(...)'` |
| XiaoHongShu | `opencli` (server: `mcporter`) | `opencli xiaohongshu search "query" -f yaml` |
| Xiaoyuzhou Podcast | `transcribe.sh` | `bash ~/.agent-reach/tools/xiaoyuzhou/transcribe.sh <URL>` |
| LinkedIn | `mcporter` | `mcporter call 'linkedin.get_person_profile(...)'` |
| RSS | `feedparser` | `python3 -c "import feedparser; ..."` |

> For multi-backend platforms, rely on the `active_backend` field from `agent-reach doctor --json`.

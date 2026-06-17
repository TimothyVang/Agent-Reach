# Social Media & Communities

XiaoHongShu, Twitter/X, Bilibili, V2EX, Reddit.

## XiaoHongShu (multi-backend)

XiaoHongShu has three backends. **Run `agent-reach-english doctor --json` first to see which `active_backend` is set for xiaohongshu**, then use the matching command group.

### Backend A: OpenCLI (desktop preferred, reuses the browser login session)

```bash
# Search notes
opencli xiaohongshu search "query" -f yaml

# Read a note's body + engagement data (use the full URL from the search results, including xsec_token)
opencli xiaohongshu note "NOTE_URL" -f yaml

# Comments (supports nested replies)
opencli xiaohongshu comments NOTE_ID -f yaml

# Home recommendation feed
opencli xiaohongshu feed -f yaml

# A user's public notes
opencli xiaohongshu user USER_ID -f yaml
```

> Requires Chrome to be open with the OpenCLI extension installed. An AUTH_REQUIRED error means the browser is not logged in to XiaoHongShu — just have the user log in once in Chrome.

### Backend B: xiaohongshu-mcp (server scenarios)

```bash
# When not logged in: check status first, then fetch a QR code for the user to scan
mcporter call 'xiaohongshu.check_login_status()' --timeout 120000
mcporter call 'xiaohongshu.get_login_qrcode()' --timeout 120000

# Search
mcporter call 'xiaohongshu.search_feeds(keyword: "query")' --timeout 120000

# Note detail + comments (take feed_id and xsec_token from the search results)
mcporter call 'xiaohongshu.get_feed_detail(feed_id: "...", xsec_token: "...")' --timeout 120000
```

> The first call automatically downloads a ~150MB headless browser, so always pass `--timeout 120000`. When not logged in, search will hang — call check_login_status first.

### Backend C: xhs-cli (legacy fallback, upstream stops updating from 2026-03)

```bash
xhs search "query"          # Search
xhs read NOTE_ID_OR_URL     # Read a note (must use the URL/ID from the search results, not a bare note_id)
xhs comments NOTE_ID_OR_URL # Comments
xhs hot                     # Hot
xhs feed                    # Recommendations
```

> Known instability: `xhs user` / `xhs user-posts` / `xhs favorites` may return an API error (upstream is unmaintained and unfixed). New users should go straight to backend A/B.

### General Notes

> **xsec_token restriction**: XiaoHongShu enforces an xsec_token mechanism, so **you cannot read a note with a bare note_id**. Correct flow: search / feed first to get results, then read using the full URL/ID from those results. This is the same for all three backends.
>
> **Rate control**: High-frequency requests (bulk searches, deep comment paging) trigger CAPTCHAs — a platform restriction that cannot be bypassed. Leave a 2-3 second gap between operations.
>
> **Write operations (posting / commenting / liking)**: Read-only is recommended. In xhs-cli v0.6.x, write operations may return 406 due to signature issues.

## Twitter/X (twitter-cli)

### Stable commands

```bash
# Home timeline (most stable)
twitter feed -n 20

# Read a single tweet (with replies)
twitter tweet URL_OR_ID

# Read a long-form post / X Article
twitter article URL_OR_ID

# A user's timeline
twitter user-posts @username -n 20

# A user's profile
twitter user @username
```

### Potentially unstable commands

```bash
# Search tweets (Twitter frequently changes GraphQL endpoints, may 404)
twitter search "query" -n 10

# likes (since 2024 you can only see your own, a platform restriction)
twitter likes
```

### Retry chain when search fails (run in order, stop on success)

1. Just retry once (intermittent failures are common): `twitter search "query" -n 10`
2. Upgrade, then retry: `pipx upgrade twitter-cli && twitter search "query" -n 10`
3. Switch to the OpenCLI alternative (desktop, reuses the browser login session): `opencli twitter search "query" -f yaml`
4. If none work, route around it with stable commands like `twitter feed` / `twitter user-posts @somebody`

### Important Notes

> **Install**: `pipx install twitter-cli` (make sure it is v0.8.5+)
>
> **Authentication**: It is recommended to export cookies with Cookie-Editor and set the environment variables `TWITTER_AUTH_TOKEN` + `TWITTER_CT0`. Automatic extraction does not work in SSH / Docker / headless environments.
>
> **IP risk control**: Do not make frequent calls from VPS / data-center IPs, especially followers/following — there is a ban risk. Use a residential proxy or a local environment.
>
> **OpenCLI alternative**: If OpenCLI is installed on the desktop, the full `opencli twitter search/article/user-posts -f yaml` set is available (browser login session, no cookie environment variables needed).
>
> **Output format**: Use `--yaml` or `--json` for structured output, which is more AI-agent-friendly.

## Bilibili

> ⚠️ **Do not use yt-dlp for Bilibili** (its anti-abuse system now blocks everything with 412 — confirmed unsolvable in testing). Use bili-cli / OpenCLI.

```bash
# Search / hot / video details (bili-cli, read-only, no login needed)
bili search "query" --type video -n 5
bili hot -n 10
bili video BVxxx

# Subtitles (OpenCLI, requires desktop Chrome)
opencli bilibili subtitle BVxxx
```

> For detailed commands (audio transcription, direct API fallback), see [references/video.md](video.md).

## V2EX (public API)

No authentication needed — call the public API directly.

### Hot topics

```bash
curl -s "https://www.v2ex.com/api/topics/hot.json" -H "User-Agent: agent-reach/1.0"
```

### Node topics

```bash
# node_name examples: python, tech, jobs, qna, programmers
curl -s "https://www.v2ex.com/api/topics/show.json?node_name=python&page=1" -H "User-Agent: agent-reach/1.0"
```

### Topic detail

```bash
# topic_id comes from the URL, e.g. https://www.v2ex.com/t/1234567
curl -s "https://www.v2ex.com/api/topics/show.json?id=TOPIC_ID" -H "User-Agent: agent-reach/1.0"
```

### Topic replies

```bash
curl -s "https://www.v2ex.com/api/replies/show.json?topic_id=TOPIC_ID&page=1" -H "User-Agent: agent-reach/1.0"
```

### User info

```bash
curl -s "https://www.v2ex.com/api/members/show.json?username=USERNAME" -H "User-Agent: agent-reach/1.0"
```

### Python usage example

```python
from agent_reach.channels.v2ex import V2EXChannel

ch = V2EXChannel()

# Get hot topics
topics = ch.get_hot_topics(limit=10)
for t in topics:
    print(f"[{t['node_title']}] {t['title']} ({t['replies']} replies)")

# Get node topics
node_topics = ch.get_node_topics("python", limit=5)

# Get topic detail + replies
topic = ch.get_topic(1234567)
print(topic["title"], "—", topic["author"])

# Get user info
user = ch.get_user("Livid")
```

> **Node list**: https://www.v2ex.com/planes

## Reddit (multi-backend, login required)

**Reddit has no zero-config path**: anonymous `.json` endpoints are blocked (403), and official API access has been largely rejected by manual review since 2025-11. Both backends rely on a login session — run `agent-reach-english doctor --json` first to see Reddit's `active_backend`. Access from mainland China requires a proxy.

### Backend A: OpenCLI (desktop preferred, reuses the browser login session)

```bash
# Search posts
opencli reddit search "query" -f yaml

# Read a post's full text + comments
opencli reddit read POST_ID -f yaml

# Browse subreddit / hot / Popular
opencli reddit subreddit LocalLLaMA -f yaml
opencli reddit hot -f yaml
opencli reddit popular -f yaml

# subreddit metadata (subscriber count, description)
opencli reddit subreddit-info LocalLLaMA -f yaml
```

> Requires Chrome to be open and logged in to reddit.com in the browser.

### Backend B: rdt-cli (legacy / server fallback, upstream stops updating from 2026-03)

```bash
rdt search "query" --limit 10   # Search posts
rdt read POST_ID                # Read a post's full text + comments
rdt sub python --limit 20       # Browse a subreddit
rdt popular --limit 10          # Browse hot
rdt all --limit 10              # Browse /r/all
```

> **Install**: `pipx install 'git+https://github.com/public-clis/rdt-cli.git'` (the PyPI version lags behind — install v0.4.2+ from GitHub). Run `rdt login` first before you can search and read (on a server with no browser, write the Cookie manually — see the doctor hint).
> Use `--yaml` output, which is more AI-agent-friendly.

### Advanced option: official API + PRAW (only for users who already have credentials)

Users who registered a Reddit script app before 2025-11 (holding a client_id/client_secret) can use PRAW with the official API (100 QPM free). New applications require manual review and personal projects are almost never approved, so **do not recommend this path to new users**.

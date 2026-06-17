# Troubleshooting

## Xueqiu: API returns 400

**Symptom:** `agent-reach doctor` shows Xueqiu as ⚠️, reporting `HTTP Error 400`

**Cause:** The Xueqiu API requires login cookies and cannot be accessed anonymously.

**Solution:** Log into xueqiu.com in Chrome, then run:

```bash
agent-reach configure --from-browser chrome
```

Run `agent-reach doctor` again to confirm it's back to ✅. When the cookies expire, just run it again.

---

## Twitter/X: twitter-cli connection failed

**Symptom:** `twitter search` or other commands return an error

**Cause:** twitter-cli needs the AUTH_TOKEN and CT0 environment variables to access the Twitter API. If your network requires a proxy to reach x.com, you need to configure a proxy.

**Solution:**

### Option 1: Set a proxy via environment variables

```bash
export HTTP_PROXY="http://user:pass@host:port"
export HTTPS_PROXY="http://user:pass@host:port"
twitter search "test" -n 1
```

### Option 2: Use a system-wide proxy tool

Let the proxy tool take over all network traffic, so twitter-cli's requests also go through the proxy:

```bash
# macOS — enable "enhanced mode" in ClashX / Surge
# Linux — proxychains or tun2socks
proxychains twitter search "test" -n 1
```

### Option 3: Skip twitter-cli and use Exa search instead

When twitter-cli is unavailable, you can search Twitter content directly with Exa:

```bash
mcporter call 'exa.web_search_exa(query: "site:x.com search term", numResults: 5)'
```

### Option 4: Check authentication

```bash
twitter check
```

> If it returns "Missing credentials", you need to set the AUTH_TOKEN and CT0 environment variables.
>
> **Fallback:** If you've already installed the bird CLI (`npm install -g @steipete/bird`), it works too. Agent Reach automatically detects installed tools.

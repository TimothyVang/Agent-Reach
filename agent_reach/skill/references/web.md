# Web Reading

General web pages and RSS.

## General Web Pages (Jina Reader)

```bash
# Read any web page's content
curl -s "https://r.jina.ai/URL"

# Example
curl -s "https://r.jina.ai/https://example.com/article"
```

**When to use**: Most web pages can be read directly with Jina Reader.

## Web Reader (MCP)

```bash
# Read web page content (Markdown format)
mcporter call 'web-reader.webReader(url: "https://example.com")'

# Keep images
mcporter call 'web-reader.webReader(url: "https://example.com", retain_images: true)'

# Plain text format
mcporter call 'web-reader.webReader(url: "https://example.com", return_format: "text")'
```

**When to use**: When you need more precise control over the output format.

## RSS (feedparser)

```python
python3 -c "
import feedparser
for e in feedparser.parse('FEED_URL').entries[:5]:
    print(f'{e.title} — {e.link}')
"
```

**When to use**: Subscribing to blogs, news sources, podcasts, and other RSS feeds.

## Selection Guide

| Scenario | Recommended Tool |
|-----|---------|
| General web page | Jina Reader (`curl r.jina.ai`) |
| Need image / format control | web-reader MCP |
| RSS subscription | feedparser |

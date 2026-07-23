# Video / Podcasts

Subtitles and transcripts for YouTube, Bilibili, and Xiaoyuzhou podcasts.

## YouTube (yt-dlp)

### Get video metadata

```bash
yt-dlp --dump-json "URL"
```

### Download subtitles

```bash
# Download subtitles (without downloading the video)
yt-dlp --write-sub --write-auto-sub --sub-lang "zh-Hans,zh,en" --skip-download -o "/tmp/%(id)s" "URL"

# Then read the .vtt file
cat /tmp/VIDEO_ID.*.vtt
```

### Get comments

```bash
# Extract comments (best-effort, completeness not guaranteed)
yt-dlp --write-comments --skip-download --write-info-json \
  --extractor-args "youtube:max_comments=20" \
  -o "/tmp/%(id)s" "URL"
# Comments are in the comments field of the .info.json file
```

### Search videos

```bash
yt-dlp --dump-json "ytsearch5:query"
```

> **Subtitle note**: Manually uploaded subtitles extract reliably; auto-generated subtitles may have duplicate lines and need post-processing.
> **Comment note**: `--write-comments` is based on web scraping (not the YouTube Data API), so some comments may be missing.

### No-subtitle fallback: Whisper audio transcription

```bash
# Fallback when a video has no subtitles: download the audio and transcribe with Whisper (a free Groq key works)
agent-reach-english transcribe "https://www.youtube.com/watch?v=VIDEO_ID"
agent-reach-english transcribe ./local_audio.mp3 -o /tmp/transcript.txt
```

> `agent-reach-english transcribe` only accepts public http(s) URLs or local audio files. When searching with `ytsearch5:`, pick a specific video URL from the yt-dlp results first, then transcribe it.
> Configure a key first: `agent-reach-english configure groq-key gsk_xxx` (free, console.groq.com)
> or `agent-reach-english configure openai-key sk-xxx`. Default auto mode: if groq fails, it automatically falls back to openai.

## Bilibili (bili-cli primary, OpenCLI for subtitles)

> ⚠️ **Do not use yt-dlp for Bilibili**: Bilibili's anti-abuse system now blocks yt-dlp entirely with 412 (tested on the latest version — direct, proxied, and with cookies all fail). yt-dlp is for YouTube only.

### Video details / search / hot / ranking (bili-cli, read-only, no login needed)

```bash
# Video details (title / uploader / duration / view & interaction stats / subtitle availability)
bili video BVxxx

# Search videos
bili search "query" --type video -n 5

# Hot videos / ranking list
bili hot -n 10
bili rank -n 10

# Download audio and split into ASR-ready WAV (pair with agent-reach-english transcribe when there are no subtitles)
bili audio BVxxx
```

### Subtitles (OpenCLI, requires desktop Chrome)

```bash
# Subtitles, line by line with timestamps
opencli bilibili subtitle BVxxx

# OpenCLI can also search / read video metadata (alternative)
opencli bilibili search "query" -f yaml
opencli bilibili video BVxxx -f yaml
```

### Zero-config fallback: direct search API call

```bash
UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36"
curl -s -c /tmp/bili_ck.txt -o /dev/null -A "$UA" "https://www.bilibili.com/"
curl -s -b /tmp/bili_ck.txt -A "$UA" -e "https://www.bilibili.com/" \
  "https://api.bilibili.com/x/web-interface/search/all/v2?keyword=QUERY&page=1"
```

> **Install bili-cli**: `pipx install bilibili-cli` (upstream stops updating from 2026-03 but tests healthy; read-only use needs no login — `bili login` with a QR scan unlocks personal features like activity feed and favorites).

## Xiaoyuzhou Podcast

### Transcribe a single episode (optional --polish for better punctuation)

```bash
# Outputs a Markdown file to /tmp/. --polish has Llama 3.3 70B add Chinese punctuation and sensible paragraph breaks
~/.agent-reach/tools/xiaoyuzhou/transcribe.sh --polish "https://www.xiaoyuzhoufm.com/episode/EPISODE_ID"
```

> The transcription prompt already asks Whisper to output Chinese punctuation; if punctuation still looks off, add `--polish` to use the free Llama 3.3 70B on Groq for punctuation and sensible paragraph breaks (a 9-minute podcast takes ~7 seconds longer). Each transcription adds one extra LLM call, so use it as needed.

### Prerequisites

1. **ffmpeg**: `brew install ffmpeg`
2. **Groq API Key** (free): https://console.groq.com/keys
3. **Configure key**: `agent-reach-english configure groq-key YOUR_KEY`
4. **First run**: `agent-reach-english install --env=auto` to install the tools

### Check status

```bash
agent-reach-english doctor
```

> Output Markdown files are saved to `/tmp/` by default.

## Selection Guide

| Scenario | Recommended Tool |
|-----|---------|
| YouTube subtitles | yt-dlp |
| Bilibili video details / search | bili-cli |
| Bilibili subtitles | opencli bilibili subtitle |
| Podcast transcription | Xiaoyuzhou transcribe.sh |
| Audio/video without subtitles | agent-reach-english transcribe (for Bilibili audio, run `bili audio` first) |

# Groq Whisper Setup Guide

## Overview
When a YouTube/Bilibili video has no subtitles, Groq's Whisper API is used to transcribe speech to text. Groq offers a free tier.

## Steps the Agent Can Complete Automatically

1. Check whether it is already configured:
```bash
agent-reach-english doctor | grep -i "groq\|whisper"
```

2. If the user provides a key, write it to the config:
```python
from agent_reach.config import Config
c = Config()
c.set("groq_api_key", "KEY_PROVIDED_BY_USER")
```

3. Test (optional):
```bash
curl -s https://api.groq.com/openai/v1/models \
  -H "Authorization: Bearer KEY_PROVIDED_BY_USER" \
  -o /dev/null -w "%{http_code}"
```
A return value of 200 = working

## Steps the User Must Do Manually

Tell the user:

> Video speech-to-text requires a Groq API key (free).
>
> Steps:
> 1. Open https://console.groq.com
> 2. Sign up with a Google account or email
> 3. Click "API Keys" on the left
> 4. Click "Create API Key"
> 5. Copy the generated key and send it to me
>
> Groq offers a free tier, which is more than enough for everyday use.

## What the Agent Does After Receiving the Key

1. Write to config: `config.set("groq_api_key", key)`
2. Test that the API works
3. Report back: "✅ Speech-to-text is now enabled! Now I can also extract content from videos that have no subtitles."

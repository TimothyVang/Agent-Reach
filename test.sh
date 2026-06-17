#!/bin/bash
# Agent Reach one-shot full test
# Usage: bash test-agent-reach.sh
# Just run it on any machine with Python 3.10+

set -e

echo "╔════════════════════════════════════════════╗"
echo "║    👁️  Agent Reach Full Test               ║"
echo "╚════════════════════════════════════════════╝"
echo ""

# ── 1. Set up a clean environment ──
echo "📦 Creating test environment..."
TEST_DIR=$(mktemp -d)
python3 -m venv "$TEST_DIR/venv"
source "$TEST_DIR/venv/bin/activate"

# ── 2. Install ──
echo "📥 Installing from GitHub..."
pip install -q https://github.com/TimothyVang/Agent-Reach/archive/refs/tags/v1.5.0.zip 2>&1 | tail -1
echo ""

# ── 3. Auto-configure ──
echo "⚙️  Running install..."
agent-reach-english install --env=auto 2>&1
echo ""

# ── 4. Diagnostics ──
echo "🩺 Running doctor..."
agent-reach-english doctor 2>&1
echo ""

# ── 5. Test one by one ──
PASS=0
FAIL=0
SKIP=0

test_it() {
    local name="$1"
    shift
    echo -n "  $name ... "
    output=$("$@" 2>&1) || true
    if echo "$output" | grep -q "📖\|🔗\|http"; then
        echo "✅"
        PASS=$((PASS+1))
    elif echo "$output" | grep -q "⚠️\|not installed\|not configured"; then
        echo "⏭️  (skipped — missing dependency)"
        SKIP=$((SKIP+1))
    else
        echo "❌"
        echo "    $(echo "$output" | head -2)"
        FAIL=$((FAIL+1))
    fi
}

echo "📖 Read tests"
test_it "Web page" agent-reach-english read "https://example.com"
test_it "GitHub" agent-reach-english read "https://github.com/TimothyVang/Agent-Reach"
test_it "YouTube" agent-reach-english read "https://www.youtube.com/watch?v=dQw4w9WgXcQ"
test_it "Bilibili" agent-reach-english read "https://www.bilibili.com/video/BV1d4411N7zD"
test_it "RSS" agent-reach-english read "https://hnrss.org/frontpage"
test_it "Twitter" agent-reach-english read "https://x.com/elonmusk/status/1893797839927353448"
test_it "Reddit" agent-reach-english read "https://www.reddit.com/r/LocalLLaMA/hot"

echo ""
echo "🔍 Search tests"
test_it "Web search" agent-reach-english search "best AI agent framework" -n 2
test_it "GitHub search" agent-reach-english search-github "yt-dlp" -n 2
test_it "Twitter search" agent-reach-english search-twitter "AI agent" -n 2
test_it "Reddit search" agent-reach-english search-reddit "machine learning" -n 2
test_it "YouTube search" agent-reach-english search-youtube "AI tutorial" -n 2
test_it "Bilibili search" agent-reach-english search-bilibili "AI" -n 2
test_it "XiaoHongShu search" agent-reach-english search-xhs "AI" -n 2

echo ""
echo "════════════════════════════════════════════"
echo "  ✅ Passed: $PASS   ❌ Failed: $FAIL   ⏭️  Skipped: $SKIP"
echo "════════════════════════════════════════════"

# ── 6. Clean up ──
deactivate 2>/dev/null || true
rm -rf "$TEST_DIR"

if [ $FAIL -eq 0 ]; then
    echo ""
    echo "🎉 All passed!"
else
    echo ""
    echo "⚠️  $FAIL test(s) failed; please check the output above"
    exit 1
fi

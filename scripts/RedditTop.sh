#!/bin/bash

################################################################################
# RedditTop.sh - Display top 5 posts from a subreddit
# Usage: RedditTop.sh [subreddit_name]
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║            Reddit Top Posts Viewer                     ║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is not installed${RESET}"
    echo "Install it using:"
    echo "  Ubuntu/Debian: sudo apt-get install curl"
    echo "  Fedora/RHEL:   sudo dnf install curl"
    exit 1
fi

# Get subreddit from argument or use default
SUBREDDIT=${1:-"all"}

echo -e "${YELLOW}Fetching top posts from r/${SUBREDDIT}...${RESET}\n"

# Fetch data from Reddit JSON API
JSON_DATA=$(curl -s -H "User-Agent: Bash Script" "https://www.reddit.com/r/${SUBREDDIT}/top.json?limit=5" 2>/dev/null)

# Check if request was successful
if [ $? -ne 0 ] || [ -z "${JSON_DATA}" ]; then
    echo -e "${RED}Error: Failed to fetch data from Reddit${RESET}"
    echo "Please check:"
    echo "  - Internet connection"
    echo "  - Subreddit name is correct"
    exit 1
fi

# Check if jq is available for better JSON parsing
if command -v jq &> /dev/null; then
    # Parse with jq
    echo "${JSON_DATA}" | jq -r '.data.children[] | 
        "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n" +
        "Title: \(.data.title)\n" +
        "Author: u/\(.data.author)\n" +
        "Score: ⬆ \(.data.score) | Comments: 💬 \(.data.num_comments)\n" +
        "URL: https://reddit.com\(.data.permalink)\n"' | head -n 100
else
    # Fallback: Parse with grep and sed (less elegant but works)
    echo -e "${YELLOW}Note: Install jq for better formatting${RESET}\n"
    
    # Extract titles using basic text processing
    echo "${JSON_DATA}" | grep -o '"title":"[^"]*"' | sed 's/"title":"//g' | sed 's/"//g' | head -5 | nl -w2 -s'. '
    
    echo ""
    echo -e "${BLUE}For full details, install jq:${RESET}"
    echo "  Ubuntu/Debian: sudo apt-get install jq"
    echo "  Fedora/RHEL:   sudo dnf install jq"
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}Data from r/${SUBREDDIT}${RESET}"
echo -e "${BLUE}To view another subreddit: RedditTop.sh <subreddit_name>${RESET}"
echo ""

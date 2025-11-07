#!/bin/bash

################################################################################
# Disk-Space.sh - Monitor disk space availability
# Usage: Disk-Space.sh [threshold_percentage]
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# Default threshold is 80%
THRESHOLD=${1:-80}

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║           Disk Space Monitoring Report                ║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${RESET}\n"

echo "Alert Threshold: ${THRESHOLD}%"
echo ""

# Display all mounted filesystems
echo -e "${GREEN}[All Filesystems]${RESET}"
df -h | grep -vE "tmpfs|devtmpfs|loop"
echo ""

# Check each filesystem
echo -e "${GREEN}[Status Check]${RESET}"
ALERT=0

while IFS= read -r line; do
    USAGE=$(echo "$line" | awk '{print $5}' | sed 's/%//')
    MOUNT=$(echo "$line" | awk '{print $6}')
    AVAIL=$(echo "$line" | awk '{print $4}')
    
    if [ -n "${USAGE}" ] && [ "${USAGE}" -ge "${THRESHOLD}" ]; then
        echo -e "${RED}⚠️  ALERT: ${MOUNT} is at ${USAGE}% (Available: ${AVAIL})${RESET}"
        ALERT=1
    elif [ -n "${USAGE}" ] && [ "${USAGE}" -ge 60 ]; then
        echo -e "${YELLOW}⚠  Warning: ${MOUNT} is at ${USAGE}% (Available: ${AVAIL})${RESET}"
    else
        echo -e "${GREEN}✓ ${MOUNT} is healthy at ${USAGE}% (Available: ${AVAIL})${RESET}"
    fi
done < <(df -h | grep -vE "Filesystem|tmpfs|devtmpfs|loop")

echo ""

# Show largest directories in root
if [ "${ALERT}" -eq 1 ]; then
    echo -e "${YELLOW}[Largest Directories in /]${RESET}"
    du -sh /* 2>/dev/null | sort -rh | head -10
    echo ""
fi

# Inode usage
echo -e "${GREEN}[Inode Usage]${RESET}"
df -i / | grep -v Filesystem

echo ""
echo -e "${BLUE}Scan completed at $(date)${RESET}"

exit ${ALERT}

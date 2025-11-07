#!/bin/bash

################################################################################
# Server-Health.sh - Monitor system uptime, load, and memory usage
# Usage: Server-Health.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║         Server Health Monitoring Report               ║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${RESET}\n"

# System Uptime
echo -e "${GREEN}[System Uptime]${RESET}"
uptime -p 2>/dev/null || uptime
echo ""

# Load Average
echo -e "${GREEN}[Load Average]${RESET}"
LOAD=$(cat /proc/loadavg | awk '{print $1, $2, $3}')
CORES=$(nproc)
echo "1-min, 5-min, 15-min: ${LOAD}"
echo "CPU Cores: ${CORES}"
echo ""

# Memory Usage
echo -e "${GREEN}[Memory Usage]${RESET}"
free -h | grep -E "Mem|Swap"
MEM_PERCENT=$(free | grep Mem | awk '{printf "%.1f", $3/$2 * 100.0}')
echo "Memory Usage: ${MEM_PERCENT}%"

if (( $(echo "${MEM_PERCENT} > 80" | bc -l 2>/dev/null || echo 0) )); then
    echo -e "${RED}⚠ Warning: High memory usage!${RESET}"
elif (( $(echo "${MEM_PERCENT} > 60" | bc -l 2>/dev/null || echo 0) )); then
    echo -e "${YELLOW}⚠ Caution: Moderate memory usage${RESET}"
else
    echo -e "${GREEN}✓ Memory usage is healthy${RESET}"
fi
echo ""

# Disk Usage
echo -e "${GREEN}[Disk Usage]${RESET}"
df -h / | grep -v Filesystem
ROOT_USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')
if [ "${ROOT_USAGE}" -gt 80 ]; then
    echo -e "${RED}⚠ Warning: Low disk space!${RESET}"
elif [ "${ROOT_USAGE}" -gt 60 ]; then
    echo -e "${YELLOW}⚠ Caution: Moderate disk usage${RESET}"
else
    echo -e "${GREEN}✓ Disk space is healthy${RESET}"
fi
echo ""

# Top Processes by CPU
echo -e "${GREEN}[Top 5 Processes by CPU]${RESET}"
ps aux --sort=-%cpu | head -6 | tail -5
echo ""

# Top Processes by Memory
echo -e "${GREEN}[Top 5 Processes by Memory]${RESET}"
ps aux --sort=-%mem | head -6 | tail -5
echo ""

echo -e "${BLUE}Health check complete at $(date)${RESET}"

#!/bin/bash

################################################################################
# CPU.sh - Alert when CPU usage exceeds threshold
# Usage: CPU.sh [threshold_percentage]
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

# Default threshold is 80%
THRESHOLD=${1:-80}

echo -e "${BLUE}=== CPU Usage Monitor ===${RESET}\n"
echo "Threshold: ${THRESHOLD}%"
echo "Checking CPU usage..."
echo ""

# Get CPU usage (average over 1 second)
CPU_USAGE=$(top -bn2 -d 0.5 | grep "Cpu(s)" | tail -1 | awk '{print $2}' | cut -d'%' -f1)

# Handle if CPU_USAGE is empty
if [ -z "${CPU_USAGE}" ]; then
    # Alternative method using mpstat if available
    if command -v mpstat &> /dev/null; then
        CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
    else
        # Fallback to /proc/stat
        CPU_USAGE=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage}')
    fi
fi

echo -e "${GREEN}Current CPU Usage: ${CPU_USAGE}%${RESET}"
echo ""

# Compare and alert
if (( $(echo "${CPU_USAGE} > ${THRESHOLD}" | bc -l 2>/dev/null || [ "${CPU_USAGE%.*}" -gt "${THRESHOLD}" ] && echo 1 || echo 0) )); then
    echo -e "${RED}⚠️  ALERT: CPU usage (${CPU_USAGE}%) exceeds threshold (${THRESHOLD}%)!${RESET}"
    echo ""
    echo -e "${YELLOW}Top 5 CPU-consuming processes:${RESET}"
    ps aux --sort=-%cpu | head -6
    exit 1
else
    echo -e "${GREEN}✓ CPU usage is within acceptable limits${RESET}"
fi

# Display CPU info
echo ""
echo -e "${BLUE}CPU Information:${RESET}"
lscpu | grep -E "Model name|CPU\(s\)|Thread|Core"

echo ""
echo -e "${GREEN}Monitoring complete!${RESET}"

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
# Use multiple methods for better compatibility
CPU_USAGE=""

# Method 1: Try top command
CPU_USAGE=$(top -bn2 -d 0.5 | grep "Cpu(s)" | tail -1 | awk '{print $2}' | cut -d'%' -f1)

# Method 2: If top fails or returns 0, try mpstat
if [ -z "${CPU_USAGE}" ] || [ "${CPU_USAGE}" = "0.0" ] || [ "${CPU_USAGE}" = "0" ]; then
    if command -v mpstat &> /dev/null; then
        CPU_USAGE=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
    fi
fi

# Method 3: If still empty, use /proc/stat (most reliable)
if [ -z "${CPU_USAGE}" ] || [ "${CPU_USAGE}" = "0.0" ] || [ "${CPU_USAGE}" = "0" ]; then
    # Read CPU stats twice with 1 second delay for accurate measurement
    read -r cpu1_user cpu1_nice cpu1_system cpu1_idle cpu1_iowait cpu1_irq cpu1_softirq cpu1_steal rest < <(grep 'cpu ' /proc/stat | awk '{print $2, $3, $4, $5, $6, $7, $8, $9}')
    sleep 1
    read -r cpu2_user cpu2_nice cpu2_system cpu2_idle cpu2_iowait cpu2_irq cpu2_softirq cpu2_steal rest < <(grep 'cpu ' /proc/stat | awk '{print $2, $3, $4, $5, $6, $7, $8, $9}')
    
    # Calculate differences
    user_diff=$((cpu2_user - cpu1_user))
    nice_diff=$((cpu2_nice - cpu1_nice))
    system_diff=$((cpu2_system - cpu1_system))
    idle_diff=$((cpu2_idle - cpu1_idle))
    iowait_diff=$((cpu2_iowait - cpu1_iowait))
    irq_diff=$((cpu2_irq - cpu1_irq))
    softirq_diff=$((cpu2_softirq - cpu1_softirq))
    steal_diff=$((cpu2_steal - cpu1_steal))
    
    # Calculate total and usage
    total_diff=$((user_diff + nice_diff + system_diff + idle_diff + iowait_diff + irq_diff + softirq_diff + steal_diff))
    usage_diff=$((user_diff + nice_diff + system_diff + iowait_diff + irq_diff + softirq_diff + steal_diff))
    
    if [ ${total_diff} -gt 0 ]; then
        CPU_USAGE=$(awk "BEGIN {printf \"%.1f\", (${usage_diff}/${total_diff})*100}")
    else
        CPU_USAGE="0.0"
    fi
fi

# Ensure CPU_USAGE has a value
CPU_USAGE=${CPU_USAGE:-0.0}

echo -e "${GREEN}Current CPU Usage: ${CPU_USAGE}%${RESET}"
echo ""

# Compare and alert
# Try bc for floating point comparison, fallback to integer comparison
EXCEEDS=0
if command -v bc &> /dev/null && [ -n "${CPU_USAGE}" ]; then
    EXCEEDS=$(echo "${CPU_USAGE} > ${THRESHOLD}" | bc -l 2>/dev/null || echo 0)
else
    # Fallback: convert to integer for comparison
    CPU_INT=${CPU_USAGE%.*}
    CPU_INT=${CPU_INT:-0}
    if [ "${CPU_INT}" -gt "${THRESHOLD}" ] 2>/dev/null; then
        EXCEEDS=1
    fi
fi

if [ "${EXCEEDS}" -eq 1 ]; then
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

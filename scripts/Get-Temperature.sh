#!/bin/bash

################################################################################
# Get-Temperature.sh - Read CPU temperature from sensors
# Usage: Get-Temperature.sh
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"

echo -e "${BLUE}=== CPU Temperature Monitor ===${RESET}\n"

# Check if sensors command is available
if command -v sensors &> /dev/null; then
    echo -e "${GREEN}[Sensor Readings]${RESET}"
    sensors | grep -E "Core|temp|CPU"
    echo ""
    
    # Get average temperature
    TEMPS=$(sensors | grep -oP '\+\K[0-9]+\.[0-9]+(?=°C)' | head -5)
    if [ -n "${TEMPS}" ]; then
        AVG_TEMP=$(echo "${TEMPS}" | awk '{sum+=$1; count++} END {if(count>0) print sum/count; else print 0}')
        echo -e "${BLUE}Average Temperature: ${AVG_TEMP}°C${RESET}"
        
        # Temperature warning
        if (( $(echo "${AVG_TEMP} > 80" | bc -l 2>/dev/null || [ "${AVG_TEMP%.*}" -gt 80 ] && echo 1 || echo 0) )); then
            echo -e "${RED}⚠️  WARNING: High temperature detected!${RESET}"
        elif (( $(echo "${AVG_TEMP} > 60" | bc -l 2>/dev/null || [ "${AVG_TEMP%.*}" -gt 60 ] && echo 1 || echo 0) )); then
            echo -e "${YELLOW}⚠  Temperature is elevated${RESET}"
        else
            echo -e "${GREEN}✓ Temperature is normal${RESET}"
        fi
    fi
else
    # Try reading from /sys/class/thermal
    echo -e "${YELLOW}sensors command not found, trying alternative methods...${RESET}\n"
    
    if [ -d /sys/class/thermal ]; then
        echo -e "${GREEN}[Thermal Zones]${RESET}"
        for zone in /sys/class/thermal/thermal_zone*/; do
            if [ -f "${zone}temp" ]; then
                TEMP=$(cat "${zone}temp")
                TEMP_C=$((TEMP / 1000))
                TYPE=$(cat "${zone}type" 2>/dev/null || echo "Unknown")
                echo "${TYPE}: ${TEMP_C}°C"
                
                if [ ${TEMP_C} -gt 80 ]; then
                    echo -e "${RED}⚠️  WARNING: High temperature!${RESET}"
                fi
            fi
        done
    else
        echo -e "${YELLOW}No temperature sensors found${RESET}"
        echo ""
        echo "To install sensors package:"
        echo "  Ubuntu/Debian: sudo apt-get install lm-sensors"
        echo "  Fedora/RHEL:   sudo dnf install lm_sensors"
        echo "  Arch Linux:    sudo pacman -S lm_sensors"
        echo ""
        echo "After installation, run: sudo sensors-detect"
    fi
fi

echo ""
echo -e "${BLUE}Temperature check complete!${RESET}"

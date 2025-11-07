#!/bin/bash

################################################################################
# weather.sh - Fetch weather using geolocation
# Usage: weather.sh [city_name]
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║              Weather Information Service               ║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"

# Check if curl is available
if ! command -v curl &> /dev/null; then
    echo -e "${RED}Error: curl is not installed${RESET}"
    echo "Install it using:"
    echo "  Ubuntu/Debian: sudo apt-get install curl"
    echo "  Fedora/RHEL:   sudo dnf install curl"
    exit 1
fi

# Get city from argument or ask user
if [ $# -eq 0 ]; then
    read -p "Enter city name (or press Enter for auto-detection): " LOCATION
else
    LOCATION="$*"
fi

echo -e "${YELLOW}Fetching weather data...${RESET}\n"

# Use wttr.in service
if [ -z "${LOCATION}" ]; then
    # Auto-detect location
    curl -s "wttr.in/?format=3" 2>/dev/null
    echo ""
    echo ""
    curl -s "wttr.in/?0qF" 2>/dev/null
else
    # Specific location
    curl -s "wttr.in/${LOCATION}?format=3" 2>/dev/null
    echo ""
    echo ""
    curl -s "wttr.in/${LOCATION}?0qF" 2>/dev/null
fi

# Check if request was successful
if [ $? -ne 0 ]; then
    echo -e "${RED}Error: Failed to fetch weather data${RESET}"
    echo "Please check your internet connection"
    exit 1
fi

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
echo -e "${GREEN}Weather data provided by wttr.in${RESET}"
echo -e "${BLUE}For more formats, try: curl wttr.in/${LOCATION}${RESET}"
echo ""

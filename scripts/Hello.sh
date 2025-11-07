#!/bin/bash

################################################################################
# Hello.sh - Basic I/O demonstration
# Usage: Hello.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}╔════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║        Hello - Interactive Demo            ║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${RESET}\n"

# Basic greeting
echo -e "${BLUE}Hello! This is a basic I/O demonstration.${RESET}\n"

# Get user name
read -p "What is your name? " NAME

if [ -z "${NAME}" ]; then
    NAME="Anonymous"
fi

# Get user age
read -p "How old are you? " AGE

# Validate age
if [[ ! "${AGE}" =~ ^[0-9]+$ ]]; then
    AGE="unknown"
fi

# Get favorite color
echo -e "\nWhat is your favorite color?"
echo "1. Red"
echo "2. Blue"
echo "3. Green"
echo "4. Yellow"
read -p "Enter choice (1-4): " COLOR_CHOICE

case "${COLOR_CHOICE}" in
    1) FAVORITE_COLOR="Red" ;;
    2) FAVORITE_COLOR="Blue" ;;
    3) FAVORITE_COLOR="Green" ;;
    4) FAVORITE_COLOR="Yellow" ;;
    *) FAVORITE_COLOR="Unknown" ;;
esac

# Display summary
echo ""
echo -e "${GREEN}╔════════════════════════════════════════════╗${RESET}"
echo -e "${GREEN}║            User Information                 ║${RESET}"
echo -e "${GREEN}╚════════════════════════════════════════════╝${RESET}"
echo ""
echo -e "${YELLOW}Name:${RESET} ${NAME}"
echo -e "${YELLOW}Age:${RESET} ${AGE}"
echo -e "${YELLOW}Favorite Color:${RESET} ${FAVORITE_COLOR}"
echo ""
echo -e "${GREEN}Nice to meet you, ${NAME}! 👋${RESET}"
echo -e "${BLUE}Current date and time: $(date)${RESET}"
echo -e "${BLUE}You are running this script from: $(pwd)${RESET}"
echo ""
echo -e "${CYAN}Thank you for using the interactive demo!${RESET}"

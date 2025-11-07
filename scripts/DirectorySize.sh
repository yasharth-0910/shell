#!/bin/bash

################################################################################
# DirectorySize.sh - Report directory size using du command
# Usage: DirectorySize.sh [directory_path]
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
RESET="\033[0m"

# Check if directory is provided
if [ $# -eq 0 ]; then
    TARGET_DIR="."
else
    TARGET_DIR="$1"
fi

# Validate directory exists
if [ ! -d "${TARGET_DIR}" ]; then
    echo -e "${RED}Error: Directory '${TARGET_DIR}' does not exist${RESET}"
    exit 1
fi

echo -e "${BLUE}=== Directory Size Report ===${RESET}\n"
echo -e "${GREEN}Analyzing: ${TARGET_DIR}${RESET}\n"

# Display total size
echo "Total Size:"
du -sh "${TARGET_DIR}" 2>/dev/null

echo -e "\nTop 10 Largest Subdirectories:"
du -h "${TARGET_DIR}" 2>/dev/null | sort -rh | head -11 | tail -10

echo -e "\n${GREEN}Analysis complete!${RESET}"

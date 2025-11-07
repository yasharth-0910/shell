#!/bin/bash

################################################################################
# Test-File.sh - Check file/directory status and permissions
# Usage: Test-File.sh <file_or_directory_path>
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Check if file path is provided
if [ $# -eq 0 ]; then
    echo -e "${RED}Error: No file or directory specified${RESET}"
    echo "Usage: $0 <file_or_directory_path>"
    exit 1
fi

TARGET="$1"

echo -e "${BLUE}=== File/Directory Test Report ===${RESET}\n"
echo -e "${GREEN}Target: ${TARGET}${RESET}\n"

# Check if exists
if [ ! -e "${TARGET}" ]; then
    echo -e "${RED}❌ Does not exist${RESET}"
    exit 1
fi

echo -e "${GREEN}✓ Exists${RESET}"

# Type checks
if [ -f "${TARGET}" ]; then
    echo -e "${GREEN}✓ Regular file${RESET}"
elif [ -d "${TARGET}" ]; then
    echo -e "${GREEN}✓ Directory${RESET}"
elif [ -L "${TARGET}" ]; then
    echo -e "${YELLOW}✓ Symbolic link${RESET}"
elif [ -b "${TARGET}" ]; then
    echo -e "${YELLOW}✓ Block device${RESET}"
elif [ -c "${TARGET}" ]; then
    echo -e "${YELLOW}✓ Character device${RESET}"
fi

# Permission checks
echo -e "\n${BLUE}Permissions:${RESET}"
[ -r "${TARGET}" ] && echo -e "${GREEN}✓ Readable${RESET}" || echo -e "${RED}❌ Not readable${RESET}"
[ -w "${TARGET}" ] && echo -e "${GREEN}✓ Writable${RESET}" || echo -e "${RED}❌ Not writable${RESET}"
[ -x "${TARGET}" ] && echo -e "${GREEN}✓ Executable${RESET}" || echo -e "${RED}❌ Not executable${RESET}"

# Additional info
echo -e "\n${BLUE}Details:${RESET}"
ls -lh "${TARGET}"

# Size info (for files)
if [ -f "${TARGET}" ]; then
    SIZE=$(stat -c%s "${TARGET}" 2>/dev/null || stat -f%z "${TARGET}" 2>/dev/null)
    echo -e "\n${BLUE}Size:${RESET} ${SIZE} bytes"
fi

# Modification time
if command -v stat &> /dev/null; then
    MOD_TIME=$(stat -c%y "${TARGET}" 2>/dev/null || stat -f%Sm "${TARGET}" 2>/dev/null)
    echo -e "${BLUE}Last Modified:${RESET} ${MOD_TIME}"
fi

echo -e "\n${GREEN}Test complete!${RESET}"

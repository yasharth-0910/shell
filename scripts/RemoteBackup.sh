#!/bin/bash

################################################################################
# RemoteBackup.sh - Backup files to remote server via SCP
# Usage: RemoteBackup.sh <source_path> <remote_user@host> <remote_path>
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

# Check arguments
if [ $# -lt 3 ]; then
    echo -e "${RED}Error: Insufficient arguments${RESET}"
    echo "Usage: $0 <source_path> <remote_user@host> <remote_path>"
    echo "Example: $0 /home/user/data user@192.168.1.100 /backup/data"
    exit 1
fi

SOURCE="$1"
REMOTE_HOST="$2"
REMOTE_PATH="$3"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_NAME="backup_${TIMESTAMP}.tar.gz"

echo -e "${BLUE}=== Remote Backup Utility ===${RESET}\n"

# Verify source exists
if [ ! -e "${SOURCE}" ]; then
    echo -e "${RED}Error: Source '${SOURCE}' does not exist${RESET}"
    exit 1
fi

echo -e "${GREEN}Source:${RESET} ${SOURCE}"
echo -e "${GREEN}Destination:${RESET} ${REMOTE_HOST}:${REMOTE_PATH}"
echo -e "${GREEN}Backup Name:${RESET} ${BACKUP_NAME}"
echo ""

# Create temporary backup archive
echo -e "${YELLOW}Creating backup archive...${RESET}"
TEMP_DIR="/tmp/backup_$$"
mkdir -p "${TEMP_DIR}"

if [ -d "${SOURCE}" ]; then
    tar -czf "${TEMP_DIR}/${BACKUP_NAME}" -C "$(dirname "${SOURCE}")" "$(basename "${SOURCE}")" 2>/dev/null
else
    tar -czf "${TEMP_DIR}/${BACKUP_NAME}" "${SOURCE}" 2>/dev/null
fi

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Archive created successfully${RESET}"
    ARCHIVE_SIZE=$(du -h "${TEMP_DIR}/${BACKUP_NAME}" | cut -f1)
    echo "Archive size: ${ARCHIVE_SIZE}"
else
    echo -e "${RED}✗ Failed to create archive${RESET}"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

echo ""
echo -e "${YELLOW}Transferring to remote server...${RESET}"

# Transfer using SCP
scp "${TEMP_DIR}/${BACKUP_NAME}" "${REMOTE_HOST}:${REMOTE_PATH}/${BACKUP_NAME}"

if [ $? -eq 0 ]; then
    echo -e "${GREEN}✓ Backup transferred successfully!${RESET}"
    echo "Remote location: ${REMOTE_HOST}:${REMOTE_PATH}/${BACKUP_NAME}"
else
    echo -e "${RED}✗ Transfer failed${RESET}"
    echo "Please check:"
    echo "  - SSH connection to ${REMOTE_HOST}"
    echo "  - Remote path ${REMOTE_PATH} exists and is writable"
    echo "  - SSH key authentication is set up"
    rm -rf "${TEMP_DIR}"
    exit 1
fi

# Cleanup
rm -rf "${TEMP_DIR}"

echo ""
echo -e "${BLUE}Backup completed at $(date)${RESET}"

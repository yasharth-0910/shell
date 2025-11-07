#!/bin/bash

################################################################################
# uninstall.sh - Uninstallation script for Custom Bash Shell Environment
# Usage: ./uninstall.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Script directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHELL_NAME="MyShell"

# Display banner
show_banner() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║      Custom Bash Shell - Uninstallation Script        ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"
}

# Confirmation prompt
confirm_uninstall() {
    echo -e "${RED}WARNING: This will remove Custom Bash Shell Environment${RESET}"
    echo -e "${YELLOW}Installation directory: ${INSTALL_DIR}${RESET}"
    echo ""
    echo "The following will be removed:"
    echo "  • Shell configuration and history"
    echo "  • PATH modifications"
    echo "  • Desktop launcher (if created)"
    echo ""
    echo -e "${YELLOW}Note: The scripts directory will NOT be deleted${RESET}"
    echo ""
    
    read -p "Are you sure you want to continue? (yes/no): " confirm
    if [[ ! "${confirm}" =~ ^[Yy][Ee][Ss]$ ]]; then
        echo -e "${GREEN}Uninstallation cancelled${RESET}"
        exit 0
    fi
    echo ""
}

# Remove from PATH
remove_from_path() {
    echo -e "${BLUE}[1/4] Removing from PATH...${RESET}"
    
    local modified=0
    
    # Check bash config
    if [ -f "${HOME}/.bashrc" ]; then
        if grep -q "${INSTALL_DIR}" "${HOME}/.bashrc"; then
            # Create backup
            cp "${HOME}/.bashrc" "${HOME}/.bashrc.backup"
            
            # Remove PATH entry
            sed -i "\|${INSTALL_DIR}|d" "${HOME}/.bashrc"
            sed -i '/# Custom Bash Shell Environment/d' "${HOME}/.bashrc"
            
            echo -e "${GREEN}✓ Removed from ~/.bashrc${RESET}"
            echo -e "${YELLOW}  Backup saved: ~/.bashrc.backup${RESET}"
            modified=1
        fi
    fi
    
    # Check zsh config
    if [ -f "${HOME}/.zshrc" ]; then
        if grep -q "${INSTALL_DIR}" "${HOME}/.zshrc"; then
            # Create backup
            cp "${HOME}/.zshrc" "${HOME}/.zshrc.backup"
            
            # Remove PATH entry
            sed -i "\|${INSTALL_DIR}|d" "${HOME}/.zshrc"
            sed -i '/# Custom Bash Shell Environment/d' "${HOME}/.zshrc"
            
            echo -e "${GREEN}✓ Removed from ~/.zshrc${RESET}"
            echo -e "${YELLOW}  Backup saved: ~/.zshrc.backup${RESET}"
            modified=1
        fi
    fi
    
    # Check profile
    if [ -f "${HOME}/.profile" ]; then
        if grep -q "${INSTALL_DIR}" "${HOME}/.profile"; then
            # Create backup
            cp "${HOME}/.profile" "${HOME}/.profile.backup"
            
            # Remove PATH entry
            sed -i "\|${INSTALL_DIR}|d" "${HOME}/.profile"
            sed -i '/# Custom Bash Shell Environment/d' "${HOME}/.profile"
            
            echo -e "${GREEN}✓ Removed from ~/.profile${RESET}"
            echo -e "${YELLOW}  Backup saved: ~/.profile.backup${RESET}"
            modified=1
        fi
    fi
    
    if [ ${modified} -eq 0 ]; then
        echo -e "${YELLOW}⚠ No PATH modifications found${RESET}"
    fi
    echo ""
}

# Remove desktop launcher
remove_launcher() {
    echo -e "${BLUE}[2/4] Removing desktop launcher...${RESET}"
    
    local launcher_path="${HOME}/.local/share/applications/myshell.desktop"
    
    if [ -f "${launcher_path}" ]; then
        rm -f "${launcher_path}"
        echo -e "${GREEN}✓ Desktop launcher removed${RESET}"
    else
        echo -e "${YELLOW}⚠ No desktop launcher found${RESET}"
    fi
    echo ""
}

# Remove configuration
remove_config() {
    echo -e "${BLUE}[3/4] Removing configuration...${RESET}"
    
    read -p "Remove command history? (y/n): " remove_history
    
    if [[ "${remove_history}" =~ ^[Yy]$ ]]; then
        if [ -d "${INSTALL_DIR}/config" ]; then
            # Backup history before removing
            if [ -f "${INSTALL_DIR}/config/.myshell_history" ]; then
                cp "${INSTALL_DIR}/config/.myshell_history" "${HOME}/.myshell_history.backup"
                echo -e "${YELLOW}  History backed up: ~/.myshell_history.backup${RESET}"
            fi
            
            rm -rf "${INSTALL_DIR}/config"
            echo -e "${GREEN}✓ Configuration removed${RESET}"
        else
            echo -e "${YELLOW}⚠ No configuration directory found${RESET}"
        fi
    else
        echo -e "${YELLOW}⚠ Configuration preserved${RESET}"
    fi
    echo ""
}

# Remove temporary files
remove_temp_files() {
    echo -e "${BLUE}[4/4] Removing temporary files...${RESET}"
    
    # Remove any temporary files created by scripts
    rm -f /tmp/tiny-http-*.log
    rm -f /tmp/backup_*
    rm -f /tmp/test_process.txt
    
    echo -e "${GREEN}✓ Temporary files cleaned${RESET}"
    echo ""
}

# Show completion message
show_completion() {
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}║        Uninstallation Completed Successfully!         ║${RESET}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${RESET}\n"
    
    echo -e "${CYAN}What was removed:${RESET}"
    echo "  ✓ PATH modifications"
    echo "  ✓ Desktop launcher"
    echo "  ✓ Configuration files"
    echo "  ✓ Temporary files"
    echo ""
    
    echo -e "${YELLOW}What remains:${RESET}"
    echo "  • Scripts directory: ${INSTALL_DIR}/scripts"
    echo "  • Documentation: ${INSTALL_DIR}/README.md"
    echo "  • Main shell: ${INSTALL_DIR}/myshell.sh"
    echo ""
    
    echo -e "${CYAN}Complete removal:${RESET}"
    echo "  To completely remove all files, run:"
    echo "  rm -rf ${INSTALL_DIR}"
    echo ""
    
    echo -e "${YELLOW}Shell restart required:${RESET}"
    echo "  Run 'source ~/.bashrc' or restart your terminal"
    echo ""
    
    echo -e "${BLUE}Thank you for using Custom Bash Shell Environment!${RESET}"
    echo ""
}

# Main uninstallation process
main() {
    show_banner
    confirm_uninstall
    
    # Run uninstallation steps
    remove_from_path
    remove_launcher
    remove_config
    remove_temp_files
    
    show_completion
}

# Run main function
main

#!/bin/bash

################################################################################
# install.sh - Installation script for Custom Bash Shell Environment
# Usage: ./install.sh
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
    echo -e "${CYAN}║       Custom Bash Shell - Installation Script         ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"
}

# Check dependencies
check_dependencies() {
    echo -e "${BLUE}[1/5] Checking dependencies...${RESET}"
    
    local missing_deps=()
    
    # Required dependencies
    if ! command -v bash &> /dev/null; then
        missing_deps+=("bash")
    fi
    
    # Optional but recommended
    local optional_deps=("curl" "nc" "bc" "jq")
    local missing_optional=()
    
    for dep in "${optional_deps[@]}"; do
        if ! command -v "${dep}" &> /dev/null; then
            missing_optional+=("${dep}")
        fi
    done
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        echo -e "${RED}✗ Missing required dependencies: ${missing_deps[*]}${RESET}"
        exit 1
    fi
    
    if [ ${#missing_optional[@]} -ne 0 ]; then
        echo -e "${YELLOW}⚠ Missing optional dependencies: ${missing_optional[*]}${RESET}"
        echo -e "${YELLOW}  Some features may not work without these packages.${RESET}"
        echo ""
        echo "Install with:"
        echo "  Ubuntu/Debian: sudo apt-get install ${missing_optional[*]}"
        echo "  Fedora/RHEL:   sudo dnf install ${missing_optional[*]}"
        echo "  Arch Linux:    sudo pacman -S ${missing_optional[*]}"
        echo ""
        read -p "Continue anyway? (y/n): " continue_choice
        if [[ ! "${continue_choice}" =~ ^[Yy]$ ]]; then
            exit 0
        fi
    else
        echo -e "${GREEN}✓ All dependencies satisfied${RESET}"
    fi
    echo ""
}

# Make scripts executable
make_executable() {
    echo -e "${BLUE}[2/5] Making scripts executable...${RESET}"
    
    # Main shell
    chmod +x "${INSTALL_DIR}/myshell.sh"
    
    # All scripts in scripts directory
    if [ -d "${INSTALL_DIR}/scripts" ]; then
        chmod +x "${INSTALL_DIR}"/scripts/*.sh
        echo -e "${GREEN}✓ Made all scripts executable${RESET}"
    else
        echo -e "${RED}✗ Scripts directory not found${RESET}"
        exit 1
    fi
    echo ""
}

# Create config directory
setup_config() {
    echo -e "${BLUE}[3/5] Setting up configuration...${RESET}"
    
    # Create config directory
    mkdir -p "${INSTALL_DIR}/config"
    
    # Create history file
    touch "${INSTALL_DIR}/config/.myshell_history"
    
    echo -e "${GREEN}✓ Configuration directory created${RESET}"
    echo ""
}

# Add to PATH (optional)
add_to_path() {
    echo -e "${BLUE}[4/5] Setting up PATH...${RESET}"
    
    # Check if already in PATH
    if echo "${PATH}" | grep -q "${INSTALL_DIR}"; then
        echo -e "${YELLOW}⚠ Already in PATH${RESET}"
        echo ""
        return
    fi
    
    echo "Do you want to add ${SHELL_NAME} to your PATH?"
    echo "This will allow you to run 'myshell.sh' from anywhere."
    read -p "Add to PATH? (y/n): " add_path_choice
    
    if [[ "${add_path_choice}" =~ ^[Yy]$ ]]; then
        # Determine shell config file
        local shell_config=""
        if [ -n "${BASH_VERSION}" ]; then
            shell_config="${HOME}/.bashrc"
        elif [ -n "${ZSH_VERSION}" ]; then
            shell_config="${HOME}/.zshrc"
        else
            shell_config="${HOME}/.profile"
        fi
        
        # Add to PATH
        echo "" >> "${shell_config}"
        echo "# Custom Bash Shell Environment" >> "${shell_config}"
        echo "export PATH=\"\${PATH}:${INSTALL_DIR}\"" >> "${shell_config}"
        
        echo -e "${GREEN}✓ Added to PATH in ${shell_config}${RESET}"
        echo -e "${YELLOW}  Run 'source ${shell_config}' to apply changes${RESET}"
    else
        echo -e "${YELLOW}⚠ Skipped adding to PATH${RESET}"
        echo "  You can run the shell using: ${INSTALL_DIR}/myshell.sh"
    fi
    echo ""
}

# Create desktop launcher (optional)
create_launcher() {
    echo -e "${BLUE}[5/5] Creating launcher...${RESET}"
    
    if [ ! -d "${HOME}/.local/share/applications" ]; then
        echo -e "${YELLOW}⚠ Desktop launcher not supported${RESET}"
        echo ""
        return
    fi
    
    echo "Do you want to create a desktop launcher?"
    read -p "Create launcher? (y/n): " launcher_choice
    
    if [[ "${launcher_choice}" =~ ^[Yy]$ ]]; then
        cat > "${HOME}/.local/share/applications/myshell.desktop" << EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=${SHELL_NAME}
Comment=Custom Bash Shell Environment
Exec=x-terminal-emulator -e ${INSTALL_DIR}/myshell.sh
Icon=utilities-terminal
Terminal=true
Categories=System;TerminalEmulator;
EOF
        
        chmod +x "${HOME}/.local/share/applications/myshell.desktop"
        echo -e "${GREEN}✓ Desktop launcher created${RESET}"
    else
        echo -e "${YELLOW}⚠ Skipped creating launcher${RESET}"
    fi
    echo ""
}

# Display completion message
show_completion() {
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}║          Installation Completed Successfully!         ║${RESET}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${RESET}\n"
    
    echo -e "${CYAN}Installation Summary:${RESET}"
    echo "  Installation Directory: ${INSTALL_DIR}"
    echo "  Number of Scripts: $(ls -1 "${INSTALL_DIR}/scripts" 2>/dev/null | wc -l)"
    echo ""
    
    echo -e "${CYAN}Quick Start:${RESET}"
    echo "  1. Run the shell:"
    echo "     ${INSTALL_DIR}/myshell.sh"
    echo ""
    echo "  2. View help:"
    echo "     Type 'help' in the shell"
    echo ""
    echo "  3. List available scripts:"
    echo "     Type 'list' in the shell"
    echo ""
    
    echo -e "${CYAN}Documentation:${RESET}"
    echo "  README: ${INSTALL_DIR}/README.md"
    echo "  Future Features: ${INSTALL_DIR}/FUTURE_ENHANCEMENTS.md"
    echo ""
    
    echo -e "${YELLOW}Note: If you added to PATH, run 'source ~/.bashrc' first${RESET}"
    echo ""
    
    read -p "Launch ${SHELL_NAME} now? (y/n): " launch_choice
    if [[ "${launch_choice}" =~ ^[Yy]$ ]]; then
        exec "${INSTALL_DIR}/myshell.sh"
    fi
}

# Main installation process
main() {
    show_banner
    
    echo -e "${YELLOW}This script will install Custom Bash Shell Environment${RESET}"
    echo -e "${YELLOW}Installation directory: ${INSTALL_DIR}${RESET}"
    echo ""
    read -p "Continue with installation? (y/n): " continue_install
    
    if [[ ! "${continue_install}" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation cancelled${RESET}"
        exit 0
    fi
    
    echo ""
    
    # Run installation steps
    check_dependencies
    make_executable
    setup_config
    add_to_path
    create_launcher
    
    show_completion
}

# Run main function
main

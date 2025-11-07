#!/bin/bash

################################################################################
# Interactive.sh - Menu-driven interface demonstration
# Usage: Interactive.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Display banner
show_banner() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║          Interactive Menu System v1.0                 ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"
}

# Main menu
show_main_menu() {
    echo -e "${BLUE}╔════════════════════════════════════════╗${RESET}"
    echo -e "${BLUE}║           Main Menu                    ║${RESET}"
    echo -e "${BLUE}╚════════════════════════════════════════╝${RESET}\n"
    echo "  1. System Information"
    echo "  2. File Operations"
    echo "  3. Network Tools"
    echo "  4. Calculator"
    echo "  5. About"
    echo "  6. Exit"
    echo ""
}

# System information submenu
system_info_menu() {
    while true; do
        show_banner
        echo -e "${YELLOW}[System Information]${RESET}\n"
        echo "  1. CPU Info"
        echo "  2. Memory Info"
        echo "  3. Disk Usage"
        echo "  4. Uptime"
        echo "  5. Back to Main Menu"
        echo ""
        read -p "Enter choice (1-5): " choice
        
        case "${choice}" in
            1)
                echo -e "\n${GREEN}[CPU Information]${RESET}"
                lscpu | grep -E "Model name|CPU\(s\):|Thread|Core" || cat /proc/cpuinfo | grep "model name" | head -1
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "\n${GREEN}[Memory Information]${RESET}"
                free -h
                read -p "Press Enter to continue..."
                ;;
            3)
                echo -e "\n${GREEN}[Disk Usage]${RESET}"
                df -h | grep -vE "tmpfs|devtmpfs"
                read -p "Press Enter to continue..."
                ;;
            4)
                echo -e "\n${GREEN}[System Uptime]${RESET}"
                uptime
                read -p "Press Enter to continue..."
                ;;
            5)
                return
                ;;
            *)
                echo -e "${RED}Invalid choice${RESET}"
                sleep 1
                ;;
        esac
    done
}

# File operations submenu
file_operations_menu() {
    while true; do
        show_banner
        echo -e "${YELLOW}[File Operations]${RESET}\n"
        echo "  1. List files in current directory"
        echo "  2. Show current directory"
        echo "  3. Create a test file"
        echo "  4. Search for a file"
        echo "  5. Back to Main Menu"
        echo ""
        read -p "Enter choice (1-5): " choice
        
        case "${choice}" in
            1)
                echo -e "\n${GREEN}[Files in $(pwd)]${RESET}"
                ls -lh
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "\n${GREEN}[Current Directory]${RESET}"
                pwd
                read -p "Press Enter to continue..."
                ;;
            3)
                read -p "Enter filename: " filename
                if [ -n "${filename}" ]; then
                    touch "/tmp/${filename}" 2>/dev/null && echo -e "${GREEN}✓ File created: /tmp/${filename}${RESET}" || echo -e "${RED}✗ Failed to create file${RESET}"
                fi
                read -p "Press Enter to continue..."
                ;;
            4)
                read -p "Enter filename to search: " search_term
                if [ -n "${search_term}" ]; then
                    echo -e "\n${GREEN}[Search Results]${RESET}"
                    find ~ -name "*${search_term}*" -type f 2>/dev/null | head -20
                fi
                read -p "Press Enter to continue..."
                ;;
            5)
                return
                ;;
            *)
                echo -e "${RED}Invalid choice${RESET}"
                sleep 1
                ;;
        esac
    done
}

# Network tools submenu
network_tools_menu() {
    while true; do
        show_banner
        echo -e "${YELLOW}[Network Tools]${RESET}\n"
        echo "  1. Show IP addresses"
        echo "  2. Show active connections"
        echo "  3. Test connectivity (ping)"
        echo "  4. Back to Main Menu"
        echo ""
        read -p "Enter choice (1-4): " choice
        
        case "${choice}" in
            1)
                echo -e "\n${GREEN}[Network Interfaces]${RESET}"
                if command -v ip &> /dev/null; then
                    ip addr show
                else
                    ifconfig
                fi
                read -p "Press Enter to continue..."
                ;;
            2)
                echo -e "\n${GREEN}[Active Connections]${RESET}"
                if command -v ss &> /dev/null; then
                    ss -tuln | head -20
                else
                    netstat -tuln | head -20
                fi
                read -p "Press Enter to continue..."
                ;;
            3)
                read -p "Enter host to ping (default: google.com): " host
                host=${host:-google.com}
                echo -e "\n${GREEN}[Pinging ${host}]${RESET}"
                ping -c 4 "${host}"
                read -p "Press Enter to continue..."
                ;;
            4)
                return
                ;;
            *)
                echo -e "${RED}Invalid choice${RESET}"
                sleep 1
                ;;
        esac
    done
}

# Simple calculator
calculator_menu() {
    show_banner
    echo -e "${YELLOW}[Simple Calculator]${RESET}\n"
    
    read -p "Enter first number: " num1
    read -p "Enter operator (+, -, *, /): " op
    read -p "Enter second number: " num2
    
    if [[ ! "${num1}" =~ ^-?[0-9]+\.?[0-9]*$ ]] || [[ ! "${num2}" =~ ^-?[0-9]+\.?[0-9]*$ ]]; then
        echo -e "${RED}Invalid numbers${RESET}"
        read -p "Press Enter to continue..."
        return
    fi
    
    case "${op}" in
        "+")
            result=$(echo "${num1} + ${num2}" | bc 2>/dev/null || echo $((num1 + num2)))
            echo -e "\n${GREEN}Result: ${num1} + ${num2} = ${result}${RESET}"
            ;;
        "-")
            result=$(echo "${num1} - ${num2}" | bc 2>/dev/null || echo $((num1 - num2)))
            echo -e "\n${GREEN}Result: ${num1} - ${num2} = ${result}${RESET}"
            ;;
        "*")
            result=$(echo "${num1} * ${num2}" | bc 2>/dev/null || echo $((num1 * num2)))
            echo -e "\n${GREEN}Result: ${num1} × ${num2} = ${result}${RESET}"
            ;;
        "/")
            if [ "${num2}" = "0" ]; then
                echo -e "${RED}Error: Division by zero${RESET}"
            else
                result=$(echo "scale=4; ${num1} / ${num2}" | bc 2>/dev/null || echo $((num1 / num2)))
                echo -e "\n${GREEN}Result: ${num1} ÷ ${num2} = ${result}${RESET}"
            fi
            ;;
        *)
            echo -e "${RED}Invalid operator${RESET}"
            ;;
    esac
    
    read -p "Press Enter to continue..."
}

# About screen
show_about() {
    show_banner
    echo -e "${YELLOW}[About]${RESET}\n"
    echo -e "${GREEN}Interactive Menu System${RESET}"
    echo "Version: 1.0.0"
    echo "Author: Senior Developer"
    echo ""
    echo "This is a demonstration of a menu-driven interface"
    echo "built using Bash scripting."
    echo ""
    echo "Features:"
    echo "  • System information display"
    echo "  • File operations"
    echo "  • Network tools"
    echo "  • Simple calculator"
    echo ""
    read -p "Press Enter to continue..."
}

# Main loop
main() {
    while true; do
        show_banner
        show_main_menu
        read -p "Enter choice (1-6): " choice
        
        case "${choice}" in
            1)
                system_info_menu
                ;;
            2)
                file_operations_menu
                ;;
            3)
                network_tools_menu
                ;;
            4)
                calculator_menu
                ;;
            5)
                show_about
                ;;
            6)
                echo -e "\n${GREEN}Thank you for using Interactive Menu System!${RESET}"
                exit 0
                ;;
            *)
                echo -e "${RED}Invalid choice. Please select 1-6${RESET}"
                sleep 1
                ;;
        esac
    done
}

# Run main function
main

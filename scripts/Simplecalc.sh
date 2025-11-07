#!/bin/bash

################################################################################
# Simplecalc.sh - Interactive calculator with all basic operations
# Usage: Simplecalc.sh
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Validate number function
is_number() {
    [[ "$1" =~ ^-?[0-9]+\.?[0-9]*$ ]]
}

# Display banner
show_banner() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║       Simple Calculator v1.0               ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════╝${RESET}\n"
}

# Display menu
show_menu() {
    echo -e "${BLUE}Select an operation:${RESET}"
    echo "  1. Addition (+)"
    echo "  2. Subtraction (-)"
    echo "  3. Multiplication (×)"
    echo "  4. Division (÷)"
    echo "  5. Power (^)"
    echo "  6. Square Root (√)"
    echo "  7. Modulo (%)"
    echo "  8. Exit"
    echo ""
}

# Perform calculation
calculate() {
    local operation="$1"
    local num1="$2"
    local num2="$3"
    local result=""
    
    if command -v bc &> /dev/null; then
        case "${operation}" in
            1|"+")
                result=$(echo "${num1} + ${num2}" | bc)
                echo -e "${GREEN}${num1} + ${num2} = ${result}${RESET}"
                ;;
            2|"-")
                result=$(echo "${num1} - ${num2}" | bc)
                echo -e "${GREEN}${num1} - ${num2} = ${result}${RESET}"
                ;;
            3|"*"|"×")
                result=$(echo "${num1} * ${num2}" | bc)
                echo -e "${GREEN}${num1} × ${num2} = ${result}${RESET}"
                ;;
            4|"/"|"÷")
                if [ "${num2}" = "0" ] || [ "${num2}" = "0.0" ]; then
                    echo -e "${RED}Error: Division by zero${RESET}"
                    return 1
                fi
                result=$(echo "scale=4; ${num1} / ${num2}" | bc)
                echo -e "${GREEN}${num1} ÷ ${num2} = ${result}${RESET}"
                ;;
            5|"^")
                result=$(echo "${num1} ^ ${num2}" | bc)
                echo -e "${GREEN}${num1} ^ ${num2} = ${result}${RESET}"
                ;;
            6|"√")
                if (( $(echo "${num1} < 0" | bc -l) )); then
                    echo -e "${RED}Error: Cannot calculate square root of negative number${RESET}"
                    return 1
                fi
                result=$(echo "scale=4; sqrt(${num1})" | bc)
                echo -e "${GREEN}√${num1} = ${result}${RESET}"
                ;;
            7|"%")
                result=$(echo "${num1} % ${num2}" | bc)
                echo -e "${GREEN}${num1} % ${num2} = ${result}${RESET}"
                ;;
            *)
                echo -e "${RED}Invalid operation${RESET}"
                return 1
                ;;
        esac
    else
        echo -e "${YELLOW}Warning: bc not installed, using integer arithmetic${RESET}"
        case "${operation}" in
            1|"+") result=$((num1 + num2)); echo -e "${GREEN}${num1} + ${num2} = ${result}${RESET}" ;;
            2|"-") result=$((num1 - num2)); echo -e "${GREEN}${num1} - ${num2} = ${result}${RESET}" ;;
            3|"*"|"×") result=$((num1 * num2)); echo -e "${GREEN}${num1} × ${num2} = ${result}${RESET}" ;;
            4|"/"|"÷") 
                if [ "${num2}" -eq 0 ]; then
                    echo -e "${RED}Error: Division by zero${RESET}"
                    return 1
                fi
                result=$((num1 / num2))
                echo -e "${GREEN}${num1} ÷ ${num2} = ${result}${RESET}"
                ;;
            7|"%") result=$((num1 % num2)); echo -e "${GREEN}${num1} % ${num2} = ${result}${RESET}" ;;
            *)
                echo -e "${RED}Operation not supported without bc${RESET}"
                return 1
                ;;
        esac
    fi
}

# Main loop
main() {
    show_banner
    
    while true; do
        show_menu
        read -p "Enter choice (1-8): " choice
        
        case "${choice}" in
            8)
                echo -e "${GREEN}Thank you for using Simple Calculator!${RESET}"
                exit 0
                ;;
            6)
                # Square root only needs one number
                read -p "Enter number: " num1
                
                if ! is_number "${num1}"; then
                    echo -e "${RED}Error: Invalid number${RESET}\n"
                    continue
                fi
                
                calculate "${choice}" "${num1}"
                ;;
            1|2|3|4|5|7)
                read -p "Enter first number: " num1
                read -p "Enter second number: " num2
                
                if ! is_number "${num1}"; then
                    echo -e "${RED}Error: '${num1}' is not a valid number${RESET}\n"
                    continue
                fi
                
                if ! is_number "${num2}"; then
                    echo -e "${RED}Error: '${num2}' is not a valid number${RESET}\n"
                    continue
                fi
                
                calculate "${choice}" "${num1}" "${num2}"
                ;;
            *)
                echo -e "${RED}Invalid choice. Please select 1-8${RESET}"
                ;;
        esac
        
        echo ""
        read -p "Press Enter to continue..."
        show_banner
    done
}

# Run main function
main

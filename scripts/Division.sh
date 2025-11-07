#!/bin/bash

################################################################################
# Division.sh - Divide two numbers with input validation
# Usage: Division.sh <number1> <number2>
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
RESET="\033[0m"

# Validate number function
is_number() {
    [[ "$1" =~ ^-?[0-9]+\.?[0-9]*$ ]]
}

echo -e "${BLUE}=== Division Calculator ===${RESET}\n"

# Check if arguments are provided
if [ $# -eq 0 ]; then
    read -p "Enter dividend (first number): " NUM1
    read -p "Enter divisor (second number): " NUM2
elif [ $# -eq 2 ]; then
    NUM1="$1"
    NUM2="$2"
else
    echo -e "${RED}Error: Invalid number of arguments${RESET}"
    echo "Usage: $0 <number1> <number2>"
    echo "Or run without arguments for interactive mode"
    exit 1
fi

# Validate inputs
if ! is_number "${NUM1}"; then
    echo -e "${RED}Error: '${NUM1}' is not a valid number${RESET}"
    exit 1
fi

if ! is_number "${NUM2}"; then
    echo -e "${RED}Error: '${NUM2}' is not a valid number${RESET}"
    exit 1
fi

# Check for division by zero
if [ "${NUM2}" = "0" ] || [ "${NUM2}" = "0.0" ]; then
    echo -e "${RED}Error: Division by zero is not allowed${RESET}"
    exit 1
fi

# Perform division
if command -v bc &> /dev/null; then
    RESULT=$(echo "scale=4; ${NUM1} / ${NUM2}" | bc)
else
    # Fallback to integer arithmetic (note: no decimals)
    RESULT=$((NUM1 / NUM2))
    echo -e "${RED}Warning: bc not found, using integer division${RESET}"
fi

# Display result
echo -e "${GREEN}${NUM1} ÷ ${NUM2} = ${RESULT}${RESET}"

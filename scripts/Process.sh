#!/bin/bash

################################################################################
# Process.sh - Command chaining example
# Usage: Process.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

echo -e "${CYAN}╔════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║      Command Chaining Demonstration        ║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${RESET}\n"

echo -e "${BLUE}This script demonstrates various command chaining techniques.${RESET}\n"

# Example 1: Sequential execution
echo -e "${YELLOW}[1] Sequential Execution (command1 ; command2)${RESET}"
echo "Creating test file ; Checking if file exists"
touch /tmp/test_process.txt ; [ -f /tmp/test_process.txt ] && echo -e "${GREEN}✓ File created successfully${RESET}"
echo ""

# Example 2: AND operator
echo -e "${YELLOW}[2] AND Operator (command1 && command2)${RESET}"
echo "Checking if file exists AND displaying its info"
[ -f /tmp/test_process.txt ] && ls -lh /tmp/test_process.txt && echo -e "${GREEN}✓ Commands executed${RESET}"
echo ""

# Example 3: OR operator
echo -e "${YELLOW}[3] OR Operator (command1 || command2)${RESET}"
echo "Checking if non-existent file exists OR showing error"
[ -f /tmp/nonexistent.txt ] || echo -e "${GREEN}✓ File doesn't exist (as expected)${RESET}"
echo ""

# Example 4: Pipes
echo -e "${YELLOW}[4] Pipes (command1 | command2 | command3)${RESET}"
echo "Finding processes | Filtering | Counting"
ps aux | grep bash | wc -l | xargs -I {} echo -e "${GREEN}Number of bash processes: {}${RESET}"
echo ""

# Example 5: Command substitution
echo -e "${YELLOW}[5] Command Substitution \$(command)${RESET}"
CURRENT_USER=$(whoami)
USER_HOME=$(eval echo ~${CURRENT_USER})
echo -e "${GREEN}Current user: ${CURRENT_USER}${RESET}"
echo -e "${GREEN}Home directory: ${USER_HOME}${RESET}"
echo ""

# Example 6: Background execution
echo -e "${YELLOW}[6] Background Execution (command &)${RESET}"
echo "Starting a background sleep process..."
(sleep 2 && echo -e "${GREEN}✓ Background process completed${RESET}") &
BG_PID=$!
echo "Background process PID: ${BG_PID}"
echo "Main script continues..."
echo ""

# Example 7: Complex chaining
echo -e "${YELLOW}[7] Complex Chaining${RESET}"
echo "Multiple operations in sequence:"
{
    echo "  Step 1: Writing to file..." && echo "Test data" > /tmp/test_process.txt
    echo "  Step 2: Reading from file..." && cat /tmp/test_process.txt
    echo "  Step 3: Appending to file..." && echo "More data" >> /tmp/test_process.txt
    echo "  Step 4: Counting lines..." && wc -l /tmp/test_process.txt | awk '{print "  Lines: " $1}'
} && echo -e "${GREEN}✓ All operations completed${RESET}"
echo ""

# Wait for background processes
echo "Waiting for background processes..."
wait
echo ""

# Cleanup
echo -e "${YELLOW}[8] Cleanup${RESET}"
rm -f /tmp/test_process.txt && echo -e "${GREEN}✓ Temporary file removed${RESET}"
echo ""

echo -e "${CYAN}╔════════════════════════════════════════════╗${RESET}"
echo -e "${CYAN}║      Demonstration Complete!               ║${RESET}"
echo -e "${CYAN}╚════════════════════════════════════════════╝${RESET}"

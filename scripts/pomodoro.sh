#!/bin/bash

################################################################################
# pomodoro.sh - Productivity timer with 25-minute work intervals
# Usage: pomodoro.sh [work_minutes] [break_minutes]
################################################################################

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

# Default durations (in minutes)
WORK_DURATION=${1:-25}
BREAK_DURATION=${2:-5}
LONG_BREAK_DURATION=15
POMODOROS_BEFORE_LONG_BREAK=4

# Convert to seconds
WORK_SECONDS=$((WORK_DURATION * 60))
BREAK_SECONDS=$((BREAK_DURATION * 60))
LONG_BREAK_SECONDS=$((LONG_BREAK_DURATION * 60))

# Counter for completed pomodoros
POMODORO_COUNT=0

# Display banner
show_banner() {
    clear
    echo -e "${CYAN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${CYAN}║            🍅 Pomodoro Timer v1.0                     ║${RESET}"
    echo -e "${CYAN}╚════════════════════════════════════════════════════════╝${RESET}\n"
}

# Format seconds to MM:SS
format_time() {
    local total_seconds=$1
    local minutes=$((total_seconds / 60))
    local seconds=$((total_seconds % 60))
    printf "%02d:%02d" ${minutes} ${seconds}
}

# Play a beep sound (if available)
play_sound() {
    if command -v paplay &> /dev/null && [ -f /usr/share/sounds/freedesktop/stereo/complete.oga ]; then
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga 2>/dev/null &
    elif command -v aplay &> /dev/null && [ -f /usr/share/sounds/alsa/Front_Center.wav ]; then
        aplay /usr/share/sounds/alsa/Front_Center.wav 2>/dev/null &
    else
        # Fallback to terminal bell
        echo -ne '\a'
    fi
}

# Countdown timer
countdown() {
    local duration=$1
    local message=$2
    local color=$3
    
    for ((i=duration; i>0; i--)); do
        show_banner
        echo -e "${color}${message}${RESET}\n"
        echo -e "${BLUE}Time Remaining:${RESET} $(format_time ${i})"
        echo ""
        echo -e "${YELLOW}Completed Pomodoros:${RESET} ${POMODORO_COUNT}"
        echo ""
        echo -e "${CYAN}Press Ctrl+C to stop${RESET}"
        
        # Progress bar
        local total=$duration
        local percent=$((100 * (total - i) / total))
        local filled=$((percent / 2))
        echo -ne "\n["
        for ((j=0; j<50; j++)); do
            if [ $j -lt $filled ]; then
                echo -ne "▓"
            else
                echo -ne "░"
            fi
        done
        echo -ne "] ${percent}%\r"
        
        sleep 1
    done
    
    # Timer complete
    play_sound
    show_banner
    echo -e "${GREEN}✓ ${message} - Complete!${RESET}\n"
    sleep 2
}

# Display instructions
show_instructions() {
    show_banner
    echo -e "${BLUE}Welcome to the Pomodoro Timer!${RESET}\n"
    echo "The Pomodoro Technique:"
    echo "  1. Work for ${WORK_DURATION} minutes (Focus time)"
    echo "  2. Take a ${BREAK_DURATION}-minute break"
    echo "  3. After ${POMODOROS_BEFORE_LONG_BREAK} pomodoros, take a ${LONG_BREAK_DURATION}-minute break"
    echo ""
    echo -e "${YELLOW}Configuration:${RESET}"
    echo "  Work Duration: ${WORK_DURATION} minutes"
    echo "  Short Break: ${BREAK_DURATION} minutes"
    echo "  Long Break: ${LONG_BREAK_DURATION} minutes"
    echo ""
    read -p "Press Enter to start your first pomodoro..."
}

# Main pomodoro loop
main() {
    # Trap Ctrl+C
    trap cleanup SIGINT
    
    show_instructions
    
    while true; do
        # Work session
        countdown ${WORK_SECONDS} "🍅 WORK TIME - Stay Focused!" "${RED}"
        POMODORO_COUNT=$((POMODORO_COUNT + 1))
        
        # Check if it's time for a long break
        if [ $((POMODORO_COUNT % POMODOROS_BEFORE_LONG_BREAK)) -eq 0 ]; then
            echo -e "${GREEN}Great job! Time for a long break!${RESET}"
            read -p "Press Enter to start long break..."
            countdown ${LONG_BREAK_SECONDS} "☕ LONG BREAK - Relax and Recharge!" "${CYAN}"
        else
            echo -e "${GREEN}Well done! Time for a short break!${RESET}"
            read -p "Press Enter to start break..."
            countdown ${BREAK_SECONDS} "☕ BREAK TIME - Relax!" "${CYAN}"
        fi
        
        # Ask if user wants to continue
        show_banner
        echo -e "${GREEN}Pomodoro #${POMODORO_COUNT} completed!${RESET}\n"
        read -p "Start another pomodoro? (y/n): " continue_choice
        
        if [[ ! "${continue_choice}" =~ ^[Yy]$ ]]; then
            break
        fi
    done
    
    cleanup
}

# Cleanup function
cleanup() {
    show_banner
    echo -e "${GREEN}╔════════════════════════════════════════════════════════╗${RESET}"
    echo -e "${GREEN}║              Session Summary                           ║${RESET}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════╝${RESET}\n"
    echo -e "${BLUE}Completed Pomodoros:${RESET} ${POMODORO_COUNT}"
    echo -e "${BLUE}Total Focus Time:${RESET} $((POMODORO_COUNT * WORK_DURATION)) minutes"
    echo ""
    echo -e "${YELLOW}Keep up the great work! 🎉${RESET}\n"
    exit 0
}

# Run main function
main

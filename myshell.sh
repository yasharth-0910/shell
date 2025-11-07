#!/bin/bash

# Configuration
SHELL_NAME="MyShell"
SHELL_VERSION="1.0.0"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/scripts" && pwd)"
CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/config" && pwd)"
HISTORY_FILE="${CONFIG_DIR}/.myshell_history"
PROMPT_COLOR="\033[1;36m"
ERROR_COLOR="\033[1;31m"
SUCCESS_COLOR="\033[1;32m"
RESET_COLOR="\033[0m"

# Create config directory if it doesn't exist
mkdir -p "${CONFIG_DIR}"
touch "${HISTORY_FILE}"

# Signal handlers
trap 'echo -e "\n${ERROR_COLOR}Use 'exit' command to quit${RESET_COLOR}"' SIGINT
trap 'cleanup_and_exit' SIGTERM

# Cleanup function
cleanup_and_exit() {
    echo -e "\n${SUCCESS_COLOR}Goodbye from ${SHELL_NAME}!${RESET_COLOR}"
    exit 0
}

# Display welcome banner
show_banner() {
    clear
    echo -e "${PROMPT_COLOR}"
    echo "╔════════════════════════════════════════════════════════════╗"
    echo "║                                                            ║"
    echo "║           ${SHELL_NAME} v${SHELL_VERSION} - Custom Shell Environment         ║"
    echo "║                                                            ║"
    echo "║  Type 'help' for available commands                       ║"
    echo "║  Type 'list' to see all utility scripts                   ║"
    echo "║  Type 'exit' to quit                                      ║"
    echo "║                                                            ║"
    echo "╚════════════════════════════════════════════════════════════╝"
    echo -e "${RESET_COLOR}\n"
}

# Built-in help command
show_help() {
    echo -e "${PROMPT_COLOR}=== ${SHELL_NAME} Help ===${RESET_COLOR}\n"
    echo "Built-in Commands:"
    echo "  help                - Show this help message"
    echo "  list                - List all available utility scripts"
    echo "  cd <directory>      - Change directory"
    echo "  pwd                 - Print working directory"
    echo "  clear               - Clear the screen"
    echo "  history             - Show command history"
    echo "  exit                - Exit the shell"
    echo ""
    echo "Utility Script Categories:"
    echo "  System Administration - Monitoring, backup, hardware info"
    echo "  Network Services      - HTTP server, network info"
    echo "  Math Operations       - Calculator, arithmetic operations"
    echo "  Interactive Tools     - Pomodoro timer, menus"
    echo "  Miscellaneous         - Weather, Reddit, colors"
    echo ""
    echo "To run a script, simply type its name (with or without .sh extension)"
    echo "Example: DirectorySize /home/user/Documents"
    echo ""
}

# List all available scripts
list_scripts() {
    echo -e "${PROMPT_COLOR}=== Available Utility Scripts ===${RESET_COLOR}\n"
    
    if [ ! -d "${SCRIPT_DIR}" ] || [ -z "$(ls -A "${SCRIPT_DIR}" 2>/dev/null)" ]; then
        echo -e "${ERROR_COLOR}No scripts found in ${SCRIPT_DIR}${RESET_COLOR}"
        return
    fi
    
    echo "System Administration:"
    for script in DirectorySize.sh Test-File.sh Server-Health.sh CPU.sh Disk-Space.sh \
                  CollectNetworkInfo.sh RemoteBackup.sh HardwareInfo.sh Get-Temperature.sh; do
        [ -f "${SCRIPT_DIR}/${script}" ] && echo "  - ${script}"
    done
    
    echo -e "\nNetwork Services:"
    for script in tiny-http.sh; do
        [ -f "${SCRIPT_DIR}/${script}" ] && echo "  - ${script}"
    done
    
    echo -e "\nMathematical Operations:"
    for script in Addition.sh Subtraction.sh Multiplication.sh Division.sh Simplecalc.sh; do
        [ -f "${SCRIPT_DIR}/${script}" ] && echo "  - ${script}"
    done
    
    echo -e "\nInteractive Utilities:"
    for script in Hello.sh Process.sh Interactive.sh pomodoro.sh; do
        [ -f "${SCRIPT_DIR}/${script}" ] && echo "  - ${script}"
    done
    
    echo -e "\nMiscellaneous:"
    for script in weather.sh RedditTop.sh Colorful.sh; do
        [ -f "${SCRIPT_DIR}/${script}" ] && echo "  - ${script}"
    done
    echo ""
}

# Show command history
show_history() {
    if [ -f "${HISTORY_FILE}" ]; then
        echo -e "${PROMPT_COLOR}=== Command History ===${RESET_COLOR}"
        cat -n "${HISTORY_FILE}" | tail -20
    else
        echo -e "${ERROR_COLOR}No history available${RESET_COLOR}"
    fi
}

# Add command to history
add_to_history() {
    echo "$1" >> "${HISTORY_FILE}"
}

# Execute script from scripts directory
execute_script() {
    local script_name="$1"
    shift
    local script_args="$@"
    
    # Add .sh extension if not present
    if [[ ! "${script_name}" =~ \.sh$ ]]; then
        script_name="${script_name}.sh"
    fi
    
    local script_path="${SCRIPT_DIR}/${script_name}"
    
    if [ -f "${script_path}" ]; then
        if [ -x "${script_path}" ]; then
            bash "${script_path}" ${script_args}
        else
            echo -e "${ERROR_COLOR}Error: Script ${script_name} is not executable${RESET_COLOR}"
            echo "Run: chmod +x ${script_path}"
        fi
    else
        echo -e "${ERROR_COLOR}Error: Script '${script_name}' not found${RESET_COLOR}"
        echo "Type 'list' to see available scripts"
        return 1
    fi
}

# Parse and execute command
execute_command() {
    local cmd="$1"
    shift
    local args="$@"
    
    case "${cmd}" in
        "help"|"--help"|"-h")
            show_help
            ;;
        "list"|"ls-scripts")
            list_scripts
            ;;
        "cd")
            if [ -z "$args" ]; then
                cd ~ || echo -e "${ERROR_COLOR}Failed to change directory${RESET_COLOR}"
            else
                cd "$args" 2>/dev/null || echo -e "${ERROR_COLOR}cd: ${args}: No such file or directory${RESET_COLOR}"
            fi
            ;;
        "pwd")
            pwd
            ;;
        "clear")
            clear
            ;;
        "history")
            show_history
            ;;
        "exit"|"quit")
            cleanup_and_exit
            ;;
        "")
            # Empty command, do nothing
            ;;
        *)
            # Try to execute as a script
            execute_script "${cmd}" ${args}
            local exit_code=$?
            
            # If script not found, try system command
            if [ $exit_code -ne 0 ]; then
                if command -v "${cmd}" &> /dev/null; then
                    ${cmd} ${args}
                fi
            fi
            ;;
    esac
}

# Main shell loop
main() {
    show_banner
    
    while true; do
        # Display prompt
        echo -ne "${PROMPT_COLOR}${SHELL_NAME}${RESET_COLOR}:${SUCCESS_COLOR}$(pwd)${RESET_COLOR}$ "
        
        # Read user input
        read -r input
        
        # Skip empty input
        [ -z "${input}" ] && continue
        
        # Add to history
        add_to_history "${input}"
        
        # Execute command
        execute_command ${input}
        
        echo ""
    done
}

# Run main function
main

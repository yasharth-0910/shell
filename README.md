# 🐚 Custom Bash Shell Environment

<div align="center">

![Bash](https://img.shields.io/badge/Bash-4.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform](https://img.shields.io/badge/Platform-Linux%20%7C%20Unix%20%7C%20WSL2%20%7C%20macOS-lightgrey.svg)
![Windows](https://img.shields.io/badge/Windows-WSL2%20%7C%20Docker-blue.svg)

A professional, feature-rich custom shell environment with 18 utility scripts for system administration, networking, and interactive computing.

**✅ Now Windows Compatible via WSL2 & Docker!**

[Features](#-features) • [Installation](#-installation) • [Windows Setup](#-windows-users) • [Usage](#-usage) • [Scripts](#-available-scripts) • [Documentation](#-documentation)

</div>

---

## 📋 Table of Contents

- [Overview](#-overview)
- [Features](#-features)
- [Technology Stack](#-technology-stack)
- [Installation](#-installation)
- [Quick Start](#-quick-start)
- [Usage](#-usage)
- [Available Scripts](#-available-scripts)
- [Configuration](#-configuration)
- [Examples](#-examples)
- [Troubleshooting](#-troubleshooting)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎯 Overview

This project implements a custom shell environment built entirely in Bash, demonstrating core operating system concepts including process management, file systems, and network programming. The shell provides a user-friendly interface with built-in commands and integrates 20+ utility scripts for various system administration and development tasks.

**Key Highlights:**
- 🚀 Lightweight and fast
- 🛠️ 18 carefully selected utility scripts organized by category
- 🎨 Colorful, interactive interface
- 📝 Command history support
- 🔧 Easy to extend and customize
- 📚 Educational resource for learning shell scripting
- 💻 **Cross-platform: Linux, macOS, WSL2, Docker**
- 🪟 **Windows compatible via WSL2 or Docker**

---

## ✨ Features

### Built-in Commands
- **Navigation**: `cd`, `pwd`, `clear`
- **Help System**: `help`, `list`
- **History**: `history` (stores command history)
- **Exit**: `exit`, `quit`

### Script Categories

#### 🖥️ System Administration (9 scripts)
- **DirectorySize.sh**: Report directory size analysis
- **Test-File.sh**: File/directory status and permissions checker
- **Server-Health.sh**: System health monitoring (CPU, memory, disk)
- **CPU.sh**: CPU usage monitoring with alerts
- **Disk-Space.sh**: Disk space monitoring with thresholds
- **CollectNetworkInfo.sh**: Network configuration information
- **RemoteBackup.sh**: Remote backup via SCP
- **HardwareInfo.sh**: Hardware information display
- **Get-Temperature.sh**: CPU temperature monitoring

#### 🌐 Network Services (1 script)
- **tiny-http.sh**: Minimal HTTP server using netcat

#### 🔢 Mathematical Operations (5 scripts)
- **Addition.sh**: Add two numbers
- **Subtraction.sh**: Subtract two numbers
- **Multiplication.sh**: Multiply two numbers
- **Division.sh**: Divide two numbers (with zero check)
- **Simplecalc.sh**: Interactive calculator with all operations

#### 🎮 Interactive Utilities (1 script)
- **Hello.sh**: Basic I/O demonstration

#### 🌤️ Miscellaneous (2 scripts)
- **weather.sh**: Weather information display
- **RedditTop.sh**: Top Reddit posts viewer

---

## 🔧 Technology Stack

- **Language**: Bash 4.0+
- **Tools**: netcat, curl, bc, coreutils
- **Platform**: Linux/Unix systems, WSL2, Docker, macOS
- **Dependencies**: Optional (jq, lm-sensors, bc)

---

## 💻 Platform Support

| Platform | Status | Method |
|----------|--------|--------|
| **Linux** | ✅ Full Support | Native |
| **WSL2 (Windows)** | ✅ Full Support | Recommended for Windows |
| **Docker** | ✅ Full Support | Cross-platform |
| **macOS** | ⚠️ Mostly Works | Native (some limitations) |
| **Git Bash (Windows)** | ⚠️ Partial | Math scripts only |

### 🪟 Windows Users

**See [WINDOWS_SETUP.md](WINDOWS_SETUP.md) for detailed instructions!**

Quick start for Windows:
```powershell
# Option 1: WSL2 (Recommended - Full Support)
wsl --install
# Then open Ubuntu and follow Linux installation

# Option 2: Docker (Full Support)
docker build -t myshell .
docker run -it myshell

# Option 3: Git Bash (Partial Support - Math scripts only)
bash myshell.sh
```

---

## 📥 Installation

### Linux/macOS/WSL2

#### Prerequisites

Ensure you have the following installed:
```bash
# Check Bash version (requires 4.0+)
bash --version

# Install required tools (Ubuntu/Debian/WSL2)
sudo apt-get update
sudo apt-get install curl netcat bc coreutils

# Optional tools for enhanced functionality
sudo apt-get install jq lm-sensors
```

For other distributions:
```bash
# Fedora/RHEL
sudo dnf install curl nc bc coreutils

# Arch Linux
sudo pacman -S curl gnu-netcat bc coreutils

# macOS
brew install bash curl netcat bc coreutils
```

#### Automated Installation

```bash
# Clone or download the project
git clone https://github.com/yourusername/custom-bash-shell.git
cd custom-bash-shell

# Run the installation script
chmod +x install.sh
./install.sh
```

#### Manual Installation

```bash
# Download and extract the project
cd /path/to/custom-bash-shell

# Make scripts executable
chmod +x myshell.sh
chmod +x scripts/*.sh

# Optional: Add to PATH
echo 'export PATH="$PATH:/path/to/custom-bash-shell"' >> ~/.bashrc
source ~/.bashrc
```

---

## 🚀 Quick Start

### Starting the Shell

```bash
# Run from the project directory
./myshell.sh

# Or if added to PATH
myshell.sh
```

### First Steps

Once the shell is running:

```bash
# View help
help

# List all available scripts
list

# Run a script
DirectorySize /home/user/Documents

# Use tab completion (built-in bash feature)
Server-<TAB>

# Exit the shell
exit
```

---

## 📖 Usage

### Running Scripts

Scripts can be run in multiple ways:

```bash
# Method 1: With .sh extension
DirectorySize.sh /path/to/directory

# Method 2: Without extension
DirectorySize /path/to/directory

# Method 3: With arguments
CPU 85

# Method 4: Interactive mode (some scripts)
Simplecalc
```

### Built-in Commands

```bash
# Change directory
cd /home/user/documents

# Print working directory
pwd

# Clear screen
clear

# Show command history
history

# Exit shell
exit
```

---

## 📚 Available Scripts

### System Administration Scripts

#### DirectorySize.sh
```bash
# Usage
DirectorySize.sh [directory_path]

# Examples
DirectorySize.sh /home/user
DirectorySize.sh .
DirectorySize.sh /var/log
```

#### Server-Health.sh
```bash
# Check server health
Server-Health.sh

# Output includes:
# - System uptime
# - Load average
# - Memory usage
# - Disk usage
# - Top processes
```

#### CPU.sh
```bash
# Monitor CPU with default threshold (80%)
CPU.sh

# Custom threshold
CPU.sh 90
```

#### Disk-Space.sh
```bash
# Monitor disk space (default 80% threshold)
Disk-Space.sh

# Custom threshold
Disk-Space.sh 70
```

#### RemoteBackup.sh
```bash
# Backup to remote server
RemoteBackup.sh /path/to/backup user@remote.server:/backup/location

# Example
RemoteBackup.sh ~/Documents backup@192.168.1.100:/backups/
```

### Network Services Scripts

#### tiny-http.sh
```bash
# Start server on default port (8080)
tiny-http.sh

# Custom port and document root
tiny-http.sh 3000 /path/to/www

# Access in browser
# http://localhost:8080
```

### Mathematical Operations Scripts

#### Simplecalc.sh
```bash
# Interactive calculator
Simplecalc.sh

# Operations available:
# 1. Addition
# 2. Subtraction
# 3. Multiplication
# 4. Division
# 5. Power
# 6. Square Root
# 7. Modulo
```

#### Individual Operations
```bash
# Addition
Addition.sh 10 20
# Output: 10 + 20 = 30

# Division
Division.sh 100 5
# Output: 100 ÷ 5 = 20
```

### Interactive Utilities Scripts

#### pomodoro.sh
```bash
# Default timing (25 min work, 5 min break)
pomodoro.sh

# Custom timing
pomodoro.sh 30 10
# 30 min work, 10 min break
```

#### Interactive.sh
```bash
# Launch interactive menu
Interactive.sh

# Features:
# - System information
# - File operations
# - Network tools
# - Calculator
```

### Miscellaneous Scripts

#### weather.sh
```bash
# Auto-detect location
weather.sh

# Specific city
weather.sh London
weather.sh "New York"
```

#### RedditTop.sh
```bash
# Top posts from r/all
RedditTop.sh

# Specific subreddit
RedditTop.sh programming
RedditTop.sh linux
```

---

## ⚙️ Configuration

### Shell Configuration

Configuration files are stored in `config/`:
- `.myshell_history`: Command history

### Customizing the Shell

Edit `myshell.sh` to customize:

```bash
# Change shell name
SHELL_NAME="MyShell"

# Change prompt colors
PROMPT_COLOR="\033[1;36m"  # Cyan
ERROR_COLOR="\033[1;31m"   # Red
SUCCESS_COLOR="\033[1;32m" # Green
```

### Environment Variables

```bash
# Set in your ~/.bashrc
export MYSHELL_HOME="/path/to/custom-bash-shell"
export MYSHELL_SCRIPTS="${MYSHELL_HOME}/scripts"
```

---

## 💡 Examples

### Example 1: System Health Check

```bash
# Start the shell
./myshell.sh

# Check system health
Server-Health

# Monitor CPU usage
CPU 75

# Check disk space
Disk-Space 80
```

### Example 2: Remote Backup Workflow

```bash
# Check directory size first
DirectorySize ~/important_data

# Backup to remote server
RemoteBackup ~/important_data user@backup-server:/backups/

# Verify on remote
CollectNetworkInfo
```

### Example 3: Development Server

```bash
# Start HTTP server for local development
tiny-http 3000 ~/myproject/public

# In another terminal, test it
curl http://localhost:3000
```

### Example 4: Productivity Session

```bash
# Start a pomodoro session
pomodoro 25 5

# Check weather during break
weather

# Browse Reddit for inspiration
RedditTop programming
```

---

## 🐛 Troubleshooting

### Common Issues

#### Issue: Scripts not executable
```bash
# Solution: Make scripts executable
chmod +x scripts/*.sh
chmod +x myshell.sh
```

#### Issue: Command not found
```bash
# Solution: Ensure you're in the shell or check PATH
./myshell.sh
# OR
export PATH="$PATH:/path/to/custom-bash-shell"
```

#### Issue: netcat not found (tiny-http.sh)
```bash
# Solution: Install netcat
sudo apt-get install netcat  # Ubuntu/Debian
sudo dnf install nc          # Fedora/RHEL
```

#### Issue: bc not found (calculator scripts)
```bash
# Solution: Install bc
sudo apt-get install bc      # Ubuntu/Debian
sudo dnf install bc          # Fedora/RHEL
```

#### Issue: jq not found (RedditTop.sh)
```bash
# Solution: Install jq for better JSON parsing
sudo apt-get install jq      # Ubuntu/Debian
sudo dnf install jq          # Fedora/RHEL
```

### Debug Mode

Enable debug mode for troubleshooting:
```bash
# Run script with -x flag
bash -x scripts/Server-Health.sh
```

---

## 📂 Project Structure

```
custom-bash-shell/
├── myshell.sh                 # Main shell executable
├── install.sh                 # Installation script
├── uninstall.sh               # Uninstall script
├── README.md                  # This file
├── FUTURE_ENHANCEMENTS.md     # Future improvements
├── LICENSE                    # License file
├── config/                    # Configuration files
│   └── .myshell_history      # Command history
├── scripts/                   # Utility scripts
│   ├── DirectorySize.sh
│   ├── Test-File.sh
│   ├── Server-Health.sh
│   ├── CPU.sh
│   ├── Disk-Space.sh
│   ├── CollectNetworkInfo.sh
│   ├── RemoteBackup.sh
│   ├── HardwareInfo.sh
│   ├── Get-Temperature.sh
│   ├── tiny-http.sh
│   ├── Addition.sh
│   ├── Subtraction.sh
│   ├── Multiplication.sh
│   ├── Division.sh
│   ├── Simplecalc.sh
│   ├── Hello.sh
│   ├── Process.sh
│   ├── Interactive.sh
│   ├── pomodoro.sh
│   ├── weather.sh
│   ├── RedditTop.sh
│   └── Colorful.sh
└── docs/                      # Documentation
```

---

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/AmazingFeature`)
3. **Commit** your changes (`git commit -m 'Add some AmazingFeature'`)
4. **Push** to the branch (`git push origin feature/AmazingFeature`)
5. **Open** a Pull Request

### Coding Standards

- Use 4 spaces for indentation
- Add comments for complex logic
- Follow existing script structure
- Test on multiple distributions if possible
- Update documentation

---

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👨‍💻 Author

**Senior Developer**
- Project: Custom Bash Shell Environment
- Version: 1.0.0
- Date: October 2025

---

## 🙏 Acknowledgments

- Inspired by Unix philosophy and shell programming
- Thanks to the Bash community
- Weather data provided by [wttr.in](https://wttr.in)
- Reddit API for data access

---

## 📞 Support

For issues, questions, or suggestions:

- **Issues**: Open an issue on GitHub
- **Discussions**: Use GitHub Discussions
- **Email**: support@example.com

---

## 🔗 Related Resources

- [Bash Reference Manual](https://www.gnu.org/software/bash/manual/)
- [Advanced Bash-Scripting Guide](https://tldp.org/LDP/abs/html/)
- [Shell Check](https://www.shellcheck.net/) - Shell script analysis tool

---

<div align="center">

**[⬆ Back to Top](#-custom-bash-shell-environment)**

Made with ❤️ and Bash

</div>

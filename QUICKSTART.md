# 🚀 Quick Start Guide

Get up and running with Custom Bash Shell Environment in 5 minutes!

---

## ⚡ 1-Minute Installation

```bash
# Navigate to the project directory
cd /home/yasharth/coding/shell

# Run the installer
./install.sh

# Launch the shell
./myshell.sh
```

---

## 🎯 First Commands

Once inside the shell, try these commands:

```bash
# See help
help

# List all available scripts
list

# View your current directory
pwd

# Check system health
Server-Health

# Try the calculator
Simplecalc

# Get weather for your location
weather

# Exit the shell
exit
```

---

## 📚 5-Minute Tutorial

### Step 1: System Monitoring (1 min)

```bash
# Check CPU usage
CPU

# Monitor disk space
Disk-Space

# View hardware information
HardwareInfo
```

### Step 2: File Operations (1 min)

```bash
# Check directory size
DirectorySize /home

# Test a file
Test-File /etc/hosts

# Get network info
CollectNetworkInfo
```

### Step 3: Interactive Tools (1 min)

```bash
# Launch interactive menu
Interactive

# Try the calculator
Simplecalc

# Run the Hello demo
Hello
```

### Step 4: Network & Misc (1 min)

```bash
# Get weather
weather "New York"

# View Reddit top posts
RedditTop linux

# See colorful output
Colorful
```

### Step 5: Productivity (1 min)

```bash
# Start a Pomodoro session
pomodoro

# Or with custom times (30 min work, 10 min break)
pomodoro 30 10
```

---

## 💡 Useful Tips

### Running Scripts

```bash
# With or without .sh extension
DirectorySize /path
DirectorySize.sh /path

# Interactive mode (for scripts that support it)
Simplecalc
Interactive
pomodoro
```

### Passing Arguments

```bash
# Script with arguments
CPU 85                    # Custom threshold
weather London           # Specific city
tiny-http 3000           # Custom port
```

### Command History

```bash
# View history
history

# History is saved in config/.myshell_history
```

### Getting Help

```bash
# Built-in help
help

# List scripts by category
list

# Most scripts show usage when run without arguments
```

---

## 🔧 Common Tasks

### Backup Files

```bash
# Local backup (create archive)
DirectorySize ~/important_data
RemoteBackup ~/important_data user@server:/backup/
```

### Start a Web Server

```bash
# Default (port 8080, current directory)
tiny-http

# Custom port and directory
tiny-http 3000 /path/to/www
```

### Monitor System

```bash
# Full health check
Server-Health

# Specific checks
CPU 80
Disk-Space 75
Get-Temperature
```

### Quick Calculations

```bash
# Interactive calculator
Simplecalc

# Direct calculation
Addition 10 20
Division 100 5
```

---

## 🎨 Customization

### Change Shell Appearance

Edit `myshell.sh` and modify these variables:

```bash
SHELL_NAME="MyShell"           # Your shell name
PROMPT_COLOR="\033[1;36m"      # Cyan
ERROR_COLOR="\033[1;31m"       # Red
SUCCESS_COLOR="\033[1;32m"     # Green
```

### Add to PATH

```bash
# Add to your ~/.bashrc
export PATH="$PATH:/home/yasharth/coding/shell"

# Reload
source ~/.bashrc

# Now you can run from anywhere
myshell.sh
```

---

## 🐛 Troubleshooting

### Scripts Not Executable

```bash
chmod +x myshell.sh scripts/*.sh
```

### Missing Dependencies

```bash
# Ubuntu/Debian
sudo apt-get install curl netcat bc jq

# Fedora/RHEL
sudo dnf install curl nc bc jq

# Arch Linux
sudo pacman -S curl gnu-netcat bc jq
```

### Port Already in Use (tiny-http)

```bash
# Try a different port
tiny-http 8081
```

---

## 📖 Next Steps

1. **Read the full README**: `cat README.md`
2. **Explore all scripts**: `list`
3. **Check future features**: `cat FUTURE_ENHANCEMENTS.md`
4. **Customize your shell**: Edit `myshell.sh`
5. **Create your own scripts**: Add to `scripts/` directory

---

## 🎓 Learning Path

### Beginner
- Try all interactive scripts
- Explore the help system
- Run basic commands

### Intermediate
- Use system monitoring scripts
- Set up remote backups
- Customize the shell

### Advanced
- Create your own scripts
- Modify existing scripts
- Contribute to the project

---

## 📞 Getting Help

- **Help Command**: Type `help` in the shell
- **Documentation**: Read `README.md`
- **Script List**: Type `list` in the shell
- **Issues**: Open an issue on GitHub

---

## ✅ Checklist

- [ ] Installed dependencies
- [ ] Ran `./install.sh`
- [ ] Launched `./myshell.sh`
- [ ] Tried `help` command
- [ ] Ran at least 5 different scripts
- [ ] Customized shell settings
- [ ] Added to PATH (optional)
- [ ] Read the full README

---

**Congratulations! You're now ready to use Custom Bash Shell Environment! 🎉**

For more detailed information, see [README.md](README.md)

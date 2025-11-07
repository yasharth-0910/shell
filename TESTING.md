# 🧪 Testing Guide

This guide helps you test all features of the Custom Bash Shell Environment.

---

## ✅ Pre-Installation Testing

### 1. Check Prerequisites

```bash
# Check Bash version
bash --version
# Should be 4.0 or higher

# Check for required tools
which curl
which nc
which bc

# Check file permissions
ls -l install.sh myshell.sh
# Should show -rwxr-xr-x (executable)
```

---

## ✅ Installation Testing

### 1. Run Installer

```bash
./install.sh
```

**Expected Results:**
- ✅ Dependency check passes
- ✅ Scripts made executable
- ✅ Config directory created
- ✅ Prompt to add to PATH
- ✅ Option to create launcher

### 2. Verify Installation

```bash
# Check config directory
ls -la config/
# Should show .myshell_history

# Check all scripts are executable
ls -l scripts/*.sh
# All should have execute permission

# Count scripts
ls -1 scripts/*.sh | wc -l
# Should show 22
```

---

## ✅ Shell Testing

### 1. Launch Shell

```bash
./myshell.sh
```

**Expected Results:**
- ✅ Welcome banner displays
- ✅ Colored prompt appears
- ✅ No error messages

### 2. Test Built-in Commands

```bash
# In the shell:

# Test help
help
# Should display help information

# Test list
list
# Should show all 22 scripts by category

# Test pwd
pwd
# Should show current directory

# Test cd
cd /tmp
pwd
# Should show /tmp

# Test history
history
# Should show command history

# Test clear
clear
# Should clear screen
```

### 3. Test Script Execution

```bash
# In the shell, test various scripts:

# With .sh extension
Hello.sh

# Without .sh extension
Hello

# With arguments
Addition 10 20
# Expected: 10 + 20 = 30

# Invalid script
NonExistent
# Expected: Error message
```

### 4. Test Error Handling

```bash
# Ctrl+C handling
# Press Ctrl+C
# Expected: Message to use 'exit' command

# Invalid command
asdfghjkl
# Expected: Error message or attempt system command

# Exit
exit
# Expected: Goodbye message
```

---

## ✅ Script Testing

### System Administration Scripts

#### DirectorySize.sh
```bash
./scripts/DirectorySize.sh ~
# Expected: Directory size report

./scripts/DirectorySize.sh
# Expected: Analyzes current directory

./scripts/DirectorySize.sh /nonexistent
# Expected: Error message
```

#### Test-File.sh
```bash
./scripts/Test-File.sh ~/.bashrc
# Expected: File information and permissions

./scripts/Test-File.sh /nonexistent
# Expected: "Does not exist" message
```

#### Server-Health.sh
```bash
./scripts/Server-Health.sh
# Expected: System health report with:
# - Uptime
# - Load average
# - Memory usage
# - Disk usage
# - Top processes
```

#### CPU.sh
```bash
./scripts/CPU.sh
# Expected: CPU usage report (default 80% threshold)

./scripts/CPU.sh 90
# Expected: CPU usage with 90% threshold
```

#### Disk-Space.sh
```bash
./scripts/Disk-Space.sh
# Expected: Disk space report

./scripts/Disk-Space.sh 70
# Expected: Report with 70% threshold
```

#### CollectNetworkInfo.sh
```bash
./scripts/CollectNetworkInfo.sh
# Expected: Network configuration including:
# - Hostname
# - Network interfaces
# - Active connections
# - Routing table
# - DNS servers
```

#### RemoteBackup.sh
```bash
# Note: Requires SSH access to test fully
./scripts/RemoteBackup.sh
# Expected: Usage message

# Test with valid arguments (if you have SSH access)
# ./scripts/RemoteBackup.sh ~/testdir user@server:/backup/
```

#### HardwareInfo.sh
```bash
./scripts/HardwareInfo.sh
# Expected: Hardware information including:
# - System info
# - CPU details
# - Memory info
# - Disk devices
# - Network interfaces
# - PCI devices
```

#### Get-Temperature.sh
```bash
./scripts/Get-Temperature.sh
# Expected: CPU temperature (if sensors available)
# or installation instructions
```

---

### Network Services Scripts

#### tiny-http.sh
```bash
# Terminal 1
./scripts/tiny-http.sh 8080
# Expected: Server starts, shows configuration

# Terminal 2
curl http://localhost:8080
# Expected: HTML page displays

# Test with custom port
./scripts/tiny-http.sh 3000 ~/mydir
```

---

### Mathematical Operations Scripts

#### Addition.sh
```bash
./scripts/Addition.sh 10 20
# Expected: 10 + 20 = 30

./scripts/Addition.sh
# Expected: Interactive mode

./scripts/Addition.sh abc 123
# Expected: Error message
```

#### Subtraction.sh
```bash
./scripts/Subtraction.sh 50 20
# Expected: 50 - 20 = 30
```

#### Multiplication.sh
```bash
./scripts/Multiplication.sh 5 6
# Expected: 5 × 6 = 30
```

#### Division.sh
```bash
./scripts/Division.sh 100 5
# Expected: 100 ÷ 5 = 20

./scripts/Division.sh 10 0
# Expected: Division by zero error
```

#### Simplecalc.sh
```bash
./scripts/Simplecalc.sh
# Expected: Interactive calculator menu
# Test all operations (1-7)
# Test exit (8)
```

---

### Interactive Utilities Scripts

#### Hello.sh
```bash
./scripts/Hello.sh
# Expected: Interactive prompts for:
# - Name
# - Age
# - Favorite color
# Then displays summary
```

#### Process.sh
```bash
./scripts/Process.sh
# Expected: Demonstrations of:
# - Sequential execution
# - AND operator
# - OR operator
# - Pipes
# - Command substitution
# - Background execution
# - Complex chaining
```

#### Interactive.sh
```bash
./scripts/Interactive.sh
# Expected: Menu system with:
# 1. System Information submenu
# 2. File Operations submenu
# 3. Network Tools submenu
# 4. Calculator
# 5. About
# 6. Exit

# Test each submenu and option
```

#### pomodoro.sh
```bash
./scripts/pomodoro.sh
# Expected: Pomodoro timer starts
# Wait through one cycle or Ctrl+C

./scripts/pomodoro.sh 1 1
# Expected: Quick test (1 min work, 1 min break)
```

---

### Miscellaneous Scripts

#### weather.sh
```bash
./scripts/weather.sh
# Expected: Auto-detected location weather

./scripts/weather.sh London
# Expected: London weather

# Requires internet connection
```

#### RedditTop.sh
```bash
./scripts/RedditTop.sh
# Expected: Top posts from r/all

./scripts/RedditTop.sh programming
# Expected: Top posts from r/programming

# Requires internet connection
```

#### Colorful.sh
```bash
./scripts/Colorful.sh
# Expected: Color demonstration including:
# - Basic colors
# - Bold colors
# - Background colors
# - Combined styles
# - Text styles
# - Rainbow text
# - Color animation
```

---

## ✅ Edge Case Testing

### Invalid Inputs
```bash
# Test with empty arguments
./scripts/Addition.sh "" ""

# Test with special characters
./scripts/Addition.sh "!@#" "$%^"

# Test with very long input
./scripts/Addition.sh $(python3 -c "print('9'*1000)") 1
```

### Resource Testing
```bash
# Test with large directory
./scripts/DirectorySize.sh /

# Test with many files
./scripts/DirectorySize.sh /usr
```

### Concurrent Testing
```bash
# Run multiple scripts simultaneously
./scripts/Server-Health.sh &
./scripts/CPU.sh &
./scripts/Disk-Space.sh &
wait
```

---

## ✅ Uninstallation Testing

```bash
./uninstall.sh
```

**Expected Results:**
- ✅ Removes PATH modifications
- ✅ Removes desktop launcher
- ✅ Option to remove config
- ✅ Cleans temporary files
- ✅ Shows what remains
- ✅ No errors

### Verify Uninstallation
```bash
# Check PATH
echo $PATH | grep custom-bash-shell
# Should be empty

# Check desktop launcher
ls ~/.local/share/applications/myshell.desktop
# Should not exist (if removed)

# Check history backup
ls ~/.myshell_history.backup
# Should exist if you chose to remove config
```

---

## ✅ Automated Testing Script

Create this script to test multiple scripts:

```bash
#!/bin/bash
# test-all.sh

echo "Testing all scripts..."

# Test mathematical operations
echo "Testing math scripts..."
./scripts/Addition.sh 10 20
./scripts/Subtraction.sh 30 10
./scripts/Multiplication.sh 5 4
./scripts/Division.sh 40 2

# Test system scripts
echo "Testing system scripts..."
./scripts/DirectorySize.sh ~
./scripts/Test-File.sh ~/.bashrc
./scripts/CPU.sh
./scripts/Disk-Space.sh

# Test info scripts
echo "Testing info scripts..."
./scripts/HardwareInfo.sh
./scripts/CollectNetworkInfo.sh

echo "All tests complete!"
```

---

## ✅ Performance Testing

### Startup Time
```bash
time ./myshell.sh <<< "exit"
# Should be < 1 second
```

### Memory Usage
```bash
# Start shell in background
./myshell.sh &
SHELL_PID=$!

# Check memory
ps aux | grep $SHELL_PID
# Should be < 10MB

# Cleanup
kill $SHELL_PID
```

### Script Execution Speed
```bash
# Time various scripts
time ./scripts/Addition.sh 10 20
time ./scripts/Server-Health.sh
time ./scripts/DirectorySize.sh ~
```

---

## ✅ Compatibility Testing

### Different Bash Versions
```bash
# Test with different bash versions
/bin/bash --version
/bin/bash ./myshell.sh
```

### Different Distributions
Test on:
- [ ] Ubuntu/Debian
- [ ] Fedora/RHEL
- [ ] Arch Linux
- [ ] Other distributions

### With/Without Optional Tools
```bash
# Test without jq
sudo apt-get remove jq
./scripts/RedditTop.sh
# Should work with fallback

# Test without bc
sudo apt-get remove bc
./scripts/Simplecalc.sh
# Should work with integer math
```

---

## ✅ Test Checklist

Use this checklist for comprehensive testing:

### Installation
- [ ] Dependencies checked
- [ ] Scripts made executable
- [ ] Config directory created
- [ ] PATH addition works
- [ ] Desktop launcher created

### Shell Basics
- [ ] Shell launches without errors
- [ ] Help command works
- [ ] List command works
- [ ] CD command works
- [ ] PWD command works
- [ ] History works
- [ ] Exit works
- [ ] Ctrl+C handled gracefully

### System Scripts (9)
- [ ] DirectorySize
- [ ] Test-File
- [ ] Server-Health
- [ ] CPU
- [ ] Disk-Space
- [ ] CollectNetworkInfo
- [ ] RemoteBackup
- [ ] HardwareInfo
- [ ] Get-Temperature

### Network Scripts (1)
- [ ] tiny-http

### Math Scripts (5)
- [ ] Addition
- [ ] Subtraction
- [ ] Multiplication
- [ ] Division
- [ ] Simplecalc

### Interactive Scripts (4)
- [ ] Hello
- [ ] Process
- [ ] Interactive
- [ ] pomodoro

### Misc Scripts (3)
- [ ] weather
- [ ] RedditTop
- [ ] Colorful

### Uninstallation
- [ ] Uninstaller runs
- [ ] PATH removed
- [ ] Launcher removed
- [ ] Config handling works
- [ ] No errors

---

## 📊 Test Results Template

```
Test Date: ___________
Tester: ___________
OS: ___________
Bash Version: ___________

Installation: [ ] Pass [ ] Fail
Shell Basics: [ ] Pass [ ] Fail
System Scripts: [ ] Pass [ ] Fail (___/9)
Network Scripts: [ ] Pass [ ] Fail (___/1)
Math Scripts: [ ] Pass [ ] Fail (___/5)
Interactive Scripts: [ ] Pass [ ] Fail (___/4)
Misc Scripts: [ ] Pass [ ] Fail (___/3)
Uninstallation: [ ] Pass [ ] Fail

Notes:
_________________________________
_________________________________
_________________________________
```

---

## 🐛 Reporting Issues

If you find bugs during testing:

1. Note the exact steps to reproduce
2. Record error messages
3. Capture environment details
4. Take screenshots if applicable
5. Report on GitHub Issues

---

**Happy Testing! 🧪**

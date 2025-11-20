# Command Reference Guide

Quick reference for all scripts with copy-ready commands and one-line descriptions.

---

## System Administration Scripts

### 1. CPU.sh
**Command:**
```bash
./scripts/CPU.sh [threshold]
```
**Description:** Monitor CPU usage with customizable threshold alerts (default: 80%)

**Examples:**
```bash
./scripts/CPU.sh           # Check CPU with 80% threshold
./scripts/CPU.sh 90        # Check CPU with 90% threshold
./scripts/CPU.sh 50        # Check CPU with 50% threshold
```

---

### 2. Get-Temperature.sh
**Command:**
```bash
./scripts/Get-Temperature.sh
```
**Description:** Display CPU temperature with heat level warnings (<60°C normal, 60-80°C elevated, >80°C high)

**Examples:**
```bash
./scripts/Get-Temperature.sh
```

---

### 3. HardwareInfo.sh
**Command:**
```bash
./scripts/HardwareInfo.sh
```
**Description:** Complete hardware inventory (CPU, RAM, storage, network, PCI/USB devices, BIOS info)

**Examples:**
```bash
./scripts/HardwareInfo.sh
```

---

### 4. Disk-Space.sh
**Command:**
```bash
./scripts/Disk-Space.sh [threshold]
```
**Description:** Monitor disk space usage with alerts and show top 10 largest directories when threshold exceeded (default: 80%)

**Examples:**
```bash
./scripts/Disk-Space.sh           # Check disk with 80% threshold
./scripts/Disk-Space.sh 90        # Check disk with 90% threshold
./scripts/Disk-Space.sh 70        # Check disk with 70% threshold
```

---

### 5. CollectNetworkInfo.sh
**Command:**
```bash
./scripts/CollectNetworkInfo.sh
```
**Description:** Comprehensive network report (interfaces, connections, routing, DNS, gateway, public IP)

**Examples:**
```bash
./scripts/CollectNetworkInfo.sh
```

---

### 6. Server-Health.sh
**Command:**
```bash
./scripts/Server-Health.sh
```
**Description:** Overall system health check (uptime, memory, CPU load, disk usage, top processes)

**Examples:**
```bash
./scripts/Server-Health.sh
```

---

### 7. DirectorySize.sh
**Command:**
```bash
./scripts/DirectorySize.sh [directory_path]
```
**Description:** Analyze directory size with top 10 largest subdirectories (default: current directory)

**Examples:**
```bash
./scripts/DirectorySize.sh                    # Current directory
./scripts/DirectorySize.sh /home/user         # Specific directory
./scripts/DirectorySize.sh /var/log           # System logs
```

---

### 8. Test-File.sh
**Command:**
```bash
./scripts/Test-File.sh <file_or_directory_path>
```
**Description:** Check file/directory properties (exists, type, permissions, readable, writable, executable)

**Examples:**
```bash
./scripts/Test-File.sh myfile.txt             # Test a file
./scripts/Test-File.sh /home/user/docs        # Test a directory
./scripts/Test-File.sh /usr/bin/bash          # Test an executable
```

---

### 9. RemoteBackup.sh
**Command:**
```bash
./scripts/RemoteBackup.sh <source_directory> <remote_user@host:/destination>
```
**Description:** Backup local directory to remote server via SCP with compression and verification

**Examples:**
```bash
./scripts/RemoteBackup.sh /home/user/data user@server.com:/backups/
./scripts/RemoteBackup.sh /var/www user@192.168.1.100:/backups/www/
```

---

## Network Services

### 10. tiny-http.sh
**Command:**
```bash
./scripts/tiny-http.sh [port]
```
**Description:** Start minimal HTTP server serving current directory (default port: 8000)

**Examples:**
```bash
./scripts/tiny-http.sh           # Start on port 8000
./scripts/tiny-http.sh 9000      # Start on port 9000
./scripts/tiny-http.sh 3000      # Start on port 3000
```

---

## Math Utilities

### 11. Addition.sh
**Command:**
```bash
./scripts/Addition.sh <number1> <number2>
```
**Description:** Add two numbers and display result

**Examples:**
```bash
./scripts/Addition.sh 10 20              # Result: 30
./scripts/Addition.sh 5.5 4.3            # Result: 9.8
./scripts/Addition.sh -10 25             # Result: 15
```

---

### 12. Subtraction.sh
**Command:**
```bash
./scripts/Subtraction.sh <number1> <number2>
```
**Description:** Subtract second number from first and display result

**Examples:**
```bash
./scripts/Subtraction.sh 50 20           # Result: 30
./scripts/Subtraction.sh 10.5 3.2        # Result: 7.3
./scripts/Subtraction.sh -5 -10          # Result: 5
```

---

### 13. Multiplication.sh
**Command:**
```bash
./scripts/Multiplication.sh <number1> <number2>
```
**Description:** Multiply two numbers and display result

**Examples:**
```bash
./scripts/Multiplication.sh 5 10         # Result: 50
./scripts/Multiplication.sh 2.5 4        # Result: 10
./scripts/Multiplication.sh -3 7         # Result: -21
```

---

### 14. Division.sh
**Command:**
```bash
./scripts/Division.sh <number1> <number2>
```
**Description:** Divide first number by second with decimal precision (checks for division by zero)

**Examples:**
```bash
./scripts/Division.sh 100 5              # Result: 20
./scripts/Division.sh 22 7               # Result: 3.142857
./scripts/Division.sh 10 0               # Error: division by zero
```

---

### 15. Simplecalc.sh
**Command:**
```bash
./scripts/Simplecalc.sh <number1> <operator> <number2>
```
**Description:** Basic calculator with +, -, *, / operations

**Examples:**
```bash
./scripts/Simplecalc.sh 10 + 5           # Result: 15
./scripts/Simplecalc.sh 20 - 8           # Result: 12
./scripts/Simplecalc.sh 6 '*' 7          # Result: 42 (note: * must be quoted)
./scripts/Simplecalc.sh 100 / 4          # Result: 25
```

---

## Interactive Scripts

### 16. Hello.sh
**Command:**
```bash
./scripts/Hello.sh
```
**Description:** Interactive greeting script demonstrating user input/output

**Examples:**
```bash
./scripts/Hello.sh
```

---

## Miscellaneous

### 17. weather.sh
**Command:**
```bash
./scripts/weather.sh [city_name]
```
**Description:** Get current weather information for a city via wttr.in API (default: auto-detect location)

**Examples:**
```bash
./scripts/weather.sh                     # Auto-detect location
./scripts/weather.sh London              # Weather for London
./scripts/weather.sh "New York"          # Weather for New York (use quotes for spaces)
./scripts/weather.sh Tokyo               # Weather for Tokyo
```

---

### 18. RedditTop.sh
**Command:**
```bash
./scripts/RedditTop.sh [subreddit] [limit]
```
**Description:** Fetch top posts from Reddit subreddit (default: r/all, limit: 10)

**Examples:**
```bash
./scripts/RedditTop.sh                   # Top 10 from r/all
./scripts/RedditTop.sh programming       # Top 10 from r/programming
./scripts/RedditTop.sh linux 5           # Top 5 from r/linux
./scripts/RedditTop.sh technology 20     # Top 20 from r/technology
```

---

## Built-in Shell Commands

When running `./myshell.sh`, these commands are available:

### cd
**Command:**
```bash
cd <directory>
```
**Description:** Change current directory

**Examples:**
```bash
cd /home/user
cd ..
cd scripts
```

---

### pwd
**Command:**
```bash
pwd
```
**Description:** Print current working directory

---

### ls
**Command:**
```bash
ls
```
**Description:** List files in current directory

---

### echo
**Command:**
```bash
echo <text>
```
**Description:** Print text to screen

**Examples:**
```bash
echo Hello World
echo "Testing MyShell"
```

---

### date
**Command:**
```bash
date
```
**Description:** Display current date and time

---

### help
**Command:**
```bash
help
```
**Description:** Show available built-in commands

---

### exit
**Command:**
```bash
exit
```
**Description:** Exit the custom shell

---

## Quick Test Suite

Copy and run these commands to test all scripts:

```bash
# System monitoring
./scripts/CPU.sh 85
./scripts/Get-Temperature.sh
./scripts/HardwareInfo.sh
./scripts/Disk-Space.sh 80
./scripts/CollectNetworkInfo.sh
./scripts/Server-Health.sh

# File operations
./scripts/DirectorySize.sh .
./scripts/Test-File.sh README.md

# Math operations
./scripts/Addition.sh 15 25
./scripts/Subtraction.sh 50 30
./scripts/Multiplication.sh 6 7
./scripts/Division.sh 100 4
./scripts/Simplecalc.sh 10 + 5

# Interactive
./scripts/Hello.sh

# Network/API
./scripts/weather.sh
./scripts/RedditTop.sh linux 5

# HTTP server (Ctrl+C to stop)
./scripts/tiny-http.sh 8000
```

---

## Notes

- All scripts are located in the `scripts/` directory
- Scripts with `[optional_parameter]` work with or without the parameter
- Scripts with `<required_parameter>` need the parameter to function
- Use absolute paths or run from the project root directory
- Some scripts require internet connection (weather.sh, RedditTop.sh)
- Some scripts may require additional packages (lm-sensors for temperature)
- For multiplication in Simplecalc.sh, quote the asterisk: `'*'` to prevent shell expansion

---

## Installation

To make scripts available system-wide:

```bash
./install.sh
```

To remove installation:

```bash
./uninstall.sh
```

After installation, run scripts without `./scripts/` prefix:
```bash
CPU.sh 85
HardwareInfo.sh
weather.sh London
```

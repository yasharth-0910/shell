# Custom Bash Shell - Commands Reference

Quick reference guide for all available commands and scripts in the Custom Bash Shell Environment.

---

## Built-in Shell Commands

These commands are built into the shell and available when you run `./myshell.sh`:

### `help`
**Description:** Display help information about available commands.  
**Usage:** `help`  
**Example:**
```bash
MyShell:~$ help
```

### `list`
**Description:** List all available utility scripts organized by category.  
**Usage:** `list`  
**Example:**
```bash
MyShell:~$ list
```

### `cd [directory]`
**Description:** Change the current working directory.  
**Usage:** `cd [directory]`  
**Examples:**
```bash
MyShell:~$ cd /var/log    # Change to /var/log
MyShell:~$ cd             # Change to home directory
MyShell:~$ cd ..          # Go to parent directory
```

### `pwd`
**Description:** Print the current working directory path.  
**Usage:** `pwd`  
**Example:**
```bash
MyShell:~$ pwd
/home/username
```

### `clear`
**Description:** Clear the terminal screen and show the welcome banner.  
**Usage:** `clear`  
**Example:**
```bash
MyShell:~$ clear
```

### `history`
**Description:** Display the last 20 commands executed in the shell.  
**Usage:** `history`  
**Example:**
```bash
MyShell:~$ history
```

### `exit` or `quit`
**Description:** Exit the custom shell and return to normal terminal.  
**Usage:** `exit` or `quit`  
**Example:**
```bash
MyShell:~$ exit
```

---

## System Administration Scripts

### `DirectorySize.sh [directory]`
**Description:** Analyze directory size and show the top 10 largest subdirectories.  
**Usage:** `DirectorySize.sh [directory]`  
**Parameters:**
- `directory` (optional): Path to analyze. Default: current directory

**Examples:**
```bash
# Analyze current directory
MyShell:~$ DirectorySize

# Analyze specific directory
MyShell:~$ DirectorySize /var/log

# Analyze home directory
MyShell:~$ DirectorySize ~
```

**What it does:**
- Shows total size of the directory
- Lists top 10 largest subdirectories
- Helps identify what's consuming disk space

---

### `Test-File.sh <path>`
**Description:** Test if a file or directory exists and show detailed information.  
**Usage:** `Test-File.sh <file_or_directory_path>`  
**Parameters:**
- `path` (required): Path to test

**Examples:**
```bash
# Test a file
MyShell:~$ Test-File /etc/passwd

# Test a directory
MyShell:~$ Test-File /home/user/Documents

# Test a symbolic link
MyShell:~$ Test-File /usr/bin/python
```

**What it shows:**
- Whether file/directory exists
- Type (regular file, directory, symlink)
- Permissions (readable, writable, executable)
- Size and modification time

---

### `Server-Health.sh`
**Description:** Comprehensive system health check showing uptime, memory, disk, CPU, and processes.  
**Usage:** `Server-Health.sh`  
**Parameters:** None

**Example:**
```bash
MyShell:~$ Server-Health
```

**What it shows:**
- System uptime
- Load average (1, 5, 15 minutes)
- Memory usage with warnings
- Disk space usage
- Top 5 CPU-consuming processes
- Top 5 memory-consuming processes

---

### `CPU.sh [threshold]`
**Description:** Monitor CPU usage and alert if it exceeds the threshold.  
**Usage:** `CPU.sh [threshold_percentage]`  
**Parameters:**
- `threshold` (optional): Alert threshold percentage. Default: 80

**Examples:**
```bash
# Use default 80% threshold
MyShell:~$ CPU

# Use 90% threshold
MyShell:~$ CPU 90

# Strict 50% threshold
MyShell:~$ CPU 50
```

**What it does:**
- Shows current CPU usage
- Alerts if usage exceeds threshold
- Lists top CPU-consuming processes when threshold exceeded

---

### `Disk-Space.sh [threshold]`
**Description:** Monitor disk space usage across all filesystems.  
**Usage:** `Disk-Space.sh [threshold_percentage]`  
**Parameters:**
- `threshold` (optional): Alert threshold percentage. Default: 80

**Examples:**
```bash
# Use default 80% threshold
MyShell:~$ Disk-Space

# Use 70% threshold
MyShell:~$ Disk-Space 70
```

**What it shows:**
- All filesystem usage
- Warnings for filesystems above threshold
- Largest directories when alerts triggered
- Inode usage

---

### `CollectNetworkInfo.sh`
**Description:** Collect comprehensive network configuration information.  
**Usage:** `CollectNetworkInfo.sh`  
**Parameters:** None

**Example:**
```bash
MyShell:~$ CollectNetworkInfo
```

**What it shows:**
- Hostname
- Network interfaces and IP addresses
- Active network connections
- Routing table
- DNS servers
- Default gateway
- Public IP address

---

### `RemoteBackup.sh <source> <remote_user@host> <remote_path>`
**Description:** Create compressed backup and transfer to remote server via SCP.  
**Usage:** `RemoteBackup.sh <source_path> <remote_user@host> <remote_path>`  
**Parameters:**
- `source_path` (required): Local file/directory to backup
- `remote_user@host` (required): Remote server (e.g., user@192.168.1.100)
- `remote_path` (required): Destination path on remote server

**Examples:**
```bash
# Backup documents to remote server
MyShell:~$ RemoteBackup ~/Documents user@192.168.1.100 /backups/

# Backup config file
MyShell:~$ RemoteBackup /etc/nginx/nginx.conf admin@backup.example.com /backups/config/
```

**What it does:**
- Creates compressed tar.gz archive
- Transfers via secure SCP
- Shows transfer progress
- Cleans up temporary files

**Note:** Requires SSH access to remote server.

---

### `HardwareInfo.sh`
**Description:** Display detailed hardware information about the system.  
**Usage:** `HardwareInfo.sh`  
**Parameters:** None

**Example:**
```bash
MyShell:~$ HardwareInfo
```

**What it shows:**
- System information (hostname, kernel, architecture, OS)
- CPU details (model, cores, frequency, cache)
- Memory information
- Storage devices
- Network interfaces
- PCI devices
- USB devices
- Graphics card info

---

### `Get-Temperature.sh`
**Description:** Monitor CPU temperature using system sensors.  
**Usage:** `Get-Temperature.sh`  
**Parameters:** None

**Example:**
```bash
MyShell:~$ Get-Temperature
```

**What it shows:**
- Temperature readings for each CPU core
- Average temperature
- Warnings if temperature is high

**Note:** Requires `lm-sensors` package. Install with:
```bash
sudo apt-get install lm-sensors
sudo sensors-detect
```

---

## Network Services Scripts

### `tiny-http.sh [port] [directory]`
**Description:** Start a minimal HTTP server to serve files.  
**Usage:** `tiny-http.sh [port] [directory]`  
**Parameters:**
- `port` (optional): Port to listen on. Default: 8080
- `directory` (optional): Directory to serve. Default: ./www

**Examples:**
```bash
# Start server on port 8080
MyShell:~$ tiny-http

# Custom port
MyShell:~$ tiny-http 3000

# Custom port and directory
MyShell:~$ sudo tiny-http 80 /var/www/html
```

**What it does:**
- Serves static files (HTML, CSS, JS, images)
- Auto-generates index page
- Logs requests
- Supports multiple MIME types

**⚠️ WARNING:** For development only! Do NOT use in production.

---

## Mathematical Operations Scripts

### `Addition.sh <number1> <number2>`
**Description:** Add two numbers (integers or decimals).  
**Usage:** `Addition.sh <number1> <number2>`  
**Parameters:**
- `number1` (required): First number
- `number2` (required): Second number

**Examples:**
```bash
# Add integers
MyShell:~$ Addition 10 20
Result: 10 + 20 = 30

# Add decimals
MyShell:~$ Addition 15.5 8.25
Result: 15.5 + 8.25 = 23.75

# Negative numbers
MyShell:~$ Addition -50 75
Result: -50 + 75 = 25
```

---

### `Subtraction.sh <number1> <number2>`
**Description:** Subtract two numbers.  
**Usage:** `Subtraction.sh <number1> <number2>`  
**Parameters:**
- `number1` (required): Number to subtract from
- `number2` (required): Number to subtract

**Examples:**
```bash
# Basic subtraction
MyShell:~$ Subtraction 50 30
Result: 50 - 30 = 20

# With decimals
MyShell:~$ Subtraction 99.99 25.50
Result: 99.99 - 25.50 = 74.49
```

---

### `Multiplication.sh <number1> <number2>`
**Description:** Multiply two numbers.  
**Usage:** `Multiplication.sh <number1> <number2>`  
**Parameters:**
- `number1` (required): First number
- `number2` (required): Second number

**Examples:**
```bash
# Multiply integers
MyShell:~$ Multiplication 12 8
Result: 12 * 8 = 96

# Multiply decimals
MyShell:~$ Multiplication 3.14 2
Result: 3.14 * 2 = 6.28
```

---

### `Division.sh <number1> <number2>`
**Description:** Divide two numbers with decimal precision.  
**Usage:** `Division.sh <number1> <number2>`  
**Parameters:**
- `number1` (required): Dividend (number to divide)
- `number2` (required): Divisor (divide by)

**Examples:**
```bash
# Basic division
MyShell:~$ Division 100 4
Result: 100 / 4 = 25.00

# Decimal division
MyShell:~$ Division 22 7
Result: 22 / 7 = 3.14
```

**Note:** Division by zero is prevented with error message.

---

### `Simplecalc.sh`
**Description:** Interactive calculator with 7 operations.  
**Usage:** `Simplecalc.sh`  
**Parameters:** None (interactive)

**Example:**
```bash
MyShell:~$ Simplecalc
```

**Operations available:**
1. Addition
2. Subtraction
3. Multiplication
4. Division
5. Power (a^b)
6. Square Root (√a)
7. Modulo (a % b)

**How to use:**
1. Run the script
2. Select operation (1-8)
3. Enter numbers when prompted
4. View result
5. Press Enter to continue
6. Select 8 to exit

---

## Interactive Utilities Scripts

### `Hello.sh`
**Description:** Simple input/output demonstration - greets user with system info.  
**Usage:** `Hello.sh`  
**Parameters:** None (interactive)

**Example:**
```bash
MyShell:~$ Hello
```

**What it does:**
- Asks for your name
- Shows personalized greeting
- Displays current date and time
- Shows system information

---

## Miscellaneous Scripts

### `weather.sh [city]`
**Description:** Display current weather information for any city.  
**Usage:** `weather.sh [city_name]`  
**Parameters:**
- `city` (optional): City name. Default: auto-detect from IP

**Examples:**
```bash
# Auto-detect location
MyShell:~$ weather

# Specific city
MyShell:~$ weather "New York"

# International city
MyShell:~$ weather Tokyo
MyShell:~$ weather London
MyShell:~$ weather Paris
```

**What it shows:**
- Current weather conditions
- Temperature (Celsius)
- Wind speed and direction
- Humidity
- 3-day forecast
- ASCII art weather icons

**Note:** Requires internet connection.

---

### `RedditTop.sh [subreddit] [limit]`
**Description:** View top posts from any subreddit.  
**Usage:** `RedditTop.sh [subreddit] [limit]`  
**Parameters:**
- `subreddit` (optional): Subreddit name. Default: "linux"
- `limit` (optional): Number of posts (1-25). Default: 10

**Examples:**
```bash
# Default (r/linux, 10 posts)
MyShell:~$ RedditTop

# Specific subreddit
MyShell:~$ RedditTop programming

# Custom limit
MyShell:~$ RedditTop python 5

# Both custom
MyShell:~$ RedditTop javascript 15
```

**What it shows:**
- Post titles
- Upvote count
- Comment count
- Author username
- Direct link to post

**Note:** Requires internet connection. For better formatting, install `jq`:
```bash
sudo apt-get install jq
```

---

## Tips and Tricks

### Running Scripts

You can run scripts with or without the `.sh` extension:
```bash
# Both work the same
MyShell:~$ DirectorySize.sh /var/log
MyShell:~$ DirectorySize /var/log
```

### Script Categories

Scripts are organized into 5 categories:
1. **System Administration** (9 scripts)
2. **Network Services** (1 script)
3. **Mathematical Operations** (5 scripts)
4. **Interactive Utilities** (1 script)
5. **Miscellaneous** (2 scripts)

**Total: 18 utility scripts**

### Getting Help

- Type `help` for shell commands
- Type `list` to see all scripts
- Most scripts show usage when run without required parameters

### Command History

- View history with `history` command
- History is saved in `config/.myshell_history`
- Last 1000 commands are saved

### Automation

Scripts can be used in cron jobs:
```bash
# Daily disk check at 8 AM
0 8 * * * /path/to/scripts/Disk-Space.sh 80

# Hourly CPU monitoring
0 * * * * /path/to/scripts/CPU.sh 90
```

### Combining Scripts

You can chain scripts together:
```bash
# Check disk space AND send alert if high
MyShell:~$ Disk-Space 80 && echo "Disk check complete"

# Run multiple checks
MyShell:~$ CPU 85 ; Disk-Space 80 ; Server-Health
```

---

## Quick Reference Table

| Script | Category | Quick Description |
|--------|----------|-------------------|
| DirectorySize.sh | System | Analyze directory sizes |
| Test-File.sh | System | Test file/directory properties |
| Server-Health.sh | System | Complete system health check |
| CPU.sh | System | Monitor CPU usage |
| Disk-Space.sh | System | Monitor disk space |
| CollectNetworkInfo.sh | System | Network configuration info |
| RemoteBackup.sh | System | Backup to remote server |
| HardwareInfo.sh | System | Hardware information |
| Get-Temperature.sh | System | CPU temperature |
| tiny-http.sh | Network | HTTP server |
| Addition.sh | Math | Add numbers |
| Subtraction.sh | Math | Subtract numbers |
| Multiplication.sh | Math | Multiply numbers |
| Division.sh | Math | Divide numbers |
| Simplecalc.sh | Math | Interactive calculator |
| Hello.sh | Interactive | I/O demo |
| weather.sh | Misc | Weather info |
| RedditTop.sh | Misc | Reddit posts |

---

## Platform Compatibility

### ✅ **Linux/Unix - Full Support**
All scripts work natively on Linux distributions (Ubuntu, Debian, Fedora, Arch, etc.)

### ✅ **Windows - WSL2 (Recommended)**
**Best way to run on Windows:**

1. **Install WSL2:**
   ```bash
   # In PowerShell (Administrator)
   wsl --install
   ```

2. **Open Ubuntu from Start Menu**

3. **Navigate and run:**
   ```bash
   cd /mnt/c/Users/YourName/Downloads/shell
   ./install.sh
   ./myshell.sh
   ```

**All features work perfectly in WSL2!**

### ⚠️ **Windows - Git Bash (Partial Support)**
**What works:**
- ✅ Math scripts (Addition, Subtraction, Multiplication, Division, Simplecalc)
- ✅ Hello.sh
- ✅ DirectorySize.sh (basic functionality)
- ✅ weather.sh (if curl available)
- ✅ RedditTop.sh (if curl available)

**What doesn't work:**
- ❌ System monitoring scripts (Server-Health, CPU, Disk-Space, Get-Temperature)
- ❌ Network info collection (CollectNetworkInfo)
- ❌ tiny-http server
- ❌ Some hardware detection features

**To use with Git Bash:**
1. Download Git for Windows: https://git-scm.com/download/win
2. Right-click project folder → "Git Bash Here"
3. Run: `bash myshell.sh`

### 🐳 **Windows - Docker (Full Support)**
**For complete compatibility on Windows without WSL2:**

1. **Install Docker Desktop for Windows**

2. **Create Dockerfile in project root:**
   ```dockerfile
   FROM ubuntu:22.04
   
   RUN apt-get update && apt-get install -y \
       bash curl netcat bc coreutils lm-sensors \
       && rm -rf /var/lib/apt/lists/*
   
   WORKDIR /app
   COPY . /app
   
   RUN chmod +x myshell.sh scripts/*.sh
   
   CMD ["./myshell.sh"]
   ```

3. **Build and run:**
   ```bash
   docker build -t myshell .
   docker run -it myshell
   ```

### 🍎 **macOS - Mostly Works**
Most scripts work on macOS with some limitations:
- May need to install GNU coreutils: `brew install coreutils`
- Some system monitoring features may differ
- Network commands may vary slightly

---

## Installation

To install the shell environment:
```bash
cd /path/to/custom-bash-shell
./install.sh
```

To uninstall:
```bash
./uninstall.sh
```

---

## Support

For issues, questions, or contributions:
- Check `README.md` for detailed documentation
- See `QUICKSTART.md` for 5-minute tutorial
- Read `TROUBLESHOOTING.md` for common problems
- View `CONTRIBUTING.md` for contribution guidelines

---

**Last Updated:** November 19, 2025  
**Version:** 1.0.0  
**Total Scripts:** 18 (22 originally, simplified for ease of use)

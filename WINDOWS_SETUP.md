# Windows Setup Guide

This guide explains how to run the Custom Bash Shell Environment on Windows.

---

## 🏆 Recommended: WSL2 (Windows Subsystem for Linux)

**Best option for Windows users - 100% compatibility, all features work!**

### Prerequisites
- Windows 10 version 2004+ (Build 19041+) or Windows 11
- Administrator access

### Step 1: Install WSL2

Open **PowerShell as Administrator** and run:

```powershell
wsl --install
```

This command will:
- Enable WSL feature
- Install Ubuntu (default distribution)
- Set WSL2 as default version

**Restart your computer when prompted.**

### Step 2: Set Up Ubuntu

1. After restart, search for "Ubuntu" in Start Menu and open it
2. Create a username and password when prompted (first time only)
3. Wait for setup to complete

### Step 3: Install the Shell

In the Ubuntu terminal:

```bash
# Navigate to your Windows Downloads folder
cd /mnt/c/Users/YourUsername/Downloads/shell

# Or if you have it elsewhere
cd /mnt/c/path/to/shell

# Run installation
./install.sh

# Start the shell
./myshell.sh
```

### Accessing Windows Files from WSL

Your Windows drives are mounted under `/mnt/`:
- C: drive is at `/mnt/c/`
- D: drive is at `/mnt/d/`

Example:
```bash
cd /mnt/c/Users/YourName/Documents
cd /mnt/d/Projects
```

### Accessing WSL Files from Windows

In Windows File Explorer, type in address bar:
```
\\wsl$\Ubuntu\home\yourusername
```

Or navigate to: `Network → WSL$ → Ubuntu`

---

## 🔧 Alternative: Git Bash (Partial Support)

**Simpler setup, but some features won't work.**

### What Works in Git Bash
✅ All math scripts (Addition, Subtraction, Multiplication, Division, Simplecalc)  
✅ Hello.sh  
✅ DirectorySize.sh (basic)  
✅ weather.sh  
✅ RedditTop.sh  

### What Doesn't Work
❌ System monitoring (Server-Health, CPU, Disk-Space, Get-Temperature)  
❌ Network collection (CollectNetworkInfo)  
❌ HTTP server (tiny-http)  

### Installation

1. **Download and Install Git for Windows**
   - Visit: https://git-scm.com/download/win
   - Download and run the installer
   - Use default settings during installation

2. **Open Git Bash**
   - Right-click on your project folder
   - Select "Git Bash Here"

3. **Run the Shell**
   ```bash
   # Navigate to the shell directory
   cd /c/Users/YourName/Downloads/shell
   
   # Make scripts executable
   chmod +x myshell.sh scripts/*.sh
   
   # Start the shell
   bash myshell.sh
   ```

### Limitations
- Some commands may show errors (expected for system monitoring scripts)
- Use only the math scripts and basic utilities
- For full functionality, use WSL2 instead

---

## 🐳 Docker (Full Support)

**Perfect for isolated environment and full compatibility.**

### Prerequisites
- Docker Desktop for Windows
- At least 4GB RAM allocated to Docker

### Step 1: Install Docker Desktop

1. Download from: https://www.docker.com/products/docker-desktop/
2. Install Docker Desktop
3. Restart your computer if prompted
4. Open Docker Desktop and wait for it to start

### Step 2: Build the Container

Open **PowerShell** or **Command Prompt** in the project folder:

```powershell
# Navigate to project directory
cd C:\Users\YourName\Downloads\shell

# Build the Docker image
docker build -t myshell .

# Run the shell
docker run -it myshell
```

### Common Docker Commands

```bash
# List running containers
docker ps

# List all containers (including stopped)
docker ps -a

# Stop a container
docker stop <container-id>

# Remove a container
docker rm <container-id>

# Remove the image
docker rmi myshell

# Run with volume mount (access Windows files)
docker run -it -v C:\Users\YourName\Documents:/data myshell
```

---

## 🖥️ Comparison Table

| Feature | WSL2 | Git Bash | Docker |
|---------|------|----------|--------|
| **Setup Difficulty** | Easy | Very Easy | Medium |
| **All Scripts Work** | ✅ Yes | ❌ No | ✅ Yes |
| **Performance** | Native | Native | Good |
| **Disk Space** | ~500MB | ~100MB | ~200MB |
| **Windows Integration** | Excellent | Good | Limited |
| **System Monitoring** | ✅ | ❌ | ✅ |
| **Network Scripts** | ✅ | ⚠️ Partial | ✅ |
| **Math Scripts** | ✅ | ✅ | ✅ |
| **Recommended For** | All users | Quick tests | Isolation |

---

## 🚀 Quick Start Commands

### Once You're In the Shell

```bash
# See all available commands
help

# List all scripts
list

# Try a math calculation
Addition 10 20

# Check system health (WSL2/Docker only)
Server-Health

# Get weather for your city
weather "New York"

# See top Reddit posts
RedditTop programming

# Exit the shell
exit
```

---

## 🐛 Troubleshooting

### WSL2 Issues

**Problem:** "WSL 2 requires an update to its kernel component"

**Solution:**
1. Download WSL2 kernel update: https://aka.ms/wsl2kernel
2. Install it
3. Run: `wsl --set-default-version 2`

**Problem:** "The requested operation requires elevation"

**Solution:** Run PowerShell as Administrator

**Problem:** Ubuntu doesn't start

**Solution:**
```powershell
# Check WSL status
wsl --status

# Update WSL
wsl --update

# Restart WSL
wsl --shutdown
# Then open Ubuntu again
```

### Git Bash Issues

**Problem:** Scripts show "Permission denied"

**Solution:**
```bash
chmod +x myshell.sh scripts/*.sh
```

**Problem:** "bash: command not found"

**Solution:** Use `bash myshell.sh` instead of `./myshell.sh`

**Problem:** System monitoring scripts fail

**Solution:** This is expected. Use WSL2 for full functionality.

### Docker Issues

**Problem:** "docker: command not found"

**Solution:** Make sure Docker Desktop is running (check system tray)

**Problem:** "Cannot connect to Docker daemon"

**Solution:**
1. Open Docker Desktop
2. Wait for it to fully start
3. Try again

**Problem:** Container exits immediately

**Solution:**
```bash
# Run interactively
docker run -it myshell

# Check logs
docker logs <container-id>
```

---

## 📝 Tips for Windows Users

### File Paths

In WSL2, Windows paths work like this:
- `C:\Users\Name\Documents` → `/mnt/c/Users/Name/Documents`
- `D:\Projects` → `/mnt/d/Projects`

Always use forward slashes `/` in WSL2, not backslashes `\`.

### Text Editors

**Recommended editors that work well with WSL2:**
- VS Code with "Remote - WSL" extension
- Notepad++
- Sublime Text
- Vim (built into WSL2)

### Copying Files

**From Windows to WSL2:**
```bash
cp /mnt/c/Users/Name/Downloads/file.txt ~/
```

**From WSL2 to Windows:**
```bash
cp ~/file.txt /mnt/c/Users/Name/Documents/
```

### Performance

For best performance in WSL2:
- Keep project files in WSL2 filesystem (`~/projects/`)
- Not in Windows filesystem (`/mnt/c/...`)

Why? Accessing Windows files from WSL2 is slower than native WSL2 files.

---

## 🎯 Which Option Should I Choose?

**Choose WSL2 if:**
- ✅ You want full compatibility
- ✅ You use Windows 10/11
- ✅ You want best performance
- ✅ You plan to use all features

**Choose Git Bash if:**
- ✅ You only need math scripts
- ✅ You want quick setup
- ✅ You're just testing
- ✅ You can't install WSL2

**Choose Docker if:**
- ✅ You already use Docker
- ✅ You want isolated environment
- ✅ You need full compatibility but can't use WSL2
- ✅ You're deploying to production

---

## 📚 Additional Resources

### WSL2 Documentation
- Official Guide: https://docs.microsoft.com/en-us/windows/wsl/
- WSL2 vs WSL1: https://docs.microsoft.com/en-us/windows/wsl/compare-versions

### Git Bash
- Git for Windows: https://gitforwindows.org/
- Git Bash Tutorial: https://www.atlassian.com/git/tutorials/git-bash

### Docker
- Docker Desktop Docs: https://docs.docker.com/desktop/windows/
- Docker Tutorial: https://docker-curriculum.com/

---

## 💡 Pro Tips

1. **Use Windows Terminal** (free from Microsoft Store) for better WSL2 experience
2. **Install VS Code** and use it with WSL2 for seamless editing
3. **Create Desktop Shortcuts** for quick access to your shell
4. **Backup your data** before major system changes
5. **Keep WSL2 updated:** `wsl --update` in PowerShell

---

## ✅ Success Checklist

- [ ] Chosen installation method (WSL2/Git Bash/Docker)
- [ ] Installed prerequisites
- [ ] Downloaded/cloned the shell project
- [ ] Made scripts executable (`chmod +x`)
- [ ] Successfully started `myshell.sh`
- [ ] Tested at least one script (e.g., `Addition 10 20`)
- [ ] Read the COMMANDS.md reference guide

---

**Need Help?** Check:
- `README.md` - Full project documentation
- `COMMANDS.md` - Command reference
- `QUICKSTART.md` - 5-minute tutorial

**Last Updated:** November 19, 2025

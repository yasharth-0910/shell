#!/bin/bash

################################################################################
# HardwareInfo.sh - Display system hardware information
# Usage: HardwareInfo.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║           System Hardware Information                 ║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${RESET}\n"

# System Information
echo -e "${GREEN}[System Information]${RESET}"
echo "Hostname: $(hostname)"
echo "Kernel: $(uname -r)"
echo "Architecture: $(uname -m)"
echo "OS: $(cat /etc/os-release 2>/dev/null | grep PRETTY_NAME | cut -d'"' -f2 || uname -s)"
echo ""

# CPU Information
echo -e "${GREEN}[CPU Information]${RESET}"
if command -v lscpu &> /dev/null; then
    lscpu | grep -E "Model name|Architecture|CPU\(s\)|Thread|Core|MHz|Cache"
else
    cat /proc/cpuinfo | grep -E "model name|cpu MHz|cache size" | head -3
fi
echo ""

# Memory Information
echo -e "${GREEN}[Memory Information]${RESET}"
free -h
if [ -f /proc/meminfo ]; then
    echo ""
    grep -E "MemTotal|MemFree|MemAvailable" /proc/meminfo
fi
echo ""

# Disk Information
echo -e "${GREEN}[Storage Devices]${RESET}"
if command -v lsblk &> /dev/null; then
    lsblk -o NAME,SIZE,TYPE,MOUNTPOINT
else
    df -h | grep -v tmpfs
fi
echo ""

# Network Interfaces
echo -e "${GREEN}[Network Interfaces]${RESET}"
if command -v ip &> /dev/null; then
    ip link show | grep -E "^[0-9]" | awk '{print $2, $3}'
else
    ifconfig -a | grep -E "^[a-z]" | awk '{print $1}'
fi
echo ""

# PCI Devices
echo -e "${GREEN}[PCI Devices]${RESET}"
if command -v lspci &> /dev/null; then
    lspci | grep -E "VGA|Audio|Ethernet|Network" | head -10
else
    echo "lspci command not available"
fi
echo ""

# USB Devices
echo -e "${GREEN}[USB Devices]${RESET}"
if command -v lsusb &> /dev/null; then
    lsusb | head -10
else
    echo "lsusb command not available"
fi
echo ""

# Graphics Card
echo -e "${GREEN}[Graphics Information]${RESET}"
if command -v lspci &> /dev/null; then
    lspci | grep -i vga
    lspci | grep -i 3d
else
    echo "Graphics information not available"
fi
echo ""

# BIOS/UEFI Information
if [ -r /sys/class/dmi/id/bios_version ]; then
    echo -e "${GREEN}[BIOS Information]${RESET}"
    echo "BIOS Vendor: $(cat /sys/class/dmi/id/bios_vendor 2>/dev/null)"
    echo "BIOS Version: $(cat /sys/class/dmi/id/bios_version 2>/dev/null)"
    echo "BIOS Date: $(cat /sys/class/dmi/id/bios_date 2>/dev/null)"
    echo ""
fi

echo -e "${BLUE}Hardware scan complete!${RESET}"

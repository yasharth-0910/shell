#!/bin/bash

################################################################################
# CollectNetworkInfo.sh - Gather network configuration data
# Usage: CollectNetworkInfo.sh
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RESET="\033[0m"

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║          Network Configuration Report                 ║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${RESET}\n"

# Hostname
echo -e "${GREEN}[Hostname]${RESET}"
hostname
echo ""

# Network Interfaces
echo -e "${GREEN}[Network Interfaces]${RESET}"
if command -v ip &> /dev/null; then
    ip -brief addr show
else
    ifconfig | grep -E "^[a-z]|inet "
fi
echo ""

# Active Connections
echo -e "${GREEN}[Active Network Connections]${RESET}"
if command -v ss &> /dev/null; then
    echo "Listening Ports:"
    ss -tuln | head -10
else
    echo "Listening Ports:"
    netstat -tuln 2>/dev/null | head -10
fi
echo ""

# Routing Table
echo -e "${GREEN}[Routing Table]${RESET}"
if command -v ip &> /dev/null; then
    ip route show
else
    route -n
fi
echo ""

# DNS Configuration
echo -e "${GREEN}[DNS Servers]${RESET}"
if [ -f /etc/resolv.conf ]; then
    grep nameserver /etc/resolv.conf
else
    echo "DNS configuration not found"
fi
echo ""

# Default Gateway
echo -e "${GREEN}[Default Gateway]${RESET}"
if command -v ip &> /dev/null; then
    ip route | grep default
else
    route -n | grep '^0.0.0.0'
fi
echo ""

# Public IP
echo -e "${GREEN}[Public IP Address]${RESET}"
if command -v curl &> /dev/null; then
    PUBLIC_IP=$(curl -s ifconfig.me 2>/dev/null || echo "Unable to determine")
    echo "${PUBLIC_IP}"
else
    echo "curl not available - cannot determine public IP"
fi
echo ""

# Network Statistics
echo -e "${GREEN}[Network Statistics]${RESET}"
if [ -f /proc/net/dev ]; then
    cat /proc/net/dev | grep -E "eth|ens|enp|wlan|wlp" | head -5
fi
echo ""

echo -e "${BLUE}Network information collection complete!${RESET}"

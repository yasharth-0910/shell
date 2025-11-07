#!/bin/bash

################################################################################
# tiny-http.sh - Minimal HTTP server using Bash and netcat
# Usage: tiny-http.sh [port] [document_root]
################################################################################

# Colors
GREEN="\033[1;32m"
BLUE="\033[1;34m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
RESET="\033[0m"
x
# Default configuration
PORT=${1:-8080}
DOC_ROOT=${2:-$(pwd)/www}
LOG_FILE="/tmp/tiny-http-${PORT}.log"

# Create document root if it doesn't exist
if [ ! -d "${DOC_ROOT}" ]; then
    echo -e "${YELLOW}Creating document root: ${DOC_ROOT}${RESET}"
    mkdir -p "${DOC_ROOT}"
    
    # Create a default index.html
    cat > "${DOC_ROOT}/index.html" << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>Tiny HTTP Server</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; background: #f0f0f0; }
        .container { background: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        h1 { color: #333; }
        p { color: #666; line-height: 1.6; }
        .info { background: #e3f2fd; padding: 15px; border-radius: 5px; margin: 20px 0; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 Welcome to Tiny HTTP Server</h1>
        <p>This is a minimal HTTP server implemented in Bash!</p>
        <div class="info">
            <strong>Server Information:</strong><br>
            Status: Running<br>
            Implementation: Bash + netcat<br>
        </div>
        <p>Place your HTML files in the document root to serve them.</p>
    </div>
</body>
</html>
EOF
    echo -e "${GREEN}✓ Created default index.html${RESET}"
fi

# Check if netcat is available
if ! command -v nc &> /dev/null; then
    echo -e "${RED}Error: netcat (nc) is not installed${RESET}"
    echo "Install it using:"
    echo "  Ubuntu/Debian: sudo apt-get install netcat"
    echo "  Fedora/RHEL:   sudo dnf install nc"
    echo "  Arch Linux:    sudo pacman -S gnu-netcat"
    exit 1
fi

# Check if port is already in use
if netstat -tuln 2>/dev/null | grep -q ":${PORT} " || ss -tuln 2>/dev/null | grep -q ":${PORT} "; then
    echo -e "${RED}Error: Port ${PORT} is already in use${RESET}"
    exit 1
fi

echo -e "${BLUE}╔════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BLUE}║              Tiny HTTP Server v1.0                    ║${RESET}"
echo -e "${BLUE}╚════════════════════════════════════════════════════════╝${RESET}\n"

echo -e "${GREEN}Server Configuration:${RESET}"
echo "  Port: ${PORT}"
echo "  Document Root: ${DOC_ROOT}"
echo "  Log File: ${LOG_FILE}"
echo ""
echo -e "${YELLOW}Server is running at:${RESET}"
echo "  http://localhost:${PORT}"
echo "  http://127.0.0.1:${PORT}"
echo ""
echo -e "${YELLOW}Press Ctrl+C to stop the server${RESET}"
echo ""

# Initialize log
echo "=== Tiny HTTP Server Started at $(date) ===" > "${LOG_FILE}"

# MIME type detection
get_mime_type() {
    local file="$1"
    case "${file}" in
        *.html|*.htm) echo "text/html" ;;
        *.css) echo "text/css" ;;
        *.js) echo "application/javascript" ;;
        *.json) echo "application/json" ;;
        *.xml) echo "application/xml" ;;
        *.jpg|*.jpeg) echo "image/jpeg" ;;
        *.png) echo "image/png" ;;
        *.gif) echo "image/gif" ;;
        *.svg) echo "image/svg+xml" ;;
        *.txt) echo "text/plain" ;;
        *) echo "application/octet-stream" ;;
    esac
}

# Handle HTTP request
handle_request() {
    local request_line=""
    local method=""
    local path=""
    local file_path=""
    
    # Read request
    read -r request_line
    
    # Parse request
    method=$(echo "${request_line}" | awk '{print $1}')
    path=$(echo "${request_line}" | awk '{print $2}')
    
    # Log request
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${method} ${path}" | tee -a "${LOG_FILE}"
    
    # Consume headers
    while read -r header; do
        [ "${header}" = $'\r' ] && break
    done
    
    # Handle only GET requests
    if [ "${method}" != "GET" ]; then
        echo -e "HTTP/1.1 405 Method Not Allowed\r"
        echo -e "Content-Type: text/plain\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "405 Method Not Allowed"
        return
    fi
    
    # Remove query string
    path="${path%%\?*}"
    
    # Default to index.html
    if [ "${path}" = "/" ]; then
        path="/index.html"
    fi
    
    # Construct file path
    file_path="${DOC_ROOT}${path}"
    
    # Security: prevent directory traversal
    if [[ "${file_path}" == *".."* ]]; then
        echo -e "HTTP/1.1 403 Forbidden\r"
        echo -e "Content-Type: text/plain\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "403 Forbidden"
        return
    fi
    
    # Serve file
    if [ -f "${file_path}" ]; then
        local mime_type=$(get_mime_type "${file_path}")
        local file_size=$(stat -c%s "${file_path}" 2>/dev/null || stat -f%z "${file_path}" 2>/dev/null)
        
        echo -e "HTTP/1.1 200 OK\r"
        echo -e "Content-Type: ${mime_type}\r"
        echo -e "Content-Length: ${file_size}\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        cat "${file_path}"
    else
        echo -e "HTTP/1.1 404 Not Found\r"
        echo -e "Content-Type: text/html\r"
        echo -e "Connection: close\r"
        echo -e "\r"
        echo "<html><body><h1>404 Not Found</h1><p>The requested resource was not found.</p></body></html>"
    fi
}

# Export function for subshells
export -f handle_request
export -f get_mime_type
export DOC_ROOT
export LOG_FILE

# Start server loop
while true; do
    nc -l -p "${PORT}" -q 1 < <(handle_request) || {
        # Handle nc variations
        nc -l "${PORT}" < <(handle_request) 2>/dev/null
    }
done

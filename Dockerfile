# Custom Bash Shell Environment - Dockerfile
# This allows running the shell in a containerized Linux environment
# Perfect for Windows users or isolated testing

FROM ubuntu:22.04

# Prevent interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone to UTC
ENV TZ=UTC

# Update package list and install dependencies
RUN apt-get update && apt-get install -y \
    bash \
    curl \
    netcat \
    bc \
    coreutils \
    lm-sensors \
    grep \
    sed \
    gawk \
    findutils \
    procps \
    net-tools \
    iproute2 \
    iputils-ping \
    sysstat \
    lsb-release \
    && rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /app

# Copy all project files
COPY . /app

# Make all scripts executable
RUN chmod +x myshell.sh && \
    chmod +x scripts/*.sh && \
    chmod +x install.sh && \
    chmod +x uninstall.sh

# Create config directory
RUN mkdir -p config && \
    touch config/.myshell_history

# Set environment variables
ENV SHELL=/bin/bash
ENV TERM=xterm-256color

# Welcome message
RUN echo '#!/bin/bash' > /etc/profile.d/welcome.sh && \
    echo 'echo "╔════════════════════════════════════════════════════════╗"' >> /etc/profile.d/welcome.sh && \
    echo 'echo "║   Welcome to Custom Bash Shell Environment (Docker)   ║"' >> /etc/profile.d/welcome.sh && \
    echo 'echo "╚════════════════════════════════════════════════════════╝"' >> /etc/profile.d/welcome.sh && \
    echo 'echo ""' >> /etc/profile.d/welcome.sh && \
    echo 'echo "📂 Project directory: /app"' >> /etc/profile.d/welcome.sh && \
    echo 'echo "🚀 Start shell: ./myshell.sh"' >> /etc/profile.d/welcome.sh && \
    echo 'echo "📖 Commands: cat COMMANDS.md"' >> /etc/profile.d/welcome.sh && \
    echo 'echo ""' >> /etc/profile.d/welcome.sh && \
    chmod +x /etc/profile.d/welcome.sh

# Default command - start the custom shell
CMD ["./myshell.sh"]

# Alternative: Start bash shell (for testing)
# CMD ["/bin/bash"]

# Build instructions:
#   docker build -t myshell .
#
# Run instructions:
#   docker run -it myshell
#
# Run with volume mount (access host files):
#   docker run -it -v /path/to/data:/data myshell
#
# Run and start bash instead:
#   docker run -it myshell /bin/bash

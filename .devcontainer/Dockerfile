# docker file for Python development environment
FROM python:latest

# set env vars
ENV DEBIAN_FRONTEND=noninteractive

# system deps - exit on error
RUN set -e && \
    # update and install packages
    apt-get update && apt-get install -y \
    # basic dev tools
    git \
    curl \
    vim \
    wget \
    htop \
    tree \
    zip \
    unzip \
    jq \
    less \

    # secure storage
    # gnome-keyring \
    # dbus-x11 \
    # libsecret-1-0 \

    # build tools
    build-essential \
    pkg-config \

    # network tools
    openssh-client \
    ca-certificates \
    gnupg \

    # search and file tools (for AI)
    ripgrep \

    # docker cli (docker in docker)
    # docker.io \ -- REMOVED FOR PLATFORM RESTRICTIONS

    # ssh server if remote
    # openssh-server \
    sudo \

    # cleanup
    && rm -rf /var/lib/apt/lists/*

# create dev user - exit on error
RUN set -e && \
    # create developer user with sudo permissions
    useradd -ms /bin/bash developer && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# install goose
RUN set -e && \
    # 1. Download the correct stable release tarball
    # We use a temp name and location for the download
    curl -fsSL -o /tmp/goose-cli.tar.bz2 https://github.com/block/goose/releases/download/stable/goose-x86_64-unknown-linux-gnu.tar.bz2 && \
    \
    # 2. Create a temporary extraction directory
    mkdir -p /tmp/goose-extract && \
    \
    # 3. Extract the contents (the 'goose' binary)
    tar -xjf /tmp/goose-cli.tar.bz2 -C /tmp/goose-extract && \
    \
    # 4. Manually move the binary to the correct, system-wide path
    mv /tmp/goose-extract/goose /usr/local/bin/goose && \
    \
    # 5. Clean up temporary files
    rm -rf /tmp/goose-cli.tar.bz2 /tmp/goose-extract && \
    \
    # 6. Verify installation success
    /usr/local/bin/goose --version && \
    \
    # 7. Run your command
    goose update

# install frequent python packages globally - exit on error
RUN set -e && \
    # global installs
    pip install --no-cache-dir \
    # testing
    pytest \
    pytest-cov \

    # dev tools
    ipython \
    ipdb \

    # other libs
    requests \
    python-dotenv

# begin dbus setup - exit on error
# RUN set -e && \
#     # create necessary dirs
#     mkdir -p /var/run/dbus && \
#     mkdir -p /home/developer/.dbus && \
#     chown -R developer:developer /var/run/dbus /home/developer/.dbus && \
#     # initialize dbus
#     dbus-uuidgen > /var/lib/dbus/machine-id && \
#     dbus-uuidgen > /home/developer/.dbus/machine-id && \
#     chown developer:developer /home/developer/.dbus/machine-id

# Create directories - exit on error
RUN set -e && \
    # create workspace and other dirs
    mkdir -p /workspaces /home/developer/.github /commandhistory && \
    chown -R developer:developer /workspaces /home/developer/.github /commandhistory

# set up ssh for developer - exit on error
RUN set -e && \
    # create .ssh dir
    mkdir -p /home/developer/.ssh && \
    chown -R developer:developer /home/developer/.ssh && \
    chmod 700 /home/developer/.ssh

# switch to user
USER developer

# create bashenv additions - exit on error
RUN set -e && \

# append to .bashenv
cat > /home/developer/.bashenv << 'BASHENV_EOF'

# Path configuration
export PATH="/usr/local/bin:$PATH"
export PYTHONPATH="${PYTHONPATH}:/workspaces"

# Goose disable keyring
export GOOSE_DISABLE_KEYRING=1

BASHENV_EOF

# create bashrc additions - exit on error
RUN set -e && \
cat > /home/developer/.bashrc << 'BASHRC_EOF'
# source bashenv
[ -f ~/.bashenv ] && source ~/.bashenv

# bash history configuration
export HISTFILE=/commandhistory/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# aliases (general)
alias ll='ls -laF'
alias la='ls -la'
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color=auto'
BASHRC_EOF

RUN cat > /home/developer/.bash_profile << 'BASH_PROFILE_EOF'
# Source .bashrc if it exists
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
BASH_PROFILE_EOF

# keyring setup in .bashrc
# RUN cat >> /home/developer/.bashrc << 'GNOME_KEYRING_EOF'
# # Start a dbus session if not already running
# if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
#     eval "$(dbus-launch --sh-syntax)"
# fi
# # Start gnome-keyring-daemon if not already running
# if ! pgrep -u "$USER" gnome-keyring-daemon > /dev/null 2>&1; then
#     eval "$(gnome-keyring-daemon --start --components=secrets 2>/dev/null)"
# fi
# GNOME_KEYRING_EOF

# Add welcome banner function to .bashrc
RUN cat >> /home/developer/.bashrc << 'WELCOME_EOF'

# Only show for interactive shells
if [[ $- == *i* ]]; then
    # nice note :)
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  Python + Goose Development Container                  ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo " Python:      $(python --version 2>&1)"
    echo " Goose:       $(goose --version 2>&1)"
    echo ""
    echo " Useful Commands:"
    echo "  - goose configure         Configure your Goose environment"
    echo ""
fi
WELCOME_EOF

# set working directory
WORKDIR /workspaces

# make health check script
RUN cat > /home/developer/healthcheck.sh << 'HEALTHCHECK_EOF'
#!/bin/bash
echo "=== System Health Check ==="
echo "Python: $(python --version)"
echo "Goose: $(goose --version)"
echo "Shell: $SHELL"
HEALTHCHECK_EOF

RUN chmod +x /home/developer/healthcheck.sh

# set healthcheck
HEALTHCHECK --interval=30s --timeout=5s CMD /home/developer/healthcheck.sh || exit 1

# set bash as default shell in container
CMD [ "bin/bash" ]
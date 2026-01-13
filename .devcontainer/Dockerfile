#syntax=docker/dockerfile:1
FROM python:3

LABEL maintainer="Connor Hanan"
LABEL org.opencontainers.image.title="datascience-goose"
LABEL org.opencontainers.image.authors="Connor Hanan"
LABEL org.opencontainers.image.description="Python, R, Julia + goose Development Container"
LABEL org.opencontainers.image.created="2026-01-12"

# build args
ARG TARGETARCH

# setup env
ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8  
ENV LANGUAGE=en_US:en  
ENV LC_ALL=en_US.UTF-8
ENV JULIAUP_DEPOT_PATH=/opt/juliaup
ENV JULIA_DEPOT_PATH=/opt/julia

# install base packages and R/Julia - exit on error
RUN <<INSTALL_EOF
    set -ex
    # GENERAL ----
    # general tools, R tools
    apt-get update && apt-get install -y --no-install-recommends \
        git curl vim wget htop tree zip unzip jq less sudo locales \
        build-essential pkg-config \
        openssh-client ca-certificates gnupg \
        ripgrep \
        \
        r-base r-base-dev \
        libcurl4-openssl-dev libssl-dev libxml2-dev
    # PYTHON ----
    pip install --no-cache-dir --upgrade pip uv
    # R ----
    ln -sf /usr/bin/Rscript /usr/local/bin/Rscript
    echo "en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    # JULIA ----
    curl -fsSL https://install.julialang.org | sh -s -- --yes --path /opt/juliaup
    chmod -R 777 /opt/juliaup
    # CLEANUP ----
    rm -rf /var/lib/apt/lists/*
INSTALL_EOF

# install goose
RUN <<GOOSE_EOF
    set -ex
    trap 'rm -rf /tmp/goose-cli.tar.bz2 /tmp/goose-extract' EXIT
    # check architecture and download appropriate binary
    # possible values: x86_64, aarch64, etc. - default to x86_64 if unknown
    # unzip and make executable
    if [ "$TARGETARCH" = "amd64" ]; then 
        ARCH="x86_64";
    elif [ "$TARGETARCH" = "arm64" ]; then 
        ARCH="aarch64";
    else 
        ARCH="x86_64"; 
    fi
    URL="https://github.com/block/goose/releases/download/stable/goose-${ARCH}-unknown-linux-gnu.tar.bz2"
    mkdir -p /tmp/goose-extract
    curl -fsSL "$URL" -o /tmp/goose-extract/goose.tar.bz2
    tar -xjf /tmp/goose-extract/goose.tar.bz2 -C /tmp/goose-extract
    mv /tmp/goose-extract/goose /usr/local/bin/goose
    chmod +x /usr/local/bin/goose
    rm -rf /tmp/goose-cli.tar.bz2 /tmp/goose-extract
    goose --version
GOOSE_EOF

# Create dev user, workspace and .ssh directories - exit on error
RUN <<USER_EOF
    set -ex
    # create developer user with sudo permissions
    useradd -ms /bin/bash developer
    echo "developer ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
    # create workspace and other dirs
    mkdir -p /workspaces /home/developer/.github /home/developer/.ssh /commandhistory
    chown -R developer:developer /workspaces /home/developer/.github /home/developer/.ssh /commandhistory 
    # change perms for .ssh dir
    chmod 700 /home/developer/.ssh
USER_EOF

# create bashenv additions
COPY --chown=developer:developer <<'BASHENV_EOF' /home/developer/.bashenv
export PATH="/usr/local/bin:/opt/juliaup/bin:$PATH"
export PYTHONPATH="${PYTHONPATH}:/workspaces"
export GOOSE_DISABLE_KEYRING=1
BASHENV_EOF

# create bashrc additions - exit on error
COPY --chown=developer:developer <<'BASHRC_EOF' /home/developer/.bashrc
# source bashenv and juliaup root if it exists
[ -f ~/.bashenv ] && source ~/.bashenv
[ -f /root/.bashrc ] && source /root/.bashrc
set history file to shared volume
export HISTFILE=/commandhistory/.bash_history
export HISTSIZE=10000
export HISTFILESIZE=20000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
# make aliases
alias ll='ls -laF'
alias la='ls -la'
alias ..='cd ..'
alias grep='grep --color=auto'
# welcome message if interactive
if [[ $- == *i* ]]; then
    echo ""
    echo "╔════════════════════════════════════════════════════════╗"
    echo "║  Python, R, Julia + goose Development Container        ║"
    echo "╚════════════════════════════════════════════════════════╝"
    echo ""
    echo " Python:      $(python --version 2>&1)"
    echo " R:           $(R --version | head -n 1 2>&1)"
    echo " Julia:       $(julia --version 2>&1)"
    echo " goose:      $(goose --version 2>&1)"
    echo ""
    echo " Notes:"
    echo "  - Your workspace is located at /workspaces"
    echo "  - Prefer 'uv' to 'pip' for installing Python packages"
    echo ""
    echo " Useful Commands:"
    echo "  - goose configure         Configure your goose environment"
    echo "  - goose session           Start a new goose session"
    echo "  - goose session -r        Resume last goose session"
    echo "  - goose web --open        Start goose web interface (experimental)"
    echo ""
    echo " Visit https://block.github.io/goose/docs/category/guides for more information."
    echo ""
fi
BASHRC_EOF

# create bash profile to source bashrc - exit on error
COPY --chown=developer:developer <<'BASHPROFILE_EOF' /home/developer/.bash_profile
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
BASHPROFILE_EOF

# make healthcheck script
COPY --chown=developer:developer <<'HEALTHCHECK_EOF' /usr/local/bin/healthcheck.sh
#!/bin/bash
echo "=== System Health Check ==="
echo "Python: $(python --version)"
echo "R: $(R --version | head -n 1)"
echo "Julia: $(julia --version)"
echo "Goose: $(goose --version)"
echo "Shell: $SHELL"
HEALTHCHECK_EOF

# finalize permissions and switch to user
RUN chmod +x /usr/local/bin/healthcheck.sh && \ 
    chown developer:developer /home/developer/.*
WORKDIR /workspaces
USER developer
HEALTHCHECK --interval=30s --timeout=5s CMD /usr/local/bin/healthcheck.sh || exit 1

# set bash as default shell in container
CMD [ "/bin/bash" ]
#!/bin/bash

set -e

# Install Claude Code CLI
if command -v claude &> /dev/null; then
    echo "Claude Code is already installed: $(claude --version)"
else
    echo "Installing Claude Code..."
    curl -fsSL https://claude.ai/install.sh | bash
fi

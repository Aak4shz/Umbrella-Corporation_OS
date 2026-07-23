# ~/.zshrc — Umbrella OS Shell Configuration

export ZSH="$HOME/.oh-my-zsh"

# Theme — Powerlevel10k with Red Queen customization
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  python
  pip
  gradle
  mvn
  docker
  history
  colored-man-pages
  command-not-found
)

[[ -f $ZSH/oh-my-zsh.sh ]] && source $ZSH/oh-my-zsh.sh

# ─── UMBRELLA OS Environment Variables ────────────────────────────────────────
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
export PATH=$JAVA_HOME/bin:$PATH
export PYTHONPATH=$HOME/.local/lib/python3.12:$PYTHONPATH
export OLLAMA_HOST=127.0.0.1:11434

# ─── Aliases — Red Queen Commands ─────────────────────────────────────────────
alias cls="clear"
alias ll="eza -lh --icons --git 2>/dev/null || ls -lh --color=auto"
alias la="eza -la --icons --git 2>/dev/null || ls -la --color=auto"
alias ..="cd .."
alias ...="cd ../.."

# Git shortcuts
alias gs="git status"
alias ga="git add ."
alias gc="git commit -m"
alias gp="git push"
alias gl="git log --oneline --graph --decorate --all"

# AI shortcuts
alias ai="ollama run llama3.2"
alias aider="aider --model ollama/llama3.2"

# Java shortcuts
alias jrun="java -jar"
alias mci="mvn clean install"
alias mcp="mvn clean package"

# Python shortcuts  
alias py="python3"
alias pip="pip3"
alias venv="python3 -m venv"
alias activate="source ./venv/bin/activate"

# Umbrella OS Interactive Welcome Banner
if [[ $- == *i* ]]; then
  echo ""
  echo "  🔴 UMBRELLA CORPORATION"
  echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "  Welcome back, $(whoami | tr '[:lower:]' '[:upper:]')"
  echo "  Authorized Access Granted | $(date '+%A, %B %d %Y — %H:%M:%S')"
  echo "  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo ""
  command -v fastfetch &>/dev/null && fastfetch
fi

# Powerlevel10k instant prompt
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ~/.zshrc

# Historial
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

eval "$(fnm env --shell zsh)"

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# Inicialización
autoload -Uz compinit colors
compinit
colors

# Prompt simple
PROMPT='%F{blue}%n@%m%f %F{green}%~%f '

# Bun
export PATH="/home/shoot/.bun/bin:$PATH"

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# fzf
if command -v fzf >/dev/null 2>&1; then
  source /usr/share/fzf/key-bindings.zsh 2>/dev/null
  source /usr/share/fzf/completion.zsh 2>/dev/null
fi

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# Plugins externos (orden importante)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Aliases
alias ll='ls -lah'
alias la='ls -A'
alias gpo='git pull origin'
alias gc='git checkout'
alias nv='nvim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'
alias pkl='port-kill --list'
alias pk='port-kill'
alias cd='z'

# PATH
export PATH="$HOME/.local/bin:$PATH"
# opencode
export PATH=/home/shoot/.opencode/bin:$PATH

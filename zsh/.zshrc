# ~/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Historial
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

# PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/shoot/.bun/bin:$PATH"
export PATH=/home/shoot/.opencode/bin:$PATH

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git fzf node npm zoxide)

source "$ZSH/oh-my-zsh.sh"

# fnm (Node version manager)
eval "$(fnm env --shell zsh)"

# zoxide
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf key bindings y completions
if command -v fzf >/dev/null 2>&1; then
  source /usr/share/fzf/key-bindings.zsh 2>/dev/null
  source /usr/share/fzf/completion.zsh 2>/dev/null
fi

# Plugins externos (orden importante: autosuggestions antes que syntax-highlighting)
if [ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Aliases
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza --icons --color=always --group-directories-first -lah --git --git-repos'
alias la='eza --icons --color=always --group-directories-first -a'
alias lt='eza --icons --color=always --group-directories-first --tree --level=2'
alias grep='grep --color=auto'
alias gpo='git pull origin'
alias gc='git checkout'
alias nv='nvim'
alias ..='z ..'
alias ...='z ../..'
alias ....='z ../../..'
alias pkl='port-kill --list'
alias pk='port-kill'
alias cd='z'
alias kiro='kiro-cli'

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/shoot/.lmstudio/bin"
# End of LM Studio CLI section


# kimi-code
export PATH="/home/shoot/.kimi-code/bin:$PATH"

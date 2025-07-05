# Load environment variables
if [ -f ~/.env ]; then
    . ~/.env
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                  PLUGINS                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# zinit (plugin manager)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Load completions on startup
autoload -Uz compinit && compinit
zinit cdreplay -q

# zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit ice lucid nocompile; zinit load MenkeTechnologies/zsh-cargo-completion
if [ -x "$(command -v fzf)" ]; then
   zinit light Aloxaf/fzf-tab
fi

# Snippets
zinit snippet OMZP::command-not-found

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                   CONFIG                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# Keybindings (more info in https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets)
bindkey '^f' autosuggest-accept
bindkey '^f' accept-search
bindkey '^M' accept-line
bindkey '^f' forward-char
bindkey '^b' backward-char
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^[b' vi-backward-blank-word
bindkey '^[w' vi-forward-blank-word
bindkey '^k' history-search-backward
bindkey '^j' history-search-forward
bindkey '^[[H' beginning-of-line  # fix Home key
bindkey '^[[F' end-of-line  # fix End key
bindkey '^[[3~' delete-char  # fix Del key
bindkey '^H' backward-kill-word  # fix Ctrl+Backspace
bindkey '^[[3;5~' kill-word  # fix Ctrl+Del
bindkey '^[[1;5C' forward-word # fix Ctrl+Right
bindkey '^[[1;5D' backward-word # fix Ctrl+Left
bindkey '^?' backward-delete-char # fix annoying vi backspace

# Autocompletion setup
EZA_PREVIEW="eza -1 --group-directories-first --icons=auto --color=always"
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'  # smartcase
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"  # colors on file completion
zstyle ':completion:*' menu no  # no default menu (use fzf)
zstyle ':completion:*:descriptions' format '[%d]' # show completion groups with colors
zstyle ':fzf-tab:complete:cd:*' fzf-preview "$EZA_PREVIEW \$realpath"  # fzf for cd w/ eza
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'  # fzf for cd
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview "$EZA_PREVIEW \$realpath"  # fzf for zoxide
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-f:accept'
zstyle ':fzf-tab:*' accept-line enter
zstyle ':fzf-tab:*' switch-group '<' '>' # switch group using `<` and `>`
zstyle ':fzf-tab:*' use-fzf-default-opts yes # make fzf-tab follow FZF_DEFAULT_OPTS

# Update fzf-tab preview size whenever the terminal height changes
check_terminal_size () {
    if [[ "$LINES" != "$previous_lines" ]]; then
        zstyle ':fzf-tab:*' fzf-pad $(($LINES/3))
    fi
    previous_lines=$LINES
}
check_terminal_size
trap 'check_terminal_size' WINCH # Executes a command when the signal is received

# History
HISTSIZE=5000
HISTFILE="${XDG_STATE_HOME}"/zsh/history
SAVEHIST=$HISTSIZE
HISTDUP=erase # Delete duplicate entries
setopt appendhistory # Append commands instead of overwrite
setopt sharehistory # Share between sessions
setopt hist_ignore_space # Don't add commands prefixed with a space
setopt hist_ignore_all_dups # Don't save duplicate commands
setopt hist_save_no_dups # Don't save duplicate commands
setopt hist_ignore_dups # Don't save duplicate commands
setopt hist_find_no_dups # Don't show duplicates in history search

# Add home folder directories aliases
alias -g downloads=~/Descargas
alias -g documents=~/Documentos
alias -g pictures=~/Imágenes
alias -g videos=~/Vídeos

# Generic shell config
if [ -f ~/.sh_config ]; then
    . ~/.sh_config
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                   PROMPT                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if [ -x "$(command -v starship)" ]; then
    eval "$(starship init zsh)"
fi

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                             SHELL INTEGRATIONS                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# fzf
if [ -x "$(command -v fzf)" ]; then
    # eval "$(fzf --zsh)" # requires newer version
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

# Fastfetch
if [ -x "$(command -v fastfetch)" ]; then
    fastfetch
fi

# zoxide
if [ -x "$(command -v zoxide)" ]; then
    export _ZO_FZF_OPTS="
        $FZF_DEFAULT_OPTS
        --exact
        --no-sort
        --keep-right
        --height=50%
        --exit-0
        --preview='$EZA_PREVIEW {2..}'
    "
    eval "$(zoxide init --cmd cd zsh)"
fi

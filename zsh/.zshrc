# Time function for benchmarking
# delta-t() {
#     local now diff
#     now=$(date +%s%N)
#
#     if [[ -n ${_delta_last:-} ]]; then
#         diff=$((now - _delta_last))
#         printf '%s:\t%d.%03d ms\n' $1 $((diff / 1000000)) $((diff % 1000000 / 1000))
#     fi
#
#     _delta_last=$now
# }

# delta-t

# Load environment variables
if [[ -f ~/.env ]]; then
    . ~/.env
fi

# delta-t "Env variables"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                  PLUGINS                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# antidote (plugin manager)
ANTIDOTE_HOME="${ZDOTDIR:-${XDG_DATA_HOME}/.local/share}/.antidote"

if [[ ! -d "$ANTIDOTE_HOME" ]]; then
   mkdir -p "$(dirname $ANTIDOTE_HOME)"
   git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_HOME"
fi

source "${ANTIDOTE_HOME}/antidote.zsh"

antidote load

# delta-t "Plugins"

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

# Generic
setopt auto_param_slash  # When a dir is completed, add a / instead of a trailing space

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

# delta-t "zsh config"

# Generic shell config
if [[ -f ~/.sh_config ]]; then
    . ~/.sh_config
fi

# delta-t "shell config"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                                   PROMPT                                   ║
# ╚════════════════════════════════════════════════════════════════════════════╝

if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
fi

# delta-t "Prompt"

# ╔════════════════════════════════════════════════════════════════════════════╗
# ║                             SHELL INTEGRATIONS                             ║
# ╚════════════════════════════════════════════════════════════════════════════╝

# fzf
if (( $+commands[fzf] )); then
    # eval "$(fzf --zsh)" # requires newer version
    source /usr/share/doc/fzf/examples/key-bindings.zsh
    source /usr/share/doc/fzf/examples/completion.zsh
fi

# Fastfetch
if (( $+commands[fastfetch] )); then
    fastfetch
    echo -n "\n\n\n\n" # Fix defer plugins moving the prompt up
fi

# zoxide
if (( $+commands[zoxide] )); then
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

# git-delta
if (( $+commands[delta] )); then
    eval "$(delta --generate-completion zsh)"
fi

# delta-t "Integrations"


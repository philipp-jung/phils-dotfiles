# Plugins
source ~/.zplug/init.zsh

# nvm https://github.com/trapd00r/LS_COLORS
zplug "lukechilds/zsh-nvm"

# Load zsh-syntax-highlighting; must be last plugin sourced.
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug load #--verbose  # needs this at the bottom

# make a nice prompt
PROMPT='%(?.%F{green}√.%F{red}?%?)%f %B%F{240}%1~%f%b %# '

# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000

# Luke's config for the Zoomer Shell

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

export PATH=/opt/transcribe/transcribe:$PATH
export PATH=~/.local/bin:$PATH

# Command history file location
HISTFILE=/home/phil/.zhistory

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Load aliases and shortcuts if existent.
[ -f "$HOME/.shortcutrc" ] && source "$HOME/.shortcutrc"
[ -f "$HOME/.aliasrc" ] && source "$HOME/.aliasrc"

# Fix for PyCharm
_JAVA_AWT_WM_NONREPARENTING=1

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/phil/google-cloud-sdk/path.zsh.inc' ]; then . '/home/phil/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/phil/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/phil/google-cloud-sdk/completion.zsh.inc'; fi

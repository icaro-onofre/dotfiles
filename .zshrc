export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/ssh-agent.socket
alias tmux="TERM=screen-256color-bce tmux"
autoload -U colors && colors

setopt prompt_subst
# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }

eval "$(starship init zsh)"
# History in cache directory:
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/history

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
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"

# Load zsh-syntax-highlighting; should be last.
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null


# Glob qualifiers
setopt no_bare_glob_qual

#Neovim switcher
function nvims() {
  items=("default" "astro-nvim" "nvchad" "lazynvim" "nvim-debug-test")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

bindkey -s ^a "nvims\n"

bindkey -s ^a "nvims\n"

source ~/.zshaliases
source ~/.zshaliases_dangerous
source ~/.zshexports
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent


#Keybindings

bindkey '^R' history-incremental-search-backward # Back incremental search
bindkey -s '^f' 'ranger --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"^M'
bindkey -s '^h' 'htop^M'
bindkey -s '^g' 'lazygit^M'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

[[ -s "/home/fforelle/.gvm/scripts/gvm" ]] && source "/home/fforelle/.gvm/scripts/gvm"

export CHROME_EXECUTABLE=chromium 


# bun completions
[ -s "/home/fforelle/.bun/_bun" ] && source "/home/fforelle/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

[[ -s "/home/icaro/.gvm/scripts/gvm" ]] && source "/home/icaro/.gvm/scripts/gvm"

export PATH="/opt/flutter/bin:$PATH"

# escritorio | export PATH="$PATH:/home/icaro/bin/nvim-linux64/bin"

export CHROME_EXECUTABLE="chromium"

#Zoxide setup
eval "$(zoxide init zsh)"

# BEGIN Funções Úteis
# ctrl+z para toglar entre bg e fg (Encontrei aqui: https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0 ]]; then
    BUFFER="fg"
    zle accept-line
  else
    zle push-input
    zle clear-screen
  fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# END Funções Úteis

# Export paths
# Jboss
export JBOSS_HOME=/home/fforelle/work/dev/unifrota_jboss
export EAP_HOME=/home/fforelle/work/dev/unifrota_jboss_experimental
export PATH=$PATH:$JBOSS_HOME/bin

export OPENAI_KEY="sk-proj-SS90Xqouqdi8cJ5ryW2dT3BlbkFJSiUByXcQZ6seexwS3kKr"



# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Eclipse configs
# escritorio export PATH=$PATH:/home/icaro/bin/eclipse
# escritorio export PATH=$PATH:/home/icaro/bin/nvim-linux64/bin
export PATH=$PATH:/home/fforelle/go/bin
export PATH=$PATH:/home/fforelle/.cargo/bin


# Cloud consoles
# google cloud
export PATH=$PATH:/home/fforelle/bin/google-cloud-sdk/bin

export PATH=$PATH:/home/fforelle/bin/cmdline-tools/bin

export PATH=$PATH:/home/fforelle/bin/flutter/bin
export PATH=$PATH:/usr/bin/dlv


# pnpm
export PNPM_HOME="/home/fforelle/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
#
# Configuring neovim on debian
export PATH=$PATH:/home/fforelle/bin/nvim-linux-x86_64/bin

export PATH=$PATH:/home/fforelle/bin

export PATH=$PATH:/usr/local/go/bin

export PATH=$PATH:/home/fforelle/bin/cmake-4.1.0-linux-aarch64/bin

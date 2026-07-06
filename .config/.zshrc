# Created by gojira_96 for 5.9
bindkey -e
bindkey '^R' history-incremental-search-backward

HISTFILE=~/.zs_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

pokeshell -s garchomp 2>/dev/null
eval "$(starship init zsh)"

export EDITOR=nvim
export VISUAL=nvim

alias gcc='gcc -std=c23'
alias clang='clang -std=c23'
alias g++='g++ -std=c++20'
alias clang++='clang++ -std=c++20'

alias nvim="kitty --class nvim-solid -o background_opacity=1.0 -e nvim"


if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"
fi

bindkey "^[[3~" delete-char

autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case insensitive


export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

precmd() { echo; }

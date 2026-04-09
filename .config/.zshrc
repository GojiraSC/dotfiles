# Created by gojira_96 for 5.9
bindkey -e
bindkey '^R' history-incremental-search-backward

HISTFILE=~/.zs_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY

pokeshell -s feraligatr 2>/dev/null


alias gcc='gcc -std=c23'
alias clang='clang -std=c23'

alias g++='g++ -std=c++20'
alias clang++='clang++ -std=c++20'

alias gcc11='gcc -std=c11'
alias g++17='g++ -std=c++17'


if test -n "$KITTY_INSTALLATION_DIR"; then
    export KITTY_SHELL_INTEGRATION="enabled"
    source "$KITTY_INSTALLATION_DIR/shell-integration/zsh/kitty.zsh"
fi

eval "$(oh-my-posh init zsh --config ~/.poshthemes/themes/kali.omp.json)"

bindkey "^[[3~" delete-char

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case insensitive

precmd() { echo; }

echo 'export PATH=~/bin:$PATH' >> ~/.zsh_profile
source ~/.zsh_profile

export PATH="$HOME/.local/share/bob/nvim-bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

source /usr/share/zsh/share/antigen.zsh

antigen use oh-my-zsh

antigen bundle aws
antigen bundle git
antigen bundle gitfast
antigen bundle git-extras
antigen bundle colorize
antigen bundle extract
antigen bundle docker
antigen bundle history
#antigen bundle kubectl
antigen bundle kube-ps1
antigen bundle pip
antigen bundle python
#antigen bundle ssh-agent
antigen bundle sudo
antigen bundle tmux
antigen bundle tmuxinator
antigen bundle vagrant
antigen bundle virtualenv

antigen bundle MichaelAquilina/zsh-autoswitch-virtualenv
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle unixorn/autoupdate-antigen.zshplugin

antigen theme https://github.com/mariusrejdak/zsh-config.git marius.zsh-theme

antigen apply

setopt inc_append_history
setopt share_history

source /usr/share/nvm/init-nvm.sh
source /etc/profile.d/jre.sh
eval "$(direnv hook zsh)"

export HOST=$HOST
export EDITOR=vim
#export PATH=$HOME/.bin:$HOME/.local/bin:$PATH
export PATH=$HOME/.bin:$HOME/.local/bin:$HOME/projects/go/bin:$PATH
#export GOPATH=$HOME/projects/go
export WORKON_HOME=$HOME/.virtualenvs
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
[[ "$COLORTERM" == "xfce4-terminal" ]] && export TERM=xterm-256color

alias s='git status -sb'

# Pretty json
alias pjson='python -m json.tool'
# alias cat='bat'

alias mfa='oathtool --totp -b "A7QSDFAI7LHJADILTJA5TSZE7E2E2RJLZNDA3WJCI55Z5GA45C3NJROZSFJ3IWAM"'

# Disable autocorrect
unsetopt correct_all

# autoload -U bashcompinit
# bashcompinit

#bindkey "^[[7~" beginning-of-line #Home key
#bindkey "^[[8~" end-of-line #End key
#bindkey "^[[3~" kill-word # control + delete

function man() {
    env LESS_TERMCAP_mb=$'\E[1;31m'   `# blink `    \
        LESS_TERMCAP_md=$'\E[1;32m'   `# bold `     \
        LESS_TERMCAP_me=$'\E[0m'                    \
        LESS_TERMCAP_se=$'\E[0m'                    \
        LESS_TERMCAP_so=$'\E[7m'      `# standout ` \
        LESS_TERMCAP_ue=$'\E[0m'                    \
        LESS_TERMCAP_us=$'\E[1;4;34m' `# underline` \
        /usr/bin/man "$@"
}

pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

if [[ -f "$HOME/.zshrc_local" ]]; then
	source $HOME/.zshrc_local
fi

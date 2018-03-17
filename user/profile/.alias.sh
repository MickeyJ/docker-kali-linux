
_nmp(){
    local ports=${1}
    local address=${2}
    nmap -p ${ports} ${address}
}

_setTheme(){
    local theme=${1}
    sed -i "/^ZSH_THEME/c\ZSH_THEME=${theme}" ~/.zshrc
    source ~/.zshrc
}

_editTheme(){
    local theme=${1}
    nano ~/profile/zsh-theme && cp ~/profile/zsh-theme ~/.oh-my-zsh/themes/${theme}.zsh-theme
    _setTheme ${theme}
}

_buildC(){
    local name=${1}
    local main=${2}
    sudo gcc -o /usr/bin/${name} ${main}.c
}

_srvSql(){
    sudo /etc/init.d/postgresql ${1}
}

_psqlIn(){
    local user=${USERNAME}
    psql -d ${user} -U ${user}
}


# helper functions
alias nmp=_nmp
alias setTheme=_setTheme
alias editTheme=_editTheme
alias buildC=_buildC
alias srvSql=_srvSql
alias psqlIn=_psqlIn


# git commands
alias gc='git commit -m'
alias gpo='git push origin'
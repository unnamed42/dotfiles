
alias up='yay -Syu'

alias pi='pacman -Si'
alias po='pacman -Qo'
alias pq='pacman -Qi'
alias pl='pacman -Ql'

function poc() {
    pacman -Qo $(which $1)
}

function pol() {
    pacman -Ql $(pacman -Qoq $(which $1))
}

alias psin='sudo pacman -S --needed'
alias ys='yay -S --needed'
alias pss='pacman -Ss'
alias yss='yay -Ss'

alias prus='sudo pacman -Rsscun'
alias pu='sudo pacman -U'
alias pc='sudo pacman -Sc'

alias hcgs='hexo clean && hexo g && hexo s'
alias hgs='hexo g && hexo s'
alias chgs='rm -rf /home/h/site/public/{css,js} && hexo g &&
hexo s'

alias restart='systemctl restart'
alias status='systemctl status'
alias enable='systemctl enable'
alias disable='systemctl disable'
alias reboot='systemctl reboot'
alias poweroff='systemctl poweroff'

PATH="$PATH:$HOME/site/node_modules/hexo/bin"
#export npm_config_prefix=~/.node_modules

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

function md() {
    if mkdir -p $1; then cd $1; fi
}

function gcommit() {
    if ! git add -A; then return $?; fi
    if [ -z "$1" ]; then
        if ! git commit; then return $?; fi
    else
        git commit -m "$1"
    fi
}

function gpush() {
    gcommit $1
    git push
}

function clearwine() {
    rm -f ~/.local/share/applications/wine-extension*.desktop
    rm -f ~/.local/share/icons/hicolor/*/*/application-x-wine-extension*
    rm -f ~/.local/share/applications/mimeinfo.cache
    rm -f ~/.local/share/mime/packages/x-wine*
    rm -f ~/.local/share/mime/application/x-wine-extension*
    update-desktop-database ~/.local/share/applications
    update-mime-database ~/.local/share/mime/
}

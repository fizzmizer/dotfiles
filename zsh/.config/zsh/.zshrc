[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

plug "zap-zsh/vim"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"


HISTFILE=$HOME/.cache/zsh/history

bindkey '^ ' autosuggest-accept

alias ch="cd ~/Documents/Works-in-progress/wip/chapitres/"
alias ww="cd ~/Documents/Works-in-progress/"
alias vc="nvim ~/.config/nvim/init.lua"
alias brc="nvim ~/.bashrc"
alias v="nvim"
alias u="cd ~/Documents/universite/"
alias syu="sudo pacman -Syu"
alias gpom="git push origin main"
alias gs="git status"
alias r="ranger"
alias cd="z"
alias yt480="yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"
alias yt720="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"

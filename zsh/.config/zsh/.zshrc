[ -f "$HOME/.local/share/zap/zap.zsh" ] && source "$HOME/.local/share/zap/zap.zsh"


eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(fzf --zsh)"

plug "zap-zsh/vim"
plug "zap-zsh/supercharge"
plug "zsh-users/zsh-syntax-highlighting"
plug "zsh-users/zsh-autosuggestions"
plug "Aloxaf/fzf-tab"

HISTSIZE=10000
SAVEHIST=10000
HISTFILE=$HOME/.cache/zsh/history
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups



zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'


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
alias r="y"
alias lf="lfub"
alias cd="z"
alias yt480="yt-dlp -f 'bestvideo[height<=480]+bestaudio/best[height<=480]'"
alias yt720="yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]'"


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

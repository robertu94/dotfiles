# Environmental Variables (((
export GOPATH=$HOME/go
export GOROOT=/usr/lib/golang
export PATH=$PATH:$GOROOT:$GOPATH/bin:$HOME/.local/bin
export PYTHONPATH=$PYTHONPATH:$HOME/repos:$HOME/repos/docker/cloudops/cloudops
#)))

# Preferred applications (((
export BROWSER="firefox"
export EDITOR="vim"
export FILE_BROWSER="thunar"
export IRC_CLIENT="irssi"
export MAIL_CLIENT="${BROWSER} gmail.com"
export MUSIC_PLAYER="firefox pandora.com"
export PAGER="/usr/local/bin/vimpager"
export SXHKD_SHELL="bash"
export TERMINAL="urxvt"
export VIRTUALIZATION="virt-manager"
if [ "$XDG_CURRENT_DESKTOP" = "KDE" ]; then
	export SSH_ASKPASS="/usr/bin/ksshaskpass"
fi
#)))

# Aliases (((
alias '...'="cd ../.."
alias '....'="cd ../../.."
alias '.....'="cd ../../../.."
alias ansible-playbook="ansible-playbook --ask-vault-pass"
alias ansible="ansible --ask-vault-pass"
alias dnf="sudo dnf"
alias docker="sudo docker"
alias less=$PAGER
alias o="xdg-open"
alias pacman="sudo pacman"
alias py3=python3
alias rdesktop="rdesktop -K -f"
alias salt="sudo salt"
alias zless=$PAGER
alias zfs="sudo zfs"
alias zpool="sudo zpool"
#)))

# vim: foldmethod=marker foldmarker=(((,)))

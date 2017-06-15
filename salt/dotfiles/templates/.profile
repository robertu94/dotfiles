# Environmental Variables (((
export GOPATH=$HOME/go
export GOROOT=/usr/lib/go
export PATH=$PATH:$GOROOT:$GOPATH/bin:$HOME/.local/bin:/usr/sbin:/sbin

#)))

# Preferred applications (((
export BROWSER="firefox"
export EDITOR="vim"
export FILE_BROWSER="thunar"
export IRC_CLIENT="irssi"
export MAIL_CLIENT="${BROWSER} gmail.com"
export MUSIC_PLAYER="${BROWSER} pandora.com"
export PAGER="${HOME}/.vim/bundle/vimpager/vimpager"
export SXHKD_SHELL="bash"
export TERMINAL="urxvt"
export VIRTUALIZATION="virt-manager"
if [ "${XDG_CURRENT_DESKTOP}" = "KDE" ]; then
	export SSH_ASKPASS="/usr/bin/ksshaskpass"
fi
#)))

# Aliases (((
alias '...'="cd ../.."
alias '....'="cd ../../.."
alias '.....'="cd ../../../.."
alias ansible-playbook="ansible-playbook --ask-vault-pass"
alias ansible="ansible --ask-vault-pass"
alias dia="dia --integrated"
alias dnf="sudo dnf"
alias docker="sudo docker"
alias emerge="sudo emerge"
alias less=${PAGER}
alias o="xdg-open"
alias pacman="sudo pacman"
alias py3=python3
alias rdesktop="rdesktop -K -f"
alias salt="sudo salt"
alias vim=nvim
alias mountzfs="sudo zpool import mypool -R /mnt/usb"
alias zless=${PAGER}
alias zfs="sudo zfs"
alias zpool="sudo zpool"
#)))

function screensaveroff(){
	xset dpms 7200 7200 7200
	xset s 7200 7200
}


# Gentoo (((
#gentoo llvm binaries installed without symlink, add them to path
export PATH=$PATH:/usr/lib/llvm/4/bin
function eupdate(){
	emerge --sync
	emerge --update --newuse --with-bdeps=y --deep @world
	emerge --depclean
	sudo revdep-rebuild
}
#)))

# vim: foldmethod=marker foldmarker=(((,)))

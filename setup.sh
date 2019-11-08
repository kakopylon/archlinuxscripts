#!/bin/sh

# install yay and packages
if ! type "yay" > /dev/null 2>&1; then
	git clone https://aur.archlinux.org/yay.git
	cd yay; makepkg -si --noconfirm
	cd ../; rm -rf yay
fi
yay -Syu --noconfirm `cat packages | xargs`

# link config files
for file in `sh -c "ls -AFd .* | egrep -v '/|@'" | xargs`
do
	ln -sfnv `find $(pwd) -name "$file"` $HOME/$file
done
for dir in `sh -c "ls .config" | xargs`
do
	mkdir -p $HOME/.config/$dir
	ln -sfnv `find $(pwd)/.config -name "$dir"`/config $HOME/.config/$dir/config
done

# docker
sudo usermod -aG docker $USER
sudo systemctl enable docker

# ghq
GOPATH=$HOME/go go get -u -v github.com/motemen/ghq

# timedatectl
sudo timedatectl set-ntp true

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ln .vimrc ~/.vimrc

# zsh
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
ln .zshrc ~/.zshrc

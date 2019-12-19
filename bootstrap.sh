#!/run/current-system/sw/bin/zsh
echo "Installing .dot"
if [ -d ~/.dot/ ]; then
  echo "~/.dot/ directory already exists: do nothing"
else
  cd ~/
  git clone git@github.com:magnetophon/.dot.git
  cd ~/.dot/
  echo "get submodules"
  git submodule update --init --recursive
#  git clone https://github.com/gmarik/vundle.git ~/.dot/spf13-vim-3/.spf13-vim-3/.vim/bundle/vundle
#  echo "install vim plugins"
#  vim \
#    -u ~/.dot/spf13-vim-3/.spf13-vim-3/.vimrc.bundles.default \
#    +set nomore \
#    +BundleInstall! \
#    +BundleClean \
#    +qall
  cd ~/.dot/
  echo "stow dotfiles"
  for item in common zprezto; do stow $item; done;
  stow $HOST
  echo "make dummy vim dir and rc for nixos myvim"
  mkdir ~/.vim
  touch ~/.vimrc
fi
echo "done! :)"

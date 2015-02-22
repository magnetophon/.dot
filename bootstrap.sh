#!/run/current-system/sw/bin/zsh
echo "Installing .dot"
if [ -d ~/.dot/ ]; then
  echo "~/.dot/ directory already exists: do nothing"
else
  cd ~/
  git clone https://github.com/magnetophon/.dot.git
  cd ~/.dot/
  echo "get submodules"
  git submodule update --init --recursive
  git clone https://github.com/gmarik/vundle.git ~/.dot/spf13-vim-3/.spf13-vim-3/.vim/bundle/vundle
  echo "install vim plugins"
  vim \
    -u ~/.dot/spf13-vim-3/.spf13-vim-3/.vimrc.bundles.default \
    +set nomore \
    +BundleInstall! \
    +BundleClean \
    +qall
  cd ~/.dot/
  echo "stow dotfiles"
  for item in common zprezto spf13-vim-3; do stow $item; done;
fi
echo "done! :)"

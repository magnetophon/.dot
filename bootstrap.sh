#!/run/current-system/sw/bin/zsh

echo "Installing .dot"

if [ -d ~/.dot/ ]; then
  echo "~/.dot/ directory already exists: do nothing"
else
  cd ~/
  git clone https://github.com/magnetophon/.dot.git
  cd ~/.dot/
  echo "clone submodules"
  git submodule update --init --recursive
  #cd ~/.dot/spf13-vim-3/.spf13-vim-3
  #git submodule init
  #git submodule update
  #cd ~/.dot/spf13-vim-3/.spf13-vim-3/.vim/bundle/vundle
  if [ ! -e ~/.dot/spf13-vim-3/.spf13-vim-3/.vim/bundle/vundle  ]; then
      git clone https://github.com/gmarik/vundle.git ~/.dot/spf13-vim-3/.spf13-vim-3/.vim/bundle/vundle
  else
    echo "vundle already exists: skip"
  fi
  echo "install vim plugins"
  vim \
    -u ~/.dot/spf13-vim-3/.spf13-vim-3/.vimrc.bundles.default \
    +set nomore \
    +BundleInstall! \
    +BundleClean \
    +qall
  cd ~/.dot/

  echo "stow the dotfiles"
  for item in common zprezto spf13-vim-3; do stow $item; done;
#  for item in common zprezto nixos-zsh-completion spf13-vim-3 do stow $item; done;
#  stow common

#  cd $dot_dir/spf13-vim-3/.spf13-vim-3/
#  git remote add upstream git@github.com:spf13/spf13-vim.git
#  cd $dot_dir/zprezto/.zprezto/
#  git remote add upstream git@github.com:sorin-ionescu/prezto.git

fi
echo "done! :)"

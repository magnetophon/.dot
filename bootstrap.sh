#!/run/current-system/sw/bin/zsh

echo "Installing .dot"

dot_dir="~/.dot"
if [ -d $dot_dir ]; then
  echo "$dot_dir directory already exists: do nothing"
else
  cd ~/
  git clone https://github.com/magnetophon/.dot.git
  cd $dot_dir

  git submodule init
  git submodule update
  echo "stow the dotfiles"
  for item in common zprezto spf13-vim-3; do stow $item; done;
#  for item in common zprezto nixos-zsh-completion spf13-vim-3 do stow $item; done;
#  stow common
  cd ~/.vim/bundle/vundle
  git checkout master
  vim +BundleInstall! +BundleClean +q

#  cd $dot_dir/spf13-vim-3/.spf13-vim-3/
#  git remote add upstream git@github.com:spf13/spf13-vim.git
#  cd $dot_dir/zprezto/.zprezto/
#  git remote add upstream git@github.com:sorin-ionescu/prezto.git

fi
echo "done! :)"

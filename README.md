# dotfiles

> git clone https://github.com/ml85/dotfiles

# zsh

Install on Ubuntu:
> sudo apt-get install zsh

Install zplug 

> curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh

# tmux

Install on Ubuntu:
> sudo apt-get install tmux
> ln -s .tmux.conf ~/dotfiles/tmux/tmux.conf

# nvim

Install on Ubuntu:
> ???

Install vim-plug:
```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create init.vim:
> mkdir -p .config/nvim; echo "source $HOME/dotfiles/nvim/init.vim" > .config/nvim/init.vim;

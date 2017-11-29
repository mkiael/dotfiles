# dotfiles

```sh
$ git clone https://github.com/ml85/dotfiles
```

### zsh

Install on Ubuntu:

```sh
$ sudo apt-get install zsh
```

Install zplug: 

```sh
$ curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
```

### tmux

Install on Ubuntu:

```sh
$ sudo apt-get install tmux
```

Link config:

```sh
$ ln -s .tmux.conf ~/dotfiles/tmux/tmux.conf
```

Clone TPM:

````sh
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### nvim

Install on Ubuntu:

```sh
$ ???
```

Install vim-plug:

```sh
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create init.vim:

````sh
$ mkdir -p .config/nvim; echo "source $HOME/dotfiles/nvim/init.vim" > .config/nvim/init.vim;
```

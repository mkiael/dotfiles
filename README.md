# dotfiles

```sh
$ git clone https://github.com/ml85/dotfiles
```
### [fzf](https://github.com/junegunn/fzf)

```sh
$ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
$ ~/.fzf/install
```

### [ag](https://github.com/ggreer/the_silver_searcher)

```sh
$ sudo apt-get install silversearcher-ag
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

```sh
$ git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### [nvim](https://github.com/neovim/neovim)

Install on Ubuntu:


```sh
$ wget https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
$ cp nvim.appimage ~/.local/bin
$ echo "alias nvim=nvim.appimage" >> ~/.bashrc
$ echo "alias vim=nvim" >> ~/.bashrc
```

Install vim-plug:

```sh
$ curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Create init.vim:

```sh
$ mkdir -p .config/nvim; echo "source $HOME/dotfiles/nvim/init.vim" > .config/nvim/init.vim;
```
### Update clangd

```sh
$ wget https://apt.llvm.org/llvm.sh
$ chmod +x llvm.sh
$ sudo ./llvm.sh <version number>
$ sudo apt install clangd-<version number>
$ sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-<version number> <version number>
```

### Install ripgrep

TBD

### Install alacritty

TBD

### Install bat

TBD

### Git

Link config:

```sh
$ ln -s ~/dotfiles/git/gitconfig .gitconfig
```

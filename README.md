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
$ sudo add-apt-repository ppa:neovim-ppa/stable
$ sudo apt-get update
$ sudo apt-get install neovim
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

### Git

Link config:

```sh
$ ln -s .gitconfig ~/dotfiles/git/gitconfig
```

### EditorConfig

Install editorconfig MacOs:

```sh
$ brew install editorconfig
```

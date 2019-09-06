# Phil's Dotfiles

I use this repo for versionizing my dotfiles. I followed [this blog post by Brandon Invergo](http://brandon.invergo.net/news/2012-05-26-using-gnu-stow-to-manage-your-dotfiles.html), where they describe how to use [GNU Stow](https://www.gnu.org/software/stow/) for managing Dotfiles.

## Setup
Make sure to have git and Stow installed on your machine. Then type these commands

```
cd ~
git clone https://github.com/philipp-jung/phils-dotfiles.git .dotfiles
cd .dotfiles
```

Now, you can create symlinks for your vim-config like so:

```
cd ~/.dotfiles
stow vim
```

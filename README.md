# dotfiles
My dotfiles Repo!

## To Apply

```
chezmoi init --apply --exclude=encrypted https://github.com/Haze-sh/dotfiles.git
```

## After Applying

```
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
```

```
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
```

```
flavours update all
```

- Add user preset to gradience (Until there is a command to do so)
- Add fcron.backup > fcrontab entries

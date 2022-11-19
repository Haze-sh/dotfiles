# dotfiles
My dotfiles Repo!

## To Apply

```
chezmoi init --apply --exclude=encrypted https://github.com/Haze-sh/dotfiles.git
```

## After Applying

```
flavours update all
```

- Add user preset to gradience (Until there is a command to do so)
- Add fcron.backup > fcrontab entries

## Caveats

- Some config files are path dependant
	* keepmenu

- Some scripts are path dependant
	* bukusync
	* setwallpaper
	* zathura-annotate

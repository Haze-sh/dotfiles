# ~ dotfiles ~ 🐈 🍻

My dotfiles Repo!

## To Apply

```
chezmoi init --apply --exclude=encrypted https://github.com/Haze-sh/dotfiles.git
```

## After Applying

### Themes
```
flavours update all
flavours apply $SCHEME
```

- Add user preset to gradience (Until there is a command to do so)

### Backups
- permessions.backup
- fcrontab.backup

## Minor Caveats

- Some config files are path dependant
	- fcrontab
	* keepmenu

- Some scripts are path dependant
	* bukusync
	* setwallpaper
	* zathura-annotate
	* merge-browser-history
	* merge-mpv-data

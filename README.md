# ~ dotfiles ~ 🐈 🍻

My dotfiles Repo!


## To Apply

```
chezmoi init --apply --exclude=encrypted https://github.com/Haze-sh/dotfiles.git
```

## Themes

```bash
flavours update all

flavours apply $SCHEME
```

- Manually add user preset to gradience (Until there is a command to do so)

## Backups

```bash
fcrontab $HOME/.confing/fcrontab.backup # Cron jobs

setfacl --restore=$HOME/.config/permissions.facl # For mopidy to work on local files

sudo cp $HOME/.config/issue.txt /etc/issue ## To have a beautiful issue

sudo cp $HOME/.config/totem.thumbnailer /usr/share/thumbnailers/totem.thumbnailer # Better thumbnails
```

## Passwords

It is easier to use some scripts by saving passwords to gnupass rather than manually doing stuff:

```bash
pass add user # Hypothesis username
pass add hypothesis # Hypothesis token
pass add keepass # KeePass password
pass add totp # KeePass TOTP
```

## Minor Caveats

- Some scripts are path dependant
	* setwallpaper
	* syncbuku
	* merge-browser-history
	* merge-mpv-data

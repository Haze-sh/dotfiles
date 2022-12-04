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

- Hypothesis username as "user"
- Hypothesis token as "hypothesis"
- KeePass password as "keepass"
- KeePass TOTP password as "totp"

## Minor Caveats

- Some scripts are path dependant
	* setwallpaper
	* syncbuku
	* merge-browser-history
	* merge-mpv-data

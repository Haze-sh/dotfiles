# ~ dotfiles ~ 🐈 🍻

My dotfiles Repo!


## To Apply

```
chezmoi init --apply --exclude=encrypted,templates https://github.com/Haze-sh/dotfiles.git
```

## Themes

```bash
flavours update all
flavours apply $SCHEME
```

- Manually add user preset to gradience (Until there is a command to do so)

## Backups

```bash
chsh -s /bin/zsh
fcrontab $HOME/.config/fcrontab.backup # Cron jobs
setfacl --restore=$HOME/.config/permissions.facl # For mopidy to work on local files
sudo cp $HOME/.config/issue.txt /etc/issue ## To have a beautiful issue
sudo cp $HOME/.config/totem.thumbnailer /usr/share/thumbnailers/totem.thumbnailer # Better thumbnails
```

## Passwords

It is easier to use some scripts by saving passwords to gnupass rather than manually doing stuff:

```bash
pass add keepass # KeePass password
pass add totp # KeePass TOTP
pass add caldav # CalDAV password
```

## Minor Caveats

- Some scripts are path dependant
	* setwallpaper
	* syncbuku

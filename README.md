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
sudo cp $HOME/.local/share/themes/issue.txt /etc/issue ## To have a beautiful issue
```

## Passwords

It is easier to use some scripts by saving passwords to gnupass rather than manually doing stuff:

```bash
pass add caldav # CalDAV password
pass add manager/keepass # KeePass password
pass add manager/totp # KeePass TOTP
```

## Other

```
sudo ln -sfT dash /usr/bin/sh
sudo ln -s $HOME/.local/bin/scripts/pinentry-bemenu /opt/
```

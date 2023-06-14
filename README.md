# ~ dotfiles ~ 🐈 🍻

My dotfiles Repo!


## To Apply

```
chezmoi init --apply --exclude=encrypted,templates https://github.com/Haze-sh/dotfiles.git
```

## Themes

```bash
flavours update all && flavours apply $SCHEME
```

## Backups

```bash
chsh -s /bin/zsh
fcrontab $HOME/.config/shellconfig/fcrontab.backup # Cron jobs
setfacl --restore=$HOME/.config/shellconfig/permissions.factl # For mopidy to work on local files
```

## Passwords

It is easier to use some scripts by saving passwords to gnupass rather than manually doing stuff:

```bash
pass add caldav # CalDAV password
pass add manager/keepass # KeePass password
pass add manager/totp # KeePass TOTP
```

## Other

```bash
sudo ln -sfT dash /usr/bin/sh
sudo ln -s $HOME/.local/bin/scripts/pinentry-bemenu /opt/
sudo cp $HOME/.local/share/themes/issue.txt /etc/issue ## To have a beautiful issue
```

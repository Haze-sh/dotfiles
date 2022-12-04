# ~ dotfiles ~ 🐈 🍻

My dotfiles Repo!

[H[2J


                                             .
                                     _  *  jH`    --    _~
                                      j`   ] '    `.n"*
                                    , 'u    '.    ` ""``*
     `                             ~j  `  --~ `         `y
                                    .'^9M           -   `V
                                    ",~   [1;33m,@u~ `~~`uu   [1;0mu
                                    --^`[1;33m,@@@@@&@@Up[1;0m    `~
                                      [1;33m,@@@@@@@@%@91H_`[1;0m       ` u
                                 j   [1;33m`Xj@N@@@@%@j11M[1;0m             .
                                     [1;33m`M9M@MM1)@@M`[1;0m           .  '
                                     [1;33m`    ``"``[1;0m
                                    y    [1;33m,,~.@u  , `` ,@[1;0m               [34;1m _____       _____       _____       _____[1;0m
                                   <`  [1;33mjeyuU_8h  1D1""`[1;0m                [34;1m|_   _|_ _  |_   _|_ _  |_   _|_ _  |_   _|_ _  __ _  __ _[1;0m
                                  ~    [1;33m"""1H`]U , *H___           [1;37m,yL  [34;1m  | |/ _` |   | |/ _` |   | |/ _` |   | |/ _` |/ _` |/ _` |[1;0m
                                         [1;33m_```*M    ),__       [1;37m,y@@&@&  [34;1m  | | (_| |   | | (_| |   | | (_| |   | | (_| | (_| | (_| |[1;0m
                                      [1;37mJBk [1;33m]`j*%hu ***``      [1;37mJ&8@@&@@@ [34;1m  |_|\\__,_|   |_|\\__,_|   |_|\\__,_|   |_|\\__,_|\\__,_|\\__,_|[1;0m
                                     [1;37m4@@@B_ [1;33m,<>>^" _^>    [1;37mJB@4@@@@@@@R
                                    [1;37m4k@@@&@k[1;33m`  ,q1u      [1;37m4@@B&RBRRRRF*
                                   [1;37m4BBBBRRBR@u [1;33m" `      [1;37mBM` uu_
                                          [1;31m1 "4@u       `__  `
                                         [1;31m1    `% ~u_ _`   "
                *                        [1;31m`   _    ___  <`
                 `                       [1;31m)_   __     "
                  `,                    [1;31mj_      _       `,
               [1;33m;11w   -eM              [1;31mj  ____ `_       J'
              [1;33m1_m,``; '                  [1;31m__ __`      ` (
              [1;33m_`*``M [1;31m`-                   [1;31m_  _    _   *[1;0m
\d
\s \v \r
\U

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

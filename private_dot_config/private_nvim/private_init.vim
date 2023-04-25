let mapleader=","
let maplocalleader="]"

" Vim-plug install
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
	echo "Downloading junegunn/vim-plug to manage plugins..."
	silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
	silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
	autocmd VimEnter * PlugInstall
endif

" Plugins
call plug#begin("~/.config/nvim/plugged")
" Basics
  Plug 'roxma/nvim-yarp'
  "Plug 'roxma/vim-hug-neovim-rpc'
  Plug 'ncm2/ncm2'
  Plug 'ncm2/ncm2-bufword'
  Plug 'ncm2/ncm2-path'
  Plug 'ncm2/ncm2-markdown-subscope'
    "g:vim_markdown_fenced_languages
  "Plug 'ycm-core/YouCompleteMe'
  "Plug 'Shougo/deoplete.nvim', {'do': ':UpdateRemotePlugins'}
  "  set runtimepath+=~/.config/nvim/plugged/deoplete.nvim
  "  let g:deoplete#enable_at_startup = 1

" Themes
  Plug 'chriskempson/base16-vim'
  Plug 'waycrate/swhkd-vim'
  "Plug 'mcchrish/vim-no-color-collections'
  "Plug 'rmehri01/onenord.nvim'
  "Plug 'preservim/vim-colors-pencil'
  "Plug 'danilo-augusto/vim-afterglow'

" Highlighting
  Plug 'akinsho/bufferline.nvim'
  "Plug 'bling/vim-bufferline'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
    let g:airline_theme='base16'
  Plug 'romainl/vim-cool'
  Plug 'nvim-treesitter/nvim-treesitter' " , {'do': ':TSUpdate'}

" Language support
""" IDE
  Plug 'sheerun/vim-polyglot'
  Plug 'vim-syntastic/syntastic'
""" Golang
  Plug 'fatih/vim-go' " , { 'do': ':GoUpdateBinaries' }
""" Rust
  Plug 'racer-rust/racer'
""" Python
  Plug 'python-mode/python-mode'
  Plug 'sansyrox/vim-python-virtualenv'
  Plug 'vim-scripts/indentpython.vim'
  Plug 'nvie/vim-flake8'
""" Markdown
  Plug 'vim-pandoc/vim-pandoc'
  Plug 'vim-pandoc/vim-pandoc-syntax'
    let g:pandoc#syntax#conceal#urls = 1
  Plug 'prashanthellina/follow-markdown-links'
  Plug 'dkarter/bullets.vim'
    let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'markdown.pandoc',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]
  "  let g:bullets_checkbox_markers = '✗○◐●✓'
  "Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
  "Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
  "  let g:mkdp_auto_close = 0
  "Plug 'ellisonleao/glow.nvim'
  "Plug 'tpope/vim-markdown'
    "let g:markdown_fenced_languages = ['python']
  "Plug 'plasticboy/vim-markdown'
  "  " disable header folding
  "  let g:vim_markdown_folding_disabled = 0
  "  " do not use conceal feature, the implementation is not so good
  "  let g:vim_markdown_conceal = 1
  "  " disable math tex conceal feature
  "  let g:tex_conceal = ""
  "  let g:vim_markdown_math = 1
  "  " support front matter of various format
  "  let g:vim_markdown_frontmatter = 1  " for YAML format
  "  let g:vim_markdown_toml_frontmatter = 1  " for TOML format
  "  let g:vim_markdown_json_frontmatter = 1  " for JSON format
  "Plug 'masukomi/vim-markdown-folding'
  "Plug 'preservim/vim-markdown'
  "Plug 'jtratner/vim-flavored-markdown'
""" LaTeX
  Plug 'lervag/vimtex'
    let g:tex_flavor='latex'
    let g:vimtex_view_method='zathura'
    let g:vimtex_quickfix_mode=0
  Plug 'KeitaNakamura/tex-conceal.vim'
    set conceallevel=1
    let g:tex_conceal='abdmg'
    hi Conceal ctermbg=none
""" CSS
  Plug 'ap/vim-css-color'
  "Plug 'RRethy/vim-hexokinase', { 'do': 'make hexokinase' }
  "  let g:Hexokinase_highlighters = ['backgroundfull']
""" CSV
  Plug 'mechatroner/rainbow_csv'
""" todo.txt
  Plug 'dbeniamine/todo.txt-vim'
    "let g:Todo_fold_char='+'
    let g:Todo_update_fold_on_sort=1
    let g:TodoTxtSortDueDateCursorPos = "top"
  Plug 'EdwinWenink/capture-todo.vim'
    let g:todo_location=$TODO_FILE
  Plug 'lgalke/gather-todo.txt-vim'
""" jrnl
  Plug 'wren/jrnl.vim'
  "Plug 'junegunn/vim-journal'
  "Plug 'vuciv/vim-bujo'
  "Plug 'austintraver/vim-jrnl'
  "Plug 'mode89/vim-jrnl-syntax'

" Tools
  Plug 'xolox/vim-misc'
  Plug 'pacha/vem-tabline'
  "Plug 'Yggdroot/indentLine'
  Plug 'dahu/Taggle'
  Plug 'jreybert/vimagit'
  Plug 'airblade/vim-gitgutter'
  Plug 'skywind3000/asyncrun.vim'
  "Plug 'nvim-lua/plenary.nvim'
  Plug 'junegunn/fzf.vim'
    let g:fzf_preview_window = ['up:20%:hidden', 'ctrl-/']
  "Plug 'alok/notational-fzf-vim'
   "let g:nv_search_paths = [$ZET_DIR]
  Plug 'ctrlpvim/ctrlp.vim'
  Plug 'jremmen/vim-ripgrep'
  "  let g:rg_command = 'rg --vimgrep -S'
  "Plug 'nvim-telescope/telescope.nvim'
  "Plug 'jesseleite/vim-agriculture'
  "Plug 'Shougo/denite.nvim'
  "  let g:nv_search_paths = ['~/Documents/Notes/']
  "Plug 'yuki-yano/fzf-preview.vim'
  Plug 'benmills/vimux'
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'preservim/nerdtree'
  Plug 'ryanoasis/vim-devicons'
  "Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'ptzz/lf.vim'
    "let g:NERDTreeHijackNetrw = 0
  Plug 'voldikss/vim-floaterm'
  "Plug 'Shougo/defx.nvim'
  Plug 'sirver/ultisnips'
    let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips', $COURSES.'/Scripts/Snippets']
    let g:UltiSnipsExpandTrigger='<tab>'
    let g:UltiSnipsJumpForwardTrigger='<tab>'
    let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
  "Plug 'honza/vim-snippets'
  "Plug 'Shougo/neosnippet.vim'
  "Plug 'Shougo/neosnippet-snippets'
  if system('pgrep aw-server')
    Plug 'ActivityWatch/aw-watcher-vim'
  endif
  Plug 'mattn/calendar-vim'
  "Plug 'itchyny/calendar.vim'
  "Plug 'preservim/tagbar'

""" Functionality
  Plug 'lukesmithxyz/vimling'
  Plug 'vim-scripts/fountain.vim'
  Plug 'tpope/vim-commentary'
  Plug 'jiangmiao/auto-pairs'
  Plug 'qpkorr/vim-renamer'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
  Plug 'wellle/targets.vim'
  Plug 'preservim/vim-pencil'
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  Plug 'pbrisbin/vim-mkdir'
  Plug 'godlygeek/tabular'
  Plug 'elzr/vim-json'
  "Plug '907th/vim-auto-save'
  "Plug 'alpertuna/vim-header'
  "Plug 'pseewald/vim-anyfold'
  "Plug 'goolord/alpha-nvim'

""" Zettelkasten
  Plug 'mickael-menu/zk-nvim'
  "Plug 'xolox/vim-notes'
  "Plug 'fmoralesc/vim-pad'
  "Plug 'MattesGroeger/vim-bookmarks'
  "Plug 'plutonly/vim-annotate'
  "Plug 'renerocksai/telekasten.nvim'
  "Plug 'dobrovolsky/kb-notes.nvim'
  "Plug 'nvim-neorg/neorg'
  "Plug 'dhruvasagar/vim-dotoo'
  "Plug 'kristijanhusak/orgmode.nvim'
  "Plug ishchow/nvim-deardiary
  "Plug 'vimwiki/vimwiki'
  "Plug 'tools-life/taskwiki'
  "Plug 'blindFS/vim-taskwarrior'
  "Plug 'jceb/vim-orgmode'
  "Plug 'axvr/org.vim'

call plug#end()

" Python
let g:python3_host_prog = '/usr/bin/python3'

" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

"" Colors
if (has("termguicolors"))
 set termguicolors
endif
"set background=dark
colorscheme base16

"" Basics
syntax on
set mouse=a
set title
set modeline
set modelines=2
set autoread
set cursorline
set nohlsearch
set ignorecase
set smartcase
set smarttab
set smartindent
set laststatus=0
set noshowcmd
set noshowmode
set noruler
set relativenumber
set nocompatible
set arabicshape!

"set list
set showmatch ""bracket match jump
set backspace=indent,eol,start

set ignorecase smartcase
set grepprg=grep\ -IrsnH

set completeopt=noinsert,menuone,noselect
set clipboard+=unnamedplus
set encoding=utf-8
set iskeyword-=],_

set tags+=./tags;,tags
set path+=**
set rtp+=$COURSES/Current
set wildmode=longest,list,full
set wildmenu
set nospell

set history=1000
set undofile
set undodir=~/.local/share/nvim/undo

"set foldmethod=indent

set splitbelow splitright
filetype plugin indent on

"" Remappings
" Use ripgrep instead of CtrlP
  if executable('rg')
      let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
      let g:ctrlp_user_caching = 0
  endif

" Use ripgrep instead of grep
  if executable('rg')
    set grepprg=rg\ --color=never\ --vimgrep
  endif

" Moving between windows
	map <C-h> <C-w>h
	map <C-j> <C-w>j
	map <C-k> <C-w>k
	map <C-l> <C-w>l

" Spell-check set to <leader>s, 'o' for 'othography'
	map <leader>o :setlocal spell! spelllang=en_us,de,ar<CR>

" Check file in shellcheck
	map <leader>s :!clear && shellcheck -x %<CR>

" Goyo plugin makes text more readable when writing prose
	map <leader>g :Goyo \| set bg=dark \| set linebreak<CR>
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

" Open my bibliography file in split
	map <leader>b :vsp<space>$BIB<CR>
	map <leader>r :vsp<space>$REFER<CR>

" Compile document, be it groff/LaTeX/markdown/etc.
	map <leader>c :w! \| !compiler "<c-r>%"<CR>

" Open corresponding .pdf/.html or preview
	map <leader>p :!opout <c-r>%<CR><CR>

" Prompt for a command to run in tmux from within vim
  map <Leader>vp :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
  map <Leader>vl :VimuxRunLastCommand<CR>

" Insert date
  nmap <leader>d i<C-R>=strftime("%Y-%m-%d %a %H:%M:%S")<CR><Esc>
  imap <leader>d <C-R>=strftime("%Y-%m-%d %a %H:%M %S")<CR>

" Insert date in ledger format
  nmap <leader>dl i<C-R>=strftime("%Y-%m-%d")<CR><Esc>
  imap <leader>dl <C-R>=strftime("%Y-%m-%d")<CR>

" Insert date in jrnl format
  nmap <leader>dj i[<C-R>=strftime("%Y-%m-%d %H:%M")<CR>]<Esc>
  imap <leader>dj [<C-R>=strftime("%Y-%m-%d %H:%M")<CR>]

" NERDTree
  nnoremap <leader>n :NERDTreeFocus<CR>
  nnoremap <C-n> :NERDTree<CR>
  nnoremap <C-t> :NERDTreeToggle<CR>
  nnoremap <C-f> :NERDTreeFind<CR>

" Adding new note
  let g:zettelkasten = $ZET_DIR
  command! -nargs=1 Zet :execute ":e" zettelkasten . "/<args>.md"
  nnoremap <leader>nz :Zet
  " cnoremap :nz e $ZET_DIR<c-r>=strftime("%Y%m%d%H%M")<CR>-
  " nnoremap <leader>z :e $ZET_DIR

" Go to index of notes and set working directory to my notes
  nnoremap <leader>ni :e $ZET_DIR/000-index.md<CR>:cd $ZET_DIR<CR>

" 'Notes Grep' with ripgrep
  command! -nargs=1 Ngrep :silent grep! "<args>" -i -g '*.md' $ZET_DIR | execute ':redraw!' | copen
  nnoremap <leader>nn :Ngrep

" Quickfix list in vertical sidbar
  command! Vlist botright vertical copen | vertical resize 50
  nnoremap <leader>v :Vlist<CR>

" Add table of content to markdown
  nnoremap <silent> <Leader>t :Toc<cr>

" Binding for searching tags ("search tag")
	nnoremap <leader>st :CtrlPTag<CR>

" Find backlinks to current file and open quickfix list with the results
"  command! -nargs=0 Ngrepl :execute "grep -F '" . " ]( " . expand("%:t") . " )" .  "'" | :copen
"  nnoremap <leader>nb :Ngrepl<CR><CR>

" Find backlinks to current file and open quickfix list with the results
  function! s:markdown_backlinks()
      call fzf#vim#grep(
                  \ "rg --column --line-number --no-heading --color=always --smart-case --max-depth 1 ".expand('%'), 1,
                  \ fzf#vim#with_preview('right:50%:hidden', '?'), 0)
  endfunction
  command! Backlinks call s:markdown_backlinks()
  nnoremap <leader>nb :Backlinks<CR>

" Generate ctags silently
	nnoremap <leader>tt :silent !ctags -R . <CR>:redraw!<CR>

" Replace all is aliased to R.
	nnoremap R :%s//g<Left><Left>

" Perform dot commands over visual blocks:
	vnoremap . :normal .<CR>

" Save file as sudo on files that require root permission
	cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Correcting previous spelling mistake.
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u

" Inkscape
  inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
  nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

"" Autocommands
"" Fountain autodetecting
  au BufRead,BufNewFile *.fountain set filetype=fountain

" Runs a script that cleans out tex build files whenever I close out of a .tex file.
	autocmd VimLeave *.tex !texclear %

" Disables automatic commenting on newline
	autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Enable markdown top level folding
  autocmd FileType pandoc.markdown set foldexpr=NestedMarkdownFolds()

" Automatically add header to markdown files
"  autocmd BufNewFile *.md 0r ~/.local/share/nvim/markdown-header.template
"  autocmd BufNewFile *.md | 1put='Title: '.expand('%')
"  autocmd BufNewFile *.md | 2put='Creation: '.strftime('%Y%m%d%H%M%S')

" Enable markdown for calcurse notes
  autocmd BufRead,BufNewFile /tmp/calcurse*,~/.config/calcurse/notes/* set filetype=markdown

" Enable jrnl recognition
  autocmd BufRead,BufNewFile *.jrnl set filetype=jrnl

" Enable Goyo by default for mutt writing
	autocmd BufRead,BufNewFile /tmp/neomutt* let g:goyo_width=80
	autocmd BufRead,BufNewFile /tmp/neomutt* :Goyo | set bg=light
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZZ :Goyo\|x!<CR>
	autocmd BufRead,BufNewFile /tmp/neomutt* map ZQ :Goyo\|q!<CR>

" Set header title for journal & enter writing mode
"function! JournalMode()
"    execute 'normal gg'
"    let filename = '#' . ' ' . expand('%:r')
"    call setline(1, filename)
"    execute 'normal o'
"    execute 'Goyo'
"endfunction

" Workflow for daily journal
"augroup journal
"    autocmd!
"
"    " Populate journal template
"    autocmd VimEnter */journal/**   0r ~/.config/nvim/templates/journal.skeleton
"
"    " Set header for the particular journal
"    autocmd VimEnter */journal/**   :call JournalMode()
"
"    " Autocompletion for directory
"    autocmd VimEnter */journal/**   set complete=k/Users/danish/programming/mine/journal/**/*
"augroup END

" Pandoc Syntax for Markdown
  augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
  augroup END

  "augroup pandoc
  "  autocmd!
  "  autocmd Filetype pandoc,markdown set filetype=pandoc.markdown
  "  autocmd Filetype pandoc,markdown set conceallevel=1
  "  autocmd Filetype pandoc,markdown highlight Conceal ctermbg=NONE
  "  autocmd Filetype pandoc,markdown highlight Folded ctermbg=NONE
  "  autocmd Filetype pandoc,markdown call AutoCorrect()
  "  autocmd Filetype pandoc,markdown EnableAutocorrect
  "augroup END

  augroup Tasks
  au! Filetype pandoc.markdown
      call matchadd('Conceal', '- \[ \]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[x\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[X\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[o\]', 10, -1, { 'conceal': '◐'})
      call matchadd('Conceal', '- \[O\]', 10, -1, { 'conceal': '●'})
      call matchadd('Conceal', '- \[?\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[!\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[c\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[i\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[\.\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \[\*\]', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \TODO', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \LATER', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '- \DONE', 10, -1, { 'conceal': ''})
      call matchadd('Conceal', '^\s*\zs-\ze [^\[]', 10, -1, { 'conceal': ''})
  augroup END

" Automatically deletes all trailing whitespace and newlines at end of file on save.
	autocmd BufWritePre * %s/\s\+$//e
	autocmd BufWritePre * %s/\n\+\%$//e
	autocmd BufWritePre *.[ch] %s/\%$/\r/e

" Deoplete
"  autocmd VimEnter * call deoplete#custom#option('sources', {'md': []})

" Enable ncm2 for all buffers
  autocmd BufEnter * call ncm2#enable_for_buffer()

" Enable autocompletion for todo.txt
  au filetype todo setlocal omnifunc=todo#Complete
  au filetype todo imap <buffer> + +<C-X><C-O>
  au filetype todo imap <buffer> @ @<C-X><C-O>

"" Functions
" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
  if &diff
      highlight! link DiffText MatchParen
  endif

" Preview Markdown
  nnoremap <leader>m :MarkdownPreview<CR>

" Function for toggling the bottom statusbar:
  let s:hidden_all = 1
  function! ToggleHiddenAll()
      if s:hidden_all  == 0
          let s:hidden_all = 1
          set noshowmode
          set noruler
          set laststatus=0
          set noshowcmd
      else
          let s:hidden_all = 0
          set showmode
          set ruler
          set laststatus=2
          set showcmd
      endif
  endfunction
  nnoremap <leader>h :call ToggleHiddenAll()<CR>

"" Add link to next buffer
  function! s:copy_filename_as_mdlink()
      let @a = "[" . expand("%") . "](" . expand("%") . ")"
  endfunction
  command! FileName call s:copy_filename_as_mdlink()
  autocmd BufLeave * call s:copy_filename_as_mdlink()
  "autocmd BufNewFile *.md,*.txt :normal "kp
  "autocmd BufNewFile *.md,*.txt :let @a = ''

"" CtrlP function for inserting a markdown link with Ctrl-X
  fu! CtrlPOpenFunc(action, line)
     if a:action =~ '^h$'
        let filename = fnameescape(fnamemodify(a:line, ':t'))
  	    let filename_wo_timestamp = fnameescape(fnamemodify(a:line, ':t:s/\d*-//'))

        call ctrlp#exit()
        call ctrlp#mrufiles#add(filename)

  	    let mdlink = '['.filename_wo_timestamp.']('.filename.')'
        put = mdlink
      else
        call call('ctrlp#acceptfile', [a:action, a:line])
     endif
  endfunction

  let g:ctrlp_open_func = {
           \ 'files': 'CtrlPOpenFunc',
           \ 'mru files': 'CtrlPOpenFunc'
           \ }

" Function to insert Markdown notes with fzf search
  fu! HandleFZF(file)
      let filename = fnameescape(fnamemodify(a:file, ':t'))
      let filename_wo_timestamp = fnameescape(fnamemodify(a:file, ':t:s/^[0-9]*-//'))
      let mdlink = '['.filename_wo_timestamp.']('.filename.')'
      put = mdlink
"      let curfilename = fnameescape(expand('%:t'))
"      let curfilename_wo_timestamp = fnameescape(fnamemodify(expand('%'), ':t:s/^[0-9]*-//'))
"      let curmdlink = '[ '.curfilename_wo_timestamp." ]( '.curfilename.' )'
"      call writefile(add(readfile(filename), curmdlink), filename)
  endfunction
  command! -nargs=1 HandleFZF :call HandleFZF(<f-args>)
  inoremap <buffer> <C-X><C-F> <esc>:call fzf#run({'source': 'rg --files --max-depth 1 .', 'sink': 'HandleFZF', 'options': '--delimiter / --with-nth -1', 'window': {'width': 0.9, 'height': 0.6}})<CR>
  "inoremap <buffer> <C-X><C-F> <esc>:call fzf#run({'source': 'find . -maxdepth 1 -type f',
  "      \ 'sink': 'HandleFZF', 'window': {'width': 0.9, 'height': 0.6}})<CR>

" Switch to Arabic - mapping
  nnoremap <Leader>a :<C-U>call AraType()<CR>
" Switch to English - mapping
  nnoremap <Leader>e :<C-U>call EngType()<CR>

" Switch to Arabic - function
  function! AraType()
    set keymap=arabic
    set rightleft
  endfunction

" Switch to English - function
  function! EngType()
" To switch back from Arabic
"    set keymap=us " Restore default (US) keyboard layout
    set norightleft
  endfunction

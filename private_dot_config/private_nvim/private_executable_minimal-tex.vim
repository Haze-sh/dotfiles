set nocompatible
set path+=**
set showmatch
set backspace=indent,eol,start
set viminfo=
filetype plugin indent on
autocmd BufRead,BufNewFile * start
autocmd BufRead * normal 1l
set rtp +=~/.config/nvim
set rtp +=~/Documents/Notes/Personal/Courses/current-course

call plug#begin("~/.config/nvim/plugged")
Plug 'jiangmiao/auto-pairs'
Plug 'lervag/vimtex'
  let g:tex_flavor='latex'
  let g:vimtex_view_method='zathura'
  let g:vimtex_quickfix_mode=0
Plug 'KeitaNakamura/tex-conceal.vim'
  set conceallevel=1
  let g:tex_conceal='abdmg'
  hi Conceal ctermbg=none
Plug 'sirver/ultisnips'
  let g:UltiSnipsSnippetDirectories=['/home/electron/.config/nvim/plugged/vim-snippets/UltiSnips', '/home/electron/.config/nvim/custom_snippets']
set runtimepath^='~/.config/nvim/plugged/base16-vim'
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif
"set background=dark
colorscheme base16

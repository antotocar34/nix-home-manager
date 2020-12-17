let mapleader =" " 
let home = $HOME

""
"PLUGINS
""

" Plug 'lervag/vimtex'
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=2
let g:tex_conceal='abdmg'
let g:vimtex_include_search_enabled=0
let g:vimtex_complete_close_braces=1
let g:vimtex_view_forward_search_on_start=0
let g:vimtex_complete_close_braces = 1
let g:vimtex_view_automatic = 0
let g:vimtex_indent_enabled=0
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

" Plug 'SirVer/Ultisnips'
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsSnippetDirectories = [home . '/.config/nixpkgs/extraConfigs/my-snippets']

" Plug 'tpope/vim-surround'

" Plug 'tpope/vim-unimpaired'

" Plug 'tpope/vim-commentary'

" Plug 'LnL7/vim-nix'

" Plug 'junegunn/fzf.vim'
let g:fzf_buffers_jump = 0

" Plug 'arcticicestudio/nord-vim'

" Plug 'preservim/nerdtree'
let g:NERDTreeQuitOnOpen = 1

" Plug 'neovimhaskell/haskell-vim'
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" Plug 'psf/black'
let g:black_linelength = 79
let g:black_skip_string_normalization = 1

" Plug 'neoclide/coc.nvim'
autocmd FileType tex let g:coc_start_at_startup = 0
autocmd FileType python let b:coc_root_patterns =
                \ ['.git', 'src']
" autocmd FileType haskell let b:coc_root_patterns =
"                 \ [????]


"""
" SETTINGS
"""

" syntax enable
filetype plugin on
set nocompatible
" Automatically changes working directory to current file.
set autochdir
" Highlight and jump to search result as it is happening
set incsearch
" Case insensitive if search is all lowercase
set smartcase
" Coc TextEdit might fail if this is unset
set hidden
set spelllang=en
set encoding=utf-8
set number relativenumber
set background=dark
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab
" Shows what you type in command mode.
set showcmd
set wildmode=longest,list,full
autocmd fileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set splitbelow splitright
set linebreak
" augroup remember_folds
"     autocmd!
"     au BufWinLeave ?* mkview 1
"     au BufWinEnter ?* silent! loadview 1
" augroup END
" Changes directory to current file directory
autocmd BufEnter * silent! lcd %:p:h
set autoread
set ttimeout
set ttimeoutlen=100
set timeoutlen=3000
"""
" BINDINGS
"""
"save
map <C-s>  <Esc>:update <CR>
"quit
nnoremap <C-q> :q!<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap  <C-j> :tabprevious<CR>
nnoremap  <C-k> :tabnext<CR>
" nnoremap  <C-t>q :tabclose<CR>
command R !clear&&./%
command TW :%s/ \+$//

nnoremap <C-p> "+p
vnoremap <C-p> "+p
nnoremap Y "+y
vnoremap Y "+y
" reload vimrc
nnoremap ¬ :source ~/.vimrc<CR>
" center the page
imap <C-e>  <C-o>zz
" fzf searc
map <leader>f :BLines <CR>
command! -bang Files call fzf#vim#files('~/', <bang>0)
command! -bang HFiles call fzf#vim#files('~/', <bang>0)
nnoremap <leader>d ggv/noind<CR>$zf``
" This is a spell check from gilles castel blog
" https://castel.dev/post/lecture-notes-1/
inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
command! -nargs=1 SS let @/ = '\V'.escape(<q-args>, '\')	
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>
nnoremap - :NERDTree <CR>
nnoremap <leader>i :!clear&&git 
nnoremap <leader>l :bn<CR>
nnoremap <leader>h :bp<CR>
nnoremap <leader>q :bd<CR>
nnoremap <leader>e :HFiles<CR>
nnoremap <leader>a :Files<CR>
map <leader>o :set invspell<CR>
nnoremap <buffer> <F10> :!clear&&texcount % <cr>
nnoremap <leader>t :vert term <CR>
nnoremap <leader>y :term <CR>
nnoremap <leader>s :VimtexTocOpen <CR>
nnoremap + :sh <CR>
" Make terminal quitting easier
tnoremap <C-d> <C-\><C-n>:q!<CR>

"""
" COLOURSCHEME
"""
augroup my-colors
    autocmd!
    autocmd ColorScheme * hi Conceal ctermbg=NONE
    autocmd ColorScheme * hi SpellBad ctermbg=NONE
augroup END

hi SpellBad ctermfg=174 ctermbg=NONE 
hi Conceal ctermfg=NONE ctermbg=NONE		
hi LineNR ctermfg=109
hi SpellCap  ctermfg=95
hi SpellRare ctermfg=95
hi SpellLocal ctermfg=95
hi Delimiter ctermfg=183
hi texMathZoneES  ctermbg=NONE
hi texDocZone  ctermbg=NONE
hi texSectionZone  ctermbg=NONE	
hi texSection  ctermbg=NONE
hi texSubSectionZone  ctermbg=NONE
hi texStatement  ctermbg=NONE
hi Delimiter  ctermbg=NONE "syntax colour of brackets and the like.
hi texMatcher  ctermbg=NONE
hi TexMathOper ctermfg=15 "syntax colour of math operators like the _
hi TexMathzoneW ctermfg=80	
hi texMathMatcher  ctermfg=80
hi texMathZoneES  ctermfg=80
hi texMathSymbol ctermfg=1 	
hi texMathZoneX ctermfg=80	
hi texGreek ctermfg=1
hi texBeginEnd ctermfg=167
hi pythonNumber ctermfg=114

augroup nord-overrides
    autocmd!
    autocmd ColorScheme nord highlight TexMathzoneW ctermfg=15
    autocmd ColorScheme nord highlight texMathSymbol ctermfg=1 	
    autocmd ColorScheme nord highlight texGreek ctermfg=1 	
    autocmd ColorScheme nord highlight Delimiter ctermfg=5 	
augroup END

colorscheme nord

highlight ColorColumn ctermbg=magenta

"""
" PYTHON Specific Stuff
"""
" Shortcut for running file
autocmd FileType python nnoremap <buffer> <F9> :exec '!clear;python' shellescape(@%, 1)<cr>
" Set max column
autocmd FileType python call matchadd('ColorColumn', '\%81v', 100)
"Needed for jedi?
autocmd FileType python setlocal completeopt-=preview

autocmd FileType python nnoremap + :vert term ipython -i %<CR>
"""
" TEX Specific Stuff
"""
autocmd FileType tex nnoremap <buffer> <leader>c I% <esc>
autocmd FileType tex setlocal spell
autocmd FileType tex set nocindent nosmartindent noautoindent
" Make the files readable
autocmd FileType tex set textwidth=95
augroup vimtex_config
    au!
    au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
"""
" HASKELL Specific Stuff
"""
" set noautoindent
autocmd FileType haskell nnoremap + :term ghci %<CR>
autocmd FileType haskell nnoremap <leader>y :vert term ghci %<CR>
autocmd FileType haskell set formatprg=stylish-haskell
autocmd FileType haskell set tabstop=2
autocmd FileType haskell set shiftwidth=2
autocmd FileType haskell nnoremap <buffer> <F9> :exec '!clear;ghci' shellescape(@%, 1)<cr>
"""
" STATA Specific Stuff
"""
" autocmd FileType stata nnoremap <F9> :exec '!clear; !xstata-mp do %' shellescape(@%, 1)<CR>
" autocmd FileType stata vmap <C-S-x> :<C-U>call RunDoLines()<CR><CR>

"""
" SHELL Specific Stuff
"""
autocmd FileType sh nnoremap <buffer> <F9> :exec '!clear;./%' shellescape(@%, 1)<cr>

"set noshowmode  " to get rid of thing like --INSERT--
"set noshowcmd  " to get rid of display of last command
"set shortmess+=F  " to get rid of the file name displayed in the command line bar


"""
" COC stuff
"""



let output = system("which node")
if v:shell_error == 0
    " coc here
    set cmdheight=2
    set updatetime=300

    " Use K to show documentation in preview window.
    nnoremap <silent> K :call <SID>show_documentation()<CR>

    function! s:show_documentation()
      if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
      elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
      else
        execute '!' . &keywordprg . " " . expand('<cword>')
      endif
    endfunction

    nnoremap <silent> gd <Plug>(coc-definition)
    nnoremap <silent> gy <Plug>(coc-type-definition)
    nnoremap <silent> gi <Plug>(coc-implementation)
    nnoremap <silent> gr <Plug>(coc-references)
    nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
    nnoremap <silent> ]g <Plug>(coc-diagnostic-next)
    xnoremap <leader>r <Plug>(coc-codeaction-selected)
    nnoremap <leader>r <Plug>(coc-codeaction-selected)

    let g:coc_on = 1
    function Toggle_coc()
        if ((g:coc_on) == 1)
            let g:coc_on = 0
            execute "CocDisable"
        else
            let g:coc_on = 1
            execute "CocEnable"
        endif
    endfunction

    nnoremap <leader>u :call Toggle_coc()<CR>
endif

"-------------------------------------------------------------------------------
" Vim configuration
"-------------------------------------------------------------------------------

" TODO: Convert init.vim to lua

" Vim requires a more POSIX compatible shell than fish
if &shell =~# 'fish$'
    set shell=sh
endif

" Use terminal title
set title

" Syntax highlighting
filetype plugin on
syntax on

" Show column and line info
set ruler

" Show line numbers
set number

" Highlight current line
set cursorline

" Whitespace visualization
set listchars=tab:→-,eol:↓,trail:⌂
set nolist

" Tabs should be 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Don't wrap lines
set nowrap

" File encoding
set fileencoding=utf-8

" Highlight search results
set hlsearch

" Don't autoinsert comment leaders in normal mode
set formatoptions-=o

" Treat dash separated words as a whole word
set iskeyword+=-

" Save swap file faster
set updatetime=400

" Set clipboard
set clipboard=unnamedplus

"-------------------------------------------------------------------------------
" Auto commands
"-------------------------------------------------------------------------------

" Reload vim configuration automatically when edited
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

"-------------------------------------------------------------------------------
" Mouse configuration
"-------------------------------------------------------------------------------

" Enable mouse in all modes
set mouse=a

"-------------------------------------------------------------------------------
" Key bindings
"-------------------------------------------------------------------------------

" Space
let mapleader=" "

" Visual block select
noremap <leader>v <C-v>

" System clipboard
" NOTE: This is only working (in TUI) because Wezterm is configured for it.
vnoremap <C-c> "+y
noremap <C-v> "+p

" Fuzzy finder
noremap <leader>o <cmd>Telescope find_files hidden=true no_ignore=true<cr>
noremap <leader>p <cmd>Telescope buffers<cr>
noremap <leader>f <cmd>Telescope live_grep<cr>

" Switch buffers
noremap <leader>h :bprev<cr>
noremap <leader>l :bnext<cr>

" Close buffer
noremap <leader>q :bd<cr>

" Hop (motion shortcuts)
noremap <leader>g <cmd>HopWord<cr>

" Comment out selection (VISUAL) or current line (NORMAL)
map <leader>/ gcc<esc>

" Reload vim configuration (this file)
noremap <leader>r <cmd>source $MYVIMRC<bar>echo 'Configuration reloaded. NOTE: Plugins may require restart.'<cr>

" Clear search buffer, clear command line and go to start of line
noremap <silent> <leader>m <cmd>let @/=""<bar>:echo ''<cr>0<esc>

" Format file
noremap <leader>; gg=G

" Edgemotion
map <C-j> <Plug>(edgemotion-j)
map <C-k> <Plug>(edgemotion-k)

"-------------------------------------------------------------------------------
" Neovide (GUI) configuration
"-------------------------------------------------------------------------------

if exists("g:neovide")
    set guifont=Fira\ Code:h11

    let g:neovide_cursor_vfx_mode = "sonicboom"
endif

"-------------------------------------------------------------------------------
" Colors
"-------------------------------------------------------------------------------

" TODO: Use 24bit colors: `set termguicolors`
" TODO: Apply system color scheme

" Use base 16 colors
set notermguicolors

" Let vim know we are using a dark background color
set background=dark

" Reset any pre-existing syntax highlighting
syntax reset

" Vim
hi Normal                   ctermfg=6       ctermbg=NONE    cterm=NONE              guifg=6     guibg=NONE  gui=NONE
hi NonText                  ctermfg=6       ctermbg=NONE    cterm=NONE              guifg=6     guibg=NONE  gui=NONE
hi Cursor                   ctermfg=0       ctermbg=7       cterm=NONE              guifg=0     guibg=7     gui=NONE
hi CursorLine               ctermfg=NONE    ctermbg=0       cterm=NONE              guifg=NONE  guibg=0     gui=NONE
hi MatchParen               ctermfg=14      ctermbg=NONE    cterm=bold,underline    guifg=14    guibg=NONE  gui=bold,underline
hi NonText                  ctermfg=4       ctermbg=NONE    cterm=NONE              guifg=4     guibg=NONE  gui=NONE
hi LineNr                   ctermfg=8       ctermbg=NONE    cterm=NONE              guifg=8     guibg=NONE  gui=NONE
hi CursorLineNr             ctermfg=7       ctermbg=0       cterm=NONE              guifg=7     guibg=0     gui=NONE
hi Visual                   ctermfg=0       ctermbg=13      cterm=NONE              guifg=0     guibg=13    gui=NONE
hi IncSearch                ctermfg=0       ctermbg=13      cterm=NONE              guifg=0     guibg=13    gui=NONE
hi Search                   ctermfg=11      ctermbg=2       cterm=bold              guifg=11    guibg=2     gui=bold
hi StatusLine               ctermfg=7       ctermbg=0       cterm=bold              guifg=7     guibg=0     gui=bold
hi StatusLineNC             ctermfg=8       ctermbg=0       cterm=bold              guifg=8     guibg=0     gui=bold
hi Folded                   ctermfg=6       ctermbg=0       cterm=bold              guifg=6     guibg=0     gui=bold
hi ErrorMsg                 ctermfg=11      ctermbg=1       cterm=bold              guifg=11    guibg=1     gui=bold
hi Title                    ctermfg=3       ctermbg=NONE    cterm=bold              guifg=3     guibg=NONE  gui=bold
hi! link vimCommentTitle    Comment
hi! link vimOption          Identifier
hi! link CursorColumn       CursorLine
hi! link WarningMsg         ErrorMsg
hi! link MoreMsg            Title
hi! link Question           MoreMsg
hi! link ModeMsg            MoreMsg

" Generic code
hi Identifier               ctermfg=7       ctermbg=NONE    cterm=NONE              guifg=7     guibg=NONE  gui=NONE
hi Statement                ctermfg=10      ctermbg=NONE    cterm=bold              guifg=10    guibg=NONE  gui=bold
hi Comment                  ctermfg=8       ctermbg=NONE    cterm=NONE              guifg=8     guibg=NONE  gui=NONE
hi Type                     ctermfg=3       ctermbg=NONE    cterm=NONE              guifg=3     guibg=NONE  gui=NONE
hi PreProc                  ctermfg=11      ctermbg=NONE    cterm=NONE              guifg=11    guibg=NONE  gui=NONE
hi Constant                 ctermfg=13      ctermbg=NONE    cterm=NONE              guifg=13    guibg=NONE  gui=NONE
hi Special                  ctermfg=15      ctermbg=NONE    cterm=NONE              guifg=15    guibg=NONE  gui=NONE
hi Underlined               ctermfg=4       ctermbg=NONE    cterm=underline         guifg=4     guibg=NONE  gui=underline
hi Delimiter                ctermfg=4       ctermbg=NONE    cterm=NONE              guifg=4     guibg=NONE  gui=NONE
hi String                   ctermfg=2       ctermbg=NONE    cterm=NONE              guifg=2     guibg=NONE  gui=NONE
hi Keyword                  ctermfg=10      ctermbg=NONE    cterm=bold              guifg=10    guibg=NONE  gui=bold
hi Todo                     ctermfg=7       ctermbg=NONE    cterm=bold,underline    guifg=4     guibg=NONE  gui=bold,underline
hi Function                 ctermfg=13      ctermbg=NONE    cterm=NONE              guifg=13    guibg=NONE  gui=NONE
hi Number                   ctermfg=9       ctermbg=NONE    cterm=NONE              guifg=9     guibg=NONE  gui=NONE
hi Boolean                  ctermfg=9       ctermbg=NONE    cterm=NONE              guifg=9     guibg=NONE  gui=NONE
hi Ignore                   ctermfg=0       ctermbg=NONE    cterm=NONE              guifg=0     guibg=NONE  gui=NONE
hi! link Error              ErrorMsg
hi! link Operator           Delimiter

augroup AlwaysHighlightTodoNote
    autocmd!
    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|NOTE', -1)
augroup END

"-------------------------------------------------------------------------------
" Plugins
"-------------------------------------------------------------------------------

lua require('plugins')


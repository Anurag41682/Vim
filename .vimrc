"set nocompatible
filetype on
set number
set title
"set backspace=indent,eol,start
set noexpandtab tabstop=2 shiftwidth=2
set softtabstop=2
set mouse=a
set completeopt-=preview
set nobackup
set noswapfile
set noundofile
set nowritebackup


"-----------------------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')

Plug 'neoclide/coc.nvim', {'branch': 'release'} "LSP support provider
Plug 'dense-analysis/ale' "Linter (syntax checker) for all language need to install the linter globally
Plug 'rhysd/vim-clang-format' "formatter for c++ family
Plug 'prettier/vim-prettier' "formatter for webdev language
Plug 'sheerun/vim-polyglot' "Highlighter(Make text colorful) and indenter for all language
Plug 'maxmellon/vim-jsx-pretty' "Highlighter for jsx files
Plug 'junegunn/fzf.vim' "file explorer also install ripgrep
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "same file explorer just to install latest
Plug 'joshdick/onedark.vim' "theme colorscheme

call plug#end()
syntax enable
"-------------------------------------------------------------------------------------------------



"-----------------------------:CocConfig file-----------------------------------
"{
	"suggest.noselect" : true,
	"inlayHint.enable": false,
	"tsserver.checkOnSave": true
"}



"----------LSP extensions that need to be installed in vim for to be used inside coc.nvim -----------

":CocInstall coc-tsserver (for js,jsx,ts,tsx) 
":CocInstall coc-clangd (for c++ requires clangd to be preinstalled)
":CocInstall coc-html (for html)
":CocInstall coc-css (for css)

"------------------- Linter that need to be installed globally (need config file too)------------------
" 'Eslint' for js,ts,jsx,tsx,json
" 'clangd' work here for c++
" 'htmlhint' for html
" 'stylelint' for css


"----------------Formatter that need to be installed globally ----------
" 'clang-formatter' for c++
" 'prettier' for js,html,css,json,ts,jsx,tsx



"------------------------Theme colorscheme-----------------------------------------------

"colorscheme solarized
"colorscheme tokyonight
"colorscheme monokai
"colorscheme gruvbox
colorscheme onedark

"set background=dark
"set termguicolors
"colorscheme monokai_pro
"let g:lightline = {
"      \ 'colorscheme': 'monokai_pro',
"      \ }

"let g:molokai_original = 1
"colorscheme molokai

"colorscheme tender
"let g:lightline = { 'colorscheme': 'tender' }
"let g:airline_theme = 'tender'






"---------------------------Keymaps and Binding------------------------------------------
let mapleader=" "
nnoremap <F5> :!g++-12 -std=c++20 -O2 -Wall -Wextra -Wshadow -fsanitize=undefined -fno-sanitize-recover -DLOCAL -g % -o %:r && ./%:r<CR>
nnoremap<C-F5> :!clang++-14 -std=c++20 -Wall -Wextra -Wshadow -fsanitize=undefined -fno-sanitize-recover -DLOCAL  -g % -o %:r && ./%:r<CR>
inoremap {<CR> {<CR>}<C-o>O
vnoremap<C-C> :w !xclip -i -sel c <CR>
noremap<C-A> ggVG
noremap<C-T> :tabnew


"---------------------------------------------------------------------------------------------

"-----------------------------fzf explorer specific----------------
nnoremap <silent> <C-F> :Files<CR>

"needs to install ripgrep
noremap <silent> <leader>f :Rg<CR> 

"---------enables hidden file to search------------
let $FZF_DEFAULT_COMMAND = 'find . -type f'
			



"---------------------------------------------------------------------------------------------
"----used in vim-jsx-pretty ----
let g:vim_jsx_pretty_highlight_close_tag = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0




"-----------------------------------------------------------------------------




"-------------------------Template ----------------------
autocmd BufNewFile *.cpp execute "0r ~/.vim/template/".input("Template name: ").".cpp"


"-------------------------------------------------------------------------------



"-------------------------Auto-Format on Save -----------------------------
"-------------------C++----------------------

autocmd FileType cpp ClangFormatAutoEnable


"----------------Javascript and all------------------

let g:prettier#config#single_quote = 1
let g:prettier#config#trailing_comma = 'all'
let g:prettier#config#arrow_parens = 'avoid'

autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.html,*.css,*.json,*.graphql :PrettierAsync




"---------------------------- Linter(syntax checker) --------------------------
let g:ale_linters = {
      \ 'javascript': ['eslint'],
      \ 'javascript.jsx': ['eslint'],
      \ 'typescript': ['eslint'],
			\ 'html': ['htmlhint'],
			\ 'css': ['stylelint'],
			\ 'typescript.tsx': ['eslint'],
      \ }



"--------------------------------- color change -----------------------------------
"gui ==  gvim
"cterm == terminal vim (only this in my case matter)
"terminal support 1-256 colors you can google all the colors/print on cmd itself 
"----------------------------------------------------------------------------------
"AlienBlood looking good on this settings


"for removing background color in vim and using the terminal background
hi Normal ctermbg=none
"suggestion box
highlight CocFloating ctermfg=white  ctermbg=black 
"side line warning and error when comes
highlight SignColumn ctermbg=none guibg=white ctermfg=white guifg=white
"change the color of background color of selected text in visual mode
highlight Visual ctermbg=236 guibg=lightgray
"Parenthesis background and foreground color when cursor hovers
highlight MatchParen ctermfg=214 ctermbg=none


"------------------------------------------------------------------------------

"use <tab> to trigger completion and navigate to the next complete item
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()




"--------------------------------------------------------------------------------

"--------------To have only file name in new tab----------------------
set tabline=%!MyTabLine()
function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        let tab = i + 1
        let winnr = tabpagewinnr(tab)
        let bufnr = tabpagebuflist(tab)[winnr - 1]
        let bufname = bufname(bufnr)
        let bufname = fnamemodify(bufname, ':t') " Get only the filename
        let s .= '%' . tab . 'T'
        let s .= (tab == tabpagenr() ? '%1*' : '%2*')
        let s .= ' ' . bufname . ' '
        if tab < tabpagenr('$')
            let s .= '|'
        endif
    endfor
    return s
endfunction




"--------------------------------------------------------------------------------


"END



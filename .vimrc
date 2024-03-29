filetype on
set number
set title
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

Plug 'neoclide/coc.nvim', {'branch': 'release'} "like intellisense
Plug 'dense-analysis/ale' "Linter (syntax checker) for all language need to install the linter globally
Plug 'rhysd/vim-clang-format' "formatter for c++ family
Plug 'prettier/vim-prettier' "formatter for webdev language
Plug 'sheerun/vim-polyglot' "Highlighter(Make text colorful) and indenter for all language
Plug 'maxmellon/vim-jsx-pretty' "Highlighter for jsx files
Plug 'junegunn/fzf.vim' "file explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } } "file explorer

call plug#end()
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

"------------------- Linter that need to be installed globally (needs config file)------------------
" 'Eslint' for js,ts,jsx,tsx,json
" 'clangd' work here for c++
" 'htmlhint' for html
" 'stylelint' for css


"----------------Formatter that need to be installed globally ----------
" 'clang-formatter' for c++
" 'prettier' for js,html,css,json,ts,jsx,tsx



"-----------------------------------Theme colorscheme-----------------------------------------------


"----------------------------------------------------------------------------------------------------




"------------------------------------Keymaps and Binding------------------------------------------
"-------------------------General---------------------------------
nnoremap <F5> :!g++-12 -std=c++20 -O2 -Wall -Wextra -Wshadow -fsanitize=undefined -fno-sanitize-recover -DLOCAL -g % -o %:r && ./%:r<CR>
nnoremap<C-F5> :!clang++-14 -std=c++20 -Wall -Wextra -Wshadow -fsanitize=undefined -fno-sanitize-recover -DLOCAL  -g % -o %:r && ./%:r<CR>
inoremap {<CR> {<CR>}<C-o>O
vnoremap<C-C> :w !xclip -i -sel c <CR>
noremap<C-A> ggVG
noremap<silent> <C-T> :tabnew<CR>
noremap<silent> <C-E> :e .<CR>
noremap<silent> <C-H> :tabprevious<CR>
noremap<silent> <C-L> :tabnext<CR>

"-----------------------fzf explorer specific----------------
"--------(file search)----------------
nnoremap <silent> <C-F> :Files<CR>

"needs to install ripgrep (word search)
noremap <silent> <leader>f :Rg <CR> 

"--------------enables word search inside hidden files--------
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)


"---------enables hidden file to search----------------------
"let $FZF_DEFAULT_COMMAND = 'find . -type f'


"-----------------coc.nvim specific--------------------------------
"---------------go to definition----------
nmap <silent> gd :call CocAction('jumpDefinition', 'tabe')<CR>



"------------------------------------------------------------------------------------------------



"------------------------Used in vim-jsx-pretty ------------------------------
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
"hi Normal ctermbg=none
"suggestion box
"highlight CocFloating ctermfg=white  ctermbg=black
"side line warning and error when comes
"highlight SignColumn ctermbg=none guibg=white ctermfg=white guifg=white
"change the color of background color of selected text in visual mode
"highlight Visual ctermbg=236 guibg=lightgray
"Parenthesis background and foreground color when cursor hovers
"highlight MatchParen ctermfg=214 ctermbg=none

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

"--------------Tab Configuration----------------------

set tabline=%!MyTabLine()

function! MyTabLine()
  let s = ''
  for i in range(tabpagenr('$'))
    let tab = i + 1
    let winnr = tabpagewinnr(tab)
    let bufnr = tabpagebuflist(tab)[winnr - 1]
    let bufname = bufname(bufnr)
    let bufname = fnamemodify(bufname, ':t')
    let filler = (tab == tabpagenr('$') ? '%#TabLineFill#' : '|')
    let s .= '%' . tab . 'T'
    let s .= (tab == tabpagenr() ? '%#StatusLine#' : '%#TabLine#')
    let s .= ' ' . bufname . ' '
    let s .= filler
  endfor
  return s
endfunction


"--------------------------------------------------------------------------------


"END



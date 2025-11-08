" Set compatibility to vim only
set nocompatible

filetype off

" Highlight blank spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWritePre * %s/\s\+$//e

" Set the max lenght of a line
autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>120v.\+', -1)

" Show line numbers
set relativenumber

" Status bar
set laststatus=2

" Automatically wrap text that extends beyond the screen lenght
set wrap

" Call the .vimrc.plug file
if filereadable(expand("~/.vimrc.plug"))
	source ~/.vimrc.plug
endif

" NERDTree settings
" autocmd VimEnter * NERDTree
map <F2> :NERDTreeToggle<CR>

" Start VundleVim envirement configuration
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Install VundleVim
Plugin 'VundleVim/Vundle.vim'

" Install YouCompleteMe
Plugin 'ycm-core/YouCompleteMe'

" Install vim-cpp-enhanced-highlight
Plugin 'octol/vim-cpp-enhanced-highlight'

" Nerdtree git plugin
Plugin 'xuyuanp/nerdtree-git-plugin'

" Vim clang formatter
Plugin 'rhysd/vim-clang-format'

call vundle#end()
filetype plugin indent on


" Nerdtree git configuration
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'+',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }


let g:NERDTreeGitStatusUseNerdFonts = 1

" C language formatter
let g:clang_format#style_options = {
            \ "AccessModifierOffset" : -4,
            \ "AllowShortIfStatementsOnASingleLine" : "true",
            \ "AlwaysBreakTemplateDeclarations" : "true",
            \ "Standard" : "C++11"}

" map to <Leader>cf in C++ code
autocmd FileType c,cpp,objc nnoremap <buffer><Leader>cf :<C-u>ClangFormat<CR>
autocmd FileType c,cpp,objc vnoremap <buffer><Leader>cf :ClangFormat<CR>
" if you install vim-operator-user
autocmd FileType c,cpp,objc map <buffer><Leader>x <Plug>(operator-clang-format)
" Toggle auto formatting:
nmap <Leader>C :ClangFormatAutoToggle<CR>

autocmd FileType c ClangFormatAutoEnable

" Mapped keys
nnoremap } }zz
nnoremap { {zz

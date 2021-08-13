
""""""""""""""""""""""""
"      basics
""""""""""""""""""""""""
set number " 行番号
set hlsearch " 検索結果をハイライト
set tabstop=2 " tab
set wildmenu
set autoindent
set hidden " バッファ切替時の警告メッセージOFF
""""""""""""""""""""""""
"      key bind
""""""""""""""""""""""""
" buffer
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>


""""""""""""""""""""""""
"      補完
""""""""""""""""""""""""
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

""""""""""""""""""""""""
"     python
""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.py setfiletype python
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" colorscheme nord

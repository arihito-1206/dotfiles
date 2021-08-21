""""""""""""""""""""""""
"      basics
""""""""""""""""""""""""
set number " 行番号
set hlsearch " 検索結果をハイライト
set tabstop=2 " tab
set wildmenu
set autoindent
set hidden " バッファ切替時の警告メッセージOFF
set laststatus=2 " 常にStatus Lineを表示する


""""""""""""""""""""""""
"      key bind
""""""""""""""""""""""""
" buffer
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>


""""""""""""""""""""""""
"      補完
""""""""""""""""""""""""
inoremap { {}<LEFT>
inoremap {<Enter> {}<LEFT><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<LEFT><CR><ESC><S-o>
inoremap " ""<LEFT>
inoremap ' ''<LEFT>

""""""""""""""""""""""""
"     python
""""""""""""""""""""""""
autocmd BufRead,BufNewFile *.py setfiletype python
augroup fileTypeIndent
    autocmd!
    autocmd BufNewFile,BufRead *.py setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END


" colorscheme nord

""""""""""""""""""""""""
"      dein.vim
""""""""""""""""""""""""
" plugin manager ---------------------------------------------
if &compatible
  set nocompatible
endif

" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')

" dein.vim本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" tomlセット
let s:toml_dir=expand('~/.dein/')
let s:toml=s:toml_dir . 'dein.toml'
let s:toml_lazy=s:toml_dir . 'dein-lazy.toml'

" プラグインのロード
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  call dein#load_toml(s:toml)
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" インストールしていないプラグインがあればインストールを実行
if dein#check_install()
  call dein#install()
endif

" ------------------------------------------------------------
""""""""""""""""""""""""
"      coc.nvim
""""""""""""""""""""""""
" coc.nvim のステータスメッセージを statusline に表示させる
" set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"rnmap <silent>gr<Plug>(coc-references)

""""""""""""""""""""""""
"      cursor
""""""""""""""""""""""""
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

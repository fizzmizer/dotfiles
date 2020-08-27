set number relativenumber
set linebreak
set showmatch
set hlsearch
set smartcase
set ignorecase
set nocompatible
set incsearch
set autoindent
set expandtab
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4
set ruler
set undolevels=1000
set backspace=indent,eol,start
set mouse=c
set encoding=utf-8
set t_Co=256
set hls!
set splitright
set splitbelow
set laststatus=2


let &t_SI = "\e[6 q"
let &t_EI = "\e[1 q"


filetype plugin indent on
syntax on

call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'easymotion/vim-easymotion'
Plug 'junegunn/goyo.vim'
Plug 'vim-latex/vim-latex'
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'jceb/vim-orgmode'
Plug 'crusoexia/vim-monokai'
Plug 'tpope/vim-speeddating'
Plug 'wellle/targets.vim'
Plug 'vimwiki/vimwiki'
Plug 'itchyny/lightline.vim'

call plug#end()


function! WC()
  let filename = expand("%")
  let cmd = "detex " . filename . " | wc -w | tr -d [:space:]"
  let result = system(cmd)
  echo result . " words"
endfunction

command WC call WC()
nmap <C-c><C-w> :WC<CR>


function! WordCount()
  let s:old_status = v:statusmsg
  let position = getpos(".")
  exe ":silent normal g\<c-g>"
  let stat = v:statusmsg
  let s:word_count = 0
  if stat != '--No lines in buffer--'
    if stat =~ "^Selected"
      let s:word_count = str2nr(split(v:statusmsg)[5])
    else
      let s:word_count = str2nr(split(v:statusmsg)[11])
    end
    let v:statusmsg = s:old_status
  end
  call setpos('.', position)
  return s:word_count 
endfunction


function! VimwikiLinkHandler(link)
" Use Vim to open external files with the 'vfile:' scheme.  E.g.:
"   1) [[vfile:~/Code/PythonProject/abc123.py]]
"   2) [[vfile:./|Wiki Home]]
let link = a:link
if link =~# '^vfile:'
  let link = link[1:]
else
  return 0
endif
let link_infos = vimwiki#base#resolve_link(link)
if link_infos.filename == ''
  echomsg 'Vimwiki Error: Unable to resolve link!'
  return 0
else
  exe 'tabnew ' . fnameescape(link_infos.filename)
  return 1
endif
endfunction


let g:lightline = {
\ 'colorscheme': 'darkula',
\ 'active': {
\   'left': [ [ 'mode', 'paste' ],
\             [ 'readonly', 'filename', 'modified', 'wordcount' ] ]
\ },
\ 'component': {
\   'wordcount': '%{WordCount()} words'
\ },
\ }



let g:vimwiki_list = [{'path': '~/Nextcloud/wiki/', 'path_html': '~/Nextcloud/wiki/'}]


let g:gruvbox_italic=1
colorscheme gruvbox
set background=dark
"colorscheme monokai


imap <C-c> Ç

map <Space>f <Plug>(easymotion-s2)


imap <C-e> <Esc>
imap <C-x><C-s> <Esc>:w<CR>a
nmap <C-x><C-s> :w<CR>
nmap <C-t><C-t> :TTemplate<CR>


nmap <C-h> <C-w><
nmap <C-l> <C-w>>
nmap <C-i> 93<C-W>>

nmap gn :tabnew<Space>



let g:tex_flavor='latex'
let g:Tex_CustomTemplateDirectory = '~/Templates/'
let g:Tex_DefaultTargetFormat='pdf'
let g:Tex_FoldedEnvironments='abstract, titlepage'
let g:Tex_FoldedMisc='preamble'
let g:Tex_ViewRule_pdf='okular'
map <C-c><C-l> :!pdflatex %<CR>
map <C-c><C-o> <leader>lv
map <C-c><C-b> :!bibtex %<<CR>


autocmd VimLeave *.tex !rubber --clean %


nnoremap <leader>d "=strftime("%d/%m/%Y -- %A")<CR>P


"LaTeX Raccourcis

autocmd FileType tex inoremap &fr \begin{frame}<Enter>\frametitle{}<Enter><Enter><++><Enter><Enter>\end{frame}<Enter><Enter><++><Esc>6kf}i
autocmd FileType tex inoremap &it \textit{} <++><Esc>T{i
autocmd FileType tex inoremap &bf \textbf{} <++><Esc>T{i
autocmd FileType tex inoremap &up \usepackage{}<++><Esc>T{i
autocmd FileType tex inoremap &en \begin{enumerate}<Enter><Enter>\end{enumerate}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap &bit \begin{itemize}<Enter><Enter>\end{itemize}<Enter><Enter><++><Esc>3kA\item<Space>
autocmd FileType tex inoremap &li <Esc>A<Enter>\item<Space>
autocmd FileType tex inoremap &chap \chapter{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap &sec \section{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap &ssec \subsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap &sssec \subsubsection{}<Enter><Enter><++><Esc>2kf}i
autocmd FileType tex inoremap &jo \jour{ <Esc>"=strftime("%d/%m/%Y -- %A")<CR>P i}<CR><CR>
autocmd FileType tex inoremap &" «~~»<++> <Esc>6hi
autocmd FileType tex inoremap &vs \vspace{}<++> <Esc>5hi
autocmd FileType tex inoremap &v1 \vspace{1cm}<CR><CR>
autocmd FileType tex inoremap &v2 \vspace{2cm}<CR><CR>
autocmd FileType tex inoremap &v3 \vspace{3cm}<CR><CR>
autocmd FileType tex inoremap &v3 \vspace{3cm}<CR><CR>
autocmd FileType tex inoremap &mn \begin{minipage}{.48\textwidth}<CR>\end{minipage}\hfill<CR>\begin{minipage}{.48\textwidth}<CR><++><CR>\end{minipage}<CR><CR><++><Esc>6ko


"HTML Raccourcis

autocmd FileType html inoremap &b <b></b><Space><++><Esc>FbT>i
autocmd FileType html inoremap &it <em></em><Space><++><Esc>FeT>i
autocmd FileType html inoremap &1 <h1></h1><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap &2 <h2></h2><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap &3 <h3></h3><Enter><Enter><++><Esc>2kf<i
autocmd FileType html inoremap &p <p></p><Enter><Enter><++><Esc>02kf>a
autocmd FileType html inoremap &a <a<Space>href=""><++></a><Space><++><Esc>14hi
autocmd FileType html inoremap &ul <ul><Enter><li></li><Enter></ul><Enter><Enter><++><Esc>03kf>a
autocmd FileType html inoremap &li <Esc>o<li></li><Esc>F>a
autocmd FileType html inoremap &ol <ol><Enter><li></li><Enter></ol><Enter><Enter><++><Esc>03kf>a
autocmd FileType html inoremap &im <img src="" alt="<++>"><++><esc>Fcf"a

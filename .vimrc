call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'skywind3000/asyncrun.vim'

Plug 'https://github.com/w0rp/ale.git'

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

Plug 'https://github.com/ludovicchabant/vim-gutentags.git'

Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-indent'
Plug 'kana/vim-textobj-syntax'
Plug 'kana/vim-textobj-function', { 'for':['c', 'cpp', 'vim', 'java'] }
Plug 'sgur/vim-textobj-parameter'

Plug 'https://github.com/Valloric/YouCompleteMe.git'

Plug 'https://github.com/Yggdroot/LeaderF.git'

Plug 'https://github.com/Shougo/echodoc.vim.git'

Plug 'liuchengxu/space-vim-dark'

Plug 'https://github.com/SpaceVim/SpaceVim.git'

call plug#end()

let mapleader=","
let g:mapleader=","

set tags=./.tags;,.tags


" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6

" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(6)<cr>

augroup f_key
	autocmd!

"编译单文件"

autocmd BufNewFile,BufRead *.c nnoremap <silent> <F9> :AsyncRun gcc -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

"c++编译"
autocmd BufNewFile,BufRead *.cpp nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>

autocmd BufNewFile,BufRead *.py nnoremap <silent> <F5> :AsyncRun -raw python "$(VIM_FILEPATH)" <cr>

"F9 就可以编译当前文件，同时按 F5 运行"
autocmd BufNewFile,BufRead *.c,*.cpp nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
augroup END



"重新定义项目标志"
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml']

"F7 编译整个项目"
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>

"继续配置用 F8 运行当前项目"
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>

"makefile 中需要定义怎么 run ，接着按 F6 执行测试"
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>

"F4 为更新 Makefile 文件"
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

let $PYTHONUNBUFFERED=1

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1

let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''
let g:ale_linters = {
\   'c++': ['clang'],
\   'c': ['clang'],
\   'python': ['pylint'],
\}
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>

let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone

noremap <c-z> <NOP>

let g:ycm_semantic_triggers =  {
           \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
           \ 'cs,lua,javascript': ['re!\w{2}'],
           \ }

"定义错误样式"
let g:ale_sign_error = "\ue009\ue009"
hi! clear SpellBad
hi! clear SpellCap
hi! clear SpellRare
hi! SpellBad gui=undercurl guisp=red
hi! SpellCap gui=undercurl guisp=blue
hi! SpellRare gui=undercurl guisp=magenta

let g:Lf_ShortcutF = '<c-p>'
let g:Lf_ShortcutB = '<m-n>'
noremap <c-n> :LeaderfMru<cr>
noremap <m-p> :LeaderfFunction!<cr>
noremap <m-n> :LeaderfBuffer<cr>
noremap <m-m> :LeaderfTag<cr>
let g:Lf_StlSeparator = { 'left': '', 'right': '', 'font': '' }

let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/cache')
let g:Lf_ShowRelativePath = 0
let g:Lf_HideHelp = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}

" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

let g:spacevim_plug_home = '~/.vim/plugged'

let g:spacevim_layers = [
	\ 'fzf', 'unite', 'better-defaults',
	\ 'which-key',
	\ ]

syntax on 
set nu  
set nobackup 
set cursorline 
set ruler  
set autoindent 

" 用浅色高亮当前行 "
autocmd InsertEnter * se cul

"显示标尺"
set ruler

"输入的命令显示出来"
set showcmd

"命令行（在状态行下）的高度，设置为1"
set cmdheight=1

"允许折叠"
set foldenable

"手动折叠"
set foldmethod=manual

"显示中文帮助"
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

"定义函数SetTitle，自动插入文件头"
func SetTitle() 

    "如果文件类型为.sh文件 "

    if &filetype == 'sh' 

        call setline(1,"\#########################################################################") 

        call append(line("."), "\# File Name: ".expand("%")) 

        call append(line(".")+1, "\# Author: sjming") 

        call append(line(".")+2, "\# mail: xxx.com") 

        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 

        call append(line(".")+4, "\#########################################################################") 

        call append(line(".")+5, "\#!/bin/bash") 

        call append(line(".")+6, "") 

    else 

        call setline(1, "/*************************************************************************") 

        call append(line("."), "    > File Name: ".expand("%")) 

        call append(line(".")+1, "    > Author: sjming") 

        call append(line(".")+2, "    > Mail: xxx.com ") 

        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 

        call append(line(".")+4, " ************************************************************************/") 

        call append(line(".")+5, "")

    endif

    if &filetype == 'cpp'

        call append(line(".")+6, "#include<iostream>")

        call append(line(".")+7, "using namespace std;")

        call append(line(".")+8, "")

    endif

    if &filetype == 'c'

        call append(line(".")+6, "#include<stdio.h>")

        call append(line(".")+7, "")

    endif

    "新建文件后，自动定位到文件末尾"

    autocmd BufNewFile * normal G

endfunc 


"设置当文件被改动时自动载入"
set autoread

"quickfix模式"
autocmd FileType c,cpp map <buffer> <leader><space> :w<cr>:make<cr>

"代码补全"
set completeopt=preview,menu

"自动保存"
set autowrite

"自动缩进"
set autoindent

set cindent

"Tab键的宽度"
set tabstop=4

"统一缩进为4"
set softtabstop=4

set shiftwidth=4

"在行和段开始处使用制表符"
set smarttab

"搜索忽略大小写"
set ignorecase

"编码设置"
set enc=utf-8
set fencs=utf-8,ucs-bom,shift-jis,gb18030,gbk,gb2312,cp936
set fileencodings=ucs-bom,utf-8,utf-16,gbk,big5,gb18030,latin1
set fileencoding=utf-8
set encoding=utf-8

"语言设置"
set langmenu=zh_CN.UTF-8

set helplang=cn

"状态行显示的内容（包括文件类型和解码）"
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}

set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

"总是显示状态行"
set laststatus=2

"命令行（在状态行下）的高度，默认为1，这里是2"
set cmdheight=2

"侦测文件类型"
filetype on

"载入文件类型插件"
filetype plugin on

"为特定文件类型载入相关缩进文件"
filetype indent on

"打开文件类型检测, 加了这句才可以用智能补全"
set completeopt=longest,menu

"高亮显示匹配的括号"
set showmatch

"为C程序提供自动缩进"
set smartindent

"自动补全"
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>

function ClosePair(char)
 if getline('.')[col('.') - 1] == a:char
 return "\<Right>"
 else
 return a:char
 endif
endf

function CloseBracket()
 if match(getline(line('.') + 1), '\s*}') < 0
 return "\<CR>}"
 else
 return "\<Esc>j0f}a"
 endif
endf

function QuoteDelim(char)
 let line = getline('.')
 let col = col('.')
 if line[col - 2] == "\\"
 return a:char
 elseif line[col - 1] == a:char
 return "\<Right>"
 else
 return a:char.a:char."\<Esc>i"
 endif
endf


map <F3> :NERDTreeMirror<CR>

map <F3> :NERDTreeToggle<CR>

let g:space_vim_dark_background = 234
colorscheme space-vim-dark
hi Comment cterm=italic
hi Normal     ctermbg=NONE guibg=NONE
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi Comment guifg=#5C6370 ctermfg=59

nnoremap <leader>w :w!<cr>
nnoremap <leader>q :q!<cr>
nnoremap <leader>wq :wq!<cr>
nnoremap H ^
nnoremap L $

inoremap jk <ESC>
map <leader>1 <ESC>:w!<cr><F1>
map <leader>2 <ESC>:w!<cr><F2>
nmap <Space>9 <F9>

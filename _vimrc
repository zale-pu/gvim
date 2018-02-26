""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible        " 不要使用vi的键盘模式，而是vim自己的
set shortmess=atI       " 启动的时候不显示那个援助索马里儿童的提示

function! MySys()
    if has("win32")
        return "win32"
    elseif has("unix")
        return "unix"
    else
        return "mac"
    endif
endfunction

if has("eval")
    filetype on         " 侦测文件类型
    filetype plugin on  " 载入文件类型插件
    filetype indent on  " 为特定文件类型载入相关缩进文件
endif

"Set shell to be bash
if MySys() == "unix" || MySys() == "mac"
    set shell=bash
else
    "set shell=E:cygwininsh
endif

""**********************************************************""
"Have the mouse enabled all the time:
if exists("&mouse")
    set mouse=a                                               " 打开鼠标支持
    set selection=exclusive                                   " 打开鼠标支持
    set selectmode=mouse,key
    set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$
    set formatoptions=tcrqn                                   " format
    set completeopt=longest,menu
    set complete=.,i
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
endif

let mapleader = ","     " Set mapleader
let g:mapleader = ","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if MySys() == "win32"
    set rtp+=$VIM/vimfiles/bundle/vundle/
else
    set rtp+=~/.Vim/bundle/vundle
endif
call vundle#rc('$VIM/vimfiles/bundle/')
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if exists("&autoread")
    set autoread        " 设置当文件被改动时自动载入
endif

""******************* Text option **************************""
set shiftwidth=4        " 设定 << 和 >> 命令移动时的宽度为 4  
set softtabstop=4       " 使得按退格键时可以一次删掉 4 个空格
set tabstop=4           " Tab键的宽度
set expandtab           " 用空格代替制表符
" set noexpandtab       " 不要用空格代替制表符
set backspace=2
set smarttab            " 在行和段开始处使用制表符
set autoindent          " Auto indent
set smartindent         " 开启新行时使用智能自动缩进
set wrap                " 设置自动换行
set wrapmargin=0        " 右視窗邊向左算起要幾個字元起折行
set textwidth=120       " 超過此寬度就會自動折行
set linebreak           " 整词换行，与自动换行搭配使用

" set iskeyword+=_,$,@,%,#   " 带有如下符号的单词不要被换行分割

if has("cindent")
    set cindent         " C-style indenting
endif

set history=400         " 历史记录数

"""""""""""""""""""""""""""""""
" => Fileformat
"""""""""""""""""""""""""""""""
set ffs=unix,dos,mac                                " 设置兼容dos和unix格式 
set encoding=utf-8
set termencoding=utf-8
set fileencodings=utf-8,chinese,ucs-bom,cp936

if MySys()=="win32" && has("gui_running")
    " 解决vim的菜单乱码
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
 
    "解决consle输出乱码
    language messages zh_CN.utf-8
endif

 
nmap <leader>fd :se ff=dos<cr>
nmap <leader>fu :se ff=unix<cr>
nmap <leader>mm :%s/\r$//g<CR>:noh<CR>              " Remove the Windows ^M
nmap <leader>ms :%s/\s\+$//g<CR>:noh<CR>            " 清除行尾空格
nmap <leader>tt :set noexpandtab<CR>:%retab!<CR>    " 将空格替换为tab
nmap <leader>ts :set expandtab<CR>:%retab!<CR>      " 将tab替换为空格

""******************* Files and backup **********************""
set nobackup            " 覆盖文件时不备份
set nowb
set noswapfile          " 不要生成swap文件,当buffer被丢弃时候隐藏它
" set autowrite           " 自动保存
" set backupcopy=yes      " 设置备份时的行为为覆盖
" set autochdir           " 自动切换当前目录为当前文件所在的目录

"""""""""""""""""""""""""""""""
" => VIM userinterface
"""""""""""""""""""""""""""""""
set so=2                " Set 7 lines to the curors - when moving vertical..
set wildmenu            " 增强模式中的命令行自动完成操作
set cmdheight=1         " 命令行（在状态行下）的高度，默认为1
set number              " 显示行号
set lazyredraw          " Do not redraw, when running macros..
set hid                 " Change buffer - without saving

set backspace=eol,start,indent          " et backspace
set whichwrap+=<,>,h,l                  " 允许backspace和光标键跨越行边界

"Ignore case when searching
set magic
set ignorecase  " 搜索忽略大小写,但在有一个或以上大写字母时仍保持对大小写敏感
set incsearch   " 输入搜索内容时就显示搜索结果
set hlsearch    " 搜索时高亮显示被找到的文本
set incsearch   " 增量查找

set noerrorbells        " 关闭错误信息响铃  
set novisualbell        " 关闭使用可视响铃代替呼叫  
set t_vb=               " 置空错误铃声的终端代码  

set showmatch           " 高亮显示匹配的括号
set showcmd             " 输入的命令显示出来

set mat=8               " How many tenths of a second to blink

if has("gui_running")
    set guioptions-=m   " 隐藏菜单栏
    set guioptions-=T   " 隐藏工具栏
    set guioptions-=l
    set guioptions-=L   " 隐藏左侧滚动条
    set guioptions-=r   " 隐藏右侧滚动条
    set guioptions-=R
    set guioptions-=e
    set guioptions-=b   " 隐藏底部滚动条
    set showtabline=0   " 隐藏Tab栏

    if MySys()=="win32" && has("autocmd")
        autocmd GUIEnter * simalt ~x
        nmap <C-F11> <Esc>:call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR> 
    endif
endif

set cul                 " 高亮光标所在行
" set cuc                 " 高亮光标所在列

"高亮字符，让其不受100列限制
:highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
:match OverLength '\%200v.*'            " 高亮字符，让其不受100列限制
" nnoremap <Esc> <Esc>:noh<CR>

if exists("&ambiwidth")
    set ambiwidth=double    " if you use vim in tty
endif

"""""""""""""""""""""""""""""""
" => Moving around and tab
"""""""""""""""""""""""""""""""
"Smart way to move btw. window
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

"""""""""""""""""""""""""""""""
" => Folding
"""""""""""""""""""""""""""""""
"Enable folding, I find it very useful
if exists("&foldenable")
    set fen
endif

if exists("&foldlevel")
    set fdl=0
endif

set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]   " 显示文件名：总行数，总的字符数
set ruler "在编辑过程中，在右下角显示光标位置的状态行

if exists('+colorcolumn')
    set colorcolumn=80,120
    hi colorcolumn guibg=darkblue
    hi colorcolumn ctermbg=darkblue
else
    autocmd BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/L9'
Bundle 'Yggdroot/indentLine'
nmap <leader>il :IndentLinesToggle<CR>
let g:indentLine_color_gui = '#303030'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'altercation/vim-colors-solarized'
" Bundle 'tomasr/molokai'
Bundle 'junegunn/seoul256.vim'
colorscheme seoul256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'godlygeek/tabular'
" xmap <A-t>  :Tabular /

Bundle 'junegunn/vim-easy-align'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'terryma/vim-multiple-cursors'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " Default mapping
let g:multi_cursor_next_key='<A-n>'
let g:multi_cursor_prev_key='<A-p>'
let g:multi_cursor_skip_key='<A-x>'
let g:multi_cursor_quit_key='<Esc>'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tpope/vim-surround'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cs 改变外部包围对象
" ds 删除外部包围对象
" ys 使用指定的符号包裹文本对象

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'Lokaltog/vim-easymotion'
" => easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:EasyMotion_leader_key = '<Leader>'
let g:EasyMotion_do_shade = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'kien/ctrlp.vim'
Bundle 'ctrlpvim/ctrlp.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map='<C-p>'
let g:ctrlp_open_multiple_files='v'
let g:ctrlp_root_markers = ['tags']
let g:ctrlp_custom_ignore = {
            \ 'dir':  '{\.git$\|\.hg$\|\.svn$|^\.*}',
            \ 'file': '{tags|taghl|cscope\.|None}'
            \ }

set wildignore+=*.zip,*.exe,*.dll,*.bin,*.d,*.o,*.so,*.a
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'scrooloose/nerdtree'
" => NERDTree           " 以树状方式浏览系统中的文件和目录 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-F3> :NERDTreeToggle<cr>       " 列出当前目录文件

let NERDTreeIgnore=[
            \ 'cscope\.','tags','taghl','\.pyc','\~$','\.swp','None',
            \ '\.d','\.o','\.so','\.a','\.map','\.bin','\.elf','\.exe',
            \ '\.\d*\d$'
            \ ]

" let NERDTreeShowBookmarks=1                       " 显示书签列表
" let NERDTreeShowLineNumbers=1                     " 显示行号
" let NERDTreeAutoCenter=1
" let NERDTreeShowHidden=1                          " 是否显示隐藏文件
" let g:nerdtree_tabs_open_on_console_startup=1     " 在终端启动vim时，共享NERDTree

" set viminfo='10,\"100,:20,%,n~/.viminfo
if has("autocmd")
    " 当打开vim且没有文件时自动打开NERDTree     
    autocmd vimenter * if !argc() | NERDTree | endif     

    " 只剩NERDTree时自动关闭        
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif 
endif

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'vim-scripts/sessionman.vim'
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/a.vim'
" => a.vim          " 头/源文件快速切换     " 不需要配置 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:alternateSearchPath='sfr:../source,sfr:../src,sfr:../include,sfr:../inc,sfr:../../include'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/YankRing.vim'
" => YankRing           " 查看寄存器内容
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>y :YRShow<cr>
let g:yankring_replace_n_pkey = ''

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'jlanzarotta/bufexplorer'
Bundle 'qpkorr/vim-bufkill'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
set switchbuf=usetab
nnoremap <silent> <C-A-w>       :bd!<cr>
nnoremap <silent> <A-w>         :BD!<cr>
nnoremap <silent> <C-Tab>       :bn<cr>
nnoremap <silent> <C-S-Tab>     :bp<cr>
nnoremap <silent> <leader>bl    :buffers<cr>
nnoremap <silent> <leader>bn    :bn<cr>
nnoremap <silent> <leader>bp    :bp<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'bling/vim-airline'
" http://www.jianshu.com/p/310368097c75
" linux, https://github.com/powerline/fonts
" windows, https://github.com/eugeii/consolas-powerline-vim
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2          " always display the tab line
" 这个是安装字体后 必须设置此项
let g:airline_powerline_fonts = 1

" 打开tabline功能,方便查看Buffer和切换，这个功能比较不错
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

if MySys() == "win32"
    " 设置consolas字体"
    set guifont=Consolas\ for\ Powerline\ FixedD:h11
    
    "设置状态栏符号显示，下面编码用双引号"
    let g:airline_left_sep = "\u2b80" 
    let g:airline_left_alt_sep = "\u2b81"
    let g:airline_right_sep = "\u2b82"
    let g:airline_right_alt_sep = "\u2b83"
    let g:airline_symbols.branch = "\u2b60"
    let g:airline_symbols.readonly = "\u2b64"
    let g:airline_symbols.linenr = "\u2b61"
else
    " 设置consolas字体"
    set guifont=Consolas\ for\ Powerline\ FixedD:h11
    
    "设置状态栏符号显示，下面编码用双引号"
    let g:airline_left_sep = "\u2b80" 
    let g:airline_left_alt_sep = "\u2b81"
    let g:airline_right_sep = "\u2b82"
    let g:airline_right_alt_sep = "\u2b83"
    let g:airline_symbols.branch = "\u2b60"
    let g:airline_symbols.readonly = "\u2b64"
    let g:airline_symbols.linenr = "\u2b61"
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
Bundle 'majutsushi/tagbar'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" let g:tagbar_ctags_bin = 'D:\Vim\vim80\ctags.exe'
set tags+=./tags,./*/tags  " use currentdir up dir recuit sub dir tag
let g:tagbar_show_linenumbers=2
nmap <C-F4> :TagbarToggle<cr>

" let g:ycm_collect_identifiers_from_tags_files = 1  
" "开启语义补全  
" let g:ycm_seed_identifiers_with_syntax = 1  
" "在接受补全后不分裂出一个窗口显示接受的项  
" set completeopt-=preview  
" "不显示开启vim时检查ycm_extra_conf文件的信息  
" let g:ycm_confirm_extra_conf=0  
" "每次重新生成匹配项，禁止缓存匹配项  
" let g:ycm_cache_omnifunc=0  
" "在注释中也可以补全  
" let g:ycm_complete_in_comments=1  
" "输入第一个字符就开始补全  
" let g:ycm_min_num_of_chars_for_completion=1  
" "不查询ultisnips提供的代码模板补全，如果需要，设置成1即可  
" let g:ycm_use_ultisnips_completer=0  
" let g:ycm_key_list_select_completion = ['<C-N>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-P>', '<Up>']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
Bundle 'tomtom/quickfixsigns_vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
"   :cc         显示详细错误信息 ( :help :cc )
"   :cp         跳到上一个错误 ( :help :cp )
"   :cn         跳到下一个错误 ( :help :cn )
"   :cl         列出所有错误 ( :help :cl )
"   :cw         如果有错误列表，则打开quickfix窗口 ( :help :cw )
"   :col        到前一个旧的错误列表 ( :help :col )
"   :cnew       到后一个较新的错误列表 ( :help :cnew )

function ToggleQuickfix()           " ToggleQuickfix window
    " remember where we are 
    let winnr = winnr() 
    " find qf window, if any 
    let qfw = 0 
    windo if &l:buftype == "quickfix" | 
                \    let qfw = winnr() | endif 
    if qfw 
        " close qf window 
        cclose 
    else 
        " open qf window as last window, fullwidth 
        bot copen 
    endif 
    " go back to where we started from 
    if (winnr >= qfw) && (winnr > 1) 
        let winnr = winnr - 1 
    endif 
    exe winnr "wincmd w" 
endfunction 
command -nargs=0 -bar FF call ToggleQuickfix() 

function ShowError()
    execute ":Errors"
endfunction
command -nargs=0 -bar EE call ShowError() 

function ToggleQF()           " ToggleQuickfix window
    if &l:buftype == "quickfix"
        cclose 
    else 
        below copen 8
    endif 
endfunction 

nnoremap <C-F2> :call ToggleQF()<cr>
nnoremap <F3> :cprev<CR>
nnoremap <F4> :cnext<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'steffanc/cscopemaps.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("cscope")
    set csto=0      " 1表示优先使用ctags数据库,0表示优先使用cscope数据库  
    set cst         " 始终同时查找cscope数据库和tags文件
    set csverb      " 显示表示表示执行成功或失败的信息
    set cscopequickfix=s-,c-,d-,i-,t-,e-    " 设定可以使用quickfix窗口来查看cscope结果
endif

function Do_CsTag()
    if( MySys() != "win32" )
        silent! execute "!rm -f tags"
        silent! execute "!ctags -R --fields=+ialS --extra=+q --c-kinds=+p --c++-kinds=+p"
        if(executable('cscope') && has("cscope") )
            if filereadable("cscope.out")
                silent! execute "cs kill cscope.out"
            endif
            silent! execute "!rm -f cscope.out ncscope.out cscope.files"
            silent! execute "!find . -name '*.h' -o -name '*.c' -o -name '*.cpp'  -o -name '*.s' > cscope.files"
            silent! execute "!cscope -Rbq"
        endif
    else
        silent! execute "!del /f/q tags"
        silent! execute "!ctags -R --fields=+ialS --extra=+q --c-kinds=+p --c++-kinds=+p"
        if(executable('cscope') && has("cscope") )
            if filereadable("cscope.out")
                silent! execute "cs kill cscope.out"
            endif
            silent! execute "!del /f/q cscope.out ncscope.out cscope.files"
            silent! execute "!dir /s/b *.c,*.cpp,*.h,*.s > cscope.files"
            silent! execute "!cscope -Rbq"
        endif
    endif

    if filereadable("cscope.out")
        silent! execute "cs add cscope.out"
    endif

    silent! call Taghl_generate()
endf

nmap <C-F10> :call Do_CsTag()<cr>

" """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
Bundle 'vim-scripts/OmniCppComplete'
" " => omincppcomplete    " C++自动补全插件  
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""  
" "CTage配置需要  
" "--c++-kinds=+p : 为标签添加函数原型(prototype)信息  
" "--fields=+iaS : 为标签添加继承信息(inheritance)，访问控制(access)信息，函数特  
" "征(function Signature,如参数表或原型等)  
" "--extra=+q : 为类成员标签添加类标识  
 
let OmniCpp_MayCompleteDot = 1      " autocomplete with .   
let OmniCpp_MayCompleteArrow = 1    " autocomplete with ->   
let OmniCpp_MayCompleteScope = 1    " autocomplete with ::   
let OmniCpp_SelectFirstItem = 1     " select first popup item (inserting it to the text)
let OmniCpp_NamespaceSearch = 2     " search namespaces in this and included files   
let OmniCpp_ShowPrototypeInAbbr = 1 " show function prototype in popup window   
let OmniCpp_GlobalScopeSearch=1   
let OmniCpp_DisplayMode=1   

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'scrooloose/nerdcommenter'
" => NERD_commenter     " 代码注释
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let NERDSpaceDelims=1        " 让注释符与语句之间留一个空格  
let NERDCompactSexyComs=1    " 多行注释时样子更好看

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/DoxygenToolkit.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:DoxygenToolkit_authorName="QiangPu"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'vim-scripts/SrcExpl'
" => SrcExpl        " 让VIM拥有source insight 一样的预览窗口  
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-F5> :SrcExplToggle<CR>
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
let g:SrcExpl_jumpKey = "<ENTER>"
let g:SrcExpl_gobackKey = "<SPACE>"
let g:SrcExpl_searchLocalDef = 1 
let g:SrcExpl_isUpdateTags = 0 
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ." 
let g:SrcExpl_updateTagsKey = "<C-F11>" 
let g:SrcExpl_prevDefKey = "<C-3>" 
let g:SrcExpl_nextDefKey = "<C-4>"

let g:SrcExpl_pluginList = [ 
        \ "__Tag_List__", 
        \ "_NERD_tree_", 
        \ "Source_Explorer" 
    \ ] 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'tracyone/mark.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <A-m> :mark 
nnoremap <A-,> :marks<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'scrooloose/syntastic'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax on
let g:syntastic_check_on_open = 1 
let g:syntastic_enable_balloons = 1
if MySys() == "win32"
    let g:syntastic_error_symbol = '✗'
    let g:syntastic_warning_symbol = '⚠'
else
    let g:syntastic_error_symbol = '!e'
    let g:syntastic_warning_symbol = '!w'
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'grep.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'exvim/ex-visincr'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'c.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:C_Ctrl_j   = 'off'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Bundle 'cpp.vim'
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bundle 'octol/vim-cpp-enhanced-highlight'
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:cpp_class_scope_highlight = 1
" let g:cpp_experimental_simple_template_highlight = 1
" let g:cpp_experimental_template_highlight = 1
" let g:cpp_concepts_highlight = 1

Bundle 'plasticboy/vim-markdown'

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " => dict               " 语法词典
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd FileType php setlocal dict+=~/.vim/dict/php_funclist.dict
" autocmd FileType css setlocal dict+=~/.vim/dict/css.dict
" autocmd FileType c setlocal dict+=~/.vim/dict/c.dict
" autocmd FileType cpp setlocal dict+=~/.vim/dict/cpp.dict
" autocmd FileType scale setlocal dict+=~/.vim/dict/scale.dict
" autocmd FileType javascript setlocal dict+=~/.vim/dict/javascript.dict

function! Taghl_generate()
    if filereadable("tags")
        if( MySys() != "win32" )
            silent! execute "!rm -f taghl"
        else
            silent! execute "!del /f/q taghl"
        endif
        sp tags
        %s/^\(\w\+::\)\(__anon\d\+::\)\+/\1/g
        w!
        v/\C\m.*[ \t]\+\<[deftv]\>\(\s\|$\).*/d
        %s/\C\m^\(\<[0-9_A-Z]\+\>\).*[ \t]\<d\>\(\s\|$\).*/syn keyword\t zMacro      \1/g
        " %s/\c\m^\(\<\w\+\>\).*[ \t]\<d\>\(\s\|$\).*/syn keyword\t zFuncName   \1 contained nextgroup=cParen/g
        %s/\c\m^\(\<\w\+\>\).*[ \t]\<d\>\(\s\|$\).*/syn region cParen matchgroup=zFunction start="\\C\\m\\<\1\\>\\s*(" end=")" contains=cParen,@zParenGroup/g
        %s/\c\m^\(\<\w\+\>\).*[ \t]\<t\>\(\s\|$\).*/syn keyword\t zTypedef    \1/g
        %s/\c\m^\(\<\w\+\>\).*[ \t]\<e\>\(\s\|$\).*/syn keyword\t zEnumMember \1/g           " enum
        " %s/\c\m^\(\<\w\+\>\).*[ \t]\<f\>\(\s\|$\).*/syn keyword\t zFuncName   \1 contained nextgroup=cParen/g
        %s/\c\m^\(\<\w\+\>\).*[ \t]\<f\>\(\s\|$\).*/syn region cParen matchgroup=zFunction start="\\C\\m\\<\1\\>\\s*(" end=")" contains=cParen,@zParenGroup/g
        %s/\c\m^\(\<\w\+\>\).*[ \t]\<v\>\(\s\|$\).*/syn keyword\t zGlobalVar  \1/g
        sort
        g/^\(.*\)$\n\1$/d
        w! taghl
        BD!
        q!
        call Taghl_source()
    endif
endfunction

function! Taghl_source()
    if filereadable("taghl")
        syn cluster zParenGroup contains=zFuncName,zTypedef,zMacro,zGlobalVar,zEnumMember,cNumbers,cString,cType
        syn region cParen matchgroup=zFuncUndef start="\C\m\<\w*\>\s*(" end=")" contains=cParen,@zParenGroup
        syn region cParen matchgroup=zFuncSys start="\C\m\<\(memcpy\|memset\|sizeof\|printf\)\>\s*(" end=")" contains=cParen,@zParenGroup
        source taghl
    endif
endfunction

if g:colors_name == "seoul256"
    hi def link   zTypedef    Type
    hi def link   zMacro      Constant
    hi def link   zEnumMember zMacro 
    hi def link   zFunction   keyword
    hi def link   zFuncUndef  DiffChange
    hi def link   zFuncSys    ModeMsg
    hi def link   zGlobalVar  Identifier
    hi def link   cPreCondit  Exception
    hi def link   cStructure  Type
    hi def link   cComment	  Ignore
    hi def link   cString     Comment
else
    hi def link   zTypedef    Type
    hi def link   zMacro      Macro      
    hi def link   zEnumMember Structure  
    hi def link   zFunction   Function   
    hi def link   zGlobalVar  Identifier 
endif
autocmd Syntax c,cpp :syn match cPreCondit "\C\m^\s*#\s*\(if\|ifdef\|ifndef\|elif\|endif\)\>"
autocmd Syntax c,cpp :syn match zMacro "\C\m^\s*#\s*\(define\|undef\)\s\+\<\w\+\>"

if filereadable("taghl")
    autocmd Syntax c,cpp :silent! call Taghl_source()
elseif filereadable("tags")
    silent! call Taghl_generate()
endif

map <F12> :silent call Taghl_generate()<CR>


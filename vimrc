source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
	let opt = '-a --binary '
	if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
	if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
	let arg1 = v:fname_in
	if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
	let arg2 = v:fname_new
	if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
	let arg3 = v:fname_out
	if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
	let eq = ''
	if $VIMRUNTIME =~ ' '
		if &sh =~ '\<cmd'
			let cmd = '""' . $VIMRUNTIME . '\diff"'
			let eq = '"'
		else
			let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
		endif
	else
		let cmd = $VIMRUNTIME . '\diff'
	endif
	silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" 基本设置 {{{1
set nocompatible
winpos 50 0
set lines=25 columns=80
" 让alt键不乱弹出菜单
set winaltkeys=no
"正常关闭前 建立备份文件
"正常关闭后 自动删除建立的备份文件
set writebackup
set nobackup
set noundofile
"文件类型检测
filetype plugin indent on
syntax on "高亮
set visualbell t_vb=  "关闭visual bell
au GuiEnter * set t_vb= "关闭beep
set autochdir "需要自动改变vim的当前目录为打开的文件所在目录则设置此项
set autoindent "自动缩进
set smartindent
"设置tab长度为4
set tabstop=4
set shiftwidth=4
"插入结束括号时，来回跳一下匹配括号
set showmatch
"文件在外部被修改时，自动重新读取
set autoread
set display=lastline "显示最多行，不用@@
set spr "Splite the new windows at right
" 在上下移动光标时，光标的上方或下方至少会保留显示的行数
" 不起作用
set scrolloff=3

"这个设置不起作用
"set formatoptions+=Bj

"搜索时全小写相当于不区分大小写，只要有一个大写字母出现，则区分大小写
"simple idea, great achievement!
set ignorecase smartcase
set hlsearch

"标签功能
set switchbuf=useopen,usetab,newtab

" 防止tmux下vim的背景色显示异常
" Refer: http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

" 显示中文帮助
if version >= 603
    set helplang=cn
    set encoding=utf-8
endif

" vimrc 位置{{{2
"说好的自动设置呢
let $MYVIMRC = '$VIM/vimrc'
"
"---
"解决乱码{{{2
"以下为解决中文显示问题,以及相应带来的提示及菜单乱码问题
set encoding=utf-8 " 设置vim内部使用的字符编码
set fileencodings=utf-8,utf-16le,utf-16,gb2312,cp936,gbk,gb18030,cp54936,big5,,euc-jp,latin-1
lang messages zh_CN.UTF-8 " 解决consle输出乱码
"解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"}}}

"字体设置 {{{2
set guifont=Source\ Code\ Pro:h20:cANSI,Monaco:h20:cANSI
set gfw=Microsoft\ Yahei:h20:cGB2312,新宋体:h20:cGB2312
"设置中英文字号
"}}}
"
"界面设置{{{2

set ruler "标尺信息
set number " 显示行号
"光标别闪
set gcr=a:blinkon0
"解决有时只显示一半双字节字符的问题
set ambiwidth=double
set laststatus=2 "状态栏出现在倒数第二行。

if has("gui_running")
	"au GUIEnter * simalt ~x " 窗口启动时自动最大化
	"set guioptions-=m " 隐藏菜单栏
	set guioptions-=T " 隐藏工具栏
	"set guioptions-=L " 隐藏左侧滚动条
	"set guioptions-=r " 隐藏右侧滚动条
	"set guioptions-=b " 隐藏底部滚动条
	"set showtabline=0 " 隐藏Tab栏
endif
"}}}

"键位设置{{{2
let mapleader = ","
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
noremap <f12> :vsplit<cr>

set backspace=indent,eol,start
" 移动可以换行（不知道为什么不起作用）
set whichwrap=b,s,<,>,h,l,[,]

"nnoremap <esc> :noh<return><esc>

"上下左右
"长行之中 j,k 可以上下移动
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k
noremap <C-A> ^
noremap <C-E> $
inoremap <C-H> <left>
inoremap <C-L> <right>
inoremap <C-J> <esc>gja
inoremap <C-K> <esc>gka
inoremap <C-X> <BS>

"Tab标签
"noremap <C-TAB> gt
"noremap <C-t> :tabnew<CR>
"inoremap <C-t> <ESC>:tabnew<CR>i
"inoremap <M-w> <ESC>:tabclose<CR>
"noremap <M-w> :tabclose<CR>

"设置切换Buffer快捷键"
nnoremap <C-tab> :bn<CR>
nnoremap <C-s-tab> :bp<CR>
inoremap <C-tab> <ESC>:bn<CR>i
inoremap <C-s-tab> <ESC>:bp<CR>i
"命令行
cnoremap <C-H> <left>
cnoremap <C-L> <right>
cnoremap <C-K> <up>
cnoremap <C-J> <down>
cnoremap <C-X> <BS>

"MS Like Notepad
vnoremap <C-C> "+y
inoremap <C-V> <esc>"+gpa
"inoremap <C-A> <esc>ggVG

" Use CTRL-S for saving, also in Insert mode
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>


" Emacs
"inoremap <C-b> <left>
"inoremap <C-f> <right>
"inoremap <C-n> <esc>gja
"inoremap <C-p> <esc>gka
inoremap <C-e> <ESC>A
inoremap <C-a> <ESC>I

"Convinent >
"nnoremap < <<
"nnoremap > >>
"nnoremap V 0v$h

"Shift > enhance
"vnoremap < <gv
"vnoremap > >gv

"CMD Line
"cnoremap <C-A> <Home>
"cnoremap <C-F> <Right>
"cnoremap <C-B> <Left>

"Symblo Auto Complete

"inoremap ( ()<left>
"inoremap < <><left>
"inoremap " ""<left>
"inoremap [ []<left>
"inoremap { {}<left>

"paragraph jump enhance

"vmap { {j
"vmap } }k

"CSS File Auto Jump
autocmd! FileType css inoremap <buffer> { {}<left><CR><esc>O

"Keep search pattern at the center of the screen.
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" }}}
"}}}
"
"_____
"插件设置{{{1
"用vim-plug加载插件{{{2
call plug#begin('$VIM/vimfiles/plugged')

Plug 'icymind/NeoSolarized'
Plug 'morhetz/gruvbox'
Plug 'sickill/vim-monokai'

" VOom 插件
Plug 'vim-voom/VOoM'
Plug 'scrooloose/nerdtree'

Plug 'vimwiki/vimwiki'

"pandoc
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

Plug 'jlanzarotta/bufexplorer'

Plug 'vim-airline/vim-airline'

"自定义插件
"let MY_PLUGIN_PATH = '$VIM/vimfiles/my-extension/'
"Plug MY_PLUGIN_PATH . ''

call plug#end()

"}}}
"

"主题{{{2
set background=dark
"colorscheme monokai
"colorscheme solarized
colorscheme gruvbox
"}}}
1
"NERDTree {{{2
noremap <F10> :NERDTreeToggle<CR>
inoremap <F10> <ESC>:NERDTreeToggle<CR>
"}}}

"Voom {{{2
let g:voom_ft_modes = {
			\'markdown' : 'markdown',
			\'tex' : 'latex',
			\'pandoc': 'pandoc',
			\'org' : 'org',
			\'text' : 'chapter',
			\'' : 'chapter',
			\}

noremap <F11> :VoomToggle<CR>
inoremap <F11> <esc>:VoomToggle<CR>
"}}}
"
"airline{{{1
"这个是安装字体后 必须设置此项" 
"let g:airline_powerline_fonts = 1   

 "打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'
" 设置consolas字体"前面已经设置过
"set guifont=Consolas\ for\ Powerline\ FixedD:h11
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_left_sep = ' >>'
let g:airline_right_sep = '<< '
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'


"}}}
"}}}

"-----
"自定义函数{{{1

"使用小小输入法，自动切换中英文{{{2
let g:input_toggle = 0

function! Yong2en()
	let g:input_toggle = system("yong-vim.exe 1 -w")
endfunction

function! Yong2zh()
	if g:input_toggle != 0
		let g:input_toggle = system("yong-vim.exe 0")
		let g:input_toggle = 0
	endif
endfunction

autocmd InsertLeave * call Yong2en()
autocmd InsertEnter * call Yong2zh()
"---

"快捷键添加标题{{{2
function! s:Add_MD_Tittle(char)
	"本行行号
	let l:ln = line('.')
	let l:thisLine = getline(l:ln)
	"作为命令输入的一个字符串的开头
	"若本行为空，默认在本行编辑；否则，另起一行且空一行
	let l:cmdStr = (l:thisLine !~ '\S' ? "S" : "o\n")
	"若不是第一行
	if l:ln > 1
		let l:upperLine = getline(l:ln - 1)
		"若上一行非空，且本行为空	
		if (l:upperLine =~ '\S')  && (l:cmdStr == 'S')
			"另起一行
			let l:cmdStr = 'o'
		endif
	endif

	"查找上一次标题出现位置
	let l:lnUpperHearder = search('^#',"nbW")
	"如果找不到上一次出现的标题
	if l:lnUpperHearder == 0
		"直接生成第一级标题
		let l:level = '#'
	else "如果能找到上一次出现的标题
		"同一级 a:char ==? 'same_level'
		let l:level =  matchstr(
					\getline(l:lnUpperHearder),
					\'^#\+') 
		if a:char ==? 'next_level'
			let l:level = '#' . l:level
		elseif a:char ==? 'upper_level'
			if l:level != '#'
				let l:level = matchstr(l:level, '.*', 1)
			endif
		endif
	endif
	return l:cmdStr . l:level . ' '
endfunction

function! s:Manually_Add_Tittle(num)
	let l:leaderStr = a:num > 0 ? repeat('#',a:num).' ' : ''
	let l:oldLine = getline('.')
	let l:newLine = l:leaderStr . matchstr(l:oldLine,
				\'^\%(#*\)\@>\%(\s*\)\@>\zs.*\ze$')
	"	删除后缀
	"	let l:newLine = substitute(l:newLine,
	"				\ '\s*#*$', '', 
	"				\ '')
	let l:whereCursor = getpos('.')

	"调整横坐标，否则光标会插在 Unicode 字符（三个字节）中间，造成乱码
	let l:whereCursor[2] = len(l:newLine) + l:whereCursor[2] - len(l:oldLine)

	call setline('.', l:newLine)	
	call setpos('.', l:whereCursor)
	return ''
endfunction

function! s:Keybindings_of_Add_Tittle()
	inoremap <silent> <expr> 
				\<S-CR> "\<ESC>" . <SID>Add_MD_Tittle('same_level')
	inoremap <silent> <expr> 
				\<C-CR> "\<ESC>" . <SID>Add_MD_Tittle('next_level')
	"Alt + Enter 键不起作用
	"inoremap <silent> <expr> <M-CR> <SID>Add_MD_Tittle('upper_level') 
	"noremap <silent> <C-1> 
	"
	" 六级标题，Alt + ( 1 - 6 ), Alt + 0 还原
	for i in range(0,6)
		execute printf(
					\'noremap <silent> <M-%s> ' 
					\. ':call <SID>Manually_Add_Tittle(%s)<cr>'
					\, i , i)
		execute printf(
					\'inoremap <silent> <M-%s> ' 
					\. '<c-r>=<SID>Manually_Add_Tittle(%s)<cr>'
					\, i , i)
	endfor
endfunction

augroup Add_Markdown_Tittle
	"注意连续行中第一行的尾部有一个空格，否则会报错
	"autocmd BufNewFile,BufRead *.txt,*.md,*.markdown,*.pandoc 
	"			\call <SID>Keybindings_of_Add_Tittle()
	autocmd FileType text,markdown,md,pandoc, 
				\call <SID>Keybindings_of_Add_Tittle()
	if &filetype==''
		call <SID>Keybindings_of_Add_Tittle()
	endif
augroup END
"}}}
"

"字数统计{{{2
function! s:words_counter(inVisual) range
	if !has('python')
		echo "Error: Required vim compiled with +python"
		return
	endif

	if a:inVisual
		let save = @z
		silent exe 'normal! gv"zy'
		let lines = @z
		let @z = save
		"silent exec 'normal! gv'
	else
		let lines = getline(1,'$')
	endif
python << EOF
##! /usr/bin/env python
# -*- coding: utf-8 -*-! 
from __future__ import unicode_literals
from __future__ import print_function
import re
import sys
import vim

if sys.version > '3':
	isPy2 = False
else:
	isPy2 = True

regex_dic = {
		'Chinese' : '['
				#扩展B以下无法识别
				'\u4E00-\u9FA5'	#基本汉字
				'\u9FA6-\u9FCB'	#基本汉字补充
				'\u3400-\u4DB5'	#扩展A
				#'\u20000-\u2A6D6'	#扩展B
				#'\u2A700-\u2B734'	#扩展C
				#'\u2B740-\u2B81D'	#扩展D
				#'\u2F00-\u2FD5'	#康熙部首
				#'\u2E80-\u2EF3'	#部首扩展
				'\uF900-\uFAD9'	#兼容汉字
				#'\u2F800-\u2FA1D'	#兼容扩展
				'\uE815-\uE86F'	#PUA(GBK)部件
				#'\uE400-\uE5E8'	#部件扩展
				#'\uE600-\uE6CF'	#PUA增补
				#'\u31C0-\u31E3'	#汉字笔画
				#'\u2FF0-\u2FFB'	#汉字结构
				#'\u3105-\u3120'	#汉语注音
				#'\u31A0-\u31BA'	#注音扩展
				'\u3007'	#〇
					']',
		'English' : '[a-zA-Z]+(\'[a-zA-Z]+)?',
		#'number' : '[0-9]+|[〇一二三四五六七八九十零百千万亿]+',
		'punc' : '[\u3000-\u303f\ufb00-\ufffd]',
		#'ascii-punc':'[\x21-\x2f\x3a-\x40\x5b-\x60\x7b-\x7e]',
		}

for name, expr in regex_dic.items():
	regex_dic[name] = re.compile(expr).findall

def line_counter( string ): 
		dic = {}
		if isPy2:
			string = string.decode('utf-8')
		for name, expr in regex_dic.items():
			num = len(regex_dic[name](string))
			dic[name] = dic.get(name,0) + num
		return dic

def multiline_counter():
	lines = vim.eval("l:lines")
	lines = ''.encode('ascii').join(lines)
	return line_counter(lines)
	#	for eachLine in lines:
	#		line_counter(eachLine)

dic = multiline_counter()

output = ('汉字: %s, '
		'英文单词: %s, '
		'全角标点: %s'
		#'半角标点: %s,' 
		#'数字: %s' 
		% (
		dic.get('Chinese', '未知'), 
		dic.get('English', '未知'),
		dic.get('punc', '未知'),
		#dic.get('ascii-punc', '未知'),
		#dic.get('number', '未知')
		))
vim.command( ':echom "%s"' % (output))
EOF

endfunction

augroup words_counter
	autocmd!
	nnoremap <silent> <f9> :call <SID>words_counter(0)<cr>
	vnoremap <silent> <f9> :call <SID>words_counter(1)<cr>
	inoremap <silent> <f9> <esc>:call <SID>words_counter(0)<CR>
augroup END

"}}}

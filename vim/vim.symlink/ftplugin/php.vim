set keywordprg=~/bin/phphelp

let PHP_autoformatcomment = 0

iab <? <?php ?><esc>hhi
imap <img <img src="" alt="" /><esc>?src<cr>lllla
imap <leader>a <a href=""><esc>?"<cr>i
imap $_R $_REQUEST['']<esc>hi
imap $_P $_POST['']<esc>hi
imap $_SER $_SERVER['']<esc>hi
imap $_SES $_SESSION['']<esc>hi

setl errorformat=%m\ in\ %f\ on\ line\ %l
setl makeprg=php\ -l\ %
nnoremap <F5> :w<CR>:make<CR>

ru indent/html.vim
unlet b:did_indent

autocmd BufEnter *php setlocal indentexpr=MyPhpIndent()

fun! MyPhpIndent()
	let ind = GetPhpIndent()
	if b:InPHPcode == 1
		return ind
	else
		let b:indent = {"lnum": -1}
		return HtmlIndent()
	endif
endfunc

setl foldlevel=0
setl fcl=all
setl fdm=manual
setl fmr=/*,*/


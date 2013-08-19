set keywordprg=~/bin/phphelp

let PHP_autoformatcomment = 0

iab <? <?php ?><esc>hhi
imap <img <img src="" alt="" /><esc>?src<cr>lllla
imap <leader>a <a href=""><esc>?"<cr>i
imap $_R $_REQUEST['']<esc>hi
imap $_P $_POST['']<esc>hi
imap $_SER $_SERVER['']<esc>hi
imap $_SES $_SESSION['']<esc>hi
imap <leader>c class=""<esc>i

" setl cpt=.,w,b,u,t,i,k/home/lftl/.vim/phpdict

"	    source ~/.vim/scripts/closetag.vim

source ~/.vim/scripts/php-doc.vim
nnoremap <C-P> :call PhpDocSingle()<CR>
nnoremap <F6> 1GVG:call PhpDocRange()<CR>

setl errorformat=%m\ in\ %f\ on\ line\ %l
setl makeprg=php\ -l\ %
nnoremap <F5> :w<CR>:make<CR>

"	Mojavi automatic view creation macro
nmap ,v /VIEW_/_v/;hy1GOp0v$uO%0/actiond$aviews//^class .*Action extendswvwy1G$p?Actc$ViewJx$a.class.php0v$h"axdd:sp a
"	i<?phpclass %0wv/viewwx/_d$a extends View{}?>kkO

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


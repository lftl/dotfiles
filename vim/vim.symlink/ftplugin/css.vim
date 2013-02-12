" au BufEnter *css setlocal omnifunc=csscomplete#CompleteCSS

" function! MyCSSComplete(findstart, base)
"	let values = csscomplete#CompleteCSS(findstart, base)
" 	return values
"endfunction

setl fdm=marker
setl fmr=BEGIN,END
setl foldlevel=0

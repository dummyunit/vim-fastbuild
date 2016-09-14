" Vim indent file
" Language: FASTBuild configuration

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

if !exists('g:fastbuild_debug')
	let g:fastbuild_debug = 0
endif

setlocal indentexpr=GetFBuildIndent()
setlocal indentkeys+=0[,0]
setlocal autoindent

" Only define the function once.
if exists("*GetFBuildIndent")
	finish
endif

function! GetFBuildIndent()
	" Find a non-blank line above the current line.
	let prevlnum = prevnonblank(v:lnum - 1)
	if g:fastbuild_debug
		echom "line" v:lnum.":" getline(v:lnum)
	endif

	" At the start of the file use zero indent.
	if prevlnum == 0
		return 0
	endif

	let ind = indent(prevlnum)
	let prevind = ind

	" Add a 'shiftwidth' after lines that end with { or [
	if getline(prevlnum) =~ '[{\[]\s*$'
		let ind = ind + &shiftwidth
		if g:fastbuild_debug
			echom prevind "->" ind
		endif
	endif

	" Subtract a 'shiftwidth' on lines containing only } or ]
	if getline(v:lnum) =~ '^\s*[}\]]\s*$'
		let ind = ind - &shiftwidth
		if g:fastbuild_debug
			echom prevind "->" ind
		endif
	endif

	return ind
endfunction

" Vim indent file
" Language: FASTBuild configuration

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
	finish
endif
let b:did_indent = 1

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
	echom "cur  line" v:lnum
	echom "cur  text" getline(v:lnum)
	echom "prev line" prevlnum
	echom "prev text" getline(prevlnum)

	" At the start of the file use zero indent.
	if prevlnum == 0
		return 0
	endif

	let ind = indent(prevlnum)
	echom "ind" ind

	" Add a 'shiftwidth' after lines that end with { or [
	if getline(prevlnum) =~ '[{\[]\s*$'
		let ind = ind + &shiftwidth
		echom "+"
	endif

	" Subtract a 'shiftwidth' on lines containing only } or ]
	if getline(v:lnum) =~ '^\s*[}\]]\s*$'
		let ind = ind - &shiftwidth
		echom "-"
	endif

	echom "ind" ind
	return ind
endfunction

" Vim indent file
" Language: FASTBuild configuration

" Only load this indent file when no other was loaded.
if exists('b:did_indent')
	finish
endif
let b:did_indent = 1

if !exists('g:fastbuild_debug')
	let g:fastbuild_debug = 0
endif

setlocal indentexpr=GetFBuildIndent()
setlocal indentkeys+=0[,0],0+
setlocal autoindent

" Only define the function once.
if exists('*GetFBuildIndent')
	finish
endif

" Returns first previous line that starts with opional whitespace and a pattern.
function s:prevline(lnum, pattern)
	let lnum = a:lnum
	while lnum > 1
		let lnum = prevnonblank(lnum)
		let line = getline(lnum)
		if line =~ '^\%(\s*\)\@>\%('.a:pattern.'\)'
			break
		endif
		let lnum -= 1
	endwhile
	return lnum
endfunction

function s:count_braces(lnum, count_open)
	let n_open = 0
	let n_close = 0
	let line = getline(a:lnum)
	let pattern = '[{}[\]]'
	let i = match(line, pattern)
	while i != -1
		if synIDattr(synID(a:lnum, i + 1, 0), 'name') !~# 'fb\%(Comment\|String\)'
			if line[i] ==# '{' || line[i] ==# '['
				let n_open += 1
			elseif line[i] ==# '}' || line[i] ==# ']'
				if n_open > 0
					let n_open -= 1
				else
					let n_close += 1
				endif
			endif
		endif
		let i = match(line, pattern, i + 1)
	endwhile
	return a:count_open ? n_open : n_close
endfunction

function! GetFBuildIndent()
	let line = getline(v:lnum)
	if g:fastbuild_debug
		echom 'line' v:lnum.':' line
	endif

	if line =~# '^\s*#'
		" Special case: line contains directive, push it to the left.
		if g:fastbuild_debug
			echom 'directive: 0'
		endif
		return 0
	elseif line =~# '^\s*[+-]'
		" Special case: line starts with an operator.
		" Find previous non-blank, non-directive, non-comment line.
		let prevlnum = s:prevline(v:lnum - 1, '[^#;/]\|/[^/]')
		if prevlnum == 0
			return 0
		endif
		if g:fastbuild_debug
			echom 'prev line' prevlnum.':' getline(prevlnum)
		endif

		let prevind = indent(prevlnum)
		let ind = prevind
		if getline(prevlnum) !~# '^\s*[+-]'
			" Previous line doesn't start with operator, increase indent.
			let ind += &shiftwidth
		endif

		if g:fastbuild_debug
			echom 'operator:' prevind.'->'.ind
		endif
		return ind
	else
		" Regular case
		" Find previous regular line (non-blank, non-directive, non-comment, non-operator).
		let prevlnum = s:prevline(v:lnum - 1, '[^#;/+-]\|/[^/]')
		if prevlnum == 0
			return 0
		endif
		if g:fastbuild_debug
			echom 'prev line' prevlnum.':' getline(prevlnum)
		endif

		let prevind = indent(prevlnum)
		" Increase indent by amount of open { and [ on previous line
		" Decrease indent by amount of closed } and ] on current line
		let ind = prevind
			\ + s:count_braces(prevlnum, 1) * &shiftwidth
			\ - s:count_braces(v:lnum, 0) * &shiftwidth

		if g:fastbuild_debug
			echom 'regular:' prevind.'->'.ind
		endif
		return ind
	endif
endfunction

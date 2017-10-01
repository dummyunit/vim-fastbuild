if exists('b:did_ftplugin')
	finish
endif
let b:did_ftplugin = 1

setlocal comments=://,:;
setlocal commentstring=//\ %s
if exists('+omnifunc')
	let g:omni_syntax_group_include_fastbuild = 'fb\w\+'
	setlocal omnifunc=syntaxcomplete#Complete
endif

let b:undo_ftplugin = 'setlocal comments< commentstring< omnifunc<'

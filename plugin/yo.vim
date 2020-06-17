" Abort if running in vi-compatible mode or the user doesn't want us.
if &cp || exists('g:yo_loaded')
  if &cp && &verbose
    echo "Not loading yo in compatible mode."
  endif
  finish
endif

let g:yo_loaded = 1

" mvn compile exec:java -Dexec.mainClass=com.sankuai.meituan.banma.expr.common.ExprDivision

function! RunJava()
	let fullpath = expand('%:p')
	" echo fullpath
	" split strings
	" https://learnvimscriptthehardway.stevelosh.com/chapters/27.html
	let pathandfile = split(fullpath, "src")
	let path = pathandfile[0]
	let file = pathandfile[1]
	" echo "path" path
	" echo "file" file
	" list access
	" https://learnvimscriptthehardway.stevelosh.com/chapters/35.html
	let packageandfile = split(file, "/java/")[1]
	" echo "file" packageandfile
	let packageandclass = substitute(packageandfile, "/", ".", "g")
	let mainClass = substitute(packageandclass, ".java$", "", "g")
	" echo "packageandclass" mainClass
	let command = "cd " . path . "; mvn compile exec:java -Dexec.mainClass=" . mainClass
	" echo "command: "  command
	let &makeprg=command
	exec "make"
	exec silent! "AsyncCommand " . command
	" exec "!" . command
	copen
endfunction
nnoremap <D-r> :call RunJava()<CR>

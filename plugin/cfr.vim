" File: plugin/cfr.vim
" Description: Need a java .class file YOU need decompiling? CFR it!
" Maintainer: Brian Mejorado <bam9523@rit.edu>
" Original: http://vim.wikia.com/wiki/Decompile_Java_.class_files_automatically

" cfr is Copyright (c) 2011-2014 Lee Benfield - http://www.benf.org/other/cfr
" http://www.benf.org/other/cfr/license.html


" Variables {{{1

" g:loaded_cfr (default 1) {{{2
if( exists("g:loaded_cfr") || &cp || v:version < 700 )
    finish
endif
let g:loaded_cfr = 1
"}}}2

" g:cfr_jar_location (default '') {{{2
" Use complete path from root, with trailing slash
if( !exists("g:cfr_jar_location") )
    let g:cfr_jar_location = ''
endif
"}}}2

" g:cfr_filename (default 'cfr_0_115.jar') {{{2
" Uses latest version by default
" http://www.benf.org/other/cfr/
if( !exists("g:cfr_jar_filename") )
    let g:cfr_jar_filename = 'cfr_0_115.jar'
endif
"}}}2

"}}}1

" Functions {{{1

" s:GetCommand: Acquire the command to execute for cfr. {{{2
function! s:GetCommand(classname) abort
    if( has('win32unix') && executable('cygpath') )
        " Cygwin users can end up mixing Windows and Unix paths here
        return "\%!java -jar `cygpath -w " . g:cfr_jar_location . g:cfr_jar_filename . " " . a:classname . "`"
    else
        return "\%!java -jar " . g:cfr_jar_location . " " . g:cfr_jar_filename . " " . a:classname
    endif
endfunction
"}}}2

" s:ReadClass: Read a class into memory and decompile it {{{2
function s:ReadClass(dir, classname)
  execute "lcd " . a:dir
  let l:decompile_command = s:GetCommand(a:classname)
  execute l:decompile_command
  0
  setlocal ft=java
  execute "normal! gg=G"
  setlocal readonly
  setlocal nomodified
endfunction
"}}}2

"}}}1

" Augroup: java_decompile -- Automatically decompile when opening *.class {{{1
augroup java_decompile
    au!
    autocmd BufReadCmd *.class
      \ call <SID>ReadClass(expand("<afile>:p:h"), expand("<afile>:t:r"))
augroup END
"}}}1

" vim: set fen fdm=marker

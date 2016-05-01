" File: plugin/decompile.vim
" Description: Decompiles Java class files.
" Maintainer: Brian Mejorado <bam9523@rit.edu>
" Original: http://vim.wikia.com/wiki/Decompile_Java_.class_files_automatically


" Variables {{{1

" g:loaded_decomp (default 1) {{{2
if( exists("g:loaded_decomp") || &cp || v:version < 700 )
    finish
endif
let g:loaded_decomp = 1
"}}}2

" g:decomp_jar (default '') {{{2
" Specifies a jarfile to use for decompilation
if( !exists("g:decomp_jar") )
    let g:decomp_jar = ''
endif
"}}}2

"}}}1

" Functions {{{1

" s:LocalPath: Acquire the local path. Used for portability. {{{2
function! s:LocalPath(path) abort
    if( has('win32unix') && executable('cygpath') )
        " Cygwin users can end up mixing Windows and Unix paths here
        return "$(cygpath -w " . a:path . ")"
    else
        return a:path
    endif
endfunction
"}}}2

" s:GetDefaultCommand: Acquire the default decompilation command. {{{2
function! s:GetDefaultCommand(classname) abort
    return "\%!javap -v -private " . s:LocalPath( a:classname )
endfunction
"}}}2

" s:GetCustomJarCommand: Acquire a command defined by the user. {{{2
function! s:GetCustomJarCommand(classname)
    let l:jarpath = g:decomp_jar . " " . a:classname
    return "\%!java -jar " . s:LocalPath( l:jarpath )
endfunction
"}}}2

" s:GetCommand: Acquire the command to execute. {{{2
function! s:GetCommand(classname) abort
    if( exists("g:decomp_jar") && g:decomp_jar !=# '' )
        return s:GetCustomJarCommand(a:classname)
    else
        return s:GetDefaultCommand(a:classname)
endfunction
"}}}2

" s:SetOptions: Set the options based on the decompilation command. {{{2
function! s:SetOptions(command) abort
    if( a:command =~# "^java -jar .*" )
        setlocal ft=java
        execute "normal! gg=G"
    endif

    setlocal readonly
    setlocal nomodified
endfunction
"}}}2

" s:ReadClass: Read a class into memory and decompile it {{{2
function s:ReadClass(dir, classname) abort
  execute "lcd " . a:dir
  " execute \"saveas " . fnameescape(tempname())
  let l:decompile_command = s:GetCommand(a:classname)
  execute l:decompile_command
  0
  call <SID>SetOptions( l:decompile_command )
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

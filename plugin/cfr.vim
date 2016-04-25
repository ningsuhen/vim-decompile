" File: plugin/cfr.vim
" Description: Need a java .class file YOU need decompiling? CFR it!
" Maintainer: Brian Mejorado <bam9523@rit.edu>
" Original: http://vim.wikia.com/wiki/Decompile_Java_.class_files_automatically

if( exists("g:loaded_cfr") || &cp || v:version < 700 )
    finish
endif
let g:loaded_cfr = 1

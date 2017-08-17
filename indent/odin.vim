" Vim Indentation File
" Language: Odin
" Maintainer: Tyler Erickson
" Latest Revision: 16 Aug 2017

" I haven't used the language yet, but at first glance it seems the indentation should be
" similar to that of C. Let's see how this works.

if exists("b:did_indent")
   finish
endif
let b:did_indent = 1

setlocal cindent

let b:undo_indent = "setl cin<"

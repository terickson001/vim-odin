" Vim syntax file
" Language: Odin
" Maintainer: Tyler Erickson
" Latest Revision: 16 Aug 2017

if exists("b:current_syntax")
    finish
endif

" Keywords
syn keyword odinKeyword import do for in defer match return using import_load foreign foreign_library foreign_system_library const fallthrough break continue asm yield await push_allocator push_context vector static dynamic atomic inline
syn keyword odinConditional if else when switch
syn keyword odinLabel case

" Types

" Keywords take precedence over other matches. For now, this works to get around it.
" syn keyword odinBuiltinType int i8 i16 i32 i64 i128 uint u8 u16 u32 u64 u128 f32 f64 rawptr string byte rune proc struct union any type
syn match odinBuiltinType "\(^\|\W\)\@<=\(int\|i\(8\|16\|32\|64\|128\)\|uint\|u\(8\|16\|32\|64\|128\)\|f\(32\|64\)\|rawptr\|string\|byte\|rune\|struct\|union\|any\|type\|enum\|bool\)\(\W\|$\)\@="

syn match odinTypeAssignment contained "\^\=\(\[\]\)\=\(\.\{2,3}\)\=\^\=\$\=\([a-zA-Z_]\+\.\)\=[a-zA-Z_]\w*\(\/\^\=\(\[\]\)\=\(\.\{2,3}\)\=\^\=\$\=\([a-zA-Z_]\+\.\)\=[a-zA-Z_]\w*\)\=" contains=odinProcType,odinContainerType,odinBuiltinType,odinType,odinPointerOperator,odinPolymorphicTypeOperator nextgroup=odinTypeArrow,odinConstantDef,odinVariableDef skipwhite
" syn match odinType contained "[a-zA-Z_]\w*"
" syn match odinContainerTypeName contained "\^\=\(\[\]\)\=\(\.\{2,3}\)\=\^\=\$\=\([a-zA-Z_]\+\.\)\=[a-zA-Z_]\w*\((\|{\)\@=" nextgroup=odinContainerTypeParens
" syn match odinContainerType contained "[a-zA-Z_]\w*\((.\{-})\|{.\{-}}\)" contains=odinTypeParameters,odinContainerTypeName
" syn region odinContainerTypeParens contained start="\((\|{\)" skip="\((.\{-})\|{.\{-}}\)" end="\()\|}\)" contains=odinParameterDec,odinTypeAssignment skipwhite
syn region odinTypeTuple contained start="(" skip="(.\{-})" end=")" contains=odinTypeAssignment

syn region odinTypeParameters contained start="(" skip="(.\{-})" end=")" contains=odinParameterDec,odinHashStatement,odinTypeAssignment nextgroup=odinTypeArrow,odinConstantDef,odinVariableDef skipwhite
syn match odinConstant "[A-Z_][A-Z0-9_]\+"

" Functions
syn match odinFunction "[a-zA-Z_]\w*(\@=" contains=odinBuiltinType
syn match odinFunctionDeclaration "[a-zA-Z_]\w*\(\s*\(:\(\s*:\|\s*=\)\=\)\(\s*inline\)\=\s*proc\)\@=" nextgroup=odinTypeDec skipwhite
syn match odinTypeDec ":" nextgroup=odinProcType,odinTypeAssignment,odinConstantDef,odinVariableDef skipwhite
syn match odinConstantDef contained ":" nextgroup=odinConstant,odinProcType,odinTypeAssignment,odinFunction skipwhite
syn match odinVariableDef contained "=" nextgroup=odinConstant,odinProcType,odinTypeAssignment,odinFunction skipwhite
syn keyword odinProcType proc nextgroup=odinTypeParameters,odinProcTypeString skipwhite
syn region odinProcTypeString  start='"' skip='\\"' end='"' skipwhite nextgroup=odinTypeParameters
" syn region odinProcTypeParameters contained start="(" skip="(.\{-})" end=")" contains=odinParameterDec,odinHashStatement,odinTypeAssignment nextgroup=odinTypeArrow,odinConstantDef,odinVariableDef skipwhite
syn match odinParameterDec contained "\((\|,\)\s*\([a-zA-Z_]\+,\s*\)*[a-zA-Z_]\+\s*:" nextgroup=odinTypeAssignment skipwhite
syn match odinTypeArrow contained "->" nextgroup=odinTypeAssignment,odinTypeTuple skipwhite

" syn match odinTypeCast "[.\w]\@<!\u\w*(\@=" nextgroup=odinTypeCaseParens
syn match odinCastFunction "cast(\@=" nextgroup=odinCastFunctionParens
syn region odinCastFunctionParens contained start="(" skip="(.\{-})" end=")" contains=odinTypeAssignment

" syn match odinVariableDec "\([a-z]\w*,\s*\)*[a-z]\w*\s*::\@!" nextgroup=odinTypeAssignment skipwhite

" Operators
syn match odinOperator "\(+=\|-=\|\/\|\*\|%\|\~\|+\|-\|&\|>>\|<<\|>=\|<=\|==\|!=\|!\|>\|<\)"
syn match odinPointerOperator "\^"
syn match odinPolymorphicTypeOperator contained "\$"
syn match odinEmptyDefinition "---"

" Numbers
syn match odinInteger "\W\@<=[0-9]\+"
syn match odinDecimal "\W\@<=[0-9]\+\.[0-9]\+"
syn match odinHexadecimal "\W\@<=0x[0-9A-Fa-f]\+"

" Bools
syn keyword odinBoolean true false
syn keyword odinNil nil

" Strings
syn region odinString  start='"' skip='\\\\\|\\"' end='"' contains=odinPrintfSpecifier,odinEscapedCharacter
syn region odinMultilineString  start='`' skip='\\\\\|\\`' end='`' contains=odinPrintfSpecifier,odinEscapedCharacter
syn region odinCharacter  start="'" skip="\\\\\|\\'" end="'"
syn match odinPrintfSpecifier contained "%\( \|-\|+\|0\|#\)\=\([0-9]\|\*\)\=\(\.[0-9]\|\.\*\)\=\(hh\|h\|l\|ll\|j\|z\|t\|L\)\=\(t\|v\|c\|r\|b\|o\|d\|z\|x\|X\|U\|f\|F\|s\|p\|T\)"
syn match odinEscapedCharacter contained "\\."

" Comments
syn region odinCommentBlock start="/\*" end="\*/" contains=odinTODO
syn match odinComment "//.*$" contains=odinTODO
syn match odinTODO contained "\(\(^\|\/\/\)[[:blank:]\*\/]*\)\@<=\u\S*:"

syn match odinHashStatement "#[a-zA-z_][a-zA-z_0-9]*"
syn match odinAttributeDec "@(\@="

" Highlighting
let b:current_syntax = "odin"
hi def link odinKeyword                 Statement
hi def link odinConditional             Conditional
hi def link odinLabel                   Label

hi def link odinProcTypeString          odinString
hi def link odinMultilineString         odinString
hi def link odinString                  String
hi def link odinPrintfSpecifier         Constant
hi def link odinEscapedCharacter        Constant
hi def link odinCharacter               Character

hi def link odinProcType                odinType
hi def link odinBuiltinType             odinType
hi def link odinContainerTypeName       odinType
hi def link odinType                    Type

hi def link odinCommentBlock            odinComment
hi def link odinComment                 Comment

hi def link odinInteger                 Number
hi def link odinDecimal                 Number
hi def link odinHexadecimal             Number

hi def link odinCastFunction            odinFunction
hi def link odinFunctionDeclaration     odinFunction
hi def link odinFunction                Function

hi def link odinBoolean                 Constant
hi def link odinNil                     Constant

hi def link odinPointerOperator         odinOperator
hi def link odinPolymorphicTypeOperator odinOperator
hi def link odinOperator                Structure

hi def link odinEmptyDefinition         Statement

hi def link odinAttributeDec            Structure

hi def link odinTypeCast                Type

hi def link odinTODO                    Todo

hi def link odinHashStatement           Statement

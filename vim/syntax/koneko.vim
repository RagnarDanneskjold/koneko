" Vim syntax file
" Language:   koneko
" Maintainer: Felix C. Stegerman <flx@obfusk.net>
" URL:        https://github.com/obfusk/koneko

if exists("b:current_syntax")
  finish
endif

syn match   knkIdent      '[^':.! \t][^, \t]*'

syn match   knkLit        'nil\([, \t]\|$\)\@='
syn match   knkBool       '#[tf]\([, \t]\|$\)\@='
syn match   knkInt        '-\?\d\+\([, \t]\|$\)\@='
syn match   knkKwd        ':[^, \t]\+'
syn match   knkKey        '[^, \t]\+:\([, \t]\|$\)\@='
syn match   knkStr        '"\(\\.\|[^\\"]\)*"\([, \t]\|$\)\@='

syn match   knkPrim       '\(call\|apply\(-dict\)\?\|if\|def\|defmulti\|defrecord\|=>\|dict\|show\|say!\|ask!\|type\|callable?\|function?\|not\|and\|or\|=\|not=\|[<>]=\?\|int->float\|record->dict\|record-type\(-\(name\|fields\)\)\?\|__[^, \t]\+__\)\([, \t]\|$\)\@='

syn match   knkParen      '[(){}\[\]]\([, \t]\|$\)\@='
syn match   knkSpecial    '[\'.!,]'

syn match   knkQuot       '\(\'[.!]\?\)\@<=[^.!, \t][^, \t]*'

syn match   knkFloat      '-\?\d\+\(\.\d\+e\d\+\|\.\d\+\|e\d\+\)\([, \t]\|$\)\@='

syn match   knkComment    ';.*'

hi def link knkIdent      Identifier

hi def link knkLit        Constant
hi def link knkBool       Constant
hi def link knkInt        Constant
hi def link knkKwd        Statement
hi def link knkKey        PreProc
hi def link knkStr        Constant

hi def link knkPrim       PreProc

hi def link knkParen      Special
hi def link knkSpecial    Special

hi def link knkQuot       Statement

hi def link knkFloat      Constant

hi def link knkComment    Comment

let b:current_syntax = "koneko"

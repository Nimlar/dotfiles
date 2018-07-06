" Vim syntax file
" Language:	taskk.txt (todo file)
" Maintainer:	Nicolas Toromanoff <nicolas.toromanoff@st.com>
" Last Change:	2018 Jul 2

if exists("b:current_syntax")
  finish
endif


syntax match todoNode          "\s*" nextgroup=todoMarker
syntax match todoMarker        "[^[:space:]]\+" nextgroup=todoInfo skipwhite contained contains=todoCompletion
syntax match todoMarker        "-" nextgroup=todoTodo skipwhite contained
syntax match todoMarker        "\~" nextgroup=todoOngoing skipwhite contained
syntax match todoMarker        "?" nextgroup=todoInfo skipwhite contained
syntax match todoMarker        "=" nextgroup=todoOnHold skipwhite contained
syntax match todoMarker        "×" nextgroup=todoDone skipwhite contained
syntax match todoMarker        "√" nextgroup=todoDone skipwhite contained

syntax match todoInfo          ".*$" contains=todoDate contained
syntax match todoDone          ".*$" contains=todoDate contained
syntax match todoTodo          ".*$" contains=todoDate contained
syntax match todoOngoing       ".*$" contains=todoDate contained
syntax match todoOnHold        ".*$" contains=todoDate contained
syntax match todoDate          "(\d\{4}-\d\{2}-\d\{2})" contained
syntax match todoCompletion    "\d\{1,3}\(\~\d\{1,3}\)\=%" contained

hi def link todoMarker         Label
hi def link todoCompletion     Label
"hi def link todoCompletion     PreProc
hi def link todoInfo           Normal
hi def link todoDate           Number
hi def link todoTodo           Normal
hi def link todoOngoing        Normal
hi def link todoOnHold         Special
hi def link todoDone           Comment

"Special
"PreProc
"Type
"Underlined
"Error
"Todo

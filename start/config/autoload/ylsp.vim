func ylsp#attached() abort
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl formatexpr=lsp#lsp#FormatExpr()
  setl tagfunc=lsp#lsp#TagFunc
  setl complete-=t " gabages included from lsp#lsp#TagFunc
  noremap <buffer> <expr> <F1> <SID>menu()
  echon "\U1F525"
endfunc

func ylsp#diag_updated() abort
  let b:ruler_lsp_diag=(lsp#lsp#ErrorCount()->values()->filter("v:val")->len()) ? "\U1F41E " : "\u2705 "
  redrawstatus
  " use echon to update the ruler
  echon
endfunc

func s:menu() abort
  call popup_menu(s:lsp_commands, #{ 
        \ callback : "<SID>callback",
        \ highlight : "Normal",
        \ })
endfunc

func s:callback(id, result) abort
  if a:result == -1 | return | endif
  execute "Lsp" .. s:lsp_commands[a:result - 1]
endfunc

let s:lsp_commands = [
      \ "Outline",
      \ "Format",
      \ "Rename",
      \ "Hover",
      \ "DiagShow",
      \ "LspSymbolSearch",
      \ "GotoDeclaration",
      \ "GotoDefinition",
      \ "GotoImpl",
      \ "GotoTypeDef",
      \ "PeekDeclaration",
      \ "PeekDefinition",
      \ "PeekImpl",
      \ "PeekReferences",
      \ "PeekTypeDef",
      \ ]

func ylsp#attached()
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl formatexpr=lsp#lsp#FormatExpr()
  setl tagfunc=lsp#lsp#TagFunc
  setl complete-=t " gabages included from lsp#lsp#TagFunc

  noremap <buffer> <expr> <F1> <SID>menu()
endfunc

func ylsp#setup()
  call LspOptionsSet(#{
        \ autoHighlightDiags: v:false,
        \ showDiagWithSign: v:false,
        \ autoComplete: v:false,
        \ ignoreCompleteItemsIsIncomplete: ["rust-analyzer", "pyright"],
        \ outlineWinSize: 30,
        \ popupBorder: v:true,
        \ popupHighlightSignatureHelp: "Normal",
        \ popupHighlight: "Normal",
        \ popupBorderHighlight: "Normal",
        \ ignoreMissingServer: v:true,
        \ })

  call LspAddServer([
        \ #{name: "clangd",
        \   filetype: ["c"],
        \   path: "clangd",
        \   args: ["--background-index"],
        \   features: #{ diagnostics: v:false },
        \ },
        \ #{name: "rust-analyzer",
        \   filetype: ["rust"],
        \   path: "rust-analyzer",
        \   args: [],
        \   syncInit: v:true,
        \   features: #{ diagnostics: v:false },
        \ },
        \ #{name: "pyright",
        \   filetype: "python",
        \   path: "pyright-langserver",
        \   args: ["--stdio"],
        \   workspaceConfig: #{ python: #{
        \     pythonPath: exepath("python3"),
        \     analysis: #{ typeCheckingMode: "off" },
        \   }},
        \   features: #{ documentFormatting: v:false },
        \  },
        \ #{name: "ruff",
        \   filetype: "python",
        \   path: "ruff",
        \   args: ["server"],
        \  },
        \ ])
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

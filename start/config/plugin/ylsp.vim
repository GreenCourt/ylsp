let &rulerformat="%l,%c%V%=%{LspRuler()}%P"

aug ylsp
  au!
  au User LspSetup call s:setup()

 " call echon to redraw the ruler
  au User LspDiagsUpdated execute "redrawstatus! | echon"
aug END

func LspRuler() abort
  return !exists("b:lsp_diag_on_ruler")
        \ ? ""
        \ : (lsp#lsp#ErrorCount()->values()->filter("v:val")->len())
        \ ? "\U1F41E "
        \ : "\u2705 "
endfunc

func s:setup() abort
  call LspOptionsSet(#{
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
        \ },
        \ #{name: "pyright",
        \   filetype: "python",
        \   path: "pyright-langserver",
        \   args: ["--stdio"],
        \   workspaceConfig: #{ python: #{
        \     analysis: #{ typeCheckingMode: "off" },
        \   }},
        \   features: #{ documentFormatting: v:false, diagnostics: v:false },
        \  },
        \ #{name: "ruff",
        \   filetype: "python",
        \   path: "ruff",
        \   args: ["server"],
        \  },
        \ ])
endfunc

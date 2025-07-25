let &rulerformat="%l,%c%V%=%{get(b:,'ruler_lsp_diag','')}%P"

aug ylsp
  au!
  au User LspSetup call s:setup()
  au User LspAttached call ylsp#attached()
  au User LspDiagsUpdated call ylsp#diag_updated()
aug END

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
        \   features: #{ diagnostics: v:false },
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

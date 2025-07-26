if executable("pyright-langserver")
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl tagfunc=lsp#lsp#TagFunc
  setl complete-=t " gabages included by lsp#lsp#TagFunc
endif

if executable("ruff")
  let b:lsp_diag_on_ruler = 1
  setl formatexpr=lsp#lsp#FormatExpr()
endif

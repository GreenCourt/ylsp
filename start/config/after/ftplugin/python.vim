if executable("pyright-langserver")
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl tagfunc=lsp#lsp#TagFunc
  setl complete-=t " gabages included by lsp#lsp#TagFunc
endif

if executable("ruff")
  setl formatexpr=lsp#lsp#FormatExpr()
endif

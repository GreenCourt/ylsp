if executable("clangd")
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl tagfunc=lsp#lsp#TagFunc
  setl formatexpr=lsp#lsp#FormatExpr()
endif

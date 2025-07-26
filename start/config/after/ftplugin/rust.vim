if executable("rust-analyzer")
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl tagfunc=lsp#lsp#TagFunc
  setl formatexpr=lsp#lsp#FormatExpr()
  let b:lsp_diag_on_ruler = 1
endif

if executable("pyright-langserver")
  setl completeopt+=popup
  setl keywordprg=:LspHover
  setl tagfunc=lsp#lsp#TagFunc
  setl complete-=t " gabages included by lsp#lsp#TagFunc
endif

if executable("ruff")
  setl formatexpr=lsp#lsp#FormatExpr()
endif

if exists("s:done") | finish | endif
let s:done = 1

func s:search_python_path() abort
  if !empty($VIRTUAL_ENV)
    return exepath("python3")
  endif

  let cur = getcwd()->resolve()
  let sep = (!exists("+shellslash") || &shellslash) ? "/" : "\\"

  while cur->fnamemodify(":h") != cur
    for v in [".venv", "venv"]
      let py = cur .. sep .. v .. sep .. "bin" .. sep .. "python3"
      if executable(py)
        return py
      endif
    endfor
    let cur = cur->fnamemodify(":h")
  endwhile

  return exepath("python3")
endfunc

let s:python_path = s:search_python_path()

echow s:python_path

call LspAddServer([
      \ #{name: "pyright",
      \   filetype: "python",
      \   path: "pyright-langserver",
      \   args: ["--stdio"],
      \   workspaceConfig: #{ python: #{
      \     pythonPath: s:python_path,
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

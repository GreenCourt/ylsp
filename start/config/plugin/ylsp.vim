aug ylsp
  au!
  au User LspSetup call s:setup()
aug END

func s:setup() abort
  call LspOptionsSet(#{
        \ showDiagWithSign: v:false,
        \ autoHighlightDiags: v:false,
        \ autoComplete: v:false,
        \ showSignature: v:false,
        \ ignoreCompleteItemsIsIncomplete: ["rust-analyzer", "pyright"],
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
        \     pythonPath: s:python_path(),
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

func s:python_path() abort
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

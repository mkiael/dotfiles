local on_attach = function()
  require'completion'.on_attach()
end

local lsp = require'lspconfig'

if vim.fn.executable('clangd') > 0 then
  lsp.clangd.setup{
    -- on_attach=on_attach, -- this line has to do with completing without pressing ctrl-space
    cmd = {
      "clangd",
      "--background-index=false",
      "--clang-tidy=true",
      "--completion-style=detailed",
      "--all-scopes-completion=true"
    },
  }
end

if vim.fn.executable('rls') > 0 then
   lsp.rls.setup{
      settings = {
         rust = {
            unstable_features = true,
            build_on_save = false,
            all_features = true,
         }
      }
   }
   lsp.rust_analyzer.setup{
      on_attach=on_attach
   }
end



-- Use signs with 0 width
vim.fn.sign_define("LspDiagnosticsSignError", {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning", {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation", {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint", {text = "", numhl = "LspDiagnosticsDefaultHint"})

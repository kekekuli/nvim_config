require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "jsonls",
  "eslint",
  "tailwindcss",
  "lua_ls",
  "ts_ls"
}

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers

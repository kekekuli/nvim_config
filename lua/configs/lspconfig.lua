require("nvchad.configs.lspconfig").defaults()

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
  return hover {
    border = "rounded",
  }
end

local servers = {
  "html",
  "cssls",
  "jsonls",
  "eslint",
  "tailwindcss",
  "lua_ls",
  "ts_ls",
}

vim.lsp.enable(servers)
-- read :h vim.lsp.config for changing options of lsp servers

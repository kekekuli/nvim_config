vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
vim.o.foldlevelstart = 99
vim.o.foldenable = true

local hover = vim.lsp.buf.hover
vim.lsp.buf.hover = function()
  return hover {
    border = "rounded",
  }
end


local vue_version = 2;

if (vue_version == 2) then
  local lspconfig = require("lspconfig");
  lspconfig.vuels.setup({
    filetypes = { "vue" },
    init_options = {
      config = {
        vetur = {
          validation = {
            template = true,
            script = true,
            style = true
          },
          completion = {
            autoImport = true,
            tagCasing = "kebab",
            useScaffoldSnippets = false
          },
          format = {
            defaultFormatter = {
              js = "prettier",
              ts = "prettier"
            }
          }
        }
      }
    },
  })
  vim.lsp.enable("vuels", vue_version == 2)
end

if (vue_version == 3) then
  -- For Mason v2,
  local vue_language_server_path = vim.fn.expand '$MASON/packages' ..
      '/vue-language-server' .. '/node_modules/@vue/language-server'
  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
  }
  local vtsls_config = {
    settings = {
      vtsls = {
        tsserver = {
          globalPlugins = {
            vue_plugin,
          },
        },
      },
    },
    filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
  }
  -- If you are on most recent `nvim-lspconfig`
  local vue_ls_config = {}
  -- nvim 0.11 or above
  vim.lsp.config('vtsls', vtsls_config)
  vim.lsp.config('vue_ls', vue_ls_config)
  vim.lsp.enable({ 'vtsls', 'vue_ls' }, vue_version == 3)
end

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
  local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
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
    filetypes = tsserver_filetypes
  }
  local ts_ls_config = {
    init_options = {
      plugins = {
        vue_plugin,
      },
    },
    filetypes = tsserver_filetypes,
  }

  -- If you are on most recent `nvim-lspconfig`
  local vue_ls_config = {}

  vim.lsp.config('vtsls', vtsls_config)
  vim.lsp.config('vue_ls', vue_ls_config)
  vim.lsp.config('ts_ls', ts_ls_config)
  vim.lsp.enable({ 'ts_ls', 'vue_ls' }) -- If using `ts_ls` replace `vtsls` to `ts_ls`
end

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

local vue2_lsp_config = {
  filetypes = { "vue" },
  settings = {
    vetur = {
      useWorkspaceDependencies = true,
      ignoreProjectWarning = true,
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
      experimental = {
        templateInterpolationService = true
      },
      format = {
        enable = false
      }
    },
  },
  cmd = { "vls", '--stdio' },
  root_markers = { "package.json" },
}

-- For Mason v2,
local vue_language_server_path = vim.fn.stdpath('data') ..
    "/mason/packages/vue-language-server/node_modules/@vue/language-server"
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
local vue3_ts_ls_config = {
  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}
local vue2_ts_ls_config = {
  init_options = {
    plugins = {
    },
  },
  filetypes = tsserver_filetypes,
}

-- If you are on most recent `nvim-lspconfig`
local vue_ls_config = {}

vim.lsp.config('vts_ls', vtsls_config)
vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('vuels', vue2_lsp_config)
vim.lsp.enable('vue_ls', false)


function enableVue2()
  vim.lsp.enable({ 'ts_ls', 'vuels', 'vue_ls' }, false);
  vim.lsp.config('ts_ls', vue2_ts_ls_config)
  vim.lsp.enable({ 'ts_ls', 'vuels' }, true);
end

function enableVue3()
  vim.lsp.enable({ 'ts_ls', 'vuels', 'vue_ls' }, false);
  vim.lsp.config('ts_ls', vue3_ts_ls_config)
  vim.lsp.enable({ 'ts_ls', 'vue_ls' }, true);
end

return {
  enableVue2 = enableVue2,
  enableVue3 = enableVue3
}

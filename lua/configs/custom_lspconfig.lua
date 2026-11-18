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


local vue2_ts_ls_config = {
  init_options = {
    plugins = {
    },
  },
  filetypes = tsserver_filetypes
}

function getVuePluginConfig(useWorkspaceDependencies)
  local server_path = vue_language_server_path

  if useWorkspaceDependencies then
    server_path = vim.fn.getcwd() .. '/node_modules/@vue/language-server'
  end

  return {
    name = '@vue/typescript-plugin',
    location = server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
  }
end

function getVue3TsLSPConfig(useWorkspaceDependencies)
  local vue_plugin = getVuePluginConfig(useWorkspaceDependencies)
  return {
    init_options = {
      plugins = {
        vue_plugin,
      },
    },
    filetypes = tsserver_filetypes,
  }
end

-- If you are on most recent `nvim-lspconfig`
local vue_ls_config = {}

vim.lsp.config('vue_ls', vue_ls_config)
vim.lsp.config('vuels', vue2_lsp_config)
vim.lsp.config('ts_ls', vue2_ts_ls_config)
vim.lsp.enable('vue_ls', false)

function EnableVue2()
  vim.lsp.enable({ 'ts_ls', 'vuels', 'vue_ls' }, false);
  vim.lsp.config('ts_ls', vue2_ts_ls_config)
  vim.lsp.enable({ 'ts_ls', 'vuels' }, true);
end

function EnableVue3()
  vim.lsp.enable({ 'ts_ls', 'vuels', 'vue_ls' }, false);
  vim.lsp.config('ts_ls', getVue3TsLSPConfig(false))
  vim.lsp.enable({ 'ts_ls', 'vue_ls' }, true);
end

-- This could support both vue2 and vue3, but I use it only when vetur not work well
function EnableLocalValor()
  vim.lsp.enable({ 'ts_ls', 'vuels', 'vue_ls' }, false);
  vim.lsp.config('ts_ls', getVue3TsLSPConfig(true))
  vim.lsp.enable({ 'ts_ls', 'vue_ls' }, true);
end

-- Ruby: use ruby-lsp (the `ruby-lsp` launcher detects the project's bundle itself).
-- Solargraph is disabled.
vim.lsp.enable("solargraph", false)
vim.lsp.config("ruby_lsp", {
  -- Reuse the server for this project when opening another Ruby file.
  reuse_client = function(client, config)
    return not client:is_stopped()
      and client.name == config.name
      and client.config.root_dir == config.root_dir
  end,
  -- Files without a project root (e.g. gem sources opened via `gd`) attach to the
  -- already running ruby_lsp client instead of starting a second, single-file one.
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, { ".tool-versions", "Gemfile", ".git" })
    if root then
      return on_dir(root)
    end
    for _, client in ipairs(vim.lsp.get_clients({ name = "ruby_lsp" })) do
      if client.config.root_dir then
        return on_dir(client.config.root_dir)
      end
    end
  end,
})
vim.lsp.enable("ruby_lsp", true)
-- graphql: make it attach inside TS/TSX (for `graphql\`\`` tagged queries),
-- and root at the folder holding graphql.config.yml so it finds the schema.
vim.lsp.config('graphql', {
  filetypes = { 'graphql', 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
  root_markers = { 'graphql.config.yml', '.graphqlrc.yml', '.graphqlrc', 'graphql.config.js' },
})

-- Pyright does not automatically discover a virtual environment above the
-- package root in Python monorepos. Walk upward so nested packages can share
-- the repository-level .venv created by tools such as uv.
local function find_python(root_dir)
  local venv = vim.fs.find('.venv', {
    path = root_dir,
    upward = true,
    type = 'directory',
  })[1]

  if not venv then
    return nil
  end

  local python = venv .. '/bin/python'
  if vim.fn.executable(python) == 1 then
    return python
  end

  return nil
end

vim.lsp.config('pyright', {
  before_init = function(_, config)
    local python = find_python(config.root_dir)
    if python then
      config.settings = vim.tbl_deep_extend('force', config.settings or {}, {
        python = { pythonPath = python },
      })
    end
  end,
  on_init = function(client)
    local python = find_python(client.root_dir)
    if python then
      client.settings = vim.tbl_deep_extend('force', client.settings or {}, {
        python = { pythonPath = python },
      })
      client.config.settings = client.settings
      client:notify('workspace/didChangeConfiguration', { settings = nil })
    end
  end,
})

return {
  EnableVue2 = EnableVue2,
  EnableVue3 = EnableVue3,
  EnableLocalValor = EnableLocalValor
}

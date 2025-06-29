return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = {
      "Git", -- 打开 Fugitive 主界面，最常用
      "G", -- :Git 的简写，方便
      "Gstatus", -- 查看当前 git 状态
      "Gdiffsplit", -- 分割窗口显示文件差异
      "Gread", -- 从 git 仓库恢复文件（放弃本地修改）
      "Gwrite", -- 保存修改到 git
      "Gblame", -- 查看文件某行的 git blame 信息
      "Glog", -- 查看提交历史
      "Gpush", -- git push
      "Gpull", -- git pull
      "Gcommit", -- git commit
      "Gbranch", -- 分支管理
      "Gcheckout", -- 切换分支或提交
      "Gmerge", -- 合并分支
      "Gstash", -- stash 相关操作
      "Greset", -- reset 代码
    },
  },
  {
    "potamides/pantran.nvim",
    config = function()
      require("pantran").setup {
        default_engine = "google", -- 默认翻译引擎，支持 google_translate、youdao、bing 等
        engines = {
          google = {
            default_target = "zh-CN",
            fallback = {
              default_target = "zh-CN",
            },
          },
        },
      }
    end,
    cmd = { "Pantran" },
  },
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = { "ToggleTerm", "ToggleTermToggleAll", "ToggleTermSendCurrentLine", "ToggleTermSendVisualLines" },
    config = function()
      require("toggleterm").setup {
        open_mapping = [[<c-\>]],
      }
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    opts = function(_, opts)
      table.insert(opts.sources, 1, { name = "codeium" })
    end,
  },
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        enable_cmp_source = false,
        virtual_text = {
          enabled = true,

          key_bindings = {
            accept = "<C-l>",
            -- Accept the current completion.
            clear = "<C-x>",
          },
        },
      }
    end,
    event = "InsertEnter",
  },
  {
    "RRethy/vim-illuminate",
    event = { "CursorHold", "CursorHoldI" },
    config = function()
      require("illuminate").configure {
        min_count_to_highlight = 2,
      }
    end,
  },

  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    config = function()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      local language_servers = vim.lsp.get_clients() -- or list servers manually like {'gopls', 'clangd'}
      for _, ls in ipairs(language_servers) do
        require("lspconfig")[ls].setup {
          capabilities = capabilities,
          -- you can add other fields for setting up lsp server in this table
        }
      end
      require("ufo").setup()
    end,
    event = "BufReadPost",
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          debounce = 1000,
        },
      }
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
  --
}

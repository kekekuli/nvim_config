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
      require("nvchad.configs.lspconfig").defaults()
    end,
  },
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "G" },
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
  },
  {
    "Exafunction/windsurf.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
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
    event = { "BufReadPost" },
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
      require("ufo").setup()
    end,
    event = "LspAttach",
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup {
        lightbulb = {
          enable = false
        },
      }
    end,
    event = "LspAttach",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,    -- 让它在启动时加载
    priority = 1000, -- 确保在其他插件之前加载
    config = function()
      -- 可选：配置主题风格
      require("tokyonight").setup {
        style = "storm",        -- 可选: "storm", "night", "moon", "day"
        terminal_colors = true, -- 终端颜色适配
      }
      -- 激活 colorscheme
      vim.cmd.colorscheme "tokyonight"
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-neotest/nvim-nio",
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("dapui").setup()
        end,
      },
      {
        "jay-babu/mason-nvim-dap.nvim",
        config = function()
          require("mason-nvim-dap").setup({
            ensure_installed = { "js" },
            automatic_installation = true,
            handlers = {}
          })
        end,
      },
    },
    config = function()
      require("configs.dap-config")
    end
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "javascript", "typescript", "html", "css", "tsx", "scss",
        "go", "lua", "c", "cpp", "python", "vue", 'embedded_template',
      },
      highlight = {
        enable = true
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
      vim.treesitter.language.register('embedded_template', 'ejs');
      vim.filetype.add({
        extension = {
          ejs = 'ejs'
        }
      })
    end
  },
  {
    "kazhala/close-buffers.nvim",
    cmd = {
      "BDelete", "BWipeout", -- lazy-load on use
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    event = "BufReadPre",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = require("configs.lsp_servers"),
      })
      require("configs.custom_lspconfig");
    end
  },
  {
    'mhinz/vim-startify',
    event = "VimEnter"
  },
  {
    'chentoast/marks.nvim',
    event = "BufReadPost",
    config = function()
      require('marks').setup({})
    end
  },
  {
    'nvim-pack/nvim-spectre',
    cmd = 'Spectre',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'jvgrootveld/telescope-zoxide',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/popup.nvim',
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('telescope').setup {}
      require('telescope').load_extension('zoxide')

      if vim.fn.executable("zoxide") == 0 then
        -- 如果不可执行 (返回 0)，则打印错误信息并退出
        vim.notify("Error: zoxide is not installed or not in your PATH.", vim.log.levels.ERROR)
      end
    end
  },
  {
    "folke/flash.nvim",
    event = "BufReadPost",
    config = function()
      require("flash").setup({
        modes = {
          char = {
            jump_labels = true
          }
        }
      })
    end
  },
  {
    'sindrets/diffview.nvim',
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewFileHistory',
    },
    config = function()
      require('diffview').setup({
        view = {
          merge_tool = {
            layout = "diff3_mixed"
          }
        },
      })

      vim.api.nvim_set_hl(0, "DiffChange", {
        bg = "#2a3231",
        -- fg (前景色) 保持默认
      })

      vim.api.nvim_set_hl(0, "DiffText", {
        fg = "#E5C07B", -- Onedark的亮金色作为背景
        bg = '#4e4e1c', -- 文本颜色设为深色
      })

      vim.api.nvim_set_hl(0, "DiffTextAdd", {
        link = "DiffText"
      })
    end
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    event = "BufReadPost",
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = '@function.outer',
              ['if'] = '@function.inner',

              ['ab'] = '@block.outer',
              ['ib'] = '@block.inner',

              ['ac'] = '@call.outer',
              ['ic'] = '@call.inner',

              ['al'] = '@lexical_block',
            }
          }
        },
      }
    end
  }

}

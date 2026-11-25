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
  -- {
  --   "Exafunction/windsurf.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "hrsh7th/nvim-cmp",
  --   },
  --   config = function()
  --     require("codeium").setup {
  --       virtual_text = {
  --         enabled = true,
  --
  --         key_bindings = {
  --           accept = "<C-l>",
  --           -- Accept the current completion.
  --           clear = false,
  --         },
  --       },
  --     }
  --     -- Manually request a completion when the automatic one doesn't show up
  --     vim.keymap.set("i", "<C-x>", function()
  --       require("codeium.virtual_text").cycle_or_complete()
  --     end, { desc = "Codeium: trigger completion" })
  --   end,
  --   event = "InsertEnter",
  -- },
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
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
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
    lazy = false,
    opts = {
      ensure_installed = {
        "javascript", "typescript", "html", "css", "tsx", "scss",
        "go", "lua", "c", "cpp", "python", "vue", 'embedded_template',
        "json", "erlang", "graphql", "rust", "elixir", "go", "yaml",
        "markdown", "markdown_inline", "prisma",
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
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("configs.custom_lspconfig");
      require("mason-lspconfig").setup({
        ensure_installed = require("configs.lsp_servers"),
        automatic_enable = { exclude = { "ruby_lsp" } },
      })
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter'
    },
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
  },
  {
    'ThePrimeagen/harpoon',
    event = "BufReadPost",
    config = function()
      require('harpoon').setup()
      require('telescope').load_extension('harpoon')
    end,
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    '3rd/image.nvim',
    event = "BufReadPost",
    build = false,
    opts = {
      processor = "magick_cli",
    },
    config = function()
      require('image').setup({
        backend = "kitty",
        kitty_method = "normal",
        tmux_show_only_in_active_window = true,
      })

      if (vim.fn.executable("magick") == 0) then
        vim.notify("Error: ImageMagick is not installed, which is required by image.nvim", vim.log.levels.ERROR)
      end
    end
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    opts = {
      html = {
        tag = {
          code = { scope_highlight = "@markup.raw" },
          em = { scope_highlight = "@markup.italic" },
          strong = { scope_highlight = "@markup.strong" },
        },
      },
    },
    event = "BufReadPost"
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    init = function()
      local config = vim.g.rainbow_delimiters or {}
      config.condition = function(bufnr)
        if vim.bo[bufnr].buftype ~= "" then
          return false
        end

        local lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
        if not lang then
          return false
        end

        local ok, parser = pcall(vim.treesitter.get_parser, bufnr, lang)
        return ok and parser ~= nil
      end
      vim.g.rainbow_delimiters = config
    end,
  },
  {
    "andymass/vim-matchup",
    event = "BufReadPost",
    config = function()
      vim.g.matchup_treesitter_stopline = 500
    end
  },
  {
    "wakatime/vim-wakatime",
    event = { "BufReadPost", "BufNewFile" },
  },
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod",                     lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
    },
    cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
    init = function()
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- {
  --   'https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim.git',
  --   -- Activate when a file is created/opened
  --   event = { 'BufReadPre', 'BufNewFile' },
  --   cond = function()
  --     -- Only activate if token is present in environment variable.
  --     -- Remove this line to use the interactive workflow.
  --     return vim.env.GITLAB_TOKEN ~= nil and vim.env.GITLAB_TOKEN ~= ''
  --   end,
  --   config = function()
  --     require('gitlab').setup({
  --       statusline = {
  --         enabled = false
  --       },
  --       code_suggestions = {
  --         enabled = true,
  --
  --         -- For the full list of default languages, see the 'auto_filetypes' array in
  --         -- https://gitlab.com/gitlab-org/editor-extensions/gitlab.vim/-/blob/main/lua/gitlab/config/defaults.lua
  --         ghost_text = {
  --           enabled = true, -- ghost text is an experimental feature
  --           accept_suggestion = "<C-l>",
  --           stream = true,
  --         },
  --       }
  --     })
  --
  --     -- This plugin is not compatible for neovim 0.12+, so make a patch mannully, may remove this in furture.
  --     local ghost_text = require("gitlab.ghost_text")
  --     local function get_ghost_text_client()
  --       return ghost_text.lsp_client
  --           and vim.lsp.get_client_by_id(ghost_text.lsp_client.client_id)
  --     end
  --
  --     local update_ghost_text = ghost_text.update_ghost_text
  --     ghost_text.update_ghost_text = function(...)
  --       if not get_ghost_text_client() then
  --         return
  --       end
  --       return update_ghost_text(...)
  --     end
  --
  --     local cancel_streaming = ghost_text.cancel_streaming
  --     ghost_text.cancel_streaming = function(...)
  --       if not get_ghost_text_client() then
  --         ghost_text.finish_streaming()
  --         return
  --       end
  --       return cancel_streaming(...)
  --     end
  --
  --     local ghost_text_vim = setmetatable({}, { __index = vim })
  --     ghost_text_vim.lsp = setmetatable({}, { __index = vim.lsp })
  --     ghost_text_vim.lsp.util = setmetatable({}, { __index = vim.lsp.util })
  --     ghost_text_vim.lsp.util.make_position_params = function(window, encoding)
  --       local client = get_ghost_text_client()
  --       encoding = encoding or (client and client.offset_encoding)
  --           or require("gitlab.config").current().code_suggestions.offset_encoding
  --       return vim.lsp.util.make_position_params(window, encoding)
  --     end
  --     ghost_text.vim = ghost_text_vim
  --
  --     local function start_gitlab()
  --       if vim.bo.buftype ~= "" or vim.api.nvim_buf_get_name(0) == "" then
  --         return
  --       end
  --
  --       if #vim.lsp.get_clients({ bufnr = 0, name = "gitlab_code_suggestions" }) == 0 then
  --         vim.cmd.GitLabCodeSuggestionsStart()
  --       end
  --     end
  --
  --     vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  --       group = vim.api.nvim_create_augroup("GitLabAutoStart", { clear = true }),
  --       callback = start_gitlab,
  --       desc = "Start GitLab code suggestions when loading or creating a file",
  --     })
  --     vim.schedule(start_gitlab)
  --   end
  --
  --   -- install glab, duo cli tool to start interactive chat particaulaly for gitlab-accsiocated projects.
  -- }
}

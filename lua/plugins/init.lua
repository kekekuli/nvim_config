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
}

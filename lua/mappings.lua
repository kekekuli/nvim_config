require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-i>", "<C-i>", { desc = "Jump forward" })

local pantran = require "pantran"
local opts = { silent = true, expr = true, noremap = true }

map(
  "n",
  "<leader>ts",
  pantran.motion_translate,
  vim.tbl_extend("force", opts, {
    desc = "Translate and move cursor",
  })
)

map(
  "n",
  "<leader>tr",
  function()
    return pantran.motion_translate() .. "_"
  end,
  vim.tbl_extend("force", opts, {
    desc = "Translate at cursor",
  })
)

map(
  "x",
  "<leader>tr",
  pantran.motion_translate,
  vim.tbl_extend("force", opts, {
    desc = "Translate selected text",
  })
)
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-i>", "<C-i>", { desc = "Jump forward" })

-- pantran configs
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

--Toggleterm configs
local ToggleOpts = { silent = true, noremap = true }

local Terminal = require("toggleterm.terminal").Terminal

local term1 = Terminal:new { count = 1, direction = "float" }
local term2 = Terminal:new { count = 2, direction = "float" }
local term3 = Terminal:new { count = 3, direction = "float" }

map("n", "<leader>1", function()
  term1:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #1" }))
map("n", "<leader>2", function()
  term2:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #2" }))
map("n", "<leader>3", function()
  term3:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #3" }))

local lazygit = Terminal:new {
  cmd = "lazygit",
  direction = "float",
}

map("n", "<leader>gg", function()
  lazygit:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle lazygit terminal" }))

-- ufo fold
map("n", "zR", require("ufo").openAllFolds)
map("n", "zM", require("ufo").closeAllFolds)

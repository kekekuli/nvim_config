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

-- lspsaga
map("n", "gh", "<cmd>Lspsaga finder<CR>", { desc = "Lspsaga finder" })
map("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", { desc = "Code Action" })
map("n", "<leader>rr", "<cmd>Lspsaga rename<CR>", { desc = "Rename" })
map("n", "<leader>gp", "<cmd>Lspsaga peek_definition<CR>", { desc = "Peek Definition" })
map("n", "<leader>gd", "<cmd>Lspsaga goto_definition<CR>", { desc = "Go To Definition" })
map("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>", { desc = "Line Diagnostics" })
map("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>", { desc = "Buffer Diagnostics" })
map("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { desc = "Prev Diagnostic" })
map("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", { desc = "Next Diagnostic" })

local dap = require("dap");
local dapui = require("dapui")
map("n", "<leader>j", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })
map("n", "<leader>J", function()
  local cond = vim.fn.input("Breakpoint condition: ")
  dap.set_breakpoint(cond)
end, { desc = "Set conditional breakpoint" })
map("n", "<leader>jc", dap.clear_breakpoints, { desc = "Clear all breakpoints" })
map("n", "<F5>", dap.continue, { desc = "Start/Continue Debugging" })
map("n", "<leader>cd", function()
  dap.terminate()
end, { desc = "Stop debug" })
map("n", "<F10>", dap.step_over, { desc = "Step Over" })
map("n", "<F11>", dap.step_into, { desc = "Step Into" })
map("n", "<F12>", dap.step_out, { desc = "Step Out" })
map("n", "<leader>dr", dap.repl.toggle, { desc = "Toggle Debug REPL" })
map("n", "<leader>dl", dap.run_last, { desc = "Run Last Debug Session" })
map("n", "<leader>jj", dapui.toggle, { desc = "Toggle DAP UI" })

require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("n", "<C-i>", "<C-i>", { desc = "Jump forward" })

-- pantran configs
local opts = { silent = true, expr = true, noremap = true }

map(
  "n",
  "<leader>ts",
  function()
    require("pantran").motion_translate()
  end,
  vim.tbl_extend("force", opts, {
    desc = "Translate and move cursor",
  })
)

map(
  "n",
  "<leader>tr",
  function()
    return require("pantran").motion_translate() .. "_"
  end,
  vim.tbl_extend("force", opts, {
    desc = "Translate at cursor",
  })
)

map(
  "x",
  "<leader>tr",
  function()
    require("pantran").motion_translate()
  end,
  vim.tbl_extend("force", opts, {
    desc = "Translate selected text",
  })
)

--Toggleterm configs
local ToggleOpts = { silent = true, noremap = true }
local terminals = {}
map("n", "<leader>1", function()
  local Terminal = require("toggleterm.terminal").Terminal
  terminals[1] = terminals[1] or Terminal:new { count = 1, direction = "float" }
  terminals[1]:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #1" }))
map("n", "<leader>2", function()
  local Terminal = require("toggleterm.terminal").Terminal
  terminals[2] = terminals[2] or Terminal:new { count = 2, direction = "float" }
  terminals[2]:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #2" }))
map("n", "<leader>3", function()
  local Terminal = require("toggleterm.terminal").Terminal
  terminals[3] = terminals[3] or Terminal:new { count = 3, direction = "float" }
  terminals[3]:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle float terminal #3" }))
map("n", "<leader>gg", function()
  local Terminal = require("toggleterm.terminal").Terminal
  terminals.lazygit = terminals.lazygit or Terminal:new {
    cmd = "lazygit",
    direction = "float",
  }
  terminals.lazygit:toggle()
end, vim.tbl_extend("force", ToggleOpts, { desc = "Toggle lazygit terminal" }))

-- ufo fold
map("n", "zR", function() require("ufo").openAllFolds() end)
map("n", "zM", function() require("ufo").closeAllFolds() end)

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

-- dap, debug related
map("n", "<leader>j", function() require("dap").toggle_breakpoint() end, { desc = "Toggle breakpoint" })
map("n", "<leader>J", function()
  local cond = vim.fn.input("Breakpoint condition: ")
  require("dap").set_breakpoint(cond)
end, { desc = "Set conditional breakpoint" })
map("n", "<leader>jc", function() require("dap").clear_breakpoints() end, { desc = "Clear all breakpoints" })
map("n", "<F5>", function() require("dap").continue() end, { desc = "Start/Continue Debugging" })
map("n", "<leader>cd", function() require("dap").terminate() end, { desc = "Stop debug" })
map("n", "<F10>", function() require("dap").step_over() end, { desc = "Step Over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<F12>", function() require("dap").step_out() end, { desc = "Step Out" })
map("n", "<leader>dr", function() require("dap").repl.toggle() end, { desc = "Toggle Debug REPL" })
map("n", "<leader>dl", function() require("dap").run_last() end, { desc = "Run Last Debug Session" })
map("n", "<leader>jj", function() require("dapui").toggle() end, { desc = "Toggle DAP UI" })

-- control buffers
map("n", "<leader>da", function() require("close_buffers").delete({ type = 'all', force = true }) end,
  { desc = "Delete all buffers" })
map("n", "<leader>do", function()
  require("close_buffers").delete({ type = 'other' })
end, { desc = "Delete other buffers" })

-- find and replace
map("n", "<leader>rp", function() require("spectre").open() end, { desc = "Start Spectre (Find/Replace)" })

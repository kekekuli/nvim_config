local dap = require("dap")


vim.fn.sign_define('DapBreakpoint', {
  text = '🛑', -- or '', '●', '🔴', etc.
  texthl = 'DiagnosticError', -- highlight group for color
})
-- Conditional Breakpoint (e.g. <leader>J)
vim.fn.sign_define('DapBreakpointCondition', {
  text = '👀',
  texthl = 'DiagnosticWarn',
  linehl = '',
  numhl = 'DiagnosticWarn',
})

-- Log Point (if you ever use `dap.set_breakpoint(nil, nil, "log message")`)
vim.fn.sign_define('DapLogPoint', {
  text = '📄',
  texthl = 'DiagnosticInfo',
  linehl = '',
  numhl = 'DiagnosticInfo',
})

-- DAP stopped line
vim.fn.sign_define('DapStopped', {
  text = '👉',
  texthl = 'DiagnosticOk',
  linehl = 'Visual',
  numhl = '',
})

-- Adapter for Node.js debugging (works with Vite and React)
dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {
    vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js"
  },
}
dap.adapters.chrome = {
  type = "server",
  host = "localhost",
  port = 9222, -- Chrome remote debugging port
}

dap.configurations.javascript = {
  {
    name = "Launch Chrome at 3000 port with src as webRoot",
    type = "chrome",
    request = "launch",
    url = "http://localhost:3000", -- your React app url
    webRoot = "${workspaceFolder}/src",
    sourceMaps = true,
    protocol = "inspector",
    port = 9222,
    runtimeExecutable = "google-chrome", -- e.g. "google-chrome" or full path
  },
}

dap.configurations.typescript = dap.configurations.javascript

local dapui = require("dapui")
dapui.setup()

-- Auto-open/close dap-ui on start/stop
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

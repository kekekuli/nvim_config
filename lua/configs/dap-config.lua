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

local dap = require("dap")
local dapui = require("dapui")
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({ reset = true })
end
dap.listeners.before.event_terminated["dapui_config"] = dapui.close
dap.listeners.before.event_exited["dapui_config"] = dapui.close

local jsDebuggerPath = vim.fn.expand("$MASON") .. "/packages/js-debug-adapter/js-debug"

dap.adapters["pwa-node"] = {
  type = "server",
  host = "localhost",
  port = "${port}",
  executable = {
    command = "node",
    -- 💀 Make sure to update this path to point to your installation
    args = { jsDebuggerPath .. "/src/dapDebugServer.js", "${port}" },
  }
}
dap.adapters["pwa-chrome"] = dap.adapters["pwa-node"]

for _, language in ipairs({ "typescript", "javascript", "svelte", "typescriptreact" }) do
  dap.configurations[language] = {
    {
      -- use nvim-dap-vscode-js's pwa-node debug adapter
      type = "pwa-node",
      -- launch a new process to attach the debugger to
      request = "launch",
      -- name of the debug action you have to select for this config
      name = "Launch current file in new node process",
      program = "${file}",
    },
    {
      -- use nvim-dap-vscode-js's pwa-node debug adapter
      type = "pwa-node",
      -- attach to an already running node process with --inspect flag
      -- default port: 9222
      request = "attach",
      name = "Attach to node process",
      -- allows us to pick the process using a picker
      processId = require 'dap.utils'.pick_process,
      -- name of the debug action name = "Attach debugger to existing `node --inspect` process",
      -- for compiled languages like TypeScript or Svelte.js
      sourceMaps = true,
      -- resolve source maps in nested locations while ignoring node_modules
      resolveSourceMapLocations = { "${workspaceFolder}/**",
        "!**/node_modules/**" },
      -- path to src in vite based projects (and most other projects as well)
      cwd = "${workspaceFolder}/src",
      -- we don't want to debug code inside node_modules, so skip it!
      skipFiles = { "${workspaceFolder}/node_modules/**/*.js" },
    },
    {
      -- use nvim-dap-vscode-js's pwa-chrome debug adapter
      type = "pwa-chrome",
      request = "launch",
      -- name of the debug action
      name = "Use chrome to attach web app",
      -- default vite dev server url
      url = "http://localhost:5173",
      -- for TypeScript/Svelte
      sourceMaps = true,
      webRoot = "${workspaceFolder}/src",
      protocol = "inspector",
      port = 9222,
      -- skip files from vite's hmr
      skipFiles = { "**/node_modules/**/*", "**/@vite/*", "**/src/client/*", "**/src/*" },
    },
  }
end

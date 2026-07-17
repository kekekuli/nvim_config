require "nvchad.autocmds"

-- docker-compose-language-service only attaches to the yaml.docker-compose filetype
vim.filetype.add {
  filename = {
    ["docker-compose.yml"] = "yaml.docker-compose",
    ["docker-compose.yaml"] = "yaml.docker-compose",
    ["compose.yml"] = "yaml.docker-compose",
    ["compose.yaml"] = "yaml.docker-compose",
  },
}

-- SQL buffers: complete real table/column names from the connected database
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "sql", "mysql", "plsql" },
  callback = function()
    require("cmp").setup.buffer {
      sources = {
        { name = "vim-dadbod-completion" },
        { name = "buffer" },
        { name = "path" },
      },
    }
  end,
})

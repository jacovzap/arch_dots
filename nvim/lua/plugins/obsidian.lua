local function last_modified_date()
  return os.date("%d-%m-%Y %H:%M:%S")
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.md",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    for i, line in ipairs(lines) do
      if line:match("^last_modified:") then
        lines[i] = "last_modified: " .. last_modified_date()
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
        break
      end
    end
  end,
})

return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to :h file-pattern for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "second_brain",
        path = "~/Documents/Obsidian/second_brain",
      },
    },
    templates = {
      folder = "~/Documents/Obsidian/second_brain/resources/templates",
      date_format = "%d-%m-%Y",
      time_format = "%H:%M",
      substitutions = {
        last_modified = last_modified_date,
      },
    },

    -- see below for full list of options 👇
  },
}

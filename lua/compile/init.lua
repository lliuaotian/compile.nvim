local M = {}

function M.setup(opts)
  opts = opts or {}
  -- TODO: implement setup function
  vim.keymap.set("n", "<leader>o", function()
    vim.notify("Hello Lua Plugin")
  end)
end

return M


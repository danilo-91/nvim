--do a protected call
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

--require this under nvim/lua/user/lsp/*.lua
require "user.lsp.mason"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"

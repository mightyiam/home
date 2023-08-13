require("luafun.fun")()
local lsp_zero = require("lsp-zero")
lsp_zero.preset("system-lsp")
lsp_zero.setup_servers({
	"lua_ls",
	"nixd",
	"tsserver",
})
lsp_zero.set_preferences({
	set_lsp_keymaps = false,
})

require("lsp.lua")(lsp_zero)

lsp_zero.setup()
require("lsp.rust")(lsp_zero)
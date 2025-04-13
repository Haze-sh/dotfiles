-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "onenord",
	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.nvdash = {
    load_on_startup = true,
    header = {
    "           ▄ ▄                   ",
    "       ▄   ▄▄▄     ▄ ▄▄▄ ▄ ▄     ",
    "       █ ▄ █▄█ ▄▄▄ █ █▄█ █ █     ",
    "    ▄▄ █▄█▄▄▄█ █▄█▄█▄▄█▄▄█ █     ",
    "  ▄ █▄▄█ ▄ ▄▄ ▄█ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ",
    "  █▄▄▄▄ ▄▄▄ █ ▄ ▄▄▄ ▄ ▄▄▄ ▄ ▄ █ ▄",
    "▄ █ █▄█ █▄█ █ █ █▄█ █ █▄█ ▄▄▄ █ █",
    "█▄█ ▄ █▄▄█▄▄█ █ ▄▄█ █ ▄ █ █▄█▄█ █",
    "    █▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█ █▄█▄▄▄█    ",
    },
    buttons = {},
}

 M.ui = {
      --  tabufline = {
      --     lazyload = false
      -- },
       statusline = {
          theme = "vscode_colored",
      }
}

-- vim.cmd('colorscheme base16')
vim.cmd("hi Cursor guifg=Black guibg=Grey")
vim.g.markdown_folding = 1
vim.opt.conceallevel = 1
vim.opt.arabicshape = false
vim.opt.guicursor = 'n-v-c-sm:blinkon1/block-Cursor/lCursor,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt_local.spell = false

return M

---@type ChadrcConfig 
local M = {}

M.plugins = "custom.plugins"

M.ui = {
  theme = "nord",
  statusline = {
    theme = "vscode_colored",
  },
  nvdash = {
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
  },
}

-- M.mappings = require "custom.mappings"

-- vim.cmd('colorscheme base16')
vim.cmd("hi Cursor guifg=Black guibg=Grey")

vim.g.markdown_folding=1
vim.opt.conceallevel=1
vim.opt.arabicshape = false
vim.opt.guicursor = 'n-v-c-sm:blinkon1/block-Cursor/lCursor,i-ci-ve:ver25,r-cr-o:hor20'

return M

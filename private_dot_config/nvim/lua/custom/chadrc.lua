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

-- vim.cmd('colorscheme base16')
vim.cmd("hi Cursor guifg=Black guibg=Grey")
vim.g.markdown_folding = 1
vim.opt.conceallevel = 1
vim.opt.arabicshape = false
vim.opt.guicursor = 'n-v-c-sm:blinkon1/block-Cursor/lCursor,i-ci-ve:ver25,r-cr-o:hor20'
vim.opt_local.spell = false

-- Global mappings
local opts = { noremap=true, silent=false }

vim.api.nvim_set_keymap("i", "<C-l>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)
vim.api.nvim_set_keymap("n", "<leader>zn", "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zt", "<Cmd>ZkTags<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>zf", "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", opts)
vim.api.nvim_set_keymap("v", "<leader>zf", ":'<,'>ZkMatch<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>st", ":CtrlPTag<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>tt", ":silent !ctags -R . <CR>:redraw<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>te", "<Cmd>Translate --target_lang=en<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>td", "<Cmd>Translate --target_lang=de<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>lr", "<Cmd>set leftright<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rl", "<Cmd>set rightleft<CR>", opts)

-- Functions
function M.grep_notes(opts)
  local collection = {}
  local list_opts = { select = { "title", "path", "absPath" } }
  require("zk.api").list(vim.env.ZK_NOTEBOOK_DIR, list_opts, function(_, notes)
    for _, note in ipairs(notes) do
      collection[note.absPath] = note.title or note.path
    end
  end)
  local options = vim.tbl_deep_extend("force", {
    prompt_title = "Notes",
    search_dirs = { vim.env.ZK_NOTEBOOK_DIR },
    disable_coordinates = true,
    path_display = function(_, path)
      return collection[path]
    end,
  }, opts or {})
  require("telescope.builtin").live_grep(options)
end
vim.api.nvim_create_user_command("ZkGrep", M.grep_notes, {})

return M

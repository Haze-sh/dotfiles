local plugins = {
  -- LSP
  {
    "neovim/nvim-lspconfig",
    config = function ()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
  },

  -- Themes
  {
    'folke/zen-mode.nvim',
    lazy = false,
  },
  {
    'folke/twilight.nvim',
  },

  -- Languages
  {
    'Haze-sh/todo.txt-vim',
    ft = 'todo',
    config = function ()
      Todo_update_fold_on_sort=1
      TodoTxtSortDueDateCursorPos="top"
    end,
  },
  {
    'nvim-orgmode/orgmode',
    ft = 'org',
    config = function()
            require('orgmode').setup_ts_grammar()
    end
  },
  {
    'mickael-menu/zk-nvim',
    ft = 'markdown',
    config = function()
      require("zk").setup()
    end,
  },
--  {
--    'dkarter/bullets.vim',
--    ft = 'markdown',
--  },
  {
    'Haze-sh/tasks-conceal.vim',
    ft = 'markdown',
  },
  {
    'lervag/vimtex',
    ft = { 'tex', 'bib' },
    config = function ()
      Tex_flavor='latex'
      Vimtex_view_method='zathura'
      Vimtex_quickfix_mode=0
      Tex_conceal='abdmg'
    end,
  },
  {
    'iurimateus/luasnip-latex-snippets.nvim',
    config = function()
      require'luasnip-latex-snippets'.setup()
    end,
    ft = { 'tex' },
  },
  {
    'wren/jrnl.vim',
    ft = 'jrnl',
  },

  -- AI
  -- {
  --   'huggingface/llm.nvim',
  --   lazy = false,
  --   opts = {
  --     model = "bigcode/starcoder",
  --     -- parameters that are added to the request body
  --     query_params = {
  --       max_new_tokens = 60,
  --       temperature = 0.2,
  --       top_p = 0.95,
  --       stop_token = "<|endoftext|>",
  --     },
  --     -- set this if the model supports fill in the middle
  --     fim = {
  --       enabled = true,
  --       prefix = "<fim_prefix>",
  --       middle = "<fim_middle>",
  --       suffix = "<fim_suffix>",
  --     },
  --     debounce_ms = 80,
  --     accept_keymap = "<C-CR>",
  --     dismiss_keymap = "<S-CR>",
  --   },
  -- },
  -- {
  --   'gsuuon/llm.nvim',
  -- },
  {
    'voldikss/vim-translator',
  },
}
return plugins

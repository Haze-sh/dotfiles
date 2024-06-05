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
    end,
  },
  {
    'mickael-menu/zk-nvim',
    ft = 'markdown',
    config = function()
      require("zk").setup()
    end,
  },
  {
    'dkarter/bullets.vim',
    ft = 'markdown',
  },
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
  {
    'madox2/vim-ai',
    lazy = false,
  },
  {
    'huggingface/llm.nvim',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org', 'py', 'cpp' },
    -- lazy = false,
    opts = {
        model = "codellama/CodeLlama-13b-hf",
        -- model = "bigcode/starcoder",
        accept_keymap = "<C-CR>",
        dismiss_keymap = "<S-CR>",
        tokens_to_clear = { "<EOT>" },
        -- tokens_to_clear = { "<|endoftext|>" },
        query_params = {
        max_new_tokens = 60,
        temperature = 0.2,
        top_p = 0.95,
        stop_tokens = nil,
        },
        fim = {
          enabled = true,
          prefix = "<PRE> ",
          middle = " <MID>",
          suffix = " <SUF>",
          -- prefix = "<fim_prefix>",
          -- middle = "<fim_middle>",
          -- suffix = "<fim_suffix>",
        },
        context_window = 4096,
        -- context_window = 8192,
        tokenizer = {
          repository = "codellama/CodeLlama-13b-hf",
          -- repository = "bigcode/starcoder",
        },
        enable_suggestions_on_startup = false,
        enable_suggestions_on_files = "*",
    },
  },
  {
    'gsuuon/model.nvim',
    ft = 'mchat',
    cmd = { 'M', 'Model', 'Mchat' },
    init = function()
      vim.filetype.add({
        extension = {
          mchat = 'mchat',
        }
      })
    end,
    keys = {
      {'<C-m>d', ':Mdelete<cr>', mode = 'n'},
      {'<C-m>s', ':Mselect<cr>', mode = 'n'},
      {'<C-m><space>', ':Mchat<cr>', mode = 'n' }
    },
  },
  -- Translations
  {
    'voldikss/vim-translator',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org' },
  },
  {
    'Haze-sh/deepl.vim',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org' },
    config = function ()
      vim.g.deepl_endpoint = 'https://api-free.deepl.com/v2/translate'
      vim.g.deepl_auth_key = '00000000-0000-0000-0000-000000000000:fx'
    end,
  },
}
return plugins

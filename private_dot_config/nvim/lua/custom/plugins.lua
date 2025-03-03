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
    'cameron-wags/rainbow_csv.nvim',
    config = true,
    ft = {
        'csv',
        'tsv',
        'csv_semicolon',
        'csv_whitespace',
        'csv_pipe',
        'rfc_csv',
        'rfc_semicolon'
    },
    cmd = {
        'RainbowDelim',
        'RainbowDelimSimple',
        'RainbowDelimQuoted',
        'RainbowMultiDelim'
    }
  },
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
    'huggingface/llm.nvim',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org', 'python', 'cpp', 'html' },
    -- lazy = false,
    opts = {
        model = "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
        -- model = "meta-llama/Meta-Llama-3.1-70B-Instruct",
        -- model = "codellama/CodeLlama-13b-hf",
        -- model = "deepseek-ai/deepseek-coder-7b-base-v1.5",
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
          repository = "deepseek-ai/DeepSeek-R1-Distill-Qwen-32B",
          -- repository = "meta-llama/Meta-Llama-3.1-70B-Instruct",
          -- repository = "codellama/CodeLlama-13b-hf",
          -- repository = "bigcode/starcoder",
        },
        enable_suggestions_on_startup = false,
        enable_suggestions_on_files = "*",
    },
  },
  {
    'olimorris/codecompanion.nvim',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org', 'python', 'cpp', 'html' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      {
        'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function ()
      require("codecompanion").setup({
        adapters = {
          llama3 = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "llama3", -- Ensure the model is differentiated from Ollama
              schema = {
                model = {
                  default = "llama3:latest",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
          agent = { adapter = "ollama" },
        },
        default_prompts = {
          ['translate to english'] = {
            strategy = "inline",
            description = 'Translate the selected text',
            opts = {
              mapping = "<LocalLeader>ch"
            },
            prompts = {
              {
                role = "system",
                content = "You are a translator",
              },
              {
                role = "user_header",
                content = "Please translate this text to English. Return the translation only and no markdown codeblocks",
              },
            },
          },
        },
      })
    end
  },
  {
    'yetone/avante.nvim',
      event = "VeryLazy",
      lazy = false,
      version = false, -- set this if you want to always pull the latest change
      opts = {
        -- add any opts here
      },
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      build = "make",
      -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
      dependencies = {
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
        "zbirenbaum/copilot.lua", -- for providers='copilot'
        {
          -- support for image pasting
          "HakonHarnes/img-clip.nvim",
          event = "VeryLazy",
          opts = {
            -- recommended settings
            default = {
              embed_image_as_base64 = false,
              prompt_for_file_name = false,
              drag_and_drop = {
                insert_mode = true,
              },
              -- required for Windows users
              use_absolute_path = true,
            },
          },
        },
        {
          -- Make sure to set this up properly if you have lazy=true
          'MeanderingProgrammer/render-markdown.nvim',
          opts = {
            file_types = { "markdown", "Avante" },
          },
          ft = { "markdown", "Avante" },
        },
      },
  },
  -- Translations
  {
    'voldikss/vim-translator',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org' },
  },
}
return plugins

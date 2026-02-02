return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- require "configs.lspconfig"
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
    'wllfaria/ledger.nvim',
    -- tree sitter needs to be loaded before ledger.nvim loads
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    config = function()
      require('ledger').setup()
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
  -- {
  --   'Haze-sh/tasks-conceal.vim',
  --   ft = 'markdown',
  -- },
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
    "yetone/avante.nvim",
      -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
      -- ⚠️ must add this setting! ! !
      build = vim.fn.has("win32")
          and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
          or "make",
      event = "VeryLazy",
      version = false, -- Never set this value to "*"! Never!
      ---@module 'avante'
      ---@type avante.Config
      opts = {
        -- add any opts here
        -- for example
        provider = "claude",
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-20250514",
            timeout = 30000, -- Timeout in milliseconds
              extra_request_body = {
                temperature = 0.75,
                max_tokens = 20480,
              },
          },
          moonshot = {
            endpoint = "https://api.moonshot.ai/v1",
            model = "kimi-k2-0711-preview",
            timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 32768,
            },
          },
        },
      },
      dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        --- The below dependencies are optional,
        "echasnovski/mini.pick", -- for file_selector provider mini.pick
        "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
        "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
        "ibhagwan/fzf-lua", -- for file_selector provider fzf
        "stevearc/dressing.nvim", -- for input provider dressing
        "folke/snacks.nvim", -- for input provider snacks
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
  -- {
  --   'ravitemer/mcphub.nvim',
  --   dependencies = {
  --       "nvim-lua/plenary.nvim",
  --   },
  --   build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
  --   config = function()
  --       require("mcphub").setup()
  --   end
  -- },
  {
    "ravitemer/mcphub.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    build = "npm install -g mcp-hub@latest",  -- Installs `mcp-hub` node binary globally
    config = function()
        require("mcphub").setup({
            --- `mcp-hub` binary related options-------------------
            config = vim.fn.expand("~/.config/mcphub/servers.json"), -- Absolute path to MCP Servers config file (will create if not exists)
            port = 37373, -- The port `mcp-hub` server listens to
            shutdown_delay = 5 * 60 * 000, -- Delay in ms before shutting down the server when last instance closes (default: 5 minutes)
            use_bundled_binary = false, -- Use local `mcp-hub` binary (set this to true when using build = "bundled_build.lua")
            mcp_request_timeout = 60000, --Max time allowed for a MCP tool or resource to execute in milliseconds, set longer for long running tasks
            global_env = {}, -- Global environment variables available to all MCP servers (can be a table or a function returning a table)
            workspace = {
                enabled = true, -- Enable project-local configuration files
                look_for = { ".mcphub/servers.json", ".vscode/mcp.json", ".cursor/mcp.json" }, -- Files to look for when detecting project boundaries (VS Code format supported)
                reload_on_dir_changed = true, -- Automatically switch hubs on DirChanged event
                port_range = { min = 40000, max = 41000 }, -- Port range for generating unique workspace ports
                get_port = nil, -- Optional function returning custom port number. Called when generating ports to allow custom port assignment logic
            },

            ---Chat-plugin related options-----------------
            auto_approve = false, -- Auto approve mcp tool calls
            auto_toggle_mcp_servers = true, -- Let LLMs start and stop MCP servers automatically
            extensions = {
                avante = {
                    make_slash_commands = true, -- make /slash commands from MCP server prompts
                }
            },

            --- Plugin specific options-------------------
            native_servers = {}, -- add your custom lua native servers here
            builtin_tools = {
                edit_file = {
                    parser = {
                        track_issues = true,
                        extract_inline_content = true,
                    },
                    locator = {
                        fuzzy_threshold = 0.8,
                        enable_fuzzy_matching = true,
                    },
                    ui = {
                        go_to_origin_on_complete = true,
                        keybindings = {
                            accept = ".",
                            reject = ",",
                            next = "n",
                            prev = "p",
                            accept_all = "ga",
                            reject_all = "gr",
                        },
                    },
                },
            },
            ui = {
                window = {
                    width = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    height = 0.8, -- 0-1 (ratio); "50%" (percentage); 50 (raw number)
                    align = "center", -- "center", "top-left", "top-right", "bottom-left", "bottom-right", "top", "bottom", "left", "right"
                    relative = "editor",
                    zindex = 50,
                    border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
                },
                wo = { -- window-scoped options (vim.wo)
                    winhl = "Normal:MCPHubNormal,FloatBorder:MCPHubBorder",
                },
            },
            json_decode = nil, -- Custom JSON parser function (e.g., require('json5').parse for JSON5 support)
            on_ready = function(hub)
                -- Called when hub is ready
            end,
            on_error = function(err)
                -- Called on errors
            end,
            log = {
                level = vim.log.levels.WARN,
                to_file = false,
                file_path = nil,
                prefix = "MCPHub",
            },
        })
    end
  },
  -- Translations
  {
    'voldikss/vim-translator',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org' },
  },

}

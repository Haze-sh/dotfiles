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
      require "configs.lspconfig"
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
  {
    'karb94/neoscroll.nvim',
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

  -- Translations
  {
    'voldikss/vim-translator',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org' },
  },

  -- AI
  {
    'olimorris/codecompanion.nvim',
    ft = { 'txt', 'tex', 'bib', 'markdown' , 'org', 'python', 'cpp', 'html' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim',
      'ravitemer/mcphub.nvim',
      {
        'stevearc/dressing.nvim', -- Optional: Improves the default Neovim UI
        opts = {},
      },
    },
    config = function ()
      require("codecompanion").setup({
        interactions = {
          chat = { adapter = "ollama" },
          inline = { adapter = "ollama" },
          agent = { adapter = "ollama" },
        },
        prompt_library = {
          markdown = {
            dirs = {
              vim.fn.getcwd() .. "~/.config/codecompanion_prompts",
            },
          },
        },
        extensions = {
          mcphub = {
            callback = "mcphub.extensions.codecompanion",
            opts = {
              -- MCP Tools
              make_tools = true,              -- Make individual tools (@server__tool) and server groups (@server) from MCP servers
              show_server_tools_in_chat = true, -- Show individual tools in chat completion (when make_tools=true)
              add_mcp_prefix_to_tool_names = false, -- Add mcp__ prefix (e.g `@mcp__github`, `@mcp__neovim__list_issues`)
              show_result_in_chat = true,      -- Show tool results directly in chat buffer
              format_tool = nil,               -- function(tool_name:string, tool: CodeCompanion.Agent.Tool) : string Function to format tool names to show in the chat buffer
              -- MCP Resources
              make_vars = false,                -- Convert MCP resources to #variables for prompts
              -- MCP Prompts
              make_slash_commands = true,      -- Add MCP prompts as /slash commands
            }
          }
        },
      })
    end
  },
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
}

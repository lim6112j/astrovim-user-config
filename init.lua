-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 1.0
vim.g.neovide_background_color = "#0f1117" .. alpha()
vim.o.guifont = "Hack Nerd Font Mono:h16"
-- fsharp 쓸때 ionide가 빈줄에서 32603 에러를 쏟아내는거 방지
vim.g["fsharp#show_signature_on_cursor_move"] = 0
vim.g["fsharp#lsp_auto_setup"] = 0
vim.g["fsharp#workspace_mode_peek_deep_level"] = 4
-- vim.g.fsharp#show_signature_on_cursor_move = 0
-- cursor line
function Pain()
    local colors = {
        bg = "#202328",
        fg = "#bbc2cf",
        yellow = "#ECBE7B",
        cyan = "#008080",
        darkblue = "#081633",
        green = "#3d5122",
        darkgreen = "#156339",
        orange = "#FF8800",
        violet = "#a9a1e1",
        magenta = "#c678dd",
        blue = "#51afef",
        red = "#6f3328"
    }

    local mode_color = {
        n = colors.darkgreen,
        i = colors.green,
        v = colors.yellow,
        V = colors.blue,
        c = colors.magenta,
        no = colors.red,
        s = colors.orange,
        S = colors.orange,
        ic = colors.yellow,
        R = colors.violet,
        Rv = colors.violet,
        cv = colors.red,
        ce = colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        tr = colors.red
    }
    local color = mode_color[vim.api.nvim_get_mode().mode]
    if color == nil then color = "NONE" end
    print(vim.api.nvim_get_mode().mode)
    vim.api.nvim_command("hi! CursorLine guifg=NONE guibg=" .. color)
end

vim.api.nvim_command([[autocmd ModeChanged * lua Pain()]])

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
        vim.keymap.set('n', "<Leader>la", vim.lsp.buf.code_action, { buffer = args.buf })
        vim.keymap.set('n', "]d", vim.diagnostic.goto_next, { buffer = args.buf })
        vim.keymap.set('n', "[d", vim.diagnostic.goto_prev, { buffer = args.buf })
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = args.buf })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = args.buf })
    end,
})
return {
    plugins = {
        -- {
        --     "aMOPel/nvim-treesitter-nim",
        --     run = { ':TSUpdate nim', ':TSUpdate nim_format_string' }
        -- },
        {
            'akinsho/flutter-tools.nvim',
            lazy = false,
            dependencies = {
                'nvim-lua/plenary.nvim',
                'stevearc/dressing.nvim', -- optional for vim.ui.select
            },
            config = true,
        },
        -- {
        --     "neovim/nvim-lspconfig",
        --     opts = function()
        --         require("lspconfig").dartls.setup({
        --             cmd = { "dart", "language-server", "--protocol=lsp" }
        --         })
        --     end
        -- },
        {
          -- nvim v0.8.0
            "kdheepak/lazygit.nvim",
    	    cmd = {
    		    "LazyGit",
    		    "LazyGitConfig",
    		    "LazyGitCurrentFile",
    		    "LazyGitFilter",
    		    "LazyGitFilterCurrentFile",
    	    },
            -- optional for floating window border decoration
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        },
        { "vim-scripts/paredit.vim",        lazy = false }, {
        "kylechui/nvim-surround",
        lazy = false,
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    }, { 'christoomey/vim-tmux-navigator', lazy = false },
        { 'ionide/Ionide-vim',              lazy = false }, {
        'nvim-orgmode/orgmode',
        lazy = false,
        config = function()
            require("orgmode").setup_ts_grammar()
            require("orgmode").setup({
                org_agenda_files = { '~/org/*', '~/org/**/*' },
                org_default_notes_file = '~/org/refile.org',
                org_foldenabled = false,
                org_folding = { '<TAB>' },
                org_todo_keywords = {
                    'TODO', 'WAITING', '|', 'DONE', 'DELEGATED'
                },
                -- mappings = {
                -- disable_all = true
                -- },
                org_todo_keyword_faces = {
                    WAITING = ':foreground blue :weight bold',
                    DELEGATED = ':background #FFFFFF :slant italic :underline on',
                    TODO = ':background #000000 :foreground red' -- overrides builtin color for `TODO` keyword
                }
            })
        end
    }, {
        "nvim-telescope/telescope.nvim",
        lazy = false,
        config = function()
            local actions = require "telescope.actions"
            local get_icon = require("astronvim.utils").get_icon
            require('telescope').setup {
                -- defaults = {
                --     file_ignore_patterns = {
                --         "node_modules", "dist", ".git", ".parcel-cache", "*.lock",
                --     }
                -- }
                defaults = {

                    git_worktrees = vim.g.git_worktrees,
                    prompt_prefix = get_icon("Selected", 1),
                    selection_caret = get_icon("Selected", 1),
                    path_display = { "truncate" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55
                        },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120
                    },
                    mappings = {
                        i = {
                            ["<C-n>"] = actions.cycle_history_next,
                            ["<C-p>"] = actions.cycle_history_prev,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-k>"] = actions.move_selection_previous
                        },
                        n = { q = actions.close }
                    },
                    vimgrep_arguments = {
                        'rg', '--color=never', '--no-heading',
                        '--with-filename', '--line-number', '--column',
                        '--smart-case', '--ignore-file', '.gitignore'
                    }
                }
            }
        end
    },
        {
            "scalameta/nvim-metals",
            dependencies = {
                "nvim-lua/plenary.nvim",
                {
                    "mfussenegger/nvim-dap",
                    config = function(self, opts)
                        -- Debug settings if you're using nvim-dap
                        local dap = require("dap")

                        dap.configurations.scala = {
                            {
                                type = "scala",
                                request = "launch",
                                name = "RunOrTest",
                                metals = {
                                    runType = "runOrTestFile",
                                    --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
                                },
                            },
                            {
                                type = "scala",
                                request = "launch",
                                name = "Test Target",
                                metals = {
                                    runType = "testTarget",
                                },
                            },
                        }
                    end
                },
            },
            ft = { "scala", "sbt", "java" },
            opts = function()
                local metals_config = require("metals").bare_config()

                -- Example of settings
                metals_config.settings = {
                    showImplicitArguments = true,
                    excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
                }

                -- *READ THIS*
                -- I *highly* recommend setting statusBarProvider to true, however if you do,
                -- you *have* to have a setting to display this in your statusline or else
                -- you'll not see any messages from metals. There is more info in the help
                -- docs about this
                -- metals_config.init_options.statusBarProvider = "on"

                -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
                metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

                metals_config.on_attach = function(client, bufnr)
                    require("metals").setup_dap()

                    -- LSP mappings
                    map("n", "gD", vim.lsp.buf.definition)
                    map("n", "K", vim.lsp.buf.hover)
                    map("n", "gi", vim.lsp.buf.implementation)
                    map("n", "gr", vim.lsp.buf.references)
                    map("n", "gds", vim.lsp.buf.document_symbol)
                    map("n", "gws", vim.lsp.buf.workspace_symbol)
                    map("n", "<leader>cl", vim.lsp.codelens.run)
                    map("n", "<leader>sh", vim.lsp.buf.signature_help)
                    map("n", "<leader>rn", vim.lsp.buf.rename)
                    map("n", "<leader>f", vim.lsp.buf.format)
                    map("n", "<leader>ca", vim.lsp.buf.code_action)

                    map("n", "<leader>ws", function()
                        require("metals").hover_worksheet()
                    end)

                    -- all workspace diagnostics
                    map("n", "<leader>aa", vim.diagnostic.setqflist)

                    -- all workspace errors
                    map("n", "<leader>ae", function()
                        vim.diagnostic.setqflist({ severity = "E" })
                    end)

                    -- all workspace warnings
                    map("n", "<leader>aw", function()
                        vim.diagnostic.setqflist({ severity = "W" })
                    end)

                    -- buffer diagnostics only
                    map("n", "<leader>d", vim.diagnostic.setloclist)

                    map("n", "[c", function()
                        vim.diagnostic.goto_prev({ wrap = false })
                    end)

                    map("n", "]c", function()
                        vim.diagnostic.goto_next({ wrap = false })
                    end)

                    -- Example mappings for usage with nvim-dap. If you don't use that, you can
                    -- skip these
                    map("n", "<leader>dc", function()
                        require("dap").continue()
                    end)

                    map("n", "<leader>dr", function()
                        require("dap").repl.toggle()
                    end)

                    map("n", "<leader>dK", function()
                        require("dap.ui.widgets").hover()
                    end)

                    map("n", "<leader>dt", function()
                        require("dap").toggle_breakpoint()
                    end)

                    map("n", "<leader>dso", function()
                        require("dap").step_over()
                    end)

                    map("n", "<leader>dsi", function()
                        require("dap").step_into()
                    end)

                    map("n", "<leader>dl", function()
                        require("dap").run_last()
                    end)
                end

                return metals_config
            end,
            config = function(self, metals_config)
                local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
                vim.api.nvim_create_autocmd("FileType", {
                    pattern = self.ft,
                    callback = function()
                        require("metals").initialize_or_attach(metals_config)
                    end,
                    group = nvim_metals_group,
                })
            end

        }
    }
}

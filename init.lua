vim.o.guifont = "Hack Nerd Font Mono:h20"

return {
    plugins = {
        { "vim-scripts/paredit.vim",        lazy = false }, {
        "kylechui/nvim-surround",
        lazy = false,
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
        { 'christoomey/vim-tmux-navigator', lazy = false },
        { 'ionide/Ionide-vim',              lazy = false },
        {
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
        }
    }
}

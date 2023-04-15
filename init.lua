return {
    plugins = {
        {
            "kylechui/nvim-surround",
            lazy = false,
            config = function()
                require("nvim-surround").setup({
                    -- Configuration here, or leave empty to use defaults
                })
            end
        }, {'christoomey/vim-tmux-navigator', lazy = false}, {
            'nvim-orgmode/orgmode',
            lazy = false,
            config = function()
                require("orgmode").setup_ts_grammar()
                require("orgmode").setup({
                    org_agenda_files = {'~/org/*'},
                    org_default_notes_file = '~/org/refile.org'
                })
            end
        }
    }
}

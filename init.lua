-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 1.0
vim.g.neovide_background_color = "#0f1117" .. alpha()
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
    }
    }
}

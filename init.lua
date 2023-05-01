-- Helper function for transparency formatting
local alpha = function()
    return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
end
-- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
vim.g.neovide_transparency = 0.0
vim.g.transparency = 1.0
vim.g.neovide_background_color = "#0f1117" .. alpha()
vim.o.guifont = "Hack Nerd Font Mono:h20"
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
                    TODO = ':background #000000 :foreground red'     -- overrides builtin color for `TODO` keyword
                }
            })
        end
    }
    }
}

return {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        styles = {
            -- floats = "transparent",
            -- sidebars = "transparent",
        },
    },
    init = function()
        vim.cmd.colorscheme("tokyonight")
        -- TODO: checkout nvim_set_hl and highlight-groups
        -- normal background (during text editing)
        -- vim.cmd.highlight("Normal guibg=none")
        vim.cmd.highlight("LineNr guibg=dark")
        -- idk
        -- vim.cmd.highlight("NonText guibg=none")
        --
        -- vim.cmd.highlight("Normal ctermbg=none")
        -- vim.cmd.highlight("NonText ctermbg=none")
    end
}

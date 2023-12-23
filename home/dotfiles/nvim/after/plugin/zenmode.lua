require("zen-mode").setup {
    window = {
        width = 160,
        options = {
            number = true,
            relativenumber = true,
        }
    },
}

vim.keymap.set("n", "<leader>zz", function()
    require("zen-mode").toggle()
    vim.wo.wrap = false
    ColorMyPencils()
end)

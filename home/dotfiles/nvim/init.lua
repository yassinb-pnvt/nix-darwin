vim.g.mapleader = " "

require("config.lazy")

vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<leader>x", ":.lua<CR>")
vim.keymap.set("v", "<leader>x", ":lua<CR>")

-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")
--
-- vim.keymap.set("n", "n", "nzzzv")
-- keymap.set("n", "N", "Nzzzv")
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "Q", "<nop>", { desc = "I hate this and never used it. Ever." })
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("x", "<leader>d", "\"_d")

vim.opt.relativenumber = true
vim.opt.nu = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"
vim.opt.clipboard = "unnamedplus"

-- additional filetypes
vim.filetype.add({
    extension = {
        templ = "templ",
    },
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking test",
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

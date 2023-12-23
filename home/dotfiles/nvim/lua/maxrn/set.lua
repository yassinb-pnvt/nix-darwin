local opts = {
    guicursor = "",
    relativenumber = true,

    nu = true,

    tabstop = 4,
    softtabstop = 4,
    shiftwidth = 4,
    expandtab = true,

    smartindent = true,

    wrap = false,

    swapfile = false,
    backup = false,
    undodir = os.getenv("HOME") .. "/.vim/undodir",
    undofile = true,

    hlsearch = false,
    incsearch = true,

    termguicolors = true,

    scrolloff = 8,
    signcolumn = "yes",

    updatetime = 50,

    colorcolumn = "80"
}

vim.opt.isfname:append("@-@")
vim.g.mapleader = " "

vim.opt.background = "dark"

for opt, val in pairs(opts) do
    vim.opt[opt] = val
end

-- Restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    callback = function()
        vim.api.nvim_exec('silent! normal! g`"zv', false)
    end,
})

vim.api.nvim_set_hl(0, "Normal", {guibg=NONE, ctermbg=NONE})

-- additional filetypes
vim.filetype.add({
 extension = {
  templ = "templ",
 },
})

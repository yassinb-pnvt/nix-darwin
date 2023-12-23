vim.g.mapleader = " "
vim.keymap.set("n", "<leader>ej", vim.cmd.Ex) vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- greatest remap ever from prime
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland from prime
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- vim.keymap.set("n", "<leader>f", "<cmd>Format<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>lua vim.lsp.buf.format()<CR>")

-- this requires you to set Option as Esc+ in iTerm settings
vim.keymap.set("n", "<M-j>", "<cmd>cnext<CR>zz")
-- this requires you to set Option as Esc+ in iTerm settings
vim.keymap.set("n", "<M-k>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("i", "<C-o>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

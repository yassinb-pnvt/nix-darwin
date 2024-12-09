vim.g.mapleader = " "

require("config.lazy")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", ":W", "w")

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "q:", ":q", { desc = "I'm monke and sometimes misstype." })

local function file_exists(name)
	local f = io.open(name, "r")
	return f ~= nil and io.close(f)
end

local function switch_header_impl()
	local bufName = vim.api.nvim_buf_get_name(0)
	print("buf name is: " .. bufName)

	local isHeaderFile = string.match(bufName, ".h$")
	if isHeaderFile then
		-- try and get C file, if not exist try and get cc file, if not exist try and get cpp file
		local newFileName = string.gsub(bufName, ".h$", ".c")
		if file_exists(newFileName) then
			vim.cmd.edit(newFileName)
			return
		end
		newFileName = string.gsub(bufName, ".h$", ".cc")
		if file_exists(newFileName) then
			vim.cmd.edit(newFileName)
			return
		end
		newFileName = string.gsub(bufName, ".h$", ".cpp")
		if file_exists(newFileName) then
			vim.cmd.edit(newFileName)
			return
		end
	end

	local isC = string.match(bufName, ".c$")
	local isCc = string.match(bufName, ".cc$")
	local isCpp = string.match(bufName, ".cpp$")
	local isSourceFile = isC or isCc or isCpp
	if isSourceFile then
		print("is source file!")
		local newFileName = string.gsub(bufName, "%..*$", ".h")
		print("new file name is: " .. newFileName)
		if file_exists(newFileName) then
			vim.cmd.edit(newFileName)
			return
		else
			print("file does not exist!")
		end
	end
end

vim.keymap.set("n", "<leader>gh", switch_header_impl)

local function goto_properties()
	local bufName = vim.api.nvim_buf_get_name(0)
	local _, _, serviceName = string.find(bufName, "(%a+)-service")
	if serviceName then
		local valuesName = string.gsub(bufName, "deploy/", serviceName .. "/src/main/resources/")
		valuesName = string.gsub(valuesName, "yaml", "properties")
		valuesName = string.gsub(valuesName, "values", "application")
		vim.cmd.edit(valuesName)
	else
		print("no service name!")
	end
end

vim.keymap.set("n", "<leader>gtp", goto_properties)

local opts = {
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

	colorcolumn = "80",
	clipboard = "unnamedplus",
}

vim.opt.isfname:append("@-@")

for opt, val in pairs(opts) do
	vim.opt[opt] = val
end

-- additional filetypes
vim.filetype.add({
	extension = {
		templ = "templ",
	},
})


local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})
autocmd("TextYankPost", {
	group = yank_group,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

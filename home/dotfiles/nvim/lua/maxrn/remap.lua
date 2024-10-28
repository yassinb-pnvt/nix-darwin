vim.g.mapleader = " "
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("x", ":W", "w")
-- best remap ever
vim.api.nvim_create_user_command("W", "w", {})

-- greatest remap ever from prime
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland from prime
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")

-- this requires you to set Option as Esc+ in iTerm settings
vim.keymap.set("n", "]q", "<cmd>cnext<CR>zz")
-- this requires you to set Option as Esc+ in iTerm settings
vim.keymap.set("n", "[q", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

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

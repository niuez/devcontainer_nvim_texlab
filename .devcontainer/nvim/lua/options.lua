local options = {
	termguicolors=true,
	encoding = "utf-8",
	fileencoding = "utf-8",
	cmdheight = 0,
	laststatus = 3,
	background = "dark",
	clipboard = "unnamed,unnamedplus",
	splitbelow = true,
	conceallevel = 0,
	expandtab = true,
	tabstop = 2,
	shiftwidth = 2,
	winblend = 30,
	pumblend = 30,
	signcolumn = "yes",
	mouse = "",
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

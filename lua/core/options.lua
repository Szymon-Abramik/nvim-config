vim.g.loaded_python3_provider = 0
vim.g.loaded_node_provider = 0

-- Side number options
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabulator options
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Search Settings
vim.opt.incsearch  = true
vim.opt.hlsearch = false
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Max scroll
vim.opt.scrolloff = 8

-- Splitting options
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Visual Indicators
vim.opt.signcolumn = "yes"

-- Editor options
vim.opt.mouse = 'a'
vim.g.mapleader = " "
vim.opt.wrap = false
vim.opt.inccommand = "split"
vim.opt.termguicolors = true
vim.opt.clipboard = "unnamedplus"

-- Disable the fill chars
-- vim.cmd[[set fillchars+=eob:\ ]]

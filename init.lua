-----------------------
-- BASIC SETUP
-----------------------

vim.cmd("syntax on")
vim.o.termguicolors = true
--vim.cmd("colorscheme habamax")
vim.g.have_nerd_font = true
vim.o.mouse = "a"
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)
vim.o.breakindent = true
vim.o.undofile = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 16
vim.o.confirm = true
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")



----------------------
-- PLUGIN MANAGER
----------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- [Setup lazy.nvim]
require("lazy").setup({
  spec = {
    -- add your plugins here
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },


    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate'
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "default" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})


-- [Setup lualine.nvim]
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = '16color',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'Filetype',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}


-- [Setup Treesitter.nvim]
require'nvim-treesitter'.install { 'c', 'python', 'lua'}

vim.api.nvim_create_autocmd('FileType', {
  pattern = { '<filetype>' },
  callback = function() vim.treesitter.start() end,
})

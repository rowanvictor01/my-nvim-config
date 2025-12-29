
-----------------------
-- BASIC SETUP
-----------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.opt.termguicolors = true
vim.opt.mouse = "a"

-- Clipboard (delay to avoid startup issues)
vim.schedule(function()
  vim.opt.clipboard = "unnamedplus"
end)

-- UI / editing
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 16
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.confirm = true

-- Searching
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"

vim.g.have_nerd_font = true


-----------------------
-- PLUGIN MANAGER
-----------------------

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-----------------------
-- PLUGINS
-----------------------

require("lazy").setup({


  -- Colorscheme (load first)
  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup {
	      style = "darker"
      }
      require("onedark").load()
    end
  },


  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          icons_enabled = true,
          theme = "powerline_dark",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          globalstatus = false,
        },
      })
    end,
  },


  -- Tree-sitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        auto_install = true,

        ensure_installed = {
          "bash", "c", "html", "lua", "luadoc",
          "markdown", "markdown_inline",
          "vim", "vimdoc", "python", "javascript",
        },

        highlight = {
          enable = true,
        },

        indent = {
          enable = true,
        },
      })
    end,
  },

}, {
  checker = { enabled = true },
})

--vim.cmd.colorscheme("catppuccin-mocha")


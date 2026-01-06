
-----------------------
-- BASIC SETUP
-----------------------

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.showmode = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

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
      "catppuccin/nvim",
      name = "catppuccin",
      priority = 1000
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
      require("onedark").setup {
	      style = "darker"
      }
      --require("onedark").load()
    end
  },

  {
      "ellisonleao/gruvbox.nvim",
      priority = 1000,
      config = true,
      opts = ...,
  },

  {
      "folke/tokyonight.nvim",
      priority = 1000,
  },

  -- Harpoon
  {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      dependencies = {"nvim-lua/plenary.nvim"},

      config = function()
          local harpoon = require("harpoon")
          harpoon:setup()

          -- Add file
          vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc = "Harpoon add current buffer"})

          -- Toggle Menu
          vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

          -- File Navigation
          vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end)
          vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end)
          vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end)
          vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end)
          vim.keymap.set("n", "<leader>h5", function() harpoon:list():select(5) end)

          -- Toggle previous & next buffers stored within Harpoon list
          vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
          vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

          -- Remove current buffer from Harpoon list
          vim.keymap.set("n", "<leader>hr", function() harpoon:list():remove() end, {desc = "Harpoon remove current buffer"})

          -- Clear Harpoon list
          vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end)
      end
  },

  -- Mini.nvim
  {
  "nvim-mini/mini.nvim",
  version = false,
  config = function()
    local mf = require("mini.files")

    mf.setup()
    require("mini.cursorword").setup()

    -- Toggle MiniFiles
    vim.keymap.set("n", "<leader>mf", function()
      if mf.get_explorer_state() then
        mf.close()
      else
        mf.open()
      end
    end, { desc = "Toggle MiniFiles" })

    -- Close MiniFiles with <Esc>
    local function map_esc(buf)
      if not buf then return end
      vim.keymap.set("n", "<Esc>", function()
        mf.close()
      end, { buffer = buf, silent = true })
    end

    vim.api.nvim_create_autocmd("User", {
      pattern = { "MiniFilesExplorerOpen", "MiniFilesBufferCreate" },
      callback = function(args)
        local buf = args.buf or (args.data and args.data.buf_id)
        map_esc(buf)
      end,
    })
  end,
	  vim.keymap.set("n", "<leader>mf", "<cmd>lua MiniFiles.open()<CR>")
  },

  -- LSP
  {
	  "neovim/nvim-lspconfig",
	  vim.lsp.enable("clangd"),
	  vim.lsp.enable("lua_ls"),
	  vim.lsp.enable("pyright"),
	  vim.lsp.enable("ts_ls"),
	  vim.lsp.enable("vue_ls"),
	  vim.lsp.enable("svelte"),
	  vim.lsp.enable("tailwindcss"),
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

  {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
      opts = {}
  },

}, {
  checker = { enabled = true },
})

--vim.o.background = "dark"
vim.cmd.colorscheme("catppuccin-mocha")
--vim.cmd.colorscheme("tokyonight-night")
--vim.cmd.colorscheme("gruvbox")


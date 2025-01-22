vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- completetion
  use 'neovim/nvim-lsp'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/nvim-cmp'
  use "rafamadriz/friendly-snippets"
  use 'hrsh7th/vim-vsnip'

  -- editing
  use 'sheerun/vim-polyglot'
  use "McAuleyPenney/tidy.nvim"
  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'
  use 'tpope/vim-commentary'
  use 'mattn/emmet-vim'
  use 'tpope/vim-unimpaired'

  -- ui
  use 'junegunn/vim-peekaboo'
  use 'chriskempson/base16-vim'
  use 'itchyny/lightline.vim'
  use 'daviesjamie/vim-base16-lightline'
  use 'justinmk/vim-sneak'
  use 'christoomey/vim-tmux-navigator'

  -- files
  use 'tpope/vim-eunuch'
  use 'justinmk/vim-dirvish'

  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use { "nvim-neotest/neotest",
    requires = {
      "vim-test/vim-test",
      "nvim-treesitter/nvim-treesitter",
      'nvim-lua/plenary.nvim',
    },
    run = ":UpdateRemotePlugins"
  }

  use {
    'TimUntersberger/neogit',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require('neogit').setup({})
    end
  }
  use "sindrets/diffview.nvim"
  use 'lewis6991/gitsigns.nvim'

  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
      }
    end
  }

  use {
    'gelguy/wilder.nvim',
    config = function()
      -- config goes here
    end,
  }
end)

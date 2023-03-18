vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }

  use({ 'rose-pine/neovim', as = 'rose-pine' })
  use({ "catppuccin/nvim", as = "catppuccin" })

  use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
  use('nvim-treesitter/playground')
  use('mbbill/undotree')

  -- TPOPE
  use('tpope/vim-vinegar')
  use('tpope/vim-commentary')
  use('tpope/vim-surround')
  use('tpope/vim-repeat')
  use('tpope/vim-fugitive')
  use('tpope/vim-eunuch')

  -- Custom text objects
  use('kana/vim-textobj-user')
  use('kana/vim-textobj-line')           -- [dcy]il, [dcy]al
  use('kana/vim-textobj-entire')         -- [dcy]ie, [dcy]ae
  use('michaeljsmith/vim-indent-object') -- [dcy]ii, [dcy]ai, [dcy]aI

  -- Notifications
  use('rcarriga/nvim-notify')

  -- Replace with register
  use('vim-scripts/ReplaceWithRegister')

  -- Close XML tags
  use('alvan/vim-closetag')

  -- Kill buffers
  use('qpkorr/vim-bufkill')

  -- LSP
  use({
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },             -- Required
      { 'williamboman/mason.nvim' },           -- Optional
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp', },        -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'hrsh7th/cmp-nvim-lua' },     -- Optional

      -- Snippets
      { 'L3MON4D3/LuaSnip' }, -- Required
    }
  })

  -- Prettier LSP
  use('jose-elias-alvarez/null-ls.nvim')

  use {
    "windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
  }
end)

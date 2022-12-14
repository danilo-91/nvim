--aliases
local fn = vim.fn

--packer bootstrap(si no está, instala packer)
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({
    'git',
    'clone',
    '--depth', '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path
  })
  print 'Installing Packer, please close and reopen Neovim'
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand que reloadea nvim cuando guardas plugins.lua
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- llamado protegido (protected call)
-- en lugar de hacer require('packer')
-- se usa pcall (protected call) y se captura el error si falla
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- que packer use una ventana propia
packer.init {
  display = {
    open_fn = function()
      return require('packer.util').float { border = "rounded" }
    end,
  },
}

--cargar plugins
return packer.startup(function(use)
  -- Plugins a cargar
  -- Packer
  use 'wbthomason/packer.nvim'

  -- varios plugins dependen de estos dos
  use 'nvim-lua/popup.nvim' -- implementación de Popup API
  use 'nvim-lua/plenary.nvim' -- funciones útiles de lua usadas en varios plugins

  -- Treesitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }

  --theme
  use 'folke/tokyonight.nvim'

  --autocmp
  use 'hrsh7th/nvim-cmp'         --completion plugin
  use 'hrsh7th/cmp-buffer'       --buffer completion
  use 'hrsh7th/cmp-path'         --path completion
  use 'hrsh7th/cmp-cmdline'      --cmdline completion
  use 'saadparwaiz1/cmp_luasnip' --snippet completion
  use "hrsh7th/cmp-nvim-lsp"     --lsp completion

  --snippets
  use 'L3MON4D3/LuaSnip'             --snippet engine
  use 'rafamadriz/friendly-snippets' --bunch of snippets to use

  --LSP
  use "neovim/nvim-lspconfig"             --enable LSP
  use "williamboman/mason.nvim"           --simple to use language server installer
  use "williamboman/mason-lspconfig.nvim" --simple to use language server installer

  --Telescope
  use 'nvim-telescope/telescope.nvim' --Telescope plugin
  use 'nvim-telescope/telescope-media-files.nvim' --plugin for Telescope

  --para packer bootstrap
  if packer_bootstrap then
    require('packer').sync()
  end
end)


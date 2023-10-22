--[[
{{{

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, understand
  what your configuration is doing, and modify it to suit your needs.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
}}}
--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Marks {{{
vim.g.mwDefaultHighlightingPalette = {
  { ctermbg = "226", ctermfg = "black", guibg = "#ffff00", guifg = "black" },
  { ctermbg = "196", ctermfg = "black", guibg = "#ff0000", guifg = "black" },
  { ctermbg = "21" , ctermfg = "white", guibg = "#0030ff", guifg = "white" },
  { ctermbg = "46" , ctermfg = "black", guibg = "#00ff00", guifg = "black" },
  { ctermbg = "201", ctermfg = "black", guibg = "#ff00ff", guifg = "black" },
  { ctermbg = "51" , ctermfg = "black", guibg = "#00ffff", guifg = "black" },
  { ctermbg = "88" , ctermfg = "white", guibg = "#870000", guifg = "white" },
  { ctermbg = "208", ctermfg = "black", guibg = "#ff8700", guifg = "black" },
  { ctermbg = "18" , ctermfg = "white", guibg = "#003087", guifg = "white" },
  { ctermbg = "22" , ctermfg = "white", guibg = "#005f00", guifg = "white" },
  { ctermbg = "90" , ctermfg = "white", guibg = "#870087", guifg = "white" },
  { ctermbg = "36" , ctermfg = "black", guibg = "#00af87", guifg = "black" },
  { ctermbg = "239", ctermfg = "white", guibg = "#4e4e4e", guifg = "white" },
  { ctermbg = "202", ctermfg = "black", guibg = "#ff5f00", guifg = "black" },
  { ctermbg = "131", ctermfg = "black", guibg = "#af5f5f", guifg = "black" },
  { ctermbg = "113", ctermfg = "black", guibg = "#87d75f", guifg = "black" },
  { ctermbg = "71" , ctermfg = "white", guibg = "#5faf5f", guifg = "white" },
  { ctermbg = "192", ctermfg = "black", guibg = "#d7ff87", guifg = "black" },
  { ctermbg = "99" , ctermfg = "white", guibg = "#875fff", guifg = "white" },
  { ctermbg = "168", ctermfg = "white", guibg = "#d75f87", guifg = "white" },
  { ctermbg = "231", ctermfg = "black", guibg = "#ffffff", guifg = "black" },
  { ctermbg = "227", ctermfg = "black", guibg = "#ffff5f", guifg = "black" },
  { ctermbg = "49" , ctermfg = "black", guibg = "#00ffaf", guifg = "black" },
  { ctermbg = "154", ctermfg = "black", guibg = "#afff00", guifg = "black" }
}
-- }}} Marks

-- Install package manager {{{
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
-- }}}

-- Plugins {{{
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  --   {
  --     -- Adds git releated signs to the gutter, as well as utilities for managing changes
  --     'lewis6991/gitsigns.nvim',
  --     opts = {
  --       -- See `:help gitsigns.txt`
  --       signs = {
  --         add = { text = '+' },
  --         change = { text = '~' },
  --         delete = { text = '_' },
  --         topdelete = { text = '‾' },
  --         changedelete = { text = '~' },
  --       },
  -- 
  --       on_attach = function(bufnr)
  --         vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
  --         vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
  --         vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
  --       end,
  -- 
  --       --[[ {{{
  --       on_attach = function(bufnr)
  --         if vim.api.nvim_buf_get_name(bufnr):match('<PATTERN>') then
  --           -- Don't attach to specific buffers whose name matches a pattern
  --           return false
  --         end
  -- 
  --         -- Setup keymaps
  --         --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {})
  --         vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', require('gitsigns').stage_hunk, { desc = '[H]unk [S]tage' })
  --       end,
  --       --]]
  --       --}}}
  -- 
  --       -- From: https://github.com/omerxx/dotfiles/blob/master/nvim/init.lua {{{
  --       --       https://www.youtube.com/watch?v=IyBAuDPzdFY
  --       --[[
  --       on_attach = function(bufnr)
  --         local gs = package.loaded.gitsigns
  -- 
  --         local function map(mode, l, r, opts)
  --           opts = opts or {}
  --           opts.buffer = bufnr
  --           vim.keymap.set(mode, l, r, opts)
  --         end
  -- 
  --         -- Navigation
  --         map('n', ']c', function()
  --           if vim.wo.diff then return ']c' end
  --           vim.schedule(function() gs.next_hunk() end)
  --           return '<Ignore>'
  --         end, {expr=true, desc='next hunk'})
  -- 
  --         map('n', '[c', function()
  --           if vim.wo.diff then return '[c' end
  --           vim.schedule(function() gs.prev_hunk() end)
  --           return '<Ignore>'
  --         end, {expr=true, desc='previous hunk'})
  -- 
  --         -- Actions
  --         map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
  --         map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
  --         map('n', '<leader>hS', gs.stage_buffer, {desc='stage buffer'})
  --         map('n', '<leader>ha', gs.stage_hunk, {desc='stage hunk'})
  --         map('n', '<leader>hu', gs.undo_stage_hunk, {desc='undo_stage_hunk'})
  --         map('n', '<leader>hR', gs.reset_buffer, {desc='reset_buffer'})
  --         map('n', '<leader>hp', gs.preview_hunk, {desc='preview_hunk'})
  --         map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc='blame_line'})
  --         map('n', '<leader>tb', gs.toggle_current_line_blame, {desc='toggle_current_line_blame'})
  --         map('n', '<leader>hd', gs.diffthis, {desc='diffthis'})
  --         map('n', '<leader>hD', function() gs.diffthis('~') end, {desc='diffthis ~'})
  --         map('n', '<leader>td', gs.toggle_deleted, {desc='toggle_deleted'})
  -- 
  --         -- Text object
  --         map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  --       end,
  --       --]]
  --       --}}}
  --     },
  --   },
  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>hp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({'n', 'v'}, ']c', function()
          if vim.wo.diff then return ']c' end
          vim.schedule(function() gs.next_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to next hunk"})
        vim.keymap.set({'n', 'v'}, '[c', function()
          if vim.wo.diff then return '[c' end
          vim.schedule(function() gs.prev_hunk() end)
          return '<Ignore>'
        end, {expr=true, buffer = bufnr, desc = "Jump to previous hunk"})
      end,
    },
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      vim.api.nvim_set_var('onedark_config', { style = 'dark', transparent = 'true' })
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
        path = 1,
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    main = "ibl",
    opts = {
       -- indent = { char = "▏" },
       -- indent = { char = "┆" },
       -- indent = { char = "│" }, -- box drawings light vertical
       -- indent = { char = "⸾" }, -- wiggly vertical line
       -- indent = { char = "⁞" }, -- vertical four dots
       -- indent = { char = "⸽" }, -- vertical six dots
       -- indent = { char = "⎸" }, -- left vertical box line
       -- indent = { char = "⎹" }, -- right vertical box line
       -- indent = { char = "|" }, -- vertical line
       -- indent = { char = "┊" }, -- box drawings light quadruple dash vertical
       -- indent = { char = "⋮" }, -- vertical ellipsis
       indent = { char = "╎" }, -- box drawings light double dash vertical
       -- indent = { char = "￨" }, -- halfwidth forms light vertical
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- vim-mark
  { 'inkarkat/vim-mark',
    dependencies = {
      'inkarkat/vim-ingo-library' -- needed by vim-mark
    },
    config = function()
      -- enable the automatic restore of marks from a previous Vim session.
      vim.api.nvim_set_var('mwAutoLoadMarks', 1)
      -- In Mark plugin, replace conflicting maps.
      -- Don't use \n and \# used by NerdTree.  Replace with ,,n and ,,#.
      -- Don't use \r used by coc, replace with ,,r.
      vim.keymap.set('n', '\\c', "<Plug>MarkClear")
      vim.keymap.set('n', '\\p', "<Plug>MarkSearchCurrentPrev")
      vim.keymap.set('x', '\\X', "<Plug>MarkRegex")
      vim.keymap.set('n', '\\X', "<Plug>MarkRegex")
      vim.keymap.set('n', '\\?', "<Plug>MarkSearchAnyPrev")
      vim.keymap.set('n', '\\/', "<Plug>MarkSearchAnyNext")
      vim.keymap.set('n', '\\*', "<Plug>MarkSearchCurrentNext")
      vim.keymap.set('x', '\\m', "<Plug>MarkSet")
      vim.keymap.set('n', '\\m', "<Plug>MarkSet")
    end,
  },

  -- Show colors (#abcdef, red, etc) in CSS files.
  'ap/vim-css-color',

  -- DirDiff
  'will133/vim-dirdiff',

  -- Vim sessions
  'tpope/vim-obsession',

  -- file managing , picker etc
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {}
      local api = require("nvim-tree.api")
      vim.keymap.set('n', '<leader>t', api.tree.toggle, { desc = 'Toggle nvimtree' })
      vim.keymap.set('n', '<leader>f', api.tree.focus, { desc = 'Focus nvimtree' })
    end,
  },

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },
}, {})
-- }}} Plugins

-- [[ Setting options ]] {{{
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Enable line numbers, relativenumber
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
-- }}} [[ Setting options ]]

-- Options {{{
vim.opt.autoindent=true       -- Copy indent from current line when starting a new line.
vim.opt.belloff='all'         -- Turn off bell for everything.
vim.opt.colorcolumn='+1'      -- Highlight column at textwidth.
vim.opt.complete='.,w,b,u,t'  -- Better Completion
vim.opt.completeopt='longest,menuone,preview'
vim.opt.cpoptions:append('J') -- Two spaces after a sentence.
vim.opt.encoding='utf-8'
vim.opt.expandtab=true        -- Insert spaces instead of real <tab> characters.
vim.opt.fillchars='diff:⣿,vert:┃,stl:='
vim.opt.formatoptions='qrn1j'
vim.opt.hidden=true           -- Allow modified buffers to be hidden.
vim.opt.history=1000          -- History of ":" commands.
vim.opt.ignorecase=true       -- Ignore case when searching.
vim.opt.laststatus=2          -- Always show status line.
vim.opt.lazyredraw=true       -- Don't redraw while executing macros, registers, commands.
vim.opt.linebreak=true        -- Wrap long lines at a character in 'breakat' rather
                              -- than last char that fits on the screen.
vim.opt.list=true             -- Show tabs, end-of-line.

-- Show tabs, end-of-line, line continuation.
vim.opt.listchars='tab:▸\\ ,eol:¬,extends:❯,precedes:❮'
-- Add < and > to matchpairs for html editing.
vim.opt.matchpairs='(:),{:},[:],<:>'

vim.opt.modeline=true         -- Enable vim modeline by default.
vim.opt.mouse='a'             -- Allow mouse use even in a xterm, in tmux.
vim.opt.equalalways=false     -- Do not keep windows the same height when splitting.
vim.opt.number=true           -- Show line numbers.
vim.opt.relativenumber=true   -- Show relative line numbers around current line.
vim.opt.ruler=true            -- Show line, column numbers, cursor position.
vim.opt.scrolloff=0           -- Show NO context above/below cursorline.
vim.opt.shiftround=true       -- Round indent to multiple of 'shiftwidth'.
vim.opt.shiftwidth=4          -- Number of spaces shifted with >> and <<.
vim.opt.showbreak='↪'         -- String to put at the start of wrapped lines.
vim.opt.showcmd=true          -- Show number of selected lines in visual mode.
vim.opt.sidescroll=1          -- Scroll horizontally 1 column at a time.
vim.opt.sidescrolloff=0       -- Scroll horizontally all the way to the edge.
vim.opt.smartcase=true        -- Override ignorecase when capitals used in search.
vim.opt.splitbelow=true       -- Put new window below current one when splitting.
vim.opt.splitright=true       -- Put new window right of the current one when splitting.
vim.opt.synmaxcol=800         -- Don't try to highlight lines longer than 800 characters.
vim.opt.tabstop=4             -- Number of spaces for a tab.
vim.opt.termguicolors=true    -- Use highlight-guifg and highlight-guibg attributes
                              -- in the terminal (thus using 24-bit color).
--vim.opt.termwinscroll=50000   -- keep 50k lines in a terminal (default is 10k)

-- Time out on key codes but not mappings.
-- Basically this makes terminal Vim work sanely.
--vim.opt.timeout=false -- Must use timeout=true for 'folke/which-key.nvim' plugin to work.
vim.opt.ttimeout=true
vim.opt.ttimeoutlen=10

-- Set title to 'titlestring' if terminal supports it.
-- Note that this doesn't work within tmux.
vim.opt.title=true

-- Indicates a fast terminal connection.
-- Enables extra chars at end of line that wrap, and helps copy/paste with mouse.
vim.opt.ttyfast=true

vim.opt.visualbell=true     -- Use a visual bell instead of beeping.
vim.opt.wmh=0               -- Set the minimum window height to 0.
vim.opt.wmw=0               -- Set the minimum window width to 0.

vim.opt.ignorecase=true     -- Ignore case when searching.
vim.opt.smartcase=true      -- Override ignorecase when capitals used in search.
vim.opt.incsearch=true      -- Show where the pattern matches as it is typed.
vim.opt.showmatch=true      -- Briefly jump to matching bracket when insert one.
vim.opt.hlsearch=true       -- Hilight matching search pattern.
--set gdefault           " :substitute flag 'g' is default on, :s///g off.

vim.opt.scrolloff=0         -- Show NO context above/below cursorline.
vim.opt.sidescroll=1        -- Scroll horizontally 1 column at a time.
--set sidescrolloff=10   " Keep 10 chars of context when side scrolling.
vim.opt.sidescrolloff=0     -- Scroll horizontally all the way to the edge.

-- Allow virtual editing in Visual block mode (e.g. allow to go pass end of line).
vim.opt.virtualedit:append('block')

-- Cursorline {{{
-- Only show cursorline in the current window and in normal mode.

vim.opt.cursorline=true
vim.cmd [[
augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
augroup END
]]

-- }}}
-- Trailing whitespace {{{
-- Only shown when not in insert mode so I don't go insane.

vim.cmd [[
augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
augroup END
]]

-- }}}
-- Line Return {{{

-- Make sure Vim returns to the same line when you reopen a file.
-- Thanks, Amit

vim.cmd [[
augroup line_return
    au!
    au BufReadPost *
        \\ if line(--'\"") > 0 && line("'\\"") <= line("$") |
        \\     execute 'normal! g`--zvzz' |
        \\ endif
augroup END
]]

-- }}}
-- Backups {{{

vim.cmd [[
set backup                        " enable backups
"set noswapfile                  " it's 2013, Vim.

set undodir=~/.vim/tmp/undo//     " undo files
set backupdir=~/.vim/tmp/backup// " backups
set directory=~/.vim/tmp/swap//   " swap files

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), --p--)
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), --p--)
endif
if !isdirectory(expand(&directory))
    call mkdir(expand(&directory), --p--)
endif
]]

-- }}}
-- }}} Options

-- [[ Basic Keymaps ]] {{{
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- }}} [[ Basic Keymaps ]]

-- Mappings {{{

-- Code folding with treesitter.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Reuse F5 to update any doc changes.
vim.keymap.set('n', '<F5>', ':checktime<cr>')
vim.keymap.set('i', '<F5>', '<esc>:checktime<cr>')

-- Wrap
vim.keymap.set('n', '<leader>W', ':set wrap!<cr>')

-- List
vim.keymap.set('n', '<leader>l', ':set list!<cr>')

-- Remove trailing whitespaces (and clear search pattern).
vim.keymap.set('n', '<leader>ww', 'mz:%s/\\s\\+$//<cr>:let @/=\'\'<cr>`z')

-- "Uppercase word" mapping.
--
-- This mapping allows you to press <c-u> in insert mode to convert the current
-- word to uppercase.  It's handy when you're writing names of constants and
-- don't want to use Capslock.
--
-- To use it you type the name of the constant in lowercase.  While your
-- cursor is at the end of the word, press <c-u> to uppercase it, and then
-- continue happily on your way:
--
--                            cursor
--                            v
--     max_connections_allowed|
--     <c-u>
--     MAX_CONNECTIONS_ALLOWED|
--                            ^
--                            cursor
--
-- It works by exiting out of insert mode, recording the current cursor
-- location in the z mark, using gUiw to uppercase inside the current word,
-- moving back to the u mark, and entering insert mode again.  Note that this
-- will overwrite the contents of the u mark.
vim.keymap.set('i', '<C-u>', '<esc>mugUiw`ua')

-- Panic Button
vim.keymap.set('n', '<f9>', 'mzggg?G`z')

-- zt is okay for putting something at the top of the screen, but when I'm
-- writing prose I often want to put something at not-quite-the-top of the
-- screen.  zh is "zoom to head level"
vim.keymap.set('n', 'zh', 'muzt10<c-u>`u')

-- Diffoff
vim.keymap.set('n', '<leader>D', ':diffoff!<cr>')
vim.keymap.set('n', '<leader>dd', ':diffthis<cr>')
vim.keymap.set('n', '<leader>do', ':diffoff<cr>')

-- Formatting, TextMate-style
--nnoremap Q gqip
vim.keymap.set('n', 'Q', 'gq')
vim.keymap.set('v', 'Q', 'gq')

-- Easier linewise reselection of what you just pasted.
vim.keymap.set('n', '<leader>V', 'V`]')

-- Indent/dedent/autoindent what you just pasted.
vim.keymap.set('n', '<lt>>', 'V`]<')
vim.keymap.set('n', '><lt>', 'V`]>')
vim.keymap.set('n', '=-', 'V`]=')

-- Keep the cursor in place while joining lines
--nnoremap J mzJ`z

-- XML
vim.keymap.set('v', '<Leader>x',  '  !xmllint --format -<CR>')
vim.keymap.set('n', '<Leader>xl', ' !!xmllint --format -<CR>')
vim.keymap.set('n', '<Leader>xa', ':%!xmllint --format -<CR>')

-- command line maps to edit line just like in a shell command line.
vim.keymap.set('c', '<C-A>', '<Home>')
vim.keymap.set('c', '<C-F>', '<Right>')
vim.keymap.set('c', '<C-B>', '<Left>')
--cnoremap <Esc>b <S-Left>
--cnoremap <Esc>f <S-Right>
vim.keymap.set('c', '<C-k>', '<C-\\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>')
vim.keymap.set('c', '<C-D>', '<DEL>')

-- Make timestamps readable in SWItrc logs
--vim.keymap.set('n', '<leader>d', ':g/^20/s/\\(....\\)\\(..\\)\\(..\\)\\(..\\)\\(..\\)\\(..\\)\\(...\\)/\\1\\/\\2\\/\\3 \\4:\\5:\\6.\\7<cr>')

-- do not wrap text
vim.keymap.set('n', '=t0', ':set textwidth=0<cr>')
-- make text wrap around after <num> chars
vim.keymap.set('n', '=t5', ':set textwidth=50<cr>')
vim.keymap.set('n', '=t6', ':set textwidth=60<cr>')
vim.keymap.set('n', '=t7', ':set textwidth=70<cr>')
vim.keymap.set('n', '=t8', ':set textwidth=80<cr>')

-- pop back to the last tag (doesn't work with /usr/bin/vi)
vim.keymap.set('n', '=p', ':pop<cr>')

-- underline current line. The underlining starts from the first
-- non-blank character to the last non-blank character of the line.
vim.keymap.set('n', '=ul', '"myy0I <esc>0"nd/[^  ]<cr>:s/./-/g<cr>0"nP0x"mP')

-- double underline current line. The underlining starts from the first
-- non-blank character to the last non-blank character of the line.
vim.keymap.set('n', '=uL', '"myy0I <esc>0"nd/[^  ]<cr>:s/./=/g<cr>0"nP0x"mP')

-- ,da = "date insert"
-- ,dt = "date and time insert" 070127^I11:22:33
-- ,X  = add extra short date, 070127
-- ,dd = date of the form: 2007/01/27
vim.keymap.set('n', '<leader>ida', ':r!date<cr>')
vim.keymap.set('n', '<leader>idt', ':r!date +\\%Y\\%m\\%d\\%t\\%T<cr>')
vim.keymap.set('n', '<leader>idd', ':r!date +\\%Y\\%m\\%d<cr>')
vim.keymap.set('n', '<leader>id/', ':r!date +\\%Y/\\%m/\\%d<cr>')

-- set wrap/nowrap
vim.keymap.set('n', '<F11>', ':set wrap!<cr>')
vim.keymap.set('n', '=w', '   :set wrap!<cr>')

-- Toggle le highlight du search pattern
vim.keymap.set('n', 'XX', ':set hlsearch!<cr>:set hlsearch?<cr>')

-- horizontal scroll
vim.keymap.set('n', '<c-Left>', 'zh')
vim.keymap.set('n', '<c-Right>', 'zl')

vim.cmd [[
" command to remove duplicate lines in a selection
:command! -range=% Uniq <line1>,<line2>s/\v^(.*)(%<<line2>l\n\1)+$/\1/e
" command to replace duplicate lines in a selection by blank lines
:command! -range=% Uniqb <line1>,<line2>s/\v^(.*)(%<<line2>l\n\1)+$/\1\n/e
]]

-- hold down Ctrl and move between windows with the standard Vim movement keys.
--map <c-j> <c-w>j<c-w>_
--map <c-k> <c-w>k<c-w>_
--map <c-h> <c-w>h<c-w><bar>
--map <c-l> <c-w>l<c-w><bar>
vim.keymap.set('n', '<c-j>', '<c-w>j')
vim.keymap.set('n', '<c-k>', '<c-w>k')
vim.keymap.set('n', '<c-h>', '<c-w>h')
vim.keymap.set('n', '<c-l>', '<c-w>l')
-- Also use Alt with the arrows to move around windows
vim.keymap.set('n', '<silent>', '<A-Up>    :wincmd k<CR>')
vim.keymap.set('n', '<silent>', '<A-Down>  :wincmd j<CR>')
vim.keymap.set('n', '<silent>', '<A-Left>  :wincmd h<CR>')
vim.keymap.set('n', '<silent>', '<A-Right> :wincmd l<CR>')

-- to quickly resize windows with a vertical split
vim.keymap.set('n', '-', '<C-W>-')
vim.keymap.set('n', '+', '<C-W>+')

-- to resize vertical windows quickly with ALT-SHIFT-[<>]
vim.keymap.set('n', '<', '<')
vim.keymap.set('n', '>', '>')

-- Draw arrows in between vertical bars in replace mode,
-- useful to make call flow diagrams.
-- e.g.
-- |protocol message'ctrl-'>               |
-- will result in
-- |-protocol message--------------------->|
--inoremap <c-->> <esc>ldwF\|pT\|r-ldwf\|Pr>bf vt>r-F\|jlR
--inoremap <c-->< <esc>ldwF\|pwhvT\|r-r<lxf\|PF<jR
--inoremap <c-->> <esc>lxvt\|r-t\|r>F\|a-<esc>jR
--inoremap <c-->< <esc>ldt\|F\|pxhvT\|r-r<f\|i-<esc>T\|jR
--inoremap <c-->> <Esc>ldwF\|pT\|r-ldwf\|Pr>bf vt>r-
--inoremap <c-->< <Esc>ldwF\|pwhvT\|r-r<lxf\|P
-- Windows Terminal uses ctrl- and ctrl+ to control the font size.
-- So use ctrl_ instead for the call-flow maps.
vim.keymap.set('i', '<c-_>>', '<Esc>ldwF|pT|r-ldwf|Pr>bf vt>r-')
vim.keymap.set('i', '<c-_><', '<Esc>ldwF|pwhvT|r-r<lxf|P')

-- |protocol message'ctrl-')               |
-- will result in
-- |           protocol message            |
-- |-------------------------------------->|
--inoremap <c-->) <esc>F\|maldt\|O<esc>P:s/\(.*\S\)\(\s*\)$/\2\1<cr>:s/\(\s*\)\(\1\)/\1;\2<cr>:s/;\(\s*\)\(.*\)/\2\1<cr>0d$`apT\|jvt\|r-t\|r>kkdd`ajjlR
--inoremap <c-->( <esc>F\|maldt\|O<esc>P:s/\(.*\S\)\(\s*\)$/\2\1<cr>:s/\(\s*\)\(\1\)/\1;\2<cr>:s/;\(\s*\)\(.*\)/\2\1<cr>0d$`apT\|jvt\|r-r<kkdd`ajjlR
-- Windows Terminal uses ctrl- and ctrl+ to control the font size.
-- So use ctrl_ instead for the call-flow maps.
vim.keymap.set('i', '<c-_>)', '<esc>F|maldt|O<esc>P:s/\\(.*\\S\\)\\(\\s*\\)$/\\2\\1<cr>:s/\\(\\s*\\)\\(\\1\\)/\\1;\\2<cr>:s/;\\(\\s*\\)\\(.*\\)/\\2\\1<cr>0d$`apT|jvt|r-t|r>kkdd`ajjlR')
vim.keymap.set('i', '<c-_>(', '<esc>F|maldt|O<esc>P:s/\\(.*\\S\\)\\(\\s*\\)$/\\2\\1<cr>:s/\\(\\s*\\)\\(\\1\\)/\\1;\\2<cr>:s/;\\(\\s*\\)\\(.*\\)/\\2\\1<cr>0d$`apT|jvt|r-r<kkdd`ajjlR')

-- Navigate betweenn protocol sections.
-- |█<right>          |                    |
-- will result in cursor moving to next section.
-- |                  |█                   |
vim.keymap.set('i', '<right>', '<esc>f|lR')
vim.keymap.set('i', '<left>', ' <esc>F|lR')

-- Go to the next error or match
vim.keymap.set('n', '<c-n>', ':cn<cr>')
-- Go to the previous error or match
vim.keymap.set('n', '<c-p>', ':cp<cr>')

-- format into human-readable json
vim.keymap.set('v', '<Leader>j',    '!python3 -mjson.tool<cr>')
vim.keymap.set('n', '<Leader>jl',  '!!python3 -mjson.tool<cr>')
vim.keymap.set('n', '<Leader>ja', ':%!python3 -mjson.tool<cr>')

-- change local directory to where current file is located.
vim.keymap.set('n', '<leader>.', ':if expand(\'%:p\') !~ \'://\' | :lchdir %:p:h | endif<cr>')

-- While in a terminal (Terminal-Job mode), press <Esc> to switch to Terminal-Normal mode
vim.keymap.set('t', '<Esc>', '<C-W>N')

-- Toggle showing line numbers
vim.keymap.set('n', '<leader>#', ':set number! relativenumber!<cr>')

-- Heresy
vim.keymap.set('i', '<c-a>', '<esc>I')
vim.keymap.set('i', '<c-e>', '<esc>A')
vim.keymap.set('c', '<c-a>', '<home>')
vim.keymap.set('c', '<c-e>', '<end>')

-- Mappings }}}

-- [[ Highlight on yank ]] {{{
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})
-- }}} [[ Highlight on yank ]]

-- [[ Configure Telescope ]] {{{
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
-- }}} [[ Configure Telescope ]]

-- [[ Configure Treesitter ]] {{{
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- }}} [[ Configure Treesitter ]]

-- [[ Configure LSP ]] {{{
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- document existing key chains
require('which-key').register({
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  clangd = {},
  -- gopls = {},
  pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end
}
-- }}} [[ Configure LSP ]]

-- [[ Configure nvim-cmp ]] {{{
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- }}} [[ Configure nvim-cmp ]]

-- [[ Configure nvim-tree ]] {{{
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
--vim.opt.termguicolors = true

local function nvimtree_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '<c-u>', api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  sort_by = "case_sensitive",
  view = {
    width = 50,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  on_attach = nvimtree_on_attach,
  update_focused_file = {
    enable = true,
    update_root = false,
  },
}
-- }}} nvim-tree

-- Highlights {{{

vim.cmd [[
"hi Folded ctermbg=16 ctermfg=37 guifg=#709090 guibg=#001717
"hi Folded ctermbg=16 ctermfg=37 guifg=#70c0c0 guibg=#000035
hi Folded ctermbg=16 ctermfg=37 guifg=#70c0c0 guibg=#002000
" Fix invisible mode message with landscape colorscheme
hi ModeMsg term=bold cterm=bold ctermfg=16 ctermbg=0 gui=bold guibg=#000000 guifg=#ff0000
" Color for listchars
"hi NonText guifg=#00c000
hi NonText guifg=#006000
"hi CursorLine guibg=#272727
hi CursorLine guibg=#300000
hi ColorColumn guibg=#202020
]]

-- }}} Highlights

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et fdm=marker

--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- ============================================================
-- SECTION 1: OPTIONS
-- Core Neovim settings, leaders, options
-- ============================================================
do
  -- Enable faster startup by caching compiled Lua modules
  vim.loader.enable()

  -- Set <space> as the leader key
  -- See `:help mapleader`
  --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
  vim.g.mapleader = ' '
  vim.g.maplocalleader = ' '

  -- Set to true if you have a Nerd Font installed and selected in the terminal
  vim.g.have_nerd_font = true

  -- [[ Setting options ]]
  --  See `:help vim.o`
  -- NOTE: You can change these options as you wish!
  --  For more options, you can see `:help option-list`

  -- Make line numbers default
  vim.o.number = true                  -- Show line numbers.
  vim.o.relativenumber = true          -- Show relative line numbers around current line.

  -- Enable mouse mode, can be useful for resizing splits for example!
  vim.o.mouse = 'a'

  -- Don't show the mode, since it's already in the status line
  vim.o.showmode = false

  -- Sync clipboard between OS and Neovim.
  --  Schedule the setting after `UiEnter` because it can increase startup-time.
  --  Remove this option if you want your OS clipboard to remain independent.
  --  See `:help 'clipboard'`
  vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

  -- Enable break indent
  vim.o.breakindent = true

  -- Enable undo/redo changes even after closing and reopening a file
  vim.o.undofile = true

  -- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
  vim.o.ignorecase = true              -- Ignore case when searching.
  vim.o.smartcase = true               -- Override ignorecase when capitals used in search.

  -- Keep signcolumn on by default
  vim.o.signcolumn = 'yes'

  -- Decrease update time
  vim.o.updatetime = 250

  -- Decrease mapped sequence wait time
  vim.o.timeoutlen = 300

  -- Configure how new splits should be opened
  vim.o.splitright = true              -- Put new window right of the current one when splitting.
  vim.o.splitbelow = true              -- Put new window below current one when splitting.

  -- Sets how neovim will display certain whitespace characters in the editor.
  --  See `:help 'list'`
  --  and `:help 'listchars'`
  --
  --  Notice listchars is set using `vim.opt` instead of `vim.o`.
  --  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
  --   See `:help lua-options`
  --   and `:help lua-guide-options`
  vim.o.list = true
  --vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
  -- Show tabs, end-of-line, line continuation.
  --vim.o.listchars = 'tab:▸\\ ,eol:¬,extends:❯,precedes:❮'
  vim.opt.listchars = { tab = '▸ ', trail = '⌴', nbsp = '␣', eol = '¬', extends = '❯', precedes = '❮' }

  -- -----------------------------------------------------------
  -- Trailing whitespace
  -- -----------------------------------------------------------
  -- Only shown when not in insert mode so I don't go insane.
  vim.cmd [[
  augroup trailing
    au!
    au InsertEnter * :set listchars-=trail:⌴
    au InsertLeave * :set listchars+=trail:⌴
  augroup END
  ]]
  -- -----------------------------------------------------------

  -- Preview substitutions live, as you type!
  vim.o.inccommand = 'split'

  -- -----------------------------------------------------------
  -- Cursorline
  -- -----------------------------------------------------------
  -- Show which line your cursor is on
  vim.o.cursorline = true
  -- Only show cursorline in the current window and in normal mode.
  vim.cmd [[
  augroup cline
    au!
    au WinLeave,InsertEnter * set nocursorline
    au WinEnter,InsertLeave * set cursorline
  augroup END
  ]]
  -- -----------------------------------------------------------

  -- Minimal number of screen lines to keep above and below the cursor.
  --vim.o.scrolloff = 10
  vim.o.scrolloff = 0                  -- Show NO context above/below cursorline.
  vim.o.sidescroll = 1                 -- Scroll horizontally 1 column at a time.
  --vim.o.sidescrolloff = 10           -- Keep 10 chars of context when side scrolling.
  vim.o.sidescrolloff = 0              -- Scroll horizontally all the way to the edge.
  --vim.o.termwinscroll = 50000        -- keep 50k lines in a terminal (default is 10k)

  -- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
  -- instead raise a dialog asking if you wish to save the current file(s)
  -- See `:help 'confirm'`
  vim.o.confirm = true

  -- -----------------------------------------------------------
  -- [[ Setting more options ]]
  -- -----------------------------------------------------------
  vim.o.autoindent = true              -- Copy indent from current line when starting a new line.
  vim.o.belloff = 'all'                -- Turn off bell for everything.
  vim.o.colorcolumn = '+1'             -- Highlight column at textwidth.
  vim.o.complete = '.,w,b,u,t'         -- Better Completion
  -- Set completeopt to have a better completion experience
  -- vim.o.completeopt = 'menuone,noselect'
  vim.o.completeopt = 'longest,menuone,preview'
  vim.opt.cpoptions:append 'J'         -- Two spaces after a sentence.
  vim.o.encoding = 'utf-8'
  vim.o.expandtab = true               -- Insert spaces instead of real <tab> characters.
  vim.o.fillchars = 'diff:⣿,vert:┃,stl:='
  vim.o.formatoptions = 'qrn1j'
  vim.o.hidden = true                  -- Allow modified buffers to be hidden.
  vim.o.history = 1000                 -- History of ":" commands.
  vim.o.laststatus = 2                 -- Always show status line.
  vim.o.lazyredraw = true              -- Don't redraw while executing macros, registers, commands.
  vim.o.linebreak = true               -- Wrap long lines at a character in 'breakat' rather
                                       -- than last char that fits on the screen.

  -- Add < and > to matchpairs for html editing.
  vim.o.matchpairs = '(:),{:},[:],<:>'

  vim.o.modeline = true                -- Enable vim modeline by default.
  vim.o.equalalways = false            -- Do not keep windows the same height when splitting.
  vim.o.ruler = true                   -- Show line, column numbers, cursor position.
  vim.o.shiftround = true              -- Round indent to multiple of 'shiftwidth'.
  vim.o.shiftwidth = 4                 -- Number of spaces shifted with >> and <<.
  vim.o.showbreak = '↪'                -- String to put at the start of wrapped lines.
  vim.o.showcmd = true                 -- Show number of selected lines in visual mode.
  vim.o.synmaxcol = 800                -- Don't try to highlight lines longer than 800 characters.
  vim.o.tabstop = 4                    -- Number of spaces for a tab.
  vim.o.termguicolors = true           -- Use highlight-guifg and highlight-guibg attributes
                                       -- in the terminal (thus using 24-bit color).
                                       -- NOTE: You should make sure your terminal supports this

  -- Time out on key codes but not mappings.
  -- Basically this makes terminal Vim work sanely.
  --vim.o.timeout = false              -- Must use timeout=true for 'folke/which-key.nvim' plugin to work.
  vim.o.ttimeout = true
  vim.o.ttimeoutlen = 10

  -- Set title to 'titlestring' if terminal supports it.
  -- Note that this doesn't work within tmux.
  vim.o.title = true

  -- Indicates a fast terminal connection.
  -- Enables extra chars at end of line that wrap, and helps copy/paste with mouse.
  vim.o.ttyfast = true

  vim.o.visualbell = true              -- Use a visual bell instead of beeping.
  vim.o.wmh = 0                        -- Set the minimum window height to 0.
  vim.o.wmw = 0                        -- Set the minimum window width to 0.

  vim.o.incsearch = true               -- Show where the pattern matches as it is typed.
  vim.o.showmatch = true               -- Briefly jump to matching bracket when insert one.
  vim.o.hlsearch = true                -- Hilight matching search pattern.
  --vim.o.gdefault = false             -- when true the :substitute flag 'g' is on by default, :s///g.

  -- Allow virtual editing in Visual block mode (e.g. allow to go pass end of line).
  vim.opt.virtualedit:append 'block'

  -- -----------------------------------------------------------
  -- Line Return
  -- -----------------------------------------------------------
  -- Make sure Vim returns to the same line when you reopen a file.
  vim.cmd [[
  augroup line_return
      au!
      au BufReadPost *
          \\ if line(--'\"") > 0 && line("'\\"") <= line("$") |
          \\     execute 'normal! g`--zvzz' |
          \\ endif
  augroup END
  ]]
  -- -----------------------------------------------------------

  -- -----------------------------------------------------------
  -- Backups
  -- -----------------------------------------------------------
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
  -- -----------------------------------------------------------

end

-- ============================================================
-- SECTION 2: KEYMAPS & AUTOCMDS
-- basic keymaps, basic autocmds
-- ============================================================
do
  -- [[ Basic Keymaps ]]
  --  See `:help vim.keymap.set()`

  -- Clear highlights on search when pressing <Esc> in normal mode
  --  See `:help hlsearch`
  vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

  -- Diagnostic Config & Keymaps
  --  See `:help vim.diagnostic.Opts`
  vim.diagnostic.config {
    update_in_insert = false,
    severity_sort = true,
    float = { border = 'rounded', source = 'if_many' },
    underline = { severity = { min = vim.diagnostic.severity.WARN } },

    -- Can switch between these as you prefer
    virtual_text = true, -- Text shows up at the end of the line
    virtual_lines = false, -- Text shows up underneath the line, with virtual lines

    -- Auto open the float, so you can easily read the errors when jumping with `[d` and `]d`
    jump = {
      on_jump = function(_, bufnr)
        vim.diagnostic.open_float {
          bufnr = bufnr,
          scope = 'cursor',
          focus = false,
        }
      end,
    },
  }

  -- Diagnostic keymaps
  vim.keymap.set('n', '[d', vim.diagnostic._jump.goto_prev, { desc = 'Go to previous diagnostic message' })
  vim.keymap.set('n', ']d', vim.diagnostic._jump.goto_next, { desc = 'Go to next diagnostic message' })
  vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
  vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

  -- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
  -- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
  -- is not what someone will guess without a bit more experience.
  --
  -- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
  -- or just use <C-\><C-n> to exit terminal mode
  vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

  -- TIP: Disable arrow keys in normal mode
  -- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
  -- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
  -- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
  -- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

  -- Keybinds to make split navigation easier.
  --  Use CTRL+<hjkl> to switch between windows
  --
  --  See `:help wincmd` for a list of all window commands
  vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
  vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
  vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
  vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

  -- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
  -- vim.keymap.set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
  -- vim.keymap.set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
  -- vim.keymap.set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
  -- vim.keymap.set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

  -- -----------------------------------------------------------
  -- [[ Other Mappings ]]
  -- -----------------------------------------------------------
  --vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

  -- Remap for dealing with word wrap
  --vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
  --vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

  -- Reuse F5 to update any doc changes.
  vim.keymap.set('n', '<F5>', ':checktime<cr>')
  vim.keymap.set('i', '<F5>', '<esc>:checktime<cr>')

  -- Show/Hide listchars (tab, trail, nbsp, eol, etc..)
  vim.keymap.set('n', '<leader>l', ':set list!<cr>')

  -- Remove trailing whitespaces (and clear search pattern).
  vim.keymap.set('n', '<leader>ww', "mz:%s/\\s\\+$//<cr>:let @/=''<cr>`z")

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
  vim.keymap.set('v', '<Leader>x',    '!xmllint --format -<CR>')
  vim.keymap.set('n', '<Leader>xl',  '!!xmllint --format -<CR>')
  vim.keymap.set('n', '<Leader>xa', ':%!xmllint --format -<CR>')

  -- command line maps to edit line just like in a shell command line.
  vim.keymap.set('c', '<C-A>', '<Home>')
  vim.keymap.set('c', '<C-F>', '<Right>')
  vim.keymap.set('c', '<C-B>', '<Left>')
  --cnoremap <Esc>b <S-Left>
  --cnoremap <Esc>f <S-Right>
  vim.keymap.set('c', '<C-k>', '<C-\\>estrpart(getcmdline(),0,getcmdpos()-1)<CR>')
  vim.keymap.set('c', '<C-D>', '<DEL>')

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
  vim.keymap.set('n', '<leader>W', ':set wrap!<cr>')
  --vim.keymap.set('n', '<F11>', ':set wrap!<cr>')
  --vim.keymap.set('n', '=w', ':set wrap!<cr>')

  -- Toggle highlight of search pattern
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
  vim.keymap.set('i', '<c-l><c-l>', '<Esc>ldwF|pT|r-ldwf|Pr>bf vt>r-T|jR')
  vim.keymap.set('i', '<c-h><c-h>', '<Esc>ldwF|pwhvT|r-r<lxf|PT|jR')

  -- |protocol message'ctrl-')               |
  -- will result in
  -- |           protocol message            |
  -- |-------------------------------------->|
  vim.keymap.set('i', '<c-L>l', '<esc>F|maldt|O<esc>P:s/\\(.*\\S\\)\\(\\s*\\)$/\\2\\1<cr>:s/\\(\\s*\\)\\(\\1\\)/\\1;\\2<cr>:s/;\\(\\s*\\)\\(.*\\)/\\2\\1<cr>0d$`apT|jvt|r-t|r>kkdd`ajjlR')
  vim.keymap.set('i', '<c-H>h', '<esc>F|maldt|O<esc>P:s/\\(.*\\S\\)\\(\\s*\\)$/\\2\\1<cr>:s/\\(\\s*\\)\\(\\1\\)/\\1;\\2<cr>:s/;\\(\\s*\\)\\(.*\\)/\\2\\1<cr>0d$`apT|jvt|r-r<kkdd`ajjlR')

  -- Navigate between protocol sections.
  -- |█<right>          |                    |
  -- will result in cursor moving to next section.
  -- |                  |█                   |
  vim.keymap.set('i', '<c-right>', '<c-o>f|<c-o>l')
  vim.keymap.set('i', '<c-left>', '<c-o>F|<c-o>T|')

  -- Go to the next error or match
  vim.keymap.set('n', '<c-n>', ':cn<cr>')
  -- Go to the previous error or match
  vim.keymap.set('n', '<c-p>', ':cp<cr>')

  -- format into human-readable json
  vim.keymap.set('v', '<Leader>j',    '!python3 -mjson.tool<cr>')
  vim.keymap.set('n', '<Leader>jl',  '!!python3 -mjson.tool<cr>')
  vim.keymap.set('n', '<Leader>ja', ':%!python3 -mjson.tool<cr>')

  -- change local directory to where current file is located.
  vim.keymap.set('n', '<leader>.', ":if expand('%:p') !~ '://' | :lchdir %:p:h | endif<cr>")

  -- While in a terminal (Terminal-Job mode), press <Esc> to switch to Terminal-Normal mode
  vim.keymap.set('t', '<Esc>', '<C-W>N')

  -- Toggle showing line numbers
  vim.keymap.set('n', '<leader>#', ':set number! relativenumber!<cr>')

  -- Heresy
  vim.keymap.set('i', '<c-a>', '<esc>I')
  vim.keymap.set('i', '<c-e>', '<esc>A')
  vim.keymap.set('c', '<c-a>', '<home>')
  vim.keymap.set('c', '<c-e>', '<end>')

  -- -----------------------------------------------------------
  -- [[ Basic Autocommands ]]
  -- -----------------------------------------------------------
  --  See `:help lua-guide-autocommands`

  -- Highlight when yanking (copying) text
  --  Try it with `yap` in normal mode
  --  See `:help vim.hl.on_yank()`
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function() vim.hl.on_yank() end,
    --callback = function() vim.hl.hl_op() end,
  })

  -- -----------------------------------------------------------
  -- vim-mark
  -- -----------------------------------------------------------
  vim.g.mwDefaultHighlightingPalette = {
    { ctermbg = '196', ctermfg = 'black', guibg = '#FF0000', guifg = 'black' }, -- Red
    { ctermbg = '46',  ctermfg = 'black', guibg = '#00FF00', guifg = 'black' }, -- Lime
    { ctermbg = '21',  ctermfg = 'white', guibg = '#0000FF', guifg = 'white' }, -- Blue
    { ctermbg = '226', ctermfg = 'black', guibg = '#FFFF00', guifg = 'black' }, -- Yellow
    { ctermbg = '51',  ctermfg = 'black', guibg = '#00FFFF', guifg = 'black' }, -- Cyan
    { ctermbg = '201', ctermfg = 'black', guibg = '#FF00FF', guifg = 'black' }, -- Magenta
    { ctermbg = '208', ctermfg = 'black', guibg = '#FFA500', guifg = 'black' }, -- Orange
    { ctermbg = '118', ctermfg = 'black', guibg = '#7FFF00', guifg = 'black' }, -- Chartreuse
    { ctermbg = '45',  ctermfg = 'black', guibg = '#40E0D0', guifg = 'black' }, -- Turquoise
    { ctermbg = '93',  ctermfg = 'white', guibg = '#800080', guifg = 'white' }, -- Purple
    { ctermbg = '220', ctermfg = 'black', guibg = '#FFD700', guifg = 'black' }, -- Gold
    { ctermbg = '210', ctermfg = 'black', guibg = '#FA8072', guifg = 'black' }, -- Salmon
    { ctermbg = '117', ctermfg = 'black', guibg = '#87CEEB', guifg = 'black' }, -- Sky Blue
    { ctermbg = '54',  ctermfg = 'white', guibg = '#4B0082', guifg = 'white' }, -- Indigo
    { ctermbg = '28',  ctermfg = 'white', guibg = '#228B22', guifg = 'white' }, -- Forest Green
    { ctermbg = '214', ctermfg = 'black', guibg = '#FF7F00', guifg = 'black' }, -- Vivid Orange
    { ctermbg = '33',  ctermfg = 'white', guibg = '#0066CC', guifg = 'white' }, -- Royal Blue
    { ctermbg = '82',  ctermfg = 'black', guibg = '#66FF33', guifg = 'black' }, -- Neon Green
    { ctermbg = '177', ctermfg = 'black', guibg = '#FF66FF', guifg = 'black' }, -- Hot Pink
    { ctermbg = '47',  ctermfg = 'black', guibg = '#33FFCC', guifg = 'black' }, -- Aqua Green
    { ctermbg = '172', ctermfg = 'black', guibg = '#FF6600', guifg = 'black' }, -- Bright Orange
    { ctermbg = '141', ctermfg = 'black', guibg = '#CC66FF', guifg = 'black' }, -- Violet
    { ctermbg = '75',  ctermfg = 'black', guibg = '#3399FF', guifg = 'black' }, -- Bright Azure
    { ctermbg = '190', ctermfg = 'black', guibg = '#CCFF00', guifg = 'black' }, -- Acid Green
    { ctermbg = '203', ctermfg = 'black', guibg = '#FF3333', guifg = 'black' }, -- Bright Red
    { ctermbg = '99',  ctermfg = 'white', guibg = '#6666CC', guifg = 'white' }, -- Muted Purple
    { ctermbg = '48',  ctermfg = 'black', guibg = '#33FF99', guifg = 'black' }, -- Mint Green
    { ctermbg = '227', ctermfg = 'black', guibg = '#FFFF66', guifg = 'black' }, -- Light Yellow
    { ctermbg = '129', ctermfg = 'white', guibg = '#9933CC', guifg = 'white' }, -- Deep Violet
    { ctermbg = '38',  ctermfg = 'black', guibg = '#339999', guifg = 'black' }, -- Teal Blue
    { ctermbg = '219', ctermfg = 'black', guibg = '#FF99CC', guifg = 'black' }, -- Light Pink
    { ctermbg = '202', ctermfg = 'black', guibg = '#FF4500', guifg = 'black' }, -- Orange Red
    { ctermbg = '79',  ctermfg = 'black', guibg = '#66FFCC', guifg = 'black' }, -- Aqua Mint
    { ctermbg = '153', ctermfg = 'black', guibg = '#9999FF', guifg = 'black' }, -- Soft Blue
    { ctermbg = '112', ctermfg = 'black', guibg = '#66CC66', guifg = 'black' }, -- Medium Green
    { ctermbg = '229', ctermfg = 'black', guibg = '#FFFF99', guifg = 'black' }, -- Pastel Yellow
    { ctermbg = '183', ctermfg = 'black', guibg = '#FF99FF', guifg = 'black' }, -- Candy Pink
    { ctermbg = '159', ctermfg = 'black', guibg = '#99FFFF', guifg = 'black' }, -- Pastel Cyan
    { ctermbg = '171', ctermfg = 'black', guibg = '#FF66CC', guifg = 'black' }, -- Neon Pink
    { ctermbg = '121', ctermfg = 'black', guibg = '#66FF66', guifg = 'black' }, -- Bright Green
    { ctermbg = '105', ctermfg = 'white', guibg = '#6666FF', guifg = 'white' }, -- Strong Blue
    { ctermbg = '215', ctermfg = 'black', guibg = '#FF9966', guifg = 'black' }, -- Peach Orange
    { ctermbg = '84',  ctermfg = 'black', guibg = '#66FF99', guifg = 'black' }, -- Soft Mint
    { ctermbg = '225', ctermfg = 'black', guibg = '#E6E6FA', guifg = 'black' }, -- Lavender
    { ctermbg = '195', ctermfg = 'black', guibg = '#CCFFFF', guifg = 'black' }, -- Baby Blue
    { ctermbg = '140', ctermfg = 'black', guibg = '#CC66CC', guifg = 'black' }, -- Purple Rose
    { ctermbg = '186', ctermfg = 'black', guibg = '#FFFFCC', guifg = 'black' }, -- Cream Yellow
    { ctermbg = '81',  ctermfg = 'black', guibg = '#66CCFF', guifg = 'black' }, -- Clear Sky
  }
  -- turn off the creation of the default mappings.
  vim.g.mw_no_mappings = 1
  -- -----------------------------------------------------------

end

-- ============================================================
-- SECTION 3: PLUGIN MANAGER INTRO
-- vim.pack intro, build hooks
-- ============================================================
do
  -- [[ Intro to `vim.pack` ]]
  -- `vim.pack` is a new plugin manager built into Neovim,
  --  which provides a Lua interface for installing and managing plugins.
  --
  --  See `:help vim.pack`, `:help vim.pack-examples` or the
  --  excellent blog post from the creator of vim.pack and mini.nvim:
  --  https://echasnovski.com/blog/2026-03-13-a-guide-to-vim-pack
  --
  --  To inspect plugin state and pending updates, run
  --    :lua vim.pack.update(nil, { offline = true })
  --
  --  To update plugins, run
  --    :lua vim.pack.update()
  --
  --
  --  Throughout the rest of the config there will be examples
  --  of how to install and configure plugins using `vim.pack`.
  --
  --  In this section we set up some autocommands to run build
  --  steps for certain plugins after they are installed or updated.

  local function run_build(name, cmd, cwd)
    local result = vim.system(cmd, { cwd = cwd }):wait()
    if result.code ~= 0 then
      local stderr = result.stderr or ''
      local stdout = result.stdout or ''
      local output = stderr ~= '' and stderr or stdout
      if output == '' then output = 'No output from build command.' end
      vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
    end
  end

  -- This autocommand runs after a plugin is installed or updated and
  --  runs the appropriate build command for that plugin if necessary.
  --
  -- See `:help vim.pack-events`
  vim.api.nvim_create_autocmd('PackChanged', {
    callback = function(ev)
      local name = ev.data.spec.name
      local kind = ev.data.kind
      if kind ~= 'install' and kind ~= 'update' then return end

      if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
        run_build(name, { 'make' }, ev.data.path)
        return
      end

      if name == 'LuaSnip' then
        if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
        return
      end

      if name == 'nvim-treesitter' then
        if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
        vim.cmd 'TSUpdate'
        return
      end
    end,
  })
end

---Because most plugins are hosted on GitHub, you can use the helper
---function to have less repetition in the following sections.
---@param repo string
---@return string
local function gh(repo) return 'https://github.com/' .. repo end

-- ============================================================
-- SECTION 4: UI / CORE UX PLUGINS
-- guess-indent, gitsigns, which-key, colorscheme, todo-comments, mini modules
-- ============================================================
do
  -- [[ Installing and Configuring Plugins ]]
  --
  -- To install a plugin simply call `vim.pack.add` with its git url.
  -- This will download the default branch of the plugin, which will usually be `main` or `master`
  -- You can also have more advanced specs, which we will talk about later.
  --
  -- For most plugins its not enough to install them, you also need to call their `.setup()` to start them.
  --
  -- For example, lets say we want to install `guess-indent.nvim` - a plugin for
  -- automatically detecting and setting the indentation.
  --
  -- We first install it from https://github.com/NMAC427/guess-indent.nvim
  -- and then call its `setup()` function to start it with default settings.
  vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
  require('guess-indent').setup {}

  -- Here is a more advanced configuration example that passes options to `gitsigns.nvim`
  --
  -- See `:help gitsigns` to understand what each configuration key does.
  -- Adds git related signs to the gutter, as well as utilities for managing changes
  vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
  local gitsigns = require 'gitsigns'
  gitsigns.setup {
    signs = {
      add = { text = '+' }, ---@diagnostic disable-line: missing-fields
      change = { text = '~' }, ---@diagnostic disable-line: missing-fields
      delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
      topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
      changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
    },
    -- gitsigns.nvim's recommended keymaps:
    on_attach = function(bufnr)
      -- Navigation
      vim.keymap.set('n', ']c', function()
        if vim.wo.diff then
          vim.cmd.normal { ']c', bang = true }
        else
          gitsigns.nav_hunk 'next'
        end
      end, { desc = 'Jump to next git [c]hange', buf = bufnr })

      vim.keymap.set('n', '[c', function()
        if vim.wo.diff then
          vim.cmd.normal { '[c', bang = true }
        else
          gitsigns.nav_hunk 'prev'
        end
      end, { desc = 'Jump to previous git [c]hange', buf = bufnr })

      -- Visual mode actions
      vim.keymap.set('v', '<leader>hs', function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('v', '<leader>hr', function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end, { desc = 'git [r]eset hunk', buf = bufnr })
      -- Normal mode actions
      vim.keymap.set('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer', buf = bufnr })
      vim.keymap.set('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk', buf = bufnr })
      vim.keymap.set('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline', buf = bufnr })
      vim.keymap.set('n', '<leader>hb', function() gitsigns.blame_line { full = true } end, { desc = 'git [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index', buf = bufnr })
      vim.keymap.set('n', '<leader>hD', function() gitsigns.diffthis '~' end, { desc = 'git [D]iff against last commit', buf = bufnr })
      vim.keymap.set('n', '<leader>hQ', function() gitsigns.setqflist 'all' end, { desc = 'git hunk [Q]uickfix list (all files in repo)', buf = bufnr })
      vim.keymap.set('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)', buf = bufnr })
      -- Toggles
      vim.keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line', buf = bufnr })
      vim.keymap.set('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff', buf = bufnr })
      -- Text object
      vim.keymap.set({ 'o', 'x' }, 'ih', gitsigns.select_hunk, { desc = 'text object [i]nside [h]unk', buf = bufnr })
    end,
  }

  -- Useful plugin to show you pending keybinds.
  vim.pack.add { gh 'folke/which-key.nvim' }
  require('which-key').setup {
    -- Delay between pressing a key and opening which-key (milliseconds)
    delay = 0,
    icons = { mappings = vim.g.have_nerd_font },
    -- Document existing key chains
    spec = {
      { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
      { 'gr', group = 'LSP Actions', mode = { 'n' } },
    },
  }

  -- [[ Colorscheme ]]
  -- You can easily change to a different colorscheme.
  -- Change the name of the colorscheme plugin below, and then
  -- change the command under that to load whatever the name of that colorscheme is.
  --
  -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  vim.pack.add { gh 'folke/tokyonight.nvim' }
  ---@diagnostic disable-next-line: missing-fields
  require('tokyonight').setup {
    styles = {
      comments = { italic = false }, -- Disable italics in comments
    },
  }

  -- Load the colorscheme here.
  -- Like many other themes, this one has different styles, and you could load
  -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  vim.cmd.colorscheme 'tokyonight-night'

  -- Highlight todo, notes, etc in comments
  vim.pack.add { gh 'folke/todo-comments.nvim' }
  require('todo-comments').setup { signs = false }

  -- [[ mini.nvim ]]
  --  A collection of various small independent plugins/modules
  vim.pack.add { gh 'nvim-mini/mini.nvim' }

  -- If a nerd font is available, load the icons module for pretty icons in various plugins.
  if vim.g.have_nerd_font then
    require('mini.icons').setup()
    -- Used for backwards compatibility with plugins that require `nvim-web-devicons` (e.g. telescope.nvim)
    MiniIcons.mock_nvim_web_devicons()
  end

  -- Better Around/Inside textobjects
  --
  -- Examples:
  --  - va)  - [V]isually select [A]round [)]paren
  --  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
  --  - ci'  - [C]hange [I]nside [']quote
  require('mini.ai').setup {
    -- NOTE: Avoid conflicts with the built-in incremental selection mappings on Neovim>=0.12 (see `:help treesitter-incremental-selection`)
    mappings = {
      around_next = 'aa',
      inside_next = 'ii',
    },
    n_lines = 500,
  }

  -- Add/delete/replace surroundings (brackets, quotes, etc.)
  --
  -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
  -- - sd'   - [S]urround [D]elete [']quotes
  -- - sr)'  - [S]urround [R]eplace [)] [']
  require('mini.surround').setup()

  -- NOTE: Comment out mini status line, since we are using lualine instead.
  --[[

  -- -----------------------------------------------------------
  -- Simple and easy statusline.
  -- -----------------------------------------------------------
  --  You could remove this setup call if you don't like it,
  --  and try some other statusline plugin
  local statusline = require 'mini.statusline'
  -- Set `use_icons` to true if you have a Nerd Font
  statusline.setup { use_icons = vim.g.have_nerd_font }

  -- You can configure sections in the statusline by overriding their
  -- default behavior. For example, here we set the section for
  -- cursor location to LINE:COLUMN
  ---@diagnostic disable-next-line: duplicate-set-field
  statusline.section_location = function() return '%2l:%-2v' end
  --]]

  -- -----------------------------------------------------------
  -- Set lualine as statusline
  -- -----------------------------------------------------------
  vim.pack.add { gh 'nvim-lualine/lualine.nvim' }

  -- Function to display the current state of Copilot in the status line.
  local function copilot_status()
    -- Check if the copilot functions are loaded yet
    if vim.fn.exists('*copilot#Enabled') == 0 then
      return ' ' -- Waiting/Not loaded icon
    end

    -- Check if Copilot is enabled globally or for the current buffer
    if vim.fn['copilot#Enabled']() == 1 then
      return ' ' -- Active Copilot icon (NerdFont GitHub icon)
    else
      return ' ' -- Disabled icon
    end
  end

  -- To make your statusline reactive, we can leverage copilot#Status() instead of copilot#Enabled().
  -- copilot#Status() is a built-in Vimscript function provided by github/copilot.vim that explicitly
  -- reports whether the engine is Normal, Disabled, Loading/Waiting for a response, or experiencing
  -- an Error. By parsing this text, we can change both the icon and apply dynamic colors
  -- (e.g., green for ready, spinning orange/yellow for loading, grey/red for disabled) directly
  -- within Lualine.
  -- Helper function to evaluate the exact operational state of copilot.vim
  local function get_copilot_state()
    if vim.fn.exists('*copilot#Status') == 0 then
      return 'inactive'
    end

    local status = vim.fn['copilot#Status']()
    -- If status is an empty string, it means it is fully loaded and idling normally
    if status == '' then
      return 'normal'
    elseif status:match('^[~*]') or status:lower():match('loading') then
      return 'loading'
    else
      return 'disabled'
    end
  end

  -- 1. Dynamic Icon Function
  local function copilot_status_icon()
    local state = get_copilot_state()
    if state == 'loading' then
      return ' ' -- Loading/Spinning icon
    -- Note: If your terminal font doesn't display '', 
    -- you can use '⏳' or '🔄' as an alternative.
    elseif state == 'normal' then
      return ' ' -- Active Github Copilot icon
    else
      return ' ' -- Disabled icon
    end
  end

  -- 2. Dynamic Color Function
  local function copilot_status_color()
    local state = get_copilot_state()
    if state == 'loading' then
      return { fg = '#ffb86c', gui = 'bold' } -- Dracula Orange (Loading)
    elseif state == 'normal' then
      return { fg = '#50fa7b', gui = 'bold' } -- Dracula Green (Active)
    else
      return { fg = '#6272a4' }               -- Dracula Comment Grey (Disabled)
    end
  end

  require('lualine').setup {
    -- See `:help lualine.txt`
    options = {
      icons_enabled = true,
      -- To set theme and other options while in neovim:
      --    lua require('lualine').setup({
      --      options = {
      --        theme = 'dracula',
      --        component_separators = { left = '', right = '' },
      --        section_separators = { left = '', right = '' }
      --      }
      --    })
      --theme = 'auto',
      --theme = 'ayu_dark',
      --theme = 'material',
      --theme = 'moonfly',
      --theme = 'nightfly',
      theme = 'dracula',
      --component_separators = { left = '', right = '' },
      --component_separators = '|',
      component_separators = '',
      --section_separators = { left = '', right = '' },
      section_separators = '',
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false, -- 🛠️ Set to true to cleanly support Kickstart's layout (laststatus = 3), or set lastst = 2.
      refresh = {
        statusline = 1000,
        tabline = 1000,
        winbar = 1000,
      },
      --path = 1,
    },
    sections = {
      lualine_a = { 'mode' },
      --lualine_b = { 'filename' },
      lualine_b = { { 'filename', path = 1 } }, -- 🛠️ Correct place for path = 1
      lualine_c = { { 'branch', color = { fg = '#bb8800', gui = 'italic,bold' } }, 'diff', 'diagnostics' },
      --lualine_x = { 'encoding', 'fileformat', 'filetype' },
      -- 🛠️ Added the custom copilot_status function right here:
      --lualine_x = { copilot_status, 'encoding', 'fileformat', 'filetype' },
      -- 🛠️ Updated here to map both the icon function and its color rule dynamically:
      lualine_x = {
        { copilot_status_icon, color = copilot_status_color },
        'encoding',
        'fileformat',
        'filetype'
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = { 'mode' },
      --lualine_b = { 'filename' },
      lualine_b = { { 'filename', path = 1 } },
      lualine_c = { { 'branch', color = { fg = '#aa7700', gui = 'italic,bold' } }, 'diff', 'diagnostics' },
      --lualine_x = {},
      -- 🛠️ Added the custom copilot_status function right here:
      --lualine_x = { copilot_status },
      -- 🛠️ Added to inactive sections too so it updates across all splits smoothly
      lualine_x = {
        { copilot_status_icon, color = copilot_status_color }
      },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    --extensions = {},
    extensions = { 'fugitive' }, -- 🛠️ Clean statusline for your new Fugitive buffers
  }
  -- -----------------------------------------------------------

  -- ... and there is more!
  --  Check out: https://github.com/nvim-mini/mini.nvim
end

-- ============================================================
-- SECTION 5: SEARCH & NAVIGATION
-- Telescope setup, keymaps, LSP picker mappings
-- ============================================================
do
  -- [[ Fuzzy Finder (files, lsp, etc) ]]
  --
  -- Telescope is a fuzzy finder that comes with a lot of different things that
  -- it can fuzzy find! It's more than just a "file finder", it can search
  -- many different aspects of Neovim, your workspace, LSP, and more!
  --
  -- There are lots of other alternative pickers (like snacks.picker, or fzf-lua)
  -- so feel free to experiment and see what you like!
  --
  -- The easiest way to use Telescope, is to start by doing something like:
  --  :Telescope help_tags
  --
  -- After running this command, a window will open up and you're able to
  -- type in the prompt window. You'll see a list of `help_tags` options and
  -- a corresponding preview of the help.
  --
  -- Two important keymaps to use while in Telescope are:
  --  - Insert mode: <c-/>
  --  - Normal mode: ?
  --
  -- This opens a window that shows you all of the keymaps for the current
  -- Telescope picker. This is really useful to discover what Telescope can
  -- do as well as how to actually do it!

  ---@type (string|vim.pack.Spec)[]
  local telescope_plugins = {
    gh 'nvim-lua/plenary.nvim',
    gh 'nvim-telescope/telescope.nvim',
    gh 'nvim-telescope/telescope-ui-select.nvim',
  }
  if vim.fn.executable 'make' == 1 then table.insert(telescope_plugins, gh 'nvim-telescope/telescope-fzf-native.nvim') end

  -- NOTE: You can install multiple plugins at once
  vim.pack.add(telescope_plugins)

  -- See `:help telescope` and `:help telescope.setup()`
  require('telescope').setup {
    -- You can put your default mappings / updates / etc. in here
    --  All the info you're looking for is in `:help telescope.setup()`
    --
    -- defaults = {
    --   mappings = {
    --     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
    --   },
    -- },
    -- pickers = {}
    extensions = {
      ['ui-select'] = { require('telescope.themes').get_dropdown() },
    },
  }

  -- Enable Telescope extensions if they are installed
  pcall(require('telescope').load_extension, 'fzf')
  pcall(require('telescope').load_extension, 'ui-select')

  -- See `:help telescope.builtin`
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
  vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
  vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
  vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
  vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
  vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
  vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
  vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
  vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
  vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
  vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

  -- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
  -- If you later switch picker plugins, this is where to update these mappings.
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('telescope-lsp-attach', { clear = true }),
    callback = function(event)
      local buf = event.buf

      -- Find references for the word under your cursor.
      vim.keymap.set('n', 'grr', builtin.lsp_references, { buffer = buf, desc = '[G]oto [R]eferences' })

      -- Jump to the implementation of the word under your cursor.
      -- Useful when your language has ways of declaring types without an actual implementation.
      vim.keymap.set('n', 'gri', builtin.lsp_implementations, { buffer = buf, desc = '[G]oto [I]mplementation' })

      -- Jump to the definition of the word under your cursor.
      -- This is where a variable was first declared, or where a function is defined, etc.
      -- To jump back, press <C-t>.
      vim.keymap.set('n', 'grd', builtin.lsp_definitions, { buffer = buf, desc = '[G]oto [D]efinition' })

      -- Fuzzy find all the symbols in your current document.
      -- Symbols are things like variables, functions, types, etc.
      vim.keymap.set('n', 'gO', builtin.lsp_document_symbols, { buffer = buf, desc = 'Open Document Symbols' })

      -- Fuzzy find all the symbols in your current workspace.
      -- Similar to document symbols, except searches over your entire project.
      vim.keymap.set('n', 'gW', builtin.lsp_dynamic_workspace_symbols, { buffer = buf, desc = 'Open Workspace Symbols' })

      -- Jump to the type of the word under your cursor.
      -- Useful when you're not sure what type a variable is and you want to see
      -- the definition of its *type*, not where it was *defined*.
      vim.keymap.set('n', 'grt', builtin.lsp_type_definitions, { buffer = buf, desc = '[G]oto [T]ype Definition' })
    end,
  })

  -- Override default behavior and theme when searching
  vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to Telescope to change the theme, layout, etc.
    builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
      winblend = 10,
      previewer = false,
    })
  end, { desc = '[/] Fuzzily search in current buffer' })

  -- It's also possible to pass additional configuration options.
  --  See `:help telescope.builtin.live_grep()` for information about particular keys
  vim.keymap.set(
    'n',
    '<leader>s/',
    function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end,
    { desc = '[S]earch [/] in Open Files' }
  )

  -- Shortcut for searching your Neovim configuration files
  vim.keymap.set('n', '<leader>sn', function() builtin.find_files { cwd = vim.fn.stdpath 'config', follow = true } end, { desc = '[S]earch [N]eovim files' })
end

-- ============================================================
-- SECTION 6: LSP
-- LSP keymaps, server configuration, Mason tools installations
-- ============================================================
do
  -- [[ LSP Configuration ]]
  -- Brief aside: **What is LSP?**
  --
  -- LSP is an initialism you've probably heard, but might not understand what it is.
  --
  -- LSP stands for Language Server Protocol. It's a protocol that helps editors
  -- and language tooling communicate in a standardized fashion.
  --
  -- In general, you have a "server" which is some tool built to understand a particular
  -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
  -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
  -- processes that communicate with some "client" - in this case, Neovim!
  --
  -- LSP provides Neovim with features like:
  --  - Go to definition
  --  - Find references
  --  - Autocompletion
  --  - Symbol Search
  --  - and more!
  --
  -- Thus, Language Servers are external tools that must be installed separately from
  -- Neovim. This is where `mason` and related plugins come into play.
  --
  -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
  -- and elegantly composed help section, `:help lsp-vs-treesitter`

  -- Useful status updates for LSP.
  vim.pack.add { gh 'j-hui/fidget.nvim' }
  require('fidget').setup {}

  --  This function gets run when an LSP attaches to a particular buffer.
  --    That is to say, every time a new file is opened that is associated with
  --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
  --    function will be executed to configure the current buffer
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
    callback = function(event)
      -- NOTE: Remember that Lua is a real programming language, and as such it is possible
      -- to define small helper and utility functions so you don't have to repeat yourself.
      --
      -- In this case, we create a function that lets us more easily define mappings specific
      -- for LSP related items. It sets the mode, buffer and description for us each time.
      local map = function(keys, func, desc, mode)
        mode = mode or 'n'
        vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
      end

      -- Rename the variable under your cursor.
      --  Most Language Servers support renaming across files, etc.
      map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

      -- WARN: This is not Goto Definition, this is Goto Declaration.
      --  For example, in C this would take you to the header.
      map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

      -- The following two autocommands are used to highlight references of the
      -- word under your cursor when your cursor rests there for a little while.
      --    See `:help CursorHold` for information about when this is executed
      --
      -- When you move your cursor, the highlights will be cleared (the second autocommand).
      local client = vim.lsp.get_client_by_id(event.data.client_id)
      if client and client:supports_method('textDocument/documentHighlight', event.buf) then
        local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.document_highlight,
        })

        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
          buffer = event.buf,
          group = highlight_augroup,
          callback = vim.lsp.buf.clear_references,
        })

        vim.api.nvim_create_autocmd('LspDetach', {
          group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
          callback = function(event2)
            vim.lsp.buf.clear_references()
            vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
          end,
        })
      end

      -- The following code creates a keymap to toggle inlay hints in your
      -- code, if the language server you are using supports them
      --
      -- This may be unwanted, since they displace some of your code
      if client and client:supports_method('textDocument/inlayHint', event.buf) then
        map('<leader>th', function() vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf }) end, '[T]oggle Inlay [H]ints')
      end
    end,
  })

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --  See `:help lsp-config` for information about keys and how to configure
  ---@type table<string, vim.lsp.Config>
  local servers = {
    clangd = {},
    -- gopls = {},
    pyright = {},
    -- tsc = {},
    --
    -- Some languages (like rust) have entire language plugins that can be useful:
    --    https://github.com/mrcjkb/rustaceanvim
    --
    -- But for many setups, the LSP (`rust_analyzer`) will work just fine
    -- rust_analyzer = {},

    stylua = {}, -- Used to format Lua code

    -- Special Lua Config, as recommended by neovim help docs
    lua_ls = {
      on_init = function(client)
        client.server_capabilities.documentFormattingProvider = false -- Disable formatting (formatting is done by stylua)

        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if path ~= vim.fn.stdpath 'config' and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc')) then return end
        end

        local current_settings = client.config.settings --[[@as lspconfig.settings.lua_ls]]
        client.config.settings.Lua = vim.tbl_deep_extend('force', current_settings.Lua, {
          runtime = {
            version = 'LuaJIT',
            path = { 'lua/?.lua', 'lua/?/init.lua' },
          },
          workspace = {
            checkThirdParty = false,
            -- NOTE: this is a lot slower and will cause issues when working on your own configuration.
            --  See https://github.com/neovim/nvim-lspconfig/issues/3189
            library = vim.api.nvim_get_runtime_file('', true),
          },
        })
      end,
      ---@type lspconfig.settings.lua_ls
      settings = {
        Lua = {
          format = { enable = false }, -- Disable formatting (formatting is done by stylua)
        },
      },
    },
  }

  vim.pack.add {
    gh 'neovim/nvim-lspconfig',
    gh 'mason-org/mason.nvim',
    gh 'mason-org/mason-lspconfig.nvim',
    gh 'WhoIsSethDaniel/mason-tool-installer.nvim',
  }

  -- Automatically install LSPs and related tools to stdpath for Neovim
  require('mason').setup {}

  -- Translates between nvim-lspconfig server names and mason.nvim package names (e.g. lua_ls <-> lua-language-server)
  require('mason-lspconfig').setup {
    automatic_enable = false, -- Change this to true if you want to automatically enable servers that are installed manually (e.g. via :Mason / :MasonInstall)
  }

  -- Ensure the servers and tools above are installed
  --
  -- To check the current status of installed tools and/or manually install
  -- other tools, you can run
  --    :Mason
  --
  -- You can press `g?` for help in this menu.
  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    -- You can add other tools here that you want Mason to install
  })

  require('mason-tool-installer').setup { ensure_installed = ensure_installed }

  for name, server in pairs(servers) do
    vim.lsp.config(name, server)
    vim.lsp.enable(name)
  end
end

-- ============================================================
-- SECTION 7: FORMATTING
-- conform.nvim setup and keymap
-- ============================================================
do
  -- [[ Formatting ]]
  vim.pack.add { gh 'stevearc/conform.nvim' }
  require('conform').setup {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- You can specify filetypes to autoformat on save here:
      local enabled_filetypes = {
        -- lua = true,
        -- python = true,
      }
      if enabled_filetypes[vim.bo[bufnr].filetype] then
        return { timeout_ms = 500 }
      else
        return nil
      end
    end,
    default_format_opts = {
      lsp_format = 'fallback', -- Use external formatters if configured below, otherwise use LSP formatting. Set to `false` to disable LSP formatting entirely.
    },
    -- You can also specify external formatters in here.
    formatters_by_ft = {
      -- rust = { 'rustfmt' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      -- javascript = { "prettierd", "prettier", stop_after_first = true },
    },
  }

  vim.keymap.set({ 'n', 'v' }, '<leader>f', function() require('conform').format { async = true } end, { desc = '[F]ormat buffer' })
end

-- ============================================================
-- SECTION 8: AUTOCOMPLETE & SNIPPETS
-- blink.cmp and luasnip setup
-- ============================================================
do
  -- [[ Snippet Engine ]]

  -- NOTE: You can also specify plugin using a version range for its git tag.
  --  See `:help vim.version.range()` for more info
  vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
  require('luasnip').setup {}

  -- `friendly-snippets` contains a variety of premade snippets.
  --    See the README about individual language/framework/plugin snippets:
  --    https://github.com/rafamadriz/friendly-snippets
  --
  -- vim.pack.add { gh 'rafamadriz/friendly-snippets' }
  -- require('luasnip.loaders.from_vscode').lazy_load()

  -- [[ Autocomplete Engine ]]
  vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
  require('blink.cmp').setup {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See `:help blink-cmp-config-keymap` for defining your own keymap
      preset = 'default',

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      --nerd_font_variant = 'mono',
      nerd_font_variant = 'normal',
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },

    sources = {
      default = { 'lsp', 'path', 'snippets' },
    },

    snippets = { preset = 'luasnip' },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See `:help blink-cmp-config-fuzzy` for more information
    fuzzy = { implementation = 'lua' },

    -- Shows a signature help window while you type arguments for a function
    signature = { enabled = true },
  }
end

-- ============================================================
-- SECTION 9: TREESITTER
-- Parser installation, syntax highlighting, folds, indentation
-- ============================================================
do
  -- [[ Configure Treesitter ]]
  --  Used to highlight, edit, and navigate code
  --
  --  See `:help nvim-treesitter-intro`

  -- NOTE: You can also specify a branch or a specific commit
  vim.pack.add { { src = gh 'nvim-treesitter/nvim-treesitter', version = 'main' } }

  -- Ensure basic parsers are installed
  local parsers = { 'bash', 'c', 'cpp', 'diff', 'html', 'javascript', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'python', 'query', 'vim', 'vimdoc' }
  require('nvim-treesitter').install(parsers)

  ---@param buf integer
  ---@param language string
  local function treesitter_try_attach(buf, language)
    -- Check if a parser exists and load it
    if not vim.treesitter.language.add(language) then return end
    -- Enable syntax highlighting and other treesitter features
    vim.treesitter.start(buf, language)

    -- Enable treesitter based folds
    -- For more info on folds see `:help folds`
    vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo.foldmethod = 'expr'
    -- Code folding with treesitter.
    --vim.o.foldmethod = 'expr'
    --vim.o.foldexpr = 'nvim_treesitter#foldexpr()'

    -- Check if treesitter indentation is available for this language, and if so enable it
    -- in case there is no indent query, the indentexpr will fallback to the vim's built in one
    local has_indent_query = vim.treesitter.query.get(language, 'indents') ~= nil

    -- Enable treesitter based indentation
    if has_indent_query then vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" end
  end

  local available_parsers = require('nvim-treesitter').get_available()
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local buf, filetype = args.buf, args.match

      local language = vim.treesitter.language.get_lang(filetype)
      if not language then return end

      local installed_parsers = require('nvim-treesitter').get_installed 'parsers'

      if vim.tbl_contains(installed_parsers, language) then
        -- Enable the parser if it is already installed
        treesitter_try_attach(buf, language)
      elseif vim.tbl_contains(available_parsers, language) then
        -- If a parser is available in `nvim-treesitter`, auto-install it and enable it after the installation is done
        require('nvim-treesitter').install(language):await(function() treesitter_try_attach(buf, language) end)
      else
        -- Try to enable treesitter features in case the parser exists but is not available from `nvim-treesitter`
        treesitter_try_attach(buf, language)
      end
    end,
  })
end

-- ============================================================
-- SECTION 10: OPTIONAL EXAMPLES / NEXT STEPS
-- kickstart.plugins.* examples
-- ============================================================
do
  -- The following comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug'
  -- require 'kickstart.plugins.indent_line'
  require 'kickstart.plugins.lint'
  require 'kickstart.plugins.autopairs'
  -- require 'kickstart.plugins.neo-tree'

  -- NOTE: You can add your own plugins, configuration, etc. in `lua/custom/plugins/*.lua`.
  --
  -- For independent modules, uncomment the convenience loader:
  -- require 'custom.plugins'
  --
  -- `custom.plugins` automatically loads files from that directory, but their
  -- order is unspecified. If plugins depend on each other, keep them in the same
  -- file and put their `vim.pack.add()` and `setup()` calls in the required order.
  --
  -- If separate modules need a specific order, require them explicitly instead:
  -- require 'custom.plugins.colorscheme'
  -- require 'custom.plugins.ui'
  -- require 'custom.plugins.git'

  -- -----------------------------------------------------------
  -- Git plugin from Tim Pope
  -- -----------------------------------------------------------
  vim.pack.add { gh 'tpope/vim-fugitive' }
  -- Some useful keymaps for vim-fugitive (Repository Control)
  vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { desc = 'Git status panel' })
  vim.keymap.set('n', '<leader>gc', ':Git commit<CR>', { desc = 'Git commit' })
  vim.keymap.set('n', '<leader>gp', ':Git push<CR>', { desc = 'Git push' })
  vim.keymap.set('n', '<leader>gl', ':Git log --oneline<CR>', { desc = 'Git log summary' })

  -- -----------------------------------------------------------
  -- Show a lightbulb icon next to a quickfix suggestion by lsp.
  -- -----------------------------------------------------------
  vim.pack.add { gh 'kosayoda/nvim-lightbulb' }
  require('nvim-lightbulb').setup {
    autocmd = { enabled = true },
  }

  -- -----------------------------------------------------------
  -- Add indentation guides even on blank lines
  -- -----------------------------------------------------------
  -- 1. Register the plugin with Neovim's native package manager
  vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }

  -- 2. Define a custom pale color for your lines.
  -- Linking to 'LineNr' forces it to use your theme's quietest text color (like line numbers).
  --vim.api.nvim_set_hl(0, 'IblSubtleIndent', { link = 'LineNr', nocombine = true })
  -- OR Define your exact pale color using your preferred hex code
  -- This targets ONLY the indent lines, leaving your actual line numbers readable.
  vim.api.nvim_set_hl(0, 'IblSubtleIndent', { fg = '#0b1231', nocombine = true })

  -- 3. Configure and initialize the plugin using the native 'ibl' module
  require('ibl').setup {
    indent = {
      -- '│' is a thin standard box character that spans the full line height
      -- Other options for the character used to draw the indent guides:
      -- '▏'
      -- '┆'
      -- '│' -- box drawings light vertical
      -- '⸾' -- wiggly vertical line
      -- '⁞' -- vertical four dots
      -- '⸽' -- vertical six dots
      -- '⎸' -- left vertical box line
      -- '⎹' -- right vertical box line
      -- '|' -- vertical line
      -- '┊' -- box drawings light quadruple dash vertical
      -- '⋮' -- vertical ellipsis
      -- '╎' -- box drawings light double dash vertical
      -- '￨' -- halfwidth forms light vertical
      char = '│',
      tab_char = '│',
      highlight = { 'IblSubtleIndent' },
    },
    scope = {
      -- Disable active scope highlighting to keep ALL lines identically pale
      enabled = false,
    },
  }

  -- -----------------------------------------------------------
  -- Hilight text in different colors.
  -- -----------------------------------------------------------
  vim.pack.add { gh 'inkarkat/vim-ingo-library' } -- needed by vim-mark
  vim.pack.add { gh 'inkarkat/vim-mark' }
  --  config = function()
      -- enable the automatic restore of marks from a previous Vim session.
      vim.api.nvim_set_var('mwAutoLoadMarks', 1)
      -- In Mark plugin, replace conflicting maps.
      -- Don't use \n and \# used by NerdTree.  Replace with ,,n and ,,#.
      -- Don't use \r used by coc, replace with ,,r.
      vim.keymap.set('n', '\\c', '<Plug>MarkClear')
      vim.keymap.set('x', '\\X', '<Plug>MarkRegex')
      vim.keymap.set('n', '\\X', '<Plug>MarkRegex')
      --vim.keymap.set('n', '\\?', '<Plug>MarkSearchAnyPrev')
      vim.keymap.set('n', '<ac-p>', '<Plug>MarkSearchAnyPrev')
      --vim.keymap.set('n', '\\/', '<Plug>MarkSearchAnyNext')
      vim.keymap.set('n', '<ac-n>', '<Plug>MarkSearchAnyNext')
      vim.keymap.set('n', '<a-p>', '<Plug>MarkSearchCurrentPrev')
      vim.keymap.set('n', '<a-n>', '<Plug>MarkSearchCurrentNext')
      vim.keymap.set('x', '\\m', '<Plug>MarkSet')
      vim.keymap.set('n', '\\m', '<Plug>MarkSet')

      vim.keymap.set('n', '\\M', '<Plug>MarkToggle')
      vim.keymap.set('n', '\\N', '<Plug>MarkAllClear')
      --[[
      vim.keymap.set('n', '<Leader>M', '<Plug>MarkToggle')
      vim.keymap.set('n', '<Leader>N', '<Plug>MarkAllClear')
      vim.keymap.set('n', '<Leader>N', '<Plug>MarkConfirmAllClear')
      vim.keymap.set('n', '<Plug>IgnoreMarkSearchNext', '<Plug>MarkSearchNext')
      vim.keymap.set('n', '<Plug>IgnoreMarkSearchPrev', '<Plug>MarkSearchPrev')
      vim.keymap.set('n', '*', '<Plug>MarkSearchOrCurNext')
      vim.keymap.set('n', '#', '<Plug>MarkSearchOrCurPrev')
      vim.keymap.set('n', '*', '<Plug>MarkSearchOrAnyNext')
      vim.keymap.set('n', '#', '<Plug>MarkSearchOrAnyPrev')
      vim.keymap.set('n', 'n', '<Plug>MarkSearchAnyOrDefaultNext')
      vim.keymap.set('n', 'N', '<Plug>MarkSearchAnyOrDefaultPrev')
      vim.keymap.set('n', '*', '<Plug>MarkSearchGroupNext')
      vim.keymap.set('n', '#', '<Plug>MarkSearchGroupPrev')
      vim.keymap.set('n', '<Leader>1', '<Plug>MarkSearchGroup1Next')
      vim.keymap.set('n', '<Leader>!', '<Plug>MarkSearchGroup1Prev')
      vim.keymap.set('n', '<Leader>+*', '<Plug>MarkSearchUsedGroupNext')
      vim.keymap.set('n', '<Leader>-*', '<Plug>MarkSearchUsedGroupPrev')
      --]]
  --  end,
  --}

  -- Show colors (#abcdef, red, etc) in CSS files.
  -- NOTE: commenting out, causing problems with LSP.
  --vim.pack.add { gh 'ap/vim-css-color' }
  --require(vim-css-color').setup {}

  -- -----------------------------------------------------------
  -- DirDiff
  -- -----------------------------------------------------------
  vim.pack.add { gh 'will133/vim-dirdiff' }

  -- -----------------------------------------------------------
  -- Vim sessions
  -- -----------------------------------------------------------
  vim.pack.add { gh 'tpope/vim-obsession' }

  -- -----------------------------------------------------------
  -- undotree
  -- -----------------------------------------------------------
  vim.pack.add { gh 'mbbill/undotree' }

  -- -----------------------------------------------------------
  -- nvim-tree
  -- -----------------------------------------------------------
  vim.pack.add { gh 'nvim-tree/nvim-web-devicons' } -- needed by nvim-tree
  vim.pack.add { gh 'nvim-tree/nvim-tree.lua' }
  -- disable netrw at the very start of your init.lua
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  local function nvimtree_on_attach(bufnr)
    local api = require 'nvim-tree.api'
    local function opts(desc)
      return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end
    -- default mappings
    api.map.on_attach.default(bufnr)
    -- custom mappings
    vim.keymap.set('n', '<c-u>', api.tree.change_root_to_parent, opts 'Up')
    vim.keymap.set('n', '?', api.tree.toggle_help, opts 'Help')
  end
  -- pass to setup along with your other options
  require('nvim-tree').setup {
    sort_by = 'case_sensitive',
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
      update_root = { enable = false },
    },
  }
  local api = require 'nvim-tree.api'
  vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'Toggle nvimtree' })
  vim.keymap.set('n', '<leader>tf', api.tree.focus, { desc = 'Focus nvimtree' })

  -- -----------------------------------------------------------
  -- Copilot
  -- -----------------------------------------------------------
  -- 1. Load the Core Copilot Engine (Requires authenticating via :Copilot setup)
  vim.pack.add { gh 'github/copilot.vim' }
  -- 2. Load CopilotChat
  vim.pack.add { gh 'CopilotC-Nvim/CopilotChat.nvim' }
  -- NOTE: plenary is already added for telescope, so commented out here.
  --vim.pack.add { { src = gh 'nvim-lua/plenary.nvim', version = 'master' } } -- for curl, log and async functions
  -- 3. Configure CopilotChat (Strictly settings inside .setup)
  require('CopilotChat').setup {
    -- model = 'gpt-4o', -- Sets your default baseline model
    --[[
    mappings = {
      submit_prompt = {
        normal = '<Leader>s',
        insert = '<C-s>'
      },
      show_diff = {
        full_diff = true
      },
      complete = {
        -- insert = '<Tab>',
        insert = '<Right>',
      },
    },
    --]]
  }
  -- 4. Explicitly bind ALL Keymaps using standard Neovim API
  -- Toggle Main Chat
  vim.keymap.set('n', '<leader>cc', '<cmd>CopilotChatToggle<CR>', { desc = 'Toggle CopilotChat', silent = true })
  -- Code context helpers (Visual mode maps let you send highlighted blocks to the chat)
  vim.keymap.set({'n', 'v'}, '<leader>cce', '<cmd>CopilotChatExplain<CR>', { desc = 'CopilotChat - Explain code' })
  vim.keymap.set({'n', 'v'}, '<leader>cct', '<cmd>CopilotChatTests<CR>', { desc = 'CopilotChat - Generate tests' })

  -- By default, Copilot binds <Tab> to accept a suggestion.
  -- However, this often conflicts with native completion engines (like nvim-cmp or blink.cmp used by Kickstart).
  -- To fix this and give you full control over cycling through multiple alternative AI suggestions,
  -- add these global variables and keymaps to your init.lua:lua
  -- 1. Disable the default <Tab> binding to prevent completion plugin conflicts
  vim.g.copilot_no_tab_map = true
  -- 2. Inline Suggestion Keymaps
  vim.keymap.set('i', '<C-y>', 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false, desc = 'Copilot - Accept suggestion' })
  vim.keymap.set('i', '<M-]>', '<Plug>(copilot-next)', { desc = 'Copilot - Next suggestion' })
  vim.keymap.set('i', '<M-[>', '<Plug>(copilot-previous)', { desc = 'Copilot - Previous suggestion' })
  vim.keymap.set('i', '<C-e>', '<Plug>(copilot-dismiss)', { desc = 'Copilot - Dismiss suggestion' })

  -- CopilotChat shortcuts
  -- CopilotChat can parse selected text directly.
  -- Adding these keymaps lets you highlight a messy block of code in Visual Mode
  -- and instantly send it to the AI for specific tasks:
  -- 1. Context-aware operations (Works in Normal and Visual mode)
  vim.keymap.set({'n', 'v'}, '<leader>ccf', '<cmd>CopilotChatFix<CR>', { desc = 'CopilotChat - Fix code bugs' })
  vim.keymap.set({'n', 'v'}, '<leader>cco', '<cmd>CopilotChatOptimize<CR>', { desc = 'CopilotChat - Optimize performance' })
  vim.keymap.set({'n', 'v'}, '<leader>ccr', '<cmd>CopilotChatReview<CR>', { desc = 'CopilotChat - Review code' })
  -- 2. Open Chat directly with a custom open prompt
  vim.keymap.set('n', '<leader>ccq', function()
    local input = vim.fn.input("Copilot Quick Chat: ")
    if input ~= "" then
      require("CopilotChat").ask("#selection " .. input)
    end
  end, { desc = "CopilotChat - Quick chat buffer" })

  -- Smart Configuration: Performance & File Exclusions
  -- You generally don't want Copilot trying to generate text while you're writing markdown documentation,
  -- or wasting computer resources scanning massive text logs or lockfiles.
  -- You can configure global rules using vim.g.copilot_filetypes:
  vim.g.copilot_filetypes = {
    ['*'] = true,           -- Enable everywhere else by default
    ['markdown'] = false,   -- Disable in markdown files
    ['text'] = false,       -- Disable in plain text files
    ['gitcommit'] = false,  -- Disable when writing Git commit messages (Fugitive handles this better!)
    ['yaml'] = false,       -- Often annoying in complex configuration files
  }

  -- Force enable or disable Copilot on demand for the active file
  vim.keymap.set('n', '<leader>ce', '<cmd>Copilot enable<CR>', { desc = 'Copilot - Force enable for buffer' })
  vim.keymap.set('n', '<leader>cd', '<cmd>Copilot disable<CR>', { desc = 'Copilot - Force disable for buffer' })

  -- -----------------------------------------------------------
  -- Display ANSI escape sequences as colors.
  -- -----------------------------------------------------------
  -- NOTE: Disable for now, because it seems to conflict with vim-mark.
  --vim.pack.add { gh 'powerman/vim-plugin-AnsiEsc' }
  --require('vim-plugin-AnsiEsc').setup {}
end

-- ============================================================
-- Highlights
-- ============================================================
vim.cmd [[
" I don't like tokyonight-night's greyish-blue background
hi Normal guibg=#000000
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
hi Search guifg=#800080 guibg=#ffc070
]]

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

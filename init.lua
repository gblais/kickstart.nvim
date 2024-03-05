--[[
{{{

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
    make Neovim your own! That might mean leaving kickstart just the way it is for a while
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

    (If you already know how the Neovim basics, you can skip this step)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not sure exactly what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or neovim features used in kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your nvim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
}}}
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]] {{{
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
-- }}} [[ Setting options ]]

-- [[ Setting more options ]] {{{
-- Set highlight on search
vim.opt.hlsearch = false
vim.opt.autoindent=true       -- Copy indent from current line when starting a new line.
vim.opt.belloff='all'         -- Turn off bell for everything.
vim.opt.colorcolumn='+1'      -- Highlight column at textwidth.
vim.opt.complete='.,w,b,u,t'  -- Better Completion
-- Set completeopt to have a better completion experience
-- vim.opt.completeopt = 'menuone,noselect'
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
                              -- NOTE: You should make sure your terminal supports this
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

-- }}} [[ Setting more options ]]

-- [[ Basic Keymaps ]] {{{
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
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
-- }}} [[ Basic Keymaps ]]

-- [[ Other Mappings ]] {{{

--vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
--vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
--vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

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
-- }}} [[ Other Mappings ]]

-- [[ Basic Autocommands ]] {{{
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
-- }}} [[ Basic Autocommands ]]

-- vim-mark {{{
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
-- turn off the creation of the default mappings.
vim.g.mw_no_mappings = 1
-- }}} vim-mark

-- [[ Install `lazy.nvim` plugin manager ]] {{{
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
-- }}}

-- [[ Configure and install plugins ]] {{{
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins, you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to next hunk' })

        map({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, desc = 'Jump to previous hunk' })

        -- Actions
        -- visual mode
        map('v', '<leader>hs', function()
          gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'stage git hunk' })
        map('v', '<leader>hr', function()
          gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
        end, { desc = 'reset git hunk' })
        -- normal mode
        map('n', '<leader>hs', gs.stage_hunk, { desc = 'git stage hunk' })
        map('n', '<leader>hr', gs.reset_hunk, { desc = 'git reset hunk' })
        map('n', '<leader>hS', gs.stage_buffer, { desc = 'git Stage buffer' })
        map('n', '<leader>hu', gs.undo_stage_hunk, { desc = 'undo stage hunk' })
        map('n', '<leader>hR', gs.reset_buffer, { desc = 'git Reset buffer' })
        map('n', '<leader>hp', gs.preview_hunk, { desc = 'preview git hunk' })
        map('n', '<leader>hb', function()
          gs.blame_line { full = false }
        end, { desc = 'git blame line' })
        map('n', '<leader>hd', gs.diffthis, { desc = 'git diff against index' })
        map('n', '<leader>hD', function()
          gs.diffthis '~'
        end, { desc = 'git diff against last commit' })

        -- Toggles
        map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = 'toggle git blame line' })
        map('n', '<leader>td', gs.toggle_deleted, { desc = 'toggle git show deleted' })

        -- Text object
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = 'select git hunk' })
      end,
    },
  },
  -- Other gitsigns configuration examples
  --[[
  -- {{{
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
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
        vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = '[G]o to [P]revious Hunk' })
        vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = '[G]o to [N]ext Hunk' })
        vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = '[P]review [H]unk' })
      end,

      -- {{{
      -- on_attach = function(bufnr)
      --   if vim.api.nvim_buf_get_name(bufnr):match('<PATTERN>') then
      --     -- Don't attach to specific buffers whose name matches a pattern
      --     return false
      --   end
      --
      --   -- Setup keymaps
      --   --vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', '<cmd>lua require"gitsigns".stage_hunk()<CR>', {})
      --   vim.api.nvim_buf_set_keymap(bufnr, 'n', 'hs', require('gitsigns').stage_hunk, { desc = '[H]unk [S]tage' })
      -- end,
      -- }}}

      -- From: https://github.com/omerxx/dotfiles/blob/master/nvim/init.lua {{{
      -- https://www.youtube.com/watch?v=IyBAuDPzdFY
      -- on_attach = function(bufnr)
      --   local gs = package.loaded.gitsigns

      --   local function map(mode, l, r, opts)
      --     opts = opts or {}
      --     opts.buffer = bufnr
      --     vim.keymap.set(mode, l, r, opts)
      --   end

      --   -- Navigation
      --   map('n', ']c', function()
      --     if vim.wo.diff then return ']c' end
      --     vim.schedule(function() gs.next_hunk() end)
      --     return '<Ignore>'
      --   end, {expr=true, desc='next hunk'})

      --   map('n', '[c', function()
      --     if vim.wo.diff then return '[c' end
      --     vim.schedule(function() gs.prev_hunk() end)
      --     return '<Ignore>'
      --   end, {expr=true, desc='previous hunk'})

      --   -- Actions
      --   map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
      --   map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
      --   map('n', '<leader>hS', gs.stage_buffer, {desc='stage buffer'})
      --   map('n', '<leader>ha', gs.stage_hunk, {desc='stage hunk'})
      --   map('n', '<leader>hu', gs.undo_stage_hunk, {desc='undo_stage_hunk'})
      --   map('n', '<leader>hR', gs.reset_buffer, {desc='reset_buffer'})
      --   map('n', '<leader>hp', gs.preview_hunk, {desc='preview_hunk'})
      --   map('n', '<leader>hb', function() gs.blame_line{full=true} end, {desc='blame_line'})
      --   map('n', '<leader>tb', gs.toggle_current_line_blame, {desc='toggle_current_line_blame'})
      --   map('n', '<leader>hd', gs.diffthis, {desc='diffthis'})
      --   map('n', '<leader>hD', function() gs.diffthis('~') end, {desc='diffthis ~'})
      --   map('n', '<leader>td', gs.toggle_deleted, {desc='toggle_deleted'})

      --   -- Text object
      --   map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
      -- end,
      --}}}
    },
  },
  -- }}}
  --]]

  -- NOTE: Plugins can also be configured to run lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for install instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires special font.
      --  If you already have a Nerd Font, or terminal set up with fallback fonts
      --  you can enable this
      { 'nvim-tree/nvim-web-devicons' }
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of help_tags options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
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
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Brief Aside: **What is LSP?**
      --
      -- LSP is an acronym you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
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

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself
          -- many times.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-T>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        clangd = {},
        -- gopls = {},
        pyright = {},
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --

        lua_ls = {
          -- cmd = {...},
          -- filetypes { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              runtime = { version = 'LuaJIT' },
              workspace = {
                checkThirdParty = false,
                -- Tells lua_ls where to find all the Lua files that you have loaded
                -- for your neovim configuration.
                library = {
                  '${3rd}/luv/library',
                  unpack(vim.api.nvim_get_runtime_file('', true)),
                },
                -- If lua_ls is really slow on your computer, you can try this instead:
                -- library = { vim.env.VIMRUNTIME },
              },
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- If you want to add a bunch of pre-configured snippets,
      --    you can use this plugin to help you. It even has snippets
      --    for various frameworks/libraries/etc. but you will have to
      --    set up the ones that are useful for you.
      -- 'rafamadriz/friendly-snippets',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
          -- Add <C-g> mapping for accepting completion with copilot.vim.
          --[[
          ['<C-g>'] = cmp.mapping(function(fallback)
            vim.api.nvim_feedkeys(vim.fn['copilot#Accept'](vim.api.nvim_replace_termcodes('<Tab>', true, true, true)), 'n', true)
          end)
          --]]
        },
        --[[
        experimental = {
          ghost_text = false -- this feature conflict with copilot.vim's preview.
        },
        --]]
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        },
      }
    end,
  },

  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`
    'folke/tokyonight.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require('tokyonight').setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day", -- The theme is used when the background is set to light
        transparent = true, -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in [Neovim](https://github.com/neovim/neovim)
        styles = {
          -- Style to be applied to different syntax groups
          -- Value is any valid attr-list value for `:help nvim_set_hl`
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "dark", -- style for sidebars, see below
          floats = "dark", -- style for floating windows
        },
        sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
        day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
        hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
        dim_inactive = false, -- dims inactive windows
        lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold
      
        --- You can override specific color groups to use other groups or a hex color
        --- function will be called with a ColorScheme table
        ---@param colors ColorScheme
        on_colors = function(colors) end,
      
        --- You can override specific highlights to use other groups or a hex color
        --- function will be called with a Highlights and ColorScheme table
        ---@param highlights Highlights
        ---@param colors ColorScheme
        on_highlights = function(highlights, colors) end,
      })
      -- Load the colorscheme here
      vim.cmd.colorscheme 'tokyonight-night'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  --[[
  { -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.api.nvim_set_var('onedark_config', { style = 'dark', transparent = 'true' })
      vim.cmd.colorscheme 'onedark'
    end,
  },
  --]]

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      statusline.setup()

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'bash', 'c', 'cpp', 'html', 'lua', 'python', 'markdown', 'javascript', 'vim', 'vimdoc' },
        -- Autoinstall languages that are not installed
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects

      -- Code folding with treesitter.
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
    end,
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- put them in the right spots if you want.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for kickstart
  --
  --  Here are some example plugins that I've included in the kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },


  -- Git related plugins
  'tpope/vim-fugitive',
  --'tpope/vim-rhubarb', -- Enables :GBrowse from fugitive.vim to open GitHub URLs.

  { -- Show a lightbulb icon next to a quickfix suggestion by lsp.
    'kosayoda/nvim-lightbulb' },

  --[[
  { -- Set lualine as statusline
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
  --]]

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
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

  { -- Hilight text in different colors.
    'inkarkat/vim-mark',
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
      vim.keymap.set('x', '\\X', "<Plug>MarkRegex")
      vim.keymap.set('n', '\\X', "<Plug>MarkRegex")
      --vim.keymap.set('n', '\\?', "<Plug>MarkSearchAnyPrev")
      vim.keymap.set('n', '<ac-p>', "<Plug>MarkSearchAnyPrev")
      --vim.keymap.set('n', '\\/', "<Plug>MarkSearchAnyNext")
      vim.keymap.set('n', '<ac-n>', "<Plug>MarkSearchAnyNext")
      vim.keymap.set('n', '<a-p>', "<Plug>MarkSearchCurrentPrev")
      vim.keymap.set('n', '<a-n>', "<Plug>MarkSearchCurrentNext")
      vim.keymap.set('x', '\\m', "<Plug>MarkSet")
      vim.keymap.set('n', '\\m', "<Plug>MarkSet")

      vim.keymap.set('n', '\\M', "<Plug>MarkToggle")
      vim.keymap.set('n', '\\N', "<Plug>MarkAllClear")
      --[[
      vim.keymap.set('n', '<Leader>M', "<Plug>MarkToggle")
      vim.keymap.set('n', '<Leader>N', "<Plug>MarkAllClear")
      vim.keymap.set('n', '<Leader>N', "<Plug>MarkConfirmAllClear")
      vim.keymap.set('n', '<Plug>IgnoreMarkSearchNext', "<Plug>MarkSearchNext")
      vim.keymap.set('n', '<Plug>IgnoreMarkSearchPrev', "<Plug>MarkSearchPrev")
      vim.keymap.set('n', '*', "<Plug>MarkSearchOrCurNext")
      vim.keymap.set('n', '#', "<Plug>MarkSearchOrCurPrev")
      vim.keymap.set('n', '*', "<Plug>MarkSearchOrAnyNext")
      vim.keymap.set('n', '#', "<Plug>MarkSearchOrAnyPrev")
      vim.keymap.set('n', 'n', "<Plug>MarkSearchAnyOrDefaultNext")
      vim.keymap.set('n', 'N', "<Plug>MarkSearchAnyOrDefaultPrev")
      vim.keymap.set('n', '*', "<Plug>MarkSearchGroupNext")
      vim.keymap.set('n', '#', "<Plug>MarkSearchGroupPrev")
      vim.keymap.set('n', '<Leader>1', "<Plug>MarkSearchGroup1Next")
      vim.keymap.set('n', '<Leader>!', "<Plug>MarkSearchGroup1Prev")
      vim.keymap.set('n', '<Leader>+*', "<Plug>MarkSearchUsedGroupNext")
      vim.keymap.set('n', '<Leader>-*', "<Plug>MarkSearchUsedGroupPrev")
      --]]
    end,
  },

  -- Show colors (#abcdef, red, etc) in CSS files.
  'ap/vim-css-color',

  -- DirDiff
  'will133/vim-dirdiff',

  -- Vim sessions
  'tpope/vim-obsession',

  'mbbill/undotree',

  { -- file managing , picker etc
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      --vim.g.nvim_tree_respect_buf_cwd = 1
      require("nvim-tree").setup {}
      local api = require("nvim-tree.api")
      vim.keymap.set('n', '<leader>tt', api.tree.toggle, { desc = 'Toggle nvimtree' })
      vim.keymap.set('n', '<leader>tf', api.tree.focus, { desc = 'Focus nvimtree' })
    end,
  },

  { -- To work well with 'navigator' tmux plugin.
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      --{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
      { "<c-^>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },

  -- GitHub CoPilot
  'github/copilot.vim',
}
-- }}} [[ Configure and install plugins ]]

-- [[ Configure nvim lightbulb ]] {{{
require("nvim-lightbulb").setup({
  autocmd = { enabled = true }
})
-- }}} [[ Configure nvim lightbulb ]]

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

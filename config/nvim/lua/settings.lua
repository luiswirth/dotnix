vim.cmd('set notimeout')
vim.cmd('set ttimeout')
vim.cmd('set shortmess+=c')           -- do not pass messages to |ins-completion-menu|.
vim.o.hidden=true                     -- required to keep multiple buffers open
vim.o.wrap=false                      -- disable text wrap
vim.cmd('set whichwrap+=<,>,[,],h,l') -- ?
vim.o.encoding="utf-8"                -- display utf-8 encoding
vim.o.pumheight=10                    -- smaller popup menu
vim.o.fileencoding="utf-8"            -- write uft-8 encoding
vim.o.ruler=true              		    -- always show cursor
vim.o.cmdheight=1                     -- more space for displaying messages
vim.o.mouse="a"                       -- enable mouse
vim.o.splitbelow=true                 -- horizontal splits will be below
vim.o.splitright=true                 -- vertical splits will be to the right
vim.o.conceallevel=0                  -- see ``
vim.o.tabstop=2                       -- tab is 2 spaces
vim.o.softtabstop=2                   -- tab is 2 spaces
vim.o.shiftwidth=2                    -- indentation is 2 spaces
vim.cmd('set ts=2')
vim.cmd('set sw=2')
vim.o.smarttab=true                   -- smarter tabs
vim.o.expandtab=true                  -- automatically convert tabs to spaces
vim.o.smartindent=true                -- smart indentation
vim.o.autoindent=true                 -- auto indentation
vim.o.laststatus=2                    -- always display status line
vim.o.number=true                    -- absolute line number
vim.o.relativenumber=true            -- relative line number

vim.o.background="dark"               -- dark background
vim.o.showtabline=2                   -- show tabline
vim.o.backup=false                    -- no backup
vim.o.writebackup=false               -- still no backup
vim.wo.signcolumn="yes"               -- always show symbol column on the right
vim.o.updatetime=300                  -- fast completion
vim.o.timeoutlen=100                  -- timeout 100ms
vim.o.incsearch=true
vim.o.foldmethod="manual"

vim.cmd("set colorcolumn=80")

--
vim.o.termguicolors=true              -- ?

vim.cmd("set nofoldenable")

vim.cmd("set nrformats+=alpha")       -- C-a also works on letters (lexicalgraphic increase)


vim.o.clipboard="unnamedplus"         -- use system clipboard

vim.diagnostic.config({underline=true});

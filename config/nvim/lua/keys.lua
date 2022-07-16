local set = vim.api.nvim_set_keymap
local opt = { silent = true, noremap = true }

-- trouble keybindings
set("n", "<leader>lD", "<cmd>Trouble workspace_diagnostics<cr>", opt)
set("n", "<leader>ld", "<cmd>Trouble document_diagnostics<cr>", opt)
set("n", "<leader>vl", "<cmd>Trouble loclist<cr>", opt)
set("n", "<leader>vq", "<cmd>Trouble quickfix<cr>", opt)
set("n", "<space>lr", "<cmd>Trouble lsp_references<cr>", opt)

-- luasnip keybindings
vim.cmd [[
  imap <silent><expr> <c-k> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<c-k>'
  inoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
  imap <silent><expr> <C-l> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-l>'
  snoremap <silent> <c-k> <cmd>lua require('luasnip').jump(1)<CR>
  snoremap <silent> <c-j> <cmd>lua require('luasnip').jump(-1)<CR>
]]

set('n', 'H', '^', opt);
set('x', 'H', '^', opt);
set('n', 'L', '$', opt);
set('x', 'L', '$', opt);

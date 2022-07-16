 local luadev = require('lua-dev')
 local lspconfig = require('lspconfig')
 lspconfig.sumneko_lua.setup(luadev)

--local sumneko_root_path = "/usr/share/lua-language-server"
--local sumneko_binary = "/usr/bin/lua-language-server"
--
--require('lspconfig').sumneko_lua.setup {
--    cmd = {sumneko_binary, "-E", sumneko_root_path .. "/main.lua"},
--    on_attach = require('lsp').on_attach,
--    capabilities = require('lsp-status').capabilities,
--    settings = {
--        Lua = {
--            runtime = {
--                version = 'LuaJIT',
--                path = vim.split(package.path, ';')
--            },
--            diagnostics = {
--                -- get the language server to recognize the `vim` global
--                globals = {'vim'}
--            },
--            workspace = {
--                -- make the server aware of Neovim runtime files
--                library = {
--                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
--                }
--            }
--        }
--    }
--}

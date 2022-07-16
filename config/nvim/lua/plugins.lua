local use = require('packer').use
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  -- text editing
  --surround edits
  --use {
  --  "blackCauldron7/surround.nvim",
  --  config = function()
  --    require("surround").setup { mappings_style = "sandwich" }
  --  end
  --}
  -- delete vs move
  use {
    "gbprod/cutlass.nvim",
    config = function()
      require("cutlass").setup({
          cut_key = "m"
      })
    end
  }
  -- commenting (`gcc`)
  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  }

  -- more word motions (underscore and CamelCase word detection)
  use 'chaoren/vim-wordmotion'
  -- more commands like `ci$`
  use 'wellle/targets.vim'
  -- jump to pos in file
  use 'ggandor/lightspeed.nvim'

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function()
      local set = vim.api.nvim_set_keymap
      local opts = { noremap=true, silent=true }
      set('n', '<space>f', ':Telescope find_files<CR>', opts)
      set('n', '<space>F', ':Telescope file_browser<CR>', opts)
      set('n', '<space>b', ':Telescope buffers<CR>', opts)
      set('n', '<space>g', ':Telescope live_grep<CR>', opts)

      set('n', '<space>ls', ':Telescope lsp_document_symbols<CR>', opts)
      set('n', '<space>lS', ':Telescope lsp_dynamic_workspace_symbols<CR>', opts)
      --set('n', '<space>la', ':Telescope lsp_code_actions<CR>', opts)
      --set('n', '<space>lA', ':Telescope lsp_range_code_actions<CR>', opts)
      --set('n', '<space>lr', ':Telescope lsp_code_references<CR>', opts)
      set('n', '<space>ld', ':Telescope document_diagnostics<CR>', opts)
      set('n', '<space>lD', ':Telescope workspace_diagnostics<CR>', opts)

      set('n', '<space>vc', ':Telescope command_history<CR>', opts)
      set('n', '<space>vs', ':Telescope search<CR>', opts)
      --set('n', '<space>vq', ':Telescope quickfix<CR>', opts)
      --set('n', '<space>vl', ':Telescope loclist<CR>', opts)
      --set('n', '<space>vj', ':Telescope jumplist<CR>', opts)
    end
  }

  -- tools
  -- collaborative editing
  use {
    'jbyuki/instant.nvim',
    config = function()
      vim.cmd("let g:instant_username = 'lwirth'")
    end
  }

  -- languages, treesitter, lsp
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "all",
        sync_install = false,
        ignore_install = {},
        highlight = {
          enable = true,
          disable = {},
          additional_vim_regex_highlighting = false,
        },
      }

    end
  }

 use {
   'neovim/nvim-lspconfig',
   config = function()
      local nvim_lsp = require('lspconfig')

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

        -- Enable completion triggered by <c-x><c-o>
        --buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

        require "lsp_signature".on_attach()

        -- Mappings.
        local opts = { noremap=true, silent=true }

        -- See `:help vim.lsp.*` for documentation on any of the below functions
        buf_set_keymap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
        buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
        --buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
        buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
        buf_set_keymap('i', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
        --buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
        --buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
        --buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
        --buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
        --buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
        --buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
        --buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
        --buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
        --buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
        --buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
        --buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
        buf_set_keymap('n', '<space>lf', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

        local map = vim.api.nvim_buf_set_keymap
        map(0, "n", "<space>lr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
        map(0, "n", "<space>la", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
        map(0, "x", "<space>la", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
        map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
        map(0, "n", "<space>e", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
        map(0, "n", "[d", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
        map(0, "n", "]d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
        --map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>")
        --map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>")
      end

      -- Add additional capabilities supported by nvim-cmp
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

      -- Use a loop to conveniently call 'setup' on multiple servers and
      -- map buffer local keybindings when the language server attaches
      local servers = { 'pyright', 'clangd', 'texlab' }
      for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
          on_attach = on_attach,
          capabilities = capabilities,
          flags = {
            debounce_text_changes = 150,
          },
        }
      end

      nvim_lsp.rust_analyzer.setup({
          on_attach=on_attach,
          capabilities = capabilities,
          settings = {
              ["rust-analyzer"] = {
                  checkOnSave = {
                    allTargest = false,
                    allFeatures = true,
                    overrideCommand = {
                      'cargo', 'clippy', '--workspace', '--message-format=json',
                      '--all-features'--, '--all-targets'
                    },
                  },
                  assist = {
                      importGranularity = "module",
                      importPrefix = "by_self",
                  },
                  cargo = {
                      loadOutDirsFromCheck = true
                  },
                  procMacro = {
                      enable = true
                  },
              }
          }
      })

      local sumneko_binary_path = vim.fn.exepath('lua-language-server')
      local sumneko_root_path = vim.fn.fnamemodify(sumneko_binary_path, ':h:h:h')

      local runtime_path = vim.split(package.path, ';')
      table.insert(runtime_path, "lua/?.lua")
      table.insert(runtime_path, "lua/?/init.lua")

      nvim_lsp.sumneko_lua.setup {
        cmd = {sumneko_binary_path, "-E", sumneko_root_path .. "/main.lua"};
            settings = {
                Lua = {
                  runtime = {
                      version = 'LuaJIT',
                      path = runtime_path,
                  },
                  diagnostics = {
                      globals = {'vim'},
                  },
                  workspace = {
                      library = vim.api.nvim_get_runtime_file("", true),
                  },
                  telemetry = {
                      enable = false,
                  },
                },
            },
      }
     end
   }

   use {
     'onsails/lspkind-nvim',
     config = function()
      require('lspkind').init({
          mode = 'symbol',
          preset = 'codicons',

          symbol_map = {
            Text = "",
            Method = "",
            Function = "",
            Constructor = "",
            Field = "ﰠ",
            Variable = "",
            Class = "ﴯ",
            Interface = "",
            Module = "",
            Property = "ﰠ",
            Unit = "塞",
            Value = "",
            Enum = "",
            Keyword = "",
            Snippet = "",
            Color = "",
            File = "",
            Reference = "",
            Folder = "",
            EnumMember = "",
            Constant = "",
            Struct = "פּ",
            Event = "",
            Operator = "",
            TypeParameter = ""
          },
      })
     end
   }

  use 'folke/lsp-colors.nvim'


  use {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        position = "bottom", -- position of the list can be: bottom, top, left, right
        height = 10, -- height of the trouble list when position is top or bottom
        width = 50, -- width of the list when position is left or right
        icons = true, -- use devicons for filenames
        mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
        fold_open = "", -- icon used for open folds
        fold_closed = "", -- icon used for closed folds
        group = true, -- group results by file
        padding = true, -- add an extra new line on top of the list
        action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = { "<c-x>" }, -- open buffer in new split
        open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
        open_tab = { "<c-t>" }, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- preview item
        next = "j" -- next item
      },
      indent_lines = true, -- add an indent guide below the fold icons
      auto_open = false, -- automatically open the list when you have diagnostics
      auto_close = false, -- automatically close the list when you have no diagnostics
      auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
      auto_fold = false, -- automatically fold a file trouble list at creation
      auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
      signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
      },
      use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
    }
  end
}


  use {
    'tami5/lspsaga.nvim',
    --branch = 'nvim51',
    config = function()
      local saga = require 'lspsaga'
      saga.init_lsp_saga {
        debug = false,
        use_saga_diagnostic_sign = true,
        -- diagnostic sign
        error_sign = "",
        warn_sign = "",
        hint_sign = "",
        infor_sign = "",
        diagnostic_header_icon = "   ",
        code_action_icon = " ",
        code_action_prompt = {
          enable = true,
          sign = true,
          sign_priority = 20,
          virtual_text = true,
        },
        finder_definition_icon = "  ",
        finder_reference_icon = "  ",
        max_preview_lines = 10,
        finder_action_keys = {
          open = "o",
          vsplit = "s",
          split = "i",
          quit = "q",
          scroll_down = "<C-f>",
          scroll_up = "<C-b>",
        },
        code_action_keys = {
          quit = "q",
          exec = "<CR>",
        },
        rename_action_keys = {
          quit = "<C-c>",
          exec = "<CR>",
        },
        definition_preview_icon = "  ",
        border_style = "single",
        rename_prompt_prefix = "➤",
        server_filetype_map = {},
        diagnostic_prefix_format = "%d. ",
      }
    end
  }

  use {
    "ray-x/lsp_signature.nvim",
  }

  --use {
  --  'simrat39/rust-tools.nvim',
  --  requires = {
  --    'nvim-lua/popup.nvim',
  --    'nvim-lua/plenary.nvim',
  --    'nvim-telescope/telescope.nvim',
  --    'mfussenegger/nvim-dap',
  --  },
  --  config = function()
  --    require('rust-tools').setup({})
  --  end
  --}

  use {
    'lervag/vimtex',
    config = function()
      vim.cmd [[
      let g:vimtex_compiler_method = 'tectonic'"

      let g:vimtex_compiler_tectonic = {
          \ 'build_dir' : '',
          \ 'options' : [
          \   '-X',
          \   'watch',
          \   '--exec build --open',
          \   '--keep-logs',
          \   '--synctex'
          \ ],
          \}
      ]]
    end
  }

  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
  }

  -- completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-nvim-lua'
  use 'hrsh7th/cmp-cmdline'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    'hrsh7th/nvim-cmp',
    config = function()
      -- Set completeopt to have a better completion experience
      vim.o.completeopt = 'menuone,noselect'

      -- nvim-cmp setup
      local cmp = require 'cmp'
      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = {
          ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
          ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
          ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
          ['<C-e>'] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
          }),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-y>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          --['<Tab>'] = function(fallback)
          --  if cmp.visible() then
          --    cmp.select_next_item()
          --  elseif luasnip.expand_or_jumpable() then
          --    luasnip.expand_or_jump()
          --  else
          --    fallback()
          --  end
          --end,
          --['<S-Tab>'] = function(fallback)
          --  if cmp.visible() then
          --    cmp.select_prev_item()
          --  elseif luasnip.jumpable(-1) then
          --    luasnip.jump(-1)
          --  else
          --    fallback()
          --  end
          --end,
        },
        sources = {
          { name = 'nvim_lua' },
          { name = 'nvim_lsp' },
          { name = 'path' },
          { name = 'luasnip' },
          { name = 'buffer', keyword_length = 5 },
        },
        sorting = {
          comparators = {
            cmp.config.compare.exact,
            cmp.config.compare.score,
            --cmp.config.compare.score,
            --cmp.config.compare.order,
            --cmp.config.compare.kind,
            --cmp.config.compare.offset,
            --cmp.config.compare.sort_text,
            --cmp.config.compare.length,
          }
        },
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = require('lspkind').cmp_format({with_text = false, maxwidth = 50} )
        },


      }

      -- `/` cmdline setup.
      cmp.setup.cmdline('/', {
        sources = {
          { name = 'buffer' }
        }
      })

      -- `:` cmdline setup.
      cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }

  -- apperance
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd('colorscheme tokyonight')
    end
  }
  use {
    'kyazdani42/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
       -- your personnal icons can go here (to override)
       -- DevIcon will be appended to `name`
       override = {
        zsh = {
          icon = "",
          color = "#428850",
          name = "Zsh"
        }
       };
       -- globally enable default icons (default to false)
       default = true;
      }
    end
  }
  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true},
    config = function()
      require('../statusline')
    end
  }
  use {
    'declancm/cinnamon.nvim',
    config = function() require('cinnamon').setup() end
  }
  use {
    "luukvbaal/stabilize.nvim",
    config = function() require("stabilize").setup() end
  }
  use {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {}
    end
  }
  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup {
      }
    end
  }
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
      }
    end
  }
end)


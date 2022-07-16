-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/luis/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/luis/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/luis/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/luis/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/luis/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    config = { "\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cinnamon.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rcinnamon\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cinnamon.nvim",
    url = "https://github.com/declancm/cinnamon.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["cutlass.nvim"] = {
    config = { "\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fcut_key\6m\nsetup\fcutlass\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/cutlass.nvim",
    url = "https://github.com/gbprod/cutlass.nvim"
  },
  ["instant.nvim"] = {
    config = { "\27LJ\2\nE\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0&let g:instant_username = 'lwirth'\bcmd\bvim\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/instant.nvim",
    url = "https://github.com/jbyuki/instant.nvim"
  },
  ["lightspeed.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lightspeed.nvim",
    url = "https://github.com/ggandor/lightspeed.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lspkind-nvim"] = {
    config = { "\27LJ\2\n�\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\fKeyword\b\rConstant\b\tEnum\b\vStruct\bפּ\nValue\b\nEvent\b\tUnit\b塞\rProperty\bﰠ\rOperator\b\vModule\b\18TypeParameter\5\14Interface\b\nClass\bﴯ\rVariable\b\nField\bﰠ\16Constructor\b\15EnumMember\b\rFunction\b\vFolder\b\vMethod\b\14Reference\b\tText\b\tFile\b\nColor\b\fSnippet\b\1\0\2\vpreset\rcodicons\tmode\vsymbol\tinit\flspkind\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lspkind-nvim",
    url = "https://github.com/onsails/lspkind-nvim"
  },
  ["lspsaga.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0034\4\0\0=\4\f\3B\1\2\1K\0\1\0\24server_filetype_map\23rename_action_keys\1\0\2\tquit\n<C-c>\texec\t<CR>\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\6\tquit\6q\vvsplit\6s\topen\6o\16scroll_down\n<C-f>\14scroll_up\n<C-b>\nsplit\6i\23code_action_prompt\1\0\4\tsign\2\17virtual_text\2\venable\2\18sign_priority\3\20\1\0\15\14warn_sign\b\15error_sign\b\29use_saga_diagnostic_sign\2\25rename_prompt_prefix\b➤\17border_style\vsingle\28definition_preview_icon\n  \29diagnostic_prefix_format\t%d. \22max_preview_lines\3\n\26finder_reference_icon\n  \27finder_definition_icon\n  \ndebug\1\21code_action_icon\t \27diagnostic_header_icon\v   \15infor_sign\b\14hint_sign\b\18init_lsp_saga\flspsaga\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lspsaga.nvim",
    url = "https://github.com/tami5/lspsaga.nvim"
  },
  ["lualine.nvim"] = {
    config = { "\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18../statusline\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["markdown-preview.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/markdown-preview.nvim",
    url = "https://github.com/iamcco/markdown-preview.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire�\b\1\0\n\0C\06\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\1\6\0005\3\n\0005\4\b\0003\5\a\0=\5\t\4=\4\v\0035\4\15\0009\5\f\0009\a\f\0009\a\r\a)\t��B\a\2\0025\b\14\0B\5\3\2=\5\16\0049\5\f\0009\a\f\0009\a\r\a)\t\4\0B\a\2\0025\b\17\0B\5\3\2=\5\18\0049\5\f\0009\a\f\0009\a\19\aB\a\1\0025\b\20\0B\5\3\2=\5\21\0049\5\f\0005\a\23\0009\b\f\0009\b\22\bB\b\1\2=\b\24\a9\b\f\0009\b\25\bB\b\1\2=\b\26\aB\5\2\2=\5\27\0049\5\f\0009\5\28\5B\5\1\2=\5\29\0049\5\f\0009\5\30\5B\5\1\2=\5\31\0049\5\f\0009\5 \0055\a#\0009\b!\0009\b\"\b=\b$\aB\5\2\2=\5%\4=\4\f\0034\4\6\0005\5&\0>\5\1\0045\5'\0>\5\2\0045\5(\0>\5\3\0045\5)\0>\5\4\0045\5*\0>\5\5\4=\4+\0035\0040\0004\5\3\0009\6,\0009\6-\0069\6.\6>\6\1\0059\6,\0009\6-\0069\6/\6>\6\2\5=\0051\4=\0042\0035\0043\0=\0044\0035\0048\0006\5\4\0'\a5\0B\5\2\0029\0056\0055\a7\0B\5\2\2=\0059\4=\4:\3B\1\2\0019\1\6\0009\1;\1'\3<\0005\4>\0004\5\3\0005\6=\0>\6\1\5=\5+\4B\1\3\0019\1\6\0009\1;\1'\3?\0005\4B\0009\5,\0009\5+\0054\a\3\0005\b@\0>\b\1\a4\b\3\0005\tA\0>\t\1\bB\5\3\2=\5+\4B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\15formatting\vformat\1\0\0\1\0\2\14with_text\1\rmaxwidth\0032\15cmp_format\flspkind\17experimental\1\0\1\15ghost_text\2\fsorting\16comparators\1\0\0\nscore\nexact\fcompare\vconfig\fsources\1\0\2\19keyword_length\3\5\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\n<C-y>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-n>\21select_next_item\n<C-p>\21select_prev_item\n<C-e>\6c\nclose\6i\1\0\0\nabort\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-d>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\21menuone,noselect\16completeopt\6o\bvim\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1�\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1�\24nvim_buf_set_option\bapi\bvim�\b\1\2\r\0*\0\\3\2\0\0003\3\1\0006\4\2\0'\6\3\0B\4\2\0029\4\4\4B\4\1\0015\4\5\0\18\5\2\0'\a\6\0'\b\a\0'\t\b\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\t\0'\t\n\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\v\0'\t\f\0\18\n\4\0B\5\5\1\18\5\2\0'\a\r\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\0016\5\18\0009\5\19\0059\5\20\5\18\6\5\0)\b\0\0'\t\6\0'\n\21\0'\v\22\0005\f\23\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n\24\0'\v\25\0005\f\26\0B\6\6\1\18\6\5\0)\b\0\0'\t\27\0'\n\24\0'\v\28\0005\f\29\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n\30\0'\v\31\0005\f \0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n!\0'\v\"\0005\f#\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n$\0'\v%\0005\f&\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n'\0'\v(\0005\f)\0B\6\6\0012\0\0�K\0\1\0\1\0\2\fnoremap\2\vsilent\2*<cmd>Lspsaga diagnostic_jump_prev<cr>\a]d\1\0\2\fnoremap\2\vsilent\2*<cmd>Lspsaga diagnostic_jump_next<cr>\a[d\1\0\2\fnoremap\2\vsilent\2+<cmd>Lspsaga show_line_diagnostics<cr>\r<space>e\1\0\2\fnoremap\2\vsilent\2\31<cmd>Lspsaga hover_doc<cr>\6K\1\0\2\fnoremap\2\vsilent\2(:<c-u>Lspsaga range_code_action<cr>\6x\1\0\2\fnoremap\2\vsilent\2!<cmd>Lspsaga code_action<cr>\14<space>la\1\0\2\fnoremap\2\vsilent\2\28<cmd>Lspsaga rename<cr>\14<space>lr\24nvim_buf_set_keymap\bapi\bvim5<cmd>lua vim.lsp.buf.format { async = true }<CR>\14<space>lf.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>\6i.<cmd>lua vim.lsp.buf.implementation()<CR>\agi*<cmd>lua vim.lsp.buf.definition()<CR>\agd+<cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\14on_attach\18lsp_signature\frequire\0\0�\t\1\0\17\0D\0p6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0026\3\0\0'\5\a\0B\3\2\0029\3\b\3\18\5\2\0B\3\2\2\18\2\3\0005\3\t\0006\4\n\0\18\6\3\0B\4\2\4X\a\b�8\t\b\0009\t\v\t5\v\f\0=\1\r\v=\2\14\v5\f\15\0=\f\16\vB\t\2\1E\a\3\3R\a�9\4\17\0009\4\v\0045\6\18\0=\1\r\6=\2\14\0065\a\30\0005\b\22\0005\t\19\0005\n\20\0=\n\21\t=\t\23\b5\t\24\0=\t\25\b5\t\26\0=\t\27\b5\t\28\0=\t\29\b=\b\31\a=\a \6B\4\2\0016\4\3\0009\4!\0049\4\"\4'\6#\0B\4\2\0026\5\3\0009\5!\0059\5$\5\18\a\4\0'\b%\0B\5\3\0026\6\3\0009\6&\0066\b'\0009\b(\b'\t)\0B\6\3\0026\a*\0009\a+\a\18\t\6\0'\n,\0B\a\3\0016\a*\0009\a+\a\18\t\6\0'\n-\0B\a\3\0019\a.\0009\a\v\a5\t1\0005\n/\0>\4\1\n\18\v\5\0'\f0\0&\v\f\v>\v\3\n=\n2\t5\nB\0005\v4\0005\f3\0=\6(\f=\f5\v5\f7\0005\r6\0=\r8\f=\f9\v5\f=\0006\r\3\0009\r:\r9\r;\r'\15<\0+\16\2\0B\r\3\2=\r>\f=\f?\v5\f@\0=\fA\v=\vC\n=\n \tB\a\2\1K\0\1\0\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\bcmd\1\0\0\14/main.lua\1\3\0\0\0\a-E\16sumneko_lua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\v:h:h:h\16fnamemodify\24lua-language-server\fexepath\afn\rsettings\18rust-analyzer\1\0\0\14procMacro\1\0\1\venable\2\ncargo\1\0\1\25loadOutDirsFromCheck\2\vassist\1\0\2\22importGranularity\vmodule\17importPrefix\fby_self\16checkOnSave\1\0\0\20overrideCommand\1\6\0\0\ncargo\vclippy\16--workspace\26--message-format=json\19--all-features\1\0\2\16allFeatures\2\15allTargest\1\1\0\0\18rust_analyzer\nflags\1\0\1\26debounce_text_changes\3�\1\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\4\0\0\fpyright\vclangd\vtexlab\24update_capabilities\17cmp_nvim_lsp\29make_client_capabilities\rprotocol\blsp\bvim\0\14lspconfig\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0004\4\0\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\14highlight\fdisable\1\0\2&additional_vim_regex_highlighting\1\venable\2\19ignore_install\1\0\2\17sync_install\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n�\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\bzsh\1\0\0\1\0\3\ticon\b\ncolor\f#428850\tname\bZsh\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["stabilize.nvim"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/stabilize.nvim",
    url = "https://github.com/luukvbaal/stabilize.nvim"
  },
  ["targets.vim"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/targets.vim",
    url = "https://github.com/wellle/targets.vim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\b\0\25\0A6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\1K\0\1\0\26:Telescope search<CR>\14<space>vs#:Telescope command_history<CR>\14<space>vc):Telescope workspace_diagnostics<CR>\14<space>lD(:Telescope document_diagnostics<CR>\14<space>ld1:Telescope lsp_dynamic_workspace_symbols<CR>\14<space>lS(:Telescope lsp_document_symbols<CR>\14<space>ls\29:Telescope live_grep<CR>\r<space>g\27:Telescope buffers<CR>\r<space>b :Telescope file_browser<CR>\r<space>F\30:Telescope find_files<CR>\r<space>f\6n\1\0\2\vsilent\2\fnoremap\2\20nvim_set_keymap\bapi\bvim\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["todo-comments.nvim"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/todo-comments.nvim",
    url = "https://github.com/folke/todo-comments.nvim"
  },
  ["tokyonight.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/tokyonight.nvim",
    url = "https://github.com/folke/tokyonight.nvim"
  },
  ["trouble.nvim"] = {
    config = { "\27LJ\2\n�\5\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\nsigns\1\0\5\16information\b\nother\b﫠\nerror\b\thint\b\fwarning\b\14auto_jump\1\2\0\0\20lsp_definitions\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\frefresh\6r\nclose\6q\fpreview\6p\nhover\6K\vcancel\n<esc>\19toggle_preview\6P\16toggle_mode\6m\tnext\6j\rprevious\6k\1\0\15\16fold_closed\b\14fold_open\b\nicons\2\nwidth\0032\vheight\3\n\25use_diagnostic_signs\1\rposition\vbottom\14auto_fold\1\17auto_preview\2\15auto_close\1\14auto_open\1\17indent_lines\2\fpadding\2\ngroup\2\tmode\26workspace_diagnostics\nsetup\ftrouble\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/trouble.nvim",
    url = "https://github.com/folke/trouble.nvim"
  },
  ["twilight.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/twilight.nvim",
    url = "https://github.com/folke/twilight.nvim"
  },
  ["vim-wordmotion"] = {
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/vim-wordmotion",
    url = "https://github.com/chaoren/vim-wordmotion"
  },
  vimtex = {
    config = { "\27LJ\2\n�\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2      let g:vimtex_compiler_method = 'tectonic'\"\n\n      let g:vimtex_compiler_tectonic = {\n          \\ 'build_dir' : '',\n          \\ 'options' : [\n          \\   '-X',\n          \\   'watch',\n          \\   '--exec build --open',\n          \\   '--keep-logs',\n          \\   '--synctex'\n          \\ ],\n          \\}\n      \bcmd\bvim\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["zen-mode.nvim"] = {
    config = { "\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0" },
    loaded = true,
    path = "/home/luis/.local/share/nvim/site/pack/packer/start/zen-mode.nvim",
    url = "https://github.com/folke/zen-mode.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: cinnamon.nvim
time([[Config for cinnamon.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rcinnamon\frequire\0", "config", "cinnamon.nvim")
time([[Config for cinnamon.nvim]], false)
-- Config for: todo-comments.nvim
time([[Config for todo-comments.nvim]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\18todo-comments\frequire\0", "config", "todo-comments.nvim")
time([[Config for todo-comments.nvim]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\nC\0\1\4\0\4\0\a6\1\0\0'\3\1\0B\1\2\0029\1\2\0019\3\3\0B\1\2\1K\0\1\0\tbody\15lsp_expand\fluasnip\frequire�\b\1\0\n\0C\06\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0'\2\5\0B\0\2\0029\1\6\0005\3\n\0005\4\b\0003\5\a\0=\5\t\4=\4\v\0035\4\15\0009\5\f\0009\a\f\0009\a\r\a)\t��B\a\2\0025\b\14\0B\5\3\2=\5\16\0049\5\f\0009\a\f\0009\a\r\a)\t\4\0B\a\2\0025\b\17\0B\5\3\2=\5\18\0049\5\f\0009\a\f\0009\a\19\aB\a\1\0025\b\20\0B\5\3\2=\5\21\0049\5\f\0005\a\23\0009\b\f\0009\b\22\bB\b\1\2=\b\24\a9\b\f\0009\b\25\bB\b\1\2=\b\26\aB\5\2\2=\5\27\0049\5\f\0009\5\28\5B\5\1\2=\5\29\0049\5\f\0009\5\30\5B\5\1\2=\5\31\0049\5\f\0009\5 \0055\a#\0009\b!\0009\b\"\b=\b$\aB\5\2\2=\5%\4=\4\f\0034\4\6\0005\5&\0>\5\1\0045\5'\0>\5\2\0045\5(\0>\5\3\0045\5)\0>\5\4\0045\5*\0>\5\5\4=\4+\0035\0040\0004\5\3\0009\6,\0009\6-\0069\6.\6>\6\1\0059\6,\0009\6-\0069\6/\6>\6\2\5=\0051\4=\0042\0035\0043\0=\0044\0035\0048\0006\5\4\0'\a5\0B\5\2\0029\0056\0055\a7\0B\5\2\2=\0059\4=\4:\3B\1\2\0019\1\6\0009\1;\1'\3<\0005\4>\0004\5\3\0005\6=\0>\6\1\5=\5+\4B\1\3\0019\1\6\0009\1;\1'\3?\0005\4B\0009\5,\0009\5+\0054\a\3\0005\b@\0>\b\1\a4\b\3\0005\tA\0>\t\1\bB\5\3\2=\5+\4B\1\3\1K\0\1\0\1\0\0\1\0\1\tname\fcmdline\1\0\1\tname\tpath\6:\1\0\0\1\0\1\tname\vbuffer\6/\fcmdline\15formatting\vformat\1\0\0\1\0\2\14with_text\1\rmaxwidth\0032\15cmp_format\flspkind\17experimental\1\0\1\15ghost_text\2\fsorting\16comparators\1\0\0\nscore\nexact\fcompare\vconfig\fsources\1\0\2\19keyword_length\3\5\tname\vbuffer\1\0\1\tname\fluasnip\1\0\1\tname\tpath\1\0\1\tname\rnvim_lsp\1\0\1\tname\rnvim_lua\n<C-y>\rbehavior\1\0\1\vselect\2\fReplace\20ConfirmBehavior\fconfirm\n<C-n>\21select_next_item\n<C-p>\21select_prev_item\n<C-e>\6c\nclose\6i\1\0\0\nabort\14<C-Space>\1\3\0\0\6i\6c\rcomplete\n<C-f>\1\3\0\0\6i\6c\n<C-d>\1\0\0\1\3\0\0\6i\6c\16scroll_docs\fmapping\fsnippet\1\0\0\vexpand\1\0\0\0\nsetup\bcmp\frequire\21menuone,noselect\16completeopt\6o\bvim\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: tokyonight.nvim
time([[Config for tokyonight.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0\27colorscheme tokyonight\bcmd\bvim\0", "config", "tokyonight.nvim")
time([[Config for tokyonight.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\nA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1�\24nvim_buf_set_keymap\bapi\bvimA\2\0\4\1\3\0\a6\0\0\0009\0\1\0009\0\2\0-\2\0\0G\3\0\0A\0\1\1K\0\1\0\1�\24nvim_buf_set_option\bapi\bvim�\b\1\2\r\0*\0\\3\2\0\0003\3\1\0006\4\2\0'\6\3\0B\4\2\0029\4\4\4B\4\1\0015\4\5\0\18\5\2\0'\a\6\0'\b\a\0'\t\b\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\t\0'\t\n\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\v\0'\t\f\0\18\n\4\0B\5\5\1\18\5\2\0'\a\r\0'\b\14\0'\t\15\0\18\n\4\0B\5\5\1\18\5\2\0'\a\6\0'\b\16\0'\t\17\0\18\n\4\0B\5\5\0016\5\18\0009\5\19\0059\5\20\5\18\6\5\0)\b\0\0'\t\6\0'\n\21\0'\v\22\0005\f\23\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n\24\0'\v\25\0005\f\26\0B\6\6\1\18\6\5\0)\b\0\0'\t\27\0'\n\24\0'\v\28\0005\f\29\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n\30\0'\v\31\0005\f \0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n!\0'\v\"\0005\f#\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n$\0'\v%\0005\f&\0B\6\6\1\18\6\5\0)\b\0\0'\t\6\0'\n'\0'\v(\0005\f)\0B\6\6\0012\0\0�K\0\1\0\1\0\2\fnoremap\2\vsilent\2*<cmd>Lspsaga diagnostic_jump_prev<cr>\a]d\1\0\2\fnoremap\2\vsilent\2*<cmd>Lspsaga diagnostic_jump_next<cr>\a[d\1\0\2\fnoremap\2\vsilent\2+<cmd>Lspsaga show_line_diagnostics<cr>\r<space>e\1\0\2\fnoremap\2\vsilent\2\31<cmd>Lspsaga hover_doc<cr>\6K\1\0\2\fnoremap\2\vsilent\2(:<c-u>Lspsaga range_code_action<cr>\6x\1\0\2\fnoremap\2\vsilent\2!<cmd>Lspsaga code_action<cr>\14<space>la\1\0\2\fnoremap\2\vsilent\2\28<cmd>Lspsaga rename<cr>\14<space>lr\24nvim_buf_set_keymap\bapi\bvim5<cmd>lua vim.lsp.buf.format { async = true }<CR>\14<space>lf.<cmd>lua vim.lsp.buf.signature_help()<CR>\n<C-k>\6i.<cmd>lua vim.lsp.buf.implementation()<CR>\agi*<cmd>lua vim.lsp.buf.definition()<CR>\agd+<cmd>lua vim.lsp.buf.declaration()<CR>\agD\6n\1\0\2\vsilent\2\fnoremap\2\14on_attach\18lsp_signature\frequire\0\0�\t\1\0\17\0D\0p6\0\0\0'\2\1\0B\0\2\0023\1\2\0006\2\3\0009\2\4\0029\2\5\0029\2\6\2B\2\1\0026\3\0\0'\5\a\0B\3\2\0029\3\b\3\18\5\2\0B\3\2\2\18\2\3\0005\3\t\0006\4\n\0\18\6\3\0B\4\2\4X\a\b�8\t\b\0009\t\v\t5\v\f\0=\1\r\v=\2\14\v5\f\15\0=\f\16\vB\t\2\1E\a\3\3R\a�9\4\17\0009\4\v\0045\6\18\0=\1\r\6=\2\14\0065\a\30\0005\b\22\0005\t\19\0005\n\20\0=\n\21\t=\t\23\b5\t\24\0=\t\25\b5\t\26\0=\t\27\b5\t\28\0=\t\29\b=\b\31\a=\a \6B\4\2\0016\4\3\0009\4!\0049\4\"\4'\6#\0B\4\2\0026\5\3\0009\5!\0059\5$\5\18\a\4\0'\b%\0B\5\3\0026\6\3\0009\6&\0066\b'\0009\b(\b'\t)\0B\6\3\0026\a*\0009\a+\a\18\t\6\0'\n,\0B\a\3\0016\a*\0009\a+\a\18\t\6\0'\n-\0B\a\3\0019\a.\0009\a\v\a5\t1\0005\n/\0>\4\1\n\18\v\5\0'\f0\0&\v\f\v>\v\3\n=\n2\t5\nB\0005\v4\0005\f3\0=\6(\f=\f5\v5\f7\0005\r6\0=\r8\f=\f9\v5\f=\0006\r\3\0009\r:\r9\r;\r'\15<\0+\16\2\0B\r\3\2=\r>\f=\f?\v5\f@\0=\fA\v=\vC\n=\n \tB\a\2\1K\0\1\0\bLua\1\0\0\14telemetry\1\0\1\venable\1\14workspace\flibrary\1\0\0\5\26nvim_get_runtime_file\bapi\16diagnostics\fglobals\1\0\0\1\2\0\0\bvim\fruntime\1\0\0\1\0\1\fversion\vLuaJIT\bcmd\1\0\0\14/main.lua\1\3\0\0\0\a-E\16sumneko_lua\19lua/?/init.lua\14lua/?.lua\vinsert\ntable\6;\tpath\fpackage\nsplit\v:h:h:h\16fnamemodify\24lua-language-server\fexepath\afn\rsettings\18rust-analyzer\1\0\0\14procMacro\1\0\1\venable\2\ncargo\1\0\1\25loadOutDirsFromCheck\2\vassist\1\0\2\22importGranularity\vmodule\17importPrefix\fby_self\16checkOnSave\1\0\0\20overrideCommand\1\6\0\0\ncargo\vclippy\16--workspace\26--message-format=json\19--all-features\1\0\2\16allFeatures\2\15allTargest\1\1\0\0\18rust_analyzer\nflags\1\0\1\26debounce_text_changes\3�\1\17capabilities\14on_attach\1\0\0\nsetup\vipairs\1\4\0\0\fpyright\vclangd\vtexlab\24update_capabilities\17cmp_nvim_lsp\29make_client_capabilities\rprotocol\blsp\bvim\0\14lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: trouble.nvim
time([[Config for trouble.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\5\0\26\0\0296\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0005\4\5\0=\4\6\0035\4\a\0=\4\b\0035\4\t\0=\4\n\0035\4\v\0=\4\f\0035\4\r\0=\4\14\0035\4\15\0=\4\16\0035\4\17\0=\4\18\0035\4\19\0=\4\20\3=\3\21\0025\3\22\0=\3\23\0025\3\24\0=\3\25\2B\0\2\1K\0\1\0\nsigns\1\0\5\16information\b\nother\b﫠\nerror\b\thint\b\fwarning\b\14auto_jump\1\2\0\0\20lsp_definitions\16action_keys\16toggle_fold\1\3\0\0\azA\aza\15open_folds\1\3\0\0\azR\azr\16close_folds\1\3\0\0\azM\azm\15jump_close\1\2\0\0\6o\ropen_tab\1\2\0\0\n<c-t>\16open_vsplit\1\2\0\0\n<c-v>\15open_split\1\2\0\0\n<c-x>\tjump\1\3\0\0\t<cr>\n<tab>\1\0\t\frefresh\6r\nclose\6q\fpreview\6p\nhover\6K\vcancel\n<esc>\19toggle_preview\6P\16toggle_mode\6m\tnext\6j\rprevious\6k\1\0\15\16fold_closed\b\14fold_open\b\nicons\2\nwidth\0032\vheight\3\n\25use_diagnostic_signs\1\rposition\vbottom\14auto_fold\1\17auto_preview\2\15auto_close\1\14auto_open\1\17indent_lines\2\fpadding\2\ngroup\2\tmode\26workspace_diagnostics\nsetup\ftrouble\frequire\0", "config", "trouble.nvim")
time([[Config for trouble.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\b\0\r6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0004\3\0\0=\3\4\0025\3\5\0004\4\0\0=\4\6\3=\3\a\2B\0\2\1K\0\1\0\14highlight\fdisable\1\0\2&additional_vim_regex_highlighting\1\venable\2\19ignore_install\1\0\2\17sync_install\1\21ensure_installed\ball\nsetup\28nvim-treesitter.configs\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: twilight.nvim
time([[Config for twilight.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rtwilight\frequire\0", "config", "twilight.nvim")
time([[Config for twilight.nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n�\1\0\0\5\0\b\0\v6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\6\0005\3\4\0005\4\3\0=\4\5\3=\3\a\2B\0\2\1K\0\1\0\roverride\1\0\1\fdefault\2\bzsh\1\0\0\1\0\3\ticon\b\ncolor\f#428850\tname\bZsh\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: cutlass.nvim
time([[Config for cutlass.nvim]], true)
try_loadstring("\27LJ\2\nF\0\0\3\0\4\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0B\0\2\1K\0\1\0\1\0\1\fcut_key\6m\nsetup\fcutlass\frequire\0", "config", "cutlass.nvim")
time([[Config for cutlass.nvim]], false)
-- Config for: vimtex
time([[Config for vimtex]], true)
try_loadstring("\27LJ\2\n�\2\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0�\2      let g:vimtex_compiler_method = 'tectonic'\"\n\n      let g:vimtex_compiler_tectonic = {\n          \\ 'build_dir' : '',\n          \\ 'options' : [\n          \\   '-X',\n          \\   'watch',\n          \\   '--exec build --open',\n          \\   '--keep-logs',\n          \\   '--synctex'\n          \\ ],\n          \\}\n      \bcmd\bvim\0", "config", "vimtex")
time([[Config for vimtex]], false)
-- Config for: instant.nvim
time([[Config for instant.nvim]], true)
try_loadstring("\27LJ\2\nE\0\0\3\0\3\0\0056\0\0\0009\0\1\0'\2\2\0B\0\2\1K\0\1\0&let g:instant_username = 'lwirth'\bcmd\bvim\0", "config", "instant.nvim")
time([[Config for instant.nvim]], false)
-- Config for: stabilize.nvim
time([[Config for stabilize.nvim]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14stabilize\frequire\0", "config", "stabilize.nvim")
time([[Config for stabilize.nvim]], false)
-- Config for: Comment.nvim
time([[Config for Comment.nvim]], true)
try_loadstring("\27LJ\2\n5\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\fComment\frequire\0", "config", "Comment.nvim")
time([[Config for Comment.nvim]], false)
-- Config for: zen-mode.nvim
time([[Config for zen-mode.nvim]], true)
try_loadstring("\27LJ\2\n:\0\0\3\0\3\0\a6\0\0\0'\2\1\0B\0\2\0029\0\2\0004\2\0\0B\0\2\1K\0\1\0\nsetup\rzen-mode\frequire\0", "config", "zen-mode.nvim")
time([[Config for zen-mode.nvim]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\b\0\25\0A6\0\0\0009\0\1\0009\0\2\0005\1\3\0\18\2\0\0'\4\4\0'\5\5\0'\6\6\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\a\0'\6\b\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\t\0'\6\n\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\v\0'\6\f\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\r\0'\6\14\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\15\0'\6\16\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\17\0'\6\18\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\19\0'\6\20\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\21\0'\6\22\0\18\a\1\0B\2\5\1\18\2\0\0'\4\4\0'\5\23\0'\6\24\0\18\a\1\0B\2\5\1K\0\1\0\26:Telescope search<CR>\14<space>vs#:Telescope command_history<CR>\14<space>vc):Telescope workspace_diagnostics<CR>\14<space>lD(:Telescope document_diagnostics<CR>\14<space>ld1:Telescope lsp_dynamic_workspace_symbols<CR>\14<space>lS(:Telescope lsp_document_symbols<CR>\14<space>ls\29:Telescope live_grep<CR>\r<space>g\27:Telescope buffers<CR>\r<space>b :Telescope file_browser<CR>\r<space>F\30:Telescope find_files<CR>\r<space>f\6n\1\0\2\vsilent\2\fnoremap\2\20nvim_set_keymap\bapi\bvim\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
try_loadstring("\27LJ\2\n-\0\0\3\0\2\0\0046\0\0\0'\2\1\0B\0\2\1K\0\1\0\18../statusline\frequire\0", "config", "lualine.nvim")
time([[Config for lualine.nvim]], false)
-- Config for: lspsaga.nvim
time([[Config for lspsaga.nvim]], true)
try_loadstring("\27LJ\2\n�\5\0\0\5\0\r\0\0176\0\0\0'\2\1\0B\0\2\0029\1\2\0005\3\3\0005\4\4\0=\4\5\0035\4\6\0=\4\a\0035\4\b\0=\4\t\0035\4\n\0=\4\v\0034\4\0\0=\4\f\3B\1\2\1K\0\1\0\24server_filetype_map\23rename_action_keys\1\0\2\tquit\n<C-c>\texec\t<CR>\21code_action_keys\1\0\2\tquit\6q\texec\t<CR>\23finder_action_keys\1\0\6\tquit\6q\vvsplit\6s\topen\6o\16scroll_down\n<C-f>\14scroll_up\n<C-b>\nsplit\6i\23code_action_prompt\1\0\4\tsign\2\17virtual_text\2\venable\2\18sign_priority\3\20\1\0\15\14warn_sign\b\15error_sign\b\29use_saga_diagnostic_sign\2\25rename_prompt_prefix\b➤\17border_style\vsingle\28definition_preview_icon\n  \29diagnostic_prefix_format\t%d. \22max_preview_lines\3\n\26finder_reference_icon\n  \27finder_definition_icon\n  \ndebug\1\21code_action_icon\t \27diagnostic_header_icon\v   \15infor_sign\b\14hint_sign\b\18init_lsp_saga\flspsaga\frequire\0", "config", "lspsaga.nvim")
time([[Config for lspsaga.nvim]], false)
-- Config for: lspkind-nvim
time([[Config for lspkind-nvim]], true)
try_loadstring("\27LJ\2\n�\3\0\0\4\0\6\0\t6\0\0\0'\2\1\0B\0\2\0029\0\2\0005\2\3\0005\3\4\0=\3\5\2B\0\2\1K\0\1\0\15symbol_map\1\0\25\fKeyword\b\rConstant\b\tEnum\b\vStruct\bפּ\nValue\b\nEvent\b\tUnit\b塞\rProperty\bﰠ\rOperator\b\vModule\b\18TypeParameter\5\14Interface\b\nClass\bﴯ\rVariable\b\nField\bﰠ\16Constructor\b\15EnumMember\b\rFunction\b\vFolder\b\vMethod\b\14Reference\b\tText\b\tFile\b\nColor\b\fSnippet\b\1\0\2\vpreset\rcodicons\tmode\vsymbol\tinit\flspkind\frequire\0", "config", "lspkind-nvim")
time([[Config for lspkind-nvim]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

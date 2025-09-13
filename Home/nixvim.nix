{
  config,
  inputs,
  ...
}:

let
  palette = config.colorScheme.palette;
in 
{
  imports = [ inputs.nixvim.homeModules.nixvim ];
  programs.nixvim = {
    enable = true;
    opts = {
      wrap = true;
      backup = false;
      number = true;
      undofile = true;
      swapfile = false;
      hlsearch = false;
      expandtab = true;
      incsearch = true;
      smartindent = true;
      termguicolors = true;
      relativenumber = true;
      tabstop = 4;
      scrolloff = 8;
      shiftwidth = 4;
      updatetime = 50;
      softtabstop = 4;
      colorcolumn = "80";
    };
    plugins = {
      nix.enable = true;
      crates.enable = true;
      fidget.enable = true;
      which-key.enable = true;
      bufferline.enable = true;
      cmp_luasnip.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lua.enable = true;
      web-devicons.enable = true;
      telescope = {
        enable = true;
        keymaps = {
          "<leader>fd".action = "find_files";
          "<leader>lg".action = "live_grep";
        };
      };
      luasnip = {
        enable = true;
        fromLua = [{
          paths = ./DotFiles/snippets.lua;
        }];
      };
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          auto_install = true;
          ensureInstalled = [ "nu" ];
        };
      };
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings.sources = [
          { name = "path"; }
          { name = "buffer"; }
          { name = "luasnip"; }
          { name = "nvim_lsp"; }
          { name = "cmp_luasnip"; }
        ];
        settings.mapping = {
          "<C-y>" = "cmp.mapping.confirm({ select = true })";
          "<C-n>" = "cmp.mapping.select_next_item()";
          "<C-p>" = "cmp.mapping.select_prev_item()";
        };
        settings.snippet.expand = ''
        function(args)
          require('luasnip').lsp_expand(args.body)
        end
        '';
      };
      lsp = {
        # onAttach = "default_keymaps({ buffer = buffnr })";
        enable = true;
        servers = {
          html.enable = true;
          htmx.enable = true;
          htmx.filetypes = [ "html" ".html" ];
          nixd.enable = true;
          bashls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          nushell.enable = true;
          nushell.filetypes = [ "nu" ".nu" ];
          tailwindcss.enable = true;
          rust_analyzer.enable = true;
          rust_analyzer.installCargo = false;
          rust_analyzer.installRustc = false;
        };
        keymaps.lspBuf = {
          "K" = "hover";
          "<leader>how" = "type_definition";
          "<leader>why" = "implementation";
          "<leader>what" = "definition";
          "<leader>where" = "references";
        };
      };
      harpoon = {
        enable = true;
      };
    };
    # extraPlugins = with pkgs.vimPlugins; [ ];
    colorschemes.base16.enable = true;
    colorschemes.base16.colorscheme = {
      base00 = "#${palette.base00}";
      base01 = "#${palette.base01}";
      base02 = "#${palette.base02}";
      base03 = "#${palette.base05}"; # comments
      base04 = "#${palette.base05}"; # line numbers
      base05 = "#${palette.base06}"; # fg text
      base06 = "#${palette.base06}";
      base07 = "#${palette.base07}";
      base08 = "#${palette.base08}";
      base09 = "#${palette.base09}";
      base0A = "#${palette.base0A}";
      base0B = "#${palette.base0B}";
      base0C = "#${palette.base0C}";
      base0D = "#${palette.base0D}";
      base0E = "#${palette.base0E}";
      base0F = "#${palette.base0F}";
    };
    extraConfigLua = ''
      vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

      parser_config.nu = {
        install_info = {
          url = "https://github.com/nushell/tree-sitter-nu",
          files = { "src/parser.c" },
          branch = "main",
        },
        filetype = "nu",
      }
    '';
    globals.mapleader = " ";
    keymaps = [
      { mode = "i"; key = "jf"; action = "<Esc>"; }
      { mode = "n"; key = "fu"; action = "<C-R>"; }
      { mode = "n"; key = "<leader>fl"; action = "<C-w>l"; }
      { mode = "n"; key = "<leader>fh"; action = "<C-w>h"; }
      { mode = "n"; key = "<leader>fk"; action = "<C-w>k"; }
      { mode = "n"; key = "<leader>fj"; action = "<C-w>j"; }
      { mode = "n"; key = "<leader>fe"; action = ":Explore<CR>"; }
      { mode = "n"; key = "<leader>term"; action = ":terminal<CR>"; }
      { mode = "n"; key = "<leader>split"; action = ":split<CR>"; }
      { mode = "n"; key = "<leader>vsplit"; action = ":vsplit<CR>"; }
      { mode = "n"; key = "J"; action = "mzJ`z"; }
      { mode = "v"; key = "J"; action = ":m '>+1<CR>gv=gv"; }
      { mode = "v"; key = "K"; action = ":m '<-2<CR>gv=gv"; }
      { mode = "n"; key = "<C-d>"; action = "<C-d>zz"; }
      { mode = "n"; key = "<C-u>"; action = "<C-u>zz"; }
      {
        mode = "n";
        key = "<leader>com";
        action = "0t,2li<Enter><Esc>V=<Esc>";
      }
      {
        mode = "n";
        key = "<leader>per";
        action = "0t.a<Enter><Esc>V=q002t.a<Enter><Esc>V=q8@0";
      }
      {
        mode = "t";
        key = "jf";
        action = "<C-\\><C-n>";
        options.noremap = true;
      }
      {
        mode = "n";
        key = "<leader>had";
        action.__raw = "function() require'harpoon':list():add() end";
      }
      {
        mode = "n";
        key = "<leader>har";
        action.__raw = ''function() require'harpoon'.ui:toggle_quick_menu(
            require'harpoon':list()
          ) end'';
      }
      {
        mode = "n";
        key = "<leader>1";
        action.__raw = "function() require'harpoon':list():select(1) end";
      }
      {
        mode = "n";
        key = "<leader>2";
        action.__raw = "function() require'harpoon':list():select(2) end";
      }
      {
        mode = "n";
        key = "<leader>3";
        action.__raw = "function() require'harpoon':list():select(3) end";
      }
      {
        mode = "n";
        key = "<leader>4";
        action.__raw = "function() require'harpoon':list():select(4) end";
      }
    ];
  };
}

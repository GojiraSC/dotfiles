vim.g.mapleader = " "
vim.g.localleader = "\\"

vim.opt.guicursor = "n-v-c:block,i-ci-ve:block-blinkwait300-blinkon200-blinkoff150,r-cr:hor20,o:hor50"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 3
vim.opt.shiftwidth = 3
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.o.title = true
vim.o.titlestring = "nvim %t"


-- Basic Keymaps
vim.keymap.set("n", "<leader>;", function() require("alpha").start() end, { desc = "Show Dashboard" })
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>wq', '<cmd>wq<CR>', { desc = "Save and Quit" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = 'Quit window' })
vim.keymap.set("n", "<leader>dv", ":DiffviewOpen<CR>", { desc = "Open Diffview" })
vim.keymap.set("n", "<leader>dh", ":DiffviewFileHistory<CR>", { desc = "Diffview File History" })
vim.keymap.set('n', '<leader>dc', ':DiffviewClose<CR>', { desc = 'Close Diffview' })
vim.keymap.set("n", "<leader>qq", ":q!<CR>", { desc = "Force quit" })
vim.keymap.set("n", "<leader>x", ":!bash %<CR>", { desc = "Run current file as script" })
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode" })


-- DAP Keymaps
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'DAP: Start/Continue' })
vim.keymap.set('n', '<F6>', function() require('dap').step_over() end, { desc = 'DAP: Step Over' })
vim.keymap.set('n', '<F7>', function() require('dap').step_into() end, { desc = 'DAP: Step Into' })
vim.keymap.set('n', '<F8>', function() require('dap').step_out() end, { desc = 'DAP: Step Out' })
vim.keymap.set("n", "<F9>", function() require('dap').toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>db', function() require('dap').toggle_breakpoint() end, { desc = 'DAP: Toggle Breakpoint' })
vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end, { desc = 'DAP: Toggle UI' })


-- Dadbod UI
vim.g.db_ui_use_nerd_fonts = 1
vim.keymap.set("n", "<leader>db", "<cmd>DBUIToggle<cr>", { desc = "Toggle Dadbod UI" })


-- Lazygit Keymap
vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })


-- Bufferline keymaps
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>BufferLinePick<cr>", { desc = "Pick buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>BufferLinePickClose<cr>", { desc = "Close picked buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", { desc = "Close other buffers" })


-- Moving Files Keymap
vim.keymap.set("n", "<leader>mv", function()
  local old = vim.fn.expand("%:p")
  vim.ui.input({ prompt = "Move to: ", default = old, completion = "file" }, function(new)
    if new and new ~= "" and new ~= old then
      vim.cmd("w")
      os.rename(old, new)
      vim.cmd("edit " .. new)
    end
  end)
end, { desc = "Move current file" })


-- Opening Terminal
vim.keymap.set("n", "<leader>t", function()
  vim.cmd("belowright split")
  vim.cmd("resize 15")
  vim.cmd("terminal bash")
  vim.cmd("startinsert")
end, { desc = "Open terminal" })


-- gcc, g++, rustc, lua, python, bash, arduino, sql, and ada compiling
vim.keymap.set("n", "<leader>r", function()
   vim.cmd("w")  -- Save file first
   local ft = vim.bo.filetype
   local filename = vim.fn.expand("%")
   local basename = vim.fn.expand("%:t:r")
   local cmd

  if ft == "c" then
    cmd = string.format("gcc %s -o %s && ./%s; exec bash", filename, basename, basename)
  elseif ft == "cpp" then
    cmd = string.format("g++ %s -o %s && ./%s; exec bash", filename, basename, basename)
  elseif ft == "rust" then
  if vim.fn.filereadable("Cargo.toml") == 1 then
    cmd = "cargo run; exec bash"
  else
    cmd = string.format("rustc %s -o %s && ./%s; exec bash", filename, basename, basename)
 end
  elseif ft == "lua" then
    cmd = string.format("lua %s; exec bash", filename)
  elseif ft == "python" then
    cmd = string.format("python3 %s; read", filename)
 elseif ft == "sh" or ft == "bash" then
    cmd = string.format("bash %s; exec bash", filename)
 elseif ft == "ada" then
    cmd = string.format("gnatmake %s -o %s && ./%s; exec bash", filename, basename, basename)
 elseif ft == "arduino" then
    cmd = string.format("arduino-cli compile %s && arduino-cli upload %s; exec bash", vim.fn.expand("%:h"), vim.fn.expand("%:h"))
 elseif ft == "sql" then
    cmd = string.format("psql -f %s; exec bash", filename)
 else
    vim.notify("Not a supported filetype for running!", vim.log.levels.WARN)
    return
 end

  vim.cmd("belowright split")
  vim.cmd("resize 15")
  vim.cmd("terminal bash -c '" .. cmd .. "'")
  vim.cmd("startinsert")
end, { desc = "Compile & Run (C/C++/Rust/Lua/Python/Bash/Ada/Arduino) in Terminal" })


-- ARM ASM Compiling
 vim.keymap.set("n", "<leader>aa", function()
  vim.cmd("w")  -- Save file first
  local filename = vim.fn.expand("%")
  local out = vim.fn.expand("%:r")
  -- Assemble and link
  local assemble = string.format("arm-linux-gnueabihf-as -o %s.o %s && arm-linux-gnueabihf-ld -o %s %s.o", out, filename, out, out)
  -- Run in QEMU
  local run = string.format("qemu-arm ./%s; exec bash", out)
  -- Open terminal below, assemble, run
  vim.cmd("belowright split")
  vim.cmd("resize 15")
  vim.cmd("terminal bash -c '" .. assemble .. " && " .. run .. "'")
  vim.cmd("startinsert")
end, { desc = "Assemble & Run ARM ASM in Terminal" })


-- Arduino Compile
vim.keymap.set("n", "<leader>ac", function()
  vim.cmd("w")
  vim.cmd("belowright split | resize 15 | terminal arduino-cli compile .")
  vim.cmd("startinsert")
end, { desc = "Arduino compile" })

-- Arduino Upload
vim.keymap.set("n", "<leader>au", function()
  vim.cmd("w")
  vim.cmd("belowright split | resize 15 | terminal arduino-cli upload .")
  vim.cmd("startinsert")
end, { desc = "Arduino upload" })

-- Arduino Compile + Upload
vim.keymap.set("n", "<leader>af", function()
  vim.cmd("w")
  vim.cmd("belowright split | resize 15 | terminal arduino-cli compile . && arduino-cli upload .; exec bash")
  vim.cmd("startinsert")
end, { desc = "Arduino compile & upload" })

-- Arduino Serial Monitor
vim.keymap.set("n", "<leader>as", function()
  vim.cmd("belowright split | resize 15 | terminal arduino-cli monitor")
 vim.cmd("startinsert")
end, { desc = "Arduino serial monitor" })

-- Arduino Install Library
vim.keymap.set("n", "<leader>al", function()
  local lib = vim.fn.input("Library name: ")
  if lib ~= "" then
    vim.cmd("belowright split | resize 15 | terminal arduino-cli lib install " .. lib .. "; exec bash")
    vim.cmd("startinsert")
  end
end, { desc = "Arduino install library" })


-- STM32 Flash Keymaps
vim.keymap.set("n", "<leader>sf", function()
  vim.cmd("w")
  vim.cmd("belowright split | resize 15 | terminal make flash; exec bash")
  vim.cmd("startinsert")
end, { desc = "STM32 flash" })



-- vim.pack Stuff
vim.pack.add({

  -- Startup
  { src = "https://github.com/dstein64/vim-startuptime" },

  -- Colorscheme
  "https://github.com/f4z3r/gruvbox-material.nvim",

  -- Fuzzy finder
  "https://github.com/nvim-tree/nvim-web-devicons",

  -- Treesitter
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

  -- Statusline
  "https://github.com/nvim-lualine/lualine.nvim",

  -- Session manager
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/Shatur/neovim-session-manager",

  -- Dashboard
  "https://github.com/MunifTanjim/nui.nvim",
  "https://github.com/MaximilianLloyd/ascii.nvim",
  "https://github.com/goolord/alpha-nvim",

  -- File explorer
  "https://github.com/nvim-tree/nvim-tree.lua",

  -- Orgmode
  "https://github.com/nvim-orgmode/orgmode",

  -- Telescope
  "https://github.com/nvim-telescope/telescope.nvim",

  -- Mason
  "https://github.com/williamboman/mason.nvim",
  "https://github.com/williamboman/mason-lspconfig.nvim",
  "https://github.com/jay-babu/mason-nvim-dap.nvim",

  -- DAP
  "https://github.com/mfussenegger/nvim-dap",

  -- LSP
  "https://github.com/neovim/nvim-lspconfig",

  -- Git Stuff
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },

  -- Bufferline
  { src = "https://github.com/akinsho/bufferline.nvim" },

  -- Status Column
  { src = "https://github.com/luukvbaal/statuscol.nvim" },

  -- Line-Justice
  "https://github.com/zaakiy/line-justice.nvim",

  -- SQL Database Stuff
  { src = "https://github.com/tpope/vim-dadbod" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-ui" },
  { src = "https://github.com/kristijanhusak/vim-dadbod-completion" },

  -- Completion
  "https://github.com/hrsh7th/nvim-cmp",
  "https://github.com/hrsh7th/cmp-nvim-lsp",
  "https://github.com/hrsh7th/cmp-buffer",
  "https://github.com/hrsh7th/cmp-path",
  "https://github.com/L3MON4D3/LuaSnip",
  "https://github.com/saadparwaiz1/cmp_luasnip",
  "https://github.com/rafamadriz/friendly-snippets",
})


-- Line Justice
local lj = require("line-justice")
lj.setup({
  line_numbers = {
    theme = nil,
    overrides = {
      CursorLine    = { fg = "#ffd966", bold = true },
      AbsoluteAbove = { fg = "#a89984" },
      AbsoluteBelow = { fg = "#a89984" },
      RelativeAbove = { fg = "#cfe2f3" },
      RelativeBelow = { fg = "#fce5cd" },
      WrappedLine   = { fg = "#928374", italic = true },
    },
  },
})

local builtin = require("statuscol.builtin")
require("statuscol").setup({
  relculright = true,
  ft_ignore = { "NvimTree", "tutor" },
  bt_ignore = { "terminal" },
  segments = {
    { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
    { sign = { namespace = { "gitsigns" }, maxwidth = 1, colwidth = 1, auto = true }, click = "v:lua.ScSa" },
    { sign = { namespace = { "diagnostic/signs" }, maxwidth = 2, auto = true }, click = "v:lua.ScSa" },
    { sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true }, click = "v:lua.ScSa" },
    { text = { lj.segment }, click = "v:lua.ScLa" },
  },
})

-- Colorscheme
require("gruvbox-material").setup({})
vim.cmd("colorscheme gruvbox-material")


-- nvim-web-devicons (c++, lua, ada, asm)
require("nvim-web-devicons").set_icon({
   cpp = {
      icon ="",
      color = "#519aba",
      name = "Cpp",
   },
   lua = {
      icon = "",
      color = "#000080",
      name = "Lua",
   },
   adb = {
      icon = "",
      color = "#38761d",
      name = "Ada",
   },
   ads = {
      icon = "",
      color = "#8fce00",
      name = "AdaSpec",
   },
   gpr = {
      icon = "",
      color = "#999999",
      name = "AdaProject",
   },
   asm = {
      icon = "",
      color = "#6A7EC2",
      name = "Asm",
   },
   sh = {
      icon = "",
      color = "#848282",
      name = "Bash",
   },
   rs = {
      icon = "󱘗",
      color = "#CE422B",
      name = "Rust",
   },
   css = {
      icon = "",
      color = "#2986cc",
      name = "CSS",
   },
})

vim.defer_fn(function()
   vim.api.nvim_set_hl(0, "DevIconLua", { fg = "#000080" })
end, 100)

vim.defer_fn(function()
   vim.api.nvim_set_hl(0, "DevIconAsm", { fg = "#6A7EC2" })
end, 100)

vim.defer_fn(function()
   vim.api.nvim_set_hl(0, "DevIconBash", { fg = "#848282" })
end, 100)


-- Gitsigns
require("gitsigns").setup({
  signs = {
    add          = { text = "│" },
    change       = { text = "│" },
    delete       = { text = "_" },
    topdelete    = { text = "‾" },
    changedelete = { text = "~" },
    untracked    = { text = "┆" },
  },
  current_line_blame = false,
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol",
    delay = 500,
  },
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end

    -- Navigation between hunks
    map("n", "]c", function()
      if vim.wo.diff then return "]c" end
      vim.schedule(function() gs.nav_hunk("next") end)
      return "<Ignore>"
    end, "Next hunk")

    map("n", "[c", function()
      if vim.wo.diff then return "[c" end
      vim.schedule(function() gs.nav_hunk("prev") end)
      return "<Ignore>"
    end, "Previous hunk")

    -- Actions
    map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
    map("v", "<leader>hs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage hunk")
    map("v", "<leader>hr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset hunk")
    map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
    map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")
    map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
    map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")
    map("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
    map("n", "<leader>hd", gs.diffthis, "Diff this")
    map("n", "<leader>hD", function() gs.diffthis("~") end, "Diff this ~")

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Select hunk")
  end,
})


-- Shared function for finding project files
_G.find_project_files = function()
  require("telescope.builtin").find_files({
    search_dirs = {
      "~/cprojects",
      "~/rustprojects",
      "~/adaprojects",
      "~/asmprojects",
      "~/cpp-projects",
      "~/luaprojects",
      "~/exercism",
      "~/dotfiles",
      "~/Documents",
      "~/.config",
      "~/org",
    },
    hidden = true,
  })
end


-- Bufferline
require("bufferline").setup({
  options = {
    mode = "buffers",
    diagnostics = "nvim_lsp",
    show_buffer_close_icons = true,
    show_close_icon = false,
    separator_style = "slant",
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true,
      },
    },
  },
})


-- Lualine
require("lualine").setup({
  options = {
    theme = "auto",
    section_separators = "",
    component_separators = "",
  },
  sections = {
    lualine_a = {
      {
        "mode",
        color = function()
          local mode_colors = {
            n  = { fg = "#1d2021", bg = "#fabd2f", gui = "bold" },  -- yellow
            i  = { fg = "#1d2021", bg = "#83a598", gui = "bold" },  -- blue
            v  = { fg = "#1d2021", bg = "#b8bb26", gui = "bold" },  -- green
            V  = { fg = "#1d2021", bg = "#b8bb26", gui = "bold" },  -- green
            [""] = { fg = "#1d2021", bg = "#b8bb26", gui = "bold" }, -- visual block (ctrl-v)
            c  = { fg = "#1d2021", bg = "#fe8019", gui = "bold" },  -- orange
            R  = { fg = "#1d2021", bg = "#fb4934", gui = "bold" },  -- red
            t  = { fg = "#1d2021", bg = "#d3869b", gui = "bold" },  -- purple
          }
          return mode_colors[vim.fn.mode()] or mode_colors.n
        end,
      },
    },
    lualine_b = {
  {
    "branch",
    color = { fg = "#56aef1", gui = "bold" },
  },
},
    lualine_c = {
  {
    "filename",
    color = { fg = "#d5c4a1" },
  },
},
    lualine_x = {
  { "encoding", color = { fg = "#a89984" } },
  {
  "fileformat",
  symbols = {
    unix = "",
    dos = "󰨡",
    mac = "",
  },
  color = { fg = "#ffd966" },
},
  { "filetype", color = { fg = "#fabd2f" } },
},
    lualine_y = {
  { "progress", color = { fg = "#8fce00" } },
},
    lualine_z = {
  { "location", color = { fg = "#134f5c" } },
},
  },
})


-- Session Manager
require("session_manager").setup({
  autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
})


-- Alpha Dashboard
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local ascii = require("ascii")

local neovim_section = {
  type = "text",
  val = ascii.art.text.neovim.sharp,
  opts = { position = "center", hl = "AlphaHeader" },
}

local ghost_section = {
  type = "text",
  val = ascii.art.gaming.pacman.basic,
  opts = { position = "center", hl = "AlphaGhost" },
}

vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#fabd2f" })
vim.api.nvim_set_hl(0, "AlphaGhost", { fg = "#2a52be" })

dashboard.section.buttons.val = {
   dashboard.button("n", " -> New File", ":ene <BAR> startinsert<CR>"),
   dashboard.button("f", "󰈞 -> Find File", ":lua _G.find_project_files()<CR>"),
   dashboard.button("r", " -> Recent File", ":Telescope oldfiles<CR>"),
   dashboard.button("e", "󰷈 -> Edit Config", ":e $MYVIMRC<CR>"),
   dashboard.button("u", "󰚰 -> Update Plugins", "<cmd>lua vim.pack.update()<CR>"),
   dashboard.button("m", " -> Jump to Bookmarks", ":Telescope marks<CR>"),
   dashboard.button("l", " -> Open Last Session", ":SessionManager load_last_session<CR>"),
   dashboard.button("q", "󰩈 -> Quit NVIM", ":qa<CR>"),
}

dashboard.section.footer.val = function()
  local v = vim.version()
  local nvim_version = string.format("v%d.%d.%d", v.major, v.minor, v.patch)
  return " Neovim " .. nvim_version
end

dashboard.section.buttons.opts.position = "center"

dashboard.opts.layout = {
  { type = "padding", val = 2 },
  neovim_section,
  { type = "padding", val = 2 },
  ghost_section,
  { type = "padding", val = 3 },
  dashboard.section.buttons,
  { type = "padding", val = 3 },
  dashboard.section.footer,
}

alpha.setup(dashboard.config)


-- Nvim Tree
require("nvim-tree").setup({})
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle file tree" })


-- Treesitter (native)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp", "lua", "rust", "python", "bash", "markdown", "vim","asm", "ada", "arduino" },
  callback = function()
    vim.treesitter.start()
  end,
})


-- Orgmode
require("orgmode").setup({
  org_agenda_files = "~/org/**/*",
  org_default_notes_file = "~/org/refile.org",
})


-- Telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })

-- Search files from home directory
vim.keymap.set("n", "<leader>fH", _G.find_project_files, { desc = "Find project files" })

-- Search files from root (everywhere)
vim.keymap.set("n", "<leader>f/", function()
  require("telescope.builtin").find_files({
    cwd = "/",
    hidden = true,
    no_ignore = true,
  })
end, { desc = "Find files (root)" })


-- Mason
require("mason").setup()


-- LSP
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- C/C++
vim.lsp.config.clangd = {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_markers = { "compile_commands.json", ".git" },
  capabilities = capabilities,
}

-- Python
vim.lsp.config.pyright = {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json", "setup.py", "pyproject.toml", ".git" },
  capabilities = capabilities,
}

-- Rust
vim.lsp.config.rust_analyzer = {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", ".git" },
  capabilities = capabilities,
}

-- Lua
vim.lsp.config.lua_ls = {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".luarc.json", ".git" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
}

-- Bash
vim.lsp.config.bashls = {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
  capabilities = capabilities,
}

-- Ada
vim.lsp.config.als = {
  cmd = { "ada_language_server" },
  filetypes = { "ada" },
  root_markers = { "*.gpr", "alire.toml", ".git" },
  capabilities = capabilities,
}

-- Arduino Uno/STM32
vim.lsp.config.arduino_language_server = {
   cmd = {
      "arduino-language-server",
      "-cli-config", vim.fn.expand("~/.arduino15/arduino-cli.yaml"),
   },
   filetypes = { "arduino" },
   root_markers = { "sketch.yaml", ".git" },
   capabilities = capabilities,
}

-- SQL
vim.lsp.config.sqls = {
  cmd = { "sqls" },
  filetypes = { "sql" },
  root_markers = { ".git" },
  capabilities = capabilities,
}

vim.lsp.enable("clangd")
vim.lsp.enable("pyright")
vim.lsp.enable("rust_analyzer")
vim.lsp.enable("lua_ls")
vim.lsp.enable("bashls")
vim.lsp.enable("als")
vim.lsp.enable("arduino_language_server")
vim.lsp.enable("sqls")


-- DAP
local dap = require("dap")

-- C/C++
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}

---@diagnostic disable: missing-fields, inject-field
dap.configurations.c = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

dap.configurations.cpp = dap.configurations.c

-- Python
dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/debugpy-adapter",
}

dap.configurations.python = {
  {
    name = "Launch",
    type = "python",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pythonPath = function()
      local venv = os.getenv("VIRTUAL_ENV")
      if venv then
        return venv .. "/bin/python"
      end
      return "/usr/bin/python3"
    end,
  },
}

-- Rust (uses codelldb)
dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- Bash
dap.adapters.bashdb = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/bash-debug-adapter",
}

dap.configurations.sh = {
  {
    name = "Launch",
    type = "bashdb",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    pathBashdb = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir/bashdb",
    pathBashdbLib = vim.fn.stdpath("data") .. "/mason/packages/bash-debug-adapter/extension/bashdb_dir",
    pathBash = "/bin/bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    env = {},
    args = {},
  },
}

-- ARM Assembly (uses codelldb)
dap.configurations.asm = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

-- Ada (uses codelldb)
dap.configurations.ada = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}



-- Completion (nvim-cmp)
local cmp = require("cmp")
local luasnip = require("luasnip")
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
})


-- Shell format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.sh",
  callback = function()
    vim.cmd("silent! !shfmt -w %")
  end,
})


-- Diagnostics
vim.diagnostic.config({
  virtual_text = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

vim.o.updatetime = 300
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

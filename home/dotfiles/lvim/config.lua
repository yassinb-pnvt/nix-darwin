-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

-- User configuration - YB 
-- Recommanded for avante
vim.opt.laststatus = 3

-- Enable relative and absolute line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable transparency in tmux
-- This allows the terminal background to show through
local function enable_transparency()
  -- Core UI elements
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NonText", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "NONE" })
  
  -- Line numbers and signs
  vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "NONE" })
  
  -- Folding
  vim.api.nvim_set_hl(0, "Folded", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FoldColumn", { bg = "NONE" })
  
  -- Cursor and selection
  vim.api.nvim_set_hl(0, "CursorLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorColumn", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "Visual", { bg = "NONE" })
  
  -- Status lines
  vim.api.nvim_set_hl(0, "StatusLine", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinSeparator", { bg = "NONE" })
  
  -- Windows and splits
  vim.api.nvim_set_hl(0, "WinBar", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "WinBarNC", { bg = "NONE" })
  
  -- Popup menus and floating windows
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuSel", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "NONE" })
  
  -- Notifications (for nvim-notify)
  vim.api.nvim_set_hl(0, "NotifyBackground", { bg = "NONE" })
  
  -- Telescope and other plugins
  vim.api.nvim_set_hl(0, "TelescopeNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePromptBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopeResultsBorder", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePreviewNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "TelescopePreviewBorder", { bg = "NONE" })
end

-- Apply transparency on startup
vim.api.nvim_create_autocmd("VimEnter", {
  pattern = "*",
  callback = function()
    enable_transparency()
    -- Force redraw to ensure transparency is applied
    vim.cmd("redraw!")
  end,
})

-- Re-apply transparency when colorscheme changes
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    enable_transparency()
    vim.cmd("redraw!")
  end,
})

-- Re-apply transparency when entering a window (for tmux splits)
vim.api.nvim_create_autocmd("WinEnter", {
  pattern = "*",
  callback = enable_transparency,
})

-- Re-apply transparency when buffer changes
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = enable_transparency,
})

-- Re-apply transparency after UI events (like CMD+e or other keybindings)
vim.api.nvim_create_autocmd("UIEnter", {
  pattern = "*",
  callback = enable_transparency,
})

-- Re-apply transparency when focus changes (for tmux window switching)
vim.api.nvim_create_autocmd("FocusGained", {
  pattern = "*",
  callback = enable_transparency,
})

-- Create a command to manually re-apply transparency
vim.api.nvim_create_user_command("Transparency", function()
  enable_transparency()
  vim.cmd("redraw!")
  vim.notify("Transparency re-applied", vim.log.levels.INFO)
end, { desc = "Re-apply transparency to all UI elements" })

lvim.plugins = {
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  'github/copilot.vim',
  'hashivim/vim-terraform',
  'vim-syntastic/syntastic',
  'juliosueiras/vim-terraform-completion',
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true, -- show icons in the signs column
    sign_priority = 8, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = " ", -- icon used for the sign, and in search results
        color = "error", -- can be a hex color, or a named color (see below)
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = " ", color = "info" },
      HACK = { icon = " ", color = "warning" },
      WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      JIRA = { icon = "⭕", color = "#0366fc", alt = { "jira", "TICKET"} },
      NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
    },
    gui_style = {
      fg = "NONE", -- The gui style to use for the fg highlight group.
      bg = "BOLD", -- The gui style to use for the bg highlight group.
    },
    merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      multiline = true, -- enable multine todo comments
      multiline_pattern = "^.", -- lua pattern to match the next multiline from the start of the matched keyword
      multiline_context = 10, -- extra lines that will be re-evaluated when changing a line
      before = "", -- "fg" or "bg" or empty
      keyword = "wide", -- "fg", "bg", "wide", "wide_bg", "wide_fg" or empty. (wide and wide_bg is the same as bg, but will also highlight surrounding characters, wide_fg acts accordingly but with fg)
      after = "fg", -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlighting (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of highlight groups or use the hex color if hl not found as a fallback
    colors = {
      error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
      warning = { "DiagnosticWarn", "WarningMsg", "#FBBF24" },
      info = { "DiagnosticInfo", "#2563EB" },
      hint = { "DiagnosticHint", "#10B981" },
      default = { "Identifier", "#7C3AED" },
      test = { "Identifier", "#FF00FF" }
    },
    search = {
      command = "rg",
      args = {
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      {
        "rcarriga/nvim-notify",
        opts = {
          background_colour = "#000000", -- Required for transparency
          timeout = 3000,
        },
        config = function()
          require("notify").setup({
            background_colour = "#000000", -- Required for transparency
            timeout = 3000,
          })
        end,
      },
    }
  },
  {
    "phaazon/hop.nvim",
    event = "BufRead",
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
      vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
    end,
  },
  {
    "mistweaverco/kulala.nvim",
    event = "VeryLazy",
    config = function()
      require("kulala").setup({
        -- Optional: customize kulala settings
        -- See https://neovim.getkulala.net/ for configuration options
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter", -- For response highlighting
    },
  },
  {
  "nvim-pack/nvim-spectre",
  event = "BufRead",
  config = function()
    require("spectre").setup()
  end,
  },
  -- required.
  { 'hrsh7th/nvim-cmp' },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- add any opts here
      -- for example
      -- provider = "gemini",
      providers = {
        gemini = {
          model = "gemini-2.0-flash",
          timeout = 30000,
          temperature = 0,
        },
      }
      -- openai = {
      --   endpoint = "https://api.openai.com/v1",
      --   model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      --   timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
      --   temperature = 0,
      --   max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
      --   --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      -- },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  }
}

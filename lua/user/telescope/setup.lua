if not pcall(require, 'telescope') then
  return
end

local actions = require 'telescope.actions'
local action_layout = require 'telescope.actions.layout'
local putils = require 'telescope.previewers.utils'

require('telescope').setup {
  defaults = {
    prompt_prefix = '> ',
    selection_caret = '> ',
    entry_prefix = '  ',
    multi_icon = '<>',

    -- path_display = "truncate",

    winblend = 0,

    layout_strategy = 'horizontal',
    layout_config = {
      width = 0.95,
      height = 0.85,
      -- preview_cutoff = 120,
      prompt_position = 'top',

      horizontal = {
        preview_width = function(_, cols, _)
          if cols > 200 then
            return math.floor(cols * 0.4)
          else
            return math.floor(cols * 0.6)
          end
        end,
      },

      vertical = {
        width = 0.9,
        height = 0.95,
        preview_height = 0.5,
      },

      flex = {
        horizontal = {
          preview_width = 0.9,
        },
      },
    },

    selection_strategy = 'reset',
    sorting_strategy = 'descending',
    scroll_strategy = 'cycle',
    color_devicons = true,

    mappings = {
      i = {
        ['<RightMouse>'] = actions.close,
        ['<LeftMouse>'] = actions.select_default,
        ['<ScrollWheelDown>'] = actions.move_selection_next,
        ['<ScrollWheelUp>'] = actions.move_selection_previous,

        ['<C-x>'] = false,
        ['<C-s>'] = actions.select_horizontal,
        ['<C-n>'] = 'move_selection_next',

        ['<C-e>'] = actions.results_scrolling_down,
        ['<C-y>'] = actions.results_scrolling_up,
        -- ["<C-y>"] = set_prompt_to_entry_value,

        -- These are new :)
        ['<M-p>'] = action_layout.toggle_preview,
        ['<M-m>'] = action_layout.toggle_mirror,
        -- ["<M-p>"] = action_layout.toggle_prompt_position,

        -- ["<M-m>"] = actions.master_stack,

        -- ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        -- ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        -- This is nicer when used with smart-history plugin.
        ['<C-k>'] = actions.cycle_history_next,
        ['<C-j>'] = actions.cycle_history_prev,
        ['<c-g>s'] = actions.select_all,
        ['<c-g>a'] = actions.add_selection,

        -- ["<c-space>"] = function(prompt_bufnr)
        --   local opts = {
        --     callback = actions.toggle_selection,
        --     loop_callback = actions.send_selected_to_qflist,
        --   }
        --   require("telescope").extensions.hop._hop_loop(prompt_bufnr, opts)
        -- end,

        ['<C-w>'] = function()
          vim.api.nvim_input '<c-s-w>'
        end,
      },

      n = {
        ['<C-e>'] = actions.results_scrolling_down,
        ['<C-y>'] = actions.results_scrolling_up,
      },
    },

    -- borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
    -- file_ignore_patterns = nil,

    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,

    history = {
      path = '~/.local/share/nvim/databases/telescope_history.sqlite3',
      limit = 100,
    },

    preview = {
      filetype_hook = function(filepath, bufnr, opts)
        if filepath:match 'cody%-agent.js' then
          putils.set_preview_message(bufnr, opts.winid, string.format 'very compiled javascript', ' ')
          return false
        end

        return true
      end,

      -- 2) Truncate lines to preview window for too large files
      -- filesize_hook = function(filepath, bufnr, opts)
      --   local path = require("plenary.path"):new(filepath)
      --   -- opts exposes winid
      --   local height = vim.api.nvim_win_get_height(opts.winid)
      --   local lines = vim.split(path:head(height), "[\r]?\n")
      --   vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
      -- end,
    },
  },

  pickers = {
    find_files = {
      -- I don't like having the cwd prefix in my files
      find_command = vim.fn.executable 'fdfind' == 1 and { 'fdfind', '--strip-cwd-prefix', '--type', 'f' } or nil,

      mappings = {
        n = {
          ['kj'] = 'close',
        },
      },
    },

    git_branches = {
      mappings = {
        i = {
          ['<C-a>'] = false,
        },
      },
    },

    buffers = {
      sort_lastused = true,
      sort_mru = true,
    },
  },

  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },

    fzf_writer = {
      use_highlighter = false,
      minimum_grep_characters = 6,
    },

    hop = {
      -- keys define your hop keys in order; defaults to roughly lower- and uppercased home row
      keys = { 'a', 's', 'd', 'f', 'g', 'h', 'j', 'k', 'l', ';' }, -- ... and more

      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { 'WarningMsg', 'Title' },

      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { 'CursorLine', 'Normal' },

      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },

    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
    },
  },
}

-- pcall(require("telescope").load_extension, "cheat")
-- pcall(require("telescope").load_extension, "arecibo")
-- require("telescope").load_extension "flutter"

_ = require('telescope').load_extension 'dap'
_ = require('telescope').load_extension 'notify'
_ = require('telescope').load_extension 'file_browser'
_ = require('telescope').load_extension 'ui-select'
_ = require('telescope').load_extension 'fzf'
_ = require('telescope').load_extension 'git_worktree'
_ = require('telescope').load_extension 'neoclip'

pcall(require('telescope').load_extension, 'smart_history')
pcall(require('telescope').load_extension, 'frecency')

if vim.fn.executable 'gh' == 1 then
  pcall(require('telescope').load_extension, 'gh')
  pcall(require('telescope').load_extension, 'octo')
end

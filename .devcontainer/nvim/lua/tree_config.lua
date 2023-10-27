vim.g.nvim_tree_show_icons = {
  git = 1,
  folders = 1,
  files = 0,
  folder_arrows = 0,
}
-- vim.g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     unstaged = '?',
--     staged = "✓",
--     unmerged = codicon_map['git-compare'],
--     renamed = codicon_map['arrow-small-right'],
--     untracked = "*",
--     deleted = "x",
--     ignored = "-"
--   },
--   folder = {
--     arrow_open = codicon_map['chevron-right'],
--     arrow_closed = codicon_map['chevron-down'],
--     default = codicon_map['chevron-right'],
--     open = codicon_map['chevron-down'],
--     empty = codicon_map['chevron-right'],
--     empty_open = codicon_map['chevron-down'],
--     symlink = codicon_map['file-symlink-directory'],
--     symlink_open = codicon_map['file-symlink-directory'],
--   }
-- }

local function tree_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  -- api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', 'h', api.node.navigate.parent_close, opts('close'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('open'))
  vim.keymap.set('n', 'a', api.fs.create, opts('add'))
  vim.keymap.set('n', 'r', api.fs.rename, opts('rename'))
end

-- pass to setup along with your other options
require("nvim-tree").setup {
  ---
  ---
}
vim.g.nvim_tree_icons = {
  default = "",
  symlink = "",
  git = {
    unstaged = '?',
    staged = "✓",
    unmerged = '⇆',
    renamed = '→',
    untracked = "*",
    deleted = "✗",
    ignored = "-"
  },
  folder = {
    arrow_open = '▿',
    arrow_closed = '▻',
    default = '▻',
    open = '▿',
    empty = '▻',
    empty_open = '▿',
    symlink = '►',
    symlink_open = '▾',
  }
}


require'nvim-tree'.setup {
  git = {
    ignore = false,
  },
  diagnostics = {
    enable = true,
    icons = {
      error = '✕',
      warning = '⚡',
      info = '♦',
      hint = '♦',
    }
  },
  on_attach = tree_attach,
}

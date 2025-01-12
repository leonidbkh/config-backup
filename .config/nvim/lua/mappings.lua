require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jj", "<ESC>")

local t = require 'telescope'
vim.keymap.set('n', '<leader>jv', '<cmd>Jira issue view<cr>', {})
vim.keymap.set('n', '<leader>jt', t.extensions.jira.transitions, {})
vim.keymap.set('n', '<leader>jc', '<cmd>Jira issue create<cr>', {})

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

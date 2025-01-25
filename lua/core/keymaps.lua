-- Utils
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Utils: Exit terminal mode' })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Utils: Clear highlight on search'})
vim.keymap.set("v", "p", '"_dP', { desc = 'Utils: Greatest remap ever' })

-- Windows manipulation
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Splits: Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Splits: Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Splits: Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Splits: Move focus to the upper window' })

-- Motion
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Motion: Moving with centering down' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Motion: Moving with centering up' })


-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Diagnostic: Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Diagnostic: Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Diagnostic: Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Diagnostic: Open diagnostic [Q]uickfix list' })

-- Visual mode motion
vim.keymap.set('v', '<', '<gv', { desc = 'Motion: Moving left indentation' })
vim.keymap.set('v', '>', '>gv', { desc = 'Motion: Moving right indentation' })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = 'Motion: Moving text one down' })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = 'Motion: Moving text one up' })



return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'} },
    config = function()
        local function map(mode, keys, func, desc)
            vim.keymap.set(mode, keys, func, { desc = 'Telescope: ' .. desc })
        end

        local builtin = require('telescope.builtin')

        map('n', '<leader>sh', builtin.help_tags, '[S]earch [h]elp')
        map('n', '<leader>sk', builtin.keymaps, '[S]earch [k]eymaps')
        map('n', '<leader>sf', builtin.find_files, '[S]earch [f]iles')
        map('n', '<leader>ss', builtin.builtin, '[S]earch [s]elect Telescope')
        map('n', '<leader>sw', builtin.grep_string, '[S]earch current [w]ord')
        map('n', '<leader>sg', builtin.live_grep, '[S]earch by [g]rep')
        map('n', '<leader>sd', builtin.diagnostics, '[S]earch [d]iagnostics')
        map('n', '<leader>sr', builtin.resume, '[S]earch [r]esume')
        map('n', '<leader>s.', builtin.oldfiles, '[S]earch recent files ("." for repeat)')
        map('n', '<leader>ff', builtin.current_buffer_fuzzy_find, '[F]uzzy [f]ind current buffer')
        map('n', '<C-p>', builtin.git_files, 'Search git files')
        map('n', '<leader><leader>', builtin.buffers, '[ ] Find existing buffers')
    end,
}

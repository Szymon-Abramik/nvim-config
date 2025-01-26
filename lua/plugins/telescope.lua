return {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'} },
    config = function()
        local side_preview = {
            layout_strategy = 'horizontal',
            layout_config = {
                horizontal = {
                    preview_width = 0.7,
                },
            },
        }
        local no_preview = {
            previewer = false,
            layout_strategy = 'center',
        }
        require('telescope').load_extension('fzf')
        require('telescope').setup({
            defaults = {
                prompt_prefix = '🔍 ',
                selection_caret = '> ',
                sorting_strategy = 'ascending',
                preview_title = 'Preview',
                layout_config = {
                    prompt_position = 'top',
                },

            },
            pickers = {
                diagnostics = side_preview,
                live_grep = side_preview,
                find_files = no_preview,
                buffers = no_preview,
                help_tags = no_preview ,
                current_buffer_fuzzy_find = no_preview,
                git_files = no_preview ,
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                },
            },
        })

        local builtin = require('telescope.builtin')
        local mappings = {
            { 'n', '<leader>sh', builtin.help_tags, '[S]earch [h]elp' },
            { 'n', '<leader>sk', builtin.keymaps, '[S]earch [k]eymaps' },
            { 'n', '<leader>sg', builtin.live_grep, '[S]earch by [g]rep' },
            { 'n', '<leader>sd', builtin.diagnostics, '[S]earch [d]iagnostics' },
            { 'n', '<leader>sf', builtin.find_files, '[S]earch [f]iles' },
            { 'n', '<C-p>', builtin.git_files, 'Search git files' },
            { 'n', '<leader><leader>', builtin.buffers, '[ ] Find existing buffers' },
            { 'n', '<leader>sG', function()
                vim.ui.input({ prompt = 'File pattern: ' }, function(input)
                    if input then
                        builtin.live_grep({
                            additional_args = function()
                                return { '--glob', input }
                            end,
                        })
                    end
                end)
            end, '[S]earch by [G]rep with file pattern' },
            -- { 'n', '<leader>ff', builtin.current_buffer_fuzzy_find, '[F]uzzy [f]ind current buffer' },
            -- { 'n', '<leader>ss', builtin.builtin, '[S]earch [s]elect Telescope' },
            -- { 'n', '<leader>s.', builtin.oldfiles, '[S]earch recent files ("." for repeat)' },
            -- { 'n', '<leader>sr', builtin.resume, '[S]earch [r]esume' },
            -- { 'n', '<leader>sw', builtin.grep_string, '[S]earch current [w]ord' },
        }

        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], { desc = 'Telescope: ' .. mapping[4] })
        end
    end,
}

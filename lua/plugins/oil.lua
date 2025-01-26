return {
    'stevearc/oil.nvim',
    config = function ()
        local mappings = {
            { 'n', '-', '<CMD>Oil<CR>', 'Open parent directory' },
        }
        require("oil").setup({
            default_file_explorer = true,
            columns = {
                -- "icon",
                "permissions",
                "size",
                "mtime",
            },
            view_options = {
                show_hidden = true,
                is_always_hidden = function(name, _)
                    return name == '..' or name == '.git'
                end,
            },

        })
        for _, mapping in ipairs(mappings) do
            vim.keymap.set(mapping[1], mapping[2], mapping[3], { desc = 'Oil: ' .. mapping[4] })
        end

    end,
}

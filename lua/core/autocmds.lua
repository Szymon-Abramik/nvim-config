vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'AutoCmd: Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = 'AutoCmd: Automatically trims trailing whitespace on write',
    group = vim.api.nvim_create_augroup('trim-whitespaces-write', { clear = true }),
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd("BufWritePre", {
    desc = 'AutoCmd: Deleting windows end line character ^M',
    group = vim.api.nvim_create_augroup('delete-windows-eol-write', { clear = true }),
    pattern = "*",
    callback = function()
        vim.cmd([[ %s/\r//e ]])
    end
})


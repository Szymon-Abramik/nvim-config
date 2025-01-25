return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "jdtls",
                    "ts_sl",
                    "clangd",
                    "pyright",
                },

            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = "LuaJIT",
                                path = vim.split(package.path, ";"),
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                library = {
                                    vim.fn.stdpath("config"),
                                    vim.fn.stdpath("data"),
                                    vim.fn.expand("$VIMRUNTIME"),
                                    vim.api.nvim_get_runtime_file("", true),
                                },
                                checkThirdParty = false,
                            },
                            telemetry = {
                                enable = false,
                            },
                        },},
                },
                jdtls = {},
                ts_sl = {},
                clangd = {},
                pyright = {},
            }

            for server, config in pairs(servers) do
                lspconfig[server].setup(vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    handlers = handlers,
                }, config))
            end

            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
                callback = function(event)
                    local builtin = require('telescope.builtin')

                    local mappings = {
                        { 'gd', builtin.lsp_definitions, '[G]oto [d]efinition' },
                        { 'gr', builtin.lsp_references, '[G]oto [r]eferences' },
                        { 'gI', builtin.lsp_implementations, '[G]oto [i]mplementation' },
                        { '<leader>D', builtin.lsp_type_definitions, 'Type [d]efinition' },
                        { '<leader>ds', builtin.lsp_document_symbols, '[D]ocument [s]ymbols' },
                        { '<leader>ws', builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [s]ymbols' },
                        { '<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame' },
                        { '<leader>ca', vim.lsp.buf.code_action, '[C]ode [a]ction' },
                        { 'K', vim.lsp.buf.hover, 'Hover Documentation' },
                        { 'gD', vim.lsp.buf.declaration, '[G]oto [d]eclaration' },
                    }

                    for _, mapping in ipairs(mappings) do
                        vim.keymap.set('n', mapping[1], mapping[2], { buffer = bufnr, desc = 'LSP: ' .. mapping[3] })
                    end
                    local client = vim.lsp.get_client_by_id(event.data.client_id)
                    if client and client.server_capabilities.documentHighlightProvider then
                        vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                            group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true }),
                            buffer = event.buf,
                            callback = vim.lsp.buf.document_highlight,
                        })

                        vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                            group = vim.api.nvim_create_augroup('lsp-clear', { clear = true }),
                            buffer = event.buf,
                            callback = vim.lsp.buf.clear_references,
                        })
                    end
                end,
            })
        end,
    },
}

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
                    "ts_ls",
                    "clangd",
                    "pyright",
                },
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local on_attach = function(client, bufnr)
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
                require('telescope').setup({
                    pickers = {
                        lsp_definitions = side_preview,
                        lsp_references = side_preview,
                        lsp_implementations = side_preview,
                        lsp_type_definitions = side_preview,
                        lsp_document_symbols = no_preview,
                        lsp_workspace_symbols = no_preview,
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
                    { 'gd', builtin.lsp_definitions, '[G]oto [d]efinition' },
                    { 'gr', builtin.lsp_references, '[G]oto [r]eferences' },
                    { '<leader>gI', builtin.lsp_implementations, '[G]oto [i]mplementation' },
                    -- { '<leader>D', builtin.lsp_type_definitions, 'Type [d]efinition' },
                    { '<leader>sc', function()
                        builtin.lsp_workspace_symbols({
                            prompt_title = "Search Classes in Workspace",
                            symbols = { "class", "type" },
                        })
                    end, '[S]earch [C]lasses in workspace' },
                    { '<leader>sm', function()
                        builtin.lsp_document_symbols({
                            prompt_title = "Search Methods in File",
                            symbols = { "method", "function" },
                        })
                    end, '[S]earch [M]ethods in file' },
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
                if client.server_capabilities.documentHighlightProvider then
                    vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                        group = vim.api.nvim_create_augroup('lsp-highlight', { clear = true }),
                        buffer = bufnr,
                        callback = vim.lsp.buf.document_highlight,
                    })

                    vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                        group = vim.api.nvim_create_augroup('lsp-clear', { clear = true }),
                        buffer = bufnr,
                        callback = vim.lsp.buf.clear_references,
                    })
                end
            end

            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = {
                                version = 'LuaJIT',
                            },
                            diagnostics = {
                                globals = { "vim" },
                            },
                            workspace = {
                                checkThirdParty = false,
                                library = {
                                    vim.env.VIMRUNTIME,
                                },
                            },
                            telemetry = {
                                enable = false,
                            },
                        },
                    },
                },
                jdtls = {},
                ts_ls = {},
                clangd = {},
                pyright = {
                    settings = {
                        python = {
                            analysis = {
                                typeCheckingMode = "strict",
                                autoSearchPaths = true,
                                useLibraryCodeForTypes = true,
                            },
                        },
                    },
                },
            }

            local lspconfig = require("lspconfig")
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

            for server, config in pairs(servers) do
                lspconfig[server].setup(vim.tbl_deep_extend("force", {
                    capabilities = capabilities,
                    on_attach = on_attach,
                }, config))
            end
        end,
    },
}

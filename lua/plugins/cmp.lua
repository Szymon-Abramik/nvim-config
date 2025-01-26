return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp", -- LSP completion
            "hrsh7th/cmp-buffer", -- Buffer completion
            "hrsh7th/cmp-path", -- Path completion
            "hrsh7th/cmp-cmdline", -- Cmdline completion
            -- Snippets
            'L3MON4D3/LuaSnip', -- Snippet engine
            'saadparwaiz1/cmp_luasnip', -- Integration with cmp
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
                 formatting = {
                    fields = { "kind", "abbr", "menu" },
                    format = function(entry, item)
                        local menu_icon = {
                            nvim_lsp = "λ",
                            buffer = "[Buffer]",
                            path = "[Path]",
                            luasnip = "[Snippet]",
                            nvim_lsp_signature_help = "[Signature]",
                        }
                        item.menu = menu_icon[entry.source.name] or entry.source.name
                        return item
                    end,
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = "buffer" },
                },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = "path" },
                }, {
                    { name = "cmdline" },
                }),
            })
        end,
    },
}


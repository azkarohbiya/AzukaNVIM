return {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
        -- add tsx and treesitter
        vim.list_extend(opts.ensure_installed, {
            "tsx",
            "typescript",
            "lua",
            "python",
            "javascript",
            "html",
            "css",
            "markdown",
            "sql",
        })
    end,
    init = function()
        -- nvim-treesitter master branch passes Lua table nodes to vim.treesitter.get_range,
        -- but Neovim 0.12.2 calls node:range(true) on them, crashing because the method is absent.
        -- Guard against nil/missing range method until nvim-treesitter is updated.
        local orig = vim.treesitter.get_range
        vim.treesitter.get_range = function(node, source, metadata)
            if not node or type(node.range) ~= "function" then
                return { 0, 0, 0, 0, 0, 0 }
            end
            return orig(node, source, metadata)
        end
    end,
}

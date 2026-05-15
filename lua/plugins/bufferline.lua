return {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
        require("bufferline").setup({
            options = {
                mode = "buffers",
                separator_style = "slant",
                diagnostics = "nvim_lsp",
                show_buffer_close_icons = false,
                show_close_icon = false,
                get_element_icon = function(opts)
                    local path = opts and opts.path
                    if not path or path == "" then
                        return "", ""
                    end
                    local ok, MiniIcons = pcall(require, "mini.icons")
                    if ok then
                        local icon, hl = MiniIcons.get("file", path)
                        return icon or "", hl or ""
                    end
                    local ok2, devicons = pcall(require, "nvim-web-devicons")
                    if ok2 then
                        local name = vim.fn.fnamemodify(path, ":t")
                        local icon, hl = devicons.get_icon(name, nil, { default = true })
                        return icon or "", hl or ""
                    end
                    return "", ""
                end,
            },
        })
    end,
}

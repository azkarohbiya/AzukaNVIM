return {
    {
        "pinecoders/vim-pine-script",
        ft = "psl",
        init = function()
            -- map .pine extension to psl filetype (plugin only ships ftdetect for .psl)
            vim.filetype.add({ extension = { pine = "psl" } })
        end,
    },
}

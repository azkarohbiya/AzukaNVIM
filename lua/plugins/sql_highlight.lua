local function pick_sql_highlight()
    local syntax_options = {
        "── Syntax Mode ──────────────────",
        "Treesitter (default)",
        "Vim built-in regex",
        "Dadbod syntax",
        "Enhanced (vim-sql-syntax)",
        "── Colorscheme ──────────────────",
        "Catppuccin Macchiato (default)",
        "Catppuccin Mocha",
        "Catppuccin Latte",
        "TokyoNight Night",
        "TokyoNight Storm",
        "TokyoNight Moon",
        "Rose Pine",
        "Rose Pine Moon",
        "Rose Pine Dawn",
    }

    vim.ui.select(syntax_options, { prompt = "SQL Highlighting:" }, function(choice)
        if not choice or choice:match("^──") then
            return
        end

        -- Syntax modes
        if choice == "Treesitter (default)" then
            vim.bo.syntax = "off"
            pcall(vim.treesitter.start, 0, "sql")
            vim.notify("SQL: Treesitter highlighting", vim.log.levels.INFO)
        elseif choice == "Vim built-in regex" then
            pcall(vim.treesitter.stop, 0)
            vim.bo.syntax = "sql"
            vim.notify("SQL: Vim built-in highlighting", vim.log.levels.INFO)
        elseif choice == "Dadbod syntax" then
            pcall(vim.treesitter.stop, 0)
            vim.bo.syntax = "sql"
            vim.g.vim_dadbod_syntax = 1
            vim.cmd("runtime! syntax/sql.vim")
            vim.notify("SQL: Dadbod highlighting", vim.log.levels.INFO)
        elseif choice == "Enhanced (vim-sql-syntax)" then
            pcall(vim.treesitter.stop, 0)
            vim.bo.syntax = "sql"
            vim.cmd("runtime! syntax/sql.vim")
            vim.notify("SQL: Enhanced highlighting", vim.log.levels.INFO)

        -- Colorschemes
        elseif choice == "Catppuccin Macchiato (default)" then
            vim.cmd("colorscheme catppuccin-macchiato")
            vim.notify("Colorscheme: Catppuccin Macchiato", vim.log.levels.INFO)
        elseif choice == "Catppuccin Mocha" then
            vim.cmd("colorscheme catppuccin-mocha")
            vim.notify("Colorscheme: Catppuccin Mocha", vim.log.levels.INFO)
        elseif choice == "Catppuccin Latte" then
            vim.cmd("colorscheme catppuccin-latte")
            vim.notify("Colorscheme: Catppuccin Latte (light)", vim.log.levels.INFO)
        elseif choice == "TokyoNight Night" then
            vim.cmd("colorscheme tokyonight-night")
            vim.notify("Colorscheme: TokyoNight Night", vim.log.levels.INFO)
        elseif choice == "TokyoNight Storm" then
            vim.cmd("colorscheme tokyonight-storm")
            vim.notify("Colorscheme: TokyoNight Storm", vim.log.levels.INFO)
        elseif choice == "TokyoNight Moon" then
            vim.cmd("colorscheme tokyonight-moon")
            vim.notify("Colorscheme: TokyoNight Moon", vim.log.levels.INFO)
        elseif choice == "Rose Pine" then
            vim.cmd("colorscheme rose-pine")
            vim.notify("Colorscheme: Rose Pine", vim.log.levels.INFO)
        elseif choice == "Rose Pine Moon" then
            vim.cmd("colorscheme rose-pine-moon")
            vim.notify("Colorscheme: Rose Pine Moon", vim.log.levels.INFO)
        elseif choice == "Rose Pine Dawn" then
            vim.cmd("colorscheme rose-pine-dawn")
            vim.notify("Colorscheme: Rose Pine Dawn (light)", vim.log.levels.INFO)
        end
    end)
end

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "sql", "mysql", "plsql" },
    callback = function()
        vim.keymap.set("n", "<leader>sq", pick_sql_highlight, {
            buffer = true,
            desc = "Pick SQL highlight / colorscheme",
        })
    end,
})

return {
    { "shmup/vim-sql-syntax", ft = { "sql", "mysql", "plsql" } },
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = { style = "night" },
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = true,
    },
}

return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "sqlfluff" })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    opts = function(_, opts)
      opts.linters_by_ft = opts.linters_by_ft or {}
      opts.linters_by_ft.sql = { "sqlfluff" }

      opts.linters = opts.linters or {}
      opts.linters.sqlfluff = {
        cmd = vim.fn.expand("~/.local/share/nvim/mason/bin/sqlfluff"),
        args = { "lint", "--format=json", "--dialect=ansi", "--rules=PRS", "-" },
      }
    end,
  },
}

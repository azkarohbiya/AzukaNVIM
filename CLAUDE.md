# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration built on [LazyVim](https://lazyvim.github.io/) with Lazy.nvim as the plugin manager. It is designed for a tmux-based workflow with a focus on SQL/database development and Python.

## Structure

- `init.lua` — Entry point; simply calls `require("config.lazy")`
- `lua/config/` — Core configuration: `lazy.lua` (plugin manager bootstrap), `keymaps.lua`, `options.lua`, `autocmds.lua`
- `lua/plugins/` — One file per plugin override/addition; Lazy.nvim auto-imports all files here
- `snippets/` — JSON snippet files for `python` and `sql`

## Adding / Modifying Plugins

Create or edit a file in `lua/plugins/`. Each file returns a Lua table of plugin specs:

```lua
return {
  {
    "author/plugin-name",
    opts = { ... },
    config = function() ... end,
  }
}
```

To override a LazyVim default plugin, use the same plugin name in a new spec — Lazy.nvim merges specs.

## Key Mappings

Leader key is `<Space>`. Notable custom mappings (see `lua/config/keymaps.lua`):

| Key | Action |
|-----|--------|
| `jk` | Escape (insert mode) |
| `<leader>ff/fs/fc/fb/fh` | Telescope: files/grep/cursor word/buffers/help |
| `<leader>sv/sh/se/sx` | Window split/equal/close |
| `<leader>vp` / `<leader>vl` | Vimux: prompt command / run last |
| `<leader>1` | Send visual selection to tmux pane |
| `<leader>2` | Send SQL selection to tmux (runs via `mybeeline`, auto-generates filename) |
| `<leader>3` | Send SQL selection to file in tmux pane 2 |
| `<leader>s` | Create/update SQL snippet from visual selection |
| `<leader>cw` | Erase trailing whitespace |
| `<leader>yy` | Copy entire file to system clipboard |
| `<C-h/j/k/l>` | Navigate between tmux panes and Neovim windows |

## Tmux Integration

Three custom Lua functions in `lua/plugins/vimux.lua` handle sending code to tmux:
- `SendSelectionToTmux()` — sends visual selection to the active pane
- `SendSelectionToTmuxBackground()` — sends SQL to pane 2, wraps with `mybeeline`, writes output to an auto-named file
- `SendSelectionToTmuxBackground3()` — sends SQL to a file in pane 2

## Dynamic SQL Snippets

`lua/plugins/snippets.lua` provides a visual-mode workflow (`<leader>s`) to interactively create or update entries in `snippets/sql.json`.

## Colorscheme & Transparency

Catppuccin (Macchiato flavor) with transparency enabled. All major UI surfaces (NormalFloat, statusline, bufferline, neo-tree, etc.) are set to transparent backgrounds in `lua/plugins/core.lua`.

## Lua Formatting

StyLua is configured via `stylua.toml`. Run it with:

```sh
stylua lua/
```

## Plugin Lock File

`lazy-lock.json` pins plugin versions. After adding plugins, commit both the plugin spec and the updated lock file.

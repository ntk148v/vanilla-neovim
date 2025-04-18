<div align="center">
  <h1>Vanilla Neovim</h1>
  <img src="https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-logo-300x87.png" alt="Neovim">
  <h3>Pure Neovim configuration without any extra plugins</h3>
</div>

Table of contents:

- [1. Introduction](#1-introduction)
- [2. Installation](#2-installation)
- [3. LSP](#3-lsp)
- [4. Keymap](#4-keymap)

## 1. Introduction

Welcome to my `vanilla` [Neovim](https://github.com/neovim/neovim) configuration. This is my attempt to create a functionality and minimal configuration without any extra plugins, which is inspired by [this talk](https://youtu.be/XA2WjJbmmoM).

> [!Important] > **Goals**:
>
> - Increase Neovim/Vim understanding.
> - Offer powerful options.
> - Challenge myself.
>
> **Not goals**:
>
> - Hate on plugins. On the contratry, I love them cause they make my Vim journey a lot easier. Checkout [my daily configuration](https://github.com/ntk148v/vanilla-neovim).

**Features**:

- Quickly comment/uncomment.
- Undo files.
- File browser.
- LSP!
- Blazing fast startup time (of course, it doesn't load any plugins :relieved:)

```shell
NVIM_APPNAME=nvim-vanilla vim-startuptime -vimpath nvim -count 100
Extra options: []
Measured: 100 times

Total Average: 16.576810 msec
Total Max:     50.683000 msec
Total Min:     8.702000 msec
```

## 2. Installation

- Requirements:
  - Install [neovim >= 0.11.0](https://github.com/neovim/neovim/wiki/Installing-Neovim#install-from-package), or you can [build it](https://github.com/neovim/neovim/wiki/Building-Neovim#) yourself.
- Backup your current neovim config, if necessary:

```shell
mv ~/.config/nvim ~/.config/nvim.bak
```

- Neovim's configurations are located under the following paths, depending on your OS:

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux, MacOS         | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%localappdata%\nvim\`                    |
| Windows (powershell) | `$env:LOCALAPPDATA\nvim\`                 |

- [Fork](https://docs.github.com/en/get-started/quickstart/fork-a-repo) this repo so that you have your own copy that you can modify, then install by cloning the fork to your machine using one of the commands below, depending on your OS.

> [!NOTE]
> Your fork's url will be something like this:
> `https://github.com/<your_github_username>/vanilla-neovim.git`

- Get your configuration:

> [!NOTE]
> If following the recommended step above (i.e., forking the repo), replace
> `ntk148v` with `<your_github_username>` in the commands below

<details><summary> Linux and Mac </summary>

```shell
git clone https://github.com/ntk148v/vanilla-neovim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim
```

</details>

<details><summary> Windows </summary>

If you're using `cmd.exe`:

```shell
git clone https://github.com/ntk148v/vanilla-neovim.git "%localappdata%\nvim"
```

If you're using `powershell.exe`

```shell
git clone https://github.com/ntk148v/vanilla-neovim.git "${env:LOCALAPPDATA}\nvim"
```

</details>

- Start Neovim, Lazy should be installed automatically, then it will install plugins.

```shell
nvim
```

- Restart Neovim and enjoy it. If you want to use LSP feature, it requires extra installation. Checkout [[3. LSP](#3-lsp)].
- Keep updated: You should keep updated using `git pull`.

## 3. LSP

Nvim supports the [Language Server Protocol (LSP)](https://microsoft.github.io/language-server-protocol/), which means it acts as a client to LSP servers and includes a Lua framework `vim.lsp` for building enhanced LSP tools.

LSP facilitates features like go-to-definition, find references, hover, completion, rename, format, refactor, etc., using semantic whole-project analysis (unlike [ctags](https://neovim.io/doc/user/tagsrch.html#ctags)).

Nvim provides an LSP client, but the servers are provided by third parties. Follow these steps to get LSP features:

1. Install language servers using your package manager or by following the upstream instructions: <https://microsoft.github.io/language-server-protocol/implementors/servers/>. I use these following language servers.

```shell
go install golang.org/x/tools/gopls@latest
npm install -g yaml-language-server
npm install -g pyright
npm install -g vscode-langservers-extracted
```

2. Restart Nvim, or use ":edit" to reload the buffer.

3. Check that LSP is active ("attached") for the buffer:

```
:checkhealth vim.lsp
```

Read more about LSP in the [official documentation](https://neovim.io/doc/user/lsp.html).

## 4. Keymap

> [!Note]
> Work in progress

Hmm, you can figure out with the `:map` command. There are also other variants.

- `:nmap` for normal mode mappings
- `:vmap` for visual mode mappings
- `:imap` for insert mode mappings

# Dotfiles

Portable baseline for macOS and Arch Linux, symlinked with [dotbot](https://github.com/anishathalye/dotbot).
Anything machine-specific lives outside this repo in untracked `*.local` files.

## New machine

Canonical checkout: `~/ghq/github.com/samclement/dotfiles`, so `ghq list`, `tv ghq-repos`
and `tvn` all see it.

```sh
ghq get --ssh samclement/dotfiles
cd "$(ghq root)/github.com/samclement/dotfiles"
./install     # symlink configs into $HOME (no network)
./bootstrap   # install packages + plugin managers (network)
./doctor      # read-only: report anything still missing
```

Then restart the shell. `./install` and `./bootstrap` are idempotent; run them in either
order, any number of times. Keep exactly **one** checkout: symlinks are absolute, so a
second clone turns `$HOME` into a mix of whichever ran `./install` last.

## What each script owns

| Script | Responsibility | Network |
| --- | --- | --- |
| `install` | dotbot: symlink tracked files into `$HOME` | only the dotbot submodule |
| `bootstrap` | OS packages, oh-my-zsh + custom plugins, tpm + tmux plugins, packer plugins | yes |
| `doctor` | Read-only gap report; exits non-zero if anything is missing | no |

Packages: [Brewfile](Brewfile) for macOS, [packages/arch.sh](packages/arch.sh) for Arch.
Both mirror the command list in [packages/tools.txt](packages/tools.txt), which is what
`doctor` checks. LSP servers are *not* installed by `bootstrap` — `mason.nvim` installs
`ts_ls`, `lua_ls` and `rust_analyzer` on first Neovim start (`nvim/after/plugin/lsp.lua`).

## Machine-local settings

Never edit the tracked files for one machine. Copy a template and edit the copy:

```sh
cp zsh/.zshrc.local.example        ~/.zshrc.local
cp git/.gitconfig.local.example    ~/.gitconfig.local
cp fish/local.fish.example         ~/.config/fish/local.fish
cp tmux/tmux.local.conf.example    ~/.config/tmux/tmux.local.conf
```

Each is sourced/included by the tracked config (git's include comes *last*, so a local
identity and signing key win) and each is gitignored. Put absolute paths, secrets
(`SOPS_AGE_KEY_FILE`) and per-host preferences there.

## Layout

| Path | Linked to |
| --- | --- |
| `zsh/.zshrc` | `~/.zshrc` (oh-my-zsh, aliases, path, television, zoxide) |
| `git/.gitconfig` | `~/.gitconfig` |
| `nvim/` | `~/.config/nvim` (packer, mason/lspconfig, telescope, treesitter) |
| `tmux/tmux.conf` | `~/.config/tmux/tmux.conf` (tmux 3.2+ XDG path) |
| `kitty/` | `~/.config/kitty` |
| `fish/` | `~/.config/fish/config.fish` + key bindings |
| `television/` | `~/.config/television` (channels, config) |
| `scripts/` | not linked; called by absolute path where needed |

## Notes

- tmux reads `~/.config/tmux/tmux.conf` on 3.2+. Older tmux ignores it silently.
- `install.conf.yaml` links relative to wherever you run it and stores absolute paths,
  so two clones of this repo produce a split `$HOME`. `relink: true` makes the last run
  win deterministically, but that only removes the ambiguity, not the mistake.

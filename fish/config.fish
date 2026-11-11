if status is-interactive
    # Commands to run in interactive sessions can go here
    set --universal nvm_default_version lts
    fish_add_path -m ~/go/bin
    fish_add_path /usr/local/go/bin
    alias k "kubectl"
    # pyenv is not installed everywhere; fail quietly instead of erroring.
    type -q pyenv; and pyenv init - | source
end

# X11-only key remap: needs both xmodmap and the script.
if type -q xmodmap; and test -x "$HOME/.local/scripts/keymap.sh"
    bash -c '$HOME/.local/scripts/keymap.sh'
end

# Machine-local settings. Not tracked. See fish/local.fish.example
if test -f "$HOME/.config/fish/local.fish"
    source "$HOME/.config/fish/local.fish"
end

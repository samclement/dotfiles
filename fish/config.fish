if status is-interactive
    # Commands to run in interactive sessions can go here
    set --universal nvm_default_version lts
    fish_add_path -m ~/go/bin
    fish_add_path /usr/local/go/bin
    alias k "kubectl"
    pyenv init - | source
end
if test -n "$DISPLAY"
    bash -c '$HOME/.local/scripts/keymap.sh'
end

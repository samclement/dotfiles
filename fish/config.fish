if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_add_path -g /opt/homebrew/bin /opt/homebrew/sbin /usr/local/bin /usr/bin /bin /usr/sbin /sbin
    set --universal nvm_default_version v18.13.0
end

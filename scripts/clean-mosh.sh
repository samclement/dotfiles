ps h --sort start_time -o pid,command -C mosh-server |
        grep "$i" |
        head --lines=-1 |
        awk '{print $1}' |
        xargs --no-run-if-empty -n 1 --verbose kill


function upwards-dirs
    set -f dir "$(pwd)"
    while test "$dir" != "/"
        echo "$dir"
        set -f dir "$(dirname "$dir")"
    end
    echo /
end

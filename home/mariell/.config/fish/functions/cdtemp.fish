function cdtemp
    set -l dir (mktemp -d)
    echo "-> temp directory: $dir"
    cd "$dir"
end

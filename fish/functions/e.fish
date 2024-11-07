function e
    set dir "/tmp/$USER"
    set file "$dir/joshuto-cwd"

    if not test -d "$dir"
        command mkdir -p "$dir"
    end
    command env joshuto --output-file "$file" $argv
    switch $status
        case 101
            z (cat "$file")
    end
end

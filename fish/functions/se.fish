function se 
    set dir "/tmp/root"
    set file "$dir/joshuto-cwd"
    if not test -d "$dir"
        command mkdir -p "$dir"
    end
    command env sudo joshuto --output-file "$file" $argv
    switch $status
        case 101
            z (cat "$file")
    end
end

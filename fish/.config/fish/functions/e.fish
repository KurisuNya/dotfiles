function e
    set dir "/tmp/$USER"
    set file "$dir/joshuto-cwd"

    function cd_cmd
        type -q z
        and z $argv
        or cd $argv
    end

    if not test -d "$dir"
        command mkdir -p "$dir"
    end
    command env joshuto --output-file "$file" $argv
    switch $status
        case 101
            cd_cmd (cat "$file")
    end
end

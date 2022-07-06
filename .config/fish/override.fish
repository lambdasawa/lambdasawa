function cd
    set d "$argv"
    if [ -z "$argv" ]
        set d (fd --type d | filter)
    end

    builtin cd "$d"
    list || ls
end

function rm
    if command -v rip >/dev/null 2>&1
        rip $argv
    else
        command rm "$argv"
    end
end

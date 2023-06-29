function fish_greeting
end

function md
    mkdir -p "$argv"
    cd "$argv"
end

function tmp
    set t $(now)
    mkdir -p "$HOME/tmp/$t/$argv"
    cd "$HOME/tmp/$t/$argv"
    tmux-open .
end

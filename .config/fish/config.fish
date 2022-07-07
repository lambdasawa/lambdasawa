if [ -e /opt/homebrew/bin/brew ]
    eval (/opt/homebrew/bin/brew shellenv)
end

if [ -z "$ASDF_DIR" ]
    if [ -e (brew --prefix asdf)/libexec/asdf.fish ]
        . (brew --prefix asdf)/libexec/asdf.fish
    end
    if [ -e ~/.asdf/asdf.fish ]
        . ~/.asdf/asdf.fish
    end
end

if command -v starship >/dev/null 2>&1
    starship init fish | source
end

if command -v direnv >/dev/null 2>&1
    direnv hook fish | source
end

if command -v zoxide >/dev/null 2>&1
    zoxide init fish | source
end

source ~/.config/fish/var.fish
source ~/.config/fish/function.fish
source ~/.config/fish/hook.fish
source ~/.config/fish/override.fish
source ~/.config/fish/alias.fish

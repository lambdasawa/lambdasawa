set -gx PATH "$PATH:$HOME/.local/bin:$HOME/bin:$HOME/.cargo/bin/"

if which code >/dev/null 2>&1
    set -gx EDITOR "code --wait"
else if which vim >/dev/null 2>&1
    set -gx EDITOR vim
end

set -gx SKIM_DEFAULT_COMMAND 'fd --type f || git ls-tree -r --name-only HEAD || rg --files || find .'

set -gx BAT_THEME 'Monokai Extended'

if [ -e /opt/homebrew/share/git-core/contrib/diff-highlight/ ]
    set -gx PATH "$PATH:/opt/homebrew/share/git-core/contrib/diff-highlight/"
end

if [ -e /usr/libexec/java_home ]
    set java_home (/usr/libexec/java_home -v 1.8.0 >/dev/null 2>&1)
    set -gx JAVA_HOME $java_home
end
if [ -e ~/Library/Android/sdk ]
    set -gx ANDROID_HOME ~/Library/Android/sdk
end
if [ -e $ANDROID_HOME/emulator ]
    set -gx PATH "$PATH:$ANDROID_HOME/emulator"
end
if [ -e $ANDROID_HOME/tools ]
    set -gx PATH "$PATH:$ANDROID_HOME/tools"
end
if [ -e $ANDROID_HOME/tools/bin ]
    set -gx PATH "$PATH:$ANDROID_HOME/tools/bin"
end
if [ -e $ANDROID_HOME/platform-tools ]
    set -gx PATH "$PATH:$ANDROID_HOME/platform-tools"
end

set jetbrains_scripts_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
if [ -e "$jetbrains_scripts_path" ]
    set -gx PATH "$PATH:$jetbrains_scripts_path"
end

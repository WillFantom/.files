# CDF: Set wd to that of the frontmost finder window
function cdf() {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

# SexyMan: Open man pages in preview
function sexyman() {
    man -t $@ | open -f -a "Preview"
}

# Install Iterm Scheme: Install an iterm2 colour scheme
function install-iterm-scheme() {
    git clone https://github.com/mbadolato/iTerm2-Color-Schemes.git /tmp/iterm2_schemes
    wd=$(pwd)
    cd /tmp/iterm2_schemes/schemes
    

}


# Installing Emacs on Mac OS X

Via homebrew:

    brew update
    brew install emacs
    # if having problems linking try these commands or something like them
    brew link emacs
    sudo chown -R td23:admin /usr/local/share/emacs

Via EmacsForMacOSX, download the dmg file from http://emacsformacosx.com/builds.  Then add the following aliases to `~/.bashrc`:

    alias ec='/Applications/Emacs.app/Contents/MacOS/bin/emacsclient'
    alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

Also consider starting the Emacs Server Daemon when running emacs, by adding to your `~/.emacs` file:

    ;;========================================
    ;; start the emacsserver that listens to emacsclient
    (server-start)

And consider using `emacsclient` as your EDITOR by adding to `~/.bashrc`:

    export EDITOR=ec


# Emacs Tips, Cheatsheets, and Keyboard Shortcuts

A list of keystrokes and the corresponding commands:

- http://www.cs.rutgers.edu/LCSR-Computing/some-docs/emacs-chart.html


# The Emacs Server and Daemon

Pages about running Emacs as a Server Daemon:

- http://www.emacswiki.org/emacs/EmacsAsDaemon
- http://www.gnu.org/software/emacs/manual/html_node/emacs/Emacs-Server.html
- http://stackoverflow.com/questions/10171280/how-to-launch-gui-emacs-from-command-line-in-osx



Kill the current emacs daemon:

    ec -e '(kill-emacs)'

Add this to your `.emacs` to start the emacs server daemon when you start emacs:

    ;;========================================
    ;; start the emacsserver that listens to emacsclient
    (server-start)




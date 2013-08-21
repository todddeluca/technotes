[todo] use tmux to avoid having jobs fail when my ssh connection is lost on the server.
[done] `sudo aptitude insall tmux`.  Then `tmux`, `^b d`, `tmux attach`.

http://monda.hu/2013/01/26/how-to-rule-remote-shell-sessions-with-tmux-and-mosh/

http://www.dayid.org/os/notes/tm.html

http://robots.thoughtbot.com/post/2641409235/a-tmux-crash-course

start a new session: `tmux`
reattach a detached session: `tmux attach`
detach the currently attached session: `^b d`
list sessions: `^b s` or `tmux ls`

http://superuser.com/questions/209437/how-do-i-scroll-in-tmux
See .tmux.conf in my dotfiles project.


Tmux guide:
http://robots.thoughtbot.com/post/2641409235/a-tmux-crash-course


Installing tmux from source as non-root user:
http://www.linuxquestions.org/questions/linux-software-2/installing-tmux-from-source-as-non-root-user-857098/

    SUMMARY:

    For anyone else who wants to install tmux to their home folder (as non root) here is what you need to do.

    1) Download libevent and ncurses.
    2) Compile them to $HOME/local
    3) Install tmux by the following:

    cd tmux
    ./configure
    CPPFLAGS="-I$HOME/local/include" LDFLAGS="-static -L$HOME/local/include -L$HOME/local/include/ncurses -L$HOME/local/lib" make
    make install

    4)./tmux


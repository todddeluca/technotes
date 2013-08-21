
A little bit on splitting windows
http://technotales.wordpress.com/2010/04/29/vim-splits-a-guide-to-doing-exactly-what-you-want/


# "TAB" COMPLETION

http://robots.thoughtbot.com/post/27041742805/vim-you-complete-me


    function! CleverTab()
      if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$' 
        return "\<tab>" 
      else 
        return "\<c-n>"
    endfunction
    inoremap <tab> <c-r>=CleverTab()<cr></cr></c-r></tab></c-n></tab>

I use `<c-space>(^X^O)` and `<s-space>(^X^L)` to acomplish that. It is also similar to some IDE like Eclipse. `</s-space></c-space>`

SuperTab:  https://github.com/ervandew/supertab/


# CHEATSHEETS

http://bullium.com/support/vim.html
good command list


# SCRIPTING

http://learnvimscriptthehardway.stevelosh.com/


# TEXT OBJECTS

http://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/
describes basic text objects and some vimscript extensions


# NEWBIE GUIDES, TIPS, ETC.

http://stevelosh.com/blog/2010/09/coming-home-to-vim/?
http://news.ycombinator.com/item?id=4218575

best of vim tips
http://rayninfo.co.uk/vimtips.html

http://mislav.uniqpath.com/2011/12/vim-revisited/
mentions jump-motions.  :help jump-motions
disses Janus as being cluttered with plugins and opinionated about
mappings


http://stackoverflow.com/questions/1218390/what-is-your-most-productive-shortcut-with-vim
The famous grok vim response.
Discusses text objects, moving around, 
marks and registers, 
The colon commands: :... g, :... v,
The bang commands, !, :r!, and :... !, used to execute external commands
and read the results into the file.

http://www.derekwyatt.org/vim/vim-tutorial-videos/
tutorial videos

http://vimcasts.org/
tutorial screencasts

# HELP

What keystrokes are mapped?
    :verbose map

Help on what a keystroke does
    :help SOME-KEYSTROKE

How to find out the mapping of a control keystroke.  Use ^Q to insert the key.
    :help <c-q> <c-d>


# MOVING

Commands useful for getting back so somewhere you once were:
 - CTRL-O and CTRL-I move back and forth in the jumplist.
 - g; and g, move back and forth in the changelist. 


# INDENTING

http://stackoverflow.com/questions/235839/how-do-i-indent-multiple-lines-quickly-in-vi
>>   Indent line by shiftwidth spaces
<<   De-indent line by shiftwidth spaces
5>>  Indent 5 lines
5==  Re-indent 5 lines

>%   Increase indent of a braced or bracketed block (place cursor on brace first)
=%   Reindent a braced or bracketed block (cursor on brace)
<%   Decrease indent of a braced or bracketed block (cursor on brace)
]p   Paste text, aligning indentation with surroundings

=i{  Re-indent the 'inner block', i.e. the contents of the block
=a{  Re-indent 'a block', i.e. block and containing braces
=2a{ Re-indent '2 blocks', i.e. this block and containing block

>i{  Increase inner block indent
<i{  Decrease inner block indent


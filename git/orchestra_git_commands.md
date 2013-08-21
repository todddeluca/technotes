## MOVE CHANGES TO ORCHESTRA WORKING COPY, WHEN TESTING/RUNNING CODE ON ORCHESTRA

Rsync to the orchestra working copy, using .rsync-filter file to not copy
.git/, *~, etc.  This is good b/c I do not want to commit every little change I
want to test, which is what I was doing by committing and pushing.  Use
--dry-run to try it out.

    rsync -avzF ~/work/roundup orchestra.med.harvard.edu:work


## MERGE FROM DEV TO PROD

Do this after committing dev/master branch and testing extensively on dev/staging servers.

    git checkout prod
    git merge --no-ff master
    # tag latest version of production release so it is easy to get back to if we need to roll back.
    git tag -a 2.0


## PUSH REPO CHANGES TO ORCHESTRA REPO

http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#pushing-changes-to-a-public-repository

    git push ssh://td23@orchestra.med.harvard.edu/groups/cbi/git/roundup.git master


## FETCH AND MERGE COMMITS FROM AN ORCHESTRA REPO.

First commit (or stash) changes in working copy.  

    git commit -a
    git pull ssh://td23@orchestra.med.harvard.edu/groups/cbi/git/roundup.git master



# RANDOM ODDS AND ENDS

Stage/add all changes and new files, commit them, and push git to orchestra working copy and move working copy to the push

    git add . && git commit -a -m 'more uniprot code added' && git push ssh://td23@orchestra.med.harvard.edu/home/td23/work/roundup master
    git reset --hard



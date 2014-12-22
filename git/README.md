This directory contains documentation related to using git.


## TUTORIALS, CHEATSHEETS, ETC.

A list of tutorials, including some visual ones.

- http://sixrevisions.com/resources/git-tutorials-beginners/

A description of a branching model similar to what we use for production,
development, and feature branches.  The difference is that we have a prod
branch and use master as the develop branch.

- http://nvie.com/posts/a-successful-git-branching-model/

The "flow" used by github:

- http://scottchacon.com/2011/08/31/github-flow.html

Recommended by Tom Monaghan.

- http://gweezlebur.com/2009/01/19/my-git-workflow.html

More

- http://eagain.net/articles/git-for-computer-scientists/
- http://reinh.com/blog/2008/08/27/hack-and-and-ship.html
- http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html
- http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html

Using git for deployment

- http://pixelhum.com/blog/using-git-for-deployment
- http://joemaller.com/990/a-web-focused-git-workflow/

Cheatsheet with some useful config aliases:

- http://cheat.errtheblog.com/s/git/


## MERGING AND REBASING

There is some controversy as to whether one should merge or rebase.  Some discussion:

- http://news.ycombinator.com/item?id=4107469
- http://www.randyfay.com/node/91
- Why Git Pull is Considered Harmful: http://stackoverflow.com/questions/15316601/why-is-git-pull-considered-harmful
- Why it is not: https://news.ycombinator.com/item?id=7385087

Nice tool for merging conflicts:

    git mergetool

Rebasing master branch on a remote master branch.  Let's say you make a few commits to master.  Meanwhile, a few pull requests come in, which you merge into the remote master.  Now you want to rebase your local commits onto the new upstream head.  Fetch the remote master changes, then rebase the local master onto the remote one:

    git fetch origin            # Updates origin/master
    git rebase origin/master    # Rebases current branch onto origin/master

Or in a single step:

    git pull --rebase origin master

Source: http://stackoverflow.com/questions/7929369/how-to-rebase-local-branch-with-remote-master


### RESOLVE / FIX A MERGE CONFLICT

If you have a conflict in file.txt
Edit the file to make it look the way you want, removing conflict markers.
See git user manual: http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#resolving-a-merge
Example conflict marker:

    <<<<<<< HEAD:file.txt
    Hello world
    =======
    Goodbye
    >>>>>>> 77976da35a11db4580b80ae27e8d65caf5208086:file.txt

Then commit the changes:

    git add file.txt
    git commit


### MERGE A GITHUB PULL REQUEST

(Citation: this is copied directly from github.com.)

Step 1: Check out a new branch to test the changes - run this from your project
directory:

    git checkout -b gavrie-master master

Step 2: Bring in gavrie's changes and test:

    git pull git://github.com/gavrie/daemoncmd.git master

Step 3: Merge the changes and update the server:

    git checkout master
    git merge gavrie-master
    git push origin master


## CLONING

The RIGHT way to clone from github, b/c it can do keyfile authentication.

    git clone git@github.com:todddeluca/boto.git

The wrong way to clone from github for key pair authentication:

    git clone https://github.com/todddeluca/boto


## REMOTES

Remove a (bad) remote:

    git remote rm origin

Add a (good) remote using ssh, which works with key-pair authentication (yay!):

    git remote add origin git@github.com:todddeluca/boto.git

Add a remote using https, which gets around firewalls but asks for passwords (boo):

    git remote add origin https://github.com/walllab/genomics2009workflow.git

For more information see:

- https://help.github.com/articles/why-is-git-always-asking-for-my-password

Delete all stale remote-tracking branches under origin. These stale branches
have already been removed from the remote repository referenced by origin, but
are still locally available in "remotes/origin":

    git remote prune origin



## PUSHING

Push changes to a remote
The default is origin
Specify the branch (refspec) to push a specific branch which can be useful
to create a new branch in the remote
For example, push a feature branch to origin, creating an identically named
branch there.

    git push origin accept_unicode_instance_id

Push repo changes to repo using a url
Http://www.kernel.org/pub/software/scm/git/docs/user-manual.html#pushing-changes-to-a-public-repository

    git push ssh://td23@orchestra.med.harvard.edu/groups/cbi/git/roundup.git master

Push a new branch to a remote repository (creating new remote branch):

    git push origin ${branch}


Create a new branch in a remote repository from an existing local branch, and
set up the local branch to track the remote branch:

    git push --set-upstream origin $BRANCH


## DELETING BRANCHES

Check if branch `myfeature` contains any commits that have not been merged into `master`:

    $ git log master..myfeature

Alternatively, check if the commits on branch `branch-to-delete` are contained in any other branches:

    $ git branch --contains branch-to-delete

Delete a remote branch from origin:

    git push origin :branchname

Delete a local branch:

    git branch -d branchname


## CREATE A REPOSITORY

### create a new (bare) remote repository for a project.
Bare repos are used as remotes for pushing/pulling.
See also https://gist.github.com/569530

    ssh me@my.remote.host.com
    cd /path/to/repos/
    git init --bare --shared foo.git
    # chgrp -R dev foo.git # Is this necessary?


### Create a repository from existing codebase

    cd /path/to/code

Create .gitignore file, or use an existing one from another project

    emacs .gitignore

Make a new git repo.  the --dry-run is to check for files, like java class files that should be added to .gitignore or tmp dirs

    git init
    git add -v --dry-run .
    git add .
    git commit -a


### Create a repository from an existing remote repo

    git clone ssh://td23@orchestra.med.harvard.edu/groups/cbi/git/roundup.git ~/work/roundup


### Create a github repository for an existing local repository

If you do not already have a local repository, create one:

    git init

Create a repository on github and add remote origin pointing to it in one step:

    hub create -d 'Repository description goes here'

Or create the repository manually on github, add it as a remote and push to it
while setting upstream tracking:

    git add README.md
    git commit -m "first commit"
    git remote add origin git@github.com:todddeluca/dones.git
    git push -u origin master

If you have an existing origin, you will have to rename it and add a github origin:

    git remote rename origin orchestra
    git remote add origin git@github.com:walllab/genotator.git

Push the master branch to origin and set its upstream to track the origin branch

    git push -u origin master

Or push all the branches to origin and set upstream tracking

    git push --all -u origin



### Make a remote repo from existing local repo

    http://toroid.org/ams/git-central-repo-howto

Create bare remote repo, if necessary

    ssh td23@orchestra.med.harvard.edu
    mkdir /home/td23/foo.git
    td23@mezzanine:~$ cd /home/td23/foo.git/
    git init --bare --shared

Optional step for testing: mock-up an existing local repo with a few commits.

    git init bar.git
    cd bar.git/
    echo 'testing' > README.txt
    git add README.txt
    git commit -a -m 'new repo'
    echo 'a change' >> README.txt
    git commit -a -m 'changes'

Make local repo origin point to remote repo

    git remote
    git remote add origin ssh://td23@orchestra.med.harvard.edu/home/td23/foo.git
    td23@todd-mac:~/work/bar.git$ git remote -v
    origin	ssh://td23@orchestra.med.harvard.edu/home/td23/foo.git (fetch)
    origin	ssh://td23@orchestra.med.harvard.edu/home/td23/foo.git (push)

Push local repo objects to remote and have all branches track remote repo

    td23@todd-mac:~/work/bar.git$ git push --all -u
    Counting objects: 6, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (6/6), 442 bytes, done.
    Total 6 (delta 0), reused 0 (delta 0)
    To ssh://td23@orchestra.med.harvard.edu/home/td23/foo.git
    * [new branch]      master -> master
    Branch master set up to track remote branch master from origin.

Does it work? it works

    td23@todd-mac:~/work/bar.git$ git pull
    Already up-to-date.



## BRANCHING

http://www.zorched.net/2008/04/14/start-a-new-branch-on-your-remote-git-repository/
http://stackoverflow.com/questions/520650/how-do-you-make-an-existing-git-branch-track-a-remote-branch
http://stackoverflow.com/questions/1519006/git-how-to-create-remote-branch
http://git-scm.com/book/en/Git-Branching-Remote-Branches

Create a local branch

    git checkout -b ${branch}

Create new branch locally and then create a new remote branch and have the local branch track the remote branch.

    git checkout -b ${branch} # create local branch
    git push -u origin ${branch} # push branch to remote and configure remote tracking
    # alternative push
    git push -u origin ${branch}:${branch} # could push to a differently named remote branch I think

Alternative way to push, which should make all local branches track remote branches on origin, creating remote branches as necessary?

    git push --all -u

Create a new local branch which tracks an existing remote branch.

    git branch --track ${branch} origin/${branch}
    # or
    git fetch origin ${branch}
    git checkout ${branch}

From an existing local branch, create a new remote branch and track it:

    git push --set-upstream origin $BRANCH

Make an existing local branch track an existing remote branch

    git branch --set-upstream ${branch} origin/${branch}

Look at all your branches

    git branch ; git branch -r ; git branch -v -v

Deleting a branch from origin remote repository

    git push origin :heads/${branch}

Deleting a branch from local repository

    git checkout master && git branch -d ${branch}

Deleting a branch from origin remote

    git push origin :${branch}

Script for creating a new branch on remote and local and having local branch track remote branch

    $ cat ~/bin/git-create-branch
    ...
    git checkout -b ${branch}
    git push -u origin ${branch}:${branch}

Usage:

    git-create-branch ${branch}


### MAKE a branch the new master branch

http://stackoverflow.com/questions/2763006/change-the-current-branch-to-master-in-git

Imagine you are in the following scenario: you branch a feature branch and then
make some commits to the master branch and the feature branch.  Then you decide
that the feature branch should be the master branch and the master branch
should be ... forgotten.  This happened to me when the feature branch was a
"v1" branch and the master branch was the v2 branch and then we ended up
sticking with v1 and forgetting about v2.  Here is what you should do, if you
have already pushed the changes to a remote repo.  If all the changes are still
local, you have more liberty in how you rewrite history:

    git checkout better_branch
    git merge --strategy=ours --no-commit master    # keep the content of this branch, but record a merge
    git commit # add a commit message
    git checkout master
    git merge better_branch             # fast-forward master up to the merge


## SQUASH COMMITS

Squashing commits merges several commits into a single commit, making the commit log and commits tree simpler and more understandable.  
http://reinh.com/blog/2009/03/02/a-git-workflow-for-agile-teams.html.
http://book.git-scm.com/4_interactive_rebasing.html

See what the last commit from origin/master.  This gives a sense of where the interactive rebase will start from.

    git log origin/master

Rebase the current branch interactively, starting from the last time we pushed to or merged from origin/master

    git rebase -i origin/master

Git will display an editor window with a list of the commits to be modified, something like:

    pick 3dcd585 Adding Comment model, migrations, spec
    pick 9f5c362 Adding Comment controller, helper, spec
    pick dcd4813 Adding Comment relationship with Post
    pick 977a754 Comment belongs to a User
    pick 9ea48e3 Comment form on Post show page

Now we tell git what we to do. Change these lines to:

    pick 3dcd585 Adding Comment model, migrations, spec
    squash 9f5c362 Adding Comment controller, helper, spec
    squash dcd4813 Adding Comment relationship with Post
    squash 977a754 Comment belongs to a User
    squash 9ea48e3 Comment form on Post show page

Save and close the file. This will squash these commits together into one commit and present us with a new editor window where we can give the new commit a message. We�ll use the story id and title for the subject and list the original commit messages in the body:

    [#3275] User Can Add A Comment To a Post
    * Adding Comment model, migrations, spec
    * Adding Comment controller, helper, spec
    * Adding Comment relationship with Post
    * Comment belongs to a User
    * Comment form on Post show page



## REVERT A FILE

http://norbauer.com/notebooks/code/notes/git-revert-reset-a-single-file
http://stackoverflow.com/questions/215718/reset-or-revert-a-specific-file-to-a-specific-revision-using-git

If you want to throw out the changes in the working copy of a file and revert (in the language of subversion/svn) to the version in the index do this:

    git checkout -- <filename>

The `--` is there to avoid accidentally checking out a branch in case the branch and file have the same name.  If not, you  can do this:

    git checkout <filename>

Revert/reset a file to a previous commit:

    git checkout <commit-hash> <filename>

## EXPORT A REPOSITORY


http://stackoverflow.com/questions/160608/how-to-do-a-git-export-like-svn-export

Hmm, there is not much consensus on this.  For a remote repository one fairly
clean way is to clone and then remove the .git dir.

    git clone $REPO_URL/$REPO_NAME.git
    rm -rf $REPO_NAME/.git



## GITHUB

### KEEPING GITHUB FORKS IN SYNC


http://stackoverflow.com/questions/1123344/merging-between-forks-in-github

Set up a remote for the repo you forked.

If you forked your github repo from "fromhere"

    git remote add walllab git@github.com:walllab/autworks.git

Pull from the original repo

    git pull ancestor master

Push to your repo

    git push origin master


## Add an empty directory to a repository

http://stackoverflow.com/questions/115983/how-do-i-add-an-empty-directory-to-a-git-repository

One way to add an "empty" directory to a git repository is to add a .gitignore
file to it.  This is useful if you have a secrets directory which you want to
exist when someone clones the repo, but you do not want your secrets in the
repo.

To make a directory stay empty (in the repo), create a .gitignore file inside
that directory that ignores everything except itself:

    # Ignore everything in this directory
    *
    # Except this file
    !.gitignore



## SUBMODULES


### Good submodule tutorials

http://chrisjean.com/2009/04/20/git-submodules-adding-using-removing-and-updating/
https://git.wiki.kernel.org/index.php/GitSubmoduleTutorial


### Update a submodule

    cd /path/to/repo/submodule
    git checkout master
    git pull
    cd /path/to/repo
    git commit -a -m 'updated submodule'


### Update all submodules

    cd /path/to/repo
    git submodule foreach git checkout master
    git submodle foreach git pull
    git commit -a -m 'updated submodules'


### Remove a submodule

Unfortunately there is no simple way to remove a submodule.

Go to the repo root:

    cd /path/to/repo

Remove the submodule entry from .gitmodules:

    vim .gitmodules

The entry will look something like this:

    grep -A2 'submodule "bundle/python.vim' .gitmodules
    [submodule "bundle/python.vim"]
      path = bundle/python.vim
      url = https://github.com/gg/python.vim.git

Remove the submodule entry from .gitconfig:

    vim .git/config

The entry will look something like this:

    grep -A1 '\[submodule "bundle/python.vim"\]' .git/config
    [submodule "bundle/python.vim"]
      url = https://github.com/gg/python.vim.git

Remove the submodule files/dir.  Note: do NOT add a trailing slash.

    git rm --cached bundle/python.vim


## NVIE FLOW MODEL

This article makes clear how to branch and merge, including managing releases,
production, development, and individual features. It includes a pretty picture
and commands for branching and merging.

http://nvie.com/posts/a-successful-git-branching-model/

Creating a feature branch
When starting work on a new feature, branch off from the develop branch.

    $ git checkout -b myfeature develop
    Switched to a new branch "myfeature"

Incorporating a finished feature on develop
Finished features may be merged into the develop branch definitely add them to
the upcoming release:

    $ git checkout develop
    Switched to branch 'develop'
    $ git merge --no-ff myfeature
    Updating ea1b82a..05e9557
    (Summary of changes)
    $ git branch -d myfeature
    Deleted branch myfeature (was 05e9557).
    $ git push origin develop

Creating a release branch
Release branches are created from the develop branch. For example, say version
1.1.5 is the current production release and we have a big release coming up.
The state of develop is ready for the “next release” and we
have decided that this will become version 1.2 (rather than 1.1.6 or 2.0). So
we branch off and give the release branch a name reflecting the new version
number:

    $ git checkout -b release-1.2 develop
    Switched to a new branch "release-1.2"
    $ ./bump-version.sh 1.2
    Files modified successfully, version bumped to 1.2.
    $ git commit -a -m "Bumped version number to 1.2"
    [release-1.2 74d9424] Bumped version number to 1.2
    1 files changed, 1 insertions(+), 1 deletions(-)

Finishing a release branch
When the state of the release branch is ready to become a real release, some
actions need to be carried out. First, the release branch is merged into master
(since every commit on master is a new release by definition, remember). Next,
that commit on master must be tagged for easy future reference to this
historical version. Finally, the changes made on the release branch need to be
merged back into develop, so that future releases also contain these bug fixes.

The first two steps in Git:

    $ git checkout master
    Switched to branch 'master'
    $ git merge --no-ff release-1.2
    Merge made by recursive.
    (Summary of changes)
    $ git tag -a 1.2

The release is now done, and tagged for future reference.
Edit: You might as well want to use the -s or -u <key> flags to sign your tag
cryptographically.

To keep the changes made in the release branch, we need to merge those back
into develop, though. In Git:

    $ git checkout develop
    Switched to branch 'develop'
    $ git merge --no-ff release-1.2
    Merge made by recursive.
    (Summary of changes)

This step may well lead to a merge conflict (probably even, since we have
changed the version number). If so, fix it and commit.

Now we are really done and the release branch may be removed, since we
do not need it anymore:

    $ git branch -d release-1.2
    Deleted branch release-1.2 (was ff452fe).


## GITHUB FLOW MODEL

See http://scottchacon.com/2011/08/31/github-flow.html.

So, what is GitHub Flow?

- Anything in the master branch is deployable
- To work on something new, create a descriptively named branch off of master (ie: new-oauth2-scopes)
- Commit to that branch locally and regularly push your work to the same named branch on the server
- When you need feedback or help, or you think the branch is ready for merging, open a pull request
- After someone else has reviewed and signed off on the feature, you can merge it into master
- Once it is merged and pushed to master, you can and should deploy immediately



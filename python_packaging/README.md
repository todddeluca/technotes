

There are several ways to package and distribute projects:

- distutils, the original way.
- setuptools, improves upon distutils.
- distribute, improves upon setuptools.

All of these methods use a 'setup.py' script for building packages, running
tests, and for registering and uploading packages to pypi.python.org.

There is a new way of configuring packages called `distutils2` in Python2.7 and
`packaging` in Python3.3 which is not yet ready (as of Summer 2012) for
primetime in my opinion because `pip` does not support it.

An old way to install packages is to download and unpack a tarball and then use
setup.py (which uses distutils, setuptools, or distribute) to install the
package.  Setuptools introduced easy_install, which helps to automate the 
process of downloading, unpacking, building, testing, and installing a package.
However the best way to install packages (in my opinion) is to use `pip`.

So there are layers of competing technologies out there.  Currently my simple
answer is as follows:

- Use `pip` to install packages.
- Use `virtualenv` to create isolated environments in which to install
  packages, so projects avoid having incompatible version problems.
- Use `distribute` with `setup.py` when creating your own packages.

Guides for python packaging:

- http://guide.python-distribute.org/
- http://docs.python.org/dev/packaging/tutorial.html
- http://packages.python.org/Distutils2/

The notes below are divided into Packaging, Distribution, and Installation
sections.


# Installation

## Installing Packages Directly From GitHub Using Pip

According to pip-1.2.1, the format for a VCS url is '<vcs>+<protocol>://<url>'.
For git, <vcs> = 'git'.  The <protocol> can be 'git', 'http', 'https', or
'ssh'.  Use 'ssh' to access a private repository with a ssh keypair.  When
using 'ssh', you must specify a username, which is 'git' for github.com.
Examples of the format of <url> are below.  The url can contain an optional
branch, tag, or revision and an optional egg name.  I'm not sure what
the egg name does.  I did test using the wrong egg name (e.g. 'diabrib' instead
of 'diabric') and the installation failed.  The page
http://www.pip-installer.org/en/latest/requirements.html has this to say on the
matter:  "... you have to include #egg=Package so pip knows what to expect at
that URL."  And if you specify the egg name, you can uninstall packages with
their urls.  See the example below.

### Informative Pages

- http://www.pip-installer.org/en/latest/requirements.html
- http://www.pip-installer.org/en/latest/requirements.html#git
- http://stackoverflow.com/questions/5008162/install-non-editable-tag-branch-from-git-repo-with-pip?rq=1
- http://stackoverflow.com/questions/4830856/is-it-possible-to-use-pip-to-install-a-package-from-a-private-github-repository?rq=1

### Examples

Installing from a private github repo.  Use "git+ssh" proto and set the username:

    pip install git+ssh://git@github.com/echweb/echweb-utils.git

Install a specific tagged version from a github repository:

    pip install git+git://github.com/django/django.git@1.2.5#egg=django

Install a specific revision from a github repository:

    pip install git+git://github.com/todddeluca/daemoncmd.git@5797c871fe29efb01224abf0f0ef9933d98ebde4

Install the master branch (or is it HEAD?) from a github repository:

    pip install git+git://github.com/todddeluca/reciprocal_smallest_distance.git

Using a requirements file to install a specific (non-editable) revision from a
git repository can be done by adding a line in the form,
`git://github.com/<user>/<repo>.git@<revision>#egg=<package_name>`.  For
example:

    git+https://github.com/todddeluca/diabric.git@e2bf05cc39c7fc80d02c38493cc8fac60f4f22e0#egg=diabric

Testing getting a specified revision via requirements.txt:

    cd ~/tmp
    virtualenv venv
    echo 'git+https://github.com/todddeluca/diabric.git@e2bf05cc39c7fc80d02c38493cc8fac60f4f22e0#egg=diabric' > requirements.txt
    venv/bin/pip install -r requirements.txt
    venv/bin/python -c 'import diabric, pkg_resources; print pkg_resources.require("diabric")[0].version'

Uninstalling using a github URL requires specifying the egg naeme.  For example:

    $ venv/bin/pip uninstall git+https://github.com/todddeluca/daemoncmd.git
    $ venv/bin/python -c 'import daemoncmd'
    $ venv/bin/pip uninstall git+https://github.com/todddeluca/daemoncmd.git#egg=daemoncmd
    Uninstalling daemoncmd:
      /Users/td23/tmp/venv/bin/daemoncmd
      /Users/td23/tmp/venv/lib/python2.7/site-packages/daemoncmd-0.1.1-py2.7.egg-info
      /Users/td23/tmp/venv/lib/python2.7/site-packages/daemoncmd.py
      /Users/td23/tmp/venv/lib/python2.7/site-packages/daemoncmd.pyc
    Proceed (y/n)? y   
      Successfully uninstalled daemoncmd
    $ venv/bin/python -c 'import daemoncmd'
    Traceback (most recent call last):
      File "<string>", line 1, in <module>
    ImportError: No module named daemoncmd


# Distribution

## Using PyPI, the Python Packaging Index, to Distribute Packages

The Python Package Index is a repository of software for the Python programming
language.  It is like CPAN for perl or CRAN for R.  Anyone can register their
package (assuming the name is available), upload metadata and documentation
about the package, and upload or link to a tarball to distribute the package.

After you have created a `setup.py` file, creating a source distribution
(tarball), registering it with pypi, and uploading it to pypi is easy:

    python setup.py sdist register upload

Instead of uploading a tarball to PyPI, you can specify a 'Download URL' in the package metadata.  Tools like `pip` can then scan this URL for links to tarballs generated by:

    python setup.py sdist
    
For example, the Download URL for a project on github could be `https://github.com/todddeluca/reciprocal_smallest_distance/downloads`.  That page contains links like:

- https://github.com/downloads/todddeluca/reciprocal_smallest_distance/reciprocal_smallest_distance-1.1.1.tar.gz
- https://github.com/downloads/todddeluca/reciprocal_smallest_distance/reciprocal_smallest_distance-1.1.tar.gz
- https://github.com/downloads/todddeluca/reciprocal_smallest_distance/reciprocal_smallest_distance-1.0.tar.gz

Someone who wanted to install reciprocal smallest distance version 1.1 could do so as follows:

    pip install reciprocal_smallest_distance==1.1

## Using GitHub to Distribute Packages

If you use git, it can be convenient to use GitHub as a remote host for your
repository.  Assuming your repository is structured as a package, with a
`setup.py` script in the root directory, etc., then you can use your GitHub
repository in two ways to distribute your code.  The first, detailed above, is
to upload tarballs created by `python setup.py sdist` to the repository
Downloads page.  The seconds way is to directly access your repository.

This can be done by cloning and installing your package.  For example:

    cd ~/tmp
    git clone https://github.com/todddeluca/daemoncmd.git
    cd daemoncmd
    python setup.py build install

Or you can use `pip`, which can access specific branches, tags, and revisions, as described in the 'Installation' section.  For example:

    pip install git+https://github.com/todddeluca/daemoncmd.git#egg=daemoncmd

Especially when rapidly developing a package or when adding enhancements
between official releases, it is useful to directly access the repository or a
specific revision without needing to bump the version number and upload a
tarball, as required by PyPI.



# Data in Package

## Adding Data to a Package

http://docs.python.org/2/distutils/setupscript.html#installing-package-data

To install data files along with a package, using `package_data` in setup.py.

## Accessing Data in a Package

http://peak.telecommunity.com/DevCenter/PkgResources#basic-resource-access

To access data files installed with a package, use the `pkg_resources` module.


# Packaging

Use `distribute` for packaging.

Create a `setup.py` file following the instructions on these pages:

- http://packages.python.org/distribute/setuptools.html
- http://pypi.python.org/pypi/distribute#quick-help-for-developers

## Specifying modules and packages in setup.py

In the setup() function call, use py_modules to specify modules:

    setup(
        ...
        py_modules = ['temps'],
    )

Use `packages` to specify packages to be installed and consider using the 
`find_packages` convenience function:

    from setuptools import setup, find_packages
    setup(
        ...
        packages = ['tfd'],
        # packages=find_packages(),
    )


## Specifying entry points (executables) in packages

If you use setuptools or distribute, you can have it automatically create an
executable that invokes a function (or other entry point) in your package.
This is a convenient and idiomatic way to interface with your package via a
command line interface (CLI).  Here are some pages describing how to create
python CLI from python packages in an idiomatic way:

- http://stackoverflow.com/questions/774824/explain-python-entry-points
- http://stackoverflow.com/questions/17893/whats-the-best-way-to-distribute-python-command-line-tools
- http://peak.telecommunity.com/DevCenter/setuptools#automatic-script-creation

Basically, you include an "entry point" in setup.py and it will create a bin/<yourscriptname>
script that will invoke the function (or whatever) you specify.

This is what the `pip` executable looks like on my system:

    #!/usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/2.7/Resources/Python.app/Contents/MacOS/Python
    # EASY-INSTALL-ENTRY-SCRIPT: 'pip==1.2.1','console_scripts','pip'
    __requires__ = 'pip==1.2.1'
    import sys
    from pkg_resources import load_entry_point

    if __name__ == '__main__':
        sys.exit(
            load_entry_point('pip==1.2.1', 'console_scripts', 'pip')()
        )

And here is a bit from pip's setup.py (https://github.com/pypa/pip/blob/develop/setup.py):

    entry_points=dict(console_scripts=['pip=pip:main', 'pip-%s=pip:main' % sys.version[:3]]),

This points to the `main()` function in the `pip` package.  From there the function takes over parsing command line arguments, etc.


## Using Distutils2 for packaging

In 2012, distutils2/packaging are the future of python packaging.  They mostly
work, but uploading a distribution to pypi with distutils2 is broken (as of
2012/05/26), and pip does not support installing setup.cfg packages.  So
they have a way to go before primetime.

### Creating a package

Initially create setup.cfg via an interactive script

    cd $PACKAGE_DIR
    pysetup create

Add package dependencies to setup.cfg in the metadata requires-dist field.

    $EDITOR setup.cfg


### Installing a package

    cd $PACKAGE_DIR
    pysetup install


### Creating a source distribution

    cd $PACKAGE_DIR
    pysetup run sdist

### Create a source distribution, register and upload it to pypi.

    cd $PACKAGE_DIR
    pysetup run sdist register upload



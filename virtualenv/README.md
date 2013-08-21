[ve]: http://www.virtualenv.org

# Documentation And Tutorials

- http://www.virtualenv.org/en/latest/index.html
- http://pypi.python.org/pypi/virtualenv
- http://www.saltycrane.com/blog/2009/05/notes-using-pip-and-virtualenv-django/

Pip installer documentation.

- http://www.pip-installer.org/en/latest/installing.html

Great article on python deployment using native (debian, rpm) packages.

- http://hynek.me/articles/python-app-deployment-with-native-packages/


# Conventions

Here `python` refers to the /path/to/python executable.  `ENV` refers to the /path/to/your_virtual_environment


# Installing and Using Virtualenv

## The Recommended Way

The [virtualenv][ve] site recommends using the virtualenv.py script to create virtual environments.  First download the script.

    curl -O https://raw.github.com/pypa/virtualenv/master/virtualenv.py

Then run the script with python to create ENV.

    python virtualenv.py --distribute ENV

Or you can do it all in one step.

    curl https://raw.github.com/pypa/virtualenv/master/virtualenv.py | python - --distribute ENV


## The Site-packages Way

You can also install the virtualenv project into the site-packages of any
python installation, like the system-wide or a local python.  Then you can use
`virtualenv` to create a virtual environment.  First install pip by following
the instructions in the pip installation section.  Then install virtualenv.

    pip install virtualenv

Then use `virtualenv` to create ENV.

    virtualenv --distribute ENV


# Pip Installation

This is not necessary, since pip comes installed in every virtual environment, so there is no need to
explicitly install it.  However you might want to install it in your system
wide or local installation of python

First install setuptools or distribute.

    curl http://python-distribute.org/distribute_setup.py | python

Then install pip.

    curl https://raw.github.com/pypa/pip/master/contrib/get-pip.py | python

That is it.


# Creating a Virtual Environment

Best practices:

- Use distribute instead of setuptools.  Create ENV with --distribute.
- Use pip instead of easy_install when installing packages/modules in the
  virtual env.
- Isolate ENV from the packages installed in the system python environment.
  This is the default behavior (as of 2012/05).  Previously, the 
  option --no-site-packages needed to be used.

Use --distribute to install distribute instead of setuptools into the new virtual environment.
Alternatively set the VIRTUALENV_DISTRIBUTE environment variable.

    export VIRTUALENV_DISTRIBUTE=True

If you downloaded virtualenv.py, use virtualenv like so:

    python /path/to/virtualenv.py --distribute ENV

If you installed the virtualenv package, use it like so:

    virtualenv --distribute ENV


# Building a Requirements.txt File For a Python Virtual Environment

http://www.pip-installer.org/en/latest/requirements.html

Use pip to create a requirements file.  This file will list every site package
and version in the python environment used to generate it.  It makes it easier
to reproduce an existing python environment elsewhere.

Create a requirements.txt file for ENV.

    ENV/bin/pip freeze > requirements.txt

Note: One "gotcha" I encountered was thinking I could specify the virtual
environment using the -E option of pip.  I found that this option gives strange
results. Perhaps the option only applies to `pip install` not `pip freeze`.
Ignore `-E` and use the pip executable from the environment bin dir.

To illustrate this gotcha, below are three freeze outputs.  The final output
seems to be the union of the previous two outputs.

Here is the `freeze` output for my local python environment

    /groups/cbi/bin/pip freeze
    MySQL-python==1.2.3
    distribute==0.6.24
    virtualenv==1.6.4
    wsgiref==0.1.2

Here is the output for a virtual environment

    $ /groups/cbi/virtualenvs/roundup-1.0/bin/pip freeze
    Django==1.3
    MySQL-python==1.2.3
    South==0.7.3
    distribute==0.6.19
    reciprocal-smallest-distance==1.1.1
    wsgiref==0.1.2

Here is the output using the local environment pip and specifying the virtual
environment using -E.

    /groups/cbi/bin/pip -E /groups/cbi/virtualenvs/roundup-1.0 freeze
    Django==1.3
    MySQL-python==1.2.3
    South==0.7.3
    distribute==0.6.19
    reciprocal-smallest-distance==1.1.1
    virtualenv==1.6.4
    wsgiref==0.1.2


# Install Packages Using a Requirements File

Every virtual environment has pip installed.  It can be used to easily install
a set of packages at specific versions.  This makes it easier to reproduce
environments.  By creating ENV and installing packages using a requirements
file, an environment can be reliably reproduced.  YMMV.

Install into ENV the packages (and versions) specified in requirements.txt

    ENV/bin/pip install -r requirements.txt


# Building A Native Package With A Virtualenv

Great article on python deployment using native (debian, rpm) packages.

- http://hynek.me/articles/python-app-deployment-with-native-packages/

The idea is that native packages (in contrast to installing from source) are faster, stabler, and more puppet friendly.
Almost all the compiling, installing, and pulling dependencies is pre-done.

The article recommends putting the virtualenv in the application directory,
/path/to/myapp/venv

It changes the script shebangs to point to ENV/bin after installing on the
local machine.  Why?  The location of ENV/bin is different where the package is
built.

    #!/path/to/myapp/bin/python

This technique should come in handy when scaling deployment out to many
servers.


# Other Stuff

Configure the virtual env to be activated when I login. This way I will install
packages into the virtualenv not the system python.

    echo '# set python virtual environment' >> ~/.bashrc
    echo 'source ~/virtualenvs/heyluca.com/bin/activate' >> ~/.bashrc
    . ~/.bashrc




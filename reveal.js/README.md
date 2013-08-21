

# Ubuntu Installation

See http://howtonode.org/how-to-install-nodejs.

    sudo apt-get install g++ curl libssl-dev apache2-utils
    sudo apt-get install git-core
    sudo aptitude install nodejs npm

Or from source:

    curl http://nodejs.org/dist/v0.10.15/node-v0.10.15.tar.gz | tar xv
    cd node-v0.10.15.tar.gz
    sudo ./configure --prefix=/usr/local
    sudo make
    sudo install

# Mac OS X Installation

These dependencies are installed system-wide: node.js and grunt.

Install node.js dependency:

    brew install node

    # Add npm/node cli binaries to PATH
    echo >> '# Node.js from Homebrew' ~/proj/dotfiles/copy/.bashrc
    echo >> 'PATH="$PATH:/usr/local/share/npm/bin"' ~/proj/dotfiles/copy/.bashrc

Install grunt-cli dependency:

    sudo npm install -g grunt-cli


Install reveal.js to create a slideshow:
    
    cd /<path>/<to>/<my>/<slideshow>
    git clone https://github.com/hakimel/reveal.js
    cd reveal.js
    npm install

Run the webserver and look at the demo presentation:

    grunt serve

Edit index.html to create your slideshow:




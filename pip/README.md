# pip-get/ pip.conf

This package contains a pip config file that points pip at a local pip cache
that gets only filled due to ONE single reason: running `pip-get`, also
included. I just don't like it that pip connects to the internet at any time it
likes and maybe or maybe not downloads a new version of a package.

## installing pip...

...without spamming stuff from pip's caching and verion-checking into the home
dir:

    python2.7 <(curl https://bootstrap.pypa.io/get-pip.py) --user --isolated --no-cache-dir --disable-pip-version-check
    python3.6 <(curl https://bootstrap.pypa.io/get-pip.py) --user --isolated --no-cache-dir --disable-pip-version-check
    rm -v ~/.local/bin/pip*

The isolated mode is needed if the pip.conf is already installed, or else
`get-pip.py` chokes on not being able to find its stuff..

## pip-get

Removing the scripts from `.local/bin` is really better, so there's no question
which python version is targeted. To override the Python version, pass in another
version in the `$PY` environment variable, like this:

    PY=python2.7 pip-get -r requirements.txt

[The default is `python3` by the way.]

## pip-where

Run this to find out where dists are installed -- useful to find out which
stuff is system installed (and should have been in dist-packages, but
whatever...) and which dists are in the user dir.

# dotfiles

`$HOME`, sweet `$HOME`.

## git-crypt

To transfer the `default` key:

    git-crypt export-key -k default >(xxd -p -c256)

Then get it on stdin somehow and import it:

    git-crypt unlock <(xxd -p -r)

(The name of the key is stored within the key file.)

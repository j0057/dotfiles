#!/bin/bash

if [ -n "$SSH_AUTH_SOCK" ]; then

    if [ -n "$SSH_PAGEANT_PID" -a -n "$SSH_PAGEANT_KILL_ON_LOGOUT" ]; then
        eval $(ssh-pageant -k)
    fi

fi

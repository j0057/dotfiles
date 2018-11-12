#!/bin/bash

if [ -n "$SSH_AUTH_SOCK" ]; then

    if [ -n "$SSH_PAGEANT_PID" -a -n "$SSH_PAGEANT_KILL_ON_LOGOUT" ]; then
        eval $(ssh-pageant -k)
    elif [ -n "$SSH_AGENT_PID" -a "$SSH_AGENT_WSL1804_KILL_ON_LOGOUT" = "$$" ]; then
        eval $(ssh-agent.wsl1804 -k)
    elif [ -n "$SSH_AGENT_PID" -a "$SSH_AGENT_KILL_ON_LOGOUT" = "$$" ]; then
        eval $(ssh-agent -k)
    fi

fi

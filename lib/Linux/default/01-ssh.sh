SSH_ENV="$HOME/.ssh/environment"

function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     for ssh_key in "${HOME}/.ssh/*dsa*"
     do
         /usr/bin/ssh-add ${ssh_key%*.pub}
     done
}

# Source SSH settings, if applicable

if [ -f "${SSH_ENV}" -a ! pgrep gnom-keyring >/dev/null 2>&1 ]; then
    . "${SSH_ENV}" > /dev/null
#ps ${SSH_AGENT_PID} doesn't work under cywgin
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent > /dev/null || {
    start_agent
    }
fi

# Reattach agent when connecting to tmux
if [[ -S "$SSH_AUTH_SOCK" && ! -h "$SSH_AUTH_SOCK" ]]; then
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock;
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock;

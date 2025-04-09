if test -z (pgrep ssh-agent | string collect)
  eval (ssh-agent -c) >/dev/null
  set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
  set -Ux SSH_AGENT_PID $SSH_AGENT_PID
end

if status is-interactive
  if ssh-add -l | grep -q "The agent has no identities"
    ssh-add
  end
end

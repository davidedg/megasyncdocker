#!/bin/bash
set -uo pipefail

SESSION_FILE="$HOME/.megaCmd/session"
CREDS_FILE="/run/mega.creds"

if [ ! -r "$CREDS_FILE" ]; then
  echo "Credentials file not found or unreadable" >&2
  exit 1
fi

megaUser=$(grep -m1 '^user=' "$CREDS_FILE" | cut -d= -f2- | tr -d '\r')
megaPass=$(grep -m1 '^pass=' "$CREDS_FILE" | cut -d= -f2- | tr -d '\r')

if [ -z "$megaUser" ] || [ -z "$megaPass" ]; then
  echo "Credentials file is missing 'user=' or 'pass='" >&2
  exit 1
fi

mega-logout --keep-session

if [ -r "$SESSION_FILE" ]; then
  echo "Trying session login..."
  if mega-login "$(cat "$SESSION_FILE")" >/dev/null 2>&1; then
    echo "Session login OK"
    unset megaPass
    exit 0
  fi
  echo "Session login failed, falling back to user/pass..."
else
  echo "No session file found, logging in with user/pass..."
fi

mega-login "$megaUser" "$megaPass"
rc=$?
unset megaPass

if [ $rc -ne 0 ]; then
  echo "Login failed (rc=$rc), waiting 5 min before exiting to avoid hammering MEGA" >&2
  sleep 150
fi
exit $rc
#!/bin/bash

SESSION_FILE="$HOME/.megaCmd/session"
CREDS_FILE="/run/mega.creds"


if [ -r "$CREDS_FILE" ]; then
  megaUser=$(grep '^user=' "$CREDS_FILE" | cut -d= -f2)
  megaPass=$(grep '^pass=' "$CREDS_FILE" | cut -d= -f2)
else
  echo "Credentials file not found or unreadable"
  exit 1
fi

mega-logout --keep-session

if [ -r "$SESSION_FILE" ]; then
  SESSION_ID=$(cat "$SESSION_FILE")
  echo "Trying session login..."
  mega-login "$SESSION_ID"
  if [ $? -ne 0 ]; then
    echo "Session login failed, falling back to user/pass..."
    mega-login "$megaUser" "$megaPass"
  fi
else
  echo "No session file found, logging in with user/pass..."
  mega-login "$megaUser" "$megaPass"
fi

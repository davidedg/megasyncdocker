#!/bin/bash
set -uo pipefail

REMOTE_PATH="/REMOTE1"
LOCAL_PATH="/data"

# La configurazione delle sync è persistente in ~/.megaCmd: al riavvio esiste già.
# Senza questo controllo mega-sync restituisce errore, la catena && si interrompe
# e il container entra in restart loop.
if mega-sync 2>/dev/null | grep -qE "[[:space:]]${LOCAL_PATH}[[:space:]]"; then
  echo "Sync $LOCAL_PATH -> MEGA:$REMOTE_PATH already configured"
else
  echo "Syncing $LOCAL_PATH to MEGA:$REMOTE_PATH..."
  #mega-sync "$LOCAL_PATH" "$REMOTE_PATH"
fi
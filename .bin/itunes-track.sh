#!/usr/bin/env bash
if [ -z `which osascript` ]; then
  exit 0
fi
ITUNES_TRACK=$(osascript <<EOF
if appIsRunning("iTunes") then
    tell app "iTunes" to get the name of the current track
end if
on appIsRunning(appName)
    tell app "System Events" to (name of processes) contains appName
end appIsRunning
EOF)

if [ ! -z "$ITUNES_TRACK" ]; then
  ITUNES_ARTIST=$(osascript <<EOF
if appIsRunning("iTunes") then
    tell app "iTunes" to get the artist of the current track
end if
on appIsRunning(appName)
    tell app "System Events" to (name of processes) contains appName
end appIsRunning
EOF)
    echo '♫' $ITUNES_TRACK '-' $ITUNES_ARTIST
fi

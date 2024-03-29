#!/usr/bin/env bash
if [ -z `which osascript` ]; then
  exit 0
fi
os=$(defaults read loginwindow SystemVersionStampAsString)
itunes="iTunes"
if [[ $os =~ "10.15" ]]; then
  itunes="Music"
fi

OUTPUT=$(osascript <<-END
tell app "$itunes"
  if it is running then
    if player state is playing then
      set track_name to name of current track
      set artist_name to artist of current track

      if artist_name > 0
        "♫ " & artist_name & " - " & track_name
      else
        "~ " & track_name
      end if
    end if
  end if
end tell
END)

if [ -z "$OUTPUT" ]; then
  if [ ! -z "$(mpc status | grep '\[playing\]')" ]; then
    OUTPUT="♫ $(mpc current)"
  fi
fi

echo $OUTPUT

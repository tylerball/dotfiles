local modifier = {'ctrl', 'option', 'cmd'}

apps = {}
apps.itunes = {}
apps.itunes.toggle = function ()
  hs.itunes.playpause()
end
apps.itunes.next = function ()
  hs.itunes.next()
end
apps.itunes.prev = function ()
  hs.itunes.prev()
end

apps.spotify = {}
apps.spotify.toggle = function ()
  hs.spotify.playpause()
end
apps.spotify.next = function ()
  hs.spotify.next()
end
apps.spotify.prev = function ()
  hs.spotify.prev()
end

apps.mpc = {}
apps.mpc.toggle = function ()
  hs.execute('~/.bin/mpc pause')
end
apps.mpc.next = function ()
  hs.execute('~/.bin/mpc next')
end
apps.mpc.prev = function ()
  hs.execute('~/.bin/mpc cdprev')
end

hs.hotkey.bind(modifier, 'return', function ()
  if hs.settings.get('paused') then
    apps[hs.settings.get('lastplayed')].toggle()
  else
    _, _, _, mpcrc = hs.execute('~/.bin/mpc status | grep "\\[playing\\]"')
    if hs.itunes.getPlaybackState() == hs.itunes.state_playing then
      hs.settings.set('lastplayed', 'itunes')
    elseif hs.spotify.getPlaybackState() == hs.spotify.state_playing then
      hs.settings.set('lastplayed', 'spotify')
    elseif mpcrc < 1 then
      hs.settings.set('lastplayed', 'mpc')
    end
    apps[hs.settings.get('lastplayed')].toggle()
    hs.settings.set('paused', true)
  end
end)

hs.hotkey.bind(modifier, 'right', function ()
  apps[hs.settings.get('lastplayed')].next()
end)

hs.hotkey.bind(modifier, 'left', function ()
  apps[hs.settings.get('lastplayed')].prev()
end)

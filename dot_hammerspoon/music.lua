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

apps.mpc = {}
apps.mpc.toggle = function ()
  hs.execute('~/.bin/mpc toggle')
end
apps.mpc.next = function ()
  hs.execute('~/.bin/mpc next')
end
apps.mpc.prev = function ()
  hs.execute('~/.bin/mpc cdprev')
end

hs.hotkey.bind(modifier, 'return', function ()
  -- _, _, _, mpcrc = hs.execute('~/.bin/mpc status | grep "\\[playing\\]"')
  if hs.itunes.isRunning() and hs.itunes.getPlaybackState() == hs.itunes.state_playing then
    hs.settings.set('lastplayed', 'itunes')
  -- elseif mpcrc < 1 then
  --   hs.settings.set('lastplayed', 'mpc')
  else
    hs.settings.set('paused', true)
  end

  apps[hs.settings.get('lastplayed')].toggle()
  if hs.settings.get('paused') == false then
    hs.settings.set('paused', true)
  end
end)

hs.hotkey.bind(modifier, 'right', function ()
  apps[hs.settings.get('lastplayed')].next()
end)

hs.hotkey.bind(modifier, 'left', function ()
  apps[hs.settings.get('lastplayed')].prev()
end)

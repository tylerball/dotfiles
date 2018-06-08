local modifier = {'shift', 'ctrl'}
local apps = {
  i = 'iTerm',
  o = 'Tweetbot',
  d = 'Dash',
  e = 'Messages',
  s = 'Slack',
  f = 'Finder',
  u = 'iTunes',
  c = 'Calendar',
  r = 'Reminders',
  a = 'Firefox',
  w = 'Google Chrome',
  p = 'Spotify',
}

for key, app in pairs(apps) do
  hs.hotkey.bind(modifier, key, function ()
    hs.application.launchOrFocus(app)
  end)
end

hs.hotkey.bind(modifier, 'w', function ()
  hs.application.launchOrFocusByBundleID('com.google.chrome')
end)

-- prevent window closes in Chrome
hs.hotkey.bind({'cmd', 'shift'}, 'w', function ()
  if hs.application.get('Google Chrome'):isFrontmost() then
    return
  else
    hs.application.frontmostApplication():selectMenuItem({'File', 'Close Window'})
  end
end)

local watcher = hs.application.watcher.new(function (app, event)
  local bind = hs.hotkey.bind({'cmd'}, 'm', function ()
    hs.application.get('Finder'):selectMenuItem('Merge All Windows')
  end):disable()
  if app == 'Finder' then
    if event == hs.application.watcher.activated then
      bind:enable()
    else
      bind:disable()
    end
  end
end)

watcher:start()

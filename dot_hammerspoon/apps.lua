local modifier = {'shift', 'ctrl'}
local apps = {
  i = 'iTerm',
  o = 'Tweetbot',
  d = 'Dash',
  e = 'Messages',
  s = 'Slack',
  f = 'Finder',
  c = 'Fantastical 2',
  r = 'Reminders',
  a = 'Firefox',
  w = 'Google Chrome',
  p = 'Spotify',
  z = 'Safari',
  n = 'Notes',
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

if hs.host.operatingSystemVersion()['minor'] >= 15 then
  hs.hotkey.bind(modifier, 'u', function()
    hs.application.launchOrFocus('Music')
  end)
else
  hs.hotkey.bind(modifier, 'u', function()
    hs.application.launchOrFocus('iTunes')
  end)
end

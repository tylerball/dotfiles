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

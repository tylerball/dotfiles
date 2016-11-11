local modifier = {'shift', 'ctrl'}
local apps = {
  i = 'iTerm',
  m = 'Mailplane 3',
  o = 'Tweetbot',
  d = 'Dash',
  e = 'Messages',
  s = 'Slack',
  f = 'Path Finder',
  u = 'iTunes',
}

for key, app in pairs(apps) do
  hs.hotkey.bind(modifier, key, function ()
    hs.application.launchOrFocus(app)
  end)
end

hs.hotkey.bind(modifier, 't', function ()
  hs.application.launchOrFocus('Google Chrome')
  hs.application.get('Google Chrome'):selectMenuItem({'People', 'Tyler'})
end)

hs.hotkey.bind(modifier, 'w', function ()
  hs.application.launchOrFocus('Google Chrome')
  hs.application.get('Google Chrome'):selectMenuItem({'People', 'Shopify'})
end)

-- prevent window closes in Chrome
hs.hotkey.bind({'cmd', 'shift'}, 'w', function ()
  if hs.application.get('Google Chrome'):isFrontmost() then
    return
  else
    hs.application.frontmostApplication():selectMenuItem({'File', 'Close Window'})
  end
end)

-- prevent quits in Chrome
hs.hotkey.bind({'cmd',}, 'q', function ()
  if hs.application.get('Google Chrome'):isFrontmost() then
    return
  else
    hs.application.frontmostApplication():kill()
  end
end)

local modifier = {'shift', 'ctrl'}
local apps = {
  {'i', 'iTerm'},
  {'m', 'Mailplane 3'},
  {'o', 'Tweetbot'},
  {'d', 'Dash'},
  {'e', 'Messages'},
  {'s', 'Slack'},
  {'f', 'Path Finder'},
  {'u', 'iTunes'},
}

hs.fnutils.each(apps, function (app)
  hs.hotkey.bind(modifier, app[1], function ()
    hs.application.launchOrFocus(app[2])
  end)
end)

hs.hotkey.bind(modifier, 't', function ()
  hs.application.launchOrFocus('Google Chrome')
  hs.application.get('Google Chrome'):selectMenuItem({'People', 'Tyler'})
end)

hs.hotkey.bind(modifier, 'w', function ()
  hs.application.launchOrFocus('Google Chrome')
  hs.application.get('Google Chrome'):selectMenuItem({'People', 'Shopify'})
end)

hs.hotkey.bind({'cmd', 'shift'}, 'w', function ()
  if hs.application.get('Google Chrome'):isFrontmost() then
    return
  end
end)

hs.hotkey.bind({'cmd',}, 'q', function ()
  if hs.application.get('Google Chrome'):isFrontmost() then
    return
  end
end)

urls = {}

urls.handler = function (scheme, host, params, fullURL)
  if hs.eventtap.checkKeyboardModifiers()['cmd'] then
    return urls.chooser(fullURL)
  end

  if string.find(fullURL, 'docs.google.com')
    or string.find(fullURL, 'goo.gl')
    then
    return urls.chooser(fullURL)
  end

  if string.find(fullURL, 'github.com/Shopify')
    or string.find(fullURL, 'shopify')
    or string.find(fullURL, 'lever.co')
    or string.find(fullURL, 'invisionapp.com')
    or string.find(fullURL, 'invis.io')
    or string.find(fullURL, 'datadoghq.com')
    then
      urls.openWork(fullURL)
  else
    urls.openHome(fullURL)
  end
end

urls.chooser = function (url)
  chooser = hs.chooser.new(function (choice)
    if choice then
      urls._open(url, choice.text)
    end
  end)

  chooser:width(20)
  chooser:rows(3)
  chooser:choices({
    {
      ['text'] = "Shopify",
      ['subText'] = '',
      ['name'] = "Shopify",
    },
    {
      ['text'] = "Tyler",
      ['subText'] = '',
      ['name'] = "Tyler",
    },
    {
      ['text'] = "Apps",
      ['subText'] = '',
      ['name'] = "Apps",
    }
  })

  chooser:show()
end

urls.openHome = function (url)
  urls._open(url, 'Tyler')
end

urls.openWork = function (url)
  urls._open(url, 'Shopify')
end

urls._open = function (url, profile)
  local bool, result = hs.applescript.applescript([[
    tell application "Google Chrome" to activate
    tell application "System Events"
      tell process "Google Chrome"
        tell menu bar 1
          tell menu bar item "People"
            tell menu "People"
              click menu item "]] .. profile .. [["
            end tell
          end tell
        end tell
      end tell
    end tell
    tell application "Google Chrome" to open location "]] .. url .. '"'
  )
  if not bool then
    print(result.NSAppleScriptErrorMessage)
  end
end

return urls

urls = {}

urls.handler = function (scheme, host, params, fullURL)
  if hs.eventtap.checkKeyboardModifiers()['cmd'] and hs.eventtap.checkKeyboardModifiers()['shift'] then
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
    or string.find(fullURL, 'circleci.com/gh/Shopify')
    then
      urls.openWork(fullURL)
  else
    urls.openHome(fullURL)
  end
end

urls.chooser = function (url)
  chooser = hs.chooser.new(function (choice)
    if choice['browser'] == 'safari' then
      urls._openSafari(url, choice.text)
    elseif choice['browser'] == 'firefox' then
      urls._openFirefox(url, choice.text)
    elseif choice['browser'] == 'chrome' then
      urls._openChrome(url, choice.text)
    end
  end)

  chooser:width(20)
  chooser:rows(3)
  chooser:choices({
    {
      ['text'] = "Shopify",
      ['subText'] = '',
      ['name'] = "Shopify",
      ['browser'] = "chrome",
    },
    {
      ['text'] = "Safari",
      ['subText'] = '',
      ['name'] = "Safari",
      ['browser'] = "safari",
    },
    {
      ['text'] = "Home",
      ['subText'] = '',
      ['name'] = 'Home',
      ['browser'] = "Firefox",
    },
  })

  chooser:show()
end

urls.openHome = function (url)
  urls._openSafari(url)
end

urls.openWork = function (url)
  urls._openChrome(url, 'Shopify')
end

urls._openChrome = function (url, profile)
  hs.application.launchOrFocusByBundleID('com.google.chrome')
  local bool, result = hs.osascript.applescript([[
    tell application "Google Chrome" to open location "]] .. url .. '"'
  )
  if not bool then
    print(result)
  end
end

urls._openFirefox = function (url)
  hs.application.launchOrFocus('Firefox')
  local bool, result = hs.osascript.applescript([[
    tell application "Firefox" to open location "]] .. url .. '"'
  )
  if not bool then
    print(result)
  end
end

urls._openSafari = function (url)
  hs.application.launchOrFocus('Safari')
  local bool, result = hs.osascript.applescript([[
    tell application "Safari" to open location "]] .. url .. '"'
  )
  if not bool then
    print(result)
  end
end

hs.urlevent.httpCallback = urls.handler
hs.urlevent.setDefaultHandler('http')

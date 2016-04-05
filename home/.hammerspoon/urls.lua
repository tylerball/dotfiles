urls = {}

urls.handler = function (scheme, host, params, fullURL)
  if string.find(fullURL, 'github.com/Shopify') 
    or string.find(fullURL, 'myshopify.com')
    or string.find(fullURL, 'myshopify.io')
    or string.find(fullURL, 'docs.google.com.*shopify.com')
    then
      urls.openWork(fullURL)
  else
    urls.openHome(fullURL)
  end
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

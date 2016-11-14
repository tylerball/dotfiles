local caffeine

function toggle(hours)
  hs.caffeinate.toggle('displayIdle')
  local state = hs.caffeinate.get('displayIdle')
  if state then
    hs.alert.show('Caffeinated!')
    hs.timer.doAfter(hs.timer.hours(hours), function () hs.caffeinate.set('displayIdle', false) end)
  else
    hs.alert.show('Decaf')
  end
  setIcon()
end

function setIcon()
  local state = hs.caffeinate.get('displayIdle')
  if state then
    caffeine:setIcon(os.getenv('HOME') .. '/.hammerspoon/caffeine-on.pdf')
  else
    caffeine:setIcon(os.getenv('HOME') .. '/.hammerspoon/caffeine-off.pdf')
  end
end

caffeine = hs.menubar.new(true)
caffeine:setMenu({
  { title = '2 Hours', fn = function() toggle(2) end },
  { title = '5 Hours', fn = function() toggle(2) end },
})

setIcon()
hs.hotkey.bind(hs.settings.get('modifier'), 'c', function () toggle(2) end)

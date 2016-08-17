layout = {}
-- contains a table indexed by screen name and grid instructions
layout.apps = {}

function length(tbl)
  local count = 0
  for i, b in pairs(tbl) do
    count = count + 1
  end
  return count
end

function layout.bind(app, locations)
  layout.apps[app] = _.extend(locations, { name = app })
end

function layout.getScreens()
  local screens = hs.screen.allScreens()

  local scr = hs.screen.primaryScreen()

  local orderedScreens = {}
  layout.screens = {}

  orderedScreens[1] = { name='main',screen=scr }
  layout.screens[scr:name()] = 'main'
  local count = 1
  while count < length(screens) and length(screens) > 1 do
    layout.screens[scr:name()] = 'alt' .. count
    scr = scr:next()
    orderedScreens[count + 1] = { name='alt' .. count,screen=scr }
    count = count + 1
  end

  return orderedScreens
end

function layout.getLayout()
  local l = 'one'
  if length(hs.screen.allScreens()) == 2 then
    l = 'two'
  end
  return l
end

function layout.doChanges()
  local focused = hs.window.focusedWindow()
  hs.fnutils.each(layout.apps, function (app)
    layout.changeApp(app['name'])
  end)
  focused:focus()
end

function layout.changeApp(a)
  hs.fnutils.each(layout.getScreens(), function (s)
    local app = hs.application.find(a)
    local windows
    if app then windows = app:allWindows() else return end
    local activeLayout = layout.getLayout()
    local app = layout.apps[a]
    local screenName = s.name
    if app[activeLayout] then
      if app[activeLayout]['custom'] then
        layout.changeWindowCustom(app[activeLayout]['custom'], app[activeLayout], s.screen, windows)
      else
        if app[activeLayout][screenName] then
          hs.fnutils.each(windows, function (w)
            layout.changeWindow(app[activeLayout][screenName], app[activeLayout], s.screen, w)
          end)
        end
      end
    end
  end)
end

function layout.changeWindowCustom(value, layout, screen, windows)
  value(layout, screen, windows)
end

function layout.setWindow(win, cell, screen)
  local active = layout.getLayout()
  local itermscreen = hs.application.find('iTerm2'):allWindows()[1]:screen()
  if screen:name() == itermscreen:name() and cell.h == 6 then
    if hs.screen.allScreens()[screen:name()] == 'main' then
      --cell.h = cell.h - 0.2
    end
    --cell.h = cell.h - 0.05
  end
  hs.grid.set(win, cell, screen)
end

function layout.changeWindow(value, _layout, screen, window)
  if window then
    layout.setWindow(window, value, screen)
  end
end

return layout

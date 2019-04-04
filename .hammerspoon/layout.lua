utils = require 'utils'

hs.grid.setGrid('6x6')

layout = {}
layout.GRIDHEIGHT = 6
layout.GRIDWIDTH = 6

positions = {
  leftHalf  =  {x=0, y=0, w=layout.GRIDWIDTH / 2, h=layout.GRIDHEIGHT},
  rightHalf =  {x=layout.GRIDWIDTH / 2, y=0, w=layout.GRIDWIDTH / 2, h=layout.GRIDHEIGHT},
  rightThird = {x=layout.GRIDWIDTH / 3 * 2, y=0, w=layout.GRIDWIDTH / 3, h=layout.GRIDHEIGHT},
  leftThird = {x=0, y=0, w=layout.GRIDWIDTH / 3, h=layout.GRIDHEIGHT},
  leftTwoThird = {x=0, y=0, w=layout.GRIDWIDTH / 3 * 2, h=layout.GRIDHEIGHT},
  rightTwoThird = {x=layout.GRIDWIDTH / 3, y=0, w=layout.GRIDWIDTH / 3 * 2, h=layout.GRIDHEIGHT},
  full      =  {x=0, y=0, w=layout.GRIDWIDTH, h=layout.GRIDHEIGHT},

  lowerRight = {x=layout.GRIDWIDTH / 2, y=layout.GRIDWIDTH / 2, w=layout.GRIDWIDTH / 2, h=layout.GRIDWIDTH / 2},
  upperRight = {x=layout.GRIDWIDTH / 2, y=0, w=layout.GRIDWIDTH / 2, h=layout.GRIDWIDTH / 2},
  lowerLeft = {x=0, y=layout.GRIDWIDTH / 2, w=layout.GRIDWIDTH / 2, h=layout.GRIDWIDTH / 2},
  upperLeft = {x=0, y=0, w=layout.GRIDWIDTH / 2, h=layout.GRIDWIDTH / 2},
  upperThird = {x=0, y=0, w=layout.GRIDWIDTH, h=layout.GRIDHEIGHT / 3},
  upperHalf = {x=0, y=0, w=layout.GRIDWIDTH, h=layout.GRIDHEIGHT / 2},
  lowerHalf = {x=0, y=layout.GRIDHEIGHT / 2, w=layout.GRIDWIDTH, h=layout.GRIDHEIGHT / 2},
}

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
  layout.apps[app] = utils.extend(locations, { name = app })
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
  if hs.screen.mainScreen():name() == 'HP Z27n G2' or hs.screen.mainScreen():name() == 'LG Ultra HD' then
    l = 'office'
  elseif length(hs.screen.allScreens()) == 2 then
    l = 'two'
  end
  return l
end

function layout.doChanges()
  local focused = hs.window.focusedWindow()
  hs.fnutils.each(layout.apps, function (app)
    layout.changeApp(app['name'])
  end)
  if focused then
    focused:focus()
  end
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
  local iterm = hs.application.find('iTerm')
  if iterm and iterm:allWindows()[1] then
    local itermscreen = iterm:allWindows()[1]:screen()
    if screen:name() == itermscreen:name() and cell.h == 6 then
      if hs.screen.allScreens()[screen:name()] == 'main' then
      end
    end
  end
  hs.grid.set(win, cell, screen)
end

function layout.changeWindow(value, _layout, screen, window)
  if window then
    layout.setWindow(window, value, screen)
  end
end

function layout.setGrid(key, cell)
  hs.hotkey.bind(hs.settings.get('modifier'), key, function ()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    layout.setWindow(win, cell, screen)
  end)
end

layout.setGrid('H', positions.leftHalf)
layout.setGrid('L', positions.rightHalf)
layout.setGrid('P', positions.rightThird)
layout.setGrid('U', positions.leftThird)
layout.setGrid('Y', positions.leftTwoThird)
layout.setGrid('O', positions.rightTwoThird)

layout.setGrid('I', positions.upperHalf)
layout.setGrid('M', positions.lowerHalf)
layout.setGrid(',', positions.lowerRight)
layout.setGrid('K', positions.upperRight)
layout.setGrid('J', positions.upperRight)

hs.hotkey.bind(hs.settings.get('modifier'), '=', function ()
  local win = hs.window.focusedWindow()
  hs.grid.set(win, hs.grid.get(win), win:screen():next())
end)

hs.hotkey.bind(hs.settings.get('modifier'), '-', function ()
  local win = hs.window.focusedWindow()
  hs.grid.set(win, hs.grid.get(win), win:screen():previous())
end)

layout.bind('Finder', {
  one = { main = positions.rightTwoThird },
  two = { main = positions.rightHalf },
})

layout.bind('iTerm', {
  one = { main = positions.full },
  office = { main = positions.full },
})

layout.bind('Dash',        {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
  office = { main = positions.right },
})

layout.bind('Slack', {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
  office = { main = positions.right },
})

layout.bind('Tweetbot',    {
  one = { main = {x=0, y=0, w=layout.GRIDWIDTH / 3, h=layout.GRIDHEIGHT - 0.1} },
  two = { alt1 = positions.leftThird },
  office = { main = positions.leftThird },
})

layout.bind('Messages',    {
  one = { main = positions.upperRight },
  two = { alt1 = positions.upperRight },
  office = { main = positions.upperRight },
})

layout.bind('Dash',    {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
})

local fullScreens = {
  'Fantastical',
  'Lightroom',
  'iTunes',
  'Spotify',
}

hs.fnutils.each(fullScreens, function (app)
  layout.bind(app, {
    one = { main = positions.full },
    two = { alt1 = positions.full },
  })
end)

local fullScreensRightOffice = {
  'Google Chrome',
  'Safari',
  'Notion',
}

hs.fnutils.each(fullScreensRightOffice, function (app)
  layout.bind(app, {
    one = { main = positions.full },
    two = { alt1 = positions.full },
    office = { main = positions.right },
  })
end)

layout.bind('Reminders', {
  one = { main = positions.lowerRight },
  two = { alt1 = positions.lowerRight },
})

hs.fnutils.each(layout.apps, function (app)
  if app['studio'] == nil then
    app['studio'] = app['one']
  end
end)

hs.hotkey.bind(hs.settings.get('modifier'), 'e', function ()
  layout.doChanges()
end)

hs.hotkey.bind(hs.settings.get('modifier'), 'return', function ()
  local win = hs.window.focusedWindow()
  local app = win:application()
  if string.match(app:title(), "iTerm") then
    win:maximize()
  else
    local frame = win:screen():frame()
    layout.setWindow(win, positions.full, win:screen())
  end
end)

hs.screen.watcher.new(layout.doChanges):start()

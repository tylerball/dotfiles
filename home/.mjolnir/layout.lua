local _ = require 'underscore'
local fnutils = require 'mjolnir.fnutils'
local screen = require 'mjolnir.screen'
local find = require 'mjolnir.cmsj.appfinder'
local window = require 'mjolnir.window'

watcher = {}
-- contains a table indexed by screen name and grid instructions
watcher.apps = {}

layouts = {
  ['work_two'] = { 'Thunderbolt Display', 'Color LCD' },
  ['work_one'] = { 'Color LCD' },
}

local screens = screen.allscreens()

function length(tbl)
  local count = 0
  for i, b in pairs(tbl) do
    count = count + 1
  end
  return count
end

function watcher.bind(app, locations)
  watcher.apps[app] = _.extend(locations, { name = app })
end

function watcher.getScreens()
  local screens = screen.allscreens()
  -- returns active screens ordered from east to west

  -- get eastmost screen
  local east
  fnutils.each(screens, function (s)
    if s:toeast() == nil then
      east = s
    end
  end)

  -- fill table from east to west
  local count = 0
  local orderedScreens = {}
  orderedScreens[0] = east
  while count < length(screens) and length(screens) > 1 do
    orderedScreens[count] = east
    east = east:towest()
    count = count + 1
  end

  return orderedScreens
end

function watcher.getLayout()
  local names = fnutils.map(watcher.getScreens(), function (s) return s:name() end)
  local l = fnutils.find(layouts, function (l) return _.is_equal(l, names) end)
  return fnutils.indexof(layouts, l)
end

function watcher.doChanges()
  local focused = window.focusedwindow()
  fnutils.each(watcher.apps, function (app)
    watcher.changeApp(app['name'])
  end)
  focused:focus()
end

function watcher.changeApp(a)
  fnutils.each(watcher.getScreens(), function (s)
    local app = find.app_from_name(a)
    local windows
    if app then windows = app:allwindows() else return end
    local activeLayout = watcher.getLayout()
    local app = watcher.apps[a]
    local screenName = s:name()
    if app[activeLayout] then
      if app[activeLayout]['custom'] then
        watcher.changeWindow(app[activeLayout]['custom'], app[activeLayout], s)
      else
        if app[activeLayout][screenName] then
          fnutils.each(windows, function (w)
            watcher.changeWindow(app[activeLayout][screenName], app[activeLayout], s, w)
          end)
        end
      end
    end
  end)
end

function watcher.changeWindow(value, layout, screen, window)
  if type(value) == 'function' then
    value(layout, screen, window)
  end
  if type(value) == 'table' then
    if window then
      grid.set(window, value, screen)
    end
  end
end

return watcher

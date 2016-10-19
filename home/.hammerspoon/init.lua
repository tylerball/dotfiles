package.path = "/usr/local/share/lua/5.2/?.lua;"..package.path
_ = require 'underscore'
utils = require 'utils'
layout = require 'layout'
urls = require 'urls'
require 'apps'

hs.grid.setGrid('6x6')

grid = {}
grid.GRIDHEIGHT = 6
grid.GRIDWIDTH = 6

positions = {
  leftHalf  =  {x=0, y=0, w=grid.GRIDWIDTH / 2, h=grid.GRIDHEIGHT},
  rightHalf =  {x=grid.GRIDWIDTH / 2, y=0, w=grid.GRIDWIDTH / 2, h=grid.GRIDHEIGHT},
  rightThird = {x=grid.GRIDWIDTH / 3 * 2, y=0, w=grid.GRIDWIDTH / 3, h=grid.GRIDHEIGHT},
  leftThird = {x=0, y=0, w=grid.GRIDWIDTH / 3, h=grid.GRIDHEIGHT},
  rightTwoThird = {x=grid.GRIDWIDTH / 3, y=0, w=grid.GRIDWIDTH / 3 * 2, h=grid.GRIDHEIGHT},
  leftTwoThird = {x=0, y=0, w=grid.GRIDWIDTH / 3 * 2, h=grid.GRIDHEIGHT},
  full      =  {x=0, y=0, w=grid.GRIDWIDTH, h=grid.GRIDHEIGHT},

  lowerRight = {x=grid.GRIDWIDTH / 2, y=grid.GRIDWIDTH / 2, w=grid.GRIDWIDTH / 2, h=grid.GRIDWIDTH / 2},
  upperRight = {x=grid.GRIDWIDTH / 2, y=0, w=grid.GRIDWIDTH / 2, h=grid.GRIDWIDTH / 2},
  lowerLeft = {x=0, y=grid.GRIDWIDTH / 2, w=grid.GRIDWIDTH / 2, h=grid.GRIDWIDTH / 2},
  upperLeft = {x=0, y=0, w=grid.GRIDWIDTH / 2, h=grid.GRIDWIDTH / 2},
  upperThird = {x=0, y=0, w=grid.GRIDWIDTH, h=grid.GRIDHEIGHT / 3},
}

hs.hotkey.bind(utils.modifier, 'return', function ()
  local win = hs.window.focusedWindow()
  local app = win:application()
  if string.match(app:title(), "iTerm") then
    win:maximize()
  else
    local frame = win:screen():frame()
    layout.setWindow(win, positions.full, win:screen())
  end
end)

utils.setGrid('H', positions.leftHalf)
utils.setGrid('L', positions.rightHalf)
utils.setGrid('P', positions.rightThird)
utils.setGrid('U', positions.leftThird)
utils.setGrid('O', positions.rightTwoThird)
utils.setGrid('I', positions.leftTwoThird)

utils.setGrid(',', positions.lowerRight)
utils.setGrid('K', positions.upperRight)
utils.setGrid('M', positions.lowerRight)
utils.setGrid('J', positions.upperRight)

hs.hotkey.bind(utils.modifier, '=', function ()
  local win = hs.window.focusedWindow()
  hs.grid.set(win, hs.grid.get(win), win:screen():next())
end)

hs.hotkey.bind(utils.modifier, '-', function ()
  local win = hs.window.focusedWindow()
  hs.grid.set(win, hs.grid.get(win), win:screen():previous())
end)

layout.bind('Path Finder', {
  one = { main = positions.rightTwoThird },
  two = { main = positions.rightHalf },
})

layout.bind('iTerm', {
  one = { main = positions.full },
})

layout.bind('Dash',        {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
})

layout.bind('Mailplane 3', {
  one = { main = positions.rightTwoThird },
  two = { main = positions.rightHalf },
})

layout.bind('Slack', {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
})

layout.bind('Tweetbot',    {
  one = { main = {x=0, y=0, w=grid.GRIDWIDTH / 3, h=grid.GRIDHEIGHT - 0.1} },
  two = { alt1 = positions.leftThird },
})

layout.bind('iTunes', {
  one = { main = positions.full },
  two = { alt1 = positions.full },
})

layout.bind('Messages',    {
  one = { main = positions.upperRight },
  two = { alt1 = positions.upperRight },
})

layout.bind('Dash',    {
  one = { main = positions.rightTwoThird },
  two = { alt1 = positions.rightTwoThird },
})

layout.bind('Google Chrome', {
  one = { main = positions.full },
  two = { alt1 = positions.full },
})

layout.bind('Lightroom', {
  one = { main = positions.full },
  two = { alt1 = positions.full },
})

hs.hotkey.bind(utils.modifier, 'e', function ()
  layout.doChanges()
end)

local watcher = hs.screen.watcher.new(layout.doChanges):start()

hs.urlevent.httpCallback = urls.handler
hs.urlevent.setDefaultHandler('http')

hs.pathwatcher.new(hs.configdir .. '/', hs.reload):start()

local audioWatcher = hs.audiodevice.watcher.setCallback(function ()
  -- NEVER USE DISPLAY AUDIO
  if hs.audiodevice.current().name == 'Display Audio' and string.find(hs.wifi.currentNetwork(), 'Shopify') then
    hs.audiodevice.findDeviceByName('Built-in Output'):setDefaultOutputDevice()
    print('display audio prevented')
  end
end)
hs.audiodevice.watcher.start()

local wifiWatcher = hs.wifi.watcher.new(function ()
  if hs.wifi.currentNetwork() == 'DATA_5G' then
    os.execute("mount_afp afp://tball@klein.local/photos /Volumes/photos")
    print('wifi and mounted')
  end
end)
wifiWatcher:start()

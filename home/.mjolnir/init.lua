_ = require 'underscore'
application = require 'mjolnir.application'
hotkey = require 'mjolnir.hotkey'
local window = require 'mjolnir.window'
local alert = require 'mjolnir.alert'
grid = require 'mjolnir.bg.grid'

local utils = require 'utils'
local watcher = require 'layout'

grid.GRIDHEIGHT = 6
grid.GRIDWIDTH = 6
grid.MARGINX = 10
grid.MARGINY = 10

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
}

hotkey.bind(utils.modifier, 'return', function ()
  utils.setGrid('return', positions.full)
  local win = window.focusedwindow()
  local app = win:application()
  if string.match(app:title(), "iTerm") then
    win:movetounit({x=0, y=0, w=1, h=1})
  else
    local frame = win:screen():frame()
    win:setframe({x=frame.x + grid.MARGINX, y=frame.y + grid.MARGINY, w=frame.w - grid.MARGINX, h=frame.h - grid.MARGINY})
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

hotkey.bind(utils.modifier, '=', function ()
  grid.pushwindow_nextscreen()
end)

hotkey.bind(utils.modifier, '-', function ()
  grid.pushwindow_prevscreen()
end)

watcher.bind('Path Finder', { ['work_two'] = { ['Thunderbolt Display'] = positions.rightHalf }})
watcher.bind('iTerm',       {
  ['work_one'] = { ['Color LCD'] = positions.full },
  ['work_two'] = { ['Thunderbolt Display'] = positions.full },
})
watcher.bind('Dash',        { ['work_two'] = { ['Color LCD'] = positions.rightTwoThird }})
watcher.bind('Mailplane 3', {
  ['work_two'] = { ['Thunderbolt Display'] = positions.rightHalf },
  ['work_one'] = { ['Color LCD'] = positions.rightTwoThird },
})

watcher.bind('Slack', {
  ['work_two'] = { ['Color LCD'] = positions.rightTwoThird },
  ['work_one'] = { ['Color LCD'] = positions.rightTwoThird },
})
watcher.bind('Tweetbot',    {
  ['work_two'] = { ['Color LCD'] = positions.leftThird },
  ['work_one'] = { ['Color LCD'] = _.extend({w=grid.GRIDWIDTH / 4}, positions.leftThird) },
})

watcher.bind('iTunes', {
  ['work_two'] = { ['Color LCD'] = positions.full },
  ['work_one'] = { ['Color LCD'] = positions.full },
})

watcher.bind('Messages',    {
  ['work_two'] = { ['Color LCD'] = positions.upperRight },
  ['work_one'] = { ['Thunderbolt Display'] = positions.upperRight },
})

watcher.bind('Dash',    {
  ['work_two'] = { ['Color LCD'] = positions.rightTwoThird },
  ['work_one'] = { ['Thunderbolt Display'] = positions.rightHalf },
})

watcher.bind('Google Chrome', {
  ['work_one'] = { ['Color LCD'] = positions.full },
  ['work_two'] = { ['Color LCD'] = positions.full }
})

watcher.bind('Adobe Lightroom', {
  ['work_one'] = { ['Color LCD'] = positions.full },
  ['work_two'] = { ['Thunderbolt Display'] = positions.full }
})

hotkey.bind(utils.modifier, 'e', function ()
  watcher.doChanges()
end)

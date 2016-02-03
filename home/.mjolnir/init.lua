_ = require 'underscore'
application = require 'mjolnir.application'
hotkey = require 'mjolnir.hotkey'
window = require 'mjolnir.window'
grid = require 'mjolnir.bg.grid'

local utils = require 'utils'
local watcher = require 'layout'

grid.GRIDHEIGHT = 6
grid.GRIDWIDTH = 6
grid.MARGINX = 0
grid.MARGINY = 0

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

utils.setGrid('H', positions.leftHalf)
utils.setGrid('L', positions.rightHalf)
utils.setGrid('return', positions.full)
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
  ['work_two'] = { ['Color LCD'] = positions.upperRight }
})

watcher.bind('Google Chrome', {
  ['work_one'] = { ['Color LCD'] = positions.full },
  ['work_two'] = { ['Color LCD'] = positions.full }
})

hotkey.bind(utils.modifier, 'e', function ()
  watcher.doChanges()
end)

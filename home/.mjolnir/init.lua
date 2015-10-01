_ = require 'underscore'
application = require 'mjolnir.application'
hotkey = require 'mjolnir.hotkey'
window = require 'mjolnir.window'
grid = require 'mjolnir.bg.grid'
applescript = require 'mjolnir._asm.hydra.applescript'

local utils = require 'utils'
local watcher = require 'watcher'

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
watcher.bind('MacVim',      {
  ['work_two'] = { ['Thunderbolt Display'] = positions.rightHalf },
  ['work_one'] = { ['Color LCD'] = positions.full },
})
watcher.bind('iTerm',       {
  ['work_two'] = { ['Color LCD'] = positions.full },
  ['work_one'] = { ['Color LCD'] = positions.leftHalf },
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

function music()
  return {
    ['work_two'] = { ['Color LCD'] = positions.full },
    ['work_one'] = { ['Color LCD'] = positions.full },
  }
end

watcher.bind('Rdio', music())
watcher.bind('iTunes', music())
watcher.bind('Spotify', music())

watcher.bind('Messages',    {
  ['work_two'] = { ['Color LCD'] = positions.upperRight }
})

watcher.bind('Google Chrome', {
  ['work_one'] = { ['Color LCD'] = positions.full },
  ['work_two'] = {
    ['custom'] = function (layout, screen)
      chromesux('Default Profile')
      grid.set(window.focusedwindow(), positions.rightTwoThird, watcher.getScreens()[0])
      chromesux('Shopify')
      grid.set(window.focusedwindow(), positions.leftHalf, watcher.getScreens()[1])
    end
  }
})

-- Chrome profiles are totally inaccessible via applescript so UI scripting it is
function chromesux(profile)
  applescript([[tell application "Google Chrome" to activate
tell application "System Events"
  tell process "Google Chrome"
    tell menu bar 1
      tell menu bar item "People"
        tell menu "People"
          click menu item "]] ..profile.. [["
        end tell
      end tell
    end tell
  end tell
end tell]])
end


hotkey.bind(utils.modifier, 'e', function ()
  watcher.doChanges()
end)

function sleep(n)
  os.execute("sleep " .. tonumber(n))
end

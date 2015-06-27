local window = require 'mjolnir.window'
local hotkey = require 'mjolnir.hotkey'
local grid = require 'mjolnir.bg.grid'

utils = {}

utils.modifier = {'cmd', 'shift', 'ctrl'}

function utils.setGrid(key, cell)
  hotkey.bind(utils.modifier, key, function ()
    local win = window.focusedwindow()
    local screen = win:screen()
    grid.set(win, cell, screen)
  end)
end

function utils.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

return utils

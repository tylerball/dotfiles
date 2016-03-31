utils = {}

utils.modifier = {'cmd', 'shift', 'ctrl'}

function utils.setGrid(key, cell)
  hs.hotkey.bind(utils.modifier, key, function ()
    local win = hs.window.focusedWindow()
    local screen = win:screen()
    layout.setWindow(win, cell, screen)
  end)
end

function utils.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

return utils

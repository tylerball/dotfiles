local modifier = {'ctrl', 'option', 'cmd'}

hs.hotkey.bind(modifier, 'return', function ()
  os.execute('/usr/local/bin/mpc toggle')
end)

hs.hotkey.bind(modifier, 'right', function ()
  os.execute('/usr/local/bin/mpc next')
end)

hs.hotkey.bind(modifier, 'left', function ()
  os.execute('/usr/local/bin/mpc cdprev')
end)

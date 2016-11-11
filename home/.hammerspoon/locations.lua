local homeCallback = function ()
  print('homeCallback')
  if hs.wifi.currentNetwork() == 'DATA_5G' then
    os.execute("/sbin/mount_afp afp://tball@192.168.1.55/photos /Volumes/photos")
    print('mounted photos drive')
  end
end

hs.wifi.watcher.new(homeCallback):start()
hs.caffeinate.watcher.new(homeCallback):start()
homeCallback()

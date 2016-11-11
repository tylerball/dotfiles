package.path = "/usr/local/share/lua/5.2/?.lua;"..package.path
require 'layout'
require 'urls'
require 'apps'
require 'redshift'
require 'music'
require 'locations'

hs.settings.set('modifier', {'cmd', 'shift', 'ctrl'})
hs.settings.set('Redshift.temperature', 2700)
hs.settings.set('Redshift.fade', '1h')

hs.pathwatcher.new(hs.configdir .. '/', hs.reload):start()

hs.audiodevice.watcher.setCallback(function ()
  -- NEVER USE DISPLAY AUDIO
  if hs.audiodevice.current().name == 'Display Audio' and string.find(hs.wifi.currentNetwork(), 'Shopify') then
    hs.audiodevice.findDeviceByName('Built-in Output'):setDefaultOutputDevice()
    print('display audio prevented')
  end
end)
hs.audiodevice.watcher.start()

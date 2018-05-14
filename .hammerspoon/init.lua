require 'settings'
require 'layout'
require 'urls'
require 'apps'
require 'music'
require 'caffeine'
require 'battery'
require 'nightshift'

hs.loadSpoon('ControlEscape'):start()

hs.settings.set('modifier', {'cmd', 'shift', 'ctrl'})
hs.settings.set('NightShift:ignoredApps', {
  'Lightroom',
  'Adobe Premiere Pro CC 2015',
})

hs.pathwatcher.new(hs.configdir .. '/', hs.reload):start()

hs.audiodevice.watcher.setCallback(function ()
  -- NEVER USE DISPLAY AUDIO
  if hs.audiodevice.current().name == 'Display Audio' and string.find(hs.wifi.currentNetwork(), 'Shopify') then
    hs.audiodevice.findDeviceByName('Built-in Output'):setDefaultOutputDevice()
    print('display audio prevented')
  end
end)
hs.audiodevice.watcher.start()

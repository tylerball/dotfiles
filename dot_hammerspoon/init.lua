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
  if hs.audiodevice.findDeviceByName('FiiO USB DAC-E10') then
    hs.audiodevice.findOutputByName('FiiO USB DAC-E10'):setDefaultOutputDevice()
  end
end)
hs.audiodevice.watcher.start()

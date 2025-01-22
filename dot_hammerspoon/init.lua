require 'layout'

hs.loadSpoon('ControlEscape'):start()
hs.settings.set('modifier', {'cmd', 'shift', 'ctrl'})

hs.pathwatcher.new(hs.configdir .. '/', hs.reload):start()

hs.audiodevice.watcher.setCallback(function ()
  if hs.audiodevice.findDeviceByName('FiiO USB DAC-E10') then
    hs.audiodevice.findOutputByName('FiiO USB DAC-E10'):setDefaultOutputDevice()
  end
end)
hs.audiodevice.watcher.start()

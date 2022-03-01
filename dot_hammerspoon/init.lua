require 'settings'
require 'layout'
require 'apps'
require 'itunes'
require 'music'
require 'caffeine'
require 'battery'
require 'nightshift'

hs.loadSpoon('ControlEscape'):start()
local VimMode = hs.loadSpoon('VimMode')
local vim = VimMode:new()
vim
  :disableForApp('iTerm')
  :shouldDimScreenInNormalMode(false)
  :enterWithSequence('jk')

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

local ctrlDoublePress = require('doubletap')
ctrlDoublePress.timeFrame = 2
ctrlDoublePress.action = function()
  vim:setInsertMode()
end

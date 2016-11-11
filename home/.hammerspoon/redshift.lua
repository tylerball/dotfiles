-- Redshift menubar
local Redshift = {
  active = hs.settings.get('Redshift.active'),
  enabled = false,
  temperature = hs.settings.get('Redshift.temperature'),
  start = '20:00',
  stop = '07:00',
  fade = hs.settings.get('Redshift.fade'),
}

local ignoredApps = hs.window.filter.new(true)
ignoredApps:setAppFilter('Lightroom', {focused=true})
ignoredApps:setAppFilter('Adobe Premiere Pro CC 2015', {focused=true})

local function getTimezoneOffset()
  local now = os.time()
  local utcdate   = os.date('!*t', now)
  local localdate = os.date('*t', now)
  return os.difftime(os.time(localdate), os.time(utcdate)) / 3600
end

function Redshift:enable()
  hs.redshift.start(self.temperature, self.start, self.stop, self.fade, false, ignoredApps)
end

function Redshift:disable()
  hs.redshift.stop()
end

function Redshift:on()
  hs.settings.set('Redshift.active', true)
  self:enable()
  hs.alert.show('Redshift on', 1)
end

function Redshift:off()
  hs.settings.set('Redshift.active', false)
  self:disable()
  hs.alert.show('Redshift off', 1)
end

function Redshift:toggle()
  if hs.settings.get('Redshift.active') then
    self:off()
  else
    self:on()
  end
end

function Redshift:loadSunrise()
  hs.location.start()
  local location = hs.location.get()
  hs.location.stop()

  if not location then
    return
  end

  local lat, long = location['latitude'], location['longitude']
  local offset = getTimezoneOffset()
  local tomorrow = os.date('*t', os.time() + 86400)
  local sunset = os.date('%H:%M', hs.location.sunset(lat, long, offset) + hs.timer.hours(1))
  local sunrise = os.date('%H:%M', hs.location.sunrise(lat, long, offset, tomorrow))

  if self.start == sunset and self.stop == sunrise then
    return
  end

  self.start = sunset
  self.stop = sunrise

  if self.active then
    self:enable()
  end
end

function Redshift:update()
  self:loadSunrise()
end

hs.timer.doAfter(3, function()
  print("init redshift")
  Redshift:update()
  hs.timer.doAt('12:00', '1d', function() Redshift:update() end)

  hs.hotkey.bind(hs.settings.get('modifier'), 'r', function()
    Redshift:toggle()
    hs.timer.doAfter(hs.timer.hours(1), function () Redshift:enable() end)
  end)

  if hs.settings.get('Redshift.active') then Redshift:enable() else Redshift:disable() end
end)

return Redshift

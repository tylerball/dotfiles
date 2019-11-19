local NightShift = {}

local appwatcher = hs.application.watcher.new(function (name, eventtype)
  if hs.fnutils.contains(hs.settings.get('NightShift:ignoredApps'), name) then
    if eventtype == hs.application.watcher.activated then
      os.execute('/Users/tball/.bin/nshift 0')
    else
      if NightShift:afterSunset() then
        os.execute('/Users/tball/.bin/nshift ' .. hs.settings.get('NightShift:strength'))
      end
    end
  end
end)

logger = hs.logger.new('mine', 5)

function NightShift:afterSunset()
  hs.location.start()
  local location = hs.location.get()
  hs.location.stop()

  if not location then
    return
  end

  local lat, long = location['latitude'], location['longitude']
  local offset = NightShift:getTimezoneOffset()
  local tomorrow = os.date('*t', os.time() + 86400)
  local sunset = hs.location.sunset(lat, long, offset) + hs.timer.days(1)
  local sunrise = hs.location.sunrise(lat, long, offset, tomorrow)
  return os.time() > sunset and os.time() < sunrise
end

function NightShift:getTimezoneOffset()
  local now = os.time()
  local utcdate   = os.date('!*t', now)
  local localdate = os.date('*t', now)
  return os.difftime(os.time(localdate), os.time(utcdate)) / 3600
end

return NightShift

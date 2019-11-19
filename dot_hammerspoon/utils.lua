utils = {}

function utils.copy(t)
  local u = { }
  for k, v in pairs(t) do u[k] = v end
  return setmetatable(u, getmetatable(t))
end

function utils.extend(destination, source)
  for k,v in pairs(source) do
    destination[k] = v
  end
  return destination
end

function utils.dirname(str)
  if str:match(".-/.-") then
    local name = string.gsub(str, "(.*/)(.*)", "%1")
    return name
  else
    return ''
  end
end

return utils

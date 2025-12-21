
function error(msg)
  print("[ERROR] " .. msg)
  return nil
end

function printtable(t, sep, keys, values)
  local str = ""
  sep = sep or " "
  keys = keys or 0
  values = values or 1
  for k, v in pairs(t) do
    if keys == 1 then str = str..tostring(k) end
    if keys == 1 and values == 1 then str = str.."=" end
    if values == 1 then str = str..tostring(v) end
    str = str..sep
  end
  print(str)
end


FileReader = { f = nil }
FileReader.__index = FileReader

function FileReader.new(file)
  local it = io.open(file, "r")
  if not it then return error("File not found") end
  local self = setmetatable({ f = it }, FileReader)
  return self:init()
end

function FileReader:init()
  self.read = function(self, x) return self.f:read(x) end
  self.lines = function(self) return self.f:lines() end
  return self
end

function FileReader:close()
  self.f:close()
  self.f = nil
end


answer = 0
reader = {}
function Run(func, input)
  reader = FileReader.new(input)
  answer = 0
  func()
  print(answer)
  reader:close()
end

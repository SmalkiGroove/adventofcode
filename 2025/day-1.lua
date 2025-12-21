dofile("utils.lua")

function get(input)
  local sens, amount = input:match("(%a)(%d+)")
  if sens == "R" then return tonumber(amount) end
  if sens == "L" then return -tonumber(amount) end
  return error("Invalid entry "..input)
end

function part1()
  local value = 50
  for line in reader:lines() do
    value = value + get(line)
    if value % 100 == 0 then
      answer = answer + 1
    end
  end
end

function part2()
  local value = 50
  for line in reader:lines() do
    local amount = get(line)
    local next = value + amount
    local lower, higher = math.min(value+1, next), math.max(value-1, next)
    for i=lower,higher do
      if i % 100 == 0 then answer = answer + 1 end
    end
    value = next
  end
end

Run(part1, "input-1.txt")
Run(part2, "input-1.txt")

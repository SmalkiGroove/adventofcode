dofile("utils.lua")

function parse()
  local x, y = 0, 0
  local grid = {}
  for line in reader:lines() do
    x, y = 0, y+1
    grid[y] = {}
    for c in line:gmatch(".") do
      x = x+1
      grid[y][x] = (c == '@' and 1 or 0)
    end
  end
  return grid
end

function get(grid, x, y, i)
  if not grid[y] then grid[y] = {} end
  if not grid[y][x] then grid[y][x] = 0 end
  if i and grid[y][x] < 0 then
    if grid[y][x] == -i then return 1 end
    if grid[y][x] > -i then grid[y][x] = 0 return 0 end
    if grid[y][x] < -i then return error("Invalid value "..grid[y][x].." at x="..x..", y="..y..", iter="..i) end
  end
  return grid[y][x]
end

function part1()
  local grid = parse()
  for y=1,#grid do for x=1,#grid[y] do
    if get(grid, x, y) == 1 then
      local adjacent = 0
      for i=-1,1 do for j=-1,1 do
        if i ~= 0 or j ~= 0 then
          adjacent = adjacent + get(grid, x+i, y+j)
        end
      end end
      if adjacent < 4 then answer = answer + 1 end
    end
  end end
end


function part2()
  local grid = parse()
  local iter, found = 0, 0
  repeat
    iter, found = iter+1, 0
    for y=1,#grid do for x=1,#grid[y] do
      if get(grid, x, y) == 1 then
        local adjacent = 0
        for i=-1,1 do for j=-1,1 do
          if i ~= 0 or j ~= 0 then
            adjacent = adjacent + get(grid, x+i, y+j, iter)
          end
        end end
        if adjacent < 4 then
          found = found + 1
          grid[y][x] = -iter
        end
      end
    end end
    answer = answer + found
    --print(iter, found)
  until found == 0
end

Run(part1, "input-4.txt")
Run(part2, "input-4.txt")

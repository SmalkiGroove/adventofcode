dofile("utils.lua")

function parse()
    local boxes = {}
    for line in reader:lines() do
        local x, y, z = line:match("(%d+),(%d+),(%d+)")
        table.insert(boxes, {x=tonumber(x), y=tonumber(y), z=tonumber(z)})
    end
    return boxes
end

function distance(b1, b2)
    local dx = b1.x - b2.x
    local dy = b1.y - b2.y
    local dz = b1.z - b2.z
    return dx * dx + dy * dy + dz * dz
end

function table_size(t)
    local size = 0
    for k, v in pairs(t) do if v ~= nil then size = size + 1 end end
    return size
end

function table_min(t)
    local min = 0
    for k, v in pairs(t) do
        if v ~= nil then
            if min == 0 or k < min then min = k end
        end
    end
    return min
end

function table_merge(t1, t2)
    local merged = {}
    for k, v in pairs(t1) do merged[k] = v end
    for k, v in pairs(t2) do merged[k] = v end
    return merged
end

function extract(boxes)
    local boxes_mem = {}
    local circuits = {}
    local distances = {}
    for i, box in ipairs(boxes) do
        for j, other in ipairs(boxes_mem) do
            if i ~= j then
                local dist = distance(box, other)
                distances[dist] = {i, j}
            end
        end
        boxes_mem[i] = box
        table.insert(circuits, {[i] = true})
    end
    return circuits, distances
end

function part1()
    local boxes = parse()
    local circuits, distances = extract(boxes)
    for z=1, 1000 do
        local d = table_min(distances)
        local found = {}
        for c, _ in ipairs(circuits) do
            if circuits[c][distances[d][1]] then found[1] = c end
            if circuits[c][distances[d][2]] then found[2] = c end
        end
        if found[1] ~= found[2] then
            circuits[found[1]] = table_merge(circuits[found[1]], circuits[found[2]])
            circuits[found[2]] = {}
        end
        distances[d] = nil
    end
    local c1, c2, c3 = 0, 0, 0
    for i, c in ipairs(circuits) do
        local n = table_size(c)
        if n >= c3 then c3 = n end
        if n >= c2 then c2, c3 = n, c2 end
        if n >= c1 then c1, c2 = n, c1 end
    end
    answer = c1 * c2 * c3
end

function part2()
    local boxes = parse()
    local circuits, distances = extract(boxes)
    local d, size = 0, 0
    repeat
        d = table_min(distances)
        local i, j = distances[d][1], distances[d][2]
        local found = {}
        for c, _ in ipairs(circuits) do
            if circuits[c][i] then found[1] = c end
            if circuits[c][j] then found[2] = c end
        end
        if found[1] ~= found[2] then
            circuits[found[1]] = table_merge(circuits[found[1]], circuits[found[2]])
            circuits[found[2]] = {}
            size = table_size(circuits[found[1]])
        end
        distances[d] = nil
        answer = boxes[i].x * boxes[j].x
    until size == 1000 or d == 0
end

Run(part1, "input-8.txt")
Run(part2, "input-8.txt")

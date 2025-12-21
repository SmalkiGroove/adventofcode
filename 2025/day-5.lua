dofile("utils.lua")

function parse()
    local fresh = {}
    for line in reader:lines() do
        local a,b = line:match("(%d+)-(%d+)")
        if a and b then
            a,b = tonumber(a),tonumber(b)
            if fresh[a] then
                fresh[a] = math.max(fresh[a], b)
            else
                fresh[a] = b
            end
        else break end
    end
    return fresh
end

function within(n, a, b)
    return (n >= a) and (n <= b)
end

function part1()
    local fresh = parse()
    for line in reader:lines() do
        local n = line:match("(%d+)")
        if n then
            n = tonumber(n)
            for a,b in pairs(fresh) do
                if within(n, a, b) then
                    --print(n.." is in range "..a.."-"..b)
                    answer = answer + 1
                    break
                end
            end
        end
    end
end

function part2()
    local fresh = parse()
    local combined = {}
    local min, max = 0, 0
    local counter, remain = 0, 0
    repeat
        counter = counter + 1
        for a,b in pairs(fresh) do
            if b then
                if min == 0 or a < min then min, max = a, b end
            end
        end
        fresh[min] = nil
        local range = {a=min, b=max}
        repeat
            max = range.b
            for a,b in pairs(fresh) do
                if b then
                    if within(a, range.a, range.b) then range.b = math.max(b, range.b) end
                end
            end
        until max == range.b
        remain = 0
        for a,b in pairs(fresh) do
            if b then
                if within(a, range.a, range.b) and within(b, range.a, range.b) then
                    fresh[a] = nil
                else
                    remain = remain + 1
                end
            end
        end
        --print(counter.."] "..range.a.."-"..range.b)
        combined[counter] = range
        min, max = 0, 0
    until remain == 0
    for i,range in ipairs(combined) do
        answer = answer + 1 + (range.b-range.a)
    end
end

--Run(part1, "input-5.txt")
Run(part2, "input-5.txt")

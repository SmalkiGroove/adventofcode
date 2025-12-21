dofile("utils.lua")

function parse()
    local input = reader:read("*all")
    local id_ranges = {}
    for k, v in string.gmatch(input, "(%d+)-(%d+)") do
        table.insert(id_ranges, {tonumber(k), tonumber(v)})
    end
    return id_ranges
end

function part1()
    local id_ranges = parse()
    for i=1, #id_ranges do
        for j=id_ranges[i][1], id_ranges[i][2] do
            local number = tostring(j)
            local digits = string.len(number)
            if digits % 2 == 0 then
                local first = string.sub(number, 1, digits/2)
                local second = string.sub(number, digits/2+1, digits)
                if first == second then
                    answer = answer + j
                end
            end
        end
    end
end

function part2()
    local id_ranges = parse()
    for i=1, #id_ranges do
        for j=id_ranges[i][1], id_ranges[i][2] do
            local number = tostring(j)
            local digits = string.len(number)
            for k=1, math.floor(digits/2) do
                if digits % k == 0 then
                    local repetitions = digits / k
                    local sub = string.sub(number, 1, k)
                    local test = ""
                    for r=1, repetitions do
                        test = test..sub
                    end
                    if test == number then
                        answer = answer + j
                        break
                    end
                end
            end
        end
    end
end

Run(part1, "input-2.txt")
Run(part2, "input-2.txt")

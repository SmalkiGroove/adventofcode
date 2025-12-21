dofile("utils.lua")

function add(numbers)
    local result = 0
    for _, x in ipairs(numbers) do result = result + x end
    return result
end

function mult(numbers)
    local result = 1
    for _, x in ipairs(numbers) do result = result * x end
    return result
end

function part1()
    local problems = {}
    for line in reader:lines() do
        local index = 0
        for x in line:gmatch("[^%s]+") do
            index = index + 1
            if not problems[index] then problems[index] = {} end
            if x == '+' then problems[index].calc = add
            elseif x == '*' then problems[index].calc = mult
            else table.insert(problems[index], tonumber(x))
            end
        end
    end
    for _, pb in pairs(problems) do
        answer = answer + pb.calc(pb)
    end
end

function part2()
    local reversed = {}
    local line_nb = 0
    local line_size = 3753
    for line in reader:lines() do
        line_nb = line_nb + 1
        for i = 1, line_size do
            if not reversed[i] then reversed[i] = {} end
            reversed[i][line_nb] = line:sub(i, i)
        end
    end
    local problems = {}
    local index = 0
    local next = function()
        index = index + 1
        problems[index] = {}
    end
    next()
    for i = line_size, 1, -1 do
        local n = 0
        for _, x in pairs(reversed[i]) do
            if x:match("%d") then n = 10 * n + tonumber(x)
            elseif x == '+' then problems[index].calc = add
            elseif x == '*' then problems[index].calc = mult
            end
        end
        if n == 0 then if problems[index].calc then next() end
        else table.insert(problems[index], n)
        end
    end
    for _, pb in pairs(problems) do
        --print(pb[1], pb[2], pb[3], pb[4], pb.calc == add and "add" or "mult")
        answer = answer + pb.calc(pb)
    end
end

Run(part1, "input-6.txt")
Run(part2, "input-6.txt")

dofile("utils.lua")

function part1()
    local beam = {[0]={}}
    local counter = 0
    local splitbeam = function(x, y)
        beam[y][x] = nil
        beam[y][x-1] = true
        beam[y][x+1] = true
        beam[y+1][x-1] = true
        beam[y+1][x+1] = true
        answer = answer + 1
    end
    for line in reader:lines() do
        local next = counter + 1
        beam[next] = {}
        for i=1, #line do
            local x = line:sub(i,i)
            if x == "S" then beam[counter][i] = true; beam[next][i] = true
            elseif beam[counter][i] then
                if x == "." then beam[next][i] = true
                elseif x == "^" then splitbeam(i, counter)
                end
            end
        end
        --printtable(beam[counter], " ", 1, 0)
        counter = next
    end
end

function part2()
    answer = 1
    local beam = {[0]={}}
    local counter = 0
    local splitbeam = function(x, y)
        local amount = beam[y][x]
        beam[y][x] = nil
        beam[y][x-1] = (beam[y][x-1] or 0) + amount
        beam[y][x+1] = (beam[y][x+1] or 0) + amount
        beam[y+1][x-1] = (beam[y+1][x-1] or 0) + amount
        beam[y+1][x+1] = (beam[y+1][x+1] or 0) + amount
        answer = answer + amount
    end
    for line in reader:lines() do
        local next = counter + 1
        beam[next] = {}
        for i=1, #line do
            local x = line:sub(i,i)
            if x == "S" then beam[counter][i] = 1; beam[next][i] = 1
            elseif beam[counter][i] and beam[counter][i] > 0 then
                if x == "." then beam[next][i] = beam[counter][i]
                elseif x == "^" then splitbeam(i, counter)
                end
            end
        end
        --printtable(beam[counter], " ", 1, 0)
        counter = next
    end
end

Run(part1, "input-7.txt")
Run(part2, "input-7.txt")

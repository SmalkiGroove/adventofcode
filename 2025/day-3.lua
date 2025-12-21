dofile("utils.lua")

bank = 100

function get(input, i)
    return tonumber(string.sub(input, bank-i, bank-i))
end

function part1()
    local counter = 0
    for line in reader:lines() do
        counter = counter + 1
        local n1 = 0
        local n2 = get(line, 0)
        for i=1, bank-1 do
            local n = get(line, i)
            if n >= n1 then n1, n2 = n, math.max(n1,n2) end
        end
        answer = answer + (10 * n1 + n2)
        --print(counter.." => "..n1..n2)
    end
end

function part2()
    local counter = 0
    for line in reader:lines() do
        counter = counter + 1
        local digits = {}
        for i=0, bank-1 do
            local n = get(line, i)
            if i < 12 then
                digits[i] = n
            else
                if n >= digits[11] then
                    local tmp_digits = {[11]=n}
                    local tmp_up = 11
                    for j=1, 11 do
                        if (tmp_up == 12-j) and (digits[12-j] >= digits[11-j]) then
                            tmp_digits[11-j] = digits[12-j]
                            tmp_up = 11-j
                        else
                            tmp_digits[11-j] = digits[11-j]
                        end
                    end
                    digits = tmp_digits
                end
            end
        end
        for j=0,11 do answer = answer + digits[j] * math.pow(10, j) end
        --print(counter.." => "..digits[11]..digits[10]..digits[9]..digits[8]..digits[7]..digits[6]..digits[5]..digits[4]..digits[3]..digits[2]..digits[1]..digits[0])
    end
    answer = math.floor(answer)
end

Run(part1, "input-3.txt")
Run(part2, "input-3.txt")

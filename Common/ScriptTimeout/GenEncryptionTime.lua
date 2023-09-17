-- º”√‹
function genRandomNum()
    while true do
        local tmp = math.random(1, 9999)
        if tmp < 2304 or tmp > 3249 then
            return tmp
        end
    end
end

function EncryptionTime()
    local templateList = {
        [1] = 49,  -- 2401
        [2] = 50,   -- 2500
        [3] = 51,   -- 2601
        [4] = 52,   -- 2704
        [5] = 53,   -- 2809
        [6] = 54,   -- 2916
        [7] = 55,   -- 3025
        [8] = 56,   -- 3136
        [9] = 57,   -- 3249
        [10] = 48   -- 2304
    }
    local resultList = {}
    local targetTime = { 2, 0, 2, 3, 1, 0, 3, 1 }
    table.insert(resultList, genRandomNum())
    for i = 1, #targetTime do
        if targetTime[i] == 0 then
            local ascii_v = templateList[10]
            table.insert(resultList, ascii_v * ascii_v)
        else
            local ascii_v = templateList[targetTime[i]]
            table.insert(resultList, ascii_v*ascii_v)
        end
        for j = 1, math.random(1, 2) do
            table.insert(resultList, genRandomNum())
        end
    end

    --print
    local ttt = '{'
    for i = 1, #resultList do
        if i == 1 then
            ttt = ttt .. tostring(resultList[i])
        else
            ttt = ttt .. ', ' .. tostring(resultList[i])
        end
    end
    ttt = ttt .. '}'
    print(ttt)
end

EncryptionTime()
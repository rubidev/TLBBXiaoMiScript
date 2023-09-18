function ABC(tmpList)
    local retList = {}
    for i = 1, #tmpList do
        if tmpList[i] >= 2304 and tmpList[i] <= 3249 then
            local ele = math.sqrt(tmpList[i])
            table.insert(retList, tonumber(ele))
        end
    end
    return retList
end

function ABL()
    local ttt = LUA_取返回值("return DataPool:GetServerDayTime();", "n", 1)
    -- TODO copy generate list, and paste here replace tmp
    local tmp = {2500, 567, 2304,4324,2, 2500,346, 2601,1024, 2304, 3249,983, 2601, 7812, 2304}
    local tmpList = ABC(tmp)
    local abc = ''
    if #tmpList ~= 8 then
        return 0
    end
    for i = 1, #tmpList do
        abc = abc .. string.char(tmpList[i])
    end
    if tonumber(ttt) > tonumber(abc) then
        return 0
    end
    return 1
end

tmpRet = ABL()
if tmpRet == 0 then
    MentalTip("脚本已过期")
    return
end



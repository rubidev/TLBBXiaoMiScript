function ABC(tmpList)
    local retList = {}
    for i = 1, #tmpList do
        if tmpList[i] >= 2304 and tmpList[i] <= 3249 then
            print(tmpList[i])
            local ele = math.sqrt(tmpList[i])
            table.insert(retList, tonumber(ele))
        end
    end
    return retList
end

ret = ABC(
    {8640, 2500, 8352, 2304, 3476, 2223, 2500, 5410, 2601, 4753, 2401, 467, 2304, 4802, 2601, 5047, 2401, 8744, 7388}
)
print('-------')
print(#ret)

str = ''
for i = 1, #ret do
    print(ret[i])
    str = str .. string.char(ret[i])
end
print(str)
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
    {4755, 2500, 5951, 9586, 2304, 6295, 2500, 4039, 2601, 7090, 7512, 2401, 5838, 3940, 2401, 3980, 9854, 2401, 1697, 5059, 2809, 1687}
)
print('-------')
print(#ret)

str = ''
for i = 1, #ret do
    print(ret[i])
    str = str .. string.char(ret[i])
end
print(str)
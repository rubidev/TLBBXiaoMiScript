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
    {6339, 2500, 9102, 5660, 2304, 1452, 8994, 2500, 5923, 2601, 5584, 6559, 2401, 5817, 2401, 3337, 2401, 6283, 2809, 1824}
)
print('-------')
print(#ret)

str = ''
for i = 1, #ret do
    print(ret[i])
    str = str .. string.char(ret[i])
end
print(str)
保留的名单 = {"花影っ", "凛凛寒风ヤ", "姜姒．", "樱╭ァ小染", "キ倾城つ", "｀折枝〃"}

roleName = 获取人物信息(12)

saveMatched = 0
for k, v in pairs(保留的名单) do
    if v == roleName then
        saveMatched = 1
        break
    end
end

if saveMatched ~= 1 then
    取出物品("福降令")
    延时(1000)
    自动清包("福降令")
end
神兵天降礼盒选择 = "命魂玉"

function UseSBTJGift()
    local SBTJGiftCount = 获取背包物品数量("神兵天降礼盒")
    for i = 1, SBTJGiftCount do
        右键使用物品("神兵天降礼盒")
        延时(1000)
        local SBTJGift = { '玄兵石', '命魂玉', '伏羲玉' }
        for index, val in pairs(SBTJGift) do
            if string.find(神兵天降礼盒选择, val) then
                LUA_Call(string.format([[setmetatable(_G, {__index = OptionalGiftBox_Three_Env});OptionalGiftBox_Three_OnItemClicked(%d)]], index))
                延时(1000)
                LUA_Call([[setmetatable(_G, {__index = OptionalGiftBox_Three_Env});OptionalGiftBox_Three_OnGetClicked()]])
                break
            end
        end
        延时(200)
    end
end

-- main --------------------------------------
UseSBTJGift()

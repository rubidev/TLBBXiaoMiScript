function TXPLevelUp()
    对话NPC("XXX")  -- TODO
    延时(1000)
    NPC二级对话("升级", 0)  -- TODO
    延时(1000)

    for i = 1, 3 do
        LUA_Call(string.format([[setmetatable(_G, {__index = Armor_Upgrade_Env});Armor_Upgrade_Choose_ItemClicked(%d);]], i))
        延时(1000)
        for i = 1, 10 do
            LUA_Call([[setmetatable(_G, {__index = Armor_Upgrade_Env});Armor_Upgrade_OKClicked();]])
            延时(300)
        end
        延时(1000)
    end
end

function TXPShengJie()
    对话NPC("XXX")  -- TODO
    延时(1000)
    NPC二级对话("提升品质", 0)  -- TODO
    延时(1000)

    for i = 1, 3 do
        LUA_Call(string.format([[setmetatable(_G, {__index = Armor_Upstage_Env});Armor_Upstage_Choose_ItemClicked(%d);]], i))
        延时(1000)
        LUA_Call([[setmetatable(_G, {__index = Armor_Upstage_Env});Armor_Upstage_OKClicked();]])
        延时(500)
    end
end

function TXPUpStars()
    对话NPC("XXX")  -- TODO
    延时(1000)
    NPC二级对话("提升星级", 0)  -- TODO
    延时(1000)

    for i = 1, 3 do
        LUA_Call(string.format([[setmetatable(_G, {__index = Armor_Upstars_Env});Armor_Upstars_Choose_ItemClicked(%d);]], i))
        延时(1000)
        for i = 1, 10 do
            LUA_Call([[setmetatable(_G, {__index = Armor_Upstars_Env});Armor_Upstars_OKClicked();]])
        end
    end
end

function main()
    取出物品("")  -- TODO 取出升级、升星、升阶材料
    取出物品("金币")
    跨图寻路("凤鸣镇", 1, 2)
    延时(2000)
    右键使用物品("")  -- TODO

    TXPLevelUp()
    延时(1000)
    TXPShengJie()
    延时(1000)
    TXPUpStars()
end

-- 执行 ---------------------------------------
main()

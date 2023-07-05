fuckItem = {
    [1] = { name = "润魂石·击", perPrice = 0.1, nType = 2 },
    [2] = { name = "击·苍玄属性书", perPrice = 0.1, nType = 2 }
}
-- perPrice： 物品单价
-- nType: 上方3个选择：物品市场、珍兽市场、装备市场： 2 is item, 1 is pet, 3 is equip

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function SearchItem(nSubType, strKey)
    -- 搜索物品
    -- TODO 确认nSubType为1是否为不选择子菜单搜索
    LUA_Call(string.format([[
        Auction:PacketSend_Search(2, %d, 1, "%s", 1)
    ]], nSubType, strKey), "s", 1)
    延时(2000)
end

function GetItemPerPrice(strKey, perPrice)
    -- 获取当前页每个物品信息
    local itemPerPrice = LUA_取返回值(string.format([[
        local itemName = "%s"
        local targetPerPrice = %f
        for i = 0, 9 do
            local pName , pSeller ,pCount ,pYB = Auction:GetItemAuctionInfo(i)
            if pName == itemName and pSeller ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
                local perPrice = pYB / pCount
                if perPrice <= targetPerPrice then

                end
            end
        end
    ]], strKey, perPrice), "s", 1)
end

function main()
    MentalTip('前往钱庄元宝市场抢低价物品')
    if tonumber(获取人物信息(46)) <= 0 then
        MentalTip("元宝不足, 退出")
        return
    end
    跨图寻路("钱庄", 60, 30);
    延时(500)
    对话NPC("孙聚财");
    延时(500)
    NPC二级对话("元宝交易市场", 1);
    延时(1000)
    if 窗口是否出现("YbMarket") == 1 then
        for i = 1, #fuckItem do
            local itemType = fuckItem[i].nType
            SearchItem(itemType, fuckItem[i].name)
            延时(500)


        end
    end


end
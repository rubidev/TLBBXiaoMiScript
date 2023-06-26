function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function BuyTLZByHongLi()
    local start = 0
    local needBuyCount = 1
    while start < needBuyCount do
        LUA_Call([[setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();]])  -- 打开YB商店
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);]])  -- 切到红利商店
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);]])  -- 切到珍兽商城
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(2);]])  -- 切到奇珍异宝
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();]]) -- 下一页
        延时(500)

        local queRenGouMaiStatus = LUA_取返回值([[return NpcShop:GetBuyDirectly()]])
        local clicked = false
        if tonumber(queRenGouMaiStatus) == 0 then
            -- 0表示勾选购买确认，会弹出确认框，这里要取消勾选
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
            clicked = true
        end

        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);]])  -- 购买土灵珠
        延时(500)
        if clicked then
            -- 购买确认按钮恢复原状
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
        end
        start = start + 1
    end

    LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();]])

end

function BuyTLZByBindYB()
    local start = 0
    local needBuyCount = 1
    while start < needBuyCount do
        LUA_Call([[setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();]])  -- 打开YB商店
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);]])  -- 切到绑定元宝
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);]])  -- 切到珍兽商城
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(2);]]) -- 切到奇珍异宝
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();]]) -- 下一页
        延时(500)

        local queRenGouMaiStatus = LUA_取返回值([[return NpcShop:GetBuyDirectly()]])
        local clicked = false
        if tonumber(queRenGouMaiStatus) == 0 then
            -- 0表示勾选购买确认，会弹出确认框，这里要取消勾选
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
            clicked = true
        end

        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);]])  -- 购买土灵珠
        延时(500)
        if clicked then
            -- 购买确认按钮恢复原状
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
        end
        start = start + 1
    end

    LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();]])

end

function BuyTLZByZhanGong()
    -- 领取战功, 购买所有土灵珠
    -- 必须打开帮会界面，切换过才能获取帮会信息
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Hygl_Env});NewBangHui_Hygl_Bhxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Bhxx_Env});NewBangHui_Bhxx_Tmxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Tmxx_Env});NewBangHui_Tmxx_Closed();]])

    坐骑_下坐骑()

    local myGuildCityName = LUA_取返回值([[
       local guildID, clanID = DataPool:GetGuildClanID()
       local myCityName = Guild:GetMyGuildDetailInfo("CityName")
       PushDebugMessage("myCityName: " .. myCityName)
       return myCityName
   ]])

    if tonumber(myGuildCityName) == -1 then
        MentalTip("脚本检索帮会失败, 使用绑定元宝购买定位")
        return
    end

    local inBangHui = 0
    local curCityName = 获取人物信息(16)
    if curCityName == "苏州" then
        坐骑_上坐骑()
        while true do
            跨图寻路("苏州", 322, 264)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 322 and tonumber(myY) == 264 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯粹")
    elseif curCityName == "大理" then
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯礼")
    elseif curCityName == "洛阳" then
        坐骑_上坐骑()
        while true do
            跨图寻路("洛阳", 237, 236)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 237 and tonumber(myY) == 236 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯仁")
    elseif curCityName == "楼兰" then
        坐骑_上坐骑()
        while true do
            跨图寻路("楼兰", 190, 130)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 190 and tonumber(myY) == 130 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯祐")
    elseif curCityName == myGuildCityName then
        inBangHui = 1
        坐骑_上坐骑()
    else
        执行功能("大理回城")
        延时(3000)
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(3000)
        对话NPC("范纯礼")
    end

    if inBangHui == 0 then
        延时(500)
        NPC二级对话("进入本帮城市")
        等待过图完毕()
        延时(3000)
    end

    while true do
        local curMap = 获取人物信息(16)
        if curMap == myGuildCityName then
            延时(2000)
            break
        end
        延时(1000)
    end

    while true do
        跨图寻路(myGuildCityName, 94, 55)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == 94 and tonumber(myY) == 55 then
            break
        end

    end
    延时(2000)

    执行功能("领取战功")
    延时(2000)

    对话NPC("赵子勋")
    延时(500)
    NPC二级对话("战功商店")
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = JueweiShop_Env});JueweiShop_MultiBuyItem();]]) -- 批量购买
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = JueweiShop_Env});JueweiShop_BuyItem(8);]])  -- 土灵珠
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NEWShop_MBuy_Env});NEWShop_MBuy_MaxButtonDwon()]])  -- 最大
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NEWShop_MBuy_Env});NEWShop_MBuy_BuyMulti_Clicked();]])  -- 确认购买
end

function main()
    MentalTip("功能: 取出、购买土灵珠, 确保背包中有1个土灵珠")

    local backpackTLZCount = tonumber(获取背包物品数量("土灵珠"))
    -- 仓库中取出土灵珠
    if backpackTLZCount < 1 then
        MentalTip("锦囊、仓库中取出土灵珠")
        取出物品("土灵珠", 1 - backpackTLZCount)
    else
        MentalTip("背包已有1个土灵珠")
        return
    end

    延时(2000)
    -- 不够，用战功买
    backpackTLZCount = tonumber(获取背包物品数量("土灵珠"))
    if backpackTLZCount < 1 then
        MentalTip("使用战功购买土灵珠，购买最大数量")
        BuyTLZByZhanGong()
    else
        MentalTip("背包已有1个土灵珠")
        return
    end

    延时(2000)
    -- 不够，用绑定元宝买
    backpackTLZCount = tonumber(获取背包物品数量("土灵珠"))
    if backpackTLZCount < 1 then
        MentalTip("战功购买土灵珠失败, 使用绑定元宝购买1个")
        BuyTLZByBindYB()
    else
        MentalTip("背包已有1个土灵珠")
        return
    end

    延时(2000)
    -- 不够，用红利买
    backpackTLZCount = tonumber(获取背包物品数量("土灵珠"))
    if backpackTLZCount < 1 then
        MentalTip("绑定元宝购买土灵珠失败, 使用红利购买1个")
        BuyTLZByHongLi()
    else
        MentalTip("背包已有1个土灵珠")
        return
    end

end


-- 执行脚本
main()
function BackToBangHui()
    -- 必须打开帮会界面，切换过才能获取帮会信息
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Hygl_Env});NewBangHui_Hygl_Bhxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Bhxx_Env});NewBangHui_Bhxx_Tmxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Tmxx_Env});NewBangHui_Tmxx_Closed();]])

    坐骑_下坐骑()

    myGuildCityName = LUA_取返回值([[
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
end

function GoToLingPaiNPC()
    while true do
        跨图寻路(myGuildCityName, 45, 46)
        延时(2000)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == 45 and tonumber(myY) == 46 then
            break
        end
    end
end

function BaoZhuShengJi(row, col)
    对话NPC("孔相如")
    延时(1000)
    NPC二级对话("四象宝珠打造与升级")
    延时(2000)
    LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))  -- 右键点击令牌, row col可知位置
    延时(500)
    for i = 1, 4 do
        LUA_Call(string.format([[setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(%d)]], i))  -- 循环选择4条属性中的
        延时(500)
        for j = 1, 50 do
            MentalTip(string.format([[尝试升级第%d颗宝珠, 第%d次]], i, j))
            LUA_Call([[setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked()]])  -- 点击升级, 每个属性点20下
            延时(110)
        end
    end
    延时(2000)
    LUA_Call([[setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnCloseClicked()]]) --关闭升级窗口
    延时(500)
    MentalTip("宝珠升级完成！")
    LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))  -- 装备上令牌
end

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【战为不负卿】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function main()
    MentalTip("对霸王令进行宝珠升级")

    -- 打开人物界面
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_SelfEquip_Clicked();]])
    延时(500)
    -- 下令牌
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click( 16,0 );]])
    延时(500)
    -- 关闭界面
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();]])

    延时(2000)

    local BWLLocation = 获取背包物品位置("霸王令")
    if BWLLocation < 1 then
        return
    end

    local row = math.floor(tonumber(BWLLocation) / 10)
    local col = math.floor(tonumber(BWLLocation) % 10)
    if col == 0 then
        col = 10
    else
        row = row + 1
    end

    取出物品("翡翠心精")
    延时(500)
    取出物品("翡翠心精礼盒")

	local FCXJCount = 获取背包物品数量("翡翠心精礼包")
	for i=1, tonumber(FCXJCount) do
        右键使用物品("翡翠心精礼包")
		延时(100)
    end

    BackToBangHui()
    延时(1000)
    GoToLingPaiNPC()
    延时(2000)
    BaoZhuShengJi(row, col)

end



main()




















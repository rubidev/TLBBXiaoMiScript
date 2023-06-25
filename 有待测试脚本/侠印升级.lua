function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetHXYLevel()
    local HXYLevel = LUA_取返回值([[
		local ActionHXY = EnumAction(21,"equip")
		if ActionHXY and ActionHXY:GetID() ~= 0 then
			local nEquipLevel = DataPool:Lua_GetHXYLevel()
			return  nEquipLevel
		else
			return 0
		end
	]])
    return tonumber(HXYLevel)
end

function GetJianMianLevel(effectIndex)
    -- JMIndex 为 0~6
    local effectLevel = LUA_取返回值(string.format([[
		local effectIndex = %d
		local nIndex , iEffectLevel, iCost , iNeedHXYLevel , iValue = DataPool:Lua_GetHXYEffect( effectIndex )
		if nIndex ~= nil then
			return iEffectLevel
		end
		return -1
	]], effectIndex))
    return tonumber(effectLevel)
end

function GetGongXun()
    local gongXun = LUA_取返回值([[
		return Player:GetData( "MILITARYXIUWEI" );
	]])
    return tonumber(gongXun)
end

function GetHXYLevelUpCost()
    -- 侠印升级所需豪侠勋章数量
    local nUpgradeCost = LUA_Call([[
		local nUpgradeCost = DataPool:Lua_GetHXYUpgradeCost(  )
		return nUpgradeCost
	]])
    return tonumber(nUpgradeCost)
end

function BuyHAYMaterial(itemIndex)
    -- 领取战功, 购买物品
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
        MentalTip("脚本检索帮会失败")
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
    LUA_Call(string.format([[setmetatable(_G, {__index = JueweiShop_Env});JueweiShop_BuyItem(%d);]], itemIndex))
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NEWShop_MBuy_Env});NEWShop_MBuy_MaxButtonDwon()]])  -- 最大
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NEWShop_MBuy_Env});NEWShop_MBuy_BuyMulti_Clicked();]])  -- 确认购买
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NEWShop_MBuy_Env});JueweiShop_OnHiden();]])  -- TODO 关闭战功商店
end

function HXYLeveUp()
    LUA_Call([[
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name( "HXY_LevelUp" )
			Set_XSCRIPT_ScriptID( 880006 )
			Set_XSCRIPT_ParamCount( 0 );
		Send_XSCRIPT();
	]])
end

function HXYEffectLevelUp(effectIndex)
    local ret = LUA_取返回值(string.format([[
        local effectIndex = %d
        local myGongXun = Player:GetData( "MILITARYXIUWEI" )
        local nIndex , iEffectLevel, iCost , iNeedHXYLevel , iValue = DataPool:Lua_GetHXYEffect( effectIndex )
		if nIndex ~= nil then
		    if iEffectLevel < 20 and myGongXun > iCost then
		        -- PushDebugMessage("")
                Clear_XSCRIPT()
                    Set_XSCRIPT_ScriptID( 880006 )
                    Set_XSCRIPT_Function_Name( "HXY_EffectLevelUp" )
                    Set_XSCRIPT_Parameter( 0, effectIndex )
                    Set_XSCRIPT_Parameter( 1 , 1)
                    Set_XSCRIPT_ParamCount( 2 )
                Send_XSCRIPT()
                return 1
            end
		end
        return -1
    ]], effectIndex))
    return tonumber(ret)
end

function main()
    MentalTip("开始豪侠印和侠印减免效果升级！！！")
    if GetHXYLevel() == 0 then
        MentalTip("请先领取并装备上豪侠印")
        return
    end

    local HXYLevelMax = 0
    local HXYEffectMax = 0
    -- 检查侠印等级并升级
    if GetHXYLevel() == 100 then
        HXYLevelMax = 1
        MentalTip("您的豪侠印已达满级, 开始升级减免属性")
    else
        取出物品("豪侠勋章")
    end

    local allEffectLevel = 0
    for i = 1, 7 do
        local effectLevel = GetJianMianLevel(i - 1)
        if effectLevel == -1 then
            return
        end
        allEffectLevel = allEffectLevel + effectLevel
    end
    if allEffectLevel >= 7 * 20 then
        HXYEffectMax = 1
        MentalTip("您的豪侠印所有减免效果等级已达满级")
        return
    else
        取出物品("御赐令赏")
        延时(1000)
        右键使用物品("御赐令赏")
    end

    if HXYLevelMax ~= 1 then
        -- 先使用掉已有的豪侠勋章
        MentalTip("开始升级豪侠印等级")
        while true do
            local curXYXZCount = 获取背包物品数量("豪侠勋章")
            local needXYXZCount = GetHXYLevelUpCost()
            if curXYXZCount < needXYXZCount then
                break
            end
            if GetHXYLevel() == 100 then
                break
            end
            HXYLeveUp()
            延时(200)
        end

        -- 已有的豪侠勋章使用完还没100级，去战功商店购买使用
        if GetHXYLevel() < 100 then
            MentalTip("前往战功商店购买【豪侠勋章】并升级侠印等级")
            BuyHAYMaterial(0)  -- 战功商店购买豪侠勋章  -- TODO 修改豪侠勋章index
            延时(1000)
            while true do
                local curXYXZCount = 获取背包物品数量("豪侠勋章")
                local needXYXZCount = GetHXYLevelUpCost()
                if curXYXZCount < needXYXZCount then
                    break
                end
                HXYLeveUp()
                延时(500)
            end
        end
    end
    MentalTip("豪侠印等级升级完成")

    if HXYEffectMax ~= 1 then
        MentalTip("开始升级豪侠印减免效果等级")
        -- 使用已有的功勋升级减免效果
        for i = 1, 7 do
            while true do
                local levelUpRet = HXYEffectLevelUp(i - 1)
                if levelUpRet == -1 then
                    break
                end
                延时(200)
            end
        end

        -- 检查当前减免效果等级是否满级，没满再去买御赐令赏
        for i = 1, 7 do
            local effectLevel = GetJianMianLevel(i - 1)
            if effectLevel == -1 then
                return
            end
            allEffectLevel = allEffectLevel + effectLevel
        end
        if allEffectLevel < 7 * 20 then
            MentalTip("前往战功商店购买【御赐令赏】并升级减免效果")
            BuyHAYMaterial(1)   -- TODO 御赐令赏的Index
            延时(1000)
            右键使用物品("御赐令赏")
            延时(500)

            -- 使用功勋升级减免效果
            for i = 1, 7 do
                while true do
                    local levelUpRet = HXYEffectLevelUp(i - 1)
                    if levelUpRet == -1 then
                        break
                    end
                    延时(200)
                end
            end
        end
    end
    MentalTip("豪侠印减免效果升级完成")
end


-- ------------------------------ MAIN ------------------------------------
main()
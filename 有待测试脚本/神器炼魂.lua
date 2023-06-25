目标神器 = "神隐"
需要的属性 = {
    "血上限",
    "毒攻击",
    "玄攻击",
    "火攻击",
    "冰攻击",
    "体力",
    "忽略目标冰抗",
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetWeaponLevel(weaponIndex)
    local weaponLevel = LUA_取返回值(string.format([[
        local eqLevel = LifeAbility : Get_Equip_Level(BagIndex)
        return eqLevel
    ]], weaponIndex))
    return tonumber(weaponLevel)
end

function GetOldAttr(weaponIndex)
    local weaponOldAttr = LUA_取返回值(string.format([[
        local weaponIndex = %d

        local ItemID = PlayerPackage : GetItemTableIndex( BagIndex )
        if ItemID <= 0 then
            PushDebugMessage("这个物品不是可兑换的神器！")
            return -1
        end

        local theAction = EnumAction( weaponIndex, "packageitem" )
        local num = theAction:GetEquipAttrCount()
        local str = ""
        for i = 0, num-1 do
            local tempstr = theAction:EnumEquipExtAttr(i)
            str = str .. "|" .. tempstr
        end
        return str
    ]], weaponIndex))
    return weaponOldAttr
end

function GetWashAfterAttr()
    local newAttr = LUA_取返回值(string.format([[
		local num =  DataPool : Lua_GetRecoinNum();
		local str = ""
		for i = 0, num-1 do
			local tempstr = DataPool :Lua_GetRecoinEnumAttr(i)
			if string.find(tempstr, "#{") then
				local left = string.find(tempstr, "#{")
				local left2 = string.find(tempstr, "}")
				strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))
			end
			str = str..strTemp.."|"
		end
		return  str
	]], "s"))
    return newAttr
end

function SuperWeaponWash(weaponIndex)
    -- LUA_Call("setmetatable(_G, {__index = SuperWeaponUpNEW_Env});SuperWeaponUpNEW_Buttons_Clicked();")
    if g_Accept_Clicked_Num == 0 then
        LUA_Call(string.format([[
            local weaponIndex = %d
            Clear_XSCRIPT()
                Set_XSCRIPT_Function_Name( "ShenQiConfirm" )
                Set_XSCRIPT_ScriptID( 500505 )
                Set_XSCRIPT_Parameter( 0, weaponIndex )
                Set_XSCRIPT_Parameter( 1, 160 )
                Set_XSCRIPT_ParamCount( 2 )
            Send_XSCRIPT()
        ]], weaponIndex))
        g_Accept_Clicked_Num = 1
    else
        LUA_Call(string.format([[
            local weaponIndex = %d
            Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name( "OnShenqiUpgrade" )
				Set_XSCRIPT_ScriptID( 500505 )
				Set_XSCRIPT_Parameter( 0, weaponIndex )
				Set_XSCRIPT_Parameter( 1, 160 )
				Set_XSCRIPT_Parameter( 2, 0 )
				Set_XSCRIPT_ParamCount( 3 )
			Send_XSCRIPT()
        ]], weaponIndex))
    end
end

function main()
    local firstTip = "开始洗神器,目标属性:"
    for i = 1, #需要的属性 do
        firstTip = firstTip .. 需要的属性[i] .. ','
    end
    MentalTip(firstTip)

    if #需要的属性 > 7 then
        MentalTip("神器最多只有7条属性")
    end

    local weaponPos = 获取背包物品位置(目标神器)
    if weaponPos == nil or weaponPos < 1 then
        MentalTip(string.format("背包中缺少神器【%s】", 目标神器))
        return
    end

    local oldWeaponAttr = GetOldAttr(weaponPos - 1)
    local oldMatched = 0
    for j = 1, #需要的属性 do
        if string.find(oldWeaponAttr, 需要的属性[j]) then
            oldMatched = oldMatched + 1
        end
    end
    if oldMatched == #需要的属性 then
        MentalTip("您的神器属性已满足需要的属性")
        return
    end

    local weaponLevel = GetWeaponLevel(weaponPos - 1)
    local washMaterial = ""
    if weaponLevel == 82 or weaponLevel == 86 then
        washMaterial = "神兵符1级"
    elseif weaponLevel == 92 or weaponLevel == 96 then
        washMaterial = "神兵符2级"
    elseif weaponLevel == 102 then
        washMaterial = "神兵符3级"
    else
        MentalTip(string.format("装备【%s】不可进行神器炼魂", 目标神器))
        return
    end

    取出物品(washMaterial)
    取出物品("金币")
    延时(1000)
    if 获取背包物品数量(washMaterial) < 5 then
        MentalTip(string.format("神器炼魂材料【%s】数量不足", washMaterial))
        return
    end

    跨图寻路("苏州", 354, 240)
    延时(1500)
    对话NPC("欧治于")
    延时(1000)
    NPC二级对话("神器炼魂")
    延时(1500)
    右键使用物品(目标神器)
    延时(1000)

    g_Accept_Clicked_Num = 0
    while true do
        if 获取背包物品数量(washMaterial) < 5 or 取所有钱() <= 5 then
            MentalTip("材料或金币不足,自动停止")
            break
        end
        SuperWeaponWash(weaponPos - 1)
        延时(1000)
        local newMatched = 0
        local newAttr = GetWashAfterAttr()
        for j = 1, #需要的属性 do
            if string.find(newAttr, 需要的属性[j]) then
                newMatched = newMatched + 1
            end
        end
        if newMatched == #需要的属性 then
            MentalTip("您的神器属性已洗好")
            return
        end
    end
end

-- ------------------------------- Main ---------------------------------
main()
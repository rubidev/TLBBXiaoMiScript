function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetEquipStar(equipIndex)
    -- 获取装备星星
    local tem = LUA_取返回值(string.format([[
        local equipIndex = %d
		local ID = EnumAction(equipIndex,"equip"):GetID()
		if ID > 0 then
			local nQua = DataPool:GetEquipQual(equipIndex)
			return nQua
		end
		return -1
	]], tonumber(equipIndex)))
    return tonumber(tem)
end

function GetWareWeaponName(equipIndex)
    return LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetName()
	]], equipIndex))
end

function GetWeaponPkgIndex(weaponName)
    local weaponIndex = LUA_取返回值(string.format([[
        local weaponName = "%s"
        local currNum = DataPool:GetBaseBag_Num();
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
            if theAction:GetID() ~= 0 then
                local itemName = theAction:GetName()
                if itemName == weaponName then
                    return i - 1
                end
            end
        end
        return -1
    ]], weaponName))
    return tonumber(weaponIndex)
end

function main()
    取出物品("伏羲玉")
    取出物品("金币")
    跨图寻路("凤鸣镇", 248, 217)
    延时(500)

    -- 获取神器名字
    local weaponName = GetWareWeaponName(0)

    -- 取下神器
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_SelfEquip_Clicked();]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click( 11,0 );]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();]])

    local weaponIndex = GetWeaponPkgIndex(weaponName)

    for i = 1, 20 do
        if weaponName ~= -1 then
            LUA_Call(string.format([[
            g_ShengJie_WeaponIndex = %d
            Clear_XSCRIPT()
                Set_XSCRIPT_Function_Name("DoSuperWeapon9Up")
                Set_XSCRIPT_ScriptID(702006)
                Set_XSCRIPT_Parameter(0, 2)
                Set_XSCRIPT_Parameter(1, g_ShengJie_WeaponIndex)
                Set_XSCRIPT_ParamCount(2)
            Send_XSCRIPT()
        ]], weaponIndex))
        end
        延时(150)
    end
    延时(500)
    右键使用物品(weaponName)
end

-- main ---------------------------------------------
main()
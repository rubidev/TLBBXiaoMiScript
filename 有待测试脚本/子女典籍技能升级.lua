function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function 判断关闭窗口(strWindowName)
    if 窗口是否出现(strWindowName) == 1 then
        LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()
		]], strWindowName))
        延时(1500)
    end
end

-- 子女装备升星 ================================================================================
znEuipList = {
    [1] = { name = "属性", downIndex = 0, equipIndex = 0, equipName = "" },
    [2] = { name = "体力", downIndex = 1, equipIndex = 1, equipName = "" },
    [3] = { name = "命中", downIndex = 2, equipIndex = 5, equipName = "" },
    [4] = { name = "会心", downIndex = 3, equipIndex = 4, equipName = "" },
    [5] = { name = "身法", downIndex = 4, equipIndex = 2, equipName = "" },
    [6] = { name = "闪避", downIndex = 5, equipIndex = 3, equipName = "" },
}

-- -----------------------------------------------子女函数---------------------------------
function GetInfantEquipID(index)
    local tem = LUA_取返回值(string.format([[
	        return EnumAction(%d ,"infantcard"):GetID()
	  ]], index));
    return tonumber(tem)
end

function GetInfantEquipName(index)
    local tem = LUA_取返回值(string.format([[
	        return EnumAction(%d ,"infantcard"):GetName()
	  ]], index));
    return tostring(tem)
end

function GetInfantEquipLevel(index)
    local tem = LUA_取返回值(string.format([[
	        return PlayerPackage:GetInfantCard_EnhanceLevel(%d)
	  ]], index));
    return tonumber(tem)
end

function DownEquipGetEquipName(equipLocationName)
    for i = 1, #znEuipList do
        if znEuipList[i].name == equipLocationName then
            MentalTip("准备取下装备位置:" .. equipLocationName)
            if GetInfantEquipID(znEuipList[i].equipIndex) == 0 then
                return 0
            end
            for k = 1, 10 do
                local equipName = GetInfantEquipName(znEuipList[i].equipIndex)
                MentalTip("准备取下装备位置:" .. equipName)

                LUA_Call(string.format([[setmetatable(_G, {__index = Infant_Env}); Infant_Card_Clicked(%d,0);]], znEuipList[i].downIndex))
                延时(1000)
                if GetInfantEquipID(znEuipList[i].equipIndex) == 0 then
                    判断关闭窗口("Infant")
                    判断关闭窗口("SelfEquip")
                    return equipName
                end
            end
            return 0
        end
    end
end

function WearInfantEquip(equipLocationName, equipName)
    if equipName == "" then
        MentalTip("参数错误,穿上子女装备失败")
        return
    end
    if 获取背包物品数量(equipName) <= 0 then
        MentalTip("没有装备无法使用,穿上子女装备")
        return
    end
    for i = 1, #znEuipList do
        if znEuipList[i].name == equipLocationName then
            for k = 1, 5 do

                右键使用物品(equipName);
                延时(1000)

                if GetInfantEquipID(znEuipList[i].equipIndex) > 0 then
                    判断关闭窗口("Infant")
                    判断关闭窗口("SelfEquip")
                    MentalTip(" 成功穿上" .. equipName .. ", 在位置:" .. equipLocationName)
                    break
                end
            end
        end
    end
end



-- ---------------------------------------------------------------------------------------


function InfantEquipLevelUp(InfantLocationName, level)
    if 获取背包物品数量("典籍注解") <= 0 then
        MentalTip("材料不足")
        return
    end

    跨图寻路("洛阳", 151, 173)

    local equipName = DownEquipGetEquipName(InfantLocationName)
    延时(1000)

    if equipName == 0 then
        return -1
    else
        LPindex = 获取背包物品位置(equipName) - 1
    end
    if GetInfantEquipLevel(LPindex) >= level then
        WearInfantEquip(InfantLocationName, equipName)
        return
    end

    local curMaterialCount = 获取背包物品数量("典籍注解")
    for i = 1, curMaterialCount do
        if 获取背包物品数量("典籍注解") <= 0 then
            MentalTip("材料不足")
            break
        end
        LUA_Call(string.format([[
			g_BagIndex = %d
			if g_BagIndex == -1 then
		        PushDebugMessage("#{ZSJX_140707_05}")
		        return
            end

			local g_MoneyCost =10000
            local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	        if selfMoney < g_MoneyCost then
	        	PushDebugMessage("#{KPWFS_131112_26}")
	        	return
	        end

	        local enhancelevel = PlayerPackage:GetInfantCard_EnhanceLevel(g_BagIndex)
	        if enhancelevel >= %d then
	        	PushDebugMessage("#{KPWFS_131112_45}")
	        	return
	        end

            if PlayerPackage:CountAvailableItemByIDTable(38000807) <= 0 then
                PushDebugMessage("材料不足")
                return
            end

             Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("StudyBooks");
                Set_XSCRIPT_ScriptID(890630);
                Set_XSCRIPT_Parameter(0,g_BagIndex);
                Set_XSCRIPT_Parameter(1,1);
                Set_XSCRIPT_ParamCount(2);
            Send_XSCRIPT()
	    ]], LPindex, level))
        延时(500)

        local curEquipLevel = GetInfantEquipLevel(LPindex)
        if curEquipLevel >= level then
            break
        end

    end


end

function AutoInfantEquipLevelUp()
    if tonumber(LUA_取返回值('return Infant:GetHeroType(0);')) <= 0 then
        MentalTip("子女没有成年")
        return
    end

    local minLevel = 9
    for _, v in pairs(znEuipList) do
        local InfantLocationName = v['name']
        local equipName = DownEquipGetEquipName(InfantLocationName)
        local LPindex = 获取背包物品位置(equipName) - 1
        local equipLevel = GetInfantEquipLevel(LPindex)
        if equipLevel < minLevel then
            minLevel = equipLevel
        end
        WearInfantEquip(InfantLocationName, equipName)
    end
    MentalTip(string.format('子女装备最低为 %d 星', minLevel))

    
    for level = minLevel, 9 do
		MentalTip(string.format("开始检测升级到%d星", level))
        for _, v in pairs(znEuipList) do
            local InfantLocationName = v['name']
            InfantEquipLevelUp(InfantLocationName, level)
        end
    end

    for _, v in pairs(znEuipList) do
        local equipLocationName = v['name']
        local equipName = v['equipName']
        WearInfantEquip(equipLocationName, equipName)
    end
end

-- ===========================================================================================
-- 子女技能升级 ================================================================================
function GetInfantNum()
    for k = 1, 5 do
        if 窗口是否出现("Infant") ~= 1 then
            LUA_Call("MainMenuBar_SelfEquip_Clicked();");
            延时(2000)
            LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Infant_Switch();");
            延时(2000)
            LUA_Call("setmetatable(_G, {__index = Infant_Env});Infant_SetCheckBox(1);");
            延时(2000)
        else
            local tem = LUA_取返回值(string.format([[
				return Infant:GetInfantCount();
			]]))
            判断关闭窗口("SelfEquip")
            return tonumber(tem)
        end
        延时(500)
    end
    return 0
end

function GetInfantLevel()
    local tem = LUA_取返回值(string.format([[
			TTCount = Infant:GetInfantCount()
			if TTCount<= 0 then
				return 0
			end
			return Infant:GetInfantLevel(0)
			]]))
    return tonumber(tem)
end


function GetMyMoney()
    所有钱 = 获取人物信息(52) + 获取人物信息(45)
    return 所有钱
end

function GetInfantSkillLevelByName(infantSkillName)
    local tem = LUA_取返回值(string.format([[
		for i = 0, 3 do
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
			if szSkillName == "%s" then
				return nSkillLevel
			end
		end
		return -1
		]], infantSkillName))
    return tonumber(tem)
end

function GetInfantSkillLevelById(infantSkillID)
    local tem = LUA_取返回值(string.format([[
			i = %d - 1
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,i)
			return nSkillLevel
		]], infantSkillID))
    return tonumber(tem)
end

function GetInfantSkillName(infantSkillID)
    local tem = LUA_取返回值(string.format([[
		local infantSkillID = %d - 1
        local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  infantSkillID )
		return szSkillName
		]], infantSkillID))
    return tem
end

function getInfantSkillID(infantSkillName)
    local tem = LUA_取返回值(string.format([[
		for i = 0, 3 do
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
			if szSkillName == "%s" then
				return i+1
			end
		end
		return -1
		]], infantSkillName))
    return tonumber(tem)
end

-- --------------------------------------------------------------------------------------------------
function SpecifiedInfantSkillLevelUp(skillName, targetLevel)
    MentalTip(string.format("升级【%s】到特定等级【%s】:", skillName, targetLevel))
    local curWLZNum = 获取背包物品数量("悟灵珠")
    for i = 1, curWLZNum do
        if 获取背包物品数量("悟灵珠") <= 0 then
            MentalTip("悟灵珠没有")
            return
        end
        if GetMyMoney() <= 5 * 10000 then
            MentalTip("金币不足")
            return
        end
        local tem = LUA_取返回值(string.format([[
			local InfantCount = Infant:GetInfantCount();
			if InfantCount <= 0  then
			    return 2
			end

			guid_H, guid_L = Infant:GetInfantGUID(0);
			nSkillID2 = -1
			for i = 0, 3 do
				local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
                if szSkillName == "%s" then
                    nSkillID2 = nSkillID
                    if nSkillLevel >= %d then
                        return 2
                    end
                end
            end
			if nSkillID2 == -1 then
				return 2
			end

            Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("InfantSkillLevelUp");
                Set_XSCRIPT_ScriptID(890600);
                Set_XSCRIPT_Parameter(0,guid_H);
                Set_XSCRIPT_Parameter(1,guid_L);
                Set_XSCRIPT_Parameter(2,nSkillID2);
                Set_XSCRIPT_Parameter(3,1);
                Set_XSCRIPT_ParamCount(4);
            Send_XSCRIPT();
		]], skillName, targetLevel))
        延时(3000)
        if tonumber(tem) == 2 then
            break
        end
    end
end

function NormalInfantSkillLevelUp(targetLevel)
    for kkk = 1, 4 do
        local skillName = GetInfantSkillName(kkk)

        local curWLZNum = 获取背包物品数量("悟灵珠")
        for i = 1, curWLZNum do
            MentalTip("升级子女技能" .. skillName .. "到等级" .. targetLevel)
            if GetInfantSkillLevelById(kkk) >= targetLevel then
                break
            end
            if 获取背包物品数量("悟灵珠") <= 0 then
                MentalTip("悟灵珠没有")
                return
            end
            if GetMyMoney() <= 5 * 10000 then
                MentalTip("金币不足")
                return
            end
            local tem = LUA_取返回值(string.format([[
				i = %d - 1
				local InfantCount = Infant:GetInfantCount();
				if InfantCount <= 0  then
				    return 2
				end

				guid_H, guid_L = Infant:GetInfantGUID(0);
				local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
				if nSkillLevel >= 9  or  nSkillLevel >= %d then
					return 2
				end
				if nSkillID == -1 then
					return 2
				end

				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name("InfantSkillLevelUp");
					Set_XSCRIPT_ScriptID(890600);
					Set_XSCRIPT_Parameter(0,guid_H);
					Set_XSCRIPT_Parameter(1,guid_L);
					Set_XSCRIPT_Parameter(2,nSkillID);
					Set_XSCRIPT_Parameter(3,1);
					Set_XSCRIPT_ParamCount(4);
				Send_XSCRIPT();
			]], kkk, targetLevel))
            延时(500)
            if tonumber(tem) == 2 then
                break
            end
        end
    end
end

function InfantSkillLevelUp(level)
    跨图寻路("洛阳", 150, 183)

    --SpecifiedInfantSkillLevelUp("毒抗", level)

    NormalInfantSkillLevelUp(level)
    延时(2000)

end


-- ----------------------------------------------------------------------------------
function AutoInfantSkillLevelUp()
    local minSkillLevel = 9
    for i = 1, 4 do
        local curSkillLevel = GetInfantSkillLevelById(i)
        if curSkillLevel < minSkillLevel then
            minSkillLevel = curSkillLevel
        end
    end
    MentalTip(string.format("当前子女技能最低等级为 %d 级", minSkillLevel))

    local startSkillLevel = minSkillLevel + 1
    if GetInfantNum() > 0 and GetInfantLevel() >= 31 then
        for i = startSkillLevel, 9 do
			MentalTip("全部升到等级" .. i)
            InfantSkillLevelUp(i)
        end
    end
end

-- -------------------------------------------------------
取出物品("悟灵珠|典籍注解")
取出物品("金币")
AutoInfantSkillLevelUp()
AutoInfantEquipLevelUp()
存物品("悟灵珠")
存物品("典籍注解")
存物品("金币")


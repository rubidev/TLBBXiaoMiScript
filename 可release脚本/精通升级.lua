local SelfEquipList = {
    [1] = { name = "武器", downIndex = 11, equipIndex = 0, equipName = "" }, --- 武器
    [2] = { name = "护腕", downIndex = 3, equipIndex = 14, equipName = "" }, --- 护腕
    [3] = { name = "戒指上", downIndex = 7, equipIndex = 6, equipName = "" }, --- 戒指（上）
    [4] = { name = "戒指下", downIndex = 8, equipIndex = 11, equipName = "" }, --- 戒指（下）
    [5] = { name = "护符上", downIndex = 9, equipIndex = 12, equipName = "" }, --- 护符（上）
    [6] = { name = "护符下", downIndex = 10, equipIndex = 13, equipName = "" }, --- 护符（下）
    [7] = { name = "衣服", downIndex = 12, equipIndex = 2, equipName = "" }, --- 衣服
    [8] = { name = "帽子", downIndex = 1, equipIndex = 1, equipName = "" }, --- 帽子
    [9] = { name = "护肩", downIndex = 2, equipIndex = 15, equipName = "" }, --- 肩膀
    [10] = { name = "手套", downIndex = 4, equipIndex = 3, equipName = "" }, --- 手套
    [11] = { name = "腰带", downIndex = 5, equipIndex = 5, equipName = "" }, --- 腰带
    [12] = { name = "鞋子", downIndex = 6, equipIndex = 4, equipName = "" }, --- 鞋子
    [13] = { name = "项链", downIndex = 13, equipIndex = 7, equipName = "" }, --- 项链
    [14] = { name = "暗器", downIndex = 14, equipIndex = 17, equipName = "" }, --- 暗器
    [15] = { name = "龙纹", downIndex = 25, equipIndex = 19, equipName = "" }, --- 龙纹
    [16] = { name = "武魂", downIndex = "", equipIndex = 18, equipName = "" }, --- 武魂
    [17] = { name = "令牌", downIndex = 16, equipIndex = 20, equipName = "" }, --- 令牌
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function MoveToPos(NPCCity, x, y)
    while true do
        跨图寻路(NPCCity, x, y)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == x and tonumber(myY) == y then
            break
        end
    end
end

function CheckAllJingTong()
    local needClean = 1
    for i = 1, #SelfEquipList do
        local isJTMaxLevel = LUA_取返回值(string.format([[
            local equipIndex = %d
            local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
            if tonumber(AttrLevel1) + tonumber(AttrLevel2) + tonumber(AttrLevel3) < 300 then
                return 0
            end
            return 1
        ]], SelfEquipList[i].equipIndex))

        if tonumber(isJTMaxLevel) == 0 then
            needClean = 0
            break
        end
    end

    if needClean == 1 then
        MentalTip("您的所有精通已满, 即将销毁精金石")
        取出物品("精金石")
        延时(1000)
        自动清包("精金石")
        return 1
    end
    return -1
end

function CheckSpecifiedJingTong(equipPosName, targetLevel)
    local isTargetLevel = 1
    for i = 1, #SelfEquipList do
        if SelfEquipList[i].name == equipPosName then
            local isJTMaxLevel = LUA_取返回值(string.format([[
                local equipIndex = %d
                local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
                if tonumber(AttrLevel1) < %d or tonumber(AttrLevel2) < %d or tonumber(AttrLevel3) < %d then
                    return 0
                end
                return 1
            ]], SelfEquipList[i].equipIndex, targetLevel, targetLevel, targetLevel))

            if tonumber(isJTMaxLevel) == 0 then
                isTargetLevel = 0
            end
            break
        end
    end

    if isTargetLevel == 1 then
        MentalTip("您的" .. equipPosName .. "精通已达" .. tostring(targetLevel) .. "级, 无需升级")
        return 1
    end
    return -1
end

function getMainAttr()
    local tem = LUA_取返回值(string.format([[
        local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
        local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
        local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
        local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
        local tt={ iIceAttack, iFireAttack, iThunderAttack,iPoisonAttack}
        if iIceAttack==math.max(unpack(tt)) then
           maxOfT ="冰"
        elseif  iFireAttack==math.max(unpack(tt)) then
            maxOfT ="火"
        elseif  iThunderAttack==math.max(unpack(tt)) then
            maxOfT ="玄"
        elseif  iPoisonAttack==math.max(unpack(tt)) then
            maxOfT ="毒"
        end
        return maxOfT
    ]]), "s")
    MentalTip("主属性攻击:" .. tem)
    return tem
end

function 取身上装备持久(aaa)
    local tem = LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa))
    return tonumber(tem)
end

function 取身上装备ID(aaa)
    local tem = LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
    return tonumber(tem)
end

function 取身上装备名字(aaa)
    return LUA_取返回值(string.format([[
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

function 判断关闭窗口(strWindowName)
    for i = 1, 3 do
        if 窗口是否出现(strWindowName) == 1 then
            LUA_Call(string.format([[
				setmetatable(_G, {__index = %s_Env}) this:Hide()
			]], strWindowName))
            延时(1500)
        end
    end
end

function 取下装备获取名字(装备位置名称)
    for i = 1, #SelfEquipList do
        if SelfEquipList[i].name == 装备位置名称 then
            MentalTip("准备取下装备位置:" .. 装备位置名称)
            local 装备持久 = 取身上装备持久(SelfEquipList[i].equipIndex)
            if 装备持久 <= 0 then
                MentalTip("装备持久不够,不取下")
                return 0
            end
            if 取身上装备ID(SelfEquipList[i].equipIndex) <= 0 then
                return 0
            end

            for k = 1, 5 do
                if 窗口是否出现("SelfEquip") == 1 then
                    local 装备名称 = 取身上装备名字(SelfEquipList[i].equipIndex)
                    LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEquipList[i].downIndex))
                    延时(2000)
                    if 取身上装备ID(SelfEquipList[i].equipIndex) == 0 then
                        判断关闭窗口("SelfEquip")
                        return 装备名称
                    end
                else
                    LUA_Call("MainMenuBar_SelfEquip_Clicked();");
                    延时(2000)
                end
            end
            return 0
        end
    end
    MentalTip("提示错误 取下装备 数组错误")
    延时(2000)
end

function 取身上装备名字(aaa)
    local tem = LUA_取返回值(string.format([[
		local index =%d
		local theaction = EnumAction(index,"equip")
		if theaction then
			local  ID =theaction:GetID();
			if tonumber( ID) > 0 then
				local Name = EnumAction(index,"equip"):GetName()
				return  Name
			end
		end
		return -1
	]], aaa))
    return tostring(tem)
end

function 取身上精通最小等级(equipIndex, shuxing)
    local tem = LUA_取返回值(string.format([[
		local index = 0
		local equipIndex = %d
		local JdSX = "%s"
		local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
		if string.find(AttrName1,JdSX) then
			if index== 0 then
				index=AttrLevel1
			else
				if AttrLevel1 <index then
					index=AttrLevel1
				end
 			end
		end
		if string.find(AttrName2,JdSX) then
			if index== 0 then
				index=AttrLevel2
			else
				if AttrLevel2 <index then
					index=AttrLevel2
				end
 			end
		end
		if string.find(AttrName3,JdSX) then
			if index== 0 then
				index=AttrLevel3
			else
				if AttrLevel3 <index then
					index=AttrLevel3
				end
 			end
		end
		return index
	]], equipIndex, shuxing))
    return tonumber(tem)
end

function 取身上装备位置精通最小等级(装备位置名称, shuxing)
    local tem = 0
    for i = 1, #SelfEquipList do
        if SelfEquipList[i].name == 装备位置名称 then
            tem = 取身上精通最小等级(SelfEquipList[i].equipIndex, shuxing)
        end
    end
    return tonumber(tem)
end

function 使用物品(物品列表, 是否绑定)
    if 是否绑定 == 0 or 是否绑定 == nil then
        tbangding = 10
    elseif 是否绑定 == 1 then
        tbangding = 0
    elseif 是否绑定 == 2 then
        tbangding = 1
    end
    for i = 0, 199 do
        local tem = LUA_取返回值(string.format([[
			local tbangding =tostring("%s")
			local i =%d
			local ttname = "%s"
			local theAction=EnumAction(i,"packageitem")
			if theAction:GetID() ~= 0 then
				local GetName=theAction:GetName()
				local szItemNum =theAction:GetNum();
				local Status=GetItemBindStatus(i);
				if GetName~=nil and GetName ~="" then
					if string.find("|"..ttname.."|","|"..GetName.."|",1,true) then
						if string.find(tbangding,tostring(Status)) then
							PushDebugMessage("修鞋匠智能右击物品:"..GetName.."|背包位置:"..i)
							return 1
						end
					end
				end
			end
			return -1
		]], tbangding, i, 物品列表))
        if tonumber(tem) >= 1 then
            LUA_Call(string.format([[
				local theAction = EnumAction(%d, "packageitem");
				if theAction:GetID() ~= 0 then
						setmetatable(_G, {__index = Packet_Env});
						local oldid = Packet_Space_Line1_Row1_button:GetActionItem();
						Packet_Space_Line1_Row1_button:SetActionItem(theAction:GetID());
						Packet_Space_Line1_Row1_button:DoAction();
						Packet_Space_Line1_Row1_button:SetActionItem(oldid);
				end
			]], i))
            延时(1000)
        end
    end
end

function 穿上装备(装备位置名称, 装备名称)
    if 装备名称 == "" then
        MentalTip("参数错误,穿上装备")
        MentalTip("参数错误,穿上装备")
        MentalTip("参数错误,穿上装备")
        延时(2000)
        return
    end

    for i = 1, #SelfEquipList do
        if SelfEquipList[i].name == 装备位置名称 then
            for k = 1, 5 do
                if 窗口是否出现("SelfEquip") == 1 then
                    使用物品(装备名称);
                    延时(2000)
                    if 取身上装备ID(SelfEquipList[i].equipIndex) > 0 then
                        MentalTip("修鞋匠成功穿上" .. 装备名称 .. "|在位置:" .. 装备位置名称)
                        判断关闭窗口("SelfEquip")
                        break
                    end
                else
                    LUA_Call("MainMenuBar_SelfEquip_Clicked();");
                    延时(2000)
                end
            end
        end
    end
end

function 精通升级(装备位置名称, 属性, 等级)

    if tonumber(等级) >= 30 and tonumber(等级) < 40 then
        需要材料数量 = 14
    elseif tonumber(等级) >= 20 and tonumber(等级) < 30 then
        需要材料数量 = 12
    elseif tonumber(等级) >= 1 and tonumber(等级) < 10 then
        需要材料数量 = 1
    elseif tonumber(等级) >= 10 and tonumber(等级) < 20 then
        需要材料数量 = 6
    elseif tonumber(等级) >= 40 and tonumber(等级) < 50 then
        需要材料数量 = 16
    elseif tonumber(等级) >= 50 and tonumber(等级) < 60 then
        需要材料数量 = 18
    elseif tonumber(等级) >= 60 and tonumber(等级) < 70 then
        需要材料数量 = 20
    elseif tonumber(等级) >= 70 and tonumber(等级) < 80 then
        需要材料数量 = 22
    elseif tonumber(等级) >= 80 and tonumber(等级) < 90 then
        需要材料数量 = 24
    elseif tonumber(等级) >= 90 and tonumber(等级) < 100 then
        需要材料数量 = 25
    else
        需要材料数量 = 20
    end

    if 获取背包物品数量("精金石") < 需要材料数量 then
        MentalTip(装备位置名称 .. "|装备提升精通目标等级:" .. 等级 .. "|精金石不够" .. 需要材料数量 .. "|跳过升级")
        return
    end

    if 到数值(获取人物信息(45) + 获取人物信息(52)) < 100 then
        MentalTip("精通属性升级,金币不够")
        return
    end

    if 属性 == "体力" then
        JT_SHUXING = "con"
    elseif 属性 == "火" then
        JT_SHUXING = "attack_fire"
    elseif 属性 == "玄" then
        JT_SHUXING = "attack_light"
    elseif 属性 == "冰" then
        JT_SHUXING = "attack_cold"
    elseif 属性 == "毒" then
        JT_SHUXING = "attack_poison"
    else
        MentalTip("精通属性升级,请设置好参数")
        return
    end
    --MentalTip("装备精通升级的属性为:" .. 属性)
    local 精通最小等级 = 取身上装备位置精通最小等级(装备位置名称, JT_SHUXING)
    MentalTip(装备位置名称 .. "属性:" .. JT_SHUXING .. "最小精通:" .. 精通最小等级)
    if 精通最小等级 > 等级 or 精通最小等级 == 0 then
        MentalTip("精通已满足目标等级: " .. tostring(等级))
        return
    end
    MoveToPos("苏州", 364, 245)

    local 装备名称 = 取下装备获取名字(装备位置名称)
    if 装备名称 == 0 then
        return
    end

    local LPindex = 获取背包物品位置(装备名称) - 1
    MentalTip("待精通升级的背包序号:" .. LPindex)
    if LPindex < 0 then
        return
    end

    for iii = 1, 999 do
        local tem = LUA_取返回值(string.format([[
            local index = tonumber(%d)
            local JT_ABC=tostring("%s")
            local nlevel= tonumber(%d)
            local equip_level = LifeAbility : Get_Equip_Level(index);
            if equip_level <80 then
                PushDebugMessage("装备等级小于80,没有精通属性")
                return 2
            end

            local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
            if selfMoney < 100 then
                PushDebugMessage("精通属性升级金币不够")
                return 2
            end

            local theAction = EnumAction(index, "packageitem")
            local JT_XUHAO = -1
            for kkk=0,2 do
                local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(kkk);
                if(pLevel ~= nil and pLevel > 0) then
                    if string.find(pName, JT_ABC)  then
                        if tonumber(pLevel) < nlevel  then
                            JT_XUHAO = kkk + 1
                            JT_MQDJ = pLevel
                        end
                    end
                else
                    PushDebugMessage("装备没有淬炼 无法升级")
                    break
                end
            end

            if tonumber(JT_XUHAO)==-1 then
                return 2
            end

           local itemneed= PlayerPackage:CountAvailableItemByIDTable(20700055)

            if tonumber(JT_MQDJ) >= 30 and  tonumber(JT_MQDJ) < 40  then
                JT_XYJJS=14
            elseif tonumber(JT_MQDJ) >= 20 and  tonumber(JT_MQDJ) < 30  then
                JT_XYJJS=12
            elseif tonumber(JT_MQDJ) >=1 and  tonumber(JT_MQDJ) < 10  then
                JT_XYJJS=1
            elseif tonumber(JT_MQDJ) >=10 and  tonumber(JT_MQDJ) < 20  then
                JT_XYJJS=6
            elseif tonumber(JT_MQDJ) >=40 and  tonumber(JT_MQDJ) < 50  then
                JT_XYJJS=16
            elseif tonumber(JT_MQDJ) >=50 and  tonumber(JT_MQDJ) < 60  then
                JT_XYJJS=18
            elseif tonumber(JT_MQDJ) >=60 and  tonumber(JT_MQDJ) < 70  then
                JT_XYJJS=20
            elseif tonumber(JT_MQDJ) >=70 and  tonumber(JT_MQDJ) < 80  then
                JT_XYJJS=22
            elseif tonumber(JT_MQDJ) >=80 and  tonumber(JT_MQDJ) < 90  then
                JT_XYJJS=24
            elseif tonumber(JT_MQDJ) >=90 and  tonumber(JT_MQDJ) < 100  then
                JT_XYJJS=25
            else
                 JT_XYJJS=20
            end

            if itemneed < JT_XYJJS then
                PushDebugMessage("精金石:不够")
                return 2
            end

            Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("EquipLevelupAtta");
            Set_XSCRIPT_ScriptID(890088);
            Set_XSCRIPT_Parameter(0,index);
            Set_XSCRIPT_Parameter(1, tonumber(JT_XUHAO));
            Set_XSCRIPT_Parameter(2, 0);
            Set_XSCRIPT_ParamCount(3);
            Send_XSCRIPT();
		]], LPindex, JT_SHUXING, 等级))
        延时(1000)
        if tonumber(tem) == 2 then
            break
        end
    end
    穿上装备(装备位置名称, 装备名称)
end

function StrengthLevelUp(index)
    if CheckSpecifiedJingTong("腰带", index) == -1 then
        精通升级("腰带", "体力", index)
    end
    if CheckSpecifiedJingTong("护肩", index) == -1 then
        精通升级("护肩", "体力", index)
    end
    if CheckSpecifiedJingTong("手套", index) == -1 then
        精通升级("手套", "体力", index)
    end
    if CheckSpecifiedJingTong("鞋子", index) == -1 then
        精通升级("鞋子", "体力", index)
    end
    if CheckSpecifiedJingTong("帽子", index) == -1 then
        精通升级("帽子", "体力", index)
    end
    if CheckSpecifiedJingTong("衣服", index) == -1 then
        精通升级("衣服", "体力", index)
    end
end

function AttackLevelUp(index)
    if CheckSpecifiedJingTong("护符上", index) == -1 then
        精通升级("护符上", 属性攻击, index)
    end
    if CheckSpecifiedJingTong("护符下", index) == -1 then
        精通升级("护符下", 属性攻击, index)
    end
    if CheckSpecifiedJingTong("戒指上", index) == -1 then
        精通升级("戒指上", 属性攻击, index)
    end
    if CheckSpecifiedJingTong("戒指下", index) == -1 then
        精通升级("戒指下", 属性攻击, index)
    end
    if CheckSpecifiedJingTong("护腕", index) == -1 then
        精通升级("护腕", 属性攻击, index)
    end
    if CheckSpecifiedJingTong("项链", index) == -1 then
        精通升级("项链", 属性攻击, index)
    end
end

function 精通智能升级()
    if 获取背包物品数量("精金石") < 12 then
        MentalTip("精通属性升级不够15个 放弃精通属性升级")
        return
    end

    local _, menPai, _, _, _, _, _, _, _ = 获取人物属性()
    if menPai == "峨嵋" then
        StrengthLevelUp(30)
        StrengthLevelUp(50)
        StrengthLevelUp(70)
        StrengthLevelUp(100)
        AttackLevelUp(30)
        AttackLevelUp(50)
        AttackLevelUp(70)
        AttackLevelUp(100)
    else
        AttackLevelUp(30)
        AttackLevelUp(50)
        AttackLevelUp(70)
        AttackLevelUp(100)
        StrengthLevelUp(30)
        StrengthLevelUp(50)
        StrengthLevelUp(70)
        StrengthLevelUp(100)
    end

end
-- -------------------------------------------------------------------------------------------
local needNotLevelUp = CheckAllJingTong()
if needNotLevelUp == 1 then
    return
end

属性攻击 = getMainAttr()
取出物品("金币")
取出物品("精金石")
精通智能升级()
存物品("金币")

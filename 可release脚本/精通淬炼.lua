-- 指定装备淬炼列表, 为空表示不指定装备
--指定装备淬炼列表 = "川暮|碧楼|惊心|凶陌圣盔|幻世魔衣|步月|蝶恋|幻世圣巾|幻世圣靴|幻世魔腕|幻世魔肩|幻世手套|噬麟圣裘|沐水天衣|沐水天肩|沐水天靴|沐水天腕|沐水手套|沐水天靴|催雪|步月|妖言|霜晓|醉舞|川暮|凶陌圣甲|蝶恋|横笛|玄魄天裘|轻寒|佛语|横笛|浅浪|川暮|醉舞|轻寒|飞雪"
指定装备淬炼列表 = ""

-- ---------------------------------------------------------------------------------------------------------------------------------------------
function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function 取身上全部钱()
    local tem = LUA_取返回值(string.format([[
			local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
			return selfMoney
			]]))
    return tonumber(tem)
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

function 取背包精通条数(index, 属性)
    local tem = LUA_取返回值(string.format([[
			local theAction = EnumAction(%d, "packageitem")
			local tiaoshu=0
			for i= 0,2 do
				local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(i);
				if string.find(pName, "%s")  then
					tiaoshu=tiaoshu+1	
				end
			end
			return tiaoshu
	]], index, 属性), "n")
    return tonumber(tem)
end

-- ------------------------------------------------------------


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

-- ------------------------------------------------装备相关------------------------------------------------
local SelfEuipList = {
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

function 取下装备获取名字(装备位置名称)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            MentalTip("准备取下装备位置:" .. 装备位置名称)
            local 装备持久 = 取身上装备持久(SelfEuipList[i].equipIndex)
            if 装备持久 <= 0 then
                MentalTip("装备持久不够,不取下")
                return 0
            end
            if 取身上装备ID(SelfEuipList[i].equipIndex) <= 0 then
                return 0
            end

            for k = 1, 5 do
                if 窗口是否出现("SelfEquip") == 1 then
                    local 装备名称 = 取身上装备名字(SelfEuipList[i].equipIndex)
                    LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
                    延时(2000)
                    if 取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
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

function 取身上装备位置名字(装备位置名称)
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            local 装备名称 = 取身上装备名字(SelfEuipList[i].equipIndex)
            return 装备名称
        end
    end
end

function 取身上精通条数(aaa, shuxing)
    local tem = LUA_取返回值(string.format([[
		local index = 0 
		local xuhao=%d
		local JdSX="%s"
		local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(xuhao) 
		if string.find(AttrName1,JdSX) then 
			index=index+1
		end
		if string.find(AttrName2,JdSX) then 
			index=index+1
		end	
		if string.find(AttrName3,JdSX) then 
			index=index+1
		end
		return index
		--PushDebugMessage(AttrLevel1..AttrName1..AttrLevel2..AttrName2..AttrLevel3..AttrName3)
	]], aaa, shuxing))
    return tonumber(tem)
end

function 取身上装备位置精通条数(装备位置名称, shuxing)
    local tem = 0
    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            tem = 取身上精通条数(SelfEuipList[i].equipIndex, shuxing)
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
							PushDebugMessage("智能右击物品:"..GetName.."|背包位置:"..i)
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
        屏幕提示("参数错误,穿上装备")
        屏幕提示("参数错误,穿上装备")
        屏幕提示("参数错误,穿上装备")
        延时(2000)
        return
    end

    for i = 1, #SelfEuipList do
        if SelfEuipList[i].name == 装备位置名称 then
            for k = 1, 5 do
                if 窗口是否出现("SelfEquip") == 1 then
                    使用物品(装备名称);
                    延时(2000)
                    if 取身上装备ID(SelfEuipList[i].equipIndex) > 0 then
                        MentalTip("成功穿上" .. 装备名称 .. "|在位置:" .. 装备位置名称)
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

-- -----------------------------------------------------------------------------------


function 装备淬炼(装备位置名称, attr, 数量)
    local JT_SHUXING = ""
    if attr == "体力" then
        JT_SHUXING = "con"
    elseif attr == "火" then
        JT_SHUXING = "attack_fire"
    elseif attr == "玄" then
        JT_SHUXING = "attack_light"
    elseif attr == "冰" then
        JT_SHUXING = "attack_cold"
    elseif attr == "毒" then
        JT_SHUXING = "attack_poison"
    end
    if JT_SHUXING == "" then
        MentalTip("精通淬炼,请设置好参数")
        延时(1000)
        return
    end

    local equipName = 取身上装备位置名字(装备位置名称)

    MentalTip("精通淬炼," .. 装备位置名称 .. attr .. 数量)

    if 指定装备淬炼列表 ~= nil and 指定装备淬炼列表 ~= '' then
        if not string.find(指定装备淬炼列表, equipName) then
            MentalTip(string.format('【%s】不在指定装备列表, 跳过该装备', equipName))
            延时(200)
            return
        end
    end

    local 精通条数 = 取身上装备位置精通条数(装备位置名称, JT_SHUXING)
    MentalTip("你当前的位置:" .. 装备位置名称 .. "已满足的属性条数:" .. 精通条数)
    if 精通条数 >= 数量 then
        MentalTip("你的装备位置: " .. 装备位置名称 .. " 满足的精通条数 >=" .. 数量)
        延时(200)
        return
    end

    if 获取背包物品数量("离火") < 15 then
        MentalTip("离火不够15个 放弃精通淬炼")
        return
    end

    if 到数值(获取人物信息(45) + 获取人物信息(52)) < 3 * 10000 then
        MentalTip("精通淬炼,金币不够")
        return
    end

    跨图寻路("苏州", 364, 245)

    local 装备名称 = 取下装备获取名字(装备位置名称);
    MentalTip(string.format("准备淬炼【%s】位置上的【%s】", 装备位置名称, 装备名称));
    延时(2000)
    if 装备名称 == 0 then
        return -1
    else
        LPindex = 获取背包物品位置(装备名称) - 1
    end

    for iii = 1, 999 do
        local tem = LUA_取返回值(string.format([[
            local index = tonumber(%d)

            local equip_level = LifeAbility : Get_Equip_Level(index);
            if equip_level < 80 then
                PushDebugMessage("装备等级不够不能淬炼")
                return 2
            end

            local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
            if selfMoney < 50000 then
                PushDebugMessage("离火金币不够")
                return 2
            end

            local theAction = EnumAction(index, "packageitem")
            JT_ABC = tostring("%s")
            local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(0);
            if	string.find(pName, JT_ABC)  then
                JT_AAA = 1
            else
                JT_AAA = 0
            end

			local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(1);		
            if string.find(pName, JT_ABC)  then
                JT_BBB=1
            else
                JT_BBB=0
            end
				
            local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(2);
            if string.find(pName,JT_ABC )  then
                JT_CCC=1
            else
                JT_CCC=0
            end

			local JT_shuliang = JT_AAA + JT_BBB + JT_CCC
            if  JT_shuliang >= 1 then
                local itemneed=PlayerPackage:CountAvailableItemByIDTable(20700063)
                if itemneed < 15 then
                    PushDebugMessage("离火不够")
                    return 2
                end
            end
		
			PushDebugMessage("精通属性序号:"..JT_AAA..JT_BBB..JT_CCC)
            if JT_AAA+JT_BBB+JT_CCC>=%d then
                PushDebugMessage("精通属性足够数量,不再淬炼")
                return 2
            end
					
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("EquipCuiLian");
				Set_XSCRIPT_ScriptID(890088);
				Set_XSCRIPT_Parameter(0,index);
				Set_XSCRIPT_Parameter(1,JT_AAA)
				Set_XSCRIPT_Parameter(2,JT_BBB)
				Set_XSCRIPT_Parameter(3,JT_CCC)
				Set_XSCRIPT_ParamCount(4);
			Send_XSCRIPT();	
		]], LPindex, JT_SHUXING, 数量), "d")
        延时(500)
        if tonumber(tem) == 2 then
            break
        end
    end
    延时(500)
    穿上装备(装备位置名称, 装备名称)
end

function GetMainAttr()
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
    return tem
end

function 全自动淬炼(sameAttrNum)
    if 取身上全部钱() < 5 * 10000 then
        MentalTip("金币不够放弃精通淬炼")
        return
    end
    if sameAttrNum == 1 then
        离火数量 = 10
    end
    if sameAttrNum == 2 then
        -- 洗双属性
        离火数量 = 15
    end
    if sameAttrNum == 3 then
        -- 洗三属性
        离火数量 = 20
    end

    if 获取背包物品数量("离火") < 离火数量 then
        MentalTip("离火不够放弃精通淬炼")
        return
    end

    local myMainAttr = GetMainAttr()
    MentalTip("您的主属性为:" .. myMainAttr)

    if menpai == "峨嵋" then
        装备淬炼("腰带", "体力", sameAttrNum)
        装备淬炼("护肩", "体力", sameAttrNum)
        装备淬炼("手套", "体力", sameAttrNum)
        装备淬炼("鞋子", "体力", sameAttrNum)
        装备淬炼("帽子", "体力", sameAttrNum)
        装备淬炼("衣服", "体力", sameAttrNum)
        装备淬炼("戒指上", myMainAttr, sameAttrNum)
        装备淬炼("戒指下", myMainAttr, sameAttrNum)
        装备淬炼("护符上", myMainAttr, sameAttrNum)
        装备淬炼("护符下", myMainAttr, sameAttrNum)
        装备淬炼("护腕", myMainAttr, sameAttrNum)
        装备淬炼("项链", myMainAttr, sameAttrNum)
    else
        装备淬炼("戒指上", myMainAttr, sameAttrNum)
        装备淬炼("戒指下", myMainAttr, sameAttrNum)
        装备淬炼("护符上", myMainAttr, sameAttrNum)
        装备淬炼("护符下", myMainAttr, sameAttrNum)
        装备淬炼("护腕", myMainAttr, sameAttrNum)
        装备淬炼("项链", myMainAttr, sameAttrNum)
        装备淬炼("腰带", "体力", sameAttrNum)
        装备淬炼("护肩", "体力", sameAttrNum)
        装备淬炼("手套", "体力", sameAttrNum)
        装备淬炼("鞋子", "体力", sameAttrNum)
        装备淬炼("帽子", "体力", sameAttrNum)
        装备淬炼("衣服", "体力", sameAttrNum)
    end
end

-- main 执行区域 -------------------------------------------------------------------------------------------
local 人物名称, menpai, PID, 远近攻击, 内外攻击, 角色账号, 门派地址, 技能状态, 性别 = 获取人物属性()
取出物品("金币")
取出物品("离火")
存物品("离火", 不存物品, 0, 1, 1)
全自动淬炼(1) --属性条数
全自动淬炼(2)
全自动淬炼(3)
存物品("离火")
存物品("金币")
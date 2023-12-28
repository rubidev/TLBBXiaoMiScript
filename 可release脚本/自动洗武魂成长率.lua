用不绑定的洗 = 0
用绑定的洗 = 1

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

function GetWornWHName()
    local tem = LUA_取返回值("return EnumAction(18,'equip'):GetName();")
    return tem
end

function GetWornWHID()
    local tem = LUA_取返回值("return EnumAction(18,'equip'):GetID();")
    return tonumber(tem)
end

function GetWornWHINFO(index)
    if not index then
        index = 1
    end
    local tem = LUA_取返回值(string.format([[
		local index=%d
		local tem = -1
		local wuhution=EnumAction(18,"equip")
		local id  =wuhution:GetID();
		if  id > 0 then
			if index == 1 then
				tem = 	DataPool:GetKfsData("NAME")  -- 名字
			elseif index == 2 then	
				 tem = DataPool:GetKfsData("EXTRALEVEL")  --合成等级
			elseif index == 3 then
				 tem =DataPool:GetKfsData("LEVEL");  --等级
			elseif index == 4 then
				 tem =DataPool:GetKfsData("LIFE");  --寿命		
			elseif index == 5 then
				 tem =LifeAbility:GetWearedEquip_HoleCount(18); --打孔数量
			elseif index == 6 then
				 tem =DataPool:GetKfsData("EXP");  --当前经验
			elseif index == 7 then
				 tem =DataPool:GetKfsData("NEEDEXP");  --最大经验				
			elseif index == 8 then	  --属性攻击
					tem =""
					for i=1,10 do
						local iText , iValue = DataPool:GetKfsFixAttrEx(i - 1)		
						if iText ~= nil and iText ~= "" and iValue ~= nil and iValue > 0  then
							tem =tem..iText.."|"
						end		
					end
			elseif index == 9 then	
				return id
			end
		end	--ID 
			return tem
		]], index))
    return tem
end

function DownWornWH(index)
    if not index then
        if GetWornWHINFO(4) <= 0 then
            MentalTip("武魂没有寿命不执行")
            return 0
        end
    end

    if GetWornWHID() > 0 then
        WHName = GetWornWHName()
        MentalTip(string.format("您的武魂为 【%s】", WHName))
    else
        MentalTip("您身上没武魂")
        return 0
    end

    for i = 1, 5 do
        LUA_Call("MainMenuBar_SelfEquip_Clicked();", -1)
        延时(2000)
        if 窗口是否出现("SelfEquip") then
            --同组命令 等待窗口出现()
            LUA_Call("setmetatable(_G, {__index = Wuhun_Env});Wuhun_Equip_Clicked(0);")
            延时(2000)
            if LUA_取返回值("return EnumAction(18,'equip'):GetID();") == "0" then
                --检测脱下装备成功
                LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();", -1)
                延时(500)
                return tostring(WHName)
            end
        end
    end

    LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();", -1)
    延时(1500)

    if GetWornWHID() == 0 then
        return tostring(WHName)
    else
        return 0
    end
end

function GetDownedWHBKIndex(WHName, WHEXTRALEVEL, isBind)
    if isBind == 0 or not isBind then
        tbangding = 10
    elseif isBind == 1 then
        tbangding = 0
    elseif isBind == 2 then
        tbangding = 1
    end

    local tem = LUA_取返回值(string.format([[
        local tolvele = tonumber(%d)
        local tbangding = tostring("%s")
        name = "%s"
        for i=0,99 do
            local theAction = EnumAction(i,"packageitem")
            local ID = theAction:GetID();
            if ID > 0 then
                local GetName=theAction:GetName();
                if string.find(name,GetName) then
                    local Status = GetItemBindStatus(i);
                    local level = PlayerPackage:GetBagKfsData(i,"EXTRALEVEL")
                    if string.find(tbangding,tostring(Status)) then
                        if level == tolvele then
                            return i
                        end
                    end
                end
            end
        end
        return    -1
			]], WHEXTRALEVEL, tbangding, WHName))
    return tonumber(tem)
end


function UseItem(index) --背包序号
	LUA_Call(string.format([[
		local theAction = EnumAction(%d, "packageitem");
		if theAction:GetID() ~= 0 then
				setmetatable(_G, {__index = Packet_Env});
				local oldid = Packet_Space_Line1_Row1_button:GetActionItem();
				Packet_Space_Line1_Row1_button:SetActionItem(theAction:GetID());
				Packet_Space_Line1_Row1_button:DoAction();
				Packet_Space_Line1_Row1_button:SetActionItem(oldid);
		end
	]], index))
end

function WashBKWH(BKIndex)
    LUA_Call(string.format([[
        m_Equip_Idx = %d
        g_YBCheck = %d
        PlayerPackage:Kfs_Op_Do(12, m_Equip_Idx, 0, 0, g_YBCheck)
    ]], BKIndex, 1))

end

function main()
    取出物品("回天神石")
    取出物品("金币")
    存物品("回天神石", 不存物品, 0, 1, 1)
    local WHEXTRALEVEL = GetWornWHINFO(2)
    local WHName = GetWornWHINFO(1)
	DownWornWH(1)
    local BKIndex = GetDownedWHBKIndex(WHName, WHEXTRALEVEL, 2)
    MentalTip('摘下的武魂在背包中的索引为' .. BKIndex)
	MoveToPos("大理",138,195)
    local HTSSNum = 获取背包物品数量("回天神石")
    for i=1, HTSSNum do
        WashBKWH(BKIndex)
        延时(500)
    end

	坐骑_下坐骑()
	坐骑_下坐骑()

	UseItem(BKIndex)


    存物品("回天神石")
    存物品("金币")
end


-- main ----------------------------------------------------------------------
main()

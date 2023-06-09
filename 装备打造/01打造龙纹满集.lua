

function 晴天_右击使用物品(index) --背包序号
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

function 晴天_卖出物品(物品列表,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	for i=0,59 do
			local tem = LUA_取返回值(string.format([[
				tbangding =tostring("%s")
				i =%d
				ttname = "%s"
				local theAction=EnumAction(i,"packageitem")
			    local GetName=theAction:GetName()
				local szItemNum =theAction:GetNum();
				local Status=GetItemBindStatus(i);
					if GetName~=nil and GetName ~="" then
						if string.find(ttname,GetName ) then
							if string.find(tbangding,tostring(Status)) then
								PushDebugMessage("出售物品:"..GetName.."|背包位置:"..i)
								return 1
							end	
						end
					end
				return -1
					]],tbangding, i,物品列表))
				if tonumber(tem)==1 then 
					for k=1,5 do
						if 窗口是否出现("Shop")==1 then
							晴天_右击使用物品(i)
							延时(1000)
							break
						else
							跨图寻路("苏州",184,274)
							对话NPC("张进宝")
							延时(1000)
						end
					end
					延时(200)
			end
		end
end


function  晴天_取身上龙纹合成等级()
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local  Level = LifeAbility:GetWearedLongWen_Level(19)
			return Level
		end
		return -1
	]]))
	return tonumber(tem)
end

function  晴天_取身上龙纹星级等级()
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local nQua = LifeAbility:GetWearedLongWen_Star(19)
			return nQua
		end
		return -1
	]]))
	return tonumber(tem)
end

function  晴天_取身上龙纹信息(AAA)
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local nExAttLevel = LifeAbility:GetWearedLongWen_AttLevel(19, %d-1)
			return nExAttLevel 
		end
		return -2	
	]], AAA))
	return tonumber(tem)
end

function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
		--#Y
	]], strCode))
end





function 晴天_全自动清理龙纹材料(星级材料列表)
	local 龙纹合成等级 =晴天_取身上龙纹合成等级()

	if 龙纹合成等级>=100 then
		local str= string.format("当前龙纹等级:[%d]满级了,执行清理材料",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("龙纹玉灵|铸纹血玉")
		晴天_卖出物品("龙纹玉灵|铸纹血玉",2)
	else
		local str= string.format("当前龙纹等级:[%d]没有满级,跳过清理材料任务",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
	end
	local 龙纹星级等级= 晴天_取身上龙纹星级等级()
	if 龙纹星级等级 >= 8 then
		local str= string.format("当前龙纹星级等级:[%d]满级了,执行清理材料",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品(星级材料列表)
		晴天_卖出物品(星级材料列表,2)
	else
		local str= string.format("当前龙纹星级等级:[%d]没有满级,跳过清理材料任务",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)	
	end

	local 龙纹血上限等级=  晴天_取身上龙纹信息(1)
	local 龙纹减抗等级 = 晴天_取身上龙纹信息(2)
	local 龙纹属性攻击等级 = 晴天_取身上龙纹信息(3)
	if 龙纹血上限等级 >= 10 then
		local str= string.format("龙纹血上限等级:[%d]满级了,执行清理材料",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·元")
		晴天_卖出物品("缀龙石·元",2)
	else
		local str= string.format("龙纹血上限等级:[%d]没有满级,跳过清理材料任务",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹减抗等级 >= 10 then
		local str= string.format("龙纹减抗等级:[%d]满级了,执行清理材料",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·伤")
		晴天_卖出物品("缀龙石·伤",2)
	else
		local str= string.format("龙纹减抗等级:[%d]没有满级,跳过清理材料任务",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹属性攻击等级 >= 10 then
		local str= string.format("龙纹属性攻击等级:[%d]满级了,执行清理材料",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·暴")
		晴天_卖出物品("缀龙石·暴",2)
	else
		local str= string.format("龙纹属性攻击等级:[%d]没有满级,跳过清理材料任务",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)	
	end
end


晴天_全自动清理龙纹材料("级勾天彩合成符|初级勾天彩合成符|中级勾天彩|初级勾天彩|玉龙髓")
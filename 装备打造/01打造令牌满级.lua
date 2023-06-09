------------------------------------------------
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
	for i=0,199 do
			local tem = LUA_取返回值(string.format([[
				local tbangding =tostring("%s")
				local i =%d
				local ttname = "%s"
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


function  晴天_取身上令牌信息(index)
	local aaa=  LUA_取返回值(string.format([[ 
			index = %d
			local nType,BaoZhu1,BaoZhu2,BaoZhu3,BaoZhu4,nQual = DataPool:GetLingPaiInfo()
			--local IconName,ItemName = DataPool:GetLingPaiBaoZhuIconName(1)
			if nType> 0 then
				if index == 1 then
					return BaoZhu1
				end
				if index == 2 then
					return BaoZhu2
				end
				if index == 3 then
					return BaoZhu3
				end
				if index == 4 then
					return BaoZhu4
				end	
				if index == 5 then
					return nQual
				end	
									
			end
			return -1
	]], index))
	return tonumber(aaa)
end


function 晴天_全自动令牌处理材料()
	if 晴天_取身上令牌信息(1)>=50 and 晴天_取身上令牌信息(2)>=50 and  晴天_取身上令牌信息(3)>=50 and  晴天_取身上令牌信息(4)>=50 then
		取出物品("翡翠心精")
		晴天_卖出物品("翡翠心精",2)
		else
		屏幕提示("宝珠都没满")
		
	end
	
	local 当前身上令牌等级 =晴天_取身上令牌信息(5) 
	if 当前身上令牌等级>=8 then
		local 提示 =string.format("令牌星级提升当前等级[%d]",当前身上令牌等级)
		晴天_友情提示(提示) 
		延时(1000)
		取出物品("唤灵液")
		晴天_卖出物品("唤灵液",2)
		else
			local 提示 =string.format("令牌星级提升当前等级[%d],跳过任务",当前身上令牌等级)
		晴天_友情提示(提示) 
	end
end


晴天_全自动令牌处理材料()
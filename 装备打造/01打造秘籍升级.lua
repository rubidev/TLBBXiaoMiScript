	function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		DebugListBox_ListBox:AddInfo("#e0000ff#u#g28f1ff".."【晴天友情提示】%s")	--
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
	]], strCode))
end

function 晴天_写角色配置项(AAA, BBB, CCC)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
	if AAA~=nil and BBB~=nil and CCC~=nil  then
		晴天_友情提示("写角色配置项|"..AAA.."|"..BBB.."|"..CCC);延时(200)
		写配置项(路径,AAA,BBB,CCC);延时(200)
	end
end

function 晴天_读角色配置项(AAA, BBB)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
    local tem =读配置项(路径,AAA,BBB)
	if tem ~=nil then
		晴天_友情提示(AAA.."|"..BBB.."=="..tem);延时(500)
		else
		return 0
	end
	return tem
end





---------------------------------------------------------必备函数-----------------------------------------------------------------
function 晴天_增加角色配置项(AAA, BBB, CCC)
     local tem =晴天_读角色配置项(AAA, BBB);延时(2000)
	if tem ~=nil or  tem ~= "" then
		if  not string.find(tem,CCC) then
			CCC=tem..CCC
			延时(2000)
			晴天_写角色配置项(AAA, BBB, CCC)
		end	
		else
		延时(2000)
		晴天_写角色配置项(AAA, BBB, CCC)
	end
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



----------------------------------------------------------------------------------------------------------------------

function 晴天_取秘籍名字(Index)	
	local tem=   LUA_取返回值(string.format([[
		Index =%d-1
		local theAction = EnumAction(Index, "combobook")
		if (theAction:GetID() ~= 0 ) then
			local bookname = Player:GetComboBookInfo(Index, "bookname");
			local nLevel = Player:GetComboBookInfo(Index, "level");
			return bookname
		end
		return -1
	]], Index))
	return tem
end

function 晴天_升级秘籍(Index)	
	LUA_取返回值(string.format([[
		local xiuweivalue =  Player : GetData( "XIUWEI" )
		Index =%d-1
		local theAction = EnumAction(Index, "combobook")
		if (theAction:GetID() ~= 0 ) then
			local levelupneed =  Player : GetComboBookInfo(Index, "nextlevelexp");
			if xiuweivalue > levelupneed then
				AskLevelupComboBook(Index);
				else
				PushDebugMessage("心得不足:"..levelupneed)
			end
		end
			]], Index))
end
	


function 晴天_兑换秘籍(index)
	跨图寻路("洛阳",219,245);延时(1500)
	对话NPC("黄云禅");延时(1500)
	NPC二级对话("兑换武林秘籍");延时(1500)
	NPC二级对话("500个",1);延时(1500)
	任务_完成(index-1)
end


function 晴天_全自动秘籍()
	if not string.find(晴天_取秘籍名字(1),"独孤九剑") then
		取出物品("秘籍残页")
		if 获取背包物品数量("秘籍残页")< 500 then
			return
		end
		晴天_兑换秘籍(1)
		坐骑_下坐骑()
		右键使用物品("独孤九剑")
		延时(10000)
		存物品("秘籍残页")
	end

	if not string.find(晴天_取秘籍名字(2),"九阴真经") then
		取出物品("秘籍残页")
		if 获取背包物品数量("秘籍残页")< 500 then
			return
		end
		晴天_兑换秘籍(2)
		坐骑_下坐骑()
		右键使用物品("九阴真经")
		延时(10000)
		存物品("秘籍残页")
	end

	if not string.find(晴天_取秘籍名字(3),"神照经") then
		取出物品("秘籍残页")
		if 获取背包物品数量("秘籍残页")< 500 then
			return
		end
		晴天_兑换秘籍(3)
		坐骑_下坐骑()
		右键使用物品("神照经")
		延时(10000)
		存物品("秘籍残页")
	end
end

function 晴天_秘籍处理()
	if string.find(晴天_取秘籍名字(1),"独孤九剑") and  string.find(晴天_取秘籍名字(2),"九阴真经") and string.find(晴天_取秘籍名字(3),"神照经") then
		晴天_卖出物品("秘籍残页",2)
	else
		存物品("秘籍残页")
	end
end


for i =1,20 do
	晴天_升级秘籍(1)	
	晴天_升级秘籍(2)	
	晴天_升级秘籍(3)
end
--晴天_全自动秘籍()
--晴天_秘籍处理()

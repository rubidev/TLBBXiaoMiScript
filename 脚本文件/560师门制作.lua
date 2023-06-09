

师门物品 = "" 




function 晴天_取背包剩余位置(nTheTabIndex)--获取背包道具栏0或材料栏1、任务栏2的空格数以及数量最多的物品序号
    local szPacketName = ""
	local CurrNum = 0
	local BaseNum = 0
	local MaxNum = 0
	if(nTheTabIndex == 0) then
		szPacketName = "base";
		CurrNum = LUA_取返回值("return DataPool:GetBaseBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetBaseBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetBaseBag_MaxNum();", "n")--最大格子数
	elseif(nTheTabIndex == 1) then
		szPacketName = "material";
		CurrNum = LUA_取返回值("return DataPool:GetMatBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetMatBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetMatBag_MaxNum();", "n")--最大格子数		
	elseif(nTheTabIndex == 2) then
		szPacketName = "quest";
		CurrNum = LUA_取返回值("return DataPool:GetTaskBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetTaskBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetTaskBag_MaxNum();", "n")--最大格子数		
	else
		return 0, -1;
	end

	local spacenum, maxnum, nIndex = LUA_取返回值(string.format([[
	        local spacenum = 0
			local maxnum = 1
			local nIndex = -1
			for i=1, %d do
				local theAction,bLocked = PlayerPackage:EnumItem("%s", i-1);
				if theAction:GetID() ~= 0 then
				   spacenum = spacenum + 1
				   local nownum = theAction:GetNum()
                   if nownum > maxnum then
				      maxnum = nownum
					  nIndex = i
                   end	                  				   
				   --local g_NeedTipItem = theAction:GetDefineID()
				   --PushDebugMessage(theAction:GetID().."/"..g_NeedTipItem.."/"..theAction:GetName().."/"..theAction:GetNum().."/"..i-1)-- (i-1)就是背包格子序号了
				end
			end
            return 	spacenum, maxnum, nIndex	
			
	]], CurrNum, szPacketName), "nnn")
	return CurrNum-spacenum, maxnum, nIndex
end



function 晴天_取角色活力()
	 local tem=  LUA_取返回值(string.format([[
	      return   Player:GetData("VIGOR")
	  ]]))  
	return tonumber(tem)
end


function 晴天_制作师门(index,材料,数量,活力值)
	清包列表 ="油钱|绿豆糕|烤玉米|芝麻饼|神定丸|回心丹|"
	if index == 1 then
		ID =163
		名称="低级制药"
	elseif index == 2 then
		ID = 164 
		名称="中级制药"
	elseif index == 3 then
		ID = 165
		名称="高级制药"	
	elseif index == 4 then
		ID = 558
		名称="初级食材"		
	elseif index == 5 then
		ID = 559
		名称="中级食材"			
	elseif index == 6 then
		ID = 560
		名称="高级食材"		
	elseif index == 7 then
		ID = 477
		名称="初级谷物配方"				
	elseif index == 8 then
		ID = 479
		名称="中级谷物配方"				
	elseif index == 9 then
		ID = 481
		名称="高级谷物配方"					
	else
		屏幕提示("请设置好")
		return
	end
	for i =1,299 do	
		取出物品(材料)
		跨图寻路("洛阳",237,306)
		坐骑_下坐骑();延时(300)
		自动清包(清包列表)
		屏幕提示("目前正在制作:"..名称)
			LUA_Call(string.format([[
	           ComposeItem_Begin(%d,1,1)
		]], ID))  
		延时(4000)
		if 获取背包物品数量(材料) < 数量 then
			break
		end
		if 晴天_取背包剩余位置(1) <=  1 then 
			存物品(师门物品)
		end	
		if 晴天_取角色活力()<= 活力值 then
			break
		end
	end
	
end

晴天_制作师门(2,"枸杞",7,5);
晴天_制作师门(2,"沉香",7,5);
晴天_制作师门(7,"沉香",7,5);

--参数 7 代表哪一个   1234567 上面对应看
--材料名字 
--需要材料数量
--需要精力
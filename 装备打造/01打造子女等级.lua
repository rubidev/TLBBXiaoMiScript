function 关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	            setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
	  end
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

function 晴天_取子女等级()
		local tem=LUA_取返回值(string.format([[
			TTCount = Infant:GetInfantCount()
			if TTCount<= 0 then
				return 0
			end
			return Infant:GetInfantLevel(0)
			]]))  
		return tonumber(tem)
end


function 晴天_取子女数据(index)
		local tem =LUA_取返回值(string.format([[
			index = %d
	        local znsl =  Infant:GetInfantCount();
			if znsl>= 0 then
				Level=Infant:GetInfantLevel(0)  --等级 
				Type=Infant:GetHeroType(0)  --阶段 
			end
			if index == 1 then
				return znsl
			elseif index == 2 then
				return Level
			elseif index == 3 then 
				return Type       --没有选择志向前为0 选择后为1 
			end			
	  ]],index));
	return tonumber(tem)
end




function 购买商会物品(名称, 数量, 价格,判断是否有物品)
     取出物品("金币",200000)  
     if 到数值(获取人物信息(45))<100000 then
		晴天_友情提示("金币不足无法购买:"..名称)
		存物品("金币")
     	    return false
     end     
     if tonumber(判断是否有物品)==1 then
      if 获取背包物品数量(名称)>=1 then
       晴天_友情提示("背包中有这个物品"..名称)
	    return false
       end
	end 
      计次循环 i=1,5 执行
             跨图寻路("洛阳",330,299)
             如果 对话NPC("乔复盛")==1 则
              延时 (1000)
               NPC二级对话("查看所有商店")
               延时 (1000)
               如果 窗口是否出现("PS_ShopList")==1 则
                          	LUA_Call([[setmetatable(_G, {__index = PS_ShopList_Env}) PS_ShopList_ChangeTabIndex(3)]])	
                            延时 (1000)
                    跳出循环
               结束    
          结束
    结束
	--搜索物品
    
    
     延时 (2000)
	LUA_Call(string.format([[	
         PlayerShop:PacketSend_Search(2 , 2, 1, "%s", 1)		
	]], 名称))
	
	延时(1500)
	--遍历第一页有没有符合条件的商品
	local tem = LUA_取返回值(string.format([[
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				local theAction = EnumAction( i - 1 , "playershop_cur_page")
				if theAction:GetID() ~= 0 then
					--物品名,店主名,所属商店ID,数量,价格
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB <= %d then
						   PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
						   --点击购买后,直接返回
						   PlayerShop:SearchPageBuyItem(i - 1, "item")
						   return true
						end
					end
				end
			end
            return false
	]], 名称, 数量, 价格), "b")
    
    延时 (2000)
	关闭窗口("PS_ShopSearch")
	关闭窗口("PS_ShopList")
	关闭窗口("Quest")	
	return tem
end





function 晴天_子女选择志向(index)   --1 毒 --2火--3冰 4毒
	LUA_Call(string.format([[
	--判断是否有子女
	local InfantCount = Infant:GetInfantCount();
	if tonumber(InfantCount) <= 0 then
		return
        else
	end
	--是否达到91级
	local level = Infant:GetInfantLevel(0)
	if tonumber(level) < 91 then
		PushDebugMessage("#{YXPY_20131118_36}")
		return
	end
    local heroType = tonumber(Infant:GetHeroType(0))
	if heroType ~= 0 then
        PushDebugMessage("[晴天] 当前已经有志向")
		return
	elseif heroType == 0 then
        PushDebugMessage("[晴天]   马上选择志向")
	    Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("ChoseInfantHeroType");
		Set_XSCRIPT_ScriptID(890630);
		Set_XSCRIPT_Parameter(0,%d);
	 	Set_XSCRIPT_ParamCount(1);
	    Send_XSCRIPT();
	end
	]], index))
end

function 晴天_子女自动选择志向()
	if 晴天_取子女数据(3)==0 and 晴天_取子女数据(2)== 91 then
		人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
		跨图寻路("洛阳",151,176)
		if string.find("唐门|星宿|丐帮", 门派) then  
			晴天_子女选择志向(1)
		elseif  string.find("逍遥|明教|", 门派) then
			晴天_子女选择志向(2)
		elseif  string.find("峨嵋|天山|武当", 门派) then
			晴天_子女选择志向(3)
		 elseif  string.find("天龙|少林|鬼谷|慕容", 门派) then
			晴天_子女选择志向(4)
		end

		else
			晴天_友情提示("当前已经有子女已经选择志向跳过任务")      		
      end  
			    延时(3000)
end

function 晴天_子女自动升级119()
	 if 晴天_取子女数据(2)< 119 and  晴天_取子女数据(2)>=91 then
		材料="典籍残页"
		取出物品(材料)
		for i=1,5 do
			if   获取背包物品数量(材料)== 0 then
				晴天_友情提示("没有升级材料:"..材料)
				购买商会物品("典籍残页", 250,80*10000,1)
			end
		 while 晴天_取子女数据(2)< 119 and  获取背包物品数量(材料)>=1 do

					  晴天_友情提示("在使用物品升级经验到119")	  
					  右键使用物品(材料)
					  延时(200)
			end
		end 
	end
end


function 晴天_子女自动91()
  if 晴天_取子女数据(1)>=1  and 晴天_取子女数据(2)< 91 then
	材料="绛紫仙露"
	--绛紫仙露|赤霞仙露|
	取出物品(材料)
	--增加购买
       while  获取背包物品数量(材料)>=1 and  晴天_取子女数据(2)< 91 do
              晴天_友情提示("升级子女"..材料)	  
               右键使用物品(材料)
               延时(300)
        end
		while  获取背包物品数量("赤霞仙露")>=1 and  晴天_取子女数据(2)< 91 do
              晴天_友情提示("升级子女赤霞仙露")	  
               右键使用物品("赤霞仙露")
               延时(300)
        end
	else
	   晴天_友情提示("子女等级>=91|跳过任务")	  
	end	
	延时(3000)
end

function 晴天_自动领养子女()
	 if 晴天_取子女数据(1)<=0  then
		执行功能("单人领养子女")
		else
		晴天_友情提示("当前已经有子女跳过任务")      
	end
	延时(3000)
end

function 晴天_子女全自动升级()
	晴天_自动领养子女()
	晴天_子女自动91()
	晴天_子女自动选择志向()
	晴天_子女自动升级119()
	--执行功能("子女五项素养")     
end


晴天_子女全自动升级()

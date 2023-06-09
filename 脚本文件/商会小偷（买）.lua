function 晴天_判断关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	        setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
	  end
end


function 晴天_九州商会购买物品(类型,名称, 数量, 最高单价,ID)   --指定商会ID
	if not ID then
		ID =789
	end	
     取出物品("金币",200000)  
     屏幕提示("九州商会购买物品:"..名称)
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
	if 类型== 2 then
			LUA_Call(string.format([[	
         PlayerShop:PacketSend_Search(2,2, 1, "%s", 1)		
	]], 名称))
	elseif  类型 == 1 then
							LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(1,1, 1, "%s", 1)	
			]], 名称))
	elseif 类型 == 3  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(3 , 10101, 1, "%s", 1)	
			]], 名称))	
	
	elseif 类型 == 4  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(4 , 10101, 1, "%s", 1)	
			]], 名称))	
	elseif 类型 == 5  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(5 , 10101, 1, "%s", 1)	
			]], 名称))	
	
	end

	
	
	延时(1500)
	--遍历第一页有没有符合条件的商品
	local tem = LUA_取返回值(string.format([[
			ID =%d
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				local theAction = EnumAction( i - 1 , "playershop_cur_page")
				if theAction:GetID() ~= 0 then
					--物品名,店主名,所属商店ID,数量,最高单价
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
						if pShopID ==ID then
							if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
							   PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
									--点击购买后,直接返回
									PlayerShop:SearchPageBuyItem(i - 1, "item")
							   return true
							end
						end
					end
				end
			end
            return false
	]], ID,名称, 数量, 最高单价), "b")
    延时 (2000)
    晴天_判断关闭窗口("PS_ShopSearch")
	晴天_判断关闭窗口("PS_ShopList")
	晴天_判断关闭窗口("Quest")	
	return tem
end


function 晴天_过滤ID九州商会购买物品(类型,名称,数量,最高单价,过滤ID)
	
     取出物品("金币",200000)  
     屏幕提示("九州商会购买物品:"..名称)
	if 窗口是否出现("PS_ShopSearch")==0  then
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
	end
	if 窗口是否出现("PS_ShopSearch")==1  then
	if 类型== 2 then
			LUA_Call(string.format([[	
         PlayerShop:PacketSend_Search(2,2, 1, "%s", 1)		
	]], 名称))
	elseif  类型 == 1 then
							LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(1,1, 1, "%s", 1)	
			]], 名称))
	elseif 类型 == 3  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(3 , 10101, 1, "%s", 1)	
			]], 名称))	
	
	elseif 类型 == 4  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(4 , 10101, 1, "%s", 1)	
			]], 名称))	
	elseif 类型 == 5  then
				LUA_Call(string.format([[	
			PlayerShop:PacketSend_Search(5 , 10101, 1, "%s", 1)	
			]], 名称))	
	
	end
	
	延时(1500)
	--遍历第一页有没有符合条件的商品
	local tem = LUA_取返回值(string.format([[
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				local theAction = EnumAction( i - 1 , "playershop_cur_page")
				if theAction:GetID() ~= 0 then
					--物品名,店主名,所属商店ID,数量,最高单价
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB/pCount <= %d and  pShopID~= %d then
						   PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
								--点击购买后,直接返回
								PlayerShop:SearchPageBuyItem(i - 1, "item")
						   return true
						end
					end
				end
			end
            return false
	]], 名称, 数量, 最高单价,过滤ID), "b")
		延时 (1000)
	end
end

function 晴天_购买自家的肉()
	取出物品("金币")
	晴天_九州商会购买物品(2,"后肘肉口粮", 1, 400*10000,243) 
end

function 晴天_兑换所有元宝(index)
	if not index then
		index = 0 
	end
	local 当前元宝数量=tonumber(获取人物信息(46))
	if 当前元宝数量>index then
		跨图寻路("钱庄",65,40)
		LUA_Call(string.format('Player:YuanBaoToTicket(tonumber(%d))',当前元宝数量))
	end
end

--晴天_兑换所有元宝(200)   --少于200不兑换
--晴天_购买自家的肉()
--晴天_智能九州商会购买物品(类型,名称, 数量, 最高单价,过滤ID)
--晴天_九州商会购买物品(4,"翻羽", 1,40*10000,1)   --子女
--晴天_九州商会购买物品(2,"龙魂玉", 200, 8,1)		--物品
--晴天_九州商会购买物品(3,"坐骑：七彩鹿", 1,40*10000,1)  --装备



for i =1 , 99 do
	--晴天_智能九州商会购买物品(2,"黄晶石(1级)", 1, 20000,243)   --类型,名称, 数量, 最高单价,过滤自己家的店ID
	晴天_过滤ID九州商会购买物品(2,"高级血祭技能书", 1, 40000,243)  
end
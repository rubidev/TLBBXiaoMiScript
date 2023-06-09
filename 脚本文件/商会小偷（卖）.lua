function 晴天_商会上架(nIndex,pirse)
	while true do
	LUA_Call(string.format([[
		setmetatable(_G, {__index = PS_ShopMag_Env})
		PS_ShopMag_Item%d:DoAction();
	]], nIndex))
	延时(200)
	local tem=LUA_取返回值(string.format([[
		setmetatable(_G, {__index = PS_ShopMag_Env})
		if PS_ShopMag_DownStall:GetText() == "下架" then
				for i =1,3 do
					PlayerShop:DownSale("item")
				end	
					return 1
		end
	]]))
	延时(200)
	if tonumber(tem) ==1 then
		LUA_Call(string.format([[
		setmetatable(_G, {__index = PS_ShopMag_Env})
		PS_ShopMag_Item%d:DoAction();
	]], nIndex))
		延时(200)
	end	
	LUA_Call(string.format([[
		setmetatable(_G, {__index = PS_ShopMag_Env})
		if PS_ShopMag_DownStall:GetText() == "上架" then
					PlayerShop:UpStall("item",%d)
		end
	]], pirse))
	end
end



function 晴天_商会上架物品(物品,单价)
		屏幕提示(单价)
	if 窗口是否出现("PS_ShopMag")==0 then
	 计次循环 i=1,5 执行
             跨图寻路("洛阳",330,299)
             如果 对话NPC("乔复盛")==1 则
              延时 (1000)
               NPC二级对话("管理合作的商店")
               延时 (1000)
               如果 窗口是否出现("PS_ShopList")==1 则
                          		    LUA_Call(string.format([[
	        setmetatable(_G, {__index = PS_ShopList_Env});PS_ShopListAccept_Clicked("manage");
	  ]]))  
                            延时 (1000)
                    跳出循环
               结束    
          结束
    结束
	延时 (5000)	
	end
	if 窗口是否出现("PS_ShopMag")==1 then
				 local tem =LUA_取返回值(string.format([[
			
						setmetatable(_G, {__index = PS_ShopMag_Env})
					for i =1,20 do
					local actIndex = PlayerShop:UIIndexToLogicIndex(0, true)
					local theAction, bLocked = PlayerShop:EnumItem(actIndex, i-1, "self");
					local theID = theAction:GetID()
					local theName =theAction:GetName()
						if theID ~= 0 then
							if theName=="%s" then
								PushDebugMessage(theName)
								return i
							end
						end
				end
				return -1
			]] ,物品))	
			延时(50)
			if tonumber(tem)>=1 then
				晴天_商会上架(tem,单价)
				 延时(500)
			end
	end
end



--晴天_商会上架物品("黄晶石(1级)",5*10000)
晴天_商会上架物品("高级血祭技能书",3*10000)

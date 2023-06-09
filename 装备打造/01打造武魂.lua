


人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
if 门派 == "天龙" then
	武魂特定名字 ="琉璃焰"
	else
	武魂特定名字 ="御瑶盘"
end

function 友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function 晴天_判断关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	        setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
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

function 晴天_取背包空位(nTheTabIndex)--获取背包道具栏0或材料栏1、任务栏2的空格数以及数量最多的物品序号
    local szPacketName = ""
	local CurrNum = 0
	local BaseNum = 0
	local MaxNum = 0
	if(nTheTabIndex == 1) then
		szPacketName = "base";
		CurrNum = LUA_取返回值("return DataPool:GetBaseBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetBaseBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetBaseBag_MaxNum();", "n")--最大格子数
	elseif(nTheTabIndex == 2) then
		szPacketName = "material";
		CurrNum = LUA_取返回值("return DataPool:GetMatBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetMatBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetMatBag_MaxNum();", "n")--最大格子数		
	elseif(nTheTabIndex == 3) then
		szPacketName = "quest";
		CurrNum = LUA_取返回值("return DataPool:GetTaskBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetTaskBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetTaskBag_MaxNum();", "n")--最大格子数		
	else
		szPacketName = "base";
		CurrNum = LUA_取返回值("return DataPool:GetBaseBag_Num();", "n")--当前格子数
		BaseNum = LUA_取返回值("return DataPool:GetBaseBag_BaseNum();", "n")--基本格子数
		MaxNum = LUA_取返回值("return DataPool:GetBaseBag_MaxNum();", "n")--最大格子数
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





--执行功能("[脚本]天机函数库 ")

function 晴天_右击天机锦囊物品(index) --背包序号
	LUA_Call(string.format([[
		local theAction, bLocked =Bank:EnumTemItem(%d);
		if theAction:GetID() ~= 0 then
				setmetatable(_G, {__index = Packet_Env});
				local oldid = Packet_Space_Line1_Row1_button:GetActionItem();
				Packet_Space_Line1_Row1_button:SetActionItem(theAction:GetID());
				Packet_Space_Line1_Row1_button:DoAction();
				Packet_Space_Line1_Row1_button:SetActionItem(oldid);
		end
	]], index))
end

function 晴天_取天机锦囊物品(物品列表,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	
	for i=0,119 do
		local tem = LUA_取返回值(string.format([[
		tbangding =tostring("%s")
		i =%d
		ttname = "%s"
		local theAction, bLocked =Bank:EnumTemItem(i);
		if theAction:GetID() ~= 0 then
			local GetName=theAction:GetName()
			local szItemNum =theAction:GetNum();
			local Status=Bank:GetTemBankItemBindStatus(i);--是否绑定
			if GetName~=nil and GetName ~="" then
				if string.find(ttname,GetName,1,true ) then
					if string.find(tbangding,tostring(Status)) then
						PushDebugMessage("取出锦囊物品:"..GetName.."|位置:"..i)
						return szItemNum
					end	
				end
			end
		end	
		return -1
		]],tbangding, i,物品列表))
  		if tonumber(tem)>= 1 then 
			if 晴天_取背包空位(1) <=1  or 晴天_取背包空位(2) <= 1 then
				break
			end
			晴天_右击天机锦囊物品(i)
			延时(1500)
		end
		延时(50)
	end
	屏幕提示("整理天机锦囊,结束")
	LUA_取返回值("setmetatable(_G, {__index = Packet_Temporary_Env});Packet_Temporary_CleanButtonClk();") 	--整理天机锦囊
	延时(1000)
	LUA_Call("setmetatable(_G, {__index = Packet_Temporary_Env});Packet_Temporary_CloseFunction();")
	LUA_Call("setmetatable(_G, {__index = Packet_Temporary_Env});Packet_Temporary_OnHiden();")
	延时(1500)
end


--晴天_取天机锦囊物品(取出列表,2)  --参数1存入物品名字列表 参数2:  0全部1是非绑定 2绑定 










function 晴天_取身上武魂ID()
	local tem =tonumber(LUA_取返回值("return EnumAction(18,'equip'):GetID();"))
	return tem
end
			
function 晴天_取身上武魂合成等级()
	local tem = LUA_取返回值(string.format([[
		local id  =EnumAction(18,"equip"):GetID();
		if  id > 0 then
			local data = DataPool:GetKfsData("EXTRALEVEL")
			return data
		else
		  return -1
		end	
		]]))
	return tonumber(tem)
end

function 晴天_取所有金币()
	local tem =tonumber(获取人物信息(45)+获取人物信息(52)) --金币+ 交子
	return tem
end

function 晴天_取身上武魂等级()
	if 晴天_取身上武魂ID() > 0 then
		local tem =tonumber(LUA_取返回值("return DataPool:GetKfsData('LEVEL');"))  
		return tem
	else
		return -1
	end
end

function 晴天_取身上武魂名称()
	local tem =LUA_取返回值("return EnumAction(18,'equip'):GetName();")
	return tem
end

function  晴天_取身上武魂寿命()  --300最大
    if   晴天_取身上武魂ID()>0 then
		return  tonumber(LUA_取返回值(string.format([[ 
					return DataPool:GetKfsData("LIFE")
					]])))
	else
		return -1
    end
end


function 晴天_取身上武魂名称()
	local tem =LUA_取返回值("return EnumAction(18,'equip'):GetName();")
	return tem
end

function 晴天_取背包武魂等级序号(名字,等级)
	local tem = LUA_取返回值(string.format([[
		for i=0,99 do
			 local theAction=EnumAction(i,"packageitem")
			 local ID =theAction:GetID();
			if ID > 0 then
			local GetName=theAction:GetName();
				  if string.find("%s",GetName) then		
						local level = PlayerPackage:GetBagKfsData(i,"LEVEL")
							if level  == %d  then 
								--PushDebugMessage(i)
								return i
							end	
						end
					end
				end
		return -1	
	]],名字,等级))
	return tonumber(tem)
end






function 晴天_取背包武魂序号(是否绑定,合成等级,打孔,寿命)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	local tem = LUA_取返回值(string.format([[
				local tbangding =tostring("%s")
				local ttLevel =%d
				local HoleNum =%d
				local ttLife=%d
				for i =0,99 do
					local theAction=EnumAction(i,"packageitem")
					local GetName=theAction:GetName()
					local szItemNum =theAction:GetNum();
					local Status=GetItemBindStatus(i);
					if GetName~=nil and GetName ~="" then
						if string.find("御瑶盘|琉璃焰",GetName ) and  string.find(tbangding,tostring(Status)) then
							local HoleCount=LifeAbility:GetEquip_HoleCount(i);
							if HoleCount >= HoleNum  then
								local level = PlayerPackage:GetBagKfsData(i ,"EXTRALEVEL")
								local curLife = PlayerPackage:GetBagKfsData(i, "LIFE")
								local maxLife = PlayerPackage:GetBagKfsData(i, "MAXLIFE")
								if level >=ttLevel and curLife <= ttLife then
									--PushDebugMessage("发现武魂:"..GetName.."|背包位置:"..i)
									return i
								end	
							end	
						end
					end
				end	
				return -1
					]],tbangding,合成等级,打孔,寿命))
					
	return tonumber(tem)				
end


 LUA_取返回值([[
			function qwhdj(ID)
				Lvelel =0
						if SetSuperTooltips then
							SetSuperTooltips(ID)
							Desc1 = SuperTooltips:GetDesc2()
							Lvelel = tonumber(string.gsub(Desc1 , "#cC8B88E等级:", ""))
						end
						return Lvelel
				end	
	]])
					
					
function 晴天_取背包武魂准确信息序号(名字,等级,合成等级,打孔数量,属性,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	local tem = LUA_取返回值(string.format([[
			name ="%s"
			TTLvelel=%d
			TThcLvelel =%d
			HoleNum =%d
			shuxing ="%s"
			tbangding =tostring("%s")
			for i=0,99 do
				local theAction=EnumAction(i,"packageitem")
				 local GetName=theAction:GetName();
					local Status=GetItemBindStatus(i);
					  if string.find(name,GetName) then			
						local hcLvele = PlayerPackage:GetBagKfsData(i ,"EXTRALEVEL")
						Lvelel=qwhdj(theAction:GetID())
						
						if hcLvelel  == TThcLvelel and Lvelel =TTLvelel  then 
							local HoleCount=LifeAbility:GetEquip_HoleCount(i);
							if HoleCount == HoleNum  then
								if string.find(tbangding,tostring(Status)) then
									DQshuxing=""
									local attrNum = PlayerPackage:GetBagKfsAttrExNum(i)
									if attrNum >0 then
										for k=0,attrNum-1 do
											local iText , iValue = PlayerPackage:GetKfsAttrEx(i ,k)
											DQshuxing=DQshuxing..iText.."|"									
										end
									end
									if DQshuxing==shuxing then
										return i
									end	
								end
							end	
						end
					end
				end 
			 return -1
			]], 名字,等级,合成等级,打孔数量,属性,tbangding), "n")
	return tonumber(tem)
end





function 晴天_取背包武魂指定属性序号(名字,等级,属性,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	local tem = LUA_取返回值(string.format([[
			tolvele =%d
			tbangding =tostring("%s")
			name ="%s"
			shuxing ="%s"
			for i=0,99 do
				local theAction=EnumAction(i,"packageitem")
				 local GetName=theAction:GetName();
					local Status=GetItemBindStatus(i);
					  if string.find(name,GetName) then			
						local level = PlayerPackage:GetBagKfsData(i ,"EXTRALEVEL")
						if level  ==tolvele then 
							if string.find(tbangding,tostring(Status)) then
								local attrNum = PlayerPackage:GetBagKfsAttrExNum(i)
								if attrNum >0 then
									for k=0,attrNum-1 do
										local iText , iValue = PlayerPackage:GetKfsAttrEx(i ,k)
										if string.find(iText,shuxing) then
											return i
										end										
									end
								end
							end	
						end
					end
				end 
			 return -1
			]], 等级,tbangding,名字,属性), "n")
	return tonumber(tem)
end




function 晴天_取下身上武魂(index)
	if not index then 
		if 晴天_取身上武魂寿命() <=0 then
			友情提示("武魂没有寿命不执行")
			return 0
		end	
	end	
	
	if 晴天_取身上武魂ID() > 0 then
		 武魂名称=晴天_取身上武魂名称()
		友情提示(武魂名称)
		else
		友情提示("身上没武魂")
		return 0
	end	
     for i=1,5 do
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();",-1)
         延时 (2000)
         if 窗口是否出现("SelfEquip") then   --同组命令 等待窗口出现()
              LUA_Call("setmetatable(_G, {__index = Wuhun_Env});Wuhun_Equip_Clicked(0);")    
              延时 (2000)
              if LUA_取返回值("return EnumAction(18,'equip'):GetID();")=="0" then  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();",-1)      
                   延时(500)  
                   return tostring(武魂名称) 
              end
         end      
     end
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();",-1)      
     延时(1500) 
     if 晴天_取身上武魂ID()==0 then
          return tostring(武魂名称)
     else  
          return 0
     end     
end


function 晴天_取身上武魂信息(index)
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
				tem = 	DataPool:GetKfsData("NAME")
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
		]],index))
	return tem
end

function 晴天_取背包武魂信息序号(名字,等级,过滤序号,属性,是否绑定)
	if 是否绑定 ==0 or not 是否绑定 then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	if not 过滤序号  then
		过滤序号 = -1
	end
	if not 属性  then
		属性 = ""
	end

	local tem = LUA_取返回值(string.format([[
			 tolvele =tonumber(%d)
			 tbangding =tostring("%s")
			 name ="%s"
			 xuhao =tonumber(%d)
			shuxing = "%s"
			for i=0,99 do
				 local theAction=EnumAction(i,"packageitem")
				 local ID =theAction:GetID();
				if ID > 0 then
				 local GetName=theAction:GetName();
				  if string.find(name,GetName) then		
						--PushDebugMessage(GetName)
						local Status=GetItemBindStatus(i);	
						local level = PlayerPackage:GetBagKfsData(i,"EXTRALEVEL")
						if string.find(tbangding,tostring(Status)) then
							if level  == tolvele and tonumber(i) ~= xuhao then 
								local attrNum = PlayerPackage:GetBagKfsAttrExNum(i)
								if attrNum >0 then
									for k=0,attrNum-1 do
										local iText , iValue = PlayerPackage:GetKfsAttrEx(i ,k)
										if string.find(iText,shuxing) then
											return i
										end										
									end
								end
							end	
						end
					end
					end	
				end 
		return    -1
			]], 等级,tbangding,名字,过滤序号,属性))
	return tonumber(tem)
end

function 晴天_窗口确定()     --晴天点击确认
	if  窗口是否出现("MessageBox_Self")==1 then
		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
		延时(2000)
	end
end

function 晴天_装备武魂(物品列表,是否绑定,合成等级,打孔数量,寿命,属性)
	--物品列表="御瑶盘|琉璃焰"
	取出物品(物品列表)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	if not 合成等级  then
		合成等级=1
	end	
	if not 打孔数量  then
		打孔数量=1
	end	
	if not 寿命  then
		寿命=1
	end


	--友情提示("判断背包合成等级≥[%d],打孔数量≥[%d]寿命>=[%d]属性含有[%s]",合成等级,打孔数量,寿命,属性)
	延时(2000)
	
	for i=0,99 do
			local tem = LUA_取返回值(string.format([[
				tbangding =tostring("%s")
				i =%d
				local ttname = "%s"
				local ttlevel =%d
				local HoleNum =%d
				local ttLife =%d
				local  shuxing ="%s"
				local theAction=EnumAction(i,"packageitem")
			    local GetName=theAction:GetName()
				local szItemNum =theAction:GetNum();
				local Status=GetItemBindStatus(i);
					if GetName~=nil and GetName ~="" then
						if string.find(ttname,GetName ) then
							local HoleCount=LifeAbility:GetEquip_HoleCount(i);
							local curLife = PlayerPackage:GetBagKfsData(i, "LIFE")
							local maxLife = PlayerPackage:GetBagKfsData(i, "MAXLIFE")
							if string.find(tbangding,tostring(Status)) and HoleCount >= HoleNum  then
									local level = PlayerPackage:GetBagKfsData(i ,"EXTRALEVEL")
									if level >=ttlevel  and curLife >= ttLife then
										
								local attrNum = PlayerPackage:GetBagKfsAttrExNum(i)
								if attrNum >0 then
									for k=0,attrNum-1 do
										local iText , iValue = PlayerPackage:GetKfsAttrEx(i ,k)
										if string.find(iText,shuxing) then
											PushDebugMessage("使用武魂:"..GetName.."|背包位置:"..i)
											return 1
										end										
									end
								end
									
									end	
							end	
						end
					end
				return -1
					]],tbangding, i,物品列表,合成等级,打孔数量,寿命,属性))
				if tonumber(tem)==1 then 
					for k=1,5 do
							晴天_判断关闭窗口("Shop")
							延时(2000)
							坐骑_下坐骑()
							延时(2000)
							晴天_右击使用物品(i)
							延时(2000)
							晴天_窗口确定()
							延时(10000)
							break
					end
					延时(200)
			end
		end
end

function 晴天_九州商会购买普通武魂(类型,名称, 数量, 最高单价)
		友情提示("九州商会购买物品:"..名称)
		取出物品(名称)
		延时(3000)
		取出物品("金币",1000000)  

		if 窗口是否出现("PS_ShopSearch") == 0 then
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
	end
	--搜索物品
	  
	if 窗口是否出现("PS_ShopSearch") == 1 then	
			LUA_Call(string.format([[	
			Lexing=tonumber(%d)
			if Lexing == 1 then  
				soushuo = 1
			elseif   Lexing == 2 then 
				soushuo = 2
			else 
				soushuo = 10101
			end
		setmetatable(_G, {__index = PS_ShopSearch_Env})
         PlayerShop:PacketSend_Search(Lexing,soushuo, 1, "%s", tonumber(1))		
	]],类型,名称))
	延时(2000)
	--遍历第一页有没有符合条件的商品
	local tem = LUA_取返回值(string.format([[
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				theAction = EnumAction( i - 1 , "playershop_cur_page")
				TTID=theAction:GetID() 
				if TTID~= 0 then
					--物品名,店主名,所属商店ID,数量,总价格
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )		
					local holdMoney = Player:GetData( "MONEY" )
					if  pYB ~= nil  then 
					if pYB > holdMoney then 
						return false
					end	
					end		
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
						 --  PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
						   --点击购买后,直接返回
							PlayerShop:SearchPageBuyItem(i - 1, "item")
							return true
						end
					end
				end
			end
            return false
	]], 名称, 数量, 最高单价), "b")
		if tem then 
			延时 (2000)
		end
	end
    --晴天_判断关闭窗口("PS_ShopSearch")
	--晴天_判断关闭窗口("PS_ShopList")
	--晴天_判断关闭窗口("Quest")	
	--return tem
end



function 晴天_背包里武魂合成(等级,是否绑定)
	友情提示("背包武魂合成到等级:"..等级+1)
	for i =1,15 do
		主武魂序号= 晴天_取背包武魂信息序号("御瑶盘|琉璃焰",等级)
		if 主武魂序号 < 0 then
			return
		end
			次武魂序号 = 晴天_取背包武魂信息序号("御瑶盘|琉璃焰",等级,主武魂序号,是否绑定)
			if 次武魂序号 < 0 then
				return
			end

		LUA_Call(string.format([[
			PlayerPackage:Kfs_Op_Do(3,%d,%d)
		]], 主武魂序号,次武魂序号), "n")
		延时(1000)
	end
end

function 晴天_智能合成背包武魂(等级,是否购买武魂)
	友情提示("智能合成背包武魂")
	if not 等级 then
		等级 =2
	end	
	if not 是否购买武魂 then
		等级 =0
	end	
	
	for kkk = 1, 9 do
		local 序号 =晴天_取背包武魂信息序号("御瑶盘|琉璃焰",等级)
		if  序号>= 0 then
				break
		end
		取出物品("金币")
		取出物品("御瑶盘|琉璃焰")
		延时(2000)
		if 晴天_取所有金币() <= 10000 then 
			友情提示("全自动合成武魂,钱不够1金跳过任务")
			break 
		end	
		晴天_取天机锦囊物品("御瑶盘|琉璃焰")
		for K =1,等级-1 do
			晴天_背包里武魂合成(K)
		end
		local 序号 =晴天_取背包武魂信息序号("御瑶盘|琉璃焰",等级)
		if  序号>= 0 then
				break
		end
		if tonumber( 获取人物信息(45)) <  10*10000 then 
			友情提示("金币不够,跳过购买武魂")
			return 
		end	
		if  是否购买武魂 == 1 then
			晴天_九州商会购买普通武魂(3,"御瑶盘",1, 10*10000)
			晴天_九州商会购买普通武魂(3,"琉璃焰",1, 10*10000)
		end
		
		for K =1,等级-1 do
			晴天_背包里武魂合成(K)
		end
		
	end
end


function 晴天_全自动合成武魂(目标合成等级,购买武魂)
	if not  购买武魂 then
		购买武魂 = 0 
	end	

	for i =1,7 do	
		local 身上武魂等级 = tonumber(晴天_取身上武魂信息(3))
		local 武魂名字 = 晴天_取身上武魂信息(1)   
		local 武魂合成等级 = tonumber(晴天_取身上武魂信息(2) )
		local 武魂寿命 =晴天_取身上武魂信息(4)   
		local 武魂打孔数量 =晴天_取身上武魂信息(5)   
		
		--if 身上武魂等级<=1 then
		--	友情提示("身上武魂等级[%d]级了跳过合成",身上武魂等级)
			--return
		--end	
		if 	 tonumber (武魂合成等级 ) >= 目标合成等级 then
			友情提示("身上武魂[%d]级了跳过合成",目标合成等级)
			延时(1000)
			return
		end
		取出物品("金币")
		if 晴天_取所有金币() <= 10000 then 
			友情提示("全自动合成武魂,钱不够1金跳过任务")
			return 
		end	
		
		晴天_智能合成背包武魂(武魂合成等级,购买武魂)
		
		local 次武魂序号 =晴天_取背包武魂信息序号("御瑶盘|琉璃焰",武魂合成等级)
		if 次武魂序号 < 0 then
			友情提示("背包武魂不符合合成")
				延时(5000)
			return
			else
			友情提示("次武魂序号:"..次武魂序号)
		end
		local 主武魂名字 = 晴天_取下身上武魂()
		延时(5000)		
		local 主武魂序号=晴天_取背包武魂指定属性序号(主武魂名字,武魂合成等级,"抗性")
		屏幕提示(主武魂序号)
		--晴天_取背包武魂等级序号(主武魂名字,身上武魂等级)
		if 主武魂序号 < 0 then
			友情提示("背包主武魂序号不符合合成")
			延时(5000)
			return
		end
		LUA_Call(string.format([[
				PlayerPackage:Kfs_Op_Do(3,%d,%d)
		]], 主武魂序号,次武魂序号), "n")
		延时(1000)
		晴天_装备武魂(主武魂名字,0,武魂合成等级+1,0,1,"抗性")
		延时(3000)
	end
end


function 晴天_九州商会购买武魂(类型,名称, 数量, 最高单价,属性)
		友情提示("九州商会购买物品:"..名称)
		if 晴天_取背包武魂指定属性序号(名称,1,属性) > 0 then
				友情提示("武魂毒抗背包有")
				return
		end
		
		取出物品(名称)
		延时(3000)
		取出物品("金币",1000000)  
		for kkk = 1, 10 do
		if 窗口是否出现("PS_ShopSearch") == 0 then
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
	end
	--搜索物品
	  
	if 窗口是否出现("PS_ShopSearch") == 1 then	
			LUA_Call(string.format([[	
			Lexing=tonumber(%d)
			if Lexing == 1 then  
				soushuo = 1
			elseif   Lexing == 2 then 
				soushuo = 2
			else 
				soushuo = 10101
			end
		setmetatable(_G, {__index = PS_ShopSearch_Env})
         PlayerShop:PacketSend_Search(Lexing,soushuo, 1, "%s", tonumber(%d))		
	]],类型,名称,kkk))
	延时(2000)
	--遍历第一页有没有符合条件的商品
	local tem = LUA_取返回值(string.format([[
	        setmetatable(_G, {__index = PS_ShopSearch_Env})
			for i = 1 ,10 do 
				theAction = EnumAction( i - 1 , "playershop_cur_page")
				TTID=theAction:GetID() 
				if TTID~= 0 then
					--物品名,店主名,所属商店ID,数量,总价格
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
						 --  PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
						   --点击购买后,直接返回
							if SetSuperTooltips then
								SetSuperTooltips(TTID)
								local Propertys =SuperTooltips:GetPropertys()
								if string.find(Propertys,"%s") then
									PlayerShop:SearchPageBuyItem(i - 1, "item")
									return true
								end	
							end	
						end
					end
				end
			end
            return false
	]], 名称, 数量, 最高单价,属性), "b")

		if tem then 
			延时 (2000)
			if 晴天_取背包武魂指定属性序号(名称,1,属性) > 0 then
				友情提示("武魂毒抗背包有")
				break
			end
		end
	end
	end
    --晴天_判断关闭窗口("PS_ShopSearch")
	--晴天_判断关闭窗口("PS_ShopList")
	--晴天_判断关闭窗口("Quest")	
	--return tem
end

--------------------------------------------------


function 晴天_九州商会购买物品(类型,名称, 最小数量,最大数量, 单价,需要数量)
     取出物品("金币",200000)  
	for kkkkk=1,9 do
		 友情提示("九州商会购买物品:类型:%d|名称:%s|最小数量:%d|最大数量:%d|单价:%d|需要数量:%d",类型,名称,最小数量,最大数量,单价,需要数量)
		if 获取背包物品数量(名称)>=需要数量 then
			友情提示("背包中有这个物品"..名称)
			延时 (1000)
			break
		end
		if 窗口是否出现("PS_ShopSearch")== 0 then
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
		end
		
		延时 (2000)
		if 类型== 2 then
				LUA_Call(string.format([[	
			 PlayerShop:PacketSend_Search(2,2, 1, "%s", %d)		
		]], 名称,kkkkk))
		elseif  类型 == 1 then
								LUA_Call(string.format([[	
				PlayerShop:PacketSend_Search(1,1, 1, "%s", %d)		
		]], 名称,kkkkk))
		elseif 类型 == 3  then
					LUA_Call(string.format([[	
				PlayerShop:PacketSend_Search(3 , 10101, 1, "%s", %d)		
		]], 名称,kkkkk))
		
		elseif 类型 == 4  then
					LUA_Call(string.format([[	
				PlayerShop:PacketSend_Search(4 , 10101, 1, "%s", %d)		
		]], 名称,kkkkk))
		elseif 类型 == 5  then
					LUA_Call(string.format([[	
				PlayerShop:PacketSend_Search(5 , 10101, 1, "%s", %d)		
		]], 名称,kkkkk))	
		end
		延时(1500)
		--遍历第一页有没有符合条件的商品
		local tem = LUA_取返回值(string.format([[
				setmetatable(_G, {__index = PS_ShopSearch_Env})
				TTname ="%s"
				minCount =tonumber(%d)
				maxCount =tonumber(%d)
				danYB =tonumber(%d)
				for i = 1 ,10 do 
					local theAction = EnumAction( i - 1 , "playershop_cur_page")
					if theAction:GetID() ~= 0 then
						local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo(i - 1)			
						if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
							if pName == TTname then 
								--PushDebugMessage(pName.."|"..pShopName.."|数量:"..pCount.."|总价:"..pYB)
								if tonumber( pYB/pCount) <=danYB then	
									if 	pCount >=minCount and  pCount <= maxCount  then
										--	PushDebugMessage(pName.."|"..pShopName.."|数量:"..pCount.."|总价:"..pYB)
										PlayerShop:SearchPageBuyItem(i - 1, "item")
										return true
									end
								end
							end
						end
					end
				end
				return false
		]],名称,最小数量,最大数量,单价), "b")
		延时 (2000)
	end
    晴天_判断关闭窗口("PS_ShopSearch")
	晴天_判断关闭窗口("PS_ShopList")
	晴天_判断关闭窗口("Quest")	
end








function 晴天_自动判断购买毒抗武魂()
		友情提示("自动判断购买毒抗武魂")
		延时(2000)
		if 晴天_取身上武魂合成等级() >=3 then
			友情提示("自动判断购买毒抗武魂,身上的合成等级大于3了,不再判断购买")
			延时(2000)
			return
		end	
		if not  string.find(tostring(晴天_取身上武魂信息(8)),"毒抗性")  then
			local 主武魂序号=晴天_取背包武魂指定属性序号(武魂特定名字,1,"毒抗性")
			
			if 主武魂序号 >= 0 then 
				友情提示("有特定的武魂:%s",武魂特定名字)
				
				晴天_装备武魂(武魂特定名字,0,1,0,0,"毒抗性")
			else
				晴天_九州商会购买武魂(3,武魂特定名字,1, 50*10000,"毒抗性") --需要小工具加持
				延时(3000)
			end
		end
end


function 晴天_检测合成武魂(等级)
		友情提示("检测合成武魂等级到[%d]",等级)
		延时(2000)
		local 身上武魂合成等级 =晴天_取身上武魂合成等级()
		if  身上武魂合成等级>=等级 then
			友情提示("检测合成武魂等级到%d,跳过任务",等级)
			延时(2000)
			return
		end
		if  string.find(tostring(晴天_取身上武魂信息(8)),"毒抗性") or 晴天_取身上武魂合成等级()>=5  then
			取出物品("御瑶盘|琉璃焰")
			晴天_全自动合成武魂(等级,0)  ---参数2 为1时候买武魂
		else
			for k =1, 7 do
				local 主武魂序号=晴天_取背包武魂指定属性序号(武魂特定名字,k,"毒抗性")
				if 主武魂序号>= 0 then
					友情提示("武魂序号为%d",主武魂序号)
					晴天_装备武魂(武魂特定名字,0,1,0,0,"毒抗性")
				end
			end	
		end
end

function 晴天_武魂提升等级()
	for i= 1, 99 do
		if string.find(tostring(晴天_取身上武魂信息(8)),"毒抗性")  then	
				if tonumber(晴天_取身上武魂信息(3))  >=tonumber(获取人物信息(26)) then			
					友情提示("武魂提升等级,武魂等级已经到人物等级啦,自动清理灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤,跳过任务")
					自动清包("灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤")
					延时(2000)
					return
				end	
				取出物品("灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤")
				local 数量 =获取背包物品数量("灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤")
				if 数量> 0 then
					for i= 1, 数量 do 
						if tonumber(晴天_取身上武魂信息(3))  >=tonumber(获取人物信息(26)) then
							return
						end	
						右键使用物品("灵魂碎片·橙")
						右键使用物品("灵魂碎片·黄")
						右键使用物品("灵魂碎片·赤")
						延时(300)
					end
				else
					晴天_九州商会购买物品(2,"灵魂碎片·黄",50,250, 60000,1)
					local 数量 =获取背包物品数量("灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤")
						if 数量<= 0 then
							break
						end	
				end
			--end
		end	
	end
	自动清包("灵魂碎片·橙|灵魂碎片·黄|灵魂碎片·赤")
end

function 晴天_修理武魂(武魂位置,材料位置)
	跨图寻路("大理",138,195)
		LUA_Call(string.format([[
			PlayerPackage:Kfs_Op_Do(4 ,%d ,%d,1,1) 
	]], 武魂位置,材料位置))
end



function 晴天_智能修理武魂()
	友情提示("智能修理武魂")
	if 晴天_取背包空位(1)<= 1 then 
		友情提示("智能修理武魂,背包空位不足,跳过任务");延时(1000)
		return 
	end	
	
	if 晴天_取身上武魂信息(9) >0 then
		local 武魂寿命 = tonumber(晴天_取身上武魂信息(4))
		友情提示("你的武魂寿命%d",武魂寿命);延时(1000)
		if 武魂寿命== 0 then
			--- or	tonumber(晴天_取身上武魂合成等级() )>=5 
			if string.find(tostring(晴天_取身上武魂信息(8)),"毒抗性") then 	
				友情提示("开始修理身上的武魂")
				延时(2000)	
				晴天_九州商会购买物品(2,"武魂延寿丹", 1,10, 30*10000,1)
				if 获取背包物品数量 ("武魂延寿丹") >=1 then
					背包武魂延寿丹序号 =获取背包物品位置("武魂延寿丹")-1
					延时(3000)
				else
					友情提示("金币不够买不到武魂延寿丹,跳过任务")
					return
				end
				
				local 身上武魂等级 = tonumber(晴天_取身上武魂信息(3))
				local 武魂名字 = 晴天_取身上武魂信息(1)   
				local 武魂合成等级 = tonumber(晴天_取身上武魂信息(2) )
				local 武魂打孔数量 =晴天_取身上武魂信息(5)   
				延时(2000)
				local 武魂名字 = 晴天_取下身上武魂(1)
				延时(3000)
				local 武魂序号=	晴天_取背包武魂序号(2,武魂合成等级,武魂打孔数量,0)
				if 武魂序号>=0 then
					晴天_修理武魂(武魂序号,背包武魂延寿丹序号)
					延时(2000)
					晴天_装备武魂(武魂名字,2,武魂合成等级,武魂打孔数量,300,"")
					存物品("武魂延寿丹",不存物品,0,0,0)
					延时(2000)
				else	
					return		
				end
			end
		else
			local 武魂序号=	晴天_取背包武魂序号(2,1,4,0)
			if 武魂序号>0 then
				友情提示("背包中有打孔大于4 合成大于2的 0寿命武魂 开始修理");延时(1000)
				晴天_九州商会购买物品(2,"武魂延寿丹", 1,10, 30*10000,1)
				if 获取背包物品数量 ("武魂延寿丹") >=1 then
					背包武魂延寿丹序号 =获取背包物品位置("武魂延寿丹")-1;延时(3000)
					晴天_修理武魂(武魂序号,背包武魂延寿丹序号)
					坐骑_下坐骑();延时(2000)
					晴天_右击使用物品(武魂序号);延时(5000)
				
				else
					友情提示("金币不够买不到武魂延寿丹,跳过任务")
					return
				end
			end
			
			
		end	
	end	
end




function 晴天_背包修理武魂(是否绑定,合成等级,打孔数量,寿命)
	背包受伤的武魂序号 =晴天_取背包武魂序号(是否绑定,合成等级,打孔数量,寿命) 
	if 背包受伤的武魂序号 >=0 then
			--友情提示("背包有合成等级≥[%d],打孔≥[%d],寿命<=[%d]的武魂...准备修理",合成等级,打孔数量,寿命)
			取出物品("金币")
		if 晴天_取所有金币() <= 50000 then 
			友情提示("背包有受伤的武魂..准备修理钱不够5金跳过任务")
			return 
		end	
		晴天_九州商会购买物品(2,"武魂延寿丹", 1,10, 30*10000,1)
		if 获取背包物品数量 ("武魂延寿丹") >=1 then
			背包武魂延寿丹序号 =获取背包物品位置("武魂延寿丹")-1
			延时(3000)
			else
			return
		end
		晴天_修理武魂(背包受伤的武魂序号,背包武魂延寿丹序号)
		延时(5000)
		晴天_装备武魂("御瑶盘|琉璃焰",2,合成等级,打孔数量,300,"")
		存物品("武魂延寿丹")
			
	else
		友情提示("全自动修理武魂,背包中没有受伤的武魂,跳过任务")
		--晴天_装备武魂("御瑶盘|琉璃焰",2,合成等级,打孔数量,300,"")
		return 
	end

end


-------------------------------------------------------------
function 晴天_取身上武魂技能ID(index)
		local tem = LUA_取返回值(string.format([[
			local skillID = DataPool:GetKfsSkill(index - 1)
			return skillID
	]],index))
	return tonumber(tem)
end

function 晴天_武魂技能学习()
	
	if 晴天_取身上武魂技能ID(1) ==-1 then
		友情提示("你还没有技能11111")
		延时(2000)
	end
	local 身上武魂名字 = 晴天_取身上武魂信息(1)   
	local 身上武魂等级 = tonumber(晴天_取身上武魂信息(3))
	local 身上武魂合成等级 = tonumber(晴天_取身上武魂信息(2) )
	local 身上武魂打孔数量 =晴天_取身上武魂信息(5)   
	local 身上武魂属性信息=晴天_取身上武魂信息(8)   
	友情提示("你当前的武魂名字[%s]等级[%d]合成等级[%d]打孔数量[%d]身上武魂属性信息[%s]",身上武魂名字,身上武魂等级,身上武魂合成等级,身上武魂打孔数量,身上武魂属性信息)
	延时(2000)
	晴天_取下身上武魂(1)
	延时(2000)
	local 背包序号 =晴天_取背包武魂准确信息序号(身上武魂名字,身上武魂等级,身上武魂合成等级,身上武魂打孔数量,身上武魂属性信息,2)
	
	友情提示(背包序号)
	延时(2000)
end

--晴天_武魂技能学习()
------是否绑定,合成等级,打孔数量,寿命
--晴天_背包修理武魂(2,3,0,0)
晴天_智能修理武魂()
--晴天_自动判断购买毒抗武魂()
晴天_检测合成武魂(7)
晴天_武魂提升等级()

-------------------------------------------------------------
---参数见尾行 其他不要动
----------------------------------------------------------------------------------------------------------------------------
function 晴天_判断关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	        setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
	  end
end


function 晴天_九州商会购买物品(名称, 数量, 总价格,判断是否有物品)
     取出物品("金币",200000)  
     屏幕提示(名称)
     if tonumber(判断是否有物品)==1 then
      if 获取背包物品数量(名称)>=1 then
       屏幕提示("背包中有这个物品"..名称)
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
					--物品名,店主名,所属商店ID,数量,总价格
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
	]], 名称, 数量, 总价格), "b")
    
    延时 (2000)
    晴天_判断关闭窗口("PS_ShopSearch")
	晴天_判断关闭窗口("PS_ShopList")
	晴天_判断关闭窗口("Quest")	
	return tem
end


function 晴天_自动窗口确定()     --晴天自动窗口确定
	if  窗口是否出现("MessageBox_Self")==1 then
		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
		延时(2000)
	elseif 窗口是否出现("MessageBox2_Self")==1 then
		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox2_Self_OK_Clicked();")
		延时(2000)
	end
end

while  获取背包物品数量("玄昊玉") < 190 do
	取出物品("玄昊玉")
	晴天_九州商会购买物品("玄昊玉", 190,20000)
end


function 晴天_兑换玄昊玉套装1()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换76级套装") ;延时(1500) 
		NPC二级对话("兑换明月套装") ;延时(1500) 
		任务_完成(2);延时(1500) 
	end
	右键使用物品("明月素影肩")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装0()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换76级套装") ;延时(1500) 
		NPC二级对话("兑换明月套装") ;延时(1500) 
		任务_完成(3);延时(1500) 
	end
	右键使用物品("明月素影链")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装1()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换76级套装") ;延时(1500) 
		NPC二级对话("兑换明月套装") ;延时(1500) 
		任务_完成(2);延时(1500) 
	end
	右键使用物品("明月素影肩")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装2()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换76级套装") ;延时(1500) 
		NPC二级对话("兑换倚楼套装") ;延时(1500) 
		任务_完成(1);延时(1500) 
	end
	右键使用物品("倚楼溪斜覆")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装3()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换玉骨套装") ;延时(1500) 
		任务_完成(1);延时(1500) 
	end
	右键使用物品("玉骨烟云鞋")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装4()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换玉骨套装") ;延时(1500) 
		任务_完成(3);延时(1500) 
	end
	LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click( 8,0 );")
	延时(2500) 
	右键使用物品("玉骨烟云指环")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装5()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换香焚套装") ;延时(1500) 
		任务_完成(1);延时(1500) 
	end
	右键使用物品("香焚红楼灵")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end
function 晴天_兑换玄昊玉套装6()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换香焚套装") ;延时(1500) 
		任务_完成(3);延时(1500) 
	end
	右键使用物品("香焚红楼影")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装7()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换琴横套装") ;延时(1500) 
		任务_完成(0);延时(1500) 
	end
	右键使用物品("琴横离情冠")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装8()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换琴横套装") ;延时(1500) 
		任务_完成(2);延时(1500) 
	end
	右键使用物品("琴横离情固")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

function 晴天_兑换玄昊玉套装9()
	if  获取背包物品数量("玄昊玉") >= 20 then
	跨图寻路("洛阳",215,325);延时(1500) 
	if 对话NPC("立繁") ==1  then
		NPC二级对话("玄昊玉兑换玄昊套装");延时(1500) 
		NPC二级对话("兑换86级套装") ;延时(1500) 
		NPC二级对话("兑换琴横套装") ;延时(1500) 
		任务_完成(3);延时(1500) 
	end
	LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click( 10,0 );")
	延时(2500) 
	右键使用物品("琴横离情摇")
	延时(2500) 
	晴天_自动窗口确定() 
	end
end

晴天_兑换玄昊玉套装0()--76明月素影链
晴天_兑换玄昊玉套装1()--76明月素影肩
晴天_兑换玄昊玉套装2()--76倚楼溪斜覆
晴天_兑换玄昊玉套装3()--86玉骨烟云指鞋
晴天_兑换玄昊玉套装4()--86玉骨烟云指环
晴天_兑换玄昊玉套装5()--86香焚红楼灵
晴天_兑换玄昊玉套装6()--86香焚红楼影
晴天_兑换玄昊玉套装7()--86琴横离情冠
晴天_兑换玄昊玉套装8()--86琴横离情固
晴天_兑换玄昊玉套装9()--86琴横离情摇

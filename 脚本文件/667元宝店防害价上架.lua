---------------------------------------------------------------------------------
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

执行功能("钱庄收元宝")

function 晴天_取出不绑定物品(物品)
	取出物品(物品)
	存物品(物品,不存物品,1,0,1)
end	

---------------------------------------------------------------------------------
function 关闭窗口(strWindowName)
      if 窗口是否出现(strWindowName) == 1 then
		晴天_友情提示("关闭窗口")
		LUA_Call(string.format([[
	          setmetatable(_G, {__index = %s_Env}) this:Hide()  
	   ]], strWindowName), "n")
	  end
end
---------------------------------------------------------------------------------
function 晴天_元宝店管理物品()
跨图寻路("钱庄",60,30);延时(500)
对话NPC("孙聚财");延时(500)
NPC二级对话("补收元宝",1);延时(500)
跨图寻路("钱庄",60,30);延时(1000)
对话NPC("孙聚财");延时(1000)
NPC二级对话("管理我出售的商品",1);延时(2000)
		for kkk=1 ,10 do 
			LUA_Call(string.format([[ 
						local aaa=tonumber(%d)
						local theAction = EnumAction( aaa - 1 , "ybmarket_self")
						if theAction:GetID() ~= 0 then
							local pName , nowStatus ,price, itemlefttime = Auction:GetMySellBoxItemAuctionInfo(aaa- 1 )
							if pName ~= nil then 
						--PushDebugMessage("[晴天]元宝店管理物品下架:"..pName)
						if nowStatus == 1 then
							--Auction:GetBackWhatOnSale(2 , aaa - 1  ,1)
						elseif nowStatus == 2 then
							Auction:GetBackExpired(2 , aaa- 1  ,1)
						elseif  nowStatus ==  3 then
							Auction:GetMoney(2 , aaa- 1 )
						  end
					end
				end			
				]], kkk), "n",1)
	延时(500)
	end
end



---------------------------------------------------------------------------------

function 晴天_元宝店上架物品(strKey,much,selfcount)
	晴天_取出不绑定物品(strKey)
	local nCount = 获取背包物品数量(strKey)
	local nIndex=获取背包物品位置(strKey)-1
if nCount<much then
  晴天_友情提示(strKey.."设置最低数量上架:"..much.."|目前物品数量:"..nCount.."位置:"..nIndex)
  return
end
if 窗口是否出现("YbMarket") == 0 then
	跨图寻路("钱庄",60,30);延时(500)
	对话NPC("孙聚财");延时(500)
	NPC二级对话("元宝交易市场",1);延时(500)
	延时 (500)
end

if 窗口是否出现("YbMarket") == 1 then
延时 (500)
晴天_友情提示("[晴天]开始搜索:"..strKey.."最低价格")
LUA_Call(string.format([[ 
Auction:PacketSend_Search(2 , 1,1, "%s", 1)
	]], strKey), "s",1)
延时 (2000)
local wupindanjia=LUA_取返回值(string.format([[ 
local pName , pSeller ,pCount ,pYB = Auction:GetItemAuctionInfo(0)
if pName =="%s" and pSeller ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
local AAA=pYB/pCount
--PushDebugMessage(pName.."最低单价:"..AAA)
return AAA
end
	]], strKey), "s",1)
延时 (1000)

晴天_友情提示(tonumber(wupindanjia))
if tonumber(selfcount)> tonumber(wupindanjia) then
	晴天_友情提示("商会最低价低于保护值,请设置保护价格:"..selfcount)
	bbb= math.floor(tonumber(selfcount)*nCount)
	else
	 bbb=math.floor(tonumber(wupindanjia)*nCount)--向下取整数
end

-- 上架_物品
		for i =1,99 do
			local nCount = 获取背包物品数量(strKey)
			if nCount<much then
				break
			end
				LUA_Call(string.format([[ 
				Auction:PacketSend_SellItem(tonumber(%d) , tonumber(%d) ,1) 
					]],nIndex,bbb), "s",1)
		
			end
	end
end


---------------------------------------------------------------------------------


function 晴天_古境管理物品()
跨图寻路("凤鸣镇",204,134);延时(500)
对话NPC("商弘继");延时(500)
NPC二级对话("补收元宝",1);延时(500)
NPC二级对话("补收金币",1);延时(500)

跨图寻路("凤鸣镇",204,134);延时(1000)
对话NPC("商弘继");延时(1000)
NPC二级对话("管理我出售的商品",1);延时(2000)

		for kkk=1 ,10 do 
LUA_Call(string.format([[ 
            local abcd=tonumber(%d)
			--PushDebugMessage(abcd)
					local pName ,nowStatus , price = KVKAuction:GetMySellBoxItemAuctionInfo(1, abcd - 1)
				if pName ~= nil then 
	        --PushDebugMessage("[晴天]古境管理物品下架:"..pName)
			
			if nowStatus == 1 then
				KVKAuction:GetBackWhatOnSale(1 , abcd - 1  ,1)
			elseif nowStatus == 2 then
				KVKAuction:GetBackExpired(1 , abcd- 1  ,1)
			elseif  nowStatus ==  3 then
		 	KVKAuction:GetMoney(1 , abcd- 1 )
             end
		end
	
	]], kkk), "n",1)
	延时(500)
	end
end




function 晴天_古境上架物品(strKey,much,selfcount)--
晴天_取出不绑定物品(strKey)
local nCount = 获取背包物品数量(strKey)
local nIndex=获取背包物品位置(strKey)-1

晴天_友情提示(strKey.."设置最低数量上架:"..much.."|目前物品数量:"..nCount.."位置:"..nIndex)
if nCount<much then
  晴天_友情提示(strKey.."设置最低数量上架:"..much.."|目前物品数量:"..nCount.."位置:"..nIndex)
  return
end

if 窗口是否出现("KVKMarket")== 0 then
跨图寻路("凤鸣镇",204,134);延时(500)
对话NPC("商弘继");延时(500)
NPC二级对话("古境寄售行",1);延时(500)
延时 (500)
end

if 窗口是否出现("KVKMarket") == 1 then
延时 (500)
晴天_友情提示("[晴天]开始搜索:"..strKey.."最低价格")
LUA_Call(string.format([[ 
KVKAuction:PacketSend_Search(1 ,1, 1, "%s" , 1)
	]], strKey), "s",1)
延时 (1000)
local wupindanjia=LUA_取返回值(string.format([[ 
	local pName, pSeller, pCount, pYB = KVKAuction:GetItemAuctionInfo(1,0 )
if pName =="%s" and pSeller ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
local abcd=pYB/pCount
--PushDebugMessage(pName.."最低单价:"..abcd)
return abcd
end

	]], strKey), "s",1)
延时 (1000)

晴天_友情提示(tonumber(wupindanjia))

if tonumber(selfcount)> tonumber(wupindanjia) then
	晴天_友情提示("商会最低价低于保护值,请设置保护价格:"..selfcount)
	bbb= math.floor(tonumber(selfcount)*nCount)
	else
	 bbb=math.floor(tonumber(wupindanjia)*nCount)--向下取整数
end

-- 上架_物品
LUA_Call(string.format([[ 
KVKAuction:PacketSend_SellItem(1,tonumber(%d) , tonumber(%d) ,1) 
	]],nIndex,bbb), "s",1)
end
end








function 晴天_元宝店修改物品(strKey)
if 窗口是否出现("YbMarket") == 0 then
	跨图寻路("钱庄",60,30);延时(500)
	对话NPC("孙聚财");延时(500)
	NPC二级对话("元宝交易市场",1);延时(500)
	延时 (500)
end

	if 窗口是否出现("YbMarket") == 1 then
延时 (500)
晴天_友情提示("[晴天]开始搜索:"..strKey.."最低价格")
LUA_Call(string.format([[ 
Auction:PacketSend_Search(2 , 1,1, "%s", 1)
	]], strKey), "s",1)
延时 (2000)

物品单价=LUA_取返回值(string.format([[ 
local pName , pSeller ,pCount ,pYB = Auction:GetItemAuctionInfo(0)
if pName =="%s" and pSeller ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
local AAA=pYB/pCount
--PushDebugMessage(pName.."最低单价:"..AAA)
return AAA
end
return -1
	]], strKey), "s",1)
延时 (1000)



晴天_友情提示(tonumber(物品单价))
关闭窗口("YbMarket")
end

跨图寻路("钱庄",61,29);延时(500)
对话NPC("孙聚财");延时(500)
对话NPC("孙聚财");延时(1000)
NPC二级对话("管理我出售的商品",1);延时(2000)

		for kkk=1 ,10 do 
		tem= LUA_取返回值(string.format([[ 
						local aaa=tonumber(%d)
						local theAction = EnumAction( aaa - 1 , "ybmarket_self")
						if theAction:GetID() ~= 0 then
							local pName , nowStatus ,price, itemlefttime = Auction:GetMySellBoxItemAuctionInfo(aaa- 1 )
							if pName ~= nil  then 
								g_itemNum = Auction:GetMySellBoxItemNum(aaa-1)
						--PushDebugMessage("[晴天]元宝店管理物品下架:"..pName)
						if  pName=="%s" then
							if nowStatus == 1 then
									return g_itemNum
								--Auction:GetBackWhatOnSale(2 , aaa - 1  ,1)
							elseif nowStatus == 2 then
								Auction:GetBackExpired(2 , aaa- 1  ,1)
							elseif  nowStatus ==  3 then
								Auction:GetMoney(2 , aaa- 1 )
							  end
						end	
					end
				end			
				return -1
				]], kkk,strKey), "n",1)
				if  tonumber(tem) > 0 then
					屏幕提示(tem)
					
					bbb = math.floor(物品单价*(tonumber(tem)))
					屏幕提示(bbb)
					延时(3000)
					LUA_Call(string.format([[ 
					g_Cur_Modify_Type =2
					g_Index =%d-1
					wantguidh, wantguidl = Auction:GetMyAuctionSellBoxItemGuid(g_Index)
					Auction:ChangePrice(g_Cur_Modify_Type ,g_Index , tonumber(%d), wantguidh, wantguidl)		
								]], kkk,bbb), "n",1)
				延时(500)
				end
		end
end
---------------------------------------------------------------------------------
晴天_元宝店修改物品("百淬神玉")


晴天_元宝店上架物品("灵兽丹·风（1级）",10,0.1)    --名字 数量 低价


晴天_元宝店上架物品("灵兽丹·虚（1级）",10,0.1)    --名字 数量 低价


晴天_元宝店上架物品("灵兽丹·震（1级）",10,0.1)    --名字 数量 低价


晴天_元宝店上架物品("灵兽丹·合（1级）",10,3)    --名字 数量 低价

晴天_元宝店上架物品("灵兽丹·咒（1级）",10,1)    --名字 数量 低价


晴天_元宝店上架物品("玉龙髓",200,0.1)    --名字 数量 低价


晴天_元宝店上架物品("金蚕丝",10,5)    --名字 数量 低价


晴天_元宝店上架物品("真元珀",10,3)    --名字 数量 低价

晴天_元宝店上架物品("功力丹",3,5)    --名字 数量 低价


晴天_元宝店上架物品("忆魂石",10,0.1)    --名字 数量 低价


晴天_元宝店上架物品("神亦石",10,0.1)    --名字 数量 低价


晴天_元宝店上架物品("圣兽鳞",100,0.1)    --名字 数量 低价


晴天_元宝店上架物品("净云水",100,1)    --名字 数量 低价


晴天_元宝店上架物品("伏羲玉",10,1)    --名字 数量 低价


晴天_元宝店上架物品("伏羲玉碎",10,1)    --名字 数量 低价


晴天_元宝店上架物品("回天神石",10,8)    --名字 数量 低价


晴天_元宝店上架物品("真元精珀",1,5)    --名字 数量 低价


晴天_元宝店上架物品("圣兽之魂",1,80)    --名字 数量 低价


晴天_元宝店上架物品("灵兽精魄",10,1)    --名字 数量 低价


晴天_元宝店上架物品("千淬神玉",10,1)    --名字 数量 低价

晴天_元宝店上架物品("寒冰星屑",10,1)    --名字 数量 低价

晴天_元宝店上架物品("神兵符3级",30,1)    --名字 数量 低价

晴天_元宝店上架物品("铸纹血玉",20,1)    --名字 数量 低价

晴天_元宝店上架物品("缀龙石·元",100,1)    --名字 数量 低价

晴天_元宝店上架物品("缀龙石·暴",100,1)    --名字 数量 低价


晴天_元宝店上架物品("缀龙石·伤",100,1)    --名字 数量 低价

晴天_元宝店上架物品("魂冰珠（1级）",100,1)    --名字 数量 低价

晴天_元宝店上架物品("润魂石·破（1级）",100,1)    --名字 数量 低价

晴天_元宝店上架物品("润魂石·击（1级）",50,1)    --名字 数量 低价

晴天_元宝店上架物品("润魂石·暴（1级）",100,1)    --名字 数量 低价

晴天_元宝店上架物品("润魂石·御（1级）",100,1)    --名字 数量 低价


晴天_元宝店上架物品("破·释玄属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("破·沉冰属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("破·嗜毒属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("破·落炎属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("暴·穿冰属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("暴·暗火属性书",1,50)    --名字 数量 低价



晴天_元宝店上架物品("暴·拔毒属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("暴·冲玄属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("御·参玄属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("御·疗毒属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("御·禀火属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("御·折冰属性书",1,50)    --名字 数量 低价



晴天_元宝店上架物品("击·苍玄属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("击·创毒属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("击·炽焰属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("击·寒冰属性书",1,50)    --名字 数量 低价

晴天_元宝店上架物品("贝叶经残片",20,0.3)    --名字 数量 低价



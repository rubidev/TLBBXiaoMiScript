

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

function 晴天_打开兑换元宝窗口()
LUA_Call(string.format([[
		Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("AskOpenDuihuanWindow");
		Set_XSCRIPT_ScriptID(181000);
		Set_XSCRIPT_ParamCount(0);
		Send_XSCRIPT();
		]]))
	
end

function 晴天_取装备宝石数量(装备名称)
	if 获取背包物品数量(装备名称)>0 then
         bHave=获取背包物品位置(装备名称)-1
		else
         return 5
    end  
    	 local tem=LUA_取返回值(string.format([[
            local gemcount = LifeAbility:GetEquip_GemCount(%d)
				if gemcount==nil then
					return 0
				end
                return gemcount
            	]], bHave))	
			return tonumber(tem)
end

function 晴天_领取首冲享好礼()
LUA_Call(string.format([[
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "GetGiftsForSaveUp" ); 	-- 脚本函数名称
		Set_XSCRIPT_ScriptID( 892676 );				-- 脚本编号
		Set_XSCRIPT_Parameter( 0, 1 );		-- 参数一
		Set_XSCRIPT_ParamCount( 1 );				-- 参数个数
	Send_XSCRIPT()
		]]))
end
	
取出物品"红宝石(3级)"

function 晴天_取可换取的元宝数量()
return LUA_取返回值(string.format([[
setmetatable(_G, {__index = YuanbaoExchange_Env});
str =YuanbaoExchange_Text5 : GetText()
local n1 = string.find(str,"：")
	if n1 then
		return tonumber(string.sub(str, n1+2))
	end
	return 0
	]]), "n")
end

function 晴天_点数兑换元宝(index)
 LUA_Call(string.format([[
	YB=%d
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("BuyYuanbao");
		Set_XSCRIPT_ScriptID(181000);
		Set_XSCRIPT_Parameter(0,tonumber(YB));
		Set_XSCRIPT_Parameter(1,1);
		Set_XSCRIPT_ParamCount(2);
	Send_XSCRIPT();
]],index), "n")
end

屏幕提示(晴天_取可换取的元宝数量())	
晴天_点数兑换元宝(200)
延时(3000)
晴天_领取首冲享好礼()



函数 宝石兑换()
取出物品("3级宝石兑换券")
如果 获取背包物品数量("3级宝石兑换券")>0 则
跨图寻路("钱庄",68,44)
     计次循环 i=1,5 执行
         如果 对话NPC("钱夫人")==1  则
              延时 (1000)
              NPC二级对话("使用宝石兑换券",0)
              延时 (1000)
              NPC二级对话("使用3级宝石兑换券",0)
              延时 (1000)
                        延时 (1000)
                        NPC二级对话("红宝石(3级)",0)
                        延时 (1000)
                        NPC二级对话("同意",0)
                        延时 (1000)
         结束
     结束   
  结束 
结束




function 晴天_取装备打孔数量(装备名称)
    local bHave=tonumber(获取背包物品位置(装备名称))-1
	if bHave< 0 then
        return 0
    end  
    	 local tem=LUA_取返回值(string.format([[
				return LifeAbility:GetEquip_HoleCount(%d)
            	]], bHave))	
			return tonumber(tem)
end

function 装备打孔(装备名称,打孔材料,孔位数量)
	延时(2000)
	local 已经打孔的孔数= 晴天_取装备打孔数量(装备名称)
	延时(2000)
	屏幕提示(装备名称.."已经打孔的孔数:"..已经打孔的孔数)
	if 已经打孔的孔数 >= 孔位数量 then
		屏幕提示("当前目标孔位数量"..孔位数量)
		延时(1000)
		return
	end
	if 获取背包物品数量(装备名称)>0 then
         bHave=获取背包物品位置(装备名称)-1
    end   
	
    if 获取背包物品数量(打孔材料)>0 then
         nIndex=获取背包物品位置(打孔材料)-1
		else 
		屏幕提示("打孔材料"..打孔材料.."不足")
		return
    end 
	延时(3000)
    --屏幕提示(bHave..nIndex)
	
	if tonumber(孔位数量) < 4 then
			LUA_Call(string.format([[
        Clear_XSCRIPT()
        Set_XSCRIPT_Function_Name("StilettoEx_3")
        Set_XSCRIPT_ScriptID(311200)
        Set_XSCRIPT_Parameter(0,%d)--装备位置
        Set_XSCRIPT_Parameter(1,%d)--材料位置
        Set_XSCRIPT_ParamCount(2)
        Send_XSCRIPT()
		]], bHave,nIndex))	
	else	
	if 已经打孔的孔数~= 3 then
		return
	end	
	if 打孔材料=="寒玉精粹" then
		four=2
		else
		four=1
	end
	LUA_Call(string.format([[
				Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("StilettoEx_4")
			Set_XSCRIPT_ScriptID(311200)
			Set_XSCRIPT_Parameter(0,%d)
			Set_XSCRIPT_Parameter(1,%d)
			Set_XSCRIPT_Parameter(2,%d)
			Set_XSCRIPT_ParamCount(3)
		Send_XSCRIPT()
				]], bHave,nIndex,four))	
	end	
end


function MessageBoxOK()
	延时(1000)
	if  窗口是否出现("MessageBox_Self")==1 then

		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
		延时(1000)
	end
end


		
function 元宝商店购买(AAA)
		LUA_Call("setmtatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
		延时(2000)
		LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(0);")
		延时(2000)
		LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(2);")
		延时(2000)
		LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(6);")
		延时(2000)
		if AAA==5 then
		LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();")
		延时(2000)
		LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")
		延时(2000)
		end
		MessageBoxOK()
		LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});this:Hide();")--关闭镶嵌窗口
end

function 晴天_装备上宝石(装备名称,材料名称,宝石名称,宝石位置)

	if 获取背包物品数量(装备名称)>0 then
         bHave=获取背包物品位置(装备名称)-1
		else
		return
    end   
	
    if 获取背包物品数量(材料名称)>0 then
         nIndex=获取背包物品位置(材料名称)-1
				else
		屏幕提示("元宝店购买:"..材料名称)		
		元宝商店购买(5)
    end 
    if 获取背包物品数量(宝石名称)>0 then
         bIndex=获取背包物品位置(宝石名称)-1
				else
		return
    end 
	
	装备空位的数量=晴天_取装备打孔数量(装备名称)
	if 装备空位的数量 <宝石位置 then
		return
	end
		
	
	装备宝石的数量=晴天_取装备宝石数量(装备名称)
	
	if 装备宝石的数量+1 >宝石位置 then
		屏幕提示("宝石数量足够 跳过任务")
		return 
	end	
	
	if 获取背包物品数量(材料名称)< 1 then
		元宝商店购买()
	end
	
		LUA_Call(string.format([[
        Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name("EnchaseEx_3")
		Set_XSCRIPT_ScriptID(701614)
		Set_XSCRIPT_Parameter(0,%d)--宝石
		Set_XSCRIPT_Parameter(1,%d)--装备位置
		Set_XSCRIPT_Parameter(2,%d)--材料位置
		Set_XSCRIPT_Parameter(3,-1)
		Set_XSCRIPT_Parameter(4,%d-1)--宝石装备位置
		Set_XSCRIPT_ParamCount(5)
		Send_XSCRIPT()
		]], bIndex,bHave,nIndex,宝石位置))	
end



function 晴天取下装备获取名字(装备位置名称)
     if 装备位置名称=="左戒指" then
			装备取下编号=7
			装备位置=6
		elseif 装备位置名称=="右戒指" then
			装备取下编号=8
			装备位置=11
       elseif  装备位置名称=="左护符" then
			装备取下编号=9
			装备位置=12
		elseif 装备位置名称=="右护符" then
			装备取下编号=10
			装备位置=13
       elseif  装备位置名称=="武器" then
			装备取下编号=11
			装备位置=0
		elseif 装备位置名称=="帽子" then
			装备取下编号=1
			装备位置=1
	   elseif 装备位置名称=="护肩" then
			装备取下编号=2
			装备位置=15	
		elseif 装备位置名称=="护腕" then
			装备取下编号=3
			装备位置=14	
		elseif 装备位置名称=="手套" then
			装备取下编号=4
			装备位置=3	
		elseif 装备位置名称=="腰带" then
			装备取下编号=5
			装备位置=5	
		elseif 装备位置名称=="鞋子" then
			装备取下编号=6
			装备位置=4		
		elseif 装备位置名称=="衣服" then
			装备取下编号=12
			装备位置=2
		elseif 装备位置名称=="项链" then
			装备取下编号=13
			装备位置=7
		elseif 装备位置名称=="暗器" then
			装备取下编号=14
			装备位置=17
		
		elseif 装备位置名称=="龙纹" then
			装备取下编号=25
			装备位置=19
		
		elseif 装备位置名称=="令牌" then
			装备取下编号=16
			装备位置=20
			
		--------------------------------------特殊装备
		elseif 装备位置名称=="豪侠印" then
			装备取下编号=""
			装备位置=21
		
		elseif 装备位置名称=="武魂" then
			装备取下编号=""
			装备位置=18
	end
	-------------------------------------------

	local 装备持久 = tonumber( LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], 装备位置)))
	
	 if 装备位置名称=="武魂" then
	    local 装备持久= 取身上武魂生命()
	 end
	
	if 装备持久<=0 then
		屏幕提示("装备持久不够,不取下")
		return 0
	end
	
     计次循环 i=1,5 执行
         LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
         延时 (1000)
         如果 窗口是否出现("SelfEquip") ==1 则   
		装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

		if 装备名称=="" then
			屏幕提示(装备位置名称.."不存在装备")
			return 0
			else
             屏幕提示("需要升级的装备:"..装备位置名称.."|"..装备名称)
		end
              if 装备位置名称=="豪侠印" then
				
				 LUA_Call ("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();")
				 延时 (2000)
				 LUA_Call ("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);")
             	延时 (2000)
				关闭窗口("SelfJunXian")
				elseif 装备位置名称=="武魂" then
				 LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
				 延时 (2000)
				 LUA_Call ("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
             	延时 (2000)
				关闭窗口("Wuhun")
				else
				 LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], 装备取下编号))
			end 
             
              延时 (1000)
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
              如果 装备ID=="0" 则  --检测脱下装备成功
                   LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
                   延时(500)  
                   返回 装备名称
              结束
         结束      
     结束
     LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();")      
     延时(500) 
			装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
	
     如果 装备ID=="0" 则
          返回 装备名称
     否则  
          返回 0
     结束     
end


function 晴天穿上装备(装备名称,装备位置名称)
     if 装备名称==""  then
		屏幕提示("参数错误,晴天穿上装备")
		return
	end
	
	if 获取背包物品数量(装备名称)<=0 then
		屏幕提示("没有装备无法使用,晴天穿上装备")
		return
	end	
		
     if 装备位置名称=="左戒指"  then
		装备取下编号=7
		装备位置=6
		elseif 装备位置名称=="右戒指" then
		装备取下编号=8
		装备位置=11
       elseif  装备位置名称=="左护符" then
		装备取下编号=9
		装备位置=12
		elseif 装备位置名称=="右护符" then
		装备取下编号=10
		装备位置=13
       elseif  装备位置名称=="武器" then
		装备取下编号=11
		装备位置=0
		elseif 装备位置名称=="帽子" then
		装备取下编号=1
		装备位置=1
	   elseif 装备位置名称=="护肩" then
		装备取下编号=2
		装备位置=15	
	    elseif 装备位置名称=="护腕" then
		装备取下编号=3
		装备位置=14	
		elseif 装备位置名称=="手套" then
		装备取下编号=4
		装备位置=3	
		elseif 装备位置名称=="腰带" then
		装备取下编号=5
		装备位置=5	
		elseif 装备位置名称=="鞋子" then
		装备取下编号=6
		装备位置=4
		elseif 装备位置名称=="衣服" then
		装备取下编号=12
		装备位置=2
		elseif 装备位置名称=="项链" then
		装备取下编号=13
		装备位置=7
		elseif 装备位置名称=="暗器" then
		装备取下编号=14
		装备位置=17
		elseif 装备位置名称=="龙纹" then
		装备取下编号=25
		装备位置=19
		elseif 装备位置名称=="令牌" then
		装备取下编号=16
		装备位置=20
		elseif 装备位置名称=="豪侠印" then
		装备取下编号="100"
		装备位置=21
		elseif 装备位置名称=="武魂" then
		装备取下编号="100"
		装备位置=18
		else
			屏幕提示("请设置好对应的装备名字再使用穿上装备")
			return
	end

     for i=1,5 do
        if 窗口是否出现("SelfEquip") ==0 then
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			延时 (1000)
		end
		if 窗口是否出现("Packet") ==0 then
			LUA_Call ("setmetatable(_G, {__index = Packet_Env});this:Show();")
			延时 (1000)
		end
		
	    if 装备位置名称=="武魂" then
			坐骑_下坐骑()
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			右键使用物品(装备名称,1) 
			延时(6000)
		else
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			右键使用物品(装备名称,2) 
			延时(2000)
			右键使用物品(装备名称,2) 
			延时(2000)
		end
		
		装备ID = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], 装备位置))
		
		当前装备名称 = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], 装备位置))

     if tonumber(装备ID)>0 then
		      屏幕提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置)
              跳出循环   
         end
     end
end

---------------------------------------------------------------------------


function 晴天_自动打宝石(装备位置名称,打孔材料,镶嵌材料,宝石名字,孔位数量)

	跨图寻路("洛阳",282,321)
	待执行装备名称= 晴天取下装备获取名字(装备位置名称)
	延时(3000)
    if 装备名称=="" or  装备名称==nil then
            return
     end
	屏幕提示("装备位置名称:"..待执行装备名称)
     LPindex=获取背包物品位置(待执行装备名称)-1
	屏幕提示("待打孔的背包序号:"..LPindex)
	if LPindex<0 then
		    return
	end
	延时(3000)
	装备打孔(待执行装备名称,打孔材料,孔位数量)
	延时(6000)
	晴天_装备上宝石(待执行装备名称,镶嵌材料,宝石名字,孔位数量)
	
	延时(6000)
	晴天穿上装备(待执行装备名称,装备位置名称)
end




屏幕提示("测试啦")
自动清包("飞蝗石")
晴天_自动打宝石("令牌","牦牛角","宝石镶嵌符","红宝石(3级)",1)
晴天_自动打宝石("暗器","牦牛角","宝石镶嵌符","红宝石(3级)",1)



晴天_自动打宝石("龙纹","牦牛角","宝石镶嵌符","红宝石(3级)",1)


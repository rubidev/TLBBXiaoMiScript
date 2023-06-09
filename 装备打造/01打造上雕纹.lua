

取属性设置为 =1           		--1,按最高属性2,按特定门派和名字新区适用
设置是否金币购买雕纹 = 1  	--1购买 2不使用金币购买
是否升级雕纹 = 1					 --特定为3

所需金币金=50           				 --请打造号上必须有50J

所需金币=所需金币金*10000
雕纹蚀刻溶剂最低价格=100*10000
黄纸最低价格 =30*10000
雕纹图样最低价格=500*10000
雕纹蚀刻溶剂购物失败=0

-----------------------------------------------------------------------------------------------------------------------------------------------------


function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
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

--------------------------------------------------装备相关------------------------------------------------
local SelfEuipList =
{
	{ name="武器", downIndex=11,  equipIndex=0, equipName="" },    --- 武器
	{ name="护腕", downIndex=3, equipIndex=14, equipName=""},    --- 护腕
	{ name="戒指上", downIndex=7,  equipIndex=6,equipName=""  },    --- 戒指（上）
	{ name="戒指下", downIndex=8,  equipIndex=11, equipName=""},    --- 戒指（下）
	{ name="护符上", downIndex=9,  equipIndex=12, equipName=""},    --- 护符（上）
	{ name="护符下", downIndex=10, equipIndex=13, equipName=""},    --- 护符（下）
	{ name="衣服", downIndex=12,  equipIndex=2,equipName=""  },    --- 衣服
	{ name="帽子", downIndex=1,  equipIndex=1, equipName="" },    --- 帽子
	{ name="护肩", downIndex=2, equipIndex=15,equipName="" },    --- 肩膀
	{ name="手套", downIndex=4,  equipIndex=3, equipName="" },    --- 手套
	{ name="腰带", downIndex=5,  equipIndex=5, equipName="" },    --- 腰带
	{ name="鞋子", downIndex=6,  equipIndex=4, equipName="" },    --- 鞋子
	{ name="项链", downIndex=13,  equipIndex=7,equipName=""  },    --- 项链
	{ name="暗器", downIndex=14, equipIndex=17, equipName=""},    --- 暗器
	{ name="龙纹", downIndex=25, equipIndex=19,equipName="" },    --- 龙纹
	{ name="武魂", downIndex="", equipIndex=18,equipName="" },    --- 武魂
	{ name="令牌", downIndex=16, equipIndex=20,equipName="" },    --- 令牌
	{ name="豪侠印", downIndex="", equipIndex=21,equipName="" ,},    --- 令牌
}

---------------------------------------------
function  晴天_取身上装备持久(aaa)
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa))
		return  tonumber(tem)
end

function  晴天_取身上装备ID(aaa)
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
	return  tonumber(tem)
end

function 晴天_取身上装备名字(aaa)
	return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

function 晴天_取身上装备等级(aaa)
		local tem =  LUA_取返回值(string.format([[ 
				local  index =%d
				local ID =EnumAction(index,"equip"):GetID()
				if ID > 0 then
					return	DataPool:GetEquipLevel(index)  --装备等级 暗器99了
				end
				return -1
			]], aaa))
			--return LifeAbility:GetWearedEquip_NeedLevel(index) --需要等级
		return  tonumber(tem)
end

function 关闭窗口(strWindowName)
	    LUA_Call(string.format([[
				name = "%s"
				if IsWindowShow(name) then
	            setmetatable(_G, {__index = name_Env}) this:Hide()  
				end
	  ]], strWindowName))  
end

function MessageBoxOK()
	if  窗口是否出现("MessageBox_Self")==1 then
		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
		延时(1000)
	end
end

function 晴天_取背包装备是否有雕纹(index)
		return  LUA_取返回值(string.format([[ 
		 return LifeAbility:IsEquipHaveDiaowen(%d)
	]], index))
end





--------------------------------------------------------------
function  取装备持久(aaa)
return  到数值(LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa)))
end
function  取装备ID(aaa)
return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
	]], aaa))
end

function  取装备名字(aaa)
return  LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetName()
	]], aaa))
end

function  取背包装备等级(index)
local aaa=  LUA_取返回值(string.format([[ 
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
	return tonumber(aaa)
end



function  取身上武魂生命()--300最大
       if  到数值( 取装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
	return -1
    end
end


function 晴天_穿上装备(装备位置名称,装备名称)
     if 装备名称==""  then
		晴天_友情提示("参数错误,晴天_穿上装备")
		return
	end
	if 获取背包物品数量(装备名称)<=0 then
			晴天_友情提示("没有装备无法使用,晴天_穿上装备")
			return
	end	
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			for k =1, 5 do
				关闭窗口("Shop")
				LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")
				if 装备位置名称 == "武魂" then
					坐骑_下坐骑();延时(2000)
					右键使用物品(装备名称);延时(8000)
				else
					右键使用物品(装备名称);延时(2000)
				end
				if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) > 0 then
					晴天_友情提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置名称)
					break   
				end
			end
		end
	end
	--晴天_友情提示(装备位置名称..":位置错误")
end


function 晴天_取下装备获取名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			晴天_友情提示("准备取下装备位置:"..装备位置名称)
			local 装备持久 = 晴天_取身上装备持久(SelfEuipList[i].equipIndex)
				if 装备位置名称=="武魂" then
					local 装备持久= 晴天_取身上武魂生命()
				end
				if tonumber(装备持久) <= 0 then
					--晴天_友情提示("装备持久不够,不取下")
					return 0
				end
				if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0  then
					return 0
				end
				
				for k =1, 10 do	
					local  装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
					if  窗口是否出现("SelfEquip")~=1  then
						LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
					end
					 if 装备位置名称=="豪侠印" then
						LUA_Call ("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();");延时 (2000)
						LUA_Call ("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);");延时 (2000)
						关闭窗口("SelfJunXian")
					elseif 装备位置名称=="武魂" then
						晴天_友情提示("存入琉璃焰|御瑶盘|,防止错误")
						延时 (2000)
						存物品("|琉璃焰|御瑶盘|")
						
						 LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
						延时 (2000)
						LUA_Call ("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
						延时 (2000)
						关闭窗口("Wuhun")
					else
						LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
					end	
					延时(3000)
					if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
						关闭窗口("SelfEquip")
						return 装备名称
					end	
				end	
			return 0
		end
	end
end


-------------------------------------------------------------------------------------



function 晴天_取身上雕纹等级(index,order)  --装备序号,雕纹序号
	local tem =LUA_取返回值(string.format([[
	index =%d
	order =%d
	local nDiaoWenID = LifeAbility:GetWearedDiaowenId(index) 
	if nDiaoWenID> 0 and order == 1 then
		local nLevel = LifeAbility:GetWearedDiaoWenGrade(nDiaoWenID)
		local strName = LifeAbility:GetWearedDiaoWenName(nDiaoWenID)
		return nLevel 
	end
	return -1
	]],index,order),"n",1)
	return tonumber(tem)
end	


function 晴天_取身上装备位置雕纹等级(装备位置名称,order)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			return	晴天_取身上雕纹等级(SelfEuipList[i].equipIndex,order) 
		end
	end
	return -1
end	

function 晴天_取身上装备雕纹等级(index)
	local tem =LUA_取返回值(string.format([[
		index=%d
		local isHaveEquip, gemIndex1, gemIndex2, gemIndex3, gemIndex4 = LifeAbility : SplitWearedEquipGem(index)  
		if isHaveEquip then
			local nDiaoWenID = LifeAbility:GetWearedDiaowenId(index)
			local nLevel = LifeAbility:GetWearedDiaoWenGrade(nDiaoWenID)
			--local strName = LifeAbility:GetWearedDiaoWenName(nDiaoWenID)
			return nLevel
		end
		return -2
	]], index),"n")
	return tem
end



--信息框 (晴天_取身上装备雕纹等级(0),0,"晴天103900393",3)

function 晴天_取所有金币()  --金币+交子
	local tem =LUA_取返回值(string.format([[
			local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
			return selfMoney
			]]),"n",1)
	return tonumber(tem)
end


function 晴天_取背包装备雕纹等级(LPindex)
	local tem =LUA_取返回值(string.format([[
	    local index = tonumber(%d)
		local IsHaveDiaowen = LifeAbility:IsEquipHaveDiaowen(index)
			if  tonumber(IsHaveDiaowen)~=1 then
				PushDebugMessage("装备没有雕纹")
				return -1
		end
		local dwId,dwlevel = LifeAbility:GetEquitDiaowenID(index)
		return dwlevel
		]], LPindex),"n")
	return tem
end



function 晴天_雕纹升级(LPindex,等级)
	if 是否升级雕纹 == 1 then
	local tem =LUA_取返回值(string.format([[
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
					PushDebugMessage("雕纹等级升级金币不够")
					return 2
		end
		
	    local index = tonumber(%d)
	    local todwlevel= tonumber(%d)	
		local IsHaveDiaowen = LifeAbility:IsEquipHaveDiaowen(index)
	    local IsHaveDiaowenEx = LifeAbility:IsEquipHaveDiaowenEx(index)
		if  tonumber(IsHaveDiaowen)~=1 then
				PushDebugMessage("装备没有雕纹")
				return 2
		end
			local dwId,dwlevel = LifeAbility:GetEquitDiaowenID(index)
			local dwIdEx,dwlevelEx = LifeAbility:GetEquitDiaowenIDEx(index)
         if dwlevel>=todwlevel then
				PushDebugMessage("雕纹已经够设置等级:"..todwlevel.."|跳过晴天_雕纹升级任务")
				return 2
          end
		
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("DoEquipDWLevelUp")
				Set_XSCRIPT_ScriptID(809272)
				Set_XSCRIPT_Parameter(0, index) --背包的序号
				Set_XSCRIPT_Parameter(1, todwlevel)  --第一个雕纹要升级的等级
				Set_XSCRIPT_Parameter(2, 0) --第二个雕纹要升级的等级
				Set_XSCRIPT_Parameter(3, 0)  --0代表不提示直接用 1代表有提示
				Set_XSCRIPT_ParamCount(4)
			Send_XSCRIPT()
			
		]], LPindex,等级),"n")
	end
end
--------------------------------------------------------------------------------------------------



function 购买商会物品(名称, 数量, 总价格,判断是否有物品)


     晴天_友情提示("晴天购买商会物品:"..名称.."|数量:"..数量)
     if tonumber(判断是否有物品)==1 then
      if 获取背包物品数量(名称)>=数量 then
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
					--物品名,店主名,所属商店ID,数量,总价格
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
						   --PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
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
	关闭窗口("PS_ShopSearch")
	关闭窗口("PS_ShopList")
	关闭窗口("Quest")	
	return tem
end

-----------------------------------------------------------------------------------红利元宝购买-----------
function 红利元宝购买(YBname)

if YBname=="手套体力雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3)")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);")--手套
	延时(2000)
elseif YBname=="衣服体力雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3);")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(11);")--衣服
	延时(2000)
	
elseif YBname=="帽子毒抗雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3);")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);")--衣服
	延时(2000)
	elseif YBname=="护肩体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3);")
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(7);")--护肩体力
		
		elseif YBname=="鞋子体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3);")
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")--鞋子体力
			elseif YBname=="腰带体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(3);")--防具
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
		    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")--腰带体力
					elseif YBname=="豪侠印体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具2
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")--豪侠印体力
		
							elseif YBname=="武魂体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具2
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")--武魂印体力
		
		elseif YBname=="龙纹体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具2
	延时(2000)
			    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")--龙纹体力
		
									elseif YBname=="暗器体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具2
	延时(2000)
			    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);")--暗器体力

	elseif YBname=="护腕冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(17);")
	
		elseif YBname=="护腕火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);")
	
		
		elseif YBname=="护腕玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")
	
			elseif YBname=="护腕毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")
	
		elseif YBname=="武器冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);")
	
			elseif YBname=="武器火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);")
	
				elseif YBname=="武器玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);")
	
				elseif YBname=="武器毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);")
	
	
			elseif YBname=="令牌冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);")
	

	
				elseif YBname=="令牌火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(11);")
	
				elseif YBname=="令牌玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);")
	
					elseif YBname=="令牌毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);")
	
	
	
				elseif YBname=="项链冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);")
	
					elseif YBname=="项链火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);")
	
					elseif YBname=="项链玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")
	
					elseif YBname=="项链毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(15);")
	
	
	
				elseif YBname=="饰品身法雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(9);")
	
	
					elseif YBname=="丹青" then
					
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(6);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")
		延时(2000)
	MessageBoxOK()
     LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")
		延时(2000)
		
					elseif YBname=="雕纹蚀刻溶剂" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop(6);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);")
		延时(2000)
		else
		晴天_友情提示(YBname.."|绑定元宝购买雕纹名字错误")
end
延时(2000)
MessageBoxOK()
延时(2000)
关闭窗口("YuanbaoShop")
end


---------------------------------------------------------------------------------绑定元宝购买-------------
-----------------------------------------------------------------------------------红利元宝购买-----------
function 绑定元宝购买(YBname)
if YBname=="手套体力雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3)")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);")--手套
	延时(2000)
elseif YBname=="衣服体力雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(11);")--衣服
	延时(2000)
elseif YBname=="帽子毒抗雕纹图样" then
	LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);")--帽子毒抗
	延时(2000)
		
	elseif YBname=="护肩体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);")
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(7);")--护肩体力
		
		elseif YBname=="鞋子体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);")
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")--鞋子体力
			elseif YBname=="腰带体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(3);")--防具
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
		    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")--腰带体力
					elseif YBname=="豪侠印体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具2
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")--豪侠印体力
		
							elseif YBname=="武魂体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具2
	延时(2000)
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")--武魂印体力
		
		elseif YBname=="龙纹体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具2
	延时(2000)
			    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")--龙纹体力
		
									elseif YBname=="暗器体力雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具2
	延时(2000)
			    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);")--暗器体力

	elseif YBname=="护腕冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(17);")
	
		elseif YBname=="护腕火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(18);")
	
		
		elseif YBname=="护腕玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(1);")
	
			elseif YBname=="护腕毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(2);")
	
	
	
		elseif YBname=="武器冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(3);")
	
			elseif YBname=="武器火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(4);")
	
				elseif YBname=="武器玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);")
	
				elseif YBname=="武器毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(6);")
	
	
			elseif YBname=="令牌冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(10);")
	

	
				elseif YBname=="令牌火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(11);")
	
				elseif YBname=="令牌玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);")
	
					elseif YBname=="令牌毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);")
	
	
	
				elseif YBname=="项链冰攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(12);")
	
					elseif YBname=="项链火攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(13);")
	
					elseif YBname=="项链玄攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(14);")
	
					elseif YBname=="项链毒攻雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(5);")--防具1
	延时(2000)
					    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(15);")
	
	
	
				elseif YBname=="饰品身法雕纹图样" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(4);")--防具1
	延时(2000)
				    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();") --下一页
				延时(2000)	
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(9);")
	
	

					elseif YBname=="雕纹蚀刻溶剂" then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();")
	延时(2000)
	LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(4);")
	延时(2000)
    LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(6);")--防具1
	延时(2000)
	  LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);")
	
	
		else
		晴天_友情提示(YBname.."|绑定元宝购买雕纹名字错误")
		
		
end
MessageBoxOK()
延时(2000)
MessageBoxOK()
延时(2000)
LUA_Call ("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_Close();")
关闭窗口("YuanbaoShop")
延时(2000)
end

function 晴天_自动处理雕纹图样(DWname,Gbug,BDbug,HLbug,YBbug)
	晴天_友情提示(string.format("【%s】开始自动检测购买雕纹图样",DWname))
	取出物品(DWname)
	if 获取背包物品数量(DWname)>= 1 then 
		return true
	end
	
	if Gbug  then  --金币购买
		for i =1, 5 do
			if 获取背包物品数量(DWname)>= 1 then 
				return true
			end
			购买商会物品(DWname, 1,雕纹图样最低价格,1)
		end	
	end
	
	if YBbug  then  --元宝购买
		屏幕提示("联系作者QQ103900393增加")
		if 获取背包物品数量(DWname)>= 1 then 
			return true
		end
	end
	
	if BDbug then   --绑定购买
		for i =1, 5 do
			if tonumber(获取人物信息(62))>= 400 then
				绑定元宝购买(DWname)
			end
			if 获取背包物品数量(DWname)>= 1 then 
				return true
			end
		end	
	end
	
	if HLbug then  --红利购买
		for i =1, 5 do
			if 获取背包物品数量(DWname)>= 1 then 
				return true
			end
			if tonumber(获取人物信息(55))>= 400 then
				绑定元宝购买(DWname)
			end
		end	
	end
	if 获取背包物品数量(DWname)== 0 then
		return false
	end 
end



function 晴天_处理丹青()
	for i=1, 5 do
		local 背包丹青数量 = 获取背包物品数量("丹青")
		if 背包丹青数量>=20 then
			晴天_友情提示("处理丹青背包已经有%d,跳过任务",背包丹青数量)
			延时(1000)
			return
		end	
		if tonumber(获取人物信息(55))>= 200 then
			红利元宝购买("丹青")	
			延时(3000)
		end		
	end
end



function 晴天_雕纹图样自动合成(DWname,Gbug,BDbug,HLbug,YBbug)
	local  雕纹图样合成后的名字=string.gsub (DWname, "图样", "")
    local  雕纹图样合成后的名字 =雕纹图样合成后的名字.."1级"
	晴天_友情提示(string.format("【%s】合成后的名字【%s】开始自动检测处理雕纹图样",DWname,雕纹图样合成后的名字))
	取出物品(雕纹图样合成后的名字)
	if 获取背包物品数量(雕纹图样合成后的名字)>= 1 then
		晴天_友情提示(string.format("【%s】合成后的名字【%s】背包总存在图样,跳过任务",DWname,雕纹图样合成后的名字))
		return  雕纹图样合成后的名字
	end
	晴天_自动处理雕纹图样(DWname,Gbug,BDbug,HLbug,YBbug)
	 if 获取背包物品数量(DWname)<= 0 then 
		return false
	end
			
	--处理丹青

	晴天_处理丹青()
		
	--处理黄纸
	 if tonumber(获取背包物品数量("黄纸"))< 20 then
		延时(2000)
		购买商会物品("黄纸", 250,黄纸最低价格,1)
		 延时(2000)
	end

     local dwndex=获取背包物品位置(DWname)-1
	 延时(1000)
	跨图寻路("洛阳",318,315)
	LUA_Call(string.format([[ 
		Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name("DWHechengBeginPay")
		Set_XSCRIPT_ScriptID(809272)
		Set_XSCRIPT_Parameter(0, %d)
		Set_XSCRIPT_Parameter(1, 0)
		Set_XSCRIPT_ParamCount(2)
		Send_XSCRIPT()
	]], dwndex))
	 延时(3000)
	LUA_Call(string.format([[ 
		Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name("DoDiaowenAction")
		Set_XSCRIPT_ScriptID(809272)
		Set_XSCRIPT_Parameter(0, 4)
		Set_XSCRIPT_Parameter(1, %d)--0序号 
		Set_XSCRIPT_ParamCount(2)
		Send_XSCRIPT()
	]], dwndex))
	延时(3000)
end



function 晴天_自动雕纹蚀刻(装备位置名称,雕纹图纸名称,Gbug,BDbug,HLbug,YBbug)
		if  晴天_取身上装备位置雕纹等级(装备位置名称,1) >=1 then
			晴天_友情提示("自动检测上雕纹位置:%s 已经有雕纹 跳过任务",装备位置名称)
			return
		end	
		晴天_友情提示("自动检测上雕纹位置:"..装备位置名称.."|雕纹名称:"..雕纹图纸名称)
		str=装备位置名称.."雕纹等级"
		if  tonumber(晴天_读角色配置项("超级晴天雕纹配置", str)) >= 3 then
			return 
		end
		
     if 雕纹蚀刻溶剂购物失败==1 then
		晴天_友情提示("雕纹蚀刻溶剂购物失败|跳过任务")
		return
	end
    关闭窗口("YuanbaoShop")

	if 到数值(获取人物信息(55)) <200 and 到数值(获取人物信息(62))<200  then
	晴天_友情提示("晴天自动上雕纹设置最绑定元宝200红利元宝200,请自己配置,目前不足跳过")
	延时(200)
	return
	end
	
	if 到数值(获取人物信息(45)) <所需金币 then
		晴天_友情提示("晴天自动上雕纹设置最少金子为:"..所需金币金.."金|请自己配置")
		延时(500) 
		return
	end

   local   LPname= 晴天_取下装备获取名字(装备位置名称)
	     延时(2000) 
        if LPname==0 then
             return
         end

	  晴天_友情提示("装备位置名称:"..LPname)
     LPindex=获取背包物品位置(LPname)-1
	     晴天_友情提示("待雕纹的背包序号:"..LPindex)
	if LPindex<0 then
		    return
	end
if tonumber( 晴天_取背包装备是否有雕纹(LPindex))==1 then
	 晴天_友情提示("装备位置名称:"..LPname.."|已经有雕纹任务跳过")
	
	晴天_雕纹升级(LPindex,3)
    延时(2000)
	晴天_写角色配置项("超级晴天雕纹配置",str,晴天_取背包装备雕纹等级(LPindex));延时(3000)	
     晴天_穿上装备(装备位置名称,LPname)
    延时(2000)
	return
end

if 取背包装备等级(LPindex)<50 then
		 晴天_友情提示("装备位置名称:"..LPname.."|小于50级不能装备雕纹")
    延时(2000)
    晴天_穿上装备(装备位置名称,LPname)
    延时(2000)
	return
end

----------------------------------------------------------------

	晴天_雕纹图样自动合成(雕纹图纸名称,Gbug,BDbug,HLbug,YBbug)
	local  雕纹图样合成后的名字=string.gsub (雕纹图纸名称, "图样", "")
    local  雕纹图样合成后的名字 =雕纹图样合成后的名字.."1级"
	if 获取背包物品数量(雕纹图样合成后的名字) >=1 then
		DWMZindex=获取背包物品位置(雕纹图样合成后的名字)-1
		晴天_友情提示("雕纹位置:"..DWMZindex)
	else
		晴天_穿上装备(装备位置名称,LPname)
		return
	end		

	if 获取背包物品数量("雕纹蚀刻溶剂")< 1 then
			购买商会物品("雕纹蚀刻溶剂", 5,雕纹蚀刻溶剂最低价格,1)
			 延时(2000)
	end

if 获取背包物品数量("雕纹蚀刻溶剂")< 1 then
		    if 到数值(获取人物信息(62))>= 200 then
            晴天_友情提示("用绑定元宝购买图样:雕纹蚀刻溶剂")
			绑定元宝购买("雕纹蚀刻溶剂")
      	    延时(2000)	
            end	
end
if 获取背包物品数量("雕纹蚀刻溶剂")< 1 then
		    if 到数值(获取人物信息(55))>= 200 then
            晴天_友情提示("用红利元宝购买图样:雕纹蚀刻溶剂")
			红利元宝购买("雕纹蚀刻溶剂")
      	    延时(2000)	
            end	
end

if 获取背包物品数量("雕纹蚀刻溶剂")< 1 then
	晴天_友情提示("雕纹蚀刻溶剂|购物失败跳过任务")
	晴天_穿上装备(装备位置名称,LPname)
    延时(1000)
	雕纹蚀刻溶剂购物失败=1
	return
	else
	
    DWRKindex=获取背包物品位置("雕纹蚀刻溶剂")-1
end

	跨图寻路("洛阳",318,315)
	
	
local tem =LUA_取返回值(string.format([[
      
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
					PushDebugMessage("雕纹属性金币不够")
					return 2
		end
Clear_XSCRIPT()
Set_XSCRIPT_Function_Name("DoDiaowenAction")
Set_XSCRIPT_ScriptID(809272)
Set_XSCRIPT_Parameter(0, 1)
Set_XSCRIPT_Parameter(1, %d)--装备
Set_XSCRIPT_Parameter(2, %d)--雕纹蚀刻溶剂
Set_XSCRIPT_Parameter(3, %d)--雕纹
Set_XSCRIPT_ParamCount(4)
Send_XSCRIPT()
		]], LPindex,DWRKindex,DWMZindex),"n")
	      	    延时(2000)	
	晴天_雕纹升级(LPindex,3);延时(3000)	
	晴天_写角色配置项("超级晴天雕纹配置",str,晴天_取背包装备雕纹等级(LPindex));延时(3000)	
	晴天_穿上装备(装备位置名称,LPname)
end
---------------------------------------------------------------------------------------------------
local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()

if  取属性设置为 == 1 then
local tem =LUA_取返回值(string.format([[
	local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
	local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
	local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
	local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
local tt={ iIceAttack, iFireAttack, iThunderAttack,iPoisonAttack}
if iIceAttack==math.max(unpack(tt)) then
   maxOfT ="冰"
elseif  iFireAttack==math.max(unpack(tt)) then
maxOfT ="火"
elseif  iThunderAttack==math.max(unpack(tt)) then
maxOfT ="玄"
elseif  iPoisonAttack==math.max(unpack(tt)) then
maxOfT ="毒"
end

return maxOfT 
]]), "s")
属性攻击=tem
晴天_友情提示("属性攻击:"..属性攻击)
end

if  取属性设置为 == 2 then
if string.find("唐门|星宿|丐帮", menpai) then
属性攻击="毒"
elseif  string.find("逍遥|明教|", menpai) then
属性攻击="火"
elseif  string.find("峨嵋|天山|", menpai) then
属性攻击="冰"
elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
属性攻击="玄"
end

local  毒主属性名称 = "111|aaa|"
local  火主属性名称 = "111|aaa|"
local  冰主属性名称 = "111|aaa|"
local  玄主属性名称 = "111|aaa|"

if string.find(毒主属性名称, 人物名称) then
属性攻击="毒"
elseif  string.find(火主属性名称, 人物名称) then
属性攻击="火"
elseif  string.find(冰主属性名称, 人物名称) then
属性攻击="冰"
elseif  string.find(玄主属性名称, 人物名称) then
属性攻击="玄"
end
--晴天_友情提示("属性攻击:"..属性攻击)
end





------------------------------------------------------------------------
function 晴天_全智能上雕纹()
	晴天_友情提示("全自动判断洛阳上雕纹")
	for i =1,3 do
		取出物品("金币")  
		取出物品("丹青|黄纸|金蚕丝")
		存物品("丹青|金蚕丝","不存",0,1,1)
	end	
	跨图寻路("洛阳",330,299)
	晴天_自动雕纹蚀刻("帽子","帽子毒抗雕纹图样",true,true,true,false)
	
	晴天_自动雕纹蚀刻("暗器","暗器体力雕纹图样",true,true,true,false)  --1金币购买 2绑定元宝购买 3红利购买 4元宝购买 
	晴天_自动雕纹蚀刻("龙纹","龙纹体力雕纹图样",true,true,true,false)    
	晴天_自动雕纹蚀刻("令牌",string.format("令牌%s攻雕纹图样",属性攻击),true,true,true,false)
--晴天_自动雕纹蚀刻("武魂","武魂体力雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("豪侠印","豪侠印体力雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("护肩","护肩体力雕纹图样",true,true,true,false)
	
	晴天_自动雕纹蚀刻("腰带","腰带体力雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("鞋子","鞋子体力雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("手套","手套体力雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("衣服","衣服体力雕纹图样",true,true,true,false)

	
	晴天_自动雕纹蚀刻("武器",string.format("武器%s攻雕纹图样",属性攻击),true,true,true,false)
	晴天_自动雕纹蚀刻("护腕",string.format("护腕%s攻雕纹图样",属性攻击),true,true,true,false)
	晴天_自动雕纹蚀刻("项链",string.format("项链%s攻雕纹图样",属性攻击),true,true,true,false)

	
	晴天_自动雕纹蚀刻("戒指上","饰品身法雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("戒指下","饰品身法雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("护符上","饰品身法雕纹图样",true,true,true,false)
	晴天_自动雕纹蚀刻("护符下","饰品身法雕纹图样",true,true,true,false)
end


--执行功能("[脚本]036接收交易")
晴天_全智能上雕纹()
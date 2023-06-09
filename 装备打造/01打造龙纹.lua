
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

function 晴天_窗口确定()
	if  窗口是否出现("MessageBox_Self")==1 then
		晴天_友情提示("窗口确定")
		LUA_Call(" setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();")
		延时(2000)
	end
end

function 晴天_窗口关闭(strWindowName)
      if 窗口是否出现(strWindowName)==1 then
	    LUA_Call(string.format([[
	            setmetatable(_G, {__index = %s_Env}) this:Hide()  
	  ]], strWindowName))  
		延时(2000)
	  end
end

function 晴天_取所有钱()
	所有钱=获取人物信息(52) +获取人物信息(45)
	return 所有钱
end

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

function  晴天_取背包装备等级(index)
local aaa=  LUA_取返回值(string.format([[ 
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
	return tonumber(aaa)
end

function  晴天_取身上武魂生命()--300最大
       if  tonumber(晴天_取身上装备ID(18) )>0 then
			return  到数值(LUA_取返回值(string.format([[ 
		return DataPool:GetKfsData("LIFE")
	]])))
	else
		return -1
    end
end

function 晴天_判断关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))  
		延时(1500)
	  end
end
function 晴天_取所有钱()
	所有钱=获取人物信息(52) +获取人物信息(45)
	return 所有钱
end



function  晴天_取身上龙纹合成等级()
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local  Level = LifeAbility:GetWearedLongWen_Level(19)
			return Level
		end
		return -1
	]]))
	return tonumber(tem)
end



function  晴天_取身上龙纹星级等级()
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local nQua = LifeAbility:GetWearedLongWen_Star(19)
			return nQua
		end
		return -1
	]]))
	return tonumber(tem)
end

function  晴天_取身上龙纹信息(AAA)
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local nExAttLevel = LifeAbility:GetWearedLongWen_AttLevel(19, %d-1)
			return nExAttLevel 
		end
		return -2	
	]], AAA))
	return tonumber(tem)
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
--------------------------------------------------装备相关------------------------------------------------
local SelfEuipList =
{
	[1]  = { name="武器", downIndex=11,  equipIndex=0, equipName="" },    --- 武器
	[2]  = { name="护腕", downIndex=3, equipIndex=14, equipName=""},    --- 护腕
	[3]  = { name="戒指上", downIndex=7,  equipIndex=6,equipName=""  },    --- 戒指（上）
	[4]  = { name="戒指下", downIndex=8,  equipIndex=11, equipName=""},    --- 戒指（下）
	[5]  = { name="护符上", downIndex=9,  equipIndex=12, equipName=""},    --- 护符（上）
	[6]  = { name="护符下", downIndex=10, equipIndex=13, equipName=""},    --- 护符（下）
	[7]  = { name="衣服", downIndex=12,  equipIndex=2,equipName=""  },    --- 衣服
	[8]  = { name="帽子", downIndex=1,  equipIndex=1, equipName="" },    --- 帽子
	[9]  = { name="护肩", downIndex=2, equipIndex=15,equipName="" },    --- 肩膀
	[10] = { name="手套", downIndex=4,  equipIndex=3, equipName="" },    --- 手套
	[11] = { name="腰带", downIndex=5,  equipIndex=5, equipName="" },    --- 腰带
	[12] = { name="鞋子", downIndex=6,  equipIndex=4, equipName="" },    --- 鞋子
	[13] = { name="项链", downIndex=13,  equipIndex=7,equipName=""  },    --- 项链
	[14] = { name="暗器", downIndex=14, equipIndex=17, equipName=""},    --- 暗器
	[15] = { name="龙纹", downIndex=25, equipIndex=19,equipName="" },    --- 龙纹
	[16] = { name="武魂", downIndex="", equipIndex=18,equipName="" },    --- 武魂
	[17] = { name="令牌", downIndex=16, equipIndex=20,equipName="" },    --- 令牌
}

----------------检测---------------------------
自动检查装备 = 0


function 晴天_取下装备获取名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			晴天_友情提示("准备取下装备位置:"..装备位置名称)
				local 装备持久 =晴天_取身上装备持久(SelfEuipList[i].equipIndex)
				if 装备持久 <= 0 then
					晴天_友情提示("装备持久不够,不取下")
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
					LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
					延时(5000)
					if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0 then
						晴天_判断关闭窗口("SelfEquip")
						return 装备名称
					end	
				end	
				return 0
			end
		end
end

function 晴天_穿上装备(装备位置名称,装备名称)
     if 装备名称==""  then
		晴天_友情提示("参数错误,晴天_穿上装备")
		return
	end
	if 获取背包物品数量(装备名称)<=0 then
			晴天_友情提示("没有装备"..装备名称.."无法装备")
			return
	end	
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			for k =1, 5 do
				右键使用物品(装备名称);延时(2000)
				if  晴天_取身上装备ID(SelfEuipList[i].equipIndex) > 0 then
					晴天_友情提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置名称)
					break   
				end
			end
		end
	end
end



function 晴天_取人物属性(分类)
	local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  分类 == 1 then
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

	if  分类 == 2 then
		if string.find("唐门|星宿|丐帮", menpai) then
			属性攻击="毒"
		elseif  string.find("逍遥|明教|", menpai) then
			属性攻击="火"
		elseif  string.find("峨嵋|天山|", menpai) then
			属性攻击="冰"
		elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
			属性攻击="玄"
		end
	end
	if  分类 == 3 then
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
	end
	return 属性攻击
end


function 晴天_全自动学习龙纹扩张属性()
	if 晴天_读角色配置项("晴天超级配置","龙纹扩张属性") =="完成" then
		晴天_友情提示("全自动学习龙纹扩张属性完成,跳过任务")
		return
	end
	
	取出物品("缀龙石·元|缀龙石·暴|缀龙石·伤|")
	--存物品("缀龙石·元|缀龙石·暴|缀龙石·伤|",不检测,0,1,1)
	材料数组={
	{名字="缀龙石·元",数量=10,ID=4,提示="学习龙纹血上限"},
	{名字="缀龙石·暴",数量=10,ID=6,提示="学习龙纹减抗下限"},
	{名字="缀龙石·伤",数量=10,ID=5,提示="学习龙纹属性攻击"},
	}
	local 属性攻击= 晴天_取人物属性(2)
	if 属性攻击=="冰" then
		UPindex= 1
	elseif 属性攻击=="火" then
		UPindex= 2
	elseif 属性攻击=="玄" then
		UPindex= 3
	elseif 属性攻击=="毒" then
		UPindex= 4
	end
	for i =1, 3 do
		if 晴天_取身上龙纹信息(i) == -1 then
			晴天_友情提示(材料数组[i].提示.."|需要材料:"..材料数组[i].名字)
			延时(3000)
			if 获取背包物品数量(材料数组[i].名字) >= 材料数组[i].数量 then
			龙纹名称= 晴天_取下装备获取名字("龙纹")
			延时(2000) 
			--晴天_友情提示(龙纹名称)
			if 龙纹名称 == 0 then
				 return 
			end
			 LPindex=获取背包物品位置(龙纹名称)-1
			跨图寻路("凤鸣镇",125,201)
			--晴天_友情提示("晴天学习技能")
			LUA_Call(string.format([[
				local xuhao =%d
				local m_Equip_Idx =%d
				local m_select =%d
				if xuhao == 4 then
					PlayerPackage:Lw_Op_Do(4,m_Equip_Idx)
				elseif xuhao == 5 then
					PlayerPackage:Lw_Op_Do(5, m_Equip_Idx, m_select)
				elseif xuhao == 6 then
					PlayerPackage:Lw_Op_Do(6,m_Equip_Idx,m_select)					
				end
			]],材料数组[i].ID,LPindex,UPindex)) 
			延时(2000) 	
			end
		end	
	晴天_穿上装备("龙纹","龙纹")
	延时(2000) 
	end
	if 晴天_取身上龙纹信息(1) >=1 and 晴天_取身上龙纹信息(2) >=1  and 晴天_取身上龙纹信息(3) >=1  then
		晴天_写角色配置项("晴天超级配置","龙纹扩张属性","完成")
	end
end




function 晴天_全智能提升龙纹()
	属性攻击= 晴天_取人物属性(2)
	if 属性攻击=="冰" then
		UPindex=1
	elseif 属性攻击=="火" then
		UPindex=2
	elseif 属性攻击=="玄" then
		UPindex=3
	elseif 属性攻击=="毒" then
		UPindex=4
	end
	晴天_友情提示(UPindex)

      跨图寻路("凤鸣镇",125,201)
      装备位置名称="龙纹"
      ZBname= 晴天_取下装备获取名字(装备位置名称)
      if ZBname==0 then
             return
      end

       晴天_友情提示("装备位置名称:"..ZBname)
       ZBindex=获取背包物品位置(ZBname)-1
       晴天_友情提示("装备位置名称的背包序号:"..ZBindex)
    	if ZBindex<0 then
             return
	    end

for i=1,5 do
	local tem =LUA_取返回值(string.format([[
		local itemIdx=tonumber(%d)
		PlayerPackage:Lw_Op_Do(8, itemIdx)
 ]], ZBindex,UPindex),"n")
end



	for i=1,5 do
		local tem =LUA_取返回值(string.format([[
					local itemIdx=tonumber(%d)
					local nId = PlayerPackage:GetBagLWData(itemIdx, "HP")
					if nId ~= nil and nId > 0 then
					local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
					local m_needMoney =PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPMONEY")
					--PushDebugMessage("所需金币:"..m_needMoney) 

					if selfMoney < m_needMoney then
					--PushDebugMessage("所需金币:"..m_needMoney.."金币不够") 
					return 2
					end

					local needItemNum = PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPITEMNUM")
					--PushDebugMessage(needItemNum)
					local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310181)
					--PushDebugMessage(LW_BDyuan)
					if LW_BDyuan>needItemNum then
					PlayerPackage:Lw_Op_Do(7, itemIdx)
					else
					 --PushDebugMessage("材料不够")
					 return 2
					end
					else
					local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
					if selfMoney <10000 then
					--PushDebugMessage("所需金币:10000,当前不够") 
					return 2
					end
					local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310181)
					if tonumber(LW_BDyuan)<10 then
					return 2
					end
					PlayerPackage:Lw_Op_Do(4, itemIdx)--1234
					return 2
					end
		 ]], ZBindex,UPindex),"n")
				if tonumber(tem)==2 then
					break
				 end
				  延时(1000)
		   end	

	for i=1,5 do
			local tem =LUA_取返回值(string.format([[
			local itemIdx=tonumber(%d)
			local nId = PlayerPackage:GetBagLWData(itemIdx, "RESIST")
			if nId ~= nil and nId > 0 then
			local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
			local m_needMoney =PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPMONEY")
			--PushDebugMessage("所需金币:"..m_needMoney) 

			if selfMoney < m_needMoney then
			--PushDebugMessage("所需金币:"..m_needMoney.."金币不够") 
			return 2
			end

			local needItemNum = PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPITEMNUM")
			--PushDebugMessage(needItemNum)
			local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310182)
			--PushDebugMessage(LW_BDyuan)

			if LW_BDyuan>needItemNum then
				PlayerPackage:Lw_Op_Do(9, itemIdx)
			else
			 --PushDebugMessage("材料不够")
			 return 2
			end
			else
			local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
			if selfMoney <10000 then
			--PushDebugMessage("所需金币:10000,当前不够") 
			return 2
			end
			local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310182)
			if tonumber(LW_BDyuan)<10 then
			return 2
			end
				PlayerPackage:Lw_Op_Do(6, itemIdx, tonumber(%d))--1234
			return 2
			end
			 ]], ZBindex,UPindex),"n")
	    if tonumber(tem)==2 then
			break
		 end
		  延时(1000)
   end	




for i=1,5 do
	local tem =LUA_取返回值(string.format([[
		local itemIdx=tonumber(%d)
		local nId = PlayerPackage:GetBagLWData(itemIdx, "BUFF")
		if nId ~= nil and nId > 0 then
		local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
		local m_needMoney =PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPMONEY")
		--PushDebugMessage("所需金币:"..m_needMoney) 
		if selfMoney < m_needMoney then
		--PushDebugMessage("所需金币:"..m_needMoney.."金币不够") 
		return 2
		end
		local needItemNum = PlayerPackage:GetBagLWAttrExInfo(itemIdx, nId, "LEVELUPITEMNUM")
		--PushDebugMessage(needItemNum)
		local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310183)
		--PushDebugMessage(LW_BDyuan)

		if LW_BDyuan>needItemNum then
			PlayerPackage:Lw_Op_Do(8, itemIdx)
		else
		 --PushDebugMessage("材料不够")
		 return 2
		end
		else
		local selfMoney =  tonumber(Player:GetData("MONEY") +Player:GetData("MONEY_JZ"))
		if selfMoney <10000 then
		--PushDebugMessage("所需金币:10000,当前不够") 
		return 2
		end

		local LW_BDyuan=PlayerPackage:CountAvailableItemByIDTable(20310183)
		if tonumber(LW_BDyuan)<10 then
		return 2
		end
			PlayerPackage:Lw_Op_Do(5, itemIdx, tonumber(%d))--1234
		return 2
		end
 ]], ZBindex,UPindex),"n")
	    if tonumber(tem)==2 then
			break
		 end
		  延时(1000)
   end	
	延时(2000)
	晴天_穿上装备(装备位置名称,ZBname)
end


function 晴天_龙纹合成(龙纹合成等级)
	if 晴天_取身上装备ID(19) <=0 or 晴天_取身上装备名字(19)~="龙纹" then 
		晴天_友情提示("没有装备龙纹,跳过合成...");延时(1500)
		return
	end	
	local 人物等级=tonumber(获取人物信息(26))
	if 人物等级>=98 then 
		龙纹合成等级 =100
	else
		龙纹合成等级 =80
	end	
	取出物品("金币")
	取出物品("龙纹玉灵")
	 装备位置名称="龙纹"
     ZBname= 晴天_取下装备获取名字(装备位置名称)
    if ZBname==0 then
         return
     end
	for i=1,900 do
		if 晴天_取所有钱() <1*10000 then
			跨图寻路("凤鸣镇",125,201)
			break
		end
		晴天_友情提示("装备位置名称:"..ZBname)
		ZBindex=获取背包物品位置(ZBname)-1
		晴天_友情提示("装备位置名称的背包序号:"..ZBindex)
    	if ZBindex<0 then
            break
	    end
		local tem = LUA_取返回值(string.format([[
			local main_lv = PlayerPackage:GetBagLWData(%d, "LEVEL")
			return main_lv
		]],ZBindex),"n")
		
		if tonumber(tem)>=龙纹合成等级 then
			 晴天_友情提示("龙纹等级[%d]>=%d跳过任务",tem,龙纹合成等级)
			break
		end	
		YLindex=获取背包物品位置("龙纹玉灵")-1
		晴天_友情提示("材料的背包序号:"..YLindex)
    	if YLindex<0 then
            break
	    end	
		if 窗口是否出现("LongwenLevelUp")==0 then
			晴天_友情提示("打开提升龙纹成长等级对话框")
			跨图寻路("凤鸣镇",125,201)
			对话NPC("焦鹰");延时(1500)
			NPC二级对话("提升龙纹成长等级");延时(1500)
		end 
		
		XLindex=获取背包物品位置("铸纹血玉")-1
		if XLindex<0 then
			XLindex=-1 
		end	
		晴天_友情提示("合成等级提升铸纹血玉位置[%d]",XLindex)
		LUA_Call(string.format([[
			PlayerPackage:Lw_Op_Do(1, tonumber(%d),tonumber(%d),tonumber(%d))
		]], ZBindex,YLindex,XLindex),"n")
		延时(200)
	end
	晴天_判断关闭窗口("LongwenLevelUp")
	延时(2000)
	晴天_穿上装备(装备位置名称,ZBname)
	晴天_友情提示("升级龙纹结束")
end
	
	
function 晴天_九州商会购买物品(名称, 数量, 单价)
	for  qq=1,9 do
		取出物品("金币",200*10000)  
		if 获取背包物品数量(名称)>=数量 then
			屏幕提示("背包中有这个物品"..名称)
			return false
		end
		if 窗口是否出现("PS_ShopSearch")~=1  then
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
		end
			
		LUA_Call(string.format([[	
			 PlayerShop:PacketSend_Search(2 , 2, 1, "%s", %d)		
		]], 名称,qq))
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
							if pName == "%s"   then
								if pYB/pCount <= %d  the
									if   pCount <= %d
										PushDebugMessage(pName.."/"..pShopName.."/"..pCount.."/"..pYB)
										PlayerShop:SearchPageBuyItem(i - 1, "item")
										return 1	
									end
								else
									return -2
								end		
							end
						end
					end
				end
				return -1
		]], 名称, 数量, 单价), "b")
		延时(1500)
	end
end

local starcailiao =	{
{玉龙髓数量=60},
{玉龙髓数量=120},
{玉龙髓数量=240},
{玉龙髓数量=400},
{玉龙髓数量=400,勾天彩="初级勾天彩",数量=30},	
{玉龙髓数量=400,勾天彩="中级勾天彩",数量=60},	
{玉龙髓数量=400,勾天彩="高级勾天彩",数量=120},	
{玉龙髓数量=400,勾天彩="幻色勾天彩",数量=300},	
}



function 晴天_提升龙纹星级(index)
	if 晴天_取身上装备ID(19) <=0 or 晴天_取身上装备名字(19)~="龙纹" then 
		晴天_友情提示("没有装备龙纹,跳过升星...");延时(1500)
		return
	end	
	for i=1, 9 do
		if not index then
			index = 9
		end	
		local  身上龙纹星星数量 = 晴天_取身上龙纹星级等级()
		if 身上龙纹星星数量>= index then
			晴天_友情提示("龙纹星级:%d,跳过任务",身上龙纹星星数量)	;延时(1000)
			return
		end
		local 玉龙髓数量= starcailiao[身上龙纹星星数量].玉龙髓数量
		local 勾天彩名字= starcailiao[身上龙纹星星数量].勾天彩
		local 勾天彩数量= starcailiao[身上龙纹星星数量].数量
		if 玉龙髓数量 then
			取出物品("玉龙髓")
			local  背包玉龙髓数量= 获取背包物品数量("玉龙髓")
			if 背包玉龙髓数量>=玉龙髓数量 then
				晴天_友情提示("龙纹升级星级:需要玉龙髓 %s / %s 足够",背包玉龙髓数量,玉龙髓数量);延时(1000)
			else
				晴天_九州商会购买物品("玉龙髓",玉龙髓数量-背包玉龙髓数量,10*10000)
				if 获取背包物品数量("玉龙髓")< 玉龙髓数量 then
					晴天_友情提示("龙纹升级星级:需要玉龙髓 %s / %s 不够",背包玉龙髓数量,玉龙髓数量);延时(1000)
					break
				end	
			end
		end
		if 勾天彩名字 and 勾天彩数量 then
			取出物品(勾天彩名字)
			local  背包勾天彩数量= 获取背包物品数量(勾天彩名字)
			if 背包勾天彩数量>=勾天彩数量 then
				晴天_友情提示("龙纹升级星级:需要%s %s 足够",勾天彩名字,勾天彩数量);延时(1000)
			else
				晴天_友情提示("龙纹升级星级:需要%s %s 不够",勾天彩名字,勾天彩数量);延时(1000)
				break
			end
		end
			
		
		跨图寻路("凤鸣镇",125,201)
		延时(2000)
		local 装备位置名称="龙纹"
		local ZBname= 晴天_取下装备获取名字(装备位置名称)
		if ZBname==0 then
		   return
		end

		晴天_友情提示("装备位置名称:"..ZBname)
		local ZBindex=获取背包物品位置(ZBname)-1
		晴天_友情提示("装备位置名称的背包序号:"..ZBindex)
		if ZBindex<0 then
			return
		end 	
		晴天_友情提示("星级提升")
		LUA_Call(string.format([[
			PlayerPackage:Lw_Op_Do(2, tonumber(%d))
		]], ZBindex),"n")
		延时(2000)
		晴天_穿上装备(装备位置名称,ZBname)
		延时(2000)
	end
	晴天_友情提示("龙纹升星结束");延时(1000)
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

function 晴天_全自动清理龙纹材料(星级材料列表)
	local 龙纹合成等级 =晴天_取身上龙纹合成等级()

	if 龙纹合成等级>=100 then
		local str= string.format("当前龙纹等级:[%d]满级了,执行清理材料",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("龙纹玉灵|铸纹血玉")
		晴天_卖出物品("龙纹玉灵|铸纹血玉",2)
	else
		local str= string.format("当前龙纹等级:[%d]没有满级,跳过清理材料任务",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
	end
	local 龙纹星级等级= 晴天_取身上龙纹星级等级()
	if 龙纹星级等级 >= 8 then
		local str= string.format("当前龙纹星级等级:[%d]满级了,执行清理材料",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品(星级材料列表)
		晴天_卖出物品(星级材料列表,2)
	else
		local str= string.format("当前龙纹星级等级:[%d]没有满级,跳过清理材料任务",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)	
	end

	local 龙纹血上限等级=  晴天_取身上龙纹信息(1)
	local 龙纹减抗等级 = 晴天_取身上龙纹信息(2)
	local 龙纹属性攻击等级 = 晴天_取身上龙纹信息(3)
	if 龙纹血上限等级 >= 10 then
		local str= string.format("龙纹血上限等级:[%d]满级了,执行清理材料",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·元")
		晴天_卖出物品("缀龙石·元",2)
	else
		local str= string.format("龙纹血上限等级:[%d]没有满级,跳过清理材料任务",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹减抗等级 >= 10 then
		local str= string.format("龙纹减抗等级:[%d]满级了,执行清理材料",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·伤")
		晴天_卖出物品("缀龙石·伤",2)
	else
		local str= string.format("龙纹减抗等级:[%d]没有满级,跳过清理材料任务",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹属性攻击等级 >= 10 then
		local str= string.format("龙纹属性攻击等级:[%d]满级了,执行清理材料",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·暴")
		晴天_卖出物品("缀龙石·暴",2)
	else
		local str= string.format("龙纹属性攻击等级:[%d]没有满级,跳过清理材料任务",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)	
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
	for i=0,199 do
			local tem = LUA_取返回值(string.format([[
				local tbangding =tostring("%s")
				local i =%d
				local ttname = "%s"
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






function  晴天_取身上龙纹信息(AAA)
	local tem=   LUA_取返回值(string.format([[
		local ID =EnumAction(19,"equip"):GetID()
		if ID> 0 then
			local nExAttLevel = LifeAbility:GetWearedLongWen_AttLevel(19, %d-1)
			return nExAttLevel 
		end
		return -2	
	]], AAA))
	return tonumber(tem)
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





function 晴天_全自动清理龙纹材料(星级材料列表)
	local 龙纹合成等级 =晴天_取身上龙纹合成等级()

	if 龙纹合成等级>=100 then
		local str= string.format("当前龙纹等级:[%d]满级了,执行清理材料",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("龙纹玉灵|铸纹血玉")
		晴天_卖出物品("龙纹玉灵|铸纹血玉",2)
	else
		local str= string.format("当前龙纹等级:[%d]没有满级,跳过清理材料任务",龙纹合成等级)
		晴天_友情提示(str)
		延时(3000)
	end
	local 龙纹星级等级= 晴天_取身上龙纹星级等级()
	if 龙纹星级等级 >= 8 then
		local str= string.format("当前龙纹星级等级:[%d]满级了,执行清理材料",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品(星级材料列表)
		晴天_卖出物品(星级材料列表,2)
	else
		local str= string.format("当前龙纹星级等级:[%d]没有满级,跳过清理材料任务",龙纹星级等级)
		晴天_友情提示(str)
		延时(3000)	
	end

	local 龙纹血上限等级=  晴天_取身上龙纹信息(1)
	local 龙纹减抗等级 = 晴天_取身上龙纹信息(2)
	local 龙纹属性攻击等级 = 晴天_取身上龙纹信息(3)
	if 龙纹血上限等级 >= 10 then
		local str= string.format("龙纹血上限等级:[%d]满级了,执行清理材料",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·元")
		晴天_卖出物品("缀龙石·元",2)
	else
		local str= string.format("龙纹血上限等级:[%d]没有满级,跳过清理材料任务",龙纹血上限等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹减抗等级 >= 10 then
		local str= string.format("龙纹减抗等级:[%d]满级了,执行清理材料",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·伤")
		晴天_卖出物品("缀龙石·伤",2)
	else
		local str= string.format("龙纹减抗等级:[%d]没有满级,跳过清理材料任务",龙纹减抗等级)
		晴天_友情提示(str)
		延时(3000)	
	end
	
	if 龙纹属性攻击等级 >= 10 then
		local str= string.format("龙纹属性攻击等级:[%d]满级了,执行清理材料",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)
		取出物品("缀龙石·暴")
		晴天_卖出物品("缀龙石·暴",2)
	else
		local str= string.format("龙纹属性攻击等级:[%d]没有满级,跳过清理材料任务",龙纹属性攻击等级)
		晴天_友情提示(str)
		延时(3000)	
	end
end




---------------------------------------------------------
if 晴天_取身上装备ID(19) >0 and 晴天_取身上装备名字(19)=="龙纹" then 
	材料列表 ="龙纹玉灵|铸纹血玉|玉龙髓|缀龙石·伤|缀龙石·暴|缀龙石·元|净云水|初级勾天彩|中级勾天彩|高级勾天彩"
	取出物品(材料列表)
	存物品(物品名称,不存物品,1,1,1)
	晴天_提升龙纹星级()
	晴天_全自动学习龙纹扩张属性()
	晴天_全智能提升龙纹()
	晴天_龙纹合成()
	晴天_全自动清理龙纹材料("级勾天彩合成符|初级勾天彩合成符|中级勾天彩|初级勾天彩|玉龙髓")
	存物品("龙纹玉灵|铸纹血玉|玉龙髓|缀龙石·伤|缀龙石·暴|缀龙石·元|净云水|初级勾天彩|中级勾天彩|高级勾天彩")
else 
	晴天_友情提示("没有装备龙纹,跳过打造...");延时(2000)	
end

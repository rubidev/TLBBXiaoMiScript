--1 洗点
--2 星级提升 ---
--3 暗器 完美 扔了
--4 暗器属性升级 满级了 扔了
--	装备等级标准表
local g_FightScore_DarkScore_Level_List =
{
	--	推荐暗器名称	推荐暗器的玩家等级+百兵精通等级,只要比这个小,一律都是这个
	[1] = {name = "飞蝗石", level = 75, needlevel = 30, param = 10},
	[2] = {name = "梅花镖", level = 90, needlevel = 50, param = 50},
	[3] = {name = "冰魄神针", level = 120, needlevel = 70, param = 100},
	[4] = {name = "金翅翎羽", level = 120, needlevel = 90, param = 250},
}



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
function 晴天_取人物技能(技能) --1 
	local tem = LUA_取返回值(string.format([[ 
	local num =tonumber(GetActionNum("skill"))
	for i = 1, num do 
		local theAction = EnumAction(i-1, "skill")
		local nSkillId = LifeAbility : GetLifeAbility_Number(theAction:GetID())
		local strName = Player:GetSkillInfo(nSkillId,"name")
		local strName2 = Player:GetSkillInfo(nSkillId,"skilldata")
		if nSkillId> 0 then 
			if strName == "%s" then 
				return 1
			end
		end
	end	
	return -1
	]], 技能))
	return tonumber(tem)
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


function 晴天_取身上暗器品阶()
	local aaa=  LUA_取返回值(string.format([[ 
		local g_FightScore_DarkScore_Quality_List =
{
	[1] = {qua=40, str="普通", param=20},			--	普通
	[2] = {qua=80, str="优秀", param=40},			--	优秀
	[3] = {qua=120, str="杰出", param=60},			--	杰出
	[4] = {qua=160, str="卓越", param=80},			--	卓越
	[5] = {qua=200, str="完美", param=100},			--	完美
}
		local nNeedLevel = LifeAbility:GetWearedEquip_NeedLevel(17)
		local nGrade = LifeAbility:GetWearedDark_QualityGrade(17)
		for i,vItem in g_FightScore_DarkScore_Quality_List do
			if ( i == 1 and nGrade < vItem.qua ) or ( i > 1 and nGrade < vItem.qua and nGrade >= g_FightScore_DarkScore_Quality_List[i - 1].qua ) or ( i == 5 and nGrade >= vItem.qua ) then
				return  vItem.str
			end
		end
		return -1
	]], index))
	return aaa
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


function 晴天_取身上暗器信息(index)
	local tem =LUA_取返回值(string.format([[
			index =%d
			local humanLYAddHP = LifeAbility:GetWearedDarkLY_CuiduHP(17) --实际暗器血上限
			local humanLYAddPro = LifeAbility:GetWearedDarkLY_CuiduPro(17) --实际暗器属性攻
			local humanLYAddHit = LifeAbility:GetWearedDarkLY_CuiduHit(17) --实际暗器命中
			if index == 1 then
				return humanLYAddHP
			elseif index == 2 then
				return humanLYAddPro
			elseif index == 3 then	
				return humanLYAddHit
				else
				return humanLYAddHP
			end
				]],index), "n")
	return tonumber(tem)
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



---------------------------------------------------------------暗器函数------------------------------------------
function 晴天_取身上暗器属性值(index)
		local tem = LUA_取返回值(string.format([[
			index = %d-1
			local  theAction = EnumAction(17, "equip");
			local ID  =theAction:GetID()
			if ID > 0 then
				local EquipAttrNum =  theAction:GetEquipAttrCount()
				local tempstr = theAction:EnumEquipExtAttr(index)
				if string.find(tempstr, "#{") then
						local left = string.find(tempstr, "#{")
						local left2 = string.find(tempstr, "}")
						local strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))	
						local strTempNum= tonumber(string.sub(tempstr,left2+3))
						return strTempNum
				end
			end	
			return -1
	]],index), "b")
	return tonumber(tem)
end

function 晴天_取背包暗器属性值(序号,index)
		local tem = LUA_取返回值(string.format([[
			xxx=%d
			index = %d-1
			local  theAction = EnumAction(xxx,"packageitem")
			local ID  =theAction:GetID()
			if ID > 0 then
				local EquipAttrNum =  theAction:GetEquipAttrCount()
				local tempstr = theAction:EnumEquipExtAttr(index)
				if string.find(tempstr, "#{") then
						local left = string.find(tempstr, "#{")
						local left2 = string.find(tempstr, "}")
						local strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))	
						local strTempNum= tonumber(string.sub(tempstr,left2+3))
						return strTempNum
				end
			end	
			return -1
	]], 序号, index), "b")
	return tonumber(tem)
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
	for i=0,200 do
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

function 晴天_取物卖绑定物品(物品列表)
	取出物品(物品列表)
	晴天_卖出物品(物品列表,2)
	存物品(物品列表)
end
---------------------------------------------------------------------------------------------------------
function 晴天_暗器打造原始属性(序号)
	local 身上暗器等级 = 晴天_取身上装备等级(17)
	if 身上暗器等级 <90 then
		晴天_友情提示("暗器打造原始属性,等级不够90跳过任务") 
		延时(1000)
		return
	else
		晴天_友情提示("暗器打造原始属性") 	
		延时(500)
	end	

	if 	 晴天_读角色配置项("晴天超级配置", "暗器打造原始属性")== "1" then
		晴天_友情提示("暗器打造原始属性,跳过任务") 
		return
	end
	local 身上暗器属性值=晴天_取身上暗器属性值(序号)
	晴天_友情提示("身上暗器原始属性值:"..身上暗器属性值) 
	if 身上暗器属性值 <= 2 then
		return
	end

	if 晴天_取所有钱() <= 10*10000 or 获取背包物品数量("神亦石") == 0 then
		晴天_友情提示("暗器打造原始属性,材料不足")
			return
	end
	跨图寻路("洛阳",207,342)
	local 装备名称= 晴天_取下装备获取名字("暗器")
	   延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
	
	for kkk=1,99 do
		local 原始属性 =晴天_取背包暗器属性值(LPindex,序号)
		晴天_友情提示("原始属性:"..原始属性)
		if 原始属性 <=2 then
			break
		end
		if 晴天_取所有钱() <= 1*10000 or 获取背包物品数量("神亦石")< 1 then
			晴天_友情提示("暗器打造原始属性,材料不足")
			break
		end	
		LUA_Call(string.format([[	
			DataPool:DarkAdjustAttr(%d, %d ,0)
		]], LPindex,序号))
		延时(2000)
	end
	晴天_穿上装备("暗器",装备名称)	
end

function 晴天_暗器智能打造原始属性()
	local 身上暗器等级 = 晴天_取身上装备等级(17)
	if 身上暗器等级 <90 then
		晴天_友情提示("暗器智能打造原始属性,等级不够90跳过任务") 
		延时(1000)
		return
	else
		晴天_友情提示("暗器智能打造原始属性") 	
		延时(500)
	end	
	取出物品("神亦石")
	人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if tonumber( 内外攻击) == 1 then
		if 晴天_取身上暗器属性值(1) <=2 and 晴天_取身上暗器属性值(4) <=4 then
			 晴天_卖出物品("神亦石",2)
			else
			晴天_暗器打造原始属性(1)
			晴天_暗器打造原始属性(4)
		end
	else
		if 晴天_取身上暗器属性值(1) <=2 and 晴天_取身上暗器属性值(4) <=4 then
			 晴天_卖出物品("神亦石",2)
			else
			晴天_暗器打造原始属性(1)
			晴天_暗器打造原始属性(4)
		end
	end	
	存物品("神亦石")
end

-------------------------------------------------------------------------------------
function 晴天_暗器重洗品阶()
	晴天_友情提示("暗器重洗品阶") 
	
	if 晴天_取身上暗器品阶()=="完美" then
		晴天_友情提示("暗器重洗品阶完美,跳过任务") 
		延时(3000)
		return
	end		
	
	if 	 晴天_读角色配置项("晴天超级配置", "暗器重洗品阶")== "1" then
		晴天_友情提示("暗器重洗品阶,跳过任务") 
		return
	end
	--local 身上暗器属性值=晴天_取身上暗器属性值(序号)
	--晴天_友情提示("身上暗器原始属性值:"..身上暗器属性值) 
	--if 身上暗器属性值 <= 2 then
		--return
	--end
	取出物品("百淬神玉|千淬神玉")
	取出物品("金币")
	if 晴天_取所有钱() <= 1*10000 or 获取背包物品数量("百淬神玉|千淬神玉") == 0 then
		晴天_友情提示("暗器重洗品阶,材料不足")
			return
	end
	跨图寻路("洛阳",207,342)
	local 装备名称= 晴天_取下装备获取名字("暗器")
	   延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
	for kkk=1,99 do
		if 晴天_取所有钱() <= 1*10000 or 获取背包物品数量("百淬神玉|千淬神玉")< 1 then
			晴天_友情提示("暗器重洗品阶,材料不足")
			break
		end	
		if  获取背包物品数量("百淬神玉")>=1 then
			LUA_Call(string.format([[	
				DataPool:DarkResetQuality(%d, 1 ,0, 0);
			]], LPindex))
			延时(2000)
		end
		if  获取背包物品数量("千淬神玉")>=1 then
			LUA_Call(string.format([[	
				DataPool:DarkResetQuality(%d, 2 ,0, 0);
			]], LPindex))
		end
		延时(2000)
	end
	晴天_穿上装备("暗器",装备名称)		
end
-------------------------------------------------------------------
function 晴天_九州商会购买物品(名称, 数量, 单价,判断是否有物品)
     取出物品("金币",200000)  
	for k=1,9 do
	local str=string.format("九州商会购买物品:%s|数量%d|单价%d", 名称, 数量, 单价)
     晴天_友情提示(str)
     if tonumber(判断是否有物品)==1 then
      if 获取背包物品数量(名称)>=数量 then
		晴天_友情提示("背包中有这个物品"..名称)
	    break
       end
	end 
    if 窗口是否出现("1PS_ShopSearch")== 0 then
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
					--物品名,店主名,所属商店ID,数量,单价
					local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )			
					if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
					    if pName == "%s" and pCount <= %d and  (pYB/pCount) <= %d  then
						   PushDebugMessage(pName.."|"..pShopName.."|数量:"..pCount.."|总价:"..pYB)
						   --点击购买后,直接返回
						   PlayerShop:SearchPageBuyItem(i - 1, "item")
						   return true
						end
					end
				end
			end
            return false
	]], 名称, 数量, 单价), "b")
    延时 (2000)
	end
    晴天_判断关闭窗口("PS_ShopSearch")
	晴天_判断关闭窗口("PS_ShopList")
	晴天_判断关闭窗口("Quest")	
end

function 晴天_暗器自动处理寒冰星石()
	晴天_友情提示("自动处理寒冰星石")
	for i =1,9 do
		取出物品("寒冰星石")
		if 获取背包物品数量("寒冰星石") <=0 then
				取出物品("寒冰星屑")
				if 获取背包物品数量("寒冰星屑") >=20 then
					晴天_友情提示("自动兑换寒冰星屑");延时(500)
					跨图寻路("楼兰",134,118);延时(500)
					对话NPC("钱宏宙");延时(500)
					NPC二级对话("兑换寒冰星石",1);延时(500)
					NPC二级对话("兑换寒冰星石",1);延时(500)
				else
					存物品("寒冰星屑")
					return -1
				end
		else
			return 1		
		end
	end
end




function 晴天_暗器智能升级()
	暗器名字 =晴天_取身上装备名字(17) 
	if 暗器名字== "断魂镖" then
		取出物品("玄昊玉")
		晴天_九州商会购买物品("玄昊玉",100,700,1)
		if 获取背包物品数量("玄昊玉")>=50 then
			晴天_取下装备获取名字("暗器")
			跨图寻路("洛阳",215,325);延时(2500) 
			if 对话NPC("立繁") ==1  then
				NPC二级对话("断魂镖打造暗器",1);
				延时(2500) 
				NPC二级对话("锻造");
				延时(2500) 
				晴天_穿上装备("暗器","断魂镖")
				晴天_穿上装备("暗器","梅花镖")
			end
		end
	elseif 暗器名字== "梅花镖" then
		if 晴天_取身上装备等级(17) >= 90 then
			if 晴天_暗器自动处理寒冰星石() ==1 then
				取出物品("金币")
				if 晴天_取所有钱() <200*10000 then
					晴天_友情提示("钱不够不要升级了")
					延时(1500)
					return
				end	
				晴天_友情提示("开始变成冰魄神针");延时(1500) 
				跨图寻路("楼兰",134,118);延时(500)
					local 装备名称= 晴天_取下装备获取名字("暗器")
					延时(2000) 
					晴天_友情提示(装备名称)
					if 装备名称 == 0 then
							 return -1
						else
					   LPindex=获取背包物品位置(装备名称)-1	
					end
					寒冰星石序号 =获取背包物品位置("寒冰星石")-1	
				local tem = LUA_取返回值(string.format([[	
				Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name( "Anqi2Shenzhen" )
					Set_XSCRIPT_ScriptID( 260001 )
					Set_XSCRIPT_Parameter( 0, %d)
					Set_XSCRIPT_Parameter( 1, %d )
					Set_XSCRIPT_ParamCount(2)
				Send_XSCRIPT()
					]], LPindex, 寒冰星石序号), "b")
				延时(3000)
				晴天_穿上装备("暗器",装备名称)
				晴天_穿上装备("暗器","冰魄神针")
			end	
		end
	end
end




--------------------------------------------------------------------------------------
function 晴天_取身上装备星星数(序号)
	local main_lv = LUA_取返回值(string.format([[
		local EquipQual = DataPool:GetEquipQual(%d) 
		return EquipQual
		]],序号))  
		return tonumber(main_lv)
end	

function 晴天_只能金翅翎羽提升技能(序号)
	
	if 晴天_取所有钱() <= 1*10000 or 获取背包物品数量("五毒珠元阳") == 0 then
		晴天_友情提示("暗器重洗品阶,材料不足")
			return
	end
	
	跨图寻路("洛阳",207,403)
	local 装备名称= 晴天_取下装备获取名字("暗器")
	延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
	LUA_Call(string.format([[	
	local g_LingYuLianDuItem = {20800039,20800041,20800043}
	g_Dark_Bag_Index = %d
	g_Dark_SelectPro  =  %d
	local needItemCount,needJz = DataPool : GetLYDarkLianduCostDataInBag(g_Dark_Bag_Index, g_Dark_SelectPro)
	if (g_Dark_Bag_Index == -1) then
		PushDebugMessage("#{AQJJ_160127_93}")
		return
	end
	
	--请选择重洗类型
	if (g_Dark_SelectPro == -1) then
		PushDebugMessage("#{AQJJ_160127_101}")
		return
	end

	local EquipPoint = LifeAbility : Get_Equip_Point(g_Dark_Bag_Index)
	if (EquipPoint ~= 17) then
		PushDebugMessage("#{AQJJ_160127_99}")
		return
	end
	
	--暗器炼毒
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name("LingyuLianDu")
		Set_XSCRIPT_ScriptID(260001)
		Set_XSCRIPT_Parameter(0,g_Dark_Bag_Index)
		Set_XSCRIPT_Parameter(1,g_Dark_SelectPro)
		Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT()
	]], 序号))
	
	晴天_穿上装备("暗器",装备名称)
end

function 晴天_自动处理金翅翎羽()
	local 暗器名字= 晴天_取身上装备名字(17)
	if 暗器名字 ~= "金翅翎羽" then
		local str=string.format("暗器名字[%s]不等于金翅翎羽,跳过任务", 暗器名字)
		晴天_友情提示(str)
		延时(2000)
		return
	end	
	if 晴天_取身上装备星星数(17) >= 8 then
		晴天_取物卖绑定物品("龙泉铁英")
	end

	if 晴天_取身上暗器信息(1) >=10688  then
		晴天_取物卖绑定物品("五毒珠元阳")
	end
	if 晴天_取身上暗器信息(2) >=176  then
		晴天_取物卖绑定物品("五毒珠魂武")
	end
	if 晴天_取身上暗器信息(2) >=2175  then
		晴天_取物卖绑定物品("五毒珠星眸")
	end
end

function 晴天_学习暗器手法()
	local 身上暗器等级 = 晴天_取身上装备等级(17)
	if 身上暗器等级 <90 then
		晴天_友情提示("学习暗器手法,等级不够90跳过任务") 
		延时(1000)
		return
	else
		晴天_友情提示("学习暗器手法") 	
		延时(500)
	end	
	
	for i =1, 5 do
		if 晴天_取人物技能("暗器投掷") == 1 or 晴天_取所有钱() < 2*10000 then
			break
		end	
		屏幕提示("学习暗器手法-暗器投掷")
		跨图寻路("洛阳",207,342)
		if 对话NPC("燕青")==1 then
            NPC二级对话("学习暗器手法",0)
			延时(1000)
			NPC二级对话("学习40",1)
			延时(1000)
			NPC二级对话("确定",1)
		end		
		延时(2000)
	end	
	for i =1, 5 do
		
		if 晴天_取人物技能("暗器打穴") == 1 or 晴天_取所有钱() < 10*10000 then
			break
		end	
		屏幕提示("学习暗器手法-暗器打穴")
		跨图寻路("洛阳",207,342)
		if 对话NPC("燕青")==1 then
            NPC二级对话("学习暗器手法",0)
			延时(1000)
			NPC二级对话("学习70",1)
			延时(1000)
			NPC二级对话("确定",1)
		end		
		延时(2000)
	end	
	for i =1, 5 do
		if 晴天_取人物技能("暗器护体") == 1 or 晴天_取所有钱() < 50*10000 then
			break
		end	
		屏幕提示("学习暗器手法-暗器护体")
		跨图寻路("洛阳",207,342)
		if 对话NPC("燕青")==1 then
            NPC二级对话("学习暗器手法",0)
			延时(1000)
			NPC二级对话("学习90",1)
			延时(1000)
			NPC二级对话("确定",1)
		end		
		延时(2000)
	end	
end



function 晴天_洗血上限(index)

        local isWQ = LUA_取返回值(string.format([[
		Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("DarkSkillAdjustForBagItem");
		Set_XSCRIPT_ScriptID(332207);
		Set_XSCRIPT_Parameter(0,%d);
		Set_XSCRIPT_Parameter(1,0);
		Set_XSCRIPT_ParamCount(2);
	Send_XSCRIPT();
			 ]],index),"n")
end

function 晴天_取重洗后的技能()
        local isWQ = LUA_取返回值(string.format([[
					local desc0,desc1,desc2 = DataPool:GetDarkSkillNewDesc()
					return desc2
			 ]], "s"))
	return tostring(isWQ) 
end

function 晴天_取暗器技能(index)
        local isWQ = LUA_取返回值(string.format([[
					local desc0,desc1,desc2 = DataPool:GetDarkSkillDesc(%d)
					return desc2
			 ]],index),"n")
	return tostring(isWQ) 
end
	

function 晴天_确定属性(index)
        local isWQ = LUA_取返回值(string.format([[
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("DoRefreshDarkSkill");
			Set_XSCRIPT_ScriptID(332207);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_Parameter(1,0);
			Set_XSCRIPT_ParamCount(2);
		Send_XSCRIPT();
			 ]],index))
end		


function 晴天_暗器全自动洗血上限()
	if tonumber(晴天_读角色配置项("晴天超级配置","暗器血上限")) == 1 then
		晴天_友情提示("暗器全自动洗血上限,已经有血上限了,跳过任务") 
		延时(500)
		return
	end	

	local 身上暗器等级 = 晴天_取身上装备等级(17)
	if 身上暗器等级 <90 then
		晴天_友情提示("暗器全自动洗血上限,等级不够90跳过任务") 
		延时(1000)
		return
	else
		晴天_友情提示("暗器全自动洗血上限") 	
		延时(500)
	end	
	
	装备位置名称 ="暗器"
	取出物品("忘无石")
	取出物品("金币")
	if 获取背包物品数量("忘无石")< 1 then
		return
	end
	if 晴天_取所有钱()<=5*10000 then	
			return
	end
		
	local 装备名称= 晴天_取下装备获取名字(装备位置名称)
	     延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	 if string.find (晴天_取暗器技能(LPindex),"血上限") then 	
			晴天_写角色配置项("晴天超级配置","暗器血上限",1)
			晴天_友情提示(装备名称.."已经有血上限啦跳过任务")
			存物品("忘无石")
			存物品("金币")
			晴天_穿上装备(装备位置名称,装备名称)	
			
			延时(3000)	
			return 
	end		
	if 晴天_取背包装备等级(LPindex)< 90 then
			晴天_友情提示(装备名称.."等级小于90跳过任务")
			存物品("忘无石")
			存物品("金币")
			晴天_穿上装备(装备位置名称,装备名称)	
			延时(3000)	
			return 
	end	
	跨图寻路("洛阳",207,343)
					for  i = 1,999 do 
						if 获取背包物品数量("忘无石")< 1 then
								break
							end
						if 晴天_取所有钱()<=5*10000 then	
								break
							end
						晴天_洗血上限(LPindex)
						延时(3000)
						重洗后的都技能= 晴天_取重洗后的技能()
						屏幕提示(重洗后的都技能)
						if string.find (重洗后的都技能,"血上限") then
							晴天_确定属性(LPindex)
							延时(5000)
								 if string.find (晴天_取暗器技能(LPindex),"血上限") then 
									
									晴天_写角色配置项("晴天超级配置","暗器血上限",1)
										break
								end	
						end
					end
						延时(3000)
						存物品("忘无石")
						存物品("金币")
					晴天_穿上装备(装备位置名称,装备名称)		
end


晴天_暗器重洗品阶()	
晴天_暗器智能升级()			
晴天_暗器全自动洗血上限()	
晴天_学习暗器手法()
晴天_暗器智能打造原始属性()
晴天_暗器重洗品阶()
晴天_自动处理金翅翎羽()
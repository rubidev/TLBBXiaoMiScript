

波斯玫瑰兑换强化 = 1

function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		DebugListBox_ListBox:AddInfo("#e0000ff#g28f1ff".."【晴天友情提示】%s")	--
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
	]], strCode))
end

function 晴天_波斯玫瑰兑换强化()
	取出物品("波斯玫瑰")  
	for i=1,99 do  
		if 获取背包物品数量("波斯玫瑰")>=30 then
			跨图寻路("大理",182,68)
			if 对话NPC("巴盖里") then
				NPC二级对话("波斯玫瑰兑换奖励") ;延时(3000)
				NPC二级对话("30朵波斯玫瑰兑换奖励") ;延时(3000)
				任务_完成()
			end
			else
			晴天_友情提示("波斯玫瑰不足|不进行波斯玫瑰兑换强化")
			break
		end
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

function  晴天_取装备强化等级(AAA)
local tem=   LUA_取返回值(string.format([[
		setmetatable(_G, {__index = EquipStrengthen_Env});
		local Level=  LifeAbility : Get_Equip_CurStrengthLevel(%d);
		return Level
	]], AAA))
	return tonumber(tem)
end


function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		DebugListBox_ListBox:AddInfo("#e0000ff#g28f1ff".."【晴天友情提示】%s")	--
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
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
---------------------------------------------------------必备函数-----------------------------------------------------------------
--------------------------------------------------装备相关------------------------------------------------
local SelfEuipList =
{
	[1]  = { name="武器", downIndex=11,  equipIndex=0, equipName="" },    --- 武器
	[2]  = { name="护腕", downIndex=3, equipIndex=14, equipName=""},    --- 护腕
	[3]  = { name="戒指（上）", downIndex=7,  equipIndex=6,equipName=""  },    --- 戒指（上）
	[4]  = { name="戒指（下）", downIndex=8,  equipIndex=11, equipName=""},    --- 戒指（下）
	[5]  = { name="护符（上）", downIndex=9,  equipIndex=12, equipName=""},    --- 护符（上）
	[6]  = { name="护符（下）", downIndex=10, equipIndex=13, equipName=""},    --- 护符（下）
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

function 晴天_取下装备获取名字(装备位置名称)
	for i =1,17 do
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
			晴天_友情提示("没有装备无法使用,晴天_穿上装备")
			return
	end	
	for i =1,17 do
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
	--晴天_友情提示(装备位置名称..":位置错误")
end
-----------------------------------------------------------------------------------------------------------
function 晴天_全自动强化装备(装备位置名称,等级)
		取出物品("金币",20*10000)
		--晴天_友情提示("当前所有钱:"..晴天_取所有钱())
		if 晴天_取所有钱() < 1*10000 then
			晴天_友情提示("强化:"..装备位置名称.."|金币不足跳过任务");延时(200)
		end
		取出物品("天罡强化精华|天罡强化露")
	if 获取背包物品数量("天罡强化精华|天罡强化露")==0 then 
			晴天_友情提示("强化:"..装备位置名称.."|强化材料不足跳过任务");延时(200)
			return 
			else
		if 获取背包物品数量("天罡强化露")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化露")-1
		end
		
		if 获取背包物品数量("天罡强化精华")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化精华")-1
		end
	end


	local 强化等级=tonumber( 晴天_读角色配置项("超级晴天", 装备位置名称.."强化等级"))
	
	if 强化等级 >= 等级 then
		return 
	end
	
	跨图寻路("洛阳",305,291)
		
	local 装备名称= 晴天_取下装备获取名字(装备位置名称)
	     延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
	晴天_友情提示("装备位置:"..LPindex.."材料位置:"..CLindex)
	跨图寻路("洛阳",305,291)

	while 晴天_取装备强化等级(LPindex) < tonumber(等级) do
		if 获取背包物品数量("天罡强化露")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化露")-1
		end
		
		if 获取背包物品数量("天罡强化精华")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化精华")-1
		end
		if 获取背包物品数量("天罡强化精华|天罡强化露")==0 then 
			break 
		end
	晴天_友情提示("装备位置:"..LPindex.."材料位置:"..CLindex)
	 LUA_Call(string.format([[
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name("FinishEnhance");
				Set_XSCRIPT_ScriptID(809262);
				Set_XSCRIPT_Parameter(0,%d);
				Set_XSCRIPT_Parameter(1,%d);
				Set_XSCRIPT_Parameter(2,-1);
				Set_XSCRIPT_ParamCount(3);
			Send_XSCRIPT();
			]], LPindex,CLindex))  
			延时(3000)
	end
	强化等级=晴天_取装备强化等级(LPindex)
	晴天_写角色配置项("超级晴天", 装备位置名称.."强化等级",强化等级) 
	晴天_穿上装备(装备位置名称,装备名称)		
end

function 晴天_强化全身装备(等级)
		if 波斯玫瑰兑换强化==1 then
			晴天_波斯玫瑰兑换强化()
		end
	晴天_全自动强化装备("令牌",等级)
	晴天_全自动强化装备("暗器",等级)	
	晴天_全自动强化装备("龙纹",等级)	
	晴天_全自动强化装备("武器",等级)	
	晴天_全自动强化装备("衣服",等级)	
	晴天_全自动强化装备("帽子",等级)	
	晴天_全自动强化装备("护腕",等级)	
	晴天_全自动强化装备("手套",等级)	
	晴天_全自动强化装备("护肩",等级)	
	晴天_全自动强化装备("腰带",等级)		
	晴天_全自动强化装备("鞋子",等级)
	晴天_全自动强化装备("项链",等级)			
	晴天_全自动强化装备("戒指（上）",等级)	
	晴天_全自动强化装备("戒指（下）",等级)	
	晴天_全自动强化装备("护符（上）",等级)	
	晴天_全自动强化装备("护符（下）",等级)							
end

晴天_强化全身装备(4)  -----全自动全身装备强化
晴天_强化全身装备(4)  
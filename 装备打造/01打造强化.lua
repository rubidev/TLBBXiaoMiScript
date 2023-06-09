


------------------------------------------------------------------------------------------------------------------------------------

function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【自动强化】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

-----------------------------------------------------------------------------------

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
SelfEuipList =
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
	[18] = { name="豪侠印", downIndex="", equipIndex=21,equipName="" ,},    --- 令牌
}


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

function 晴天_绑定元宝店购物(名字)
	local BDYB={
["地煞强化精华"]={第一栏=1,第二栏=4,第三栏=2,第几页=0,选项=15,元宝数量=20}, 
["金刚砂"]={第一栏=1,第二栏=4,第三栏=2,第几页=0,选项=14,元宝数量=80}, 
	}
	
	if tonumber( 获取人物信息(62)) <BDYB[名字].元宝数量 then
		晴天_友情提示("名字需要绑定元宝:"..BDYB[名字].元宝数量.."|不足,跳过任务")
		return
	end
		
	local 延时时间 = 3000
	if 窗口是否出现("YuanbaoShop")==0 then
		LUA_Call("setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();");延时(延时时间)
	end
	晴天_友情提示("元宝店点击第一栏:"..BDYB[名字].第一栏.."|序号从0123456")
	LUA_Call(string.format([[
	        setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(%d);
	  ]], BDYB[名字].第一栏));延时(延时时间)  
	
	晴天_友情提示("元宝店点击第二栏:"..BDYB[名字].第二栏.."|序号从123456")
	LUA_Call(string.format([[
	        setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(%d);
	  ]], BDYB[名字].第二栏));延时(延时时间)  
	
	晴天_友情提示("元宝店点击第三栏:"..BDYB[名字].第三栏.."|序号从123456")
		LUA_Call(string.format([[
	setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateShop_Bind(%d);
		  ]], BDYB[名字].第三栏));延时(延时时间)  
	---
	晴天_友情提示("元宝店点击第几页:"..BDYB[名字].第几页.."|序号从123456")
	if BDYB[名字].第几页== 1 then
		LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(延时时间)
		elseif BDYB[名字].第几页== 2 then
		LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(延时时间)
		LUA_Call("setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_PageDown();");延时(延时时间)
	end
	--选项
		晴天_友情提示("元宝店点击选项:"..BDYB[名字].选项.."|序号从123456")
		LUA_Call(string.format([[
	        setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(%d);
	  ]], BDYB[名字].选项));延时(延时时间)  
	晴天_窗口确定()
	晴天_窗口关闭("YuanbaoShop")
end
	
	
function 晴天_取背包空格(index)--背包取道具栏空格
	local aaa=  LUA_取返回值(string.format([[ 
	index=%d
	if index==1 then
		local xianzai = DataPool:GetBaseBag_Num();
		local szPacketName = "base";
		local zhanyong = 0;
		for i=1, xianzai  do
			local theAction = PlayerPackage:EnumItem(szPacketName, i-1);
			local GetName=theAction:GetName()
			if GetName ~=""  then
				zhanyong = zhanyong + 1
			end
		end
		shengyu = xianzai - zhanyong
		return shengyu
	end
	
	if index==2 then
		local xianzai = DataPool:GetBaseBag_Num();
		local szPacketName = "material";
		local zhanyong = 0;
		
				for i=1, xianzai  do
			local theAction = PlayerPackage:EnumItem(szPacketName, i-1);
			local GetName=theAction:GetName()
			if GetName ~=""  then
				zhanyong = zhanyong + 1
			end
		end
		shengyu = xianzai - zhanyong
		return shengyu
	end
	]], index))
	return tonumber(aaa)
end

function 晴天_波斯玫瑰兑换强化()
	自动清包("后肘肉口粮|回旋金球")
	取出物品("波斯玫瑰")  
	for i=1,99 do  
		if  晴天_取背包空格(1) <= 3 then
			晴天_友情提示("背包空格不足|不进行波斯玫瑰兑换强化")
			break
		end
		if 获取背包物品数量("波斯玫瑰")>=30 then
			跨图寻路("大理",182,68)
			if 对话NPC("巴盖里") then
				NPC二级对话("波斯玫瑰兑换奖励") ;延时(1000)
				NPC二级对话("30朵波斯玫瑰兑换奖励") ;延时(1000)
				任务_完成()
			end
			else
			晴天_友情提示("波斯玫瑰不足|不进行波斯玫瑰兑换强化")
			break
		end
		延时(1000)
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

function  晴天_取身上装备强化等级(AAA)
	local tem=   LUA_取返回值(string.format([[
			local oEquip = EnumAction(%d, "equip")
			local nlevel,aaa,bbb = oEquip:GetStrengthenLevel()
			return nlevel
			-- -1 是没有装备 0 是没有强化
		]], AAA))
	return tonumber(tem)
end

function 晴天_取身上装备位置强化等级(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			return	晴天_取身上装备强化等级(SelfEuipList[i].equipIndex) 
		end
	end
end	




----------------检测---------------------------
自动检查装备 = 0


---------------------------------------------------------必备函数-----------------------------------------------------------------

function 晴天_取下装备获取名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
				屏幕提示("准备取下装备位置:"..装备位置名称)
				延时(2000)
				local 装备持久 =晴天_取身上装备持久(SelfEuipList[i].equipIndex)
				if 装备持久 <= 0 then
					屏幕提示("装备持久不够,不取下")
					return 0
				end
				if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) == 0  then
					return 0
				end
				
				for k =1, 10 do	
					local  装备名称 = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
					if  窗口是否出现("SelfEquip")==0  then
						LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
					end
					 if 装备位置名称=="豪侠印" then
						LUA_Call ("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();");延时 (2000)
						LUA_Call ("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);");延时 (2000)
						晴天_判断关闭窗口("SelfJunXian")
					else
						LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
					end	
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
	--晴天_友情提示(装备位置名称..":位置错误")
end
-----------------------------------------------------------------------------------------------------------









function 晴天_全自动强化装备(装备位置名称,等级)
		取出物品("金币",20*10000)
		--晴天_友情提示("当前所有钱:"..晴天_取所有钱())
		if 晴天_取所有钱() < 1*10000 then
			晴天_友情提示("强化:"..装备位置名称.."|目标等级:"..等级.."|金币不足跳过任务");延时(200)
			return 
		end
		取出物品("天罡强化精华|天罡强化露")
		
	if 获取背包物品数量("天罡强化精华|天罡强化露")<=0 then 
			晴天_友情提示("强化:"..装备位置名称.."|目标等级:"..等级.."|强化材料不足跳过任务");延时(200)
			return 
	else
		if 获取背包物品数量("天罡强化露")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化露")-1
		end
		
		if 获取背包物品数量("天罡强化精华")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化精华")-1
		end
	end


	local 强化等级=晴天_取身上装备位置强化等级(装备位置名称)
	
	if 强化等级 >= 等级 then
		晴天_友情提示("当前强化位置:[%s]强化等级[%d]目标等级[%d]跳过任务",装备位置名称,强化等级,等级)
		return 
	end
	跨图寻路("洛阳",305,291)
	
	local 装备名称= 晴天_取下装备获取名字(装备位置名称); 延时(2000) 
	
	晴天_友情提示(装备名称)
	
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
	for  kkk =1, 99 do
		跨图寻路("洛阳",305,291)
		local nowLV=晴天_取装备强化等级(LPindex)
		if  nowLV >= tonumber(等级) then
			晴天_友情提示("强化等级足够啦,跳出")
			break
		end	
	
		if 获取背包物品数量("天罡强化露")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化露")-1
		end
		
		if 获取背包物品数量("天罡强化精华")> 0 then 	
			 CLindex=获取背包物品位置("天罡强化精华")-1
		end
		if 获取背包物品数量("天罡强化精华|天罡强化露")==0 then 
			break 
		end
		
		晴天_友情提示("装备名称[%s]装备位置[%d]材料位置[%d]目标等级[%d]目前等级[%d]",装备名称,LPindex,CLindex,nowLV,等级)
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
			延时(500)
	end
	--强化等级=晴天_取装备强化等级(LPindex)
	--晴天_写角色配置项("超级晴天", 装备位置名称.."强化等级",强化等级) 
	晴天_穿上装备(装备位置名称,装备名称)		
end
-----------------------------------------------------------------------------
function 晴天_全自动所有装备(装备位置名称,等级,材料)
		
		取出物品("金币",20*10000)
		--晴天_友情提示("当前所有钱:"..晴天_取所有钱())
		if 晴天_取所有钱() < 1*10000 then
			晴天_友情提示("强化:"..装备位置名称.."|目标等级:"..等级.."|金币不足跳过任务");延时(200)
		end
		
	local 强化等级=晴天_取身上装备位置强化等级(装备位置名称)
	if 强化等级 >= 等级 then
		return 
	end
		
		
	取出物品(材料)

	跨图寻路("洛阳",305,291)
		
	local 装备名称= 晴天_取下装备获取名字(装备位置名称)
	 延时(3000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end

	跨图寻路("洛阳",305,291)

	while 晴天_取装备强化等级(LPindex) < tonumber(等级) do
		if 获取背包物品数量(材料)==0 then 
			if 材料=="地煞强化精华" then
				晴天_绑定元宝店购物(材料)
			else
				local 强化等级=晴天_取装备强化等级(LPindex)
				--晴天_写角色配置项("超级晴天", 装备位置名称.."强化等级",强化等级) 
				晴天_穿上装备(装备位置名称,装备名称)		
					return	
			end
		end

	if 获取背包物品数量(材料)> 0 then 	
		 CLindex=获取背包物品位置(材料)-1
			else
			return
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
	--强化等级=晴天_取装备强化等级(LPindex)
	--晴天_写角色配置项("超级晴天", 装备位置名称.."强化等级",强化等级) 
	晴天_穿上装备(装备位置名称,装备名称)		
	
end
	


function 晴天_高级强化(材料,高级等级)
	取出物品(材料)
	if 获取背包物品数量(材料)> 0 then 	
		else
			return
	end
	
	for i =1,#(SelfEuipList) do
			local 强化等级=晴天_取身上装备位置强化等级(SelfEuipList[i].name)
			if 强化等级>=9 and 强化等级 < 高级等级 then
				晴天_全自动所有装备(SelfEuipList[i].name,高级等级,材料)
			end			
	end
	if 获取背包物品数量(材料)> 0 then 	
		存物品(材料)
	end
end



function 晴天_强化全身装备(等级)
	if 波斯玫瑰兑换强化==1 then
		晴天_波斯玫瑰兑换强化()
	end
	取出物品("天罡强化精华|天罡强化露")	
	if 获取背包物品数量("天罡强化精华|天罡强化露")<=0 then 
		晴天_友情提示("强化材料,不足跳过任务")
		延时(200)
		return 
	end
		
	晴天_全自动强化装备("令牌",等级)
	晴天_全自动强化装备("暗器",等级)	
	晴天_全自动强化装备("龙纹",等级)	
	--晴天_全自动强化装备("武器",等级)	
	晴天_全自动强化装备("衣服",等级)	
	晴天_全自动强化装备("帽子",等级)	
	晴天_全自动强化装备("护腕",等级)	
	晴天_全自动强化装备("手套",等级)	
	晴天_全自动强化装备("护肩",等级)	
	晴天_全自动强化装备("腰带",等级)		
	晴天_全自动强化装备("鞋子",等级)
	晴天_全自动强化装备("项链",等级)			
	晴天_全自动强化装备("戒指上",等级)	
	晴天_全自动强化装备("戒指下",等级)	
	晴天_全自动强化装备("护符上",等级)	
	晴天_全自动强化装备("护符下",等级)							
end

function 晴天_检查装备()
		if 自动检查装备 ==0  then
			for i =1,table.getn(SelfEuipList) do
				SelfEuipList[i].equipName = 晴天_取身上装备名字(SelfEuipList[i].equipIndex)
			end	
			自动检查装备 = 1		
		else
			for i =1,table.getn(SelfEuipList) do
				if 晴天_取身上装备名字(SelfEuipList[i].equipIndex)~= SelfEuipList[i].equipName then
					晴天_穿上装备(SelfEuipList[i].name,SelfEuipList[i].equipName)
				end			     
			end	
		end	
end

function 晴天_领取强8到9()
	跨图寻路("洛阳",305,291)
	if 对话NPC("风胡子") then
		NPC二级对话("强化超值赠") ;延时(2000)
		NPC二级对话("领取强化卷轴·8升9") ;延时(2000)
	end
end

function 晴天_卷轴强化89装备(装备位置名称)
	
		local 等级 = 8
		取出物品("金币",20*10000)
		--晴天_友情提示("当前所有钱:"..晴天_取所有钱())
		if 晴天_取所有钱() < 1*10000 then
			晴天_友情提示("金币不足跳过任务");延时(200)
			return 
		end
		取出物品("强化卷轴·8升9")
	if 获取背包物品数量("强化卷轴·8升9")<=0 then 
		晴天_友情提示("强化:"..装备位置名称.."|目标等级:"..等级.."|强化材料不足跳过任务");
		延时(2000)
		return 
	end

	local 强化等级=晴天_取身上装备位置强化等级(装备位置名称)
	
	if 强化等级 ~= 等级 then
		晴天_友情提示("当前强化位置:[%s]强化等级[%d]目标等级[%d]跳过任务",装备位置名称,强化等级,等级)
		return 
	end
		晴天_领取强8到9()
	跨图寻路("洛阳",305,291)
		
	local 装备名称= 晴天_取下装备获取名字(装备位置名称)
	     延时(2000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	
		跨图寻路("洛阳",305,291)
		local nowLV=晴天_取装备强化等级(LPindex)
		if  nowLV ~= tonumber(等级) then
			晴天_友情提示("强化等级足够啦,跳出")
			晴天_穿上装备(装备位置名称,装备名称)		
		end	
		
		if 获取背包物品数量("强化卷轴·8升9")> 0 then 	
			 CLindex=获取背包物品位置("强化卷轴·8升9")-1
		end

		晴天_友情提示("装备名称[%s]装备位置[%d]材料位置[%d]目标等级[%d]目前等级[%d]",装备名称,LPindex,CLindex,nowLV,等级)
		LUA_Call(string.format([[
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("FinishQuickEnhance");
			Set_XSCRIPT_ScriptID(809262);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_Parameter(1,%d);
			Set_XSCRIPT_ParamCount(2);
		Send_XSCRIPT();
			]], LPindex,CLindex))  
			延时(2000)
	--强化等级=晴天_取装备强化等级(LPindex)
	--晴天_写角色配置项("超级晴天", 装备位置名称.."强化等级",强化等级) 
	晴天_穿上装备(装备位置名称,装备名称)		
end




---------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------
--晴天_全自动所有装备("暗器",5,"地煞强化精华")--地煞强化精华 断魂镖 特写

波斯玫瑰兑换强化 =1

晴天_检查装备()    --防止装备乱穿
if 波斯玫瑰兑换强化==1 then
	晴天_波斯玫瑰兑换强化()
end
取出物品("天罡强化精华|天罡强化露")	
if 获取背包物品数量("天罡强化精华|天罡强化露")<=0 then 
	晴天_友情提示("强化材料,不足跳过任务")
	延时(200)
	--return 
end


	晴天_全自动强化装备("武器",8)
	晴天_全自动强化装备("豪侠印",8)
	晴天_全自动强化装备("暗器",8)	
	晴天_全自动强化装备("令牌",8)
	晴天_全自动强化装备("龙纹",8)	
	晴天_全自动强化装备("护腕",8)
	晴天_全自动强化装备("项链",8)			
	晴天_全自动强化装备("戒指上",8)	
	晴天_全自动强化装备("戒指下",8)	
	晴天_全自动强化装备("护符上",8)	
	晴天_全自动强化装备("护符下",8)		
	晴天_全自动强化装备("衣服",8)	
	晴天_全自动强化装备("帽子",8)	
	晴天_全自动强化装备("手套",8)	
	晴天_全自动强化装备("护肩",8)	
	晴天_全自动强化装备("腰带",8)		
	晴天_全自动强化装备("鞋子",8)
	
	晴天_卷轴强化89装备("武器")
	晴天_卷轴强化89装备("豪侠印")
	晴天_卷轴强化89装备("暗器")	
	晴天_卷轴强化89装备("令牌")
	晴天_卷轴强化89装备("龙纹")	
	晴天_卷轴强化89装备("护腕")
	晴天_卷轴强化89装备("项链")			
	晴天_卷轴强化89装备("戒指上")	
	晴天_卷轴强化89装备("戒指下")	
	晴天_卷轴强化89装备("护符上")	
	晴天_卷轴强化89装备("护符下")		
	晴天_卷轴强化89装备("衣服")	
	晴天_卷轴强化89装备("帽子")	
	晴天_卷轴强化89装备("手套")	
	晴天_卷轴强化89装备("护肩")	
	晴天_卷轴强化89装备("腰带")		
	晴天_卷轴强化89装备("鞋子")
	--晴天_高级强化("至尊强化精华",20)
--晴天_强化全身装备(3)
--晴天_强化全身装备(5)  
--晴天_强化全身装备(7)  
--晴天_强化全身装备(8)  
--晴天_强化全身装备(9)  
晴天_高级强化("至尊强化精华",30)
晴天_检查装备()   --防止装备乱穿
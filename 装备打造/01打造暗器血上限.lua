
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

function 晴天_判断关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))  
		延时(1500)
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

function 晴天_取重洗后的技能(index)
		 local isWQ =""
		for i=1, 5 do
			 isWQ = LUA_取返回值(string.format([[
						local str =""
						local  xuhao=%d
							local desc0,desc1,desc2 =  DataPool:GetDarkSkillNewDesc()
							if xuhao==1 then 
								str= desc0
							elseif  xuhao==2 then 
								str= desc1
							elseif xuhao==3 then 
								str= desc2
							end
						return str
				 ]],index))
			if isWQ~="" then
				return tostring(isWQ) 
			end
		end	
	return tostring(isWQ) 
end

function 晴天_取暗器技能(index,xuhao)
        local isWQ = LUA_取返回值(string.format([[
					local str =""
					local desc0,desc1,desc2 = DataPool:GetDarkSkillDesc(%d)
					local  xuhao=%d
					if xuhao==1 then 
						str= desc0
					elseif  xuhao==2 then 
						str= desc1
					elseif xuhao==3 then 
						str= desc2
					end
					return str
			 ]],index,xuhao),"n")
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

function 晴天_取人物属性(分类)  --1是最高属性 2是门派
	if  窗口是否出现("SelfEquip")~=1  then
		LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
	end
	
	local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  分类 ==1 then
		local tem =LUA_取返回值(string.format([[
		local maxOfT="错误"
		local	iIceDefine,iFireDefine,iThunderDefine,iPoisonDefine =0,0,0,0
		iIceAttack = Player:GetData( "ATTACKCOLD" );
		iFireAttack = Player:GetData( "ATTACKFIRE" );
		iThunderAttack = Player:GetData( "ATTACKLIGHT" );
		iPoisonAttack = Player:GetData( "ATTACKPOISON" );
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
		晴天_友情提示("晴天取人物最高属性攻击:"..属性攻击)
	elseif  分类 == 2 then
		if string.find("唐门|星宿|丐帮", menpai) then
			属性攻击="毒"
		elseif  string.find("逍遥|明教|", menpai) then
			属性攻击="火"
		elseif  string.find("峨嵋|天山|", menpai) then
			属性攻击="冰"
		elseif  string.find("天龙|少林|鬼谷|慕容|武当", menpai) then
			属性攻击="玄"
		end
	else
		return -1
	end
	return 属性攻击
end

local 人物属性 =晴天_取人物属性(1)

function 晴天_暗器全自动洗血上限()
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
	 if string.find (晴天_取暗器技能(LPindex,3),"血上限") and string.find (晴天_取暗器技能(LPindex,1),人物属性)  then 
			if string.find (晴天_取暗器技能(LPindex,2),"散")  or  string.find (晴天_取暗器技能(LPindex,2),"麻痹")  then

				晴天_友情提示(装备名称.."已经有血上限啦跳过任务")
				存物品("忘无石")
				存物品("金币")
				晴天_穿上装备(装备位置名称,装备名称)	
				延时(3000)	
				return 
			end
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
						延时(1000)
						local 信息1 =晴天_取重洗后的技能(1)
						local 信息2=晴天_取重洗后的技能(2)
						local 信息3 =晴天_取重洗后的技能(3)
						屏幕提示("1"..信息1)
						屏幕提示("2"..信息2)
						屏幕提示("3"..信息3)
						if string.find (信息3,"血上限") and string.find (信息1,人物属性) then
							if string.find (信息2,"散")  or  string.find (信息2,"麻痹")  then
								晴天_确定属性(LPindex)
								延时(3000)
							end	
								 if string.find (晴天_取暗器技能(LPindex,3),"血上限") and string.find (晴天_取暗器技能(LPindex,1),人物属性)  then 
										if string.find (信息2,"散")  or  string.find (信息2,"麻痹")  then
											break
										end
								end	
						end
					end
					延时(500)
						存物品("忘无石")
						存物品("金币")
					晴天_穿上装备(装备位置名称,装备名称)		
end
			
function 晴天_暗器全二技能()
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
	 if string.find (晴天_取暗器技能(LPindex,3),"血上限") and string.find (晴天_取暗器技能(LPindex,1),人物属性)  then 

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
						延时(1000)
						local 信息1 =晴天_取重洗后的技能(1)
						local 信息2=晴天_取重洗后的技能(2)
						local 信息3 =晴天_取重洗后的技能(3)
						屏幕提示("1"..信息1)
						屏幕提示("2"..信息2)
						屏幕提示("3"..信息3)
						if string.find (信息3,"血上限") and string.find (信息1,人物属性) then
	
								晴天_确定属性(LPindex)
								延时(3000)
			
								 if string.find (晴天_取暗器技能(LPindex,3),"血上限") and string.find (晴天_取暗器技能(LPindex,1),人物属性)  then 
					
											break
					
								end	
						end
					end
					延时(500)
						存物品("忘无石")
						存物品("金币")
					晴天_穿上装备(装备位置名称,装备名称)		
end			
					晴天_暗器全二技能()
--晴天_暗器全自动洗血上限()	
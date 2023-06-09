令牌名称集合="江湖令|金兰令|聚义令|歃血令|霸王令"
令牌名称列表={"江湖令","金兰令","聚义令","歃血令","霸王令"}
领取令牌所需帮贡={200,300,400,500,1000}
领取宝珠所需帮贡=50

------------------------------------------------
function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
		--#Y
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
	if tem then
		晴天_友情提示(AAA.."|"..BBB.."=="..tem);延时(500)
		else
		return 0
	end
	return tem
end

function 晴天_取人物属性(分类)  --1是最高属性 2是门派
	local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if  分类 ==1 then
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
		--屏幕提示("晴天取人物最高属性攻击:"..属性攻击)
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
	return tostring(属性攻击)
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
}

----------------检测---------------------------
function 晴天_取所有钱()
	所有钱=tonumber( 获取人物信息(52)) +     tonumber( 获取人物信息(45))
	return 所有钱
end


function  晴天_取身上装备持久(aaa)
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetEquipDur()
	]], aaa))
		return  tonumber(tem)
end

function  晴天_取身上装备信息(aaa)	--序号
	local tem = LUA_取返回值(string.format([[ 
		return EnumAction(%d,"equip"):GetID()
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
	local tem =LUA_取返回值(string.format([[ 
		TTAction =EnumAction(%d,"equip")
		local ID =TTAction:GetID()
		if ID > 0 then
			local name= TTAction:GetName()
			return name
		end
		return -1	
	]], aaa))
		return tostring(tem)
end

	
function  晴天_取背包装备等级(index)
local aaa=  LUA_取返回值(string.format([[ 
		return LifeAbility : Get_Equip_Level(%d);
	]], index))
	return tonumber(aaa)
end
--取各种等级
function  晴天_取身上令牌信息(index)
	local aaa=  LUA_取返回值(string.format([[ 
			local index = %d
			local nType,BaoZhu1,BaoZhu2,BaoZhu3,BaoZhu4,nQual = DataPool:GetLingPaiInfo()
			--local IconName,ItemName = DataPool:GetLingPaiBaoZhuIconName(1)
			if nType> 0 then
				if index == 1 then
					return BaoZhu1
				end
				if index == 2 then
					return BaoZhu2
				end
				if index == 3 then
					return BaoZhu3
				end
				if index == 4 then
					return BaoZhu4
				end	
				if index == 5 then
					return nQual
				end	
				if  index ==  0 then
					return nType
				end					
			end
			return -1
	]], index))
	return tonumber(aaa)
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

--------------------------------------------------------必备函数-----------------------------------------------------------------

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






function 晴天_取下装备获取名字(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
				晴天_友情提示("准备取下装备位置:"..装备位置名称)
				 if 晴天_取身上装备ID(SelfEuipList[i].equipIndex) <=0 then
					return 0
				end
				local 装备持久 =晴天_取身上装备持久(SelfEuipList[i].equipIndex)
				if 装备持久 <= 0 then
					晴天_友情提示("装备持久不够,不取下")
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

-------------------------------------------------------------------------------------------------------

function 晴天_取帮会城市名称()--请求服务器，获取帮会城市名称，返回-1没有城市 ！
           if 判断有无帮派()==1 then
			   GuildCity_Name = LUA_取返回值([[
					local CityName = Guild:GetMyGuildDetailInfo("CityName")
					return CityName
			   ]], "s")
	   if GuildCity_Name ~= "-1" then--之前已经打开过帮会界面，并已获取过帮会城市，直接返回！
	       return GuildCity_Name
	   end
	   LUA_Call("Guild:AskGuildDetailInfo()");延时(5000)
			   GuildCity_Name = LUA_取返回值([[
					local CityName = Guild:GetMyGuildDetailInfo("CityName")
					return CityName
			   ]], "s")
               延时(1000)
        if 窗口是否出现("NewBangHui_Bhxx") then
	        LUA_Call("setmetatable(_G, {__index = NewBangHui_Bhxx_Env}) NewBangHui_Bhxx_Close()")
	    end
	    return GuildCity_Name
    end  
end

-------------------------------------------------------------------------------------------------------

function 晴天_进入帮会城市(XXX,YYY)
    for i=1,5 do
        if 获取人物信息(16)== 晴天_取帮会城市名称() then
			寻路(XXX,YYY,1);延时(1000)
			break
		else
			跨图寻路("洛阳",236,236);延时(1000)
            对话NPC("范纯仁");延时(1000)
            NPC二级对话("进入本帮城市");延时(5000)
			等待过图完毕();延时(2000)
    	end
	end
end

function  晴天_令牌第一次领取()
	if 晴天_取身上装备名字(20) == "-1" and  获取背包物品数量(令牌名称集合) <=0 then
		if tonumber(获取人物信息(63)) >=100 then --帮贡
			晴天_友情提示("当前装备无令牌 ,前往帮会领取")
			晴天_进入帮会城市(44,47)	
		for i=1,5 do
			if 获取背包物品数量("江湖令") >=1 then
					晴天_穿上装备("令牌","江湖令")
					延时(2000)
			end
			if 晴天_取身上装备名字(20)=="江湖令" then
				延时(2000)
				break
			end
			if 对话NPC("孔相如")==1 then
				延时(2000)
				NPC二级对话("获取令牌") 
				延时(2000)
				任务_完成()
				延时(2000)
			end
		end
	end
	else
	晴天_友情提示("已经有令牌 , 无需领取")
	end
end

function  晴天_令牌自动升阶()
	if 晴天_取身上装备名字(20)==令牌名称列表[5] then
		晴天_友情提示("当前令牌为:"..令牌名称列表[5] .."|无需再进行升阶")
		return
	end
	if 晴天_取身上装备持久(20)<=0 then
		晴天_友情提示("当前令牌为没有持久不进行升阶")
		return
	end
	晴天_进入帮会城市(44,47)	
	for kk=1,4 do
	 if 晴天_取身上装备名字(20)==令牌名称列表[kk] then
		if  tonumber(获取人物信息(63)) >=领取令牌所需帮贡[kk] then
			晴天_友情提示("当前令牌为:"..令牌名称列表[kk].."|要升阶的令牌为:"..令牌名称列表[kk+1])
			晴天_取下装备获取名字("令牌")
				for i=1,5 do
					if 对话NPC("孔相如")==1 then
					延时(2000)
					NPC二级对话("令牌装备升阶") 
					延时(2000)
						 if 窗口是否出现("EquipLingPai_ShengJie") ==1 then
							右键使用物品(令牌名称列表[kk],1)     --参数2:为使用次数
							  延时(2000)
							  LUA_Call ("setmetatable(_G, {__index = EquipLingPai_ShengJie_Env});EquipLingPai_ShengJie_OnOK();")
							 延时(2000)
							晴天_判断关闭窗口("EquipLingPai_ShengJie")
							延时(2000)
							晴天_穿上装备("令牌",令牌名称列表[kk])
							 晴天_穿上装备("令牌",令牌名称列表[kk+1])
							 延时(2000)
						end
						if 晴天_取身上装备名字(20)==令牌名称列表[kk+1] then
							break
						end
				   end
			  end
		  end
	   end
	 end
end

local lingqubaozhu ={
{"青龙宝珠·冰攻击","获取绿色青龙宝珠",0},
{"青龙宝珠·火攻击","获取绿色青龙宝珠",1},
{"青龙宝珠·玄攻击","获取绿色青龙宝珠",2},										
{"青龙宝珠·毒攻击","获取绿色青龙宝珠",3},			
		
{"玄武宝珠·毒抗性","获取蓝色玄武宝珠",3},

{"白虎宝珠·命中","获取黄色白虎宝珠",4},

}
				
function  晴天_获取四象宝珠(name)
	晴天_友情提示("获取:"..name)
	for i =1, 5 do
		if 获取背包物品数量(name) >=1 then
			晴天_友情提示("背包中有宝珠"..name);延时(2000)
			return 
		end
		if tonumber(获取人物信息(63)) <=50 then
			return
		end
		for k=1, #lingqubaozhu do
			if lingqubaozhu[k][1] ==name then
				晴天_进入帮会城市(44,47)	
				if 对话NPC("孔相如")==1 then
					NPC二级对话("获取四象宝珠");延时(2000)
					NPC二级对话(lingqubaozhu[k][2]);延时(2000) 
					任务_完成(lingqubaozhu[k][3]);延时(2000) 
					break
				end
			end
		end		
	end
end


function  晴天_令牌镶嵌宝珠(LPname,ZBname,index)
	if 获取背包物品数量(LPname) >=1 then
		if   获取背包物品数量(ZBname) >=1 then
			local LPindex=获取背包物品位置(LPname)-1
			local ZBindex =获取背包物品位置(ZBname)-1
			LUA_Call(string.format([[
				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name( "RL_SetRs" );
					Set_XSCRIPT_ScriptID( 880001 );
					Set_XSCRIPT_Parameter( 0, %d);  
					Set_XSCRIPT_Parameter( 1, %d-1);  
					Set_XSCRIPT_Parameter( 2, %d );         --- 物品背包索引
					Set_XSCRIPT_ParamCount( 3 );
				Send_XSCRIPT();	
			]], LPindex,index,ZBindex))
		else
			晴天_友情提示("令牌宝珠不齐,无法镶嵌")
		end
	end
end


function  晴天_取背包令牌宝珠等级(LPname,index)
	local tem =LUA_取返回值(string.format([[
		local nRsID =PlayerPackage:Lua_GetBagItemRl_Rs(%d , %d-1)
		if nRsID > 0 then
			return 1
		end 	
		return -1
	]], LPindex,index), "n")
	return tem
end


local 人物名称,当前门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
local  宝珠镶嵌表 ={
{"峨嵋|天山|武当|桃花岛","朱雀宝珠·血上限","青龙宝珠·冰攻击","玄武宝珠·毒抗性","白虎宝珠·命中"},
{"唐门|星宿|丐帮","朱雀宝珠·血上限","青龙宝珠·毒攻击","玄武宝珠·毒抗性","白虎宝珠·命中"},
{"天龙|少林|鬼谷|慕容","朱雀宝珠·血上限","青龙宝珠·毒攻击","玄武宝珠·毒抗性","白虎宝珠·命中"},
{"逍遥|明教|","朱雀宝珠·血上限","青龙宝珠·毒攻击","玄武宝珠·毒抗性","白虎宝珠·命中"},
}

function 晴天_令牌全自动镶嵌宝珠()
	晴天_友情提示("令牌全自动镶嵌宝珠") 
	if 晴天_取所有钱() <= 10*10000  or  tonumber(获取人物信息(63)) < 领取宝珠所需帮贡 then
		晴天_友情提示("令牌全自动镶嵌宝珠,材料不足")
		return
	end
	for i =1, 4 do
		if 晴天_取身上令牌信息(i) == 0 then
			local 令牌名称=晴天_取身上装备名字(20)
			if  晴天_取下装备获取名字("令牌")==0 then                
				return
			end
			local baozhiname = ""
			for k= 1,#宝珠镶嵌表 do
				if string.find(宝珠镶嵌表[k][1],当前门派,1,true) then
					baozhiname=宝珠镶嵌表[k][i+1]
					晴天_友情提示("开始镶嵌宝珠:"..baozhiname..i)
					晴天_获取四象宝珠(baozhiname)
					晴天_令牌镶嵌宝珠(令牌名称,baozhiname,i);
					晴天_穿上装备("令牌",令牌名称)
				end
			end
		end
	end
end	
		

function 晴天_取背包令牌宝珠等级(令牌序号,宝珠序号)
	local aaa=  LUA_取返回值(string.format([[ 
			local m_EquipBagIndex =%d
			local nIndex=%d
			local uLevel = PlayerPackage:Lua_GetBagItemRl_RsLevel(m_EquipBagIndex , nIndex - 1)
			return uLevel
		]], 令牌序号,宝珠序号))
		return tonumber(aaa)
end



function 晴天_令牌宝珠打造与升级(序号,等级)
	 g_RsLevelUp_NeedItem_Num = {
				6,6,6,7,7,7,9,9,9,12,12,12,16,16,16,21,21,21,27,27,27,34,34,34,42,42,42,
				51,51,51,61,61,61,72,72,72,84,84,84,97,97,97,111,111,111,126,126,126,126
			}
	local 提示 =string.format("令牌宝珠打造[%d]目标等级[%d]",序号,等级)
	晴天_友情提示(提示) 
	取出物品("翡翠心精")
	local 宝珠等级 =晴天_取身上令牌信息(序号)
	if 宝珠等级 <= 0 then
		晴天_友情提示("没有宝珠") 
		return
	end	
	if 宝珠等级>=等级 then
		local 提示 =string.format("令牌宝珠打造[%d]目标等级[%d]当前等级[%d],跳过任务",序号,等级,宝珠等级)
		晴天_友情提示(提示) 
		return
	end
	local 背包材料数量 = 获取背包物品数量("翡翠心精")
	local 升级需要数量 = g_RsLevelUp_NeedItem_Num[宝珠等级]
	local 当前金币 = 晴天_取所有钱()
	if 背包材料数量 < 升级需要数量  or 当前金币 <= 5*10000 then
		local 提示 =string.format("令牌宝珠打造[%d]目标等级[%d]当前等级[%d],需要材料[%d]当前材料[%d],金币数量[%d]--材料不足跳过任务",序号,等级,宝珠等级,升级需要数量,背包材料数量,当前金币)
		晴天_友情提示(提示) 
		--存物品("翡翠心精")
		return
	end	
	
	晴天_进入帮会城市(44,47)	
	local 令牌名称=晴天_取身上装备名字(20)
	if  晴天_取下装备获取名字("令牌")==0 then        
		return
	end

    LPindex=获取背包物品位置(令牌名称)-1	
	if LPindex<0 then
		return
	end	
		for j=1,99 do
			local 背包宝珠等级 =晴天_取背包令牌宝珠等级(LPindex,序号) 
			if 背包宝珠等级 >= 等级 then
				local 提示 =string.format("令牌宝珠打造[%d]目标等级[%d]当前等级[%d],跳过任务",序号,等级,背包宝珠等级)
					晴天_友情提示(提示) 
				break
			end
			local 背包材料数量 =获取背包物品数量("翡翠心精")
			local 升级需要数量 =g_RsLevelUp_NeedItem_Num[背包宝珠等级]
			local 当前金币 =晴天_取所有钱()
			if 背包材料数量<升级需要数量  or 当前金币<=5*10000 then
		local 提示 =string.format("令牌宝珠打造[%d]目标等级[%d]当前等级[%d],需要材料[%d]当前材料[%d],金币数量[%d]--材料不足跳过任务",序号,等级,宝珠等级,升级需要数量,背包材料数量,当前金币)
				晴天_友情提示(提示) 
				break
			end		
			LUA_Call(string.format([[	
						local m_EquipBagIndex=%d
						local nIndex =%d
						Clear_XSCRIPT();
						Set_XSCRIPT_Function_Name( "RsLevelUp_RL" );
						Set_XSCRIPT_ScriptID( 880001 );
						Set_XSCRIPT_Parameter( 0, m_EquipBagIndex );         --- 装备背包索引
						Set_XSCRIPT_Parameter( 1,nIndex - 1   );        --- 镶嵌的符石索引
						Set_XSCRIPT_ParamCount( 2 );
					Send_XSCRIPT();	
							]], LPindex,序号))
					延时(2000)
		end	
	延时(2000)	
	晴天_穿上装备("令牌",令牌名称)	
end

function 晴天_取背包装备星星(序号)
	local tem =LUA_取返回值(string.format([[
		local equipQual =PlayerPackage:GetSuperWeaponQual(%d)
		return equipQual
		]], 序号), "n")
	return tonumber( tem)
end



function 晴天_令牌星级提升()
	晴天_友情提示("令牌星级提升") 
	local 当前身上令牌等级 =晴天_取身上令牌信息(5) 
	if 当前身上令牌等级>=8 then
		local 提示 =string.format("令牌星级提升当前等级[%d],跳过任务",当前身上令牌等级)
		晴天_友情提示(提示) 
		延时(1000)
		取出物品("唤灵液")
		晴天_卖出物品("唤灵液",2)
		return
	end	

	取出物品("唤灵液")
	if 获取背包物品数量("唤灵液")<= 0 or 晴天_取所有钱()<=2*10000 then
		晴天_友情提示("令牌星级提升材料不足跳过任务")
		return
	end	
	晴天_进入帮会城市(44,47)	
	local 令牌名称=晴天_取身上装备名字(20)
	if  晴天_取下装备获取名字("令牌")==0 then        
		return
	end
	
    LPindex=获取背包物品位置(令牌名称)-1	
	if LPindex<0 then
		return
	end	

	for i =1,200 do
		if 晴天_取背包装备星星(LPindex)>=8 then
			自动清包("唤灵液")
		end	
		if 获取背包物品数量("唤灵液")<= 0 or  晴天_取所有钱()<=2*10000 then
			晴天_友情提示("令牌星级提升材料不足跳过任务")
			break
		end	
		LUA_Call(string.format([[	
			Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name( "RL_StarLevelup" );
			Set_XSCRIPT_ScriptID( 880001 );
			Set_XSCRIPT_Parameter( 0, %d);         --- 装备背包索引
			Set_XSCRIPT_Parameter( 1, 1);         ---自动购买确认
			Set_XSCRIPT_ParamCount( 2 );
		Send_XSCRIPT();		
		]], LPindex))
		延时(2000)
	end
	晴天_穿上装备("令牌",令牌名称)	
end




function 晴天_取背包令牌扩展确定数量(LPindex,忽略目标抗)
		local tem =	LUA_取返回值(string.format([[
			local  index= %d
			local kangxing = "%s"
			tem = 0 
			for i =0, 2 do
				local nExAttrID , nExAttrStr= PlayerPackage:Lua_GetBagRlExAttr(index, i)
				if string.find(nExAttrStr,"maxhp") or string.find(nExAttrStr,kangxing) then
					tem =tem+1
				end
			end
			PushDebugMessage("令牌已有确认属性条数:"..tem)
			return tem
		]], LPindex,忽略目标抗))
		return tonumber(tem)
end		


function 晴天_令牌扩张属性重铸(属性选择)
	材料数组={1,2,3,100}
	if not 属性选择 then
		属性选择=1 
	end	
	晴天_友情提示("令牌扩张属性重铸") 
	if tonumber(晴天_读角色配置项("晴天超级配置", "令牌扩张属性"))>=3 then
		晴天_友情提示("令牌扩张属性属性满足3个,跳过任务")
		return
	end
	
	
	local 令牌名称=晴天_取下装备获取名字("令牌")
	if  令牌名称==0 then                 --取下武器，如果取下失败则返回
		LUA_Call("PushDebugMessage(\"取下令牌失败，放弃升阶!\")")
		return
	end
    LPindex=获取背包物品位置(令牌名称)-1	
	if LPindex<0 then
		return
	end	
	if 属性选择 ==1 then
		忽略目标抗 ="maxhp"
	end
	if 	属性选择 ==2 then
		if 晴天_取人物属性(1)=="冰" then
			忽略目标抗= "equip_attr_resistother_cold"
		elseif  晴天_取人物属性(1)=="火" then
			忽略目标抗= "equip_attr_resistother_fire"
		elseif  晴天_取人物属性(1)=="玄" then
			忽略目标抗= "equip_attr_resistother_light"
		elseif  晴天_取人物属性(1)=="毒" then
			忽略目标抗= "equip_attr_resistother_poison"
		end
	end
		晴天_友情提示("确定属性为:"..忽略目标抗)
	tem = 晴天_取背包令牌扩展确定数量(LPindex,忽略目标抗)
	
	if tonumber(tem) >= 3 then
		晴天_写角色配置项("晴天超级配置", "令牌扩张属性", "3")
		晴天_友情提示("令牌扩张属性3个属性已经洗完成,跳过任务")
		晴天_穿上装备("令牌",令牌名称)
		return
	end
	
	材料数量=材料数组[tem+1]
	屏幕提示("确定属性条数:"..tem.."|天荒晶石:"..材料数量)
	取出物品("天荒晶石")
	if 获取背包物品数量("天荒晶石")< 材料数量 or 晴天_取所有钱()<=6*10000 then
		晴天_友情提示("材料不足跳过任务")
		晴天_穿上装备("令牌",令牌名称)
		存物品("天荒晶石")
		return
	end	
	
	晴天_进入帮会城市(44,47)	
	for i=1,20 do
		tem = 晴天_取背包令牌扩展确定数量(LPindex,忽略目标抗)
		材料数量=材料数组[tem+1]
		if 获取背包物品数量("天荒晶石")< 材料数量 or  晴天_取所有钱()<=6*10000 then
			晴天_友情提示("材料不足跳过任务")
			break
		end	

		 temtem =	LUA_取返回值(string.format([[
			local  index= %d
			local kangxing = "%s"
			local nExAttrID111 , nExAttrStr111= PlayerPackage:Lua_GetBagRlExAttr(index, 0)
			if string.find(nExAttrStr111,"maxhp") or string.find(nExAttrStr111,kangxing) then
			  aaa=1
			else
			  aaa=0
			end
			local  nExAttrID222 , nExAttrStr222 = PlayerPackage:Lua_GetBagRlExAttr(index, 1)
			if string.find(nExAttrStr222,"maxhp") or string.find(nExAttrStr222,kangxing) then
			  bbb=1
			else
			  bbb=0
			end

			local  nExAttrID333 , nExAttrStr333 = PlayerPackage:Lua_GetBagRlExAttr(index, 2)
			if string.find(nExAttrStr333,"maxhp") or string.find(nExAttrStr333,kangxing) then
			  ccc=1
			else
			  ccc=0
			end

			PushDebugMessage("令牌扩张属性重洗|第一个:"..nExAttrStr111.."|第二个:"..nExAttrStr222.."|第三个:"..nExAttrStr333)

			if aaa+bbb+ccc ==1 then
				PushDebugMessage("需要天荒神石2个")
			elseif  aaa+bbb+ccc ==2 then
				PushDebugMessage("需要天荒神石3个")
			elseif  aaa+bbb+ccc ==3 then
				--PushDebugMessage("222")
				return 3
			end

			Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("RlResetExAttr");
			Set_XSCRIPT_ScriptID(880001);
			Set_XSCRIPT_Parameter(0,index);
			Set_XSCRIPT_Parameter(1,aaa);
			Set_XSCRIPT_Parameter(2,bbb);
			Set_XSCRIPT_Parameter(3,ccc);
			Set_XSCRIPT_Parameter(4,0);
			Set_XSCRIPT_ParamCount(5);
			Send_XSCRIPT();	
			return 1
			]], LPindex,忽略目标抗))
		if tonumber(temtem) == 3 then
			延时(3000)
			晴天_友情提示("令牌扩张属性3个属性已经洗完成,跳过任务")
			延时(3000)
			break
		end
		延时(3000)
	end
	晴天_穿上装备("令牌",令牌名称)
	存物品("天荒晶石")
end

function 晴天_智能令牌宝珠打造与升级(等级)
	local 人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
	if 门派 == "峨嵋" then
		晴天_令牌宝珠打造与升级(1,等级)  -- 序号,指定等级
		晴天_令牌宝珠打造与升级(2,等级)
		晴天_令牌宝珠打造与升级(3,等级)
		晴天_令牌宝珠打造与升级(4,等级)
	else
		晴天_令牌宝珠打造与升级(2,等级)  -- 序号,指定等级
		晴天_令牌宝珠打造与升级(1,等级)
		晴天_令牌宝珠打造与升级(3,等级)
		晴天_令牌宝珠打造与升级(4,等级)
	end
end

function 晴天_全自动智能令牌宝珠打造与升级()
	取出物品("翡翠心精")
	if 晴天_取身上令牌信息(1)>=50 and 晴天_取身上令牌信息(2)>=50 and  晴天_取身上令牌信息(3)>=50 and  晴天_取身上令牌信息(4)>=50 then
		晴天_卖出物品("翡翠心精",2)
	else
		取出物品("金币")
		--	晴天_智能令牌宝珠打造与升级(30)
		---	晴天_智能令牌宝珠打造与升级(40)
		晴天_智能令牌宝珠打造与升级(50)
		存物品("翡翠心精")
		存物品("金币")
	end
end



if tonumber (判断有无帮派()) == 1  then
	晴天_友情提示("晴天定制所有文本百分之99文本")
	else
	晴天_友情提示("你还没有帮会,跳过所有令牌任务")
	延时(3000)
	return
end

晴天_令牌第一次领取()
晴天_令牌自动升阶()
晴天_令牌全自动镶嵌宝珠()
晴天_全自动智能令牌宝珠打造与升级()
晴天_令牌星级提升()
--晴天_令牌扩张属性重铸(2) --1  为指定三血上限        2为血上限和忽抗

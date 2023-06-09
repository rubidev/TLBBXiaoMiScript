
--------------------------------------------------装备相关------------------------------------------------
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

-----------------------------------------------------------------------------------------------------

function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天QQ103900393提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
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
		屏幕提示("写角色配置项|"..AAA.."|"..BBB.."|"..CCC);延时(200)
		写配置项(路径,AAA,BBB,CCC);延时(200)
	end
end

function 晴天_读角色配置项(AAA, BBB)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
    local tem =读配置项(路径,AAA,BBB)
	if tem ~=nil then
		屏幕提示(AAA.."|"..BBB.."=="..tem);延时(500)
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
		屏幕提示("晴天取人物最高属性攻击:"..属性攻击)
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

------------------------------------------------------------------------------------------------------------------------------------------------

function 晴天_取所有钱()
	local 所有钱=获取人物信息(52) +获取人物信息(45)
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


	
function 晴天_取身上装备位置等级(装备位置名称)
	for i =1,#SelfEuipList do
		if SelfEuipList[i].name == 装备位置名称 then
			return	晴天_取身上装备等级(SelfEuipList[i].equipIndex) 
		end
	end
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





---------------------------------------------------------必备函数-----------------------------------------------------------------

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
						晴天_判断关闭窗口("SelfJunXian")
					elseif 装备位置名称=="武魂" then
						晴天_友情提示("存入琉璃焰|御瑶盘|,防止错误")
						延时 (2000)
						存物品("|琉璃焰|御瑶盘|")
						
						 LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
						延时 (2000)
						LUA_Call ("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
						延时 (2000)
						晴天_判断关闭窗口("Wuhun")
					else
						LUA_Call(string.format([[ setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)]], SelfEuipList[i].downIndex))
					end	
					延时(3000)
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
				晴天_判断关闭窗口("Shop")
				晴天_判断关闭窗口("YuanbaoShop")
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


function 晴天_取身上雕纹等级(index,order)  --装备序号,雕纹序号
	local tem =LUA_取返回值(string.format([[
	local index =%d
	local order =%d
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

------------------------------------------------------------------------------------





local  aaaaa,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
local 材料数组 ={1,2,9,50,87,165,300}

function 晴天_雕纹升级(装备位置名称,等级)
	local 雕纹等级 = 晴天_取身上装备位置雕纹等级(装备位置名称,1) 
	if 雕纹等级<= 0 then
		屏幕提示("没有雕纹")
		return
	end	
	屏幕提示(装备位置名称.."雕纹等级:"..雕纹等级)
	延时(200)
	if 雕纹等级 >= 等级 then
		return
	end
	local 需要金蚕丝数量 =材料数组[雕纹等级]	
	if 获取背包物品数量("金蚕丝") < 需要金蚕丝数量 then
		屏幕提示("雕纹等级升级,金蚕丝不够")
		return
	end
	if 	晴天_取所有钱()  <5*10000 then
		屏幕提示("雕纹等级升级,金币不够")
		return
	end

   local  LPname= 晴天_取下装备获取名字(装备位置名称)
	延时(2000) 
    if LPname == 0 then
        return
    end

	  --屏幕提示("装备位置名称:"..LPname)
     local LPindex=获取背包物品位置(LPname)-1
	    -- 屏幕提示("待精通升级的背包序号:"..LPindex)
	if LPindex<0 then
		    return
	end
		

	跨图寻路("洛阳",318,313)
	延时(2000) 
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
						PushDebugMessage("雕纹已经够设置等级:"..todwlevel)
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
		晴天_穿上装备(装备位置名称,LPname)
end



function  晴天_全自动雕纹升级(index)
	for i =1,#SelfEuipList do
		取出物品("金币",99999999)
		取出物品("金蚕丝")	
		local 需要金蚕丝数量 =材料数组[index]	
		if 获取背包物品数量("金蚕丝") < 需要金蚕丝数量 then
			屏幕提示("雕纹等级升级.."..index..",金蚕丝不够:"..需要金蚕丝数量)
			延时(2000)
			break
		end
		local 装备位置名称 =SelfEuipList[i].name
		晴天_雕纹升级(装备位置名称,index)
	end
end

 晴天_全自动雕纹升级(3)
 晴天_全自动雕纹升级(4)
 晴天_全自动雕纹升级(5)
 晴天_全自动雕纹升级(6)
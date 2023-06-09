
znEuipList =
{
	[1]  = { name="属性", downIndex=0,  equipIndex=0, equipName="" },   
	[2]  = { name="体力", downIndex=1, equipIndex=1, equipName=""},    
	[3]  = { name="命中", downIndex=2,  equipIndex=5,equipName=""  },   
	[4]  = { name="会心", downIndex=3,  equipIndex=4, equipName=""},    
	[5]  = { name="身法", downIndex=4,  equipIndex=2, equipName=""},    
	[6]  = { name="闪避", downIndex=5, equipIndex=3, equipName=""},    
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

function 晴天_判断关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))  
		延时(1500)
	  end
end

-------------------------------------------------子女函数---------------------------------
function 晴天_取子女装备ID(index)
		local tem =LUA_取返回值(string.format([[
	        return EnumAction(%d ,"infantcard"):GetID()
	  ]], index));
	return tonumber(tem)
end

function 晴天_取子女装备名称(index)
		local tem =LUA_取返回值(string.format([[
	        return EnumAction(%d ,"infantcard"):GetName()
	  ]], index));
	return tostring(tem)
end

function 晴天_取子女典籍等级(index)
		local tem =LUA_取返回值(string.format([[
	        return PlayerPackage:GetInfantCard_EnhanceLevel(%d)
	  ]], index));
	return tonumber(tem)
end
		
		

function 晴天_取下子女装备获取名字(装备位置名称)
	for i =1,#znEuipList do
		if znEuipList[i].name == 装备位置名称 then
			晴天_友情提示("准备取下装备位置:"..装备位置名称)
				if 晴天_取子女装备ID(znEuipList[i].equipIndex) == 0  then
					return 0
				end
				for k =1, 10 do	
					local  装备名称 = 晴天_取子女装备名称(znEuipList[i].equipIndex)
					晴天_友情提示("准备取下装备位置:"..装备名称)	
					if  窗口是否出现("Infant")~=1  then
						LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
						LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Infant_Switch();");延时(2000)
						LUA_Call ("setmetatable(_G, {__index = Infant_Env});Infant_SetCheckBox(1);");延时(2000)
					end
					LUA_Call(string.format([[setmetatable(_G, {__index = Infant_Env}); Infant_Card_Clicked(%d,0);]], znEuipList[i].downIndex))
					延时(5000)
					if  晴天_取子女装备ID(znEuipList[i].equipIndex) == 0 then
						晴天_判断关闭窗口("Infant")
						晴天_判断关闭窗口("SelfEquip")
						return 装备名称
					end	
				end	
				return 0
			end
		end
end

function 晴天_穿上子女装备(装备位置名称,装备名称)
     if 装备名称==""  then
		晴天_友情提示("参数错误,晴天_穿上子女装备")
		return
	end
	if 获取背包物品数量(装备名称)<=0 then
			晴天_友情提示("没有装备无法使用,晴天_穿上子女装备")
			return
	end	
	for i =1,#znEuipList do
		if znEuipList[i].name == 装备位置名称 then
			for k =1, 5 do
				if  窗口是否出现("Infant")~=1  then
					LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
					LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Infant_Switch();");延时(2000)
					LUA_Call ("setmetatable(_G, {__index = Infant_Env});Infant_SetCheckBox(1);");延时(2000)
				end
				右键使用物品(装备名称);延时(2000)
				if  晴天_取子女装备ID(znEuipList[i].equipIndex) > 0 then
					晴天_判断关闭窗口("Infant")
					晴天_判断关闭窗口("SelfEquip")
					晴天_友情提示(" 晴天成功穿上"..装备名称.."|在位置:"..装备位置名称)
					break   
				end
			end
		end
	end
end



-----------------------------------------------------------------------------------------


function 晴天_子女典籍升级(装备位置名称,等级)
	local 典籍等级=tonumber( 晴天_读角色配置项("超级晴天", 装备位置名称.."典籍等级"))
	if 典籍等级 >= 等级 then
		晴天_友情提示(装备位置名称..等级.."|跳过任务")
		return 
	end
		取出物品("典籍注解")
	if 获取背包物品数量("典籍注解") <= 0 then
		晴天_友情提示("材料不足")
		return
	end	
	跨图寻路("洛阳",151,173)
	local 装备名称= 晴天_取下子女装备获取名字(装备位置名称)
	延时(3000) 
	晴天_友情提示(装备名称)
	if 装备名称 == 0 then
             return -1
		else
	   LPindex=获取背包物品位置(装备名称)-1	
	end
	if 晴天_取子女典籍等级(LPindex) >=等级  then
		晴天_穿上子女装备(装备位置名称,装备名称)
		return
	end
		
	for i =1,50 do
		if 获取背包物品数量("典籍注解") <= 0 then
			晴天_友情提示("材料不足")
			break
		end	
		    LUA_Call(string.format([[
			g_BagIndex = %d
			if g_BagIndex == -1 then
		PushDebugMessage("#{ZSJX_140707_05}")
		return
	end
	
			local g_MoneyCost =10000
				local selfMoney = Player : GetData( "MONEY" ) + Player : GetData( "MONEY_JZ" )
	if selfMoney < g_MoneyCost then
		PushDebugMessage("#{KPWFS_131112_26}")
		return
	end
	
	local enhancelevel = PlayerPackage:GetInfantCard_EnhanceLevel(g_BagIndex)
	if enhancelevel >= %d then
		PushDebugMessage("#{KPWFS_131112_45}")
		return
	end
			
		--if PlayerPackage:CountAvailableItemByIDTable(38000807) <= 0 then
			--PushDebugMessage("材料不足")
			--return
		--end		
			
		 Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("StudyBooks");
			Set_XSCRIPT_ScriptID(890630);
			Set_XSCRIPT_Parameter(0,g_BagIndex);
			Set_XSCRIPT_Parameter(1,1);  
			Set_XSCRIPT_ParamCount(2);
		Send_XSCRIPT()
	  ]], LPindex,等级))
	延时(2000)
	典籍等级=晴天_取子女典籍等级(LPindex)
	if 典籍等级>= 等级 then
		break
	end	
		延时(3000)
	end
	local 典籍等级=晴天_取子女典籍等级(LPindex)
	晴天_写角色配置项("超级晴天", 装备位置名称.."典籍等级",典籍等级) 
	晴天_穿上子女装备(装备位置名称,装备名称)
end

function 晴天_子女全自动典籍升级(等级)
	晴天_子女典籍升级("属性",等级)
	晴天_子女典籍升级("体力",等级)
	晴天_子女典籍升级("命中",等级)
	晴天_子女典籍升级("会心",等级)
	晴天_子女典籍升级("身法",等级)
	晴天_子女典籍升级("闪避",等级)
end


function 晴天_子女典籍平均升级()
	if tonumber(LUA_取返回值('return Infant:GetHeroType(0);')) <= 0 then
		晴天_友情提示("子女没有成年")
		return
	end	
	取出物品("典籍注解")	
	取出物品("金币")
	for i =1,9 do
		晴天_子女全自动典籍升级(i)
	end
	存物品("金币")
	存物品("典籍注解")
end

---------------------------------------------------------
晴天_子女典籍平均升级()	



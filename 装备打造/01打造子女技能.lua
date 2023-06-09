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

function 晴天_取所有钱()
	所有钱=获取人物信息(52) +获取人物信息(45)
	return 所有钱
end



function 晴天_取子女技能等级(技能名称)
	local tem = LUA_取返回值(string.format([[
		for i = 0, 3 do
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
			if szSkillName=="%s" then
				return nSkillLevel
			end
		end	
		return -1
		]],技能名称))  
		return tonumber(tem)
end

function 晴天_取子女技能序号等级(序号)
	local tem = LUA_取返回值(string.format([[
			i =%d-1
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,i)
			return nSkillLevel
		]],序号))  
		return tonumber(tem)
end


function 晴天_取子女技能序号(技能名称)
	local tem = LUA_取返回值(string.format([[
		for i = 0, 3 do
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
			if szSkillName=="%s" then
				return i+1
			end
		end	
		return -1
		]],技能名称))  
		return tonumber(tem)
end

function 晴天_取子女技能等级(技能名称)
	local tem = LUA_取返回值(string.format([[
		for i = 0, 3 do
			local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
			if szSkillName=="%s" then
				return nSkillLevel
			end
		end	
		return -1
		]],技能名称))  
		return tonumber(tem)
end

function 晴天_子女技能特定升级(技能名称,等级)
	晴天_友情提示("子女技能特定升级:"..技能名称..等级)
	for i=1,20 do
			if 获取背包物品数量("悟灵珠")<=0 then
					晴天_友情提示("悟灵珠没有")
					return
			end
			if 晴天_取所有钱() <= 5*10000 then
				晴天_友情提示("金币不足")
					return
			end	
		local tem = LUA_取返回值(string.format([[
				local InfantCount = Infant:GetInfantCount();
				if InfantCount <= 0  then
						return 2
				end
			guid_H, guid_L = Infant:GetInfantGUID(0);
			nSkillID2=-1
			for i = 0, 3 do
				local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
					if szSkillName=="%s" then
						nSkillID2=nSkillID
						if nSkillLevel>= %d then
							return 2
						end
					end
				end	
			if nSkillID2 == -1 then
				return 2
			end
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("InfantSkillLevelUp");
			Set_XSCRIPT_ScriptID(890600);
			Set_XSCRIPT_Parameter(0,guid_H);
			Set_XSCRIPT_Parameter(1,guid_L);
			Set_XSCRIPT_Parameter(2,nSkillID2);
			Set_XSCRIPT_Parameter(3,1);
			Set_XSCRIPT_ParamCount(4);
		Send_XSCRIPT();
		]],技能名称,等级))  
		延时(3000)	
		if tonumber(tem) == 2 then
				break
		end
	end
end
----------------------------------------------------------------------------------------------------

function 晴天_子女技能升级(等级)
	for kkk=1,4 do
		晴天_友情提示("升级子女技能序号"..kkk)
		for i=1,20 do
			if 晴天_取子女技能序号等级(kkk) >= 等级  then
				break
			end	
			if 获取背包物品数量("悟灵珠")<=0 then
					晴天_友情提示("悟灵珠没有")
					return
			end
			if 晴天_取所有钱() <= 5*10000 then
				晴天_友情提示("金币不足")
					return
			end	
			local tem = LUA_取返回值(string.format([[
					i=%d-1
					local InfantCount = Infant:GetInfantCount();
					if InfantCount <= 0  then
							return 2
					end
				guid_H, guid_L = Infant:GetInfantGUID(0);
				local nSkillID, nSkillLevel, nSkillEffect, nSkillUpRate, szSkillName, szIcon, szTipsInfo = Infant:GetInfantSkillInfo(0,  i )
				if nSkillLevel >= 9  or  nSkillLevel >= %d then
					return 2
				end
				if nSkillID == -1 then
					return 2
				end
				Clear_XSCRIPT();
					Set_XSCRIPT_Function_Name("InfantSkillLevelUp");
					Set_XSCRIPT_ScriptID(890600);
					Set_XSCRIPT_Parameter(0,guid_H);
					Set_XSCRIPT_Parameter(1,guid_L);
					Set_XSCRIPT_Parameter(2,nSkillID);
					Set_XSCRIPT_Parameter(3,1);
					Set_XSCRIPT_ParamCount(4);
				Send_XSCRIPT();
			]],kkk,等级))  
			延时(3000)		
			if tonumber(tem) == 2 then
				break
			end	
		end
	end	
end

function 晴天_子女技能全自动升级(等级,是否毒抗)	
	取出物品("悟灵珠");延时(2000)
	取出物品("金币");延时(2000)
	跨图寻路("洛阳",150,183)		
	if 是否毒抗 == 1 then
		晴天_子女技能特定升级("毒抗",等级)
	end	
	晴天_子女技能升级(等级)
	存物品("悟灵珠");延时(2000)
	存物品("金币")
end

function 晴天_子女技能平衡升级(是否毒抗,优先等级)	
	for i=1,9 do
		if 是否毒抗 == 1 then
			晴天_子女技能特定升级("毒抗",优先等级)
		end	
		晴天_子女技能升级(i)
	end
end

function 晴天_子女技能全自动升级(是否毒抗,优先等级)	
	晴天_友情提示("子女技能全自动升级")
	取出物品("悟灵珠");
	取出物品("金币");
	if 获取背包物品数量("悟灵珠") >=1  and 晴天_取所有钱() >= 5*10000 then
		跨图寻路("洛阳",150,183)		
		晴天_子女技能平衡升级(是否毒抗,优先等级)
		else
		晴天_友情提示("悟灵珠金币不足")
	end	
	存物品("悟灵珠");
	存物品("金币");
end

function 晴天_判断关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		LUA_Call(string.format([[
			setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName))  
		延时(1500)
	  end
end

function 晴天_取子女数量()
	for k =1, 5 do
		if  窗口是否出现("Infant")~=1  then
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();");延时(2000)
			LUA_Call ("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Infant_Switch();");延时(2000)
			LUA_Call ("setmetatable(_G, {__index = Infant_Env});Infant_SetCheckBox(1);");延时(2000)
		else
			local tem=LUA_取返回值(string.format([[
				return Infant:GetInfantCount();
			]]))  
			晴天_判断关闭窗口("SelfEquip")
			return tonumber(tem)
		end
		延时(500)
	end
	return 0
end

function 晴天_取子女等级()
		local tem=LUA_取返回值(string.format([[
			TTCount = Infant:GetInfantCount()
			if TTCount<= 0 then
				return 0
			end
			return Infant:GetInfantLevel(0)
			]]))  
		return tonumber(tem)
end


------------------------------------------------------------------------------------

if 晴天_取子女等级() >=31 then
	晴天_子女技能全自动升级(1,5)	
end
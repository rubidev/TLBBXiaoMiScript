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
		晴天_友情提示("写角色配置项|"..AAA.."|"..BBB.."|"..CCC);延时(20)
		写配置项(路径,AAA,BBB,CCC);延时(20)
	end
end

function 晴天_读角色配置项(AAA, BBB)
    local 名字= 获取人物信息(12)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
    local tem =读配置项(路径,AAA,BBB)
	if tem then
		晴天_友情提示("读角色配置:"..AAA.."|"..BBB.."=="..tem);延时(20)
	else
		return -1
	end
	return tem
end



function 晴天_写指定角色配置项(名字,AAA, BBB, CCC)
    local 路径=string.format("C:\\天龙小蜜\\角色配置\\%s.ini",名字)
	if AAA~=nil and BBB~=nil and CCC~=nil  then
		晴天_友情提示("写角色配置项|"..AAA.."|"..BBB.."|"..CCC);延时(20)
		写配置项(路径,AAA,BBB,CCC);延时(20)
	end
end

function 晴天_增加角色配置项(AAA, BBB, CCC)
     local tem =晴天_读角色配置项(AAA, BBB);延时(2000)
	if tem ~=nil or  tem ~= "" then
		if  not string.find(tem,CCC) then
			CCC=tem..CCC
			延时(2000)
			晴天_写角色配置项(AAA, BBB, CCC)
		end	
	else
		延时(2000)
		晴天_写角色配置项(AAA, BBB, CCC)
	end
end

function 晴天_删除角色配置项(AAA, BBB, CCC)
    local tem =晴天_读角色配置项(AAA, BBB);延时(1000)
	if tem ~=nil and  tem ~= "" then
		if string.find(tem,CCC) then
			DDD=string.gsub(tem,CCC,"|")
			延时(2000)
			晴天_写角色配置项(AAA, BBB, DDD)
		end
		else
		晴天_友情提示("删除角色配置项..无数据")
	end
end




function 晴天_取豪侠印等级()
	local main_lv = LUA_取返回值(string.format([[
		 ActionHXY = EnumAction(21,"equip")
		if ActionHXY and ActionHXY:GetID() ~= 0 then
			local nEquipLevel = DataPool:Lua_GetHXYLevel(  )
			return  nEquipLevel 
		else
			return 0
		end
		]]))  
	return  tonumber( main_lv)
end


if 晴天_取豪侠印等级() >= 100 then
	晴天_删除角色配置项("配置","战功物品", "豪侠勋章")
	
	晴天_增加角色配置项("配置","战功物品", "|润物露|")
	晴天_增加角色配置项("配置","战功物品", "|御赐令赏|")
else
	取出物品("润物露")
	local 背包数量 =获取背包物品数量("润物露")
	if 背包数量>=30 then
			晴天_删除角色配置项("配置","战功物品", "润物露")	
			晴天_增加角色配置项("配置","战功物品", "|豪侠勋章|")
			晴天_增加角色配置项("配置","战功物品", "|御赐令赏|")
		else
			晴天_删除角色配置项("配置","战功物品", "御赐令赏")	
			晴天_增加角色配置项("配置","战功物品", "|润物露|")
			晴天_增加角色配置项("配置","战功物品", "|豪侠勋章|")	
	end
	存物品("润物露")
end	

执行功能("买战功物品")






function 晴天_豪侠印升级()
	屏幕提示("晴天_豪侠印升级")
	取出物品("豪侠勋章")
	for i=1,20 do
		if 获取背包物品数量("豪侠勋章")>0 then
			LUA_Call ("SelfJunXian_EquipHXYLevelup();");延时(200)
		end
	end
	执行功能("自动存仓") 
end

晴天_豪侠印升级()
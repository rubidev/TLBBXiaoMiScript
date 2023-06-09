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
			屏幕提示("属性攻击:"..属性攻击)
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

function 晴天_取宝玉等级(index)
	local tem =LUA_取返回值(string.format([[
		local bElementsLevel= Player:GetFiveElements_ElementsLevel(%d-1)
		return  bElementsLevel
		]],index), "n")
	return tonumber(tem)
end

function 晴天_取宝玉升级需要数量()
	local tem =LUA_取返回值(string.format([[
	local	g_CostMoney = {  20000 , 50000 , 80000 ,120000 ,160000 , 
		200000 , 250000 , 300000 , 400000 ,500000}
		
	local	g_CostItemCount = {  2 , 5 , 8 ,12 ,16 , 20 , 25 , 30 , 40 ,50}
	local num = 2
	local nIndex2Cohesion = Player:GetFiveElementsIndexCanDoCohesion()
	if nIndex2Cohesion >= 0 and nIndex2Cohesion < 5 then
		local bElementsLevel	= Player:GetFiveElements_ElementsLevel( nIndex2Cohesion )
		local nLevelGrade = math.floor ( bElementsLevel / 10 )
		if nLevelGrade >= 0 and nLevelGrade <= 9 then
			 num =g_CostItemCount[  nLevelGrade + 1 ] 
		end
	end
	
	return num
		]]), "n")
	return tonumber(tem)
end
function 晴天_取所有钱()
	local 所有钱=获取人物信息(52) +获取人物信息(45)
	return 所有钱
end


function 晴天_取宝玉升级需要金币()
	local tem =LUA_取返回值(string.format([[
	local	g_CostMoney = {  20000 , 50000 , 80000 ,120000 ,160000 , 
		200000 , 250000 , 300000 , 400000 ,500000}
		
	local	g_CostItemCount = {  2 , 5 , 8 ,12 ,16 , 20 , 25 , 30 , 40 ,50}
	local num = 20000
	local nIndex2Cohesion = Player:GetFiveElementsIndexCanDoCohesion()
	if nIndex2Cohesion >= 0 and nIndex2Cohesion < 5 then
		local bElementsLevel	= Player:GetFiveElements_ElementsLevel( nIndex2Cohesion )
		local nLevelGrade = math.floor ( bElementsLevel / 10 )
		if nLevelGrade >= 0 and nLevelGrade <= 9 then
			 num =g_CostMoney[  nLevelGrade + 1 ] 
		end
	end
	
	return num
		]]), "n")
	return tonumber(tem)
end

	
function 晴天_取选择信息()
	local tem =LUA_取返回值(string.format([[
		setmetatable(_G, {__index = EquipBaoJian_YuLuan_Tips_Env});
		if this:IsVisible() hen
			local str =EquipBaoJian_YuLuan_Tips_Info:GetText()
			if string.find(str,'一条属性效果',1,true) then
				return 1
			end
		end
		return -1
	]]))
	return tonumber(tem)
end 


		
function 晴天_宝玉自动学习()
	local index =1
	local  人物决定属性= 晴天_取人物属性(1)
	if 人物决定属性=="冰" then
		index= 1
	elseif  人物决定属性=="火" then
		index= 2
	elseif  人物决定属性=="玄" then
		index=3	
	elseif  人物决定属性=="毒" then
		index=4
	end
	for  i =1,9 do
		if 晴天_取宝玉等级(1) >= 1 and 晴天_取宝玉等级(2) >= 1 and 晴天_取宝玉等级(3) >= 1 and 晴天_取宝玉等级(4) >= 1 and 晴天_取宝玉等级(5) >= 1 then
			屏幕提示("宝玉都大于1了不用学习了!!~~")
			break
		end	
		取出物品("九天玉碎")
		取出物品("金币",999999)
		if 窗口是否出现("EquipBaoJian_Cohesion")==1 then
			屏幕提示("开始学习!!~~")
			LUA_Call("setmetatable(_G, {__index = EquipBaoJian_Cohesion__Env});EquipBaoJian_Cohesion_OnOK();")
			延时 (3000)
			if 晴天_取宝玉等级(i)== 0  then
				--选择属性
				if 窗口是否出现("EquipBaoJian_YuLuan_Tips") ==1 then	
						屏幕提示("属性选择"..index)
						LUA_Call(string.format([[
						setmetatable(_G, {__index = EquipBaoJian_YuLuan_Tips_Env});EquipBaoJian_YuLuan_Tips_OnSelect(%d);
						setmetatable(_G, {__index = EquipBaoJian_TianHuo_Tips_Env});this:Hide()
					]],index), "n")
					延时(3000)
				end
				--减抗选择
				if 窗口是否出现("EquipBaoJian_YunShui_Tips") ==1 then	
					屏幕提示("减抗选择"..index)
					LUA_Call(string.format([[
						setmetatable(_G, {__index = EquipBaoJian_YunShui_Tips_Env});EquipBaoJian_YunShui_Tips_OnSelect(%d);
						setmetatable(_G, {__index = EquipBaoJian_TianHuo_Tips_Env});this:Hide()
					]],index), "n")
					延时(3000)
				end
				--
				if 窗口是否出现("EquipBaoJian_TianHuo_Tips") ==1 then		
						屏幕提示("穿刺选择:穿刺")
						LUA_Call(string.format([[
						setmetatable(_G, {__index = EquipBaoJian_TianHuo_Tips_Env});EquipBaoJian_TianHuo_Tips_OnSelect(1);
						setmetatable(_G, {__index = EquipBaoJian_TianHuo_Tips_Env});this:Hide()
					]],index), "n")
					延时(3000)
				end	
			end
		else
			跨图寻路("凤鸣镇",113,200)
			if 对话NPC("杜钏灵")==1 then
				NPC二级对话("五行宝玉凝聚",0)
			end
			延时(3000)	
		end
	end
end



function 晴天_五行宝玉凝聚()
    for k=1,999 do
		取出物品("九天玉碎")
		local neednum =晴天_取宝玉升级需要数量()
		if 获取背包物品数量("九天玉碎") <neednum then
			屏幕提示("材料不足,跳过");延时 (1000)
			break
		end
		取出物品("金币",9999999)
		local needmenoy = 晴天_取宝玉升级需要金币()
		if 晴天_取所有钱()< needmenoy then
			屏幕提示("金币不足,跳过");延时 (1000)
			break
		end
       if 窗口是否出现("EquipBaoJian_Cohesion")==1 then
			LUA_Call("setmetatable(_G, {__index = EquipBaoJian_Cohesion__Env});EquipBaoJian_Cohesion_OnOK();")
			延时(200)	
			local 提示 =获取人物信息(37)
			if 提示 then
				--写配置项("C:\\天龙小蜜\\提示.ini","提示","提示",提示)
				--金币不足
				if string.find(提示,"#{ZZZB_150811_188}",1,true) then
					屏幕提示("金币不足,跳过")
					延时 (1000)
					break
				elseif  string.find(提示,"#{ZZZB_150811_187}",1,true) then
					屏幕提示("材料不足,跳过")
					延时 (1000)
					break
				end
			end
        else 
			跨图寻路("凤鸣镇",113,200)
             if 对话NPC("杜钏灵")==1 then
				NPC二级对话("五行宝玉凝聚",0)
				延时 (1000)
			end
         end
	end 
	存物品("九天玉碎")
	存物品("金币")
end

晴天_宝玉自动学习()
晴天_五行宝玉凝聚()

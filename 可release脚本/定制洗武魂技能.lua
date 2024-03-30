指定武魂技能 = {
    "武勇之魂",
    "强击之魂|星准之魂",
	"天雷轰顶|雷霆猛击"
    
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetMyMoney()
    local myMoney = LUA_取返回值([[
        local myMoney = Player:GetData('MONEY') + Player:GetData('MONEY_JZ')
        return myMoney
    ]])
    return tonumber(myMoney)
end

function main()
    MentalTip("根据上方配置, 重洗武魂3个技能")
    取出物品("忆魂石|金币")
    if 获取背包物品数量("忆魂石") <= 0 then
        MentalTip("背包中【忆魂石】数量不足, 退出")
        return
    end

    if GetMyMoney() < 5 * 10000 then
        MentalTip("金币不足, 退出")
        return
    end

    local tmp = 0
	
	LUA_Call([[setmetatable(_G, {__index = Wuhun_Env});Wuhun_Equip_Clicked( 0 );]])  -- 摘下武魂
	
	
	if 指定武魂技能[1] ~= nil and 指定武魂技能[1] ~= "" then
		local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   PushDebugMessage(v)
			   local oldSkillDesc = DataPool:GetKFSSkillDesc(0,0)
			   --PushDebugMessage(oldSkillDesc)
				if string.find(oldSkillDesc, v) then
					return 1
				end
			end
			
			return -1
		]], 指定武魂技能[1]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		延时(200)
	end
	
	if 指定武魂技能[2] ~= nil and 指定武魂技能[2] ~= "" then
		local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   --PushDebugMessage(v)
			   local oldSkillDesc = DataPool:GetKFSSkillDesc(0,1)
				if string.find(oldSkillDesc, v) then
					return 1
				end
			end
			
			return -1
		]], 指定武魂技能[2]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		延时(200)
	end
	
	
	if 指定武魂技能[3] ~= nil and 指定武魂技能[3] ~= "" then
		local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   --PushDebugMessage(v)
			   local oldSkillDesc = DataPool:GetKFSSkillDesc(0,2)
				if string.find(oldSkillDesc, v) then
					return 1
				end
			end
			
			return -1
		]], 指定武魂技能[3]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		延时(200)
	end
		
    if tmp == #指定武魂技能 then
        MentalTip("您的武魂已满足目标技能, 无需再洗")
        return
    end
	

	跨图寻路("大理", 140, 195)
    延时(1500)
    对话NPC("无崖子")
    延时(1000)
    NPC二级对话("重洗武魂技能")
    延时(1000)	

    local pos1 = 获取背包物品位置("琉璃焰")
    local pos2 = 获取背包物品位置("御瑶盘")
    if tonumber(pos1) ~= 0 then
        右键使用物品("琉璃焰")
    else
        右键使用物品("御瑶盘")
    end
    延时(1000)

    local count = 1
    while true do
        if GetMyMoney() < 5 * 10000 or 获取背包物品数量("忆魂石") <= 0 then
            MentalTip("材料【忆魂石】或金币不足, 退出")
            break
        end

        MentalTip(string.format("开始第%d次重洗", count))
        LUA_Call([[setmetatable(_G, {__index = NewWuhunSkillStudy_Env});NewWuhunSkillStudy_OK_Clicked();]])
        延时(500)
        local newCount = 0
		
		
		if 指定武魂技能[1] ~= nil and 指定武魂技能[1] ~= "" then
			local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   --PushDebugMessage(v)
			   local newSkillDesc = DataPool : GetKFSNewSkillDesc(0,0);
				if string.find(newSkillDesc, v) then
					return 1
				end
			end
			
			return -1
			]], 指定武魂技能[1]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			延时(200)
		end
		
		if 指定武魂技能[2] ~= nil and 指定武魂技能[2] ~= "" then
			local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   --PushDebugMessage(v)
			   local newSkillDesc = DataPool : GetKFSNewSkillDesc(0,1);
				if string.find(newSkillDesc, v) then
					return 1
				end
			end
			
			return -1
			]], 指定武魂技能[2]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			延时(200)
		end
		
		if 指定武魂技能[3] ~= nil and 指定武魂技能[3] ~= "" then
			local ret = LUA_取返回值(string.format([[
			function StringSplit(str, reps)
				local resultStrList = {}
				string.gsub(str, '[^' .. reps .. ']+',
						function(w)
							table.insert(resultStrList, w)
						end
				)
				return resultStrList
			end

			local targetWuHunSkill = "%s"
			
			local thirdSkillList = StringSplit(targetWuHunSkill, "|")
			
			for _, v in pairs(thirdSkillList) do
			   --PushDebugMessage(v)
			   local newSkillDesc = DataPool : GetKFSNewSkillDesc(0,2);
				if string.find(newSkillDesc, v) then
					return 1
				end
			end
			
			return -1
			]], 指定武魂技能[3]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			延时(200)
		end
		

        if newCount == #指定武魂技能 then
            LUA_Call([[setmetatable(_G, {__index = NewWuhunSkillStudy_Env});NewWuhunSkill_SaveChange_OK()]])
            MentalTip("重洗武魂技能完成")
            break
        else
            MentalTip(string.format("本次有【%d】条技能满足条件", newCount))
        end
        count = count + 1
        延时(100)
    end
end

-- -------------------------- MAIN ----------------------
main()
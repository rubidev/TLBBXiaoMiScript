ָ����꼼�� = {
    "����֮��",
    "ǿ��֮��|��׼֮��",
	"���׺䶥|�����ͻ�"
    
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."����ҹ��Ʒ, ���Ǿ�Ʒ��".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetMyMoney()
    local myMoney = LUA_ȡ����ֵ([[
        local myMoney = Player:GetData('MONEY') + Player:GetData('MONEY_JZ')
        return myMoney
    ]])
    return tonumber(myMoney)
end

function main()
    MentalTip("�����Ϸ�����, ��ϴ���3������")
    ȡ����Ʒ("���ʯ|���")
    if ��ȡ������Ʒ����("���ʯ") <= 0 then
        MentalTip("�����С����ʯ����������, �˳�")
        return
    end

    if GetMyMoney() < 5 * 10000 then
        MentalTip("��Ҳ���, �˳�")
        return
    end

    local tmp = 0
	
	LUA_Call([[setmetatable(_G, {__index = Wuhun_Env});Wuhun_Equip_Clicked( 0 );]])  -- ժ�����
	
	
	if ָ����꼼��[1] ~= nil and ָ����꼼��[1] ~= "" then
		local ret = LUA_ȡ����ֵ(string.format([[
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
		]], ָ����꼼��[1]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		��ʱ(200)
	end
	
	if ָ����꼼��[2] ~= nil and ָ����꼼��[2] ~= "" then
		local ret = LUA_ȡ����ֵ(string.format([[
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
		]], ָ����꼼��[2]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		��ʱ(200)
	end
	
	
	if ָ����꼼��[3] ~= nil and ָ����꼼��[3] ~= "" then
		local ret = LUA_ȡ����ֵ(string.format([[
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
		]], ָ����꼼��[3]))
		
		if tonumber(ret) == 1 then
			tmp = tmp + 1
		end
		��ʱ(200)
	end
		
    if tmp == #ָ����꼼�� then
        MentalTip("�������������Ŀ�꼼��, ������ϴ")
        return
    end
	

	��ͼѰ·("����", 140, 195)
    ��ʱ(1500)
    �Ի�NPC("������")
    ��ʱ(1000)
    NPC�����Ի�("��ϴ��꼼��")
    ��ʱ(1000)	

    local pos1 = ��ȡ������Ʒλ��("������")
    local pos2 = ��ȡ������Ʒλ��("������")
    if tonumber(pos1) ~= 0 then
        �Ҽ�ʹ����Ʒ("������")
    else
        �Ҽ�ʹ����Ʒ("������")
    end
    ��ʱ(1000)

    local count = 1
    while true do
        if GetMyMoney() < 5 * 10000 or ��ȡ������Ʒ����("���ʯ") <= 0 then
            MentalTip("���ϡ����ʯ�����Ҳ���, �˳�")
            break
        end

        MentalTip(string.format("��ʼ��%d����ϴ", count))
        LUA_Call([[setmetatable(_G, {__index = NewWuhunSkillStudy_Env});NewWuhunSkillStudy_OK_Clicked();]])
        ��ʱ(500)
        local newCount = 0
		
		
		if ָ����꼼��[1] ~= nil and ָ����꼼��[1] ~= "" then
			local ret = LUA_ȡ����ֵ(string.format([[
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
			]], ָ����꼼��[1]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			��ʱ(200)
		end
		
		if ָ����꼼��[2] ~= nil and ָ����꼼��[2] ~= "" then
			local ret = LUA_ȡ����ֵ(string.format([[
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
			]], ָ����꼼��[2]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			��ʱ(200)
		end
		
		if ָ����꼼��[3] ~= nil and ָ����꼼��[3] ~= "" then
			local ret = LUA_ȡ����ֵ(string.format([[
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
			]], ָ����꼼��[3]))
			
			if tonumber(ret) == 1 then
				newCount = newCount + 1
			end
			��ʱ(200)
		end
		

        if newCount == #ָ����꼼�� then
            LUA_Call([[setmetatable(_G, {__index = NewWuhunSkillStudy_Env});NewWuhunSkill_SaveChange_OK()]])
            MentalTip("��ϴ��꼼�����")
            break
        else
            MentalTip(string.format("�����С�%d����������������", newCount))
        end
        count = count + 1
        ��ʱ(100)
    end
end

-- -------------------------- MAIN ----------------------
main()
指定武魂技能 = {

}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetWareWuHunOldSkill(skillIndex)
    local skillName = LUA_取返回值(string.format([[
        index = %d
        Kfs_Skill_ID = {}
        for i = 1, 3 do
            local skillID = DataPool:GetKfsSkill( i - 1)
            Kfs_Skill_ID[i] = skillID
        end

        local nSumSkill = GetActionNum("skill");
        for i=1, nSumSkill do
            theAction = EnumAction(i-1, "skill");
            if theAction:GetDefineID() == Kfs_Skill_ID[index] then
                return theAction:GetName()
            end
        end
        return -1
    ]], skillIndex))
    return skillName
end

function GetPkgWuHunOldSkill(skillIndex, wuHunPos)
    local skillName = LUA_取返回值(string.format([[
        local skillIndex = %d
        local itemIdx = %d
        local theAction = EnumAction(itemIdx, "packageitem");
        local nSumSkill = PlayerPackage:GetBagKfsSkillNum(itemIdx)

        local skillID = PlayerPackage:GetBagKfsSkillUpSkill(itemIdx , skillIndex )
        local nSumSkill = GetActionNum("skill");
        for i=1, nSumSkill do
            theAction = EnumAction(i-1, "skill");
            if theAction:GetDefineID() == skillID then
                return theAction:GetName()
            end
        end
        return -1
    ]]))
    return skillName
end

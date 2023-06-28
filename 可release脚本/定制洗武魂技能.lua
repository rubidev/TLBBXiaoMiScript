指定武魂技能 = {
    "寒锋之魂",
    "强击之魂",
    "雾腐蚀毒"
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
    LUA_Call([[setmetatable(_G, {__index = Wuhun_Env});Wuhun_Equip_Clicked( 0 );]])  -- 摘下武魂

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

    local wuHunSkill = ""
    for index, skillName in pairs(指定武魂技能) do
        if skillName ~= "" then
            if wuHunSkill ~= "" then
                wuHunSkill = wuHunSkill .. '|' .. skillName
            else
                wuHunSkill = wuHunSkill .. skillName
            end
        end
    end

    local tmp = 0
    for k, v in pairs(指定武魂技能) do
        local ret = LUA_取返回值(string.format([[
            local targetWuHunSkill = "%s"

            for i = 0, 2 do
                local oldSkillDesc = DataPool:GetKFSSkillDesc(0,i)
                if string.find(oldSkillDesc, targetWuHunSkill) then
                    return 1
                end
            end
            return -1
        ]], v))
        if tonumber(ret) == 1 then
            tmp = tmp + 1
        end
    end
    if tmp == #指定武魂技能 then
        MentalTip("您的武魂已满足目标技能, 无需再洗")
        return
    end

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
        for x, y in pairs(指定武魂技能) do
            local ret = LUA_取返回值(string.format([[
                local targetWuHunSkill = "%s"

                for i = 0, 2 do
                    local newSkillDesc =  DataPool : GetKFSNewSkillDesc(0,i);
                    if string.find(newSkillDesc, targetWuHunSkill) then
                        return 1
                    end
                end
                return -1
            ]], y))

            if tonumber(ret) == 1 then
                newCount = newCount + 1
            end
        end

        if newCount == #指定武魂技能 then
            LUA_Call([[setmetatable(_G, {__index = NewWuhunSkillStudy_Env});NewWuhunSkill_SaveChange_OK()]])
            MentalTip("重洗武魂技能完成")
            break
        else
            MentalTip(string.format("本次有【%d】条技能满足条件", newCount))
        end
        count = count + 1
        延时(200)
    end
end

-- -------------------------- MAIN ----------------------
main()
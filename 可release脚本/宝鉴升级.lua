function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function CheckBaoJian()
    local isMaxLevel = LUA_取返回值([[
        local totalLevel = 0
        for i = 0, 4 do
            local BaoYuLevel = Player:GetFiveElements_ElementsLevel(i)
            totalLevel = totalLevel + BaoYuLevel
        end

        if totalLevel < 500 then
            return 0
        end
        return 1
    ]])

    if tonumber(isMaxLevel) == 1 then
        MentalTip("宝鉴等级已满")
        return 1
    end
    return -1
end

function BaoJianCohesion()
    local isMaxLevel = CheckBaoJian()
    if isMaxLevel == 1 then
        return
    end

    取出物品("金币")
    取出物品("九天玉碎")
    延时(1000)
    if 获取背包物品数量("九天玉碎") <= 0 then
        MentalTip("材料【九天玉碎】不足")
        return
    end

    跨图寻路("凤鸣镇", 113, 200)  -- TODO
    if 对话NPC("杜钏灵") == 1 then
        NPC二级对话("五行宝玉凝聚")
        延时(1000)
    end
    while true do
        if 窗口是否出现("EquipBaoJian_Cohesion") == 1 then
            LUA_Call("setmetatable(_G, {__index = EquipBaoJian_Cohesion__Env});EquipBaoJian_Cohesion_OnOK();")
            延时(200)
            local notice = 获取人物信息(37)
            if notice then
                if string.find(notice, "#{ZZZB_150811_188}", 1, true) then
                    MentalTip("金币不足")
                    延时(1000)
                    return
                elseif string.find(notice, "#{ZZZB_150811_187}", 1, true) then
                    MentalTip("材料【九天玉碎】不足")
                    延时(1000)
                    return
                end
            end
        end
    end
end

-- ------------------- MAIN --------------------------------------------------
BaoJianCohesion()
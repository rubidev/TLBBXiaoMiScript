function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetSlotLevel(slotIndex)
    local slotLevel = LUA_取返回值(string.format([[
        local slotIndex = %d
        local slotLevel = DataPool:GetSuperWeaponDIYSkillSlotLevel(slotIndex)
        if slotLevel ~= nil and slotLevel > 0 then
            return slotLevel
        end
        return -1
    ]], slotIndex))
    return tonumber(slotLevel)
end

function GetLevelUpCost(slotLevel, slotIndex)
    local costNum = LUA_取返回值(string.format([[
        local slotLevel = %d
        local slotIndex = %d
        local nCostNum, nCostMoney = DataPool:GetSuperWeaponDIYSkillLevelupData(slotLevel, slotIndex)
        if nCostNum ~= nil and nCostNum > 0 then
			return nCostNum
        end
        return -1
    ]], slotLevel, slotIndex))
    return tonumber(costNum)
end

function SlotLevelUp(slotIndex)
    local hunYuList = {
        [1] = "命魂玉",
        [2] = "地魂玉",
        [3] = "天魂玉",
    }
    local slotLevel = GetSlotLevel(slotIndex)
    if slotLevel ~= -1 and slotLevel ~= 10 then
		LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseFunction();]])
		延时(500)
		LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_SelfEquip_Clicked();]])
		延时(500)
		LUA_Call([[setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_OpenShenQi();]])
		延时(1000)
        while true do
            local newSlotLevel = GetSlotLevel(slotIndex)
            local MHYCount = 获取背包物品数量(hunYuList[slotIndex])
            local levelUpCost = GetLevelUpCost(newSlotLevel, slotIndex)
            if MHYCount < levelUpCost then
                MentalTip(string.format("背包中【%s】数量不足", hunYuList[slotIndex]))
                break
            end
            if slotLevel == 10 then
                MentalTip(string.format("第%d个槽位已达满级", slotIndex))
                break
            end
            LUA_Call(string.format([[
                setmetatable(_G, {__index = SuperWeapon9_DIYSkill_Env});
                SuperWeapon9_DIYSkill_MainButtonLevelUp(%d);
            ]], slotIndex))
            延时(200)
        end
		LUA_Call([[setmetatable(_G, {__index = SuperWeapon9_DIYSkill_Env});SuperWeapon9_DIYSkill_CloseFunction();]])
    end
end

function main()
    MentalTip("升级9星神器的3个槽位")

    取出物品("命魂玉|地魂玉|天魂玉")

    -- 升级插槽
    for j = 1, 3 do
        MentalTip(string.format("开始升级第%d个槽位", j))
        SlotLevelUp(j)
    end

    local nowSlot1Level = GetSlotLevel(1)
    if nowSlot1Level ~= 10 then
        return
    end
    执行功能("合成地魂玉")
    SlotLevelUp(2)

    local nowSlot2Level = GetSlotLevel(2)
    if nowSlot2Level ~= 10 then
        return
    end

    执行功能("合成天魂玉")
    SlotLevelUp(3)
end

-- ------------------------------ MAIN ----------------------------------
main()

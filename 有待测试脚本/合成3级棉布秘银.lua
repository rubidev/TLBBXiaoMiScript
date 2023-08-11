function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function CaiLiaoCompound(numPerTime, materialType, compoundLevel)
    -- 参数1：合成几个
    -- 参数2：合成秘银、棉布、精铁(1、2、3)
    -- 参数3：合成几级材料：1,2,3,4
    LUA_Call(string.format([[
        Clear_XSCRIPT()
            local g_CurNum_PerTime = %d
            local nIndex = %d
            local nSubIndex = %d
            Set_XSCRIPT_Function_Name( "CaiLiaoCompound_New" )
            Set_XSCRIPT_ScriptID(701602)
            Set_XSCRIPT_Parameter(0,135)			--npcid
            Set_XSCRIPT_Parameter(1,g_CurNum_PerTime)	--每次合成的数量
            Set_XSCRIPT_Parameter(2,nIndex)				--类型, 合成哪种材料，范围：1~3 (秘银， 棉布， 精铁)
            Set_XSCRIPT_Parameter(3,nSubIndex)			--子类型,合成几级材料，范围：1~4
            Set_XSCRIPT_Parameter(4,0)					--二次确认
            Set_XSCRIPT_ParamCount(5)
        Send_XSCRIPT()
    ]], numPerTime, materialType, compoundLevel))
end

function GetMyMoney()
    local myMoney = LUA_取返回值([[
        local myMoney = Player:GetData('MONEY') + Player:GetData('MONEY_JZ')
        return myMoney
    ]])
    return tonumber(myMoney)
end

function CompoundToThree(materialName, materialType)
    local level2Name = "2级" .. materialName
    local level1Name = "1级" .. materialName
    local level0Name = materialName .. "碎片"

    local level2Count = 获取背包物品数量(level2Name)
    local level1Count = 获取背包物品数量(level1Name)
    local level0Count = 获取背包物品数量(level0Name)

    -- ----------------------- 将所有1级、2级材料 合成为3级 --------------------------------
    -- 所有1级合成2级
    level1Count = 获取背包物品数量(level1Name)
    if level1Count > 5 then
        local canMergeNum = math.floor(level1Count / 5)
        if GetMyMoney() < canMergeNum * 1000 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(canMergeNum, materialType, 2)
        延时(1000)
    else
        MentalTip(string.format("%s 数量小于5个, 跳过", level1Name))
    end

    -- 所有2级合成3级
    level2Count = 获取背包物品数量(level2Name)
    if level2Count > 5 then
        local canMergeNum = math.floor(level2Count / 5)
        if GetMyMoney() < canMergeNum * 1500 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(canMergeNum, materialType, 3)
        延时(1000)
    else
        MentalTip(string.format("%s 数量小于5个, 跳过", level2Name))
    end

    -- 处理剩余2级材料
    level2Count = 获取背包物品数量(level2Name)
    if level2Count > 0 then
        local lackLevel2To3Count = 5 - level2Count
        local lackLevel1To2Count = 5 * lackLevel2To3Count
        level1Count = 获取背包物品数量(level1Name)
        local realLackLevel1To2Count = lackLevel1To2Count - level1Count
        local lacklevel0Count = realLackLevel1To2Count * 5
        level0Count = 获取背包物品数量(level0Name)
        if level0Count < lacklevel0Count then
            MentalTip(materialName .. '碎片数量不足')
            return
        end

        if GetMyMoney() < realLackLevel1To2Count * 500 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(realLackLevel1To2Count, materialType, 1) -- 合成1级材料
        延时(1000)

        if GetMyMoney() < lackLevel2To3Count * 1000 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(lackLevel2To3Count, materialType, 2) -- 合成2级材料
        延时(1000)

        if GetMyMoney() < 1500 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(1, materialType, 3) -- 合成3级材料
    end

    延时(2000)

    -- ---------------------- 每125个材料合成1个3级，不够的部分不合成 --------------------------------
    level0Count = 获取背包物品数量(level0Name)
    local canCompLevel3Count = math.floor(level0Count / 125)
    if canCompLevel3Count > 0 then
        local canCompLevel2Count = canCompLevel3Count * 5
        local canCompLevel1Count = canCompLevel2Count * 5
        if GetMyMoney() < canCompLevel1Count * 500 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(canCompLevel1Count, materialType, 1) -- 合成1级材料
        延时(1000)

        if GetMyMoney() < canCompLevel2Count * 1000 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(canCompLevel2Count, materialType, 2) -- 合成2级材料
        延时(1000)

        if GetMyMoney() < canCompLevel3Count * 1500 then
            MentalTip("金钱不足, 退出")
            return
        end
        CaiLiaoCompound(canCompLevel3Count, materialType, 3) -- 合成3级材料
    end
end

function main()
    MentalTip('只有够125个碎片才合成1次3级材料')
    取出物品('棉布碎片|秘银碎片|1级棉布|1级秘银|2级棉布|2级秘银')
    取出物品('金币')
    存物品("棉布碎片", 不存物品, 0, 1, 0)  -- 存仓不绑定的
    存物品("秘银碎片", 不存物品, 0, 1, 0)
    存物品("1级棉布", 不存物品, 0, 1, 0)
    存物品("1级秘银", 不存物品, 0, 1, 0)
    存物品("2级棉布", 不存物品, 0, 1, 0)
    存物品("2级秘银", 不存物品, 0, 1, 0)

    跨图寻路("洛阳", 280, 321)
    延时(2000)

    local materialType2Name = {
        [1] = "秘银",
        [2] = "棉布",
        [3] = "精铁",
    }
    for typeIndex = 1, #materialType2Name do
        local materName = materialType2Name[typeIndex]
        MentalTip("开始合成" .. materName)
        CompoundToThree(materName, typeIndex)
        延时(1000)
    end

    存物品("棉布碎片")
    存物品("秘银碎片")
    存物品("1级棉布")
    存物品("1级秘银")
    存物品("2级棉布")
    存物品("2级秘银")
    存物品("3级棉布")
    存物品("3级秘银")
    存物品("金币")
end

-- -------------------------------------- Main ------------------------
main()

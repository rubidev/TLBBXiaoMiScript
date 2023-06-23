function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function CheckJingTong()
    local needClean = 1
    for i = 1, #SelfEquipList do
        local isJTMaxLevel = LUA_取返回值(string.format([[
            local equipIndex = %d
            local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
            if tonumber(AttrLevel1) + tonumber(AttrLevel2) + tonumber(AttrLevel3) < 300 then
                return 0
            end
            return 1
        ]], SelfEquipList[i].equipIndex))

        if tonumber(isJTMaxLevel) == 0 then
            needClean = 0
            break
        end
    end

    if needClean == 1 then
        MentalTip("精通已满级，不选金精石")
        return 1
    else
        return -1
    end
end

function CheckJTYS()
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
        MentalTip("宝鉴已满级，不选九天玉碎")
        return 1
    end
    return -1
end

function CheckLiHuo()
    -- 清理离火
    local level = tonumber(LUA_取返回值("return Player:GetData('LEVEL')"))
    if level < 80 then
        MentalTip("您的等级小于80, 不清理精金石")
        return
    end

    local mainAttr = LUA_取返回值(string.format([[
        local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
        local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
        local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
        local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
        local tt = { iIceAttack, iFireAttack, iThunderAttack, iPoisonAttack}
        if iIceAttack == math.max(unpack(tt)) then
           maxOfT = "attack_cold"
        elseif  iFireAttack==math.max(unpack(tt)) then
            maxOfT = "attack_fire"
        elseif  iThunderAttack==math.max(unpack(tt)) then
            maxOfT = "attack_light"
        elseif  iPoisonAttack==math.max(unpack(tt)) then
            maxOfT = "attack_poison"
        end
        return maxOfT
    ]]), "s")
    local attrName = "无法识别"
    if mainAttr == "attack_cold" then
        attrName = "冰"
    elseif mainAttr == "attack_fire" then
        attrName = "火"
    elseif mainAttr == "attack_light" then
        attrName = "玄"
    elseif mainAttr == "attack_poison" then
        attrName = "毒"
    end
    MentalTip("您的主属性是：" .. attrName)
    if string.find(attrName, "无法识别") then
        return
    end

    local needClean = 1
    -- 遍历防具
    for i = 1, 6 do
        local JTAttrOK = LUA_取返回值(string.format([[
            local equipIndex = %d
            local mainAttr = "%s"
            local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
            if string.find(AttrName1, mainAttr) and string.find(AttrName2, mainAttr) and string.find(AttrName3, mainAttr) then
                return 1
            end
            return 0
        ]], SelfEquipList[i].equipIndex, 'con'))

        if tonumber(JTAttrOK) == 0 then
            needClean = 0
            break
        end
    end

    if needClean == 1 then
        -- 遍历饰品
        for i = 7, #SelfEquipList do
            local JTAttrOK = LUA_取返回值(string.format([[
                local equipIndex = %d
                local mainAttr = "%s"
                local AttrLevel1,AttrName1,AttrLevel2,AttrName2,AttrLevel3,AttrName3 = DataPool:GetJingTongAttrInfo(equipIndex)
                if string.find(AttrName1, mainAttr) and string.find(AttrName2, mainAttr) and string.find(AttrName3, mainAttr) then
                    return 1
                end
            ]], SelfEquipList[i].equipIndex, mainAttr))

            if tonumber(JTAttrOK) == 0 then
                needClean = 0
                break
            end
        end
    end

    if needClean == 1 then
        MentalTip("精通已全部洗好，不选离火")
        return 1
    else
        return -1
    end
end

-- -----------------------------------Main ---------------------------------------------------
取出物品("竹香筒粽")
取出物品("锦粽飘香礼盒")
local ZXTZCount = 获取背包物品数量("竹香筒粽")
local PXGiftCount = 获取背包物品数量("锦粽飘香礼盒")
if ZXTZCount > 0 then
    for i = 1, ZXTZCount do
        右键使用物品("竹香筒粽")
        延时(100)
    end
end

PXGiftChoice = {
    [1] = "金精石",
    [2] = "伏羲玉",
    [3] = "离火",
    [4] = "九天玉碎"
}

if PXGiftCount > 0 then
    local choiceIndex
    if CheckJTYS() == -1 then
        MentalTip("选择九天玉碎")
        choiceIndex = 4
    elseif CheckJingTong() == -1 then
        MentalTip("选择金精石")
        choiceIndex = 1
    elseif CheckLiHuo() == -1 then
        MentalTip("选择离火")
        choiceIndex = 3
    else
        MentalTip("选择伏羲玉")
        choiceIndex = 2
    end
    for j = 1, PXGiftCount do
        右键使用物品("锦粽飘香礼盒")
        延时(1000)

        LUA_Call(string.format([[
            setmetatable(_G, {__index = DuanWu_BaoZongZi_PickOne_Env});DuanWu_BaoZongZi_PickOne_Select_Clicked(%d)
        ]], choiceIndex))  -- 1,2,3,4
        延时(500)
        LUA_Call([[
            setmetatable(_G, {__index = DuanWu_BaoZongZi_PickOne_Env});DuanWu_BaoZongZi_PickOne_OK_Clicked()
        ]])

    end
end

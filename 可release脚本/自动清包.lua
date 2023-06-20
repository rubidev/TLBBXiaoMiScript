local SelfEquipList = {
    [1] = { name = "衣服", downIndex = 12, equipIndex = 2, equipName = "" }, --- 衣服
    [2] = { name = "帽子", downIndex = 1, equipIndex = 1, equipName = "" }, --- 帽子
    [3] = { name = "鞋子", downIndex = 6, equipIndex = 4, equipName = "" }, --- 鞋子
    [4] = { name = "护肩", downIndex = 2, equipIndex = 15, equipName = "" }, --- 肩膀
    [5] = { name = "手套", downIndex = 4, equipIndex = 3, equipName = "" }, --- 手套
    [6] = { name = "腰带", downIndex = 5, equipIndex = 5, equipName = "" }, --- 腰带
    [7] = { name = "项链", downIndex = 13, equipIndex = 7, equipName = "" }, --- 项链
    [8] = { name = "护腕", downIndex = 3, equipIndex = 14, equipName = "" }, --- 护腕
    [9] = { name = "戒指上", downIndex = 7, equipIndex = 6, equipName = "" }, --- 戒指（上）
    [10] = { name = "戒指下", downIndex = 8, equipIndex = 11, equipName = "" }, --- 戒指（下）
    [11] = { name = "护符上", downIndex = 9, equipIndex = 12, equipName = "" }, --- 护符（上）
    [12] = { name = "护符下", downIndex = 10, equipIndex = 13, equipName = "" }, --- 护符（下）
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function CleanJTYS()
    -- 清理九天玉碎
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
        MentalTip("宝鉴等级已满, 即将销毁九天玉碎")
        取出物品("九天玉碎")
        延时(1000)
        自动清包("九天玉碎")
    end
end

function CleanJingJinShi()
    -- 清理精金石
    local level = tonumber(LUA_取返回值("return Player:GetData('LEVEL')"))
    if level < 80 then
        MentalTip("您的等级小于80, 不清理精金石")
        return
    end

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
        MentalTip("您的所有精通已满, 即将销毁精金石")
        取出物品("精金石")
        延时(1000)
        自动清包("精金石")
    else
        MentalTip("您的所有精通尚未全部满级")
    end
end

function CleanLiHuo()
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

            if tonumber(isJTMaxLevel) == 0 then
                needClean = 0
                break
            end
        end
    end

    if needClean == 1 then
        MentalTip("您的所有精通已是全体力和主属性, 即将销毁离火")
        取出物品("离火")
        延时(1000)
        自动清包("离火")
    else
        MentalTip("您仍有部分装备需要精通淬洗")
    end
end

function JudgeHasAgname(Agname)
    -- 判断是否有该称号
    local hasChengHao = LUA_取返回值(string.format([[
        local targetAgname = "%s"
        local nAgnameNum = Player:GetAgnameNum();
        for k=0, nAgnameNum-1 do
            local szAgnameName, _ = Player:EnumAgname(k, "name", 0);
            -- local effect = Player:EnumAgname(k, "effect", 0, 0)
            if string.find(szAgnameName, targetAgname) then
                return 1
            end
        end
        return 0
    ]], Agname))
    return hasChengHao
end

function CleanAgnameMaterial()
    -- 清理称号兑换材料
    if tonumber(JudgeHasAgname("缥缈之独步天下")) == 1 then
        MentalTip("您已拥有【缥缈之独步天下】称号, 即将销毁缥缈玄符")
        取出物品("缥缈玄符")
        延时(1000)
        自动清包("缥缈玄符")
    else
        MentalTip("您尚未拥有【缥缈之独步天下】称号")
    end
    延时(500)

    if tonumber(JudgeHasAgname("傲凌天山震九州")) == 1 then
        MentalTip("您已拥有【傲凌天山震九州】称号, 即将销毁无崖丹青")
        取出物品("无崖丹青")
        延时(1000)
        自动清包("无崖丹青")
    else
        MentalTip("您尚未拥有【傲凌天山震九州】称号")
    end
    延时(500)

    if tonumber(JudgeHasAgname("鬼谷无双")) == 1 then
        MentalTip("您已拥有【鬼谷无双】称号, 即将销毁征南先锋印")
        取出物品("征南先锋印")
        延时(1000)
        自动清包("征南先锋印")
    else
        MentalTip("您尚未拥有【鬼谷无双】称号")
    end
    延时(500)
end

function GetEquipStar(equipIndex)
    -- 获取装备星星
    local tem = LUA_取返回值(string.format([[
        local equipIndex = %d
		local ID = EnumAction(equipIndex,"equip"):GetID()
		if ID > 0 then
			local nQua = DataPool:GetEquipQual(equipIndex)
			return nQua
		end
		return -1
	]], tonumber(equipIndex)))
    return tonumber(tem)
end

function CleanAnQiMaterial()
    -- 清理龙泉铁英、绑定五毒珠
    local level = tonumber(LUA_取返回值("return Player:GetData('LEVEL')"))
    if level < 80 then
        MentalTip("您的等级小于80, 不清理龙泉铁英、绑定五毒珠")
        return
    end

    local tem = GetEquipStar(17)
    if tonumber(tem) ~= -1 then
        if tonumber(tem) == 8 then
            MentalTip("您的暗器已达8星, 即将销毁龙泉铁英")
            取出物品("龙泉铁英")
            延时(1000)
            自动清包("龙泉铁英")
        end
    end
    延时(1000)

    -- 清理五毒珠
    local anQiCuiduHP = LUA_取返回值([[
        return LifeAbility:GetWearedDarkLY_CuiduHP(17) --实际暗器血上限
    ]])
    local anQiCuiduPro = LUA_取返回值([[
        return LifeAbility:GetWearedDarkLY_CuiduPro(17) --实际暗器属性攻
    ]])
    local anQiCuiduHit = LUA_取返回值([[
        return LifeAbility:GetWearedDarkLY_CuiduHit(17) --实际暗器命中
    ]])

    if tonumber(anQiCuiduHP) >= 10688 then
        MentalTip("您的暗器血上限已达最大值, 销毁绑定五毒珠·元阳")
        取出物品("五毒珠·元阳")
        存物品("五毒珠·元阳", 不存物品, 0, 1, 0)
        延时(500)
        自动清包("五毒珠·元阳")
    end
    if tonumber(anQiCuiduPro) >= 176 then
        MentalTip("您的暗器血上限已达最大值, 销毁绑定五毒珠·魂武")
        取出物品("五毒珠·魂武")
        存物品("五毒珠·魂武", 不存物品, 0, 1, 0)
        延时(500)
        自动清包("五毒珠·魂武")
    end
    if tonumber(anQiCuiduHit) >= 2175 then
        MentalTip("您的暗器血上限已达最大值, 销毁绑定五毒珠·星眸")
        取出物品("五毒珠·星眸")
        存物品("五毒珠·星眸", 不存物品, 0, 1, 0)
        延时(500)
        自动清包("五毒珠·星眸")
    end
end

function CleanXBS()
    local weaponStarInfo = GetEquipStar(0)
    local weaponStar = tonumber(string.sub(tostring(weaponStarInfo), 1, 1))
    if weaponStar == 8 or weaponStar == 9 then
        MentalTip("您身上的神器已达8星或9星, 销毁玄兵石")
        取出物品("玄兵石")
        取出物品("玄兵石碎片")
        延时(500)
        自动清包("玄兵石")
        自动清包("玄兵石碎片")
    else
        MentalTip("您身上的尚未8星")
    end
end

function GetLongWebExAttLevel(longWebExAttIndex)
    local tem = LUA_取返回值(string.format([[
        local longWenAttrLevel = 0
        local ID =EnumAction(19,"equip"):GetID()
        if ID > 0 then
            local nExAttLevel = LifeAbility:GetWearedLongWen_AttLevel(19, %d-1)
            return nExAttLevel
        end
        return -1
	]], tonumber(longWebExAttIndex)))
    return tonumber(tem)
end

function DestroyMaterialBindItem(itemNameList)
    LUA_Call(string.format([[
        local targetItemName = "%s"
        local currNum = DataPool:GetMatBag_Num();
        for i=1, currNum do
            local theAction,bLocked = PlayerPackage:EnumItem("material", i-1);
            if theAction:GetID() ~= 0 then
                local itemName = theAction:GetName()   -- 物品名字
                local szItemNum = theAction:GetNum();   -- 物品数量
                local itemStatus = GetItemBindStatus(i);   -- 物品绑定状态，判定有问题
                if string.find(targetItemName, itemName) then
                    if itemStatus == 1 then
                        Clear_XSCRIPT()
                            Set_XSCRIPT_ScriptID( 124 )
                            Set_XSCRIPT_Function_Name( "OnDestroy" )
                            Set_XSCRIPT_Parameter( 0, i )
                            Set_XSCRIPT_ParamCount( 1 )
                        Send_XSCRIPT()
                    end
                end
            end
        end
    ]], itemNameList))
end

function CleanZLS()
    -- 销毁绑定缀龙石
    if GetLongWebExAttLevel(1) + GetLongWebExAttLevel(2) + GetLongWebExAttLevel(3) >= 30 then
        MentalTip("您身上的龙纹扩展属性全满级, 销毁绑定缀龙石")
        取出物品("缀龙石·元")
        存物品("缀龙石·元", 不存物品, 0, 1, 0)
        取出物品("缀龙石·伤")
        存物品("缀龙石·伤", 不存物品, 0, 1, 0)
        取出物品("缀龙石·暴")
        存物品("缀龙石·暴", 不存物品, 0, 1, 0)
        延时(500)
        自动清包("缀龙石·元")
        自动清包("缀龙石·伤")
        自动清包("缀龙石·暴")
    else
        MentalTip("您身上的龙纹扩展属性尚未全满级")
    end
end


-- 执行逻辑 -------------------------------------------------------------------------
CleanLiHuo()  -- 离火
延时(1000)
CleanJingJinShi() -- 精金石
延时(1000)
CleanJTYS()  -- 九天玉碎
延时(1000)
CleanAgnameMaterial()  -- 称号兑换材料
延时(1000)
CleanAnQiMaterial()  -- 暗器升星、扩展属性升级材料
延时(1000)
CleanXBS()  -- 玄兵石
延时(1000)
CleanZLS()  -- 缀龙石


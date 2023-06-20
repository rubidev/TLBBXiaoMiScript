function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetWareLingPaiInfo(baoZhuIndex)
    -- 获取已装备的令牌信息
    local lingPaiInfo = LUA_取返回值(string.format([[
			local index = %d
			local nType,BaoZhu1,BaoZhu2,BaoZhu3,BaoZhu4,nQual = DataPool:GetLingPaiInfo()
			--local IconName,ItemName = DataPool:GetLingPaiBaoZhuIconName(1)
			if nType> 0 then
				if index == 1 then
					return BaoZhu1
				end
				if index == 2 then
					return BaoZhu2
				end
				if index == 3 then
					return BaoZhu3
				end
				if index == 4 then
					return BaoZhu4
				end
				if index == 5 then
					return nQual
				end
				if  index ==  0 then
					return nType
				end
			end
			return -1
	]], baoZhuIndex))
    return tonumber(lingPaiInfo)
end

function GetPkgLingPaiBaoZhu(lingPaiPos, baoZhuIndex)
    -- 背包中令牌宝珠等级
    local baoZhuLevel = LUA_取返回值(string.format([[
        local m_EquipBagIndex = %d
        local nIndex = %d
        local uLevel = PlayerPackage:Lua_GetBagItemRl_RsLevel(m_EquipBagIndex , nIndex - 1)
        return uLevel
    ]], lingPaiPos, baoZhuIndex))
    return tonumber(baoZhuLevel)
end

function checkWareLingPaiBaoZhu()
    local allBaoZhuLevel = 0
    for i = 1, 4 do
        allBaoZhuLevel = allBaoZhuLevel + GetWareLingPaiInfo(i)
    end
    if allBaoZhuLevel >= 50 * 4 then
        MentalTip("您身上令牌的宝珠已全部满级")
        return 1
    else
        MentalTip("您身上的令牌宝珠未满级,仍需使用翡翠心精")
        return -1
    end
end

function checkPkgLingPaiBaoZhu()
    local lingPaiList = { "江湖令", "金兰令", "聚义令", "歃血令", "霸王令" }
    for i = 1, #lingPaiList do
        取出物品(string.format("%s", lingPaiList[i]))
        延时(100)
    end
    延时(1000)

    local unfinishedLingPaiCount = 0
    for j = 1, 4 do
        unfinishedLingPaiCount = unfinishedLingPaiCount + 获取背包物品数量(string.format("%s", lingPaiList[j]))
    end
    if unfinishedLingPaiCount > 0 then
        MentalTip("背包中还有低阶令牌,仍需使用翡翠心精")
        return -1
    end

    if 获取背包物品数量("霸王令") > 0 then
        local LPIndex = 获取背包物品位置("霸王令") - 1
        local allBaoZhuLevel = 0
        for k = 1, 4 do
            allBaoZhuLevel = allBaoZhuLevel + GetPkgLingPaiBaoZhu(LPIndex, k)
        end
        if allBaoZhuLevel >= 50 * 4 then
            MentalTip("您背包中令牌的宝珠已全部满级")
            return 1
        else
            MentalTip("背包中霸王令宝珠未满级,仍需使用翡翠心精")
            return -1
        end
    else
        MentalTip("背包中没有第二个霸王令")
        return 1
    end
end

--  Main ------------------------------------------------------------------------------------------
MentalTip("检测令牌,并清理翡翠心精")
local wareLP = checkWareLingPaiBaoZhu()
local pkgLP = checkPkgLingPaiBaoZhu()
if wareLP == 1 and pkgLP == 1 then
    取出物品("翡翠心精")
    延时(1000)
    自动清包("翡翠心精")
end

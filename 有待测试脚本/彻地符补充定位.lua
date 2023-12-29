-- 优先使用绑定元宝补充

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function StringSplit(str, reps)
    -- 字符串切割
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function GetDJTSLeftCount(curPage, curIndex, DJTSIndex)
    local leftCount = LUA_RETURN(string.format([[
        g_CurSelectPage = %d
        g_CurIndex = %d
        g_Client_ItemIndex = %d
        local nIdx = (g_CurSelectPage - 1) * 10 + g_CurIndex - 1
        local sceneid, strText, count, posx, posy, init = PlayerPackage:GetDunJiaShuPosInfo(g_Client_ItemIndex, nIdx)
        return count
    ]], curPage, curIndex, DJTSIndex))
    return tonumber(leftCount)
end

function AddCountByYBBind(DJTSIndex)
    LUA_Call(string.format([[
        Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("YuanbaoBind_AddFuZhou");
			Set_XSCRIPT_ScriptID(330059);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
    ]], DJTSIndex))
end

function AddCountByYB(DJTSIndex)
    LUA_Call(string.format([[
        Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("Yuanbao_AddFuZhou");
			Set_XSCRIPT_ScriptID(330059);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
    ]], DJTSIndex))
end

function AddCount(DJTSIndex)
    LUA_Call(string.format([[
        Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("AddFuZhou");
			Set_XSCRIPT_ScriptID(330059);
			Set_XSCRIPT_Parameter(0, %d)
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
    ]], DJTSIndex))
end

function AddDJTSCount()
    local DJTSPos = 获取背包物品位置("彻地符箓")
    local DJTSIndex = DJTSPos - 1

    local leftCount = GetDJTSLeftCount(1, 1, DJTSIndex)

    local needAddCount = 50 - leftCount

    local needBuyCount = math.floor(needAddCount / 10)
    if needBuyCount == 0 then
        MentalTip('剩余次数大于40, 无需补充')
        return
    end

    MentalTip(string.format([[需要补充【%d】次, 才能使次数大于40]], addNum))

    local curYBBind = tonumber(获取人物信息(62))
    local YBBindCanBuyCount = math.floor(curYBBind / 110)
    local minCount = needBuyCount
    if YBBindCanBuyCount < needBuyCount then
        minCount = YBBindCanBuyCount
        for i = 1, minCount do
            MentalTip(string.format([[第【%d】次使用绑定元宝购买]]))
            AddCountByYBBind(DJTSIndex)
            延时(1000)
        end
    end

    local needHLBugCount = needBuyCount - YBBindCanBuyCount
    if needHLBugCount > 0 then
        local curHL = tonumber(获取人物信息(55))
        local HLCanBuyCount = math.floor(curHL / 110)
        local minCount = needHLBugCount
        if HLCanBuyCount < needHLBugCount then
            minCount = HLCanBuyCount
            for i = 1, minCount do
                MentalTip(string.format([[第【%d】次购买]]))
                AddCount(DJTSIndex)
                延时(1000)
            end
        end
    end
end

-- main ------------------------------------------------
取出物品("彻地符箓")
延时(1000)
if 获取背包物品数量("彻地符箓") > 0 then
    AddDJTSCount()
end
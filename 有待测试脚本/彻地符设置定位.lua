定位列表 = {
    { page = 2, index = 1, scene = '太湖', posX = 271, posY = 200 },
    { page = 2, index = 2, scene = '太湖', posX = 234, posY = 275 },
    { page = 2, index = 3, scene = '嵩山', posX = 65, posY = 45 },
    { page = 2, index = 4, scene = '圣火宫', posX = 78, posY = 75 },
    { page = 2, index = 5, scene = '汗血岭', posX = 82, posY = 79 },
    { page = 2, index = 6, scene = '昆仑福地', posX = 105, posY = 55 },
    { page = 2, index = 7, scene = '清源', posX = 227, posY = 75 },
    { page = 2, index = 8, scene = '雁南', posX = 272, posY = 270 },
    { page = 2, index = 9, scene = '秦皇地宫四层', posX = 160, posY = 188 },
    { page = 2, index = 10, scene = '燕王古墓九层', posX = 55, posY = 77 },
    { page = 3, index = 1, scene = '漠南青原', posX = 45, posY = 219 },
    { page = 3, index = 2, scene = '漠南青原', posX = 178, posY = 200 },
    { page = 3, index = 3, scene = '漠南青原', posX = 217, posY = 32 },
    { page = 3, index = 4, scene = '漠南青原', posX = 210, posY = 129 },
    { page = 3, index = 5, scene = '天岐南淮', posX = 89, posY = 157 },
    { page = 3, index = 6, scene = '天岐南淮', posX = 52, posY = 70 },
    { page = 3, index = 7, scene = '苍梧秘境', posX = 135, posY = 173 },
    { page = 3, index = 8, scene = '忘川花海', posX = 83, posY = 107 },
    { page = 3, index = 9, scene = '忘川花海', posX = 24, posY = 225 },
    { page = 3, index = 10, scene = '忘川花海', posX = 226, posY = 228 }
}
-- page: 彻底符第几页
-- index: 彻底符当前页第一个位置, 位置如下：
-- 1    2
-- 3    4
-- 5    6
-- 7    8
-- 9    10
-- scene: 场景
-- posX: X坐标
-- posY: Y坐标


LUA_RETURN = lua_取返回值
sleep = 延时

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

function MoveToPos(NPCCity, x, y)
    while true do
        跨图寻路(NPCCity, x, y)
        sleep(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == x and tonumber(myY) == y then
            break
        end
    end
end

function GetDJTSPosInfo(curPage, curIndex, DJTSIndex)
    local posInfo = LUA_RETURN(string.format([[
        g_CurSelectPage = %d
        g_CurIndex = %d
        g_Client_ItemIndex = %d
        local nIdx = (g_CurSelectPage - 1) * 10 + g_CurIndex - 1
        local sceneid, strText, count, posx, posy, init = PlayerPackage:GetDunJiaShuPosInfo(g_Client_ItemIndex, nIdx)
        if sceneid >=1 then
            posInfo = strText .. "|" .. posx .. "|" .. "posy"
        else
            posInfo = "||"
        end
        return posInfo
    ]], curPage, curIndex, DJTSIndex))
    return posInfo
end

function DJTSSetPosition(curPage, curIndex, DJTSItemKIndex)
    local index = (curPage - 1) * 10 + curIndex - 1
    LUA_Call(string.format([[
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("SetPosition");
            Set_XSCRIPT_ScriptID(330059);
            Set_XSCRIPT_Parameter(0, %d)
            Set_XSCRIPT_Parameter(1, %d)
            Set_XSCRIPT_ParamCount(2)
        Send_XSCRIPT();
    ]], DJTSItemKIndex, index))
end

function SetPosition()
    local DJTSPos = 获取背包物品位置("彻地符箓")
    local DJTSIndex = DJTSPos - 1

    for _, posInfo in pairs(定位列表) do
        local curPage = tonumber(posInfo.page)
        local curIndex = tonumber(posInfo.index)
        local scene = posInfo.scene
        local posX = tonumber(posInfo.posX)
        local posY = tonumber(posInfo.posY)

        local posInfoStr = GetDJTSPosInfo(curPage, curIndex, DJTSIndex)
        local posInfoList = StringSplit(posInfoStr, '|')
        local needSetPos = false
        if posInfoList[1] == nil then
            needSetPos = true
        elseif (posInfoList[1] ~= scene) or( posInfoList[2] ~= tostring(posX)) or (posInfoList[3] ~= tostring(posY)) then
            needSetPos = true
        end

        if needSetPos then
            MentalTip(string.format([[即将前往 %s(%d,%d) 设置定位]], scene, posX, posY))
            MoveToPos(scene, posX, posY)
            sleep(1000)
            MentalTip(string.format([[即将把彻底符的第【%s】页的第【%s】个定位设置为 %s(%d,%d)]], curPage, curIndex, scene, posX, posY))
            DJTSSetPosition(curPage, curIndex, DJTSIndex)
        else
            MentalTip(string.format([[彻底符的第【%d】页, 第【%d】个位置已经为 %s(%d,%d), 跳过]], curPage, curIndex, scene, posX, posY))
        end

        sleep(200)
    end
end

-- main -----------------------------------------------
取出物品("彻地符箓")
延时(1000)
if 获取背包物品数量("彻地符箓") > 0 then
    SetPosition()
end

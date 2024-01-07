头饰列表 = {}
背饰列表 = {}
幻饰武器列表 = {}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
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
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == x and tonumber(myY) == y then
            break
        end
    end
end

function ActiveHeadDecoration()
    local headDecorationStr = ''
    for _, headDecoration in pairs(头饰列表) do
        if headDecorationStr == '' then
            headDecorationStr = headDecoration
        else
            headDecorationStr = headDecorationStr .. '|' .. headDecoration
        end
    end

    if headDecorationStr ~= '' then
        取出物品(headDecorationStr)
        取出物品('金币')

        local needActiveDecorationList = {}
        for _, headDecoration in pairs(头饰列表) do
            local decorationCount = 获取背包物品数量(headDecoration)
            if decorationCount > 0 then
                table.insert(needActiveDecorationList, headDecoration)
            end
        end

        MoveToPos('洛阳', 1, 2)  -- TODO
        对话NPC('')   -- TODO
        延时(1000)
        NPC二级对话('激活头饰', 1)    -- TODO
        延时(1000)

        for _, decoration in pairs(needActiveDecorationList) do
            右键使用物品(decoration)
            延时(1500)
            LUA_Call([[]])  -- TODO
        end
    end
end

function ActiveBackDecoration()
    local backDecorationStr = ''
    for _, backDecoration in pairs(背饰列表) do
        if backDecorationStr == '' then
            backDecorationStr = backDecoration
        else
            backDecorationStr = backDecorationStr .. '|' .. backDecoration
        end
    end

    if backDecorationStr ~= '' then
        取出物品(backDecorationStr)
        取出物品('金币')

        local needActiveDecorationList = {}
        for _, backDecoration in pairs(背饰列表) do
            local decorationCount = 获取背包物品数量(backDecoration)
            if decorationCount > 0 then
                table.insert(needActiveDecorationList, backDecoration)
            end
        end

        MoveToPos('洛阳', 1, 2)  -- TODO
        对话NPC('')   -- TODO
        延时(1000)
        NPC二级对话('激活背饰', 1)    -- TODO
        延时(1000)

        for _, decoration in pairs(needActiveDecorationList) do
            右键使用物品(decoration)
            延时(1500)
            LUA_Call([[]])  -- TODO
        end
    end
end

function ActiveBackDecoration()
    local decorationWeaponStr = ''
    for _, decorationWeapon in pairs(幻饰武器列表) do
        if decorationWeaponStr == '' then
            decorationWeaponStr = decorationWeapon
        else
            decorationWeaponStr = decorationWeaponStr .. '|' .. decorationWeapon
        end
    end

    if decorationWeaponStr ~= '' then
        取出物品(decorationWeaponStr)
        取出物品('金币')

        local needActiveDecorationList = {}
        for _, decorationWeapon in pairs(幻饰武器列表) do
            local decorationCount = 获取背包物品数量(decorationWeapon)
            if decorationCount > 0 then
                table.insert(needActiveDecorationList, decorationWeapon)
            end
        end

        MoveToPos('洛阳', 1, 2)  -- TODO
        对话NPC('')   -- TODO
        延时(1000)
        NPC二级对话('锻造幻饰武器', 1)    -- TODO
        延时(1000)

        for _, decoration in pairs(needActiveDecorationList) do
            右键使用物品(decoration)
            延时(1500)
            LUA_Call([[]])  -- TODO
            延时(1500)
            右键使用物品(decoration .. "（1级）")  -- TODO
        end
    end
end

function main()
    ActiveHeadDecoration()
    ActiveBackDecoration()
    ActiveBackDecoration()
end

-- main ------------------------------------
main()


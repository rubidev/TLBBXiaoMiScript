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

function main()
    MentalTip("前往【凤鸣镇】领取【霸者天下补偿礼包】")
    MoveToPos("凤鸣镇", 132, 59)
    延时(1000)
    对话NPC("万翎疆")
    延时(500)
    NPC二级对话("领取霸者天下补偿礼包")
    延时(2500)
    右键使用物品("霸者天下补偿礼包")
end

-- main  --------------------------
main()

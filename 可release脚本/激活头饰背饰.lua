背饰列表 = {}

头饰列表 = {
    '福禄宝冠'
}



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

function MoveToNPC(NPCCity, x, y)
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


-- main --------------------------------------
MoveToNPC('洛阳', 336, 270)

for _, item in pairs(背饰列表) do
    对话NPC("贝师师")
    延时(1000)
    NPC二级对话("激活背饰")
    延时(1000)
    右键使用物品(item)
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = DressPaint_TB_Env});DressPaint_TB_OK_Clicked();]])
end

for _, item in pairs(头饰列表) do
    对话NPC("贝师师")
    延时(1000)
    NPC二级对话("激活头饰")
    延时(1000)
    右键使用物品(item)
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = DressPaint_TB_Env});DressPaint_TB_OK_Clicked();]])
end
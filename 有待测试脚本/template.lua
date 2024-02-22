

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function WritePlayerConfiguration(section, keyName, value)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    if section ~= nil and keyName ~= nil and value ~= nil then
        MentalTip("写角色配置项|" .. section .. "|" .. keyName .. "|" .. value);
        延时(200)
        写配置项(configPath, section, keyName, value);
        延时(200)
    end
end

function ReadPlayerConfiguration(section, keyName)
    local playerName = 获取人物信息(12)
    local configPath = string.format("C:\\天龙小蜜\\角色配置\\%s.ini", playerName)
    local tem = 读配置项(configPath, section, keyName)
    if tem then
        MentalTip(section .. "|" .. keyName .. "==" .. tem);
        延时(500)
    else
        return 0
    end
    return tem
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

function genRandomNum(minNum, maxNum)
    local tmp = math.random(minNum, maxNum)
    return tmp
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

end

-- main ---------------------------------------------
main()


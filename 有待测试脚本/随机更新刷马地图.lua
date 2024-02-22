local ShuaMaMapCombination = {
    [1] = { map1 = "玉溪", map2 = "石林", waitMap = "玉溪", waitX = 51, waitY = 53 },
    [2] = { map1 = "南诏", map2 = "苗疆", waitMap = "苗疆", waitX =, waitY = },
    [3] = { map1 = "长白山", map2 = "黄龙府", waitMap = "黄龙府", waitX =, waitY = },
    [4] = { map1 = "洱海", map2 = "苍山", waitMap = "苍山", waitX =, waitY = },
    [5] = { map1 = "南海", map2 = "琼州", waitMap = "琼州", waitX =, waitY = },
    [6] = { map1 = "雁南", map2 = "雁北", waitMap = "雁北", waitX =, waitY = },
    [7] = { map1 = "草原", map2 = "辽西", waitMap = "辽西", waitX =, waitY = },
    [8] = { map1 = "武夷", map2 = "梅岭", waitMap = "梅岭", waitX =, waitY = },
}

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
    local totalMap = { "嵩山", "太湖", "镜湖", "西湖", "龙泉", "武夷",
                       "梅岭", "南海", "琼州", "敦煌", "雁南", "雁北",
                       "草原", "辽西", "长白山", "黄龙府", "洱海",
                       "苍山", "石林", "玉溪", "南诏", "苗疆" }

    local selectNum = genRandomNum(1, #ShuaMaMapCombination)

    local map1 = ShuaMaMapCombination[selectNum].map1
    local map2 = ShuaMaMapCombination[selectNum].map2
    local waitMap = ShuaMaMapCombination[selectNum].waitMap
    local waitX = ShuaMaMapCombination[selectNum].waitX
    local waitY = ShuaMaMapCombination[selectNum].waitY

    MentalTip(string.format([[更新刷马地图为【%s】【%s】, 等待地点为【%s】(%s, %s)]], map1, map2, waitMap, waitX, waitY))
    MentalTip(string.format([[更新刷马地图为【%s】【%s】, 等待地点为【%s】(%s, %s)]], map1, map2, waitMap, waitX, waitY))
    MentalTip(string.format([[更新刷马地图为【%s】【%s】, 等待地点为【%s】(%s, %s)]], map1, map2, waitMap, waitX, waitY))

    for _, mapName in pairs(totalMap) do
        local choice = ReadPlayerConfiguration("刷马", mapName)
        if tonumber(choice) ~= 0 then
            WritePlayerConfiguration("刷马", mapName, 0)
        end
    end

    WritePlayerConfiguration("刷马", map1, 1)
    WritePlayerConfiguration("刷马", map2, 1)
    WritePlayerConfiguration("刷马", "刷马等待地图", waitMap)
    WritePlayerConfiguration("刷马", "刷马等待X", waitX)
    WritePlayerConfiguration("刷马", "刷马等待Y", waitY)


end

-- main ---------------------------------------------
main()


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

function UseCFXJ()
    local itemCount = 获取背包物品数量("春风信笺")
    延时(500)
    for index = 1, itemCount do
        右键使用物品("春风信笺")
        延时(800)
        LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
        延时(800)

    end
end

function SendCFXJ()
    跨图寻路("苏州", 178, 258)

    延时(3000)

    local exist_player = {}

    local myX = 获取人物信息(7)
    local myY = 获取人物信息(8)

    local nearbyPlayer = 获取周围玩家(白名单, myX, myY, 15)
    MentalTip(string.format([[周围玩家: %s]], nearbyPlayer))
    local nearbyPlayerList = StringSplit(nearbyPlayer, '|')

    for i = 1, #nearbyPlayerList do
        local playerName = nearbyPlayerList[i]

        local exist = 0
        for j = 1, #exist_player do
            if exist_player[j] == playerName then
                exist = 1
            end
        end

        if exist == 0 then
            table.insert(exist_player, playerName)

            local name, ID, x, y, HP, tDistance, tType, tOwner, tJudge, tTitle = 遍历周围物品(5, playerName, 5)
            选中对象(ID)

            MentalTip(string.format([[开始尝试对【%s】使用 春风信笺]], playerName))

            local itemCount = 获取背包物品数量("春风信笺")
            if itemCount > 0 then
                UseCFXJ()
            else
                MentalTip("没有 春风信笺, 退出")
                return
            end

        end


    end
end

function main()
    MentalTip("本队前往 苏州（178, 258）使用春风信笺")
    跨图寻路("苏州", 178, 258)
    while true do
        local itemCount = 获取背包物品数量("春风信笺")
            if itemCount <= 0 then
                MentalTip("没有【春风信笺】, 退出")
                return
            end
        SendCFXJ()
        延时(5000)
    end
end

-- main ------------------------------------------------------
main()

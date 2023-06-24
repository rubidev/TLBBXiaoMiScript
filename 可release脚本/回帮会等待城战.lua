function GetCityBattleTime()
    local year = tonumber(os.date("%Y", os.time()))
    local month = tonumber(os.date("%m", os.time()))
    local day = tonumber(os.date("%d", os.time()))
    local todayTimestamp = tonumber(os.time({ year = year, month = month, day = day, hour = 0, min = 0, sec = 0 }))
    local battleStartTimestamp = todayTimestamp + 20 * 60 * 60 + 15 * 60 + 2
    return battleStartTimestamp
end

function 准备城战()
    -- 必须打开帮会界面，切换过才能获取帮会信息
    LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Hygl_Env});NewBangHui_Hygl_Bhxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Bhxx_Env});NewBangHui_Bhxx_Tmxx_Clicked();]])
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_Tmxx_Env});NewBangHui_Tmxx_Closed();]])

    坐骑_下坐骑()

    local myGuildCityName = LUA_取返回值([[
       local guildID, clanID = DataPool:GetGuildClanID()
       local myCityName = Guild:GetMyGuildDetailInfo("CityName")
       PushDebugMessage("myCityName: " .. myCityName)
       return myCityName
   ]])

    if tonumber(myGuildCityName) == -1 then
        MentalTip("脚本检索帮会失败, 使用绑定元宝购买定位")
        return
    end

    local inBangHui = 0
    local curCityName = 获取人物信息(16)
    if curCityName == "苏州" then
        坐骑_上坐骑()
        while true do
            跨图寻路("苏州", 322, 264)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 322 and tonumber(myY) == 264 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯粹")
    elseif curCityName == "大理" then
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯礼")
    elseif curCityName == "洛阳" then
        坐骑_上坐骑()
        while true do
            跨图寻路("洛阳", 237, 236)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 237 and tonumber(myY) == 236 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯仁")
    elseif curCityName == "楼兰" then
        坐骑_上坐骑()
        while true do
            跨图寻路("楼兰", 190, 130)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 190 and tonumber(myY) == 130 then
                break
            end
        end
        延时(1000)
        对话NPC("范纯祐")
    elseif curCityName == myGuildCityName then
        inBangHui = 1
        坐骑_上坐骑()
    else
        执行功能("大理回城")
        延时(3000)
        坐骑_上坐骑()
        while true do
            跨图寻路("大理", 179, 121)
            延时(500)
            local myX = 获取人物信息(7)
            local myY = 获取人物信息(8)
            if tonumber(myX) == 179 and tonumber(myY) == 121 then
                break
            end
        end
        延时(3000)
        对话NPC("范纯礼")
    end

    if inBangHui == 0 then
        延时(500)
        NPC二级对话("进入本帮城市")
        等待过图完毕()
        延时(3000)
    end

    while true do
        local curMap = 获取人物信息(16)
        if curMap == myGuildCityName then
            延时(2000)
            break
        end
        延时(1000)
    end

    while true do
        跨图寻路(myGuildCityName, 107, 55)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == 107 and tonumber(myY) == 55 then
            break
        end

    end
    延时(2000)

    对话NPC("万儒诚")
    延时(1000)
    NPC二级对话("参与霸者天下")
    延时(500)

    local cityBattleStartTime = GetCityBattleTime()
    while true do
        if os.time() < cityBattleStartTime then
            屏幕提示(string.format("距离城站开始还有%d秒", cityBattleStartTime - tonumber(os.time())))
            延时(5000)
        else
            NPC二级对话("前往备战凤鸣镇-坤")
            延时(1000)
            LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
            break
        end
    end


end


-- 执行脚本
执行功能("同步游戏时间")
准备城战()

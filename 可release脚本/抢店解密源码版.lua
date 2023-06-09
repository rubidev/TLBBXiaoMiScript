SWE = 1
-------------------------------------------------------
function MOU(text, ...)
    if SWE == 1 then
        local strCode = string.format(text, ...)
        LUA_Call(string.format([[
            setmetatable(_G, {__index = DebugListBox_Env})
                str= "#e330033#gFFB90F".."".."#e330033#gFFB90F".."%-88s"
                DebugListBox_ListBox:AddInfo(str)
                --橙色 #e0000ff#u#g0ceff3
                --蓝色 #e0000ff#g28f1ff
                --#Y
        ]], strCode))
    end
end

function 关闭窗口(strWindowName)
    if 窗口是否出现(strWindowName) == 1 then
        LUA_Call(string.format([[
            setmetatable(_G, {__index = %s_Env}) this:Hide()
	    ]], strWindowName))
    end
end

function 创建店铺(szName, iTem)
    for i = 1, 5 do
        if 对话NPC("乔复盛") == 1 then
            延时(200)
            if 窗口是否出现("Quest") == 1 then
                for kkk = 1, 5 do
                    LUA_Call(string.format([[
                        local nType = PlayerShop:GetCanOpenShopType();
                        if nType==1 or nType==3 then
                            setmetatable(_G, {__index = PS_CreateShop_Env})
                            PlayerShop:CreateShop("%s", %d)
                        else
                                PushDebugMessage("")
                        end
                    ]], szName, iTem))
                    延时(200)
                    break
                end
                关闭窗口("Quest")
                break
            end
        end
    end
end

function TRE()
    店铺名称 = "被他人否定"
    LUA_Call(string.format([[
        setmetatable(_G, {__index = PS_CreateShop_Env})
        PlayerShop:CreateShop("%s", 1)
    ]], 店铺名称))
end

跨图寻路("洛阳", 329, 299)
执行功能("同步游戏时间")
while true do
    local hour = tonumber(os.date("%H", os.time()))
    local minute = tonumber(os.date("%M", os.time()))
    local second = tonumber(os.date("%S", os.time()))
    if minute ~= nil or second ~= nil then
        MOU(string.format("北京时间[%d]分[%d]秒~~~~~~等待开抢时间59:59", minute, second))
        if minute == 59 and second == 59 then
            for i = 1, 6 do
                TRE()
                延时(100)
            end
        end
    end
    延时(100)
end




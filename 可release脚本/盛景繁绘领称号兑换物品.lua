-- 数值大的写前面
-- TODO 修改
兑换物品 = {25, 3}

-- 第一页各位置序号
-- 1  2  3
-- 4  5  6
-- 7  8  9
-- 10  11  12

-- 第二页各位置序号
-- 21   22  23
-- 24   25


function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end


function main()
    LUA_Call([[setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(48)]]) -- 打开界面
    延时(1500)
    LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_OnFenYeClick(2);]])  -- 切到墨宝换金
    延时(1500)
    LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_GetTit();]]) -- 领取称号
    延时(500)

    for _, itemIndex in pairs(兑换物品) do
        local index = itemIndex
        if itemIndex > 20 then
            LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_DownPageClick();]])
            延时(1000)
            index = itemIndex - 20
        else
            LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_UpPageClick();]])
            延时(1000)
        end
        LUA_Call(string.format([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_ExchangePrize(%s);]], index))
        延时(1000)
        LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_MBuy_Env});ShengJingFanHui_MBuy_CalMax()]])
        延时(1000)
        LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_MBuy_Env});ShengJingFanHui_MBuy_OK_Clicked()]])
        延时(500)
    end

    右键使用物品("笔墨横姿显真意")
    延时(500)

    LUA_Call([[setmetatable(_G, {__index = ShengJingFanHui_Env});ShengJingFanHui_OnClose();]])  -- 关闭盛景繁绘

end

-- main -----------------------------------------------
main()

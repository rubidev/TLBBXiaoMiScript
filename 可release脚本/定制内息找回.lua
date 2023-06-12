买回溯令角色 = {
    "﹎尛妹．ゝ",
    "′﹎摆烂ゝ"
}

function BuyHSL()
    local 人物名称 = 获取人物信息(12)
    local matched = 0
    for k, v in pairs(买回溯令角色) do
        if string.find(人物名称, v) then
            matched = 1
            break
        end
    end

    if matched ~= 1 then
		屏幕提示("当前角色没有加入购买回溯令名单")
        return
    end

    if tonumber(获取背包物品数量("内息回溯令")) > 0 then
	    屏幕提示("背包中已有内息回溯令")
        return
    end

    -- 打开精彩活动界面
    LUA_Call([[setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(1);]])
    延时(500)

    -- 打开华玉集
    LUA_Call([[setmetatable(_G, {__index = TodayCampaignListNew_Env});TodayCampaignListNew_WeeklyShop_Clicked();]])
    延时(500)

    -- 点击下一页
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop_Env});ActivitySchedule_Shop_PageDown();]])
    延时(500)
    -- 点击内息回溯令
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop_Env});ActivitySchedule_Shop_Clicked(1)]])
    延时(500)

    -- 点击确定
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy_Env});ActivitySchedule_MBuy_OK_Clicked();]])
    延时(500)

    -- 关闭界面
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop_Env});ActivitySchedule_Shop_OnHiden();]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = TodayCampaignListNew_Env});TodayCampaignListNew_OnClosed();]])
end

BuyHSL()

延时(2000)

执行功能("交子内息找回")
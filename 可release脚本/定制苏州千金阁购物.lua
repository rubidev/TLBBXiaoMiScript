购买物品 = {
    "3级宝石兑换券", "金蚕丝"
}


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

function BuyGood(goodIndex)
    LUA_Call([[setmetatable(_G, {__index = GuiShi_Shop_Env});GuiShi_Shop_BuyMult();]])   -- 生效批量购买
    延时(1000)

    LUA_Call(string.format([[setmetatable(_G, {__index = GuiShi_Shop_Env});GuiShi_Shop_onGoods(%d);]], goodIndex))  -- 1 表示宝石券，2 表示金蚕丝
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = GuiShi_ShopMBuy_Env});GuiShi_ShopMBuy_OnMax();]])  -- 设置最大购买
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = GuiShi_ShopMBuy_Env});GuiShi_ShopMBuy_OnOK();]])  -- 购买
    延时(1000)

    LUA_Call([[setmetatable(_G, {__index = GuiShi_Shop_Env});GuiShi_Shop_BuyMult();]])  -- 关闭千金阁
    延时(400)
end

function Main()
    屏幕提示("【雨夜出品, 必是精品】新千金阁购物, 默认买宝石兑换券、金蚕丝")

    MoveToPos("苏州", 222, 235)
    延时(2000)
    对话NPC("柳金蟾")
    延时(500)
    NPC二级对话("千金阁")
    延时(1000)

    for k, value in pairs(购买物品) do
        if string.find("3级宝石兑换券", value) then
            BuyGood(1)
        elseif string.find("金蚕丝", value) then
            BuyGood(2)
        elseif string.find("福降令", value) then
            BuyGood(3)
        elseif string.find("虹耀石", value) then
            BuyGood(4)
        elseif string.find("缀梦灵石", value) then
            BuyGood(5)
        elseif string.find("玄灵丹", value) then
            BuyGood(6)
        elseif string.find("3级秘银", value) then
            BuyGood(7)
        elseif string.find("3级棉布", value) then
            BuyGood(8)
        elseif string.find("中级勾天彩合成符", value) then
            BuyGood(9)
        elseif string.find("绿色典籍礼盒", value) then
            BuyGood(10)
        end
    end
end

Main()
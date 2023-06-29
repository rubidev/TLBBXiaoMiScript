-- 打开无字谱
LUA_Call([[
    setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(23)
]])
延时(1000)
-- 切换到心诀
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Env});Rune_Stars_FenYe_Switch(2)
]])
延时(1000)
-- 切换到心诀合成
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Reel_Env});Rune_Stars_Reel_SubFenYe_Switch(2)
]])
延时(1000)
-- 一键分解
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Reel_Env});Rune_Stars_Reel_BatchSplit()
]])
延时(1000)
-- 分解确认
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_BatchSplit_Env});Rune_Stars_BatchSplit_OKClicked()
]])
延时(1000)
-- 关闭无字谱界面
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Reel_Env});Rune_Stars_Reel_OnCloseClicked();
]])
延时(300)
跨图寻路("大理", 206, 52)
延时(2000)
对话NPC("沈暝楼")
延时(500)
NPC二级对话("还诀斋")
延时(1500)

-- 点击批量购买
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Shop_Env});Rune_Stars_Shop_BuyMult();
]])
延时(1000)
-- 选择目标
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Shop_Env});Rune_Stars_Shop_onGoods(2);
]])
延时(1000)

-- 最大
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_BatchBuy_Env});Rune_Stars_BatchBuy_OnMax()
]])
延时(1000)
-- 购买确认
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_BatchBuy_Env});Rune_Stars_BatchBuy_OnOK()
]])
延时(1000)

-- 关闭还诀斋
LUA_Call([[
    setmetatable(_G, {__index = Rune_Stars_Shop_Env});Rune_Stars_Shop_OnClose();
]])
延时(2000)

for i=1, 获取背包物品数量("心诀集录·良") do
    右键使用物品("心诀集录·良")
    延时(500)
end
延时(500)
执行功能("自动清包")
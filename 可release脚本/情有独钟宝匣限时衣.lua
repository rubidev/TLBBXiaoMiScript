屏幕提示("【雨夜出品, 必是精品】领取【情有独钟宝匣】中的30天衣服")
local count = 获取背包物品数量("情有独钟宝匣")
for i=1, count do
    右键使用物品("情有独钟宝匣")
    延时(1000)
    LUA_Call([[
        setmetatable(_G, {__index = DuanWu_BaoZongZi_DoubleChoice_Env});DuanWu_BaoZongZi_DoubleChoice_GetFree()
    ]])
end
延时(1500)
右键使用物品("动作：凌波共月")
延时(200)
右键使用物品("情有独钟")
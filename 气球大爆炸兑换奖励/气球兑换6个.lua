-- 最多可得18*9=172

local exchangeCount=0

屏幕提示("【雨夜出品必是精品】前往洛阳童姥处")
跨图寻路("洛阳",262,342)
延时(2000)
屏幕提示("【雨夜出品必是精品】6个弹珠兑换紫色真元符集，预计耗时1分钟")

对话NPC("童姥")
延时(500)
NPC二级对话("使用彩色弹珠兑换奖励")
延时(500)
while true do
    if exchangeCount >= 28 then
	    break
	end
	NPC二级对话("6个弹珠兑换紫色真元符集")
	延时(1000)
	LUA_Call("setmetatable(_G, {__index = WuhunQuest_Env});WuhunQuest_Bn1Click();")
	延时(500)
	exchangeCount = exchangeCount + 1
end


local giftCount = tonumber(获取背包物品数量("紫色真元符集"))

for i=1,giftCount do
   右键使用物品("紫色真元符集")
   延时(200)
end



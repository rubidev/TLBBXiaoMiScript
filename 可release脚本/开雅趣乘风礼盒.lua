
function OpenGift()
    右键使用物品("雅趣乘风礼盒")
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = SpecialGift_ThreeChoiceTongyong_Env});SpecialGift_ThreeChoiceTongyong_Choose(3)]])  -- 选中第三个，瑶华璧
    延时(1000)
    LUA_Call([[setmetatable(_G, {__index = SpecialGift_ThreeChoiceTongyong_Env});SpecialGift_ThreeChoiceTongyong_GetClick()]])
end


function main()
    屏幕提示("【雨夜出品, 必是精品】使用背包中的雅趣乘风礼盒, 选择瑶华璧")
    local giftCount = tonumber(获取背包物品数量("雅趣乘风礼盒"))

    local index = 0
    while index < giftCount do
	    OpenGift()
        index = index + 1
		延时(2000)
	end

end



main()
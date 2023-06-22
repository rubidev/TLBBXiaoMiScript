


取出物品("竹香筒粽")
取出物品("锦粽飘香礼盒")
local ZXTZCount = 获取背包物品数量("竹香筒粽")
local PXGiftCount = 获取背包物品数量("锦粽飘香礼盒")
if ZXTZCount > 0 then
	for i = 1, ZXTZCount do
		右键使用物品("竹香筒粽")
		延时(100)
	end
end

if PXGiftCount > 0 then
	
end

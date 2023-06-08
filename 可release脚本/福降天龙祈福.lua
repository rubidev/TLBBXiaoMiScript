取出物品("福降令")

延时(2000)

FJLCount = 获取背包物品数量("福降令")

if tonumber(FJLCount) > 0 then
	while true do
	    跨图寻路("洛阳",270,256)
		延时(2000)
		local myX = tonumber(获取人物信息(7))
		local myY = tonumber(获取人物信息(8))
		if myX == 270 and myY == 256 then
			break
		end
	end
	延时(2000)

	对话NPC("乔致广")
	延时(1000)
	NPC二级对话("福降天龙")
	延时(2000)
	LUA_Call([[setmetatable(_G, {__index = FuJiangTianLongHD_Env});FuJiangTianLongHD_DoBless();]])
	延时(1000)
	LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
	
end



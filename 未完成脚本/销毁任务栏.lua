


local taskNum = LUA_取返回值([[
    local currNum = DataPool:GetTaskBag_Num();
    return currNum
]])


for i = 1, tonumber(taskNum) do
    local isTarget = LUA_取返回值(string.format([[
        local theAction,bLocked = PlayerPackage:EnumItem("quest", %d-1);
		if theAction:GetID() ~= 0 then
			local itemName = theAction:GetName()
			-- local itemNum = theAction:GetNum()
            if string.find(itemName, "维修木材") then
				return 1
			elseif string.find(itemName, "宋") then
				return 2
			elseif string.find(itemName, "辽") then
				return 2
			end
		end
		return -1
    ]], i))


	local row = math.floor(i / 10)
    local col = math.floor(i % 10)
    if col == 0 then
        col = 10
    else
        row = row + 1
    end

	if tonumber(isTarget) == 1 then
		跨图寻路("洛阳", 360, 183)
		延时(2000)
		对话NPC("孔宗渊")
		延时(500)
		NPC二级对话("我想删除任务道具")
		延时(1000)
		LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))  -- 右键选中物品
		延时(500)
		LUA_Call(string.format([[]]))  -- TODO 点击销毁按钮
		延时(500)
		LUA_Call([[]]) -- TODO 关闭销毁界面
	elseif tonumber(isTarget) == 2 then
		LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))  -- 右键使用棋子
	end
end
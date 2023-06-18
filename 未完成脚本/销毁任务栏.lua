


local taskNum = LUA_取返回值([[
    local currNum = DataPool:GetTaskBag_Num();
    return currNum
]])


LUA_Call([[]])  -- 打开背包，切换到任务栏
LUA_Call([[]]) -- 点击整理

for i = 1, tonumber(taskNum) do
    local isTarget = LUA_取返回值(string.format([[
        local targetItemName = "%s"
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
    ]], targetItemName, i))
	if tonumber(isTarget) == 1 then
		跨图寻路("洛阳", 360, 183)
		延时(2000)
		对话NPC("孔宗渊")
		延时(500)
		NPC二级对话("我想删除任务道具")
		延时(1000)
		LUA_Call()
	elseif tonumber(isTarget) == 2 then
		
	end
	
	
end
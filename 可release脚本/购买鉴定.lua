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

取出物品("3级棉布|3级秘银|4级棉布|4级秘银|5级棉布|5级秘银|至尊棉布|至尊秘银")
MoveToPos("洛阳", 356, 236)

mianBuCount  = 获取背包物品数量("3级棉布") + 获取背包物品数量("4级棉布") + 获取背包物品数量("5级棉布") + 获取背包物品数量("至尊棉布")
miYinCount  = 获取背包物品数量("3级秘银") + 获取背包物品数量("4级秘银") + 获取背包物品数量("5级秘银") + 获取背包物品数量("至尊秘银")

needBuyShuNum = math.floor(tonumber(mianBuCount) / 5) + 1
needBuyFuNum = math.floor(tonumber(miYinCount) / 5) + 1

对话NPC("付云伤")
延时(3000)
NPC二级对话("云锦行", 0)
延时(2000)
for i=1, 4 do
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_PageDown();]])
    延时(200)
end
延时(500)
LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_PageUp();]])
延时(1000)

for i = 1, needBuyShuNum do
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_Clicked(6)]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy2_Env});ActivitySchedule_MBuy2_OK_Clicked();]])
    延时(500)
end

对话NPC("付云伤")
延时(2000)
NPC二级对话("云锦行", 0)
延时(2000)

for i=1, 4 do
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_PageDown();]])
    延时(200)
end

延时(2000)
for i = 1, needBuyFuNum do
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_Clicked(1)]])
    延时(500)
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy2_Env});ActivitySchedule_MBuy2_OK_Clicked();]])
    延时(500)
end

延时(500)
LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_OnHiden();]])
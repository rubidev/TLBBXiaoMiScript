取出物品("马鞍|黄金马鞍")
跨图寻路("洛阳", 228, 325)
延时(1000)
对话NPC("田骁鸣")
延时(500)
NPC二级对话("兑换白银马鞍")
延时(800)
if 窗口是否出现("MessageBox_Self") == 1 then
    LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
end
延时(200)
NPC二级对话("兑换青铜马鞍")
延时(800)
if 窗口是否出现("MessageBox_Self") == 1 then
    LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
end

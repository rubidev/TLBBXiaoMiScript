function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end


MentalTip("开始任务【初识元丹晓全貌】")
跨图寻路("苏州", 177, 230)
延时(1000)

-- 任务1
对话NPC("云丹丹")
延时(500)
NPC二级对话("初识元丹", 1)
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});QuestAccept_Clicked();]])  -- 接受任务，点击接受
延时(500)
NPC二级对话("发生了什么事", 1)
延时(500)
NPC二级对话("那该当如何", 1)
延时(500)
NPC二级对话("何为元丹", 1)
延时(500)
NPC二级对话("我已知晓", 1)
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});MissionContinue_Clicked();]])  -- 点击完成
延时(500)
MentalTip("结束任务【初识元丹晓全貌】")


-- 人物2
MentalTip("开始任务【丹入三脉强体魄】")
对话NPC("云丹丹")
延时(500)
NPC二级对话("丹入三脉", 1)
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});QuestAccept_Clicked();]])  -- 接受任务，点击接受
延时(500)
LUA_Call([[setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_Pet_Clicked();]])  -- 打开珍兽界面
延时(500)
LUA_Call([[setmetatable(_G, {__index = Pet_Env});Pet_NeiDan_Page_Switch()]])   -- 切到元丹界面
延时(500)
LUA_Call([[setmetatable(_G, {__index = PetNeidan_Env});PetNeidan_NeiDanRClicked(1)]])  -- 装备内丹
延时(500)
对话NPC("云丹丹")
延时(500)
NPC二级对话("丹入三脉", 1)
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});MissionContinue_Clicked();]])  -- 点击完成
延时(500)
MentalTip("结束任务【丹入三脉强体魄】")


-- 任务3
MentalTip("开始任务【元丹坊中觅奇珍】")
对话NPC("云丹丹")
延时(500)
NPC二级对话("元丹坊中觅奇珍")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});QuestAccept_Clicked();]])  -- 接受任务，点击接受
延时(500)
取出物品("金币", 50)
跨图寻路("苏州", 177, 230)
延时(1000)
对话NPC("云丹丹")
延时(500)
NPC二级对话("元丹坊")
延时(1000)
LUA_Call([[setmetatable(_G, {__index = PetNeidan_Shop_Env});PetNeidan_Shop_Clicked(1)]])  -- 点击 精品灵元图
延时(1000)
--LUA_Call([[setmetatable(_G, {__index = Shop_MBuy_Env});Shop_MBuy_CalMax();]])  -- 点击最大
--延时(500)
LUA_Call([[setmetatable(_G, {__index = Shop_MBuy_Env});Shop_MBuy_BuyMulti_Clicked();]])  -- 点击 批量购买确认
延时(500)
LUA_Call([[setmetatable(_G, {__index = MessageBox_Self3_Env});MessageBox_Self3_OnOk()]])  -- 点击 确认
延时(500)
LUA_Call([[setmetatable(_G, {__index = PetNeidan_Shop_Env});PetNeidan_Shop_OnHiden();]])  -- 关闭 元丹坊
延时(500)
对话NPC("云丹丹")
延时(500)
NPC二级对话("元丹坊中觅奇珍")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});MissionContinue_Clicked();]])  -- 点击完成
延时(500)
MentalTip("结束任务【元丹坊中觅奇珍】")


-- 任务4
MentalTip("开始任务【按图索骥奇遇现】")
对话NPC("云丹丹")
延时(500)
NPC二级对话("按图索骥奇遇现")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});QuestAccept_Clicked();]])  -- 接受任务，点击接受
延时(500)
执行功能("精品灵元图")
延时(500)
跨图寻路("苏州", 177, 230)
延时(1000)
对话NPC("云丹丹")
延时(500)
NPC二级对话("按图索骥奇遇现")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});MissionContinue_Clicked();]])  -- 点击完成
延时(500)
MentalTip("结束任务【按图索骥奇遇现】")



-- 任务5
MentalTip("开始任务【长戈试道探灵谷】")
对话NPC("云丹丹")
延时(500)
NPC二级对话("长戈试道探灵谷")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});QuestAccept_Clicked();]])  -- 接受任务，点击接受
延时(500)
MentalTip("任务【长戈试道探灵谷】需要通关聚灵谷")
对话NPC("云丹丹")
延时(500)
NPC二级对话("长戈试道探灵谷")
延时(500)
LUA_Call([[setmetatable(_G, {__index = Quest_Env});MissionContinue_Clicked();]])  -- 点击完成
MentalTip("结束任务【长戈试道探灵谷】")


-- 领取奖励
MentalTip("领取武林风云录奖励")
LUA_Call([[
    local currentSelect = 11
    Clear_XSCRIPT()
        Set_XSCRIPT_Function_Name("GetBonus")
        Set_XSCRIPT_ScriptID(290099)
        Set_XSCRIPT_Parameter(0,tonumber(currentSelect - 1))
        Set_XSCRIPT_ParamCount(1)
    Send_XSCRIPT()
]])





giftQualityList = {
    '良品礼物',
    '精品礼物',
    '珍品礼物',
    '神品礼物',
}

--giftQualityList = {
--    '良品礼物',
--    '精品礼物',
--    '珍品礼物',
--    '神品礼物',
--}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

while true do
    跨图寻路("大理", 206, 53)
    延时(500)
    local myX = 获取人物信息(7)
    local myY = 获取人物信息(8)
    if tonumber(myX) == 206 and tonumber(myY) == 53 then
        break
    end
end
延时(1000)

for _, giftQuality in pairs(giftQualityList) do
    MentalTip(string.format("即将合成【%s】", giftQuality))
    对话NPC("沈暝楼")
    延时(800)
    NPC二级对话('礼物合成')
    延时(800)
    NPC二级对话(giftQuality, 1)
    延时(2000)
    LUA_Call([[
        setmetatable(_G, {__index = Gift_Synthesis_Env});Gift_Synthesis_ConfirmClick();
    ]])
    延时(500)
end
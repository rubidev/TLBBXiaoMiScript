function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

curMap = 获取人物信息(16)
if string.find(curMap, "地府") then
    MentalTip("你在地府, 即将出地府！")
    出监狱地府()
else
    MentalTip("你活的好好的！")
end
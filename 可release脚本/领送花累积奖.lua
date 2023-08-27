LUA_Call([[setmetatable(_G, {__index = SeventhFestivalEnter_Env});SeventhFestivalEnter_OnClick()]])
延时(3000)

LUA_Call([[setmetatable(_G, {__index = SeventhFestivalTopList_Env});SeventhFestivalTopList_Page_Click(3)]])
延时(2000)

for i=1, 6 do
	LUA_Call(string.format([[setmetatable(_G, {__index = SeventhFestivalTopList_Env});SeventhFestivalTopList_LeiJiAward_OnClicked(%d);]], i))
	延时(500)
end

延时(1000)

LUA_Call([[setmetatable(_G, {__index = SeventhFestivalTopList_Env});SeventhFestivalTopList_Close_Click();]])
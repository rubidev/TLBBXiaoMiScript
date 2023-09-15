延时时间 = 140


local curDay = LUA_取返回值("return DataPool:GetServerDayTime();", "n", 1)
if tonumber(curDay) >= 20230914 then
    MentalTip("过期！！！")
    return
end
while true do
    LUA_Call([[City:OpenNewGuildWarDlg();]])
    LUA_Call([[City:SendAddEnemyMsg( 715,1 );]])
    延时(延时时间)
end
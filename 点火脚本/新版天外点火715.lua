速度 = 140

KServerZoneWordId = LUA_取返回值(string.format([[
    local WorldNum = City:GetKServerWorldNum();
    for i=1,WorldNum do
        local WorldName = City:GetKServerZoneWorldNameByIndex(i-1);
        if WorldName=="%s" then
            local g_CurrentSelectedServer = City:GetKServerZoneWorldIdByIndex(i-1);
            return g_CurrentSelectedServer
        end
    end
]]))

while true do
    LUA_Call([[City:OpenNewGuildWarDlg();]])
    LUA_Call(string.format([[
        City:AddKServerEnemyList(%d, 715);
    ]], tonumber(KServerZoneWordId)))
    延时(速度)
end
local 帮派喊话内容 = "#cff66cc..好友没满的加好友，高科技送祝福"
if 判断有无帮派() == 1 then
    LUA_Call("setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();")
    延时(3000)
    LUA_Call("setmetatable(_G, {__index = ChatFrame_Env});Talk : SendChatMessage('guild', '" .. 帮派喊话内容 .. "');")
    local BangHuiMembersNum = 到整数(LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetMembersNum(3);"))
    屏幕提示("当前在线帮众[" .. tostring(BangHuiMembersNum) .. "]人")
    for i = 0, BangHuiMembersNum - 1 do
        local guildIdx = 到整数(LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetShowMembersIdx(" .. tostring(i) .. ");"))
        local szMsg = LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetMembersInfo(" .. tostring(guildIdx) .. ", 'Name');")
        LUA_Call("DataPool:AddFriend(0, '" .. szMsg .. "')")
        --屏幕提示(szMsg)
        延时(1000)
    end
    LUA_Call("setmetatable(_G, {__index = ChatFrame_Env});Talk : SendChatMessage('guild', '" .. 帮派喊话内容 .. "');")
end

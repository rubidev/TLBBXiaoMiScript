function SwitchRoleMode(RoleModeType)
    -- 切换到指定模式
    --屏幕提示("更换模式"..RoleModeType)
    if RoleModeType == "和平" then
        LUA_Call("Player:ChangePVPMode(0);")
    elseif RoleModeType == "个人" then
        LUA_Call("Player:ChangePVPMode(1);")
    elseif RoleModeType == "组队" then
        LUA_Call("Player:ChangePVPMode(3);")
    elseif RoleModeType == "帮会" then
        LUA_Call("Player:ChangePVPMode(4);")
    elseif RoleModeType == "善恶" then
        LUA_Call("Player:ChangePVPMode(2);")
    end
end

SwitchRoleMode("和平")
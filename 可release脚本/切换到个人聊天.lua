
-- 综合频道
--LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(0);]])

-- 系统频道
--LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(1);]])

-- 个人频道
LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(2);]])

-- 同城频道
--LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(3);]])

-- 征召频道
--LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(4);]])
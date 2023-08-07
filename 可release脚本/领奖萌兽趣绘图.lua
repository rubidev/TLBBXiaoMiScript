  -- 打开萌宠戏浮夏
LUA_Call([[setmetatable(_G, {__index = PlayerQuicklyEnter_Env});PlayerQuicklyEnter_Clicked(24)]])
延时(1000)

-- 打开萌兽趣绘图
LUA_Call([[setmetatable(_G, {__index = XiGua_Guide_Env});XiGua_Guide_Clicked(4);]])
延时(1000)

-- 领奖
LUA_Call([[setmetatable(_G, {__index = XiGuaJie_Activity_Env});XiGuaJie_Activity_GetReward_Clicked(1)]])
延时(500)
LUA_Call([[setmetatable(_G, {__index = XiGuaJie_Activity_Env});XiGuaJie_Activity_GetReward_Clicked(2)]])
延时(500)
LUA_Call([[setmetatable(_G, {__index = XiGuaJie_Activity_Env});XiGuaJie_Activity_GetReward_Clicked(3)]])
延时(1000)
LUA_Call([[setmetatable(_G, {__index = XiGuaJie_Activity_Env});XiGuaJie_Activity_Close()]])

执行功能("自动清包")

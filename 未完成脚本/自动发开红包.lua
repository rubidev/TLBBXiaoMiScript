
-- 打开帮会
LUA_Call([[
    setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();
]])

延时(2000)

-- 切到红包界面
LUA_Call([[
    setmetatable(_G, {__index = NewBangHui_Hygl_Env});NewBangHui_Hygl_HB_OnClicked();
]])
延时(1000)
-- 发红包
LUA_Call([[
    -- 副本红包(鸿运红包)
    setmetatable(_G, {__index = NewBangHui_Redenvelope_Env});NewBangHui_Redenvelope_Deliver_Left_Clicked()
    -- 充值红包(鸿福红包)
    setmetatable(_G, {__index = NewBangHui_Redenvelope_Env});NewBangHui_Redenvelope_Deliver_Right_Clicked()
]])
延时(1000)
-- 关闭帮会界面
LUA_Call([[
    setmetatable(_G, {__index = NewBangHui_Redenvelope_Env});NewBangHui_Redenvelope_Closed();
]])

延时(3000)

-- 打开红包，测试是否可用
LUA_Call([[
    -- 打开红包
    setmetatable(_G, {__index = RedenvelopeMessage_Env});RedenvelopeMessage_ButtonOnClicked(0);
]])
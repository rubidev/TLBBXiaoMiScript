取出物品("菩提心经")
延时(3000)
if 获取背包物品数量("菩提心经") > 0 then
    LUA_Call([[
        Clear_XSCRIPT()
                Set_XSCRIPT_Function_Name("AskActRMBReward")  --脚本接口
                Set_XSCRIPT_ScriptID(790029) --脚本编号
                Set_XSCRIPT_ParamCount(0)
        Send_XSCRIPT()
    ]])

    延时(2000)

    LUA_Call([[setmetatable(_G, {__index = MessageBox_Self2_Env});MessageBox_Self2_Ok_Clicked();]])

end
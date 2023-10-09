for i = 1, 40 do
    LUA_Call([[
        Clear_XSCRIPT()
            Set_XSCRIPT_Function_Name( "QiFu" )
            Set_XSCRIPT_ScriptID( 893167 )
            Set_XSCRIPT_ParamCount(0)
        Send_XSCRIPT()
    ]])
    延时(3000)
end

执行功能("自动清包")
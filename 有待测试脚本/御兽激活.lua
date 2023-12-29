-- 优先使用绑定元宝补充

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function StringSplit(str, reps)
    -- 字符串切割
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function ActivePetMaster()
    LUA_Call([[
        for activeIndex = 0, 115 do
            local pointState = Player:GetPetMasterPointState(activeIndex , "State")
            local petFlag = Player:GetPetMasterPointState(activeIndex , "PetFlag")
            if pointState ~= nil and petFlag ~= nil then
                if pointState == 0 or pointState == 1 then      --未激活 或者 待激活
                    Clear_XSCRIPT()
                        Set_XSCRIPT_Function_Name( "PetMasterActive" )
                        Set_XSCRIPT_ScriptID( 880004 )
                        Set_XSCRIPT_Parameter( 0,  activeIndex)         ---点的索引
                        Set_XSCRIPT_ParamCount( 1 )
                    Send_XSCRIPT()
                end
            end
        end
    ]])
end

-- main ------------------------------------------------
ActivePetMaster()
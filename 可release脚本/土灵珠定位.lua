定位土灵珠数量 = 2

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
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

function GetBaseBKGItemPos(itemName, itemNum)
    local tmp = LUA_取返回值(string.format([[
        local currNum = DataPool:GetBaseBag_Num();
        local itemName = "%s"
        local itemNum = %d
        local itemCount = 0
        for i=1, currNum do
            local theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
            local sName = theAction:GetName();
            if string.find(itemName, sName) ~= nil then
                itemCount = itemCount + 1
                if itemCount == itemNum then
                    return i
                end
            end
        end
        return -1
    ]], itemName, tonumber(itemNum)))
    return tonumber(tmp)
end

function setTLZPosition(TLZIndex)
    LUA_Call(string.format([[
        local Client_ItemIndex = %d
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("SetPosition");
            Set_XSCRIPT_ScriptID(330001);
            Set_XSCRIPT_Parameter(0, Client_ItemIndex);
            Set_XSCRIPT_ParamCount(1);
        Send_XSCRIPT();
    ]], TLZIndex))
end

function setPosition()
    for num = 1, 定位土灵珠数量 do
        local TLZPos = GetBaseBKGItemPos('土灵珠', num)
        if TLZPos ~= -1 then
            setTLZPosition(TLZPos - 1)
        end
        延时(200)
    end
end

function main()
    setPosition()
end

-- main -----------------------------------------------
main()

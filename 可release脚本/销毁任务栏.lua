销毁任务道具名字 = {
    "维修木材"
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function MoveToPos(NPCCity, x, y)
    while true do
        跨图寻路(NPCCity, x, y)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == x and tonumber(myY) == y then
            break
        end
    end
end

function DestroyMissionItem()
    MentalTip("前往洛阳(361, 183)准备销毁任务道具")
    MoveToPos('洛阳', 361, 183)

    for taskItemPos = 200, 219 do
        MentalTip(string.format('开始第【%d/20】轮销毁作业', taskItemPos - 199))
        for _, item in pairs(销毁任务道具名字) do
            LUA_Call(string.format([[
                taskItemPos = %d
                theAction,bLocked = PlayerPackage:EnumItem("quest", taskItemPos - 200);  -- szPacketName = "base"、"material"、"quest"
                if theAction:GetID() ~= 0 then
                    local sName = theAction:GetName();
                    if sName == "%s" then
                        Clear_XSCRIPT()
                            Set_XSCRIPT_ScriptID( 124 )
                            Set_XSCRIPT_Function_Name( "OnDestroy" )
                            Set_XSCRIPT_Parameter( 0, taskItemPos )
                            Set_XSCRIPT_ParamCount( 1 )
                        Send_XSCRIPT()
                    end
                end
            ]], taskItemPos, item))
        end
        延时(500)
    end
end

function UseQiZi()
    for i = 1, 20 do
        local row = math.floor(i / 10)
        local col = math.floor(i % 10)
        if col == 0 then
            col = 10
        else
            row = row + 1
        end
        LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))  -- 右键使用棋子
        延时(500)
    end
end

-- main ------------------------
UseQiZi()
DestroyMissionItem()
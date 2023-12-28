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

function PickOutJGC()
    取出物品("金刚锉")
    MoveToPos("苏州", 354, 234)
    延时(2000)
    对话NPC("欧冶子")
    延时(1000)
    NPC二级对话("补充金刚锉使用次数")
end

function RightUse(row, col)
    LUA_Call(string.format([[
        setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);
    ]], row, col))
end

function ClickConfirmBtn()
    LUA_Call([[
        setmetatable(_G, {__index = JinGangCuo_AddNum_Env});
        JinGangCuo_AddNum_ConfirmClick();
    ]])
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

function MergeJGCCount()
    local posString = LUA_取返回值(string.format([[
        local itemName = "%s"
        local currNum = DataPool:GetBaseBag_RealMaxNum();
        local pos = ""
        for i=1, currNum do
            local theAction,bLocked = PlayerPackage:EnumItem("base", i-1);
			if theAction:GetID() ~= 0 then
				local sName = theAction:GetName();
				if itemName == sName then
                    pos = pos .. tostring(i) .. "|"
                end
			end
        end
        return pos
    ]], "金刚锉"))
    local posList = StringSplit(posString, "|")

    for i = 1, #posList do
        if posList[i] ~= nil and posList[i] ~= '' then
            local pos = tonumber(posList[i])
            local row = math.floor(tonumber(pos) / 10)
            local col = math.floor(tonumber(pos) % 10)
            if col == 0 then
                col = 10
            else
                row = row + 1
            end

            RightUse(row, col)
            延时(800)
            ClickConfirmBtn()
            延时(500)
        end
    end
end

function main()
    for i = 1, 3 do
        MentalTip(string.format("共进行3轮补充金刚锉次数, 当前第【%d】轮", i))
        PickOutJGC()

        if 获取背包物品数量("金刚锉") < 1 then
            MentalTip("没有金刚锉, 退出")
            break
        end

        延时(1000)
        MergeJGCCount()
    end

    MoveToPos("苏州", 343, 245)
end

main()

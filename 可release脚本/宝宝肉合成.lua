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

function RightUse(row, col)
    LUA_Call(string.format([[
        setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);
    ]], row, col))
end

function ClickConfirmBtn()
    LUA_Call([[setmetatable(_G, {__index = ZhenShouYao_AddNum_Env});ZhenShouYao_AddNum_ConfirmClick();]])
end

function List2String(targetList)
    local retString = ''
    for index, item in pairs(targetList) do
        retString = retString .. item
        if index ~= #targetList then
            retString = retString .. '|'
        end
    end
    return retString
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

function MergePetFoodCount(petFoodName)
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
    ]], petFoodName))
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
            延时(1000)
            ClickConfirmBtn()
        end
    end
end

function main()
    执行功能("同步游戏时间")
    local curDay = LUA_取返回值("return DataPool:GetServerDayTime();", "n", 1)
    if tonumber(curDay) >= 20230914 then
		MentalTip("您的文本已到期！！！")
        return
    end

    local loopCount = 0
    while true do
        if loopCount >= 3 then
            break
        end

        MentalTip(string.format("共尝试3轮合成, 当前第【%d】轮", loopCount + 1))
        local petFoodList = { "珍兽回春丹", "珍兽回神丹", "珍兽滋补丹", "珍兽万补丹", "超级珍兽滋补丹", "超级珍兽回春丹" }
        local petFoodString = List2String(petFoodList)
        取出物品(petFoodString)

        MoveToPos("洛阳", 275, 295)
        延时(3000)

        for i = 1, #petFoodList do
            local petFoodName = petFoodList[i]
            local petFoodCount = 获取背包物品数量(petFoodName)
            if petFoodCount < 2 then
                MentalTip(string.format("【%s】数量少于2个, 跳过", petFoodName))
            else
                对话NPC("云渺渺")
                延时(1000)
                NPC二级对话("珍兽药补充使用次数")
                延时(2000)
                MergePetFoodCount(petFoodName)
            end
        end
        loopCount = loopCount + 1
    end
end


-- 执行函数 ----------------------------------
main()

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


function main()
    MentalTip("使用春至香囊")
    while true do
        local itemCount = 获取背包物品数量("春至香囊")
        if itemCount <= 0 then
            MentalTip("没有【春至香囊】, 退出")
            return
        end
        右键使用物品("春至香囊")
        延时(800)
        LUA_Call([[setmetatable(_G, {__index = SpringFestival_Redpacket2_Env});SpringFestival_Redpacket2_OpenBtn(1);]])
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = SpringFestival_Redpacket2_Env});SpringFestival_Redpacket2_OnCloseClicked();]])
    end
end

-- main ------------------------------------------------------
main()

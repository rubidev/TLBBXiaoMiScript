目标名字关键字 = {}
-- 目标名字关键字 = { "至尊", "君临", "异界侠士"}

杀死敌人秒数 = 5

遍历速度 = 110 -- 尽量不改, 越小越快, 小于110容易掉线, 但是精度越差; 越大越满, 但是精度越好


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

function GetTargetRelation()
    local tmp = LUA_取返回值([[
		return Target:GetData( "RELATION" )
	]])

    if tmp == nil then
        tmp = LUA_取返回值([[
			Target:SendAskDetail();
			return Target:GetData( "RELATION" )
		]])
    end
    return tmp
end

while true do
    local myX = 获取人物信息(7)
    local myY = 获取人物信息(8)
    local minHP = -1
    local tID = -1
    local tPlayerName = -1
    local nearbyPlayer = 获取周围玩家(白名单, myX, myY, 15)
    if nearbyPlayer ~= nil then
        local nearbyPlayerList = StringSplit(nearbyPlayer, '|')
        for _, playerName in pairs(nearbyPlayerList) do
            local flag = false
            if #目标名字关键字 ~= 0 then
                for _, pattern in pairs(目标名字关键字) do
                    if string.find(playerName, pattern) then
                        flag = true
                        break
                    end
                end
            else
                flag = true
            end

            if flag then
                local name, ID, x, y, HP, tDistance, tType, tOwner, tJudge, tTitle = 遍历周围物品(5, playerName, 15)
                if name ~= nil and ID ~= nil then
                    选中对象(ID)
                    延时(遍历速度)
                    local relation = GetTargetRelation()
                    if relation == '4' or relation == '5' then
                        if minHP == -1 then
                            minHP = HP
                            tID = ID
                            tPlayerName = name
                        else
                            if HP < minHP then
                                minHP = HP
                                tID = ID
                                tPlayerName = name
                            end
                        end
                    end
                    -- 屏幕提示(tPlayerName .. '|' .. ID .. '|血量百分比：' .. minHP)
                end
            end
        end
        MentalTip('当前血量最少的目标为：' .. tPlayerName .. '|' .. tID .. '|血量百分比：' .. minHP)
        选中对象(tID)

        local waitTime = 0
        while true do
            if waitTime >= 杀死敌人秒数 then
                MentalTip("5秒仍未击杀, 切换到下一个目标")
                break
            end

            local name, curID, x, y, curHP, tDistance, tType, tOwner, tJudge, tTitle = 遍历周围物品(5, tPlayerName, 15)
            if curID ~= nil and curHP > 0 then
                选中对象(tID)
                延时(1000)
            else
                break
            end

            waitTime = waitTime + 1
        end
    end

    延时(120)
end
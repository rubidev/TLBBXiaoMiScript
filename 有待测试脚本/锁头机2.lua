目标名字关键字 = ''
-- 目标名字关键字 = "至尊|君临|异界侠士"

目标门派 = '武当|唐门'


杀死敌人秒数 = 5



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


function SearchMinHPTarget(filterTargetList, memPaiList)
    local mainTargetInfo = LUA_取返回值(string.format([[
        local memPaiList = {
            [10]="少林"
            [11]="明教"
            [12]="丐帮"
            [13]="武当"
            [14]="峨嵋"
            [15]="星宿"
            [16]="天龙"
            [17]="天山"
            [18]="逍遥"
            [19]="无门派"
            [20]="慕容"
            [21]="唐门"
            [22]="鬼谷"
            [23]="桃花岛"
            [24]="绝情谷"
        }

        local needMenPaiList = "%s"
        function isNeedMenPai()
            local nMenpai = Target:GetMenPai();
            local memPaiName = memPaiList[nMenpai+10]
            if string.find(memPaiName, needMenPaiList) then
                flag = true
            else
                flag = false
            end
            return flag
        end

        function HavaUnbeatableBuff()
            local TARGET_BUFF_MAX = 6;
            local TARGET_IMPACT_NUM = 20; --查询时要从20个里面选出优先级最高的6个

            local nBuffNum = Target:GetBuffNumber();
            local nFindNum = nBuffNum --在修正nBuffNum之前获得它的值
            if(nFindNum > TARGET_IMPACT_NUM) then nFindNum = TARGET_IMPACT_NUM; end
            if(nBuffNum > TARGET_BUFF_MAX) then nBuffNum = TARGET_BUFF_MAX; end

            local tmp = 0
            for jj = 1, nFindNum then
                szIconName,szTipInfo = Target:GetBuffIconNameByIndex(jj-1);
                PushDebugMessage(szTipInfo)
                if string.find(szTipInfo, '无敌') then
                    tmp = 1
                    break
                end
            end
            return tmp
        end

        local filterTargetList = "%s"

        local minHP = -1
        local mainTargetID = -1
        local mainTargetName = -1
        for i=1,2000 do
            if SetMainTargetFromList(i ,false, false) == 1 then   -- TODO
                local playerName = Target:GetName()
                local nameFlag = false
                if filterTargetList ~= nil and filterTargetList ~= '' then
                    if string.find(filterTargetList, mainTargetName) then
                        nameFlag = true
                    end
                else
                    nameFlag = true
                end

                local menPaiFlag = false
                if needMenPaiList ~= nil and needMenPaiList ~= '' then
                    if isNeedMenPai() then
                        menPaiFlag = true		
                    end
				else
					menPaiFlag = true
                end

                if nameFlag and menPaiFlag then
                    local isUnbeatable = HavaUnbeatableBuff()
                    if isUnbeatable ~= 1 then
                        local RaidHP = Target:TargetFrame_Update_HP_Raid();
                        if RaidHP ~= nil and RaidHP ~= 0 then
                            if minHP == -1 and  then
                                minHP = RaidHP
                                mainTargetID = i
                                mainTargetName = playerName
                            else
                                if RaidHP < minHP then
                                    minHP = RaidHP
                                    mainTargetID = i
                                    mainTargetName = playerName
                                end
                            end
                        end
                    end
                end
            end
        end
        return mainTargetID .. "|" .. mainTargetName
    ]], memPaiList, filterTargetList))

    local tmpList = StringSplit(mainTargetInfo, '|')
    local mainTargetID, mainTargetName = tmpList[1], tmpList[2]
    return mainTargetID, mainTargetName
end

function main()
    if 目标名字关键字 ~= '' and 目标门派 ~= '' then
        MentalTip("【目标名字关键字】和【目标门派】只能选填一个, 请修改")
        return
    end

    while true do
        local mainTargetID, mainTargetName = SearchMinHPTarget(目标名字关键字, 目标门派)

        if mainTargetID ~= -1 and mainTargetName ~= -1 then
            选中对象(mainTargetID)

            local waitTime = 0
            while true do
                if waitTime >= 杀死敌人秒数 then
                    MentalTip("5秒仍未击杀, 切换到下一个目标")
                    break
                end

                local name, curID, x, y, curHP, tDistance, tType, tOwner, tJudge, tTitle = 遍历周围物品(5, mainTargetName, 15)
                if curID ~= nil and curHP > 0 then
                    选中对象(mainTargetID)
                    延时(1000)
                else
                    break
                end

                waitTime = waitTime + 1
            end
        end
        延时(200)
    end
end

-- main ---------------------------------------------
main()


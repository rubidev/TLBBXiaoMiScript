--目标名字关键字 = ''
目标名字关键字 = "義戰|至尊|君临|异界侠士"

--目标门派 = ''
目标门派 = '武当|桃花岛|唐门'

杀死敌人秒数 = 3

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
    local x1 = 获取人物信息(7)
    local y1 = 获取人物信息(8)

    local nearPlayerStr = 获取周围玩家(白名单, x1, y1, 15)

    --屏幕提示(nearPlayerStr)
	if nearPlayerStr == nil or nearPlayerStr == '' then
        return -1
    end

    local nearPlayerList = StringSplit(nearPlayerStr, '|')

    local IDList = {}
    for index, nearPlayerName in pairs(nearPlayerList) do

        if 目标名字关键字 ~= nil and 目标名字关键字 ~= '' then
			local specialNameList = StringSplit(目标名字关键字, '|')
			-- 1. 过滤目标名字
			for _, specialName in pairs(specialNameList) do
				if string.find(nearPlayerName, specialName) then
					local pName, pID, posX, posY, HP, distance, pType, owner, 怪物判断, hedeTitle = 遍历周围物品(5, nearPlayerName, 15)
					if pID > 0 then
						--屏幕提示(pName .. '|' .. pID)
						table.insert(IDList, pID)
					end
				end
			end
        else
            local pName, pID, posX, posY, HP, distance, pType, owner, 怪物判断, hedeTitle = 遍历周围物品(5, nearPlayerName, 15)
            if pID > 0 then
                --屏幕提示(pName .. '|' .. pID)
                table.insert(IDList, pID)
            end
        end
    end
	--屏幕提示(#IDList)
	--屏幕提示('-------------------------------------')

    local minHP = -1
    local minHPPlayerID = -1
	local minHPPlayerName = -1
	--屏幕提示(目标门派)
    for _, playerID in pairs(IDList) do
        local tmp = LUA_取返回值(string.format([[
			local needMenPaiList = "%s"
			local playerID = %d
			local minHP = %.14f
			local minHPPlayerID = %d
			local minHPPlayerName = "%s"
			--PushDebugMessage(minHP)

			isFriendly = false

			function isNeedMenPai()
			    -- 2. 过滤门派
			    if needMenPaiList == nil or needMenPaiList == '' then
			        return true
			    end

				local nMenpaiID = Target:GetMenPai();

				if nMenpaiID ~= nil then
					local menpaiID = tonumber(nMenpaiID)

					if menpaiID == 0 then
						memPaiName = '少林'
					elseif menpaiID == 1 then
						memPaiName = '明教'
					elseif menpaiID == 2 then
						memPaiName = '丐帮'
					elseif menpaiID == 3 then
						memPaiName = '武当'
					elseif menpaiID == 4 then
						memPaiName = '峨嵋'
					elseif menpaiID == 5 then
						memPaiName = '星宿'
					elseif menpaiID == 6 then
						memPaiName = '天龙'
					elseif menpaiID == 7 then
						memPaiName = '天山'
					elseif menpaiID == 8 then
						memPaiName = '逍遥'
					elseif menpaiID == 9 then
						memPaiName = '无门派'
					elseif menpaiID == 10 then
						memPaiName = '慕容';
					elseif menpaiID == 11 then
						memPaiName = '唐门'
					elseif menpaiID == 12 then
						memPaiName = '鬼谷'
					elseif menpaiID == 13 then
						memPaiName = '桃花岛'
					elseif menpaiID == 14 then
						memPaiName = '绝情谷'
					end
                else
                    return true
				end

				--PushDebugMessage('他的门派' .. memPaiName)
				--PushDebugMessage(needMenPaiList)

				if string.find(needMenPaiList, memPaiName) then
					flag = true
				else
					flag = false
				end
				return flag
			end


			function JudgeTargetBuff()
			    -- 3. 过滤无敌、放大状态
				local TARGET_BUFF_MAX = 6;
				local TARGET_IMPACT_NUM = 20; --查询时要从20个里面选出优先级最高的6个

				local nBuffNum = Target:GetBuffNumber();
				--PushDebugMessage('他有buffer数量：' .. nBuffNum)

				local nFindNum = nBuffNum --在修正nBuffNum之前获得它的值
				if(nFindNum > TARGET_IMPACT_NUM) then nFindNum = TARGET_IMPACT_NUM; end
				if(nBuffNum > TARGET_BUFF_MAX) then nBuffNum = TARGET_BUFF_MAX; end

				local tmp = -1
				for jj = 1, nFindNum do
					szIconName,szTipInfo = Target:GetBuffIconNameByIndex(jj-1);
					--PushDebugMessage(szTipInfo)

					if string.find(szTipInfo, '传送保护') then
						tmp = 0
						PushDebugMessage("目标在卡无敌")
						return tmp
					end
					if string.find(szTipInfo, '所受伤害放大') then
						tmp = 1
						PushDebugMessage("目标被放大")
						return tmp
					end
				end

				return tmp
			end


			ret = SetMainTargetFromList(playerID ,isFriendly, false)
			--PushDebugMessage('设置目标结果: ' .. tostring(ret))
			if ret == 1 then
				local targetName = Target:GetName();
                local memPaiSatisfied = isNeedMenPai()
                if memPaiSatisfied then
                    local buffStatus = JudgeTargetBuff()  -- 0: 卡无敌状态， 1: 被放大， -1: 普通状态
                    if buffStatus ~= 0 then
                        if buffStatus == 1 then
                            return 'fangda' .. playerID .. '|' .. targetName
                        end

                        -- 4. 过滤血量
                        local RaidHP = Target:GetHPPercent();
						--PushDebugMessage(RaidHP)
                        if minHP == -1 then
                            minHP = RaidHP
                            minHPPlayerID = playerID
							minHPPlayerName = Target:GetName();
                        elseif RaidHP < minHP then
							--PushDebugMessage(11111111111111111111111111)
                            minHP = RaidHP
                            minHPPlayerID = playerID
							minHPPlayerName = Target:GetName();
                        end

                    end
                end

			end

            return_ret = tostring(minHPPlayerID) .. '|' .. minHPPlayerName .. '|' .. tostring(minHP)
			--PushDebugMessage(return_ret)
            return return_ret

		]], 目标门派, tonumber(playerID), minHP, minHPPlayerID, minHPPlayerName))

		local retList = StringSplit(tmp, '|')
        if retList[1] == 'fangda' then
			local targetName = retList[2]
            return playerID, targetName
        else
            minHPPlayerID = tonumber(retList[1])
			minHPPlayerName = retList[2]
            minHP = tonumber(retList[3])
        end
		--延时(5)

    end
	--屏幕提示("血： ".. minHP)
	--选中对象(minHPPlayerID)
    return minHPPlayerID, minHPPlayerName
end

function main()


    while true do
        local mainTargetID, mainTargetName = SearchMinHPTarget(目标名字关键字, 目标门派)


        if mainTargetID ~= -1 then
		    屏幕提示(mainTargetID .. mainTargetName)
            选中对象(mainTargetID)

            local waitTime = 0
            while true do
                if waitTime >= 杀死敌人秒数 then
                    MentalTip(string.format([[%d秒仍未击杀, 切换到下一个目标]], 杀死敌人秒数))
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
		else
			--屏幕提示(tonumber(os.date("%S", os.time())))
		    延时(2000)
        end
        延时(200)
    end
end

-- main ---------------------------------------------
main()

--Ŀ�����ֹؼ��� = ''
Ŀ�����ֹؼ��� = "�x��|����|����|�����ʿ"

--Ŀ������ = ''
Ŀ������ = '�䵱|�һ���|����'

ɱ���������� = 3

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."����ҹ��Ʒ,���Ǿ�Ʒ��".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function StringSplit(str, reps)
    -- �ַ����и�
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function SearchMinHPTarget(filterTargetList, memPaiList)
    local x1 = ��ȡ������Ϣ(7)
    local y1 = ��ȡ������Ϣ(8)

    local nearPlayerStr = ��ȡ��Χ���(������, x1, y1, 15)

    --��Ļ��ʾ(nearPlayerStr)
	if nearPlayerStr == nil or nearPlayerStr == '' then
        return -1
    end

    local nearPlayerList = StringSplit(nearPlayerStr, '|')

    local IDList = {}
    for index, nearPlayerName in pairs(nearPlayerList) do

        if Ŀ�����ֹؼ��� ~= nil and Ŀ�����ֹؼ��� ~= '' then
			local specialNameList = StringSplit(Ŀ�����ֹؼ���, '|')
			-- 1. ����Ŀ������
			for _, specialName in pairs(specialNameList) do
				if string.find(nearPlayerName, specialName) then
					local pName, pID, posX, posY, HP, distance, pType, owner, �����ж�, hedeTitle = ������Χ��Ʒ(5, nearPlayerName, 15)
					if pID > 0 then
						--��Ļ��ʾ(pName .. '|' .. pID)
						table.insert(IDList, pID)
					end
				end
			end
        else
            local pName, pID, posX, posY, HP, distance, pType, owner, �����ж�, hedeTitle = ������Χ��Ʒ(5, nearPlayerName, 15)
            if pID > 0 then
                --��Ļ��ʾ(pName .. '|' .. pID)
                table.insert(IDList, pID)
            end
        end
    end
	--��Ļ��ʾ(#IDList)
	--��Ļ��ʾ('-------------------------------------')

    local minHP = -1
    local minHPPlayerID = -1
	local minHPPlayerName = -1
	--��Ļ��ʾ(Ŀ������)
    for _, playerID in pairs(IDList) do
        local tmp = LUA_ȡ����ֵ(string.format([[
			local needMenPaiList = "%s"
			local playerID = %d
			local minHP = %.14f
			local minHPPlayerID = %d
			local minHPPlayerName = "%s"
			--PushDebugMessage(minHP)

			isFriendly = false

			function isNeedMenPai()
			    -- 2. ��������
			    if needMenPaiList == nil or needMenPaiList == '' then
			        return true
			    end

				local nMenpaiID = Target:GetMenPai();

				if nMenpaiID ~= nil then
					local menpaiID = tonumber(nMenpaiID)

					if menpaiID == 0 then
						memPaiName = '����'
					elseif menpaiID == 1 then
						memPaiName = '����'
					elseif menpaiID == 2 then
						memPaiName = 'ؤ��'
					elseif menpaiID == 3 then
						memPaiName = '�䵱'
					elseif menpaiID == 4 then
						memPaiName = '����'
					elseif menpaiID == 5 then
						memPaiName = '����'
					elseif menpaiID == 6 then
						memPaiName = '����'
					elseif menpaiID == 7 then
						memPaiName = '��ɽ'
					elseif menpaiID == 8 then
						memPaiName = '��ң'
					elseif menpaiID == 9 then
						memPaiName = '������'
					elseif menpaiID == 10 then
						memPaiName = 'Ľ��';
					elseif menpaiID == 11 then
						memPaiName = '����'
					elseif menpaiID == 12 then
						memPaiName = '���'
					elseif menpaiID == 13 then
						memPaiName = '�һ���'
					elseif menpaiID == 14 then
						memPaiName = '�����'
					end
                else
                    return true
				end

				--PushDebugMessage('��������' .. memPaiName)
				--PushDebugMessage(needMenPaiList)

				if string.find(needMenPaiList, memPaiName) then
					flag = true
				else
					flag = false
				end
				return flag
			end


			function JudgeTargetBuff()
			    -- 3. �����޵С��Ŵ�״̬
				local TARGET_BUFF_MAX = 6;
				local TARGET_IMPACT_NUM = 20; --��ѯʱҪ��20������ѡ�����ȼ���ߵ�6��

				local nBuffNum = Target:GetBuffNumber();
				--PushDebugMessage('����buffer������' .. nBuffNum)

				local nFindNum = nBuffNum --������nBuffNum֮ǰ�������ֵ
				if(nFindNum > TARGET_IMPACT_NUM) then nFindNum = TARGET_IMPACT_NUM; end
				if(nBuffNum > TARGET_BUFF_MAX) then nBuffNum = TARGET_BUFF_MAX; end

				local tmp = -1
				for jj = 1, nFindNum do
					szIconName,szTipInfo = Target:GetBuffIconNameByIndex(jj-1);
					--PushDebugMessage(szTipInfo)

					if string.find(szTipInfo, '���ͱ���') then
						tmp = 0
						PushDebugMessage("Ŀ���ڿ��޵�")
						return tmp
					end
					if string.find(szTipInfo, '�����˺��Ŵ�') then
						tmp = 1
						PushDebugMessage("Ŀ�걻�Ŵ�")
						return tmp
					end
				end

				return tmp
			end


			ret = SetMainTargetFromList(playerID ,isFriendly, false)
			--PushDebugMessage('����Ŀ����: ' .. tostring(ret))
			if ret == 1 then
				local targetName = Target:GetName();
                local memPaiSatisfied = isNeedMenPai()
                if memPaiSatisfied then
                    local buffStatus = JudgeTargetBuff()  -- 0: ���޵�״̬�� 1: ���Ŵ� -1: ��ͨ״̬
                    if buffStatus ~= 0 then
                        if buffStatus == 1 then
                            return 'fangda' .. playerID .. '|' .. targetName
                        end

                        -- 4. ����Ѫ��
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

		]], Ŀ������, tonumber(playerID), minHP, minHPPlayerID, minHPPlayerName))

		local retList = StringSplit(tmp, '|')
        if retList[1] == 'fangda' then
			local targetName = retList[2]
            return playerID, targetName
        else
            minHPPlayerID = tonumber(retList[1])
			minHPPlayerName = retList[2]
            minHP = tonumber(retList[3])
        end
		--��ʱ(5)

    end
	--��Ļ��ʾ("Ѫ�� ".. minHP)
	--ѡ�ж���(minHPPlayerID)
    return minHPPlayerID, minHPPlayerName
end

function main()


    while true do
        local mainTargetID, mainTargetName = SearchMinHPTarget(Ŀ�����ֹؼ���, Ŀ������)


        if mainTargetID ~= -1 then
		    ��Ļ��ʾ(mainTargetID .. mainTargetName)
            ѡ�ж���(mainTargetID)

            local waitTime = 0
            while true do
                if waitTime >= ɱ���������� then
                    MentalTip(string.format([[%d����δ��ɱ, �л�����һ��Ŀ��]], ɱ����������))
                    break
                end

				local name, curID, x, y, curHP, tDistance, tType, tOwner, tJudge, tTitle = ������Χ��Ʒ(5, mainTargetName, 15)
                if curID ~= nil and curHP > 0 then
                    ѡ�ж���(mainTargetID)
                    ��ʱ(1000)
                else
                    break
                end

                waitTime = waitTime + 1
            end
		else
			--��Ļ��ʾ(tonumber(os.date("%S", os.time())))
		    ��ʱ(2000)
        end
        ��ʱ(200)
    end
end

-- main ---------------------------------------------
main()

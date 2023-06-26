信任角色 = "′云．|′尘．|′霜．|′雪．|′星．|′露．"  -- 信任角色名，用 | 间隔

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
    string.gsub(str,'[^'..reps..']+',
		function ( w )
			table.insert(resultStrList, w)
		end
	)
    return resultStrList
end

function GetTrustFriendCount()
	local trustFriendCount = LUA_取返回值([[
		local trustFriendNumber = DataPool : GetTrustFriendNumber( );
		return trustFriendNumber
	]])
	return tonumber(trustFriendCount)
end

function AddTrustFriend(friendId)
	LUA_Call(string.format([[
		local guid = "%s"
		DataPool : AddTrustFriend( guid );
	]], friendId))
end

function GetTrustFriendName(nIndex)
	local trustFriendName = LUA_取返回值(string.format([[
		local index = %d
		local name = DataPool : GetTrustFriend( index, "NAME" )
		return name
	]], nIndex))
	return trustFriendName
end

function GetTrustFriendGuid(nIndex)
	local trustFriendGuidStr = LUA_取返回值(string.format([[
		local nIndex = %d
		local guid = DataPool : GetTrustFriend( nIndex, "GUID" );
		return guid
	]], nIndex))
	local trustFriendGuid = string.sub(trustFriendGuidStr, 3)
	return trustFriendGuidStr
end

function HasRoleExistTrust(curFriendId)
	local nowTrustFriCount = GetTrustFriendCount()
	if nowTrustFriCount >= 10 then
		return -1
	end

	local index = 0
	while index < nowTrustFriCount do
		local truFriendGuid = GetTrustFriendGuid(index)
		if truFriendGuid == curFriendId then
			return -2
		end
		index = index + 1
	end
	return 1
end

function GetFriendID(roleName)
    local tem = LUA_取返回值(string.format([[
		name2 ="%s"
		XXX=1
		for nIndex = 0, 80 do
			local ID = DataPool:GetFriend( XXX, nIndex, "ID" );
			if ID then
				local name = DataPool:GetFriend( XXX, nIndex, "NAME")
				if name2 == name then
				  return ID
				end
			end
		end
		return -1
		]], roleName), "b")
    return tem
end

function main()
	local myName = 获取人物信息(12)
	local needAddRole = StringSplit(信任角色, "|")
	for i= 1, #needAddRole do
		local roleName = needAddRole[i]
		if roleName ~= myName then
			local curFriendId = GetFriendID(roleName)
			local checkExist = HasRoleExistTrust(curFriendId)
			if checkExist == -1 then
				MentalTip("您的信任角色已打上限, 无法继续添加")
				return
			elseif checkExist == -2 then
				MentalTip(string.format("【%s】已存在于信任列表, 跳过", roleName))
			elseif checkExist == 1 then
				if curFriendId ~= "-1" then
					AddTrustFriend(curFriendId)
					MentalTip(string.format("添加信任【%s】成功", roleName))
				else
					MentalTip(string.format("【%s】不是您的好友, 无法添加信任, 跳过", roleName))
				end
			end
		end
		延时(1000)  -- 只能延长时间，否则回导致添加失败
	end
end

-- ----------------------------------- Main -----------------------------------------------
main()
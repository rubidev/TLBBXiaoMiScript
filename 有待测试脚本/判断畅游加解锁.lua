

function judgeProtectTime()
	local judgeRet = LUA_取返回值([[
		if (tonumber(DataPool:GetLeftProtectTime()) > 0) then
			return 0
		end
		return 1
	]])
	return tonumber(judgeRet)
end





while true do
	if judgeProtectTime() == 1 then
		延时(2000)
	end
end

while true do
	if tonumber(判断通过安全验证()) == 1 then
		break
	end
	延时(10000)
end
g_摆摊位置 = { 80, 55 }

g_主页 = 0    --0物品 1宝宝

g_出售物品 = {
    ["润魂石·暴（1级）"] = 0.7,
    ["润魂石·破（1级）"] = 0.7,
    ["魂冰珠（3级）"] = 70,
    ["变异老虎"] = 500,
}



LUA_取返回值("StallSale:CloseStall('cancel');")	延时(1000)

local str = ""
for k,v in pairs(g_出售物品) do
	str = str .. k .. "|"
end
取出物品(str)
跨图寻路("钱庄",g_摆摊位置[1],g_摆摊位置[2])	延时(1000)

--摆摊
while 窗口是否出现("StallSale")==0 do
	坐骑_下坐骑()
	LUA_取返回值("PlayerPackage:OpenStallSaleFrame();StallSale:AgreeBeginStall();")	延时(1000)
end

--主页面
LUA_取返回值("StallSale:SetDefaultPage("..g_主页..")")	延时(1000)

--上架物品
for k,v in pairs(g_出售物品) do
	local name = k
	local money = v
	for i=0,199 do
		local ret = LUA_取返回值(string.format([[
			local i = %d
			setmetatable(_G, {__index = Packet_Env});
			local theAction = EnumAction(i, "packageitem");
			local id = theAction:GetID();
			if id~=0 then
				if theAction:GetName()=="%s" then
					Packet_Space_Line10_Row10_button:SetActionItem(id);
					Packet_Space_Line10_Row10_button:DoAction();
					return 1
				end
			end
		]],i,name))
		if ret=="1" then
			延时(1000)
			LUA_取返回值(string.format([[
				local theAction = EnumAction(%d, "packageitem");
				local id = theAction:GetID();
				if id~=0 then
					local num = theAction:GetNum();
					local name = theAction:GetName();
					local money = %s * num
					if money<1 then money=1 end
					PushDebugMessage("物品["..name.."]"..num.."个 "..tostring(money))
					StallSale:ReferItemPrice(money);
					setmetatable(_G, {__index = InputYuanbao_Env});this:Hide();
					setmetatable(_G, {__index = MessageBox_Self_Env});this:Hide();
				end
			]],i,money))
		end
	end

	local ret = LUA_取返回值(string.format([[
		local idx = -1
		for i=0,9 do
			local szPetName,szOn = Pet:GetPetList_Appoint(i);
			if szPetName~="" then
				idx = idx + 1
			end
			if PlayerPackage:IsPetLock(i)~=1 and szPetName=="%s" then
				PushDebugMessage("珍兽["..szPetName.."] "..%s)
				Exchange:AddPet(idx);
				return 1
			end
		end
	]],name,money))
	if ret=="1" then
		延时(1000)
		LUA_取返回值(string.format([[
			StallSale:PetUpStall(%s);
			setmetatable(_G, {__index = InputYuanbao_Env});this:Hide();
			setmetatable(_G, {__index = MessageBox_Self_Env});this:Hide();
		]],money))
	end

end

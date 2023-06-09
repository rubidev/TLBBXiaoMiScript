老板号 = "浅尝辄止′"

local lua = LUA_取返回值

local function 刷新()
    -- -1结束  0继续刷新 1-4买紫金石
    --打开界面
    if lua("return tostring(IsWindowShow('Token_Shop'))") == "false" then
        lua([[
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("OnOpenShop")
				Set_XSCRIPT_ScriptID( 892921 )
			Send_XSCRIPT()
		]])
        延时(1000)
    end
    local ret3 = lua([[
		setmetatable(_G, {__index = Token_Shop_Env});
		local buyList = {
			[1] = Token_Shop_Yuanbao1_Icon_Mask,
			[2] = Token_Shop_Yuanbao2_Icon_Mask,
			[3] = Token_Shop_Yuanbao3_Icon_Mask,
			[4] = Token_Shop_Yuanbao4_Icon_Mask,
		}
		for i=1,4 do
			local theAction = EnumAction(i-1, "xiguashop_item");
			if theAction:GetID()~=0 then
				local name = theAction:GetName()
				if name=="紫金石" then
					if buyList[i]:IsVisible()==false then
						return i
					end
				--elseif string.find(name,"时装") then
				--	return -1
				--elseif string.find(name,"破天门") then
				--	return -1
				end
			end
		end
		return 0
	]])
    if tonumber(ret3) ~= 0 then
        return tonumber(ret3)
    end

    local ret = tonumber(lua([[
		setmetatable(_G, {__index = Token_Shop_Env});
		local str = Token_Shop_Remain2_Text:GetText()	--"?拥有金玉环：鐞70"
		local _,int = string.find(str,"鐞")
		local DB = tonumber(string.sub(str,int+1,string.len(str)))
		if DB<2 then
			return -1
		else
			Clear_XSCRIPT();
				Set_XSCRIPT_Function_Name('OnRefreshShopItem');
				Set_XSCRIPT_ScriptID(892921);
				Set_XSCRIPT_Parameter(0,1);
				Set_XSCRIPT_Parameter(1,0);
				Set_XSCRIPT_ParamCount(2);
			Send_XSCRIPT();
			return 0
		end
	]]))
    延时(1000)
    if ret == 0 then
        local ret2 = lua([[
			setmetatable(_G, {__index = Token_Shop_Env});
			local buyList = {
				[1] = Token_Shop_Yuanbao1_Icon_Mask,
				[2] = Token_Shop_Yuanbao2_Icon_Mask,
				[3] = Token_Shop_Yuanbao3_Icon_Mask,
				[4] = Token_Shop_Yuanbao4_Icon_Mask,
			}
			for i=1,4 do
				local theAction = EnumAction(i-1, "xiguashop_item");
				if theAction:GetID()~=0 then
					local name = theAction:GetName()
					if name=="紫金石" then
						if buyList[i]:IsVisible()==false then
							return i
						end
					--elseif string.find(name,"时装") then
					--	return -1
					--elseif string.find(name,"破天门") then
					--	return -1
					end
				end
			end
			return 0
		]])
        return tonumber(ret2)
    else
        return -1
    end
end

local function 购买(idx)
    --打开界面
    if lua("return tostring(IsWindowShow('Token_Shop'))") == "false" then
        lua([[
			Clear_XSCRIPT()
				Set_XSCRIPT_Function_Name("OnOpenShop")
				Set_XSCRIPT_ScriptID( 892921 )
			Send_XSCRIPT()
		]])
        延时(1000)
    end
    lua("setmetatable(_G, {__index = Token_Shop_Env});Token_Shop_YuanbaoBuy(" .. idx .. ")")
    延时(1000)
    lua("setmetatable(_G, {__index = MessageBox_Self2_Env});MessageBox_Self2_Ok_Clicked()")
    延时(1000)
end

local function 交易给老板(i)
    if lua("return Player:GetName()") == 老板号 then
        购买(i)
    elseif tonumber(lua("return Player:GetData('YUANBAO')")) >= 450 then
        购买(i)
    else
        while lua("return tostring(IsWindowShow('Exchange'))") == "false" do
            --要元宝
            跨图寻路("洛阳", 284, 357)
            延时(1000)
            lua("Target:SelectThePlayer('" .. 老板号 .. "')")
            延时(100)
            lua("Exchange:SendExchangeApply();")
            延时(100)
            for o = 1, 10 do
                if lua("return tostring(IsWindowShow('Exchange'))") == "true" then
                    延时(1000)
                    break
                end
                延时(1000)
            end
        end
        while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
            if lua("return tostring(Exchange:IsLocked('other'))") == "true" then
                local Timer = tonumber(lua("setmetatable(_G, {__index = ExchangeSafe_Env});return ExchangeSafe_Watch:GetProperty('Timer');"))
                延时(Timer * 1000 + 500)
                if lua("return tostring(Exchange:IsLocked('self'))") == "false" then
                    lua("setmetatable(_G, {__index = Exchange_Env});Exchange_Lock_Button_Clicked()")
                    延时(1500)
                end
                if lua("return tostring(Exchange:IsLocked('self'))") == "true" then
                    lua("setmetatable(_G, {__index = Exchange_Env});Trade_Accept_Button_Clicked()")
                    延时(500)
                end
            end
        end

        while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
            延时(1000)
        end

        while true do
            local ret = lua([[
				local index,BindState = PlayerPackage:FindFirstBindedItemIdxByIDTable(30501036)
				if index~=-1 then
					PlayerPackage:UseItem(index)
					return 1
				end
				return 0
			]])
            if ret == "1" then
                延时(400)
            else
                break
            end
        end

        购买(i)
        延时(1000)

        --接受交易
        while lua("return tostring(IsWindowShow('Exchange'))") == "false" do
            lua([[
				if Exchange:IsStillAnyAppInList() then					
					Exchange:OpenExchangeFrame()
				else
					PushDebugMessage("等待老板号交易我")				
				end					
				setmetatable(_G, {__index = MainMenuBar_Env});					
				if Exchange:IsStillAnyAppInList()==false then					
					MainMenuBar_Stop_Flash_Exchange()				
				end					
			]])
            延时(1000)
        end

        --接到交易
        if lua("return tostring(IsWindowShow('Exchange'))") == "true" then
            延时(1000)
            右键使用物品("紫金石", 2)
            延时(1000)
            while lua("return tostring(IsWindowShow('Exchange'))") == "true" do

                if lua("return tostring(Exchange:IsLocked('self'))") == "false" then
                    local Timer = tonumber(lua("setmetatable(_G, {__index = ExchangeSafe_Env});return ExchangeSafe_Watch:GetProperty('Timer');"))
                    延时(Timer * 1000 + 500)
                    lua("setmetatable(_G, {__index = Exchange_Env});Exchange_Lock_Button_Clicked()")
                    延时(1500)
                elseif lua("return tostring(Exchange:IsLocked('other'))") == "true" then
                    延时(1000)
                    lua("setmetatable(_G, {__index = Exchange_Env});Trade_Accept_Button_Clicked()")
                    break
                end
                延时(1000)
            end
            while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
                延时(100)
            end
        end
    end
end

if tonumber(lua("return DataPool:GetServerDayTime()")) > 20220817 then
    屏幕提示("活动已结束")
    return
end

while true do
    local ret = 刷新()
    if ret == -1 then
        break
    end
    if ret >= 1 and ret <= 4 then
        交易给老板(ret)
    end
end

for i = 1, 5 do
    lua(string.format([[
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name('OnGetTokenShopFanLi');
			Set_XSCRIPT_ScriptID(892921);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
	]], i))
    延时(500)
end

if lua("return Player:GetName()") == 老板号 then
    跨图寻路("钱庄", 66, 66)
    延时(1000)
    for i = 1, 10 do
        lua("Player:YuanBaoToTicket(450)")
        延时(1000)
    end
    跨图寻路("洛阳", 284, 357)
    延时(1000)
    while true do
        local 对方名字 = ""
        --接受交易
        lua([[
			if Exchange:IsStillAnyAppInList() then					
				Exchange:OpenExchangeFrame()				
			end					
			setmetatable(_G, {__index = MainMenuBar_Env});					
			if Exchange:IsStillAnyAppInList()==false then					
				MainMenuBar_Stop_Flash_Exchange()				
			end					
		]])
        延时(1000)

        --接到交易
        if lua("return tostring(IsWindowShow('Exchange'))") == "true" then
            延时(1000)
            对方名字 = lua("return Exchange:GetOthersName()")
            屏幕提示(对方名字)
            延时(1000)
            右键使用物品("元宝票", 1)
            延时(1000)
            while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
                if lua("return tostring(Exchange:IsLocked('self'))") == "false" then
                    local Timer = tonumber(lua("setmetatable(_G, {__index = ExchangeSafe_Env});return ExchangeSafe_Watch:GetProperty('Timer');"))
                    延时(Timer * 1000 + 500)
                    lua("setmetatable(_G, {__index = Exchange_Env});Exchange_Lock_Button_Clicked()")
                    延时(1500)
                elseif lua("return tostring(Exchange:IsLocked('other'))") == "true" then
                    延时(1000)
                    lua("setmetatable(_G, {__index = Exchange_Env});Trade_Accept_Button_Clicked()")
                    break
                else
                    延时(1000)
                end
            end
            while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
                延时(100)
            end
            lua("Target:SelectThePlayer('" .. 对方名字 .. "')")
            延时(100)
            lua("Exchange:SendExchangeApply();")
            延时(100)
            while true do
                延时(1000)
                if lua("return tostring(IsWindowShow('Exchange'))") == "true" then
                    while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
                        if lua("return tostring(Exchange:IsLocked('other'))") == "true" then
                            local Timer = tonumber(lua("setmetatable(_G, {__index = ExchangeSafe_Env});return ExchangeSafe_Watch:GetProperty('Timer');"))
                            延时(Timer * 1000 + 1000)
                            if lua("return tostring(Exchange:IsLocked('self'))") == "false" then
                                lua("setmetatable(_G, {__index = Exchange_Env});Exchange_Lock_Button_Clicked()")
                                延时(1500)
                            end
                            if lua("return tostring(Exchange:IsLocked('self'))") == "true" then
                                lua("setmetatable(_G, {__index = Exchange_Env});Trade_Accept_Button_Clicked()")
                                延时(500)
                            end
                        end
                    end
                    break
                else
                    屏幕提示("等待" .. 对方名字 .. "交易紫金石")
                end
            end

            while lua("return tostring(IsWindowShow('Exchange'))") == "true" do
                延时(1000)
            end
        end
    end
end

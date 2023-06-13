RMB奖励领取 = {		--1是选择左边 2是选择右边
	[0] = 1,
	[1] = 1,
	[2] = 1,
	[3] = 1,
	[4] = 1,
	[5] = 1,
	[6] = 1,
	[7] = 1,
	[8] = 1,
	[9] = 1,
	[10] = 1,
}

RMB自动购买 = false 	--true是自动买 false是不自动买

需要自动使用的物品名称 = {
	"真元精珀",
	"醒目酒",
	"且试新茶囊",
	"线索卷",
	"橙色真元符集",
	"玄机药尘",
	"武约心决繁盒",
}

local function 打开界面()
    local ret = LUA_取返回值([[
		if IsWindowShow('Fuli_ZhanLing2') then
			return 0
		else
			OpenZhanLing(1)
			return 1
		end
	]])
    if ret == "1" then
        延时(1000)
    end
end
local function 是否激活RMB()
    local ret = LUA_取返回值([[
		setmetatable(_G, {__index = Fuli_ZhanLing2_Env});
		return tostring(Fuli_ZhanLing2_ArouseButton__auto_0__:IsVisible())
	]])
    return ret == "false"
end

local function 激活()
    if 是否激活RMB() then
        return
    end
    --激活
    LUA_取返回值([[
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name( "AskActRMBReward" )
			Set_XSCRIPT_ScriptID(790029)
			Set_XSCRIPT_Parameter(0, 1)
			Set_XSCRIPT_ParamCount(1)
		Send_XSCRIPT()
	]])
    延时(1000)
end

local function 购买菩提心经()
    取出物品("菩提心经折扣券|菩提心经")
    if 获取背包物品数量("菩提心经") == 0 then
        local ret = LUA_取返回值([[	--使用折扣券
			local index,BindState = PlayerPackage:FindFirstBindedItemIdxByIDTable(38004812)
			if index~=-1 then
				Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name("OnBuy")
					Set_XSCRIPT_ScriptID(790035)
					Set_XSCRIPT_Parameter(0, index)
					Set_XSCRIPT_Parameter(1, 1)
					Set_XSCRIPT_ParamCount(2)
				Send_XSCRIPT()
				return 1
			end
			PushDebugMessage("没有菩提心经折扣券 直接购买")
			return -1
		]])
        延时(1000)

        if ret ~= "1" then
            --使用折扣券失败 元宝店购买
            LUA_取返回值("UpdateShopItem(4,3)")
            延时(1000)
            LUA_取返回值([[
				for i=0,GetActionNum("boothitem") do
					local theAction = EnumAction(i, "boothitem");
					if theAction:GetID()~=0 then
						local name = theAction:GetName()
						if name=="菩提心经" then
							NpcShop:BulkBuyItem(i,1,0);
							return
						end
					end
				end
			]])
            延时(1000)
        end
    end
end

local function 领取奖励()
    for i = 0, 10 do
        打开界面()
        local ret1 = LUA_取返回值(string.format([[
			setmetatable(_G, {__index = Fuli_ZhanLing2_Env});
			if Fuli_ZhanLing2_Reward_BasicGetButton__auto_%d__:IsVisible() then
				Clear_XSCRIPT()
					Set_XSCRIPT_Function_Name("AskGetReward")  --脚本接口
					Set_XSCRIPT_ScriptID(790029) --脚本编号
					Set_XSCRIPT_Parameter(0,%d)	--序号
					Set_XSCRIPT_Parameter(1,0) 	--0免费 1付费
					Set_XSCRIPT_Parameter(2,0)	--选择1或者2
					Set_XSCRIPT_ParamCount(3)
				Send_XSCRIPT()
				return 1
			end
		]], i, i + 1))
        if ret1 == "1" then
            延时(500)
        end
        if RMB奖励领取[i] == 1 or RMB奖励领取[i] == 2 then
            local ret2 = LUA_取返回值(string.format([[
				setmetatable(_G, {__index = Fuli_ZhanLing2_Env});
				if Fuli_ZhanLing2_Reward_AdvancedGetButton__auto_%d__:IsVisible() then
					Clear_XSCRIPT()
						Set_XSCRIPT_Function_Name("AskGetReward")  --脚本接口
						Set_XSCRIPT_ScriptID(790029) --脚本编号
						Set_XSCRIPT_Parameter(0,%d)	--序号
						Set_XSCRIPT_Parameter(1,1) 	--0免费 1付费
						Set_XSCRIPT_Parameter(2,%d)	--选择1或者2
						Set_XSCRIPT_ParamCount(3)
					Send_XSCRIPT()
					return 1
				end
			]], i, i + 1, RMB奖励领取[i]))
            if ret2 == "1" then
                延时(500)
            end
        end
    end
    屏幕提示("微信TL7665：奖励领取完毕")
end
local function 使用物品()
    for i = 1, #需要自动使用的物品名称 do
        local 物品名 = 需要自动使用的物品名称[i]
        for o = 1, 获取背包物品数量(物品名) do
            右键使用物品(物品名)
            延时(300)
            LUA_取返回值("setmetatable(_G, {__index = Item_MultiUse_Env});Item_MultiUse_BuyMulti_Clicked()")

            if 获取背包物品数量(物品名) == 0 then
                break
            end
        end
    end
    屏幕提示("微信TL7665：使用需要自动使用的物品完毕")
end

打开界面()
if 是否激活RMB() == false then
    取出物品("菩提心经折扣券|菩提心经")
    if RMB自动购买 and 获取背包物品数量("菩提心经") == 0 then
        屏幕提示("没有菩提心经, 当前设置为自动购买")
        购买菩提心经()
    end
    激活()
end
领取奖励()
使用物品()

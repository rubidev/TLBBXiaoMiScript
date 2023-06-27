购买灵兽金甲礼盒数量 = -1   -- 指定购买数量，-1 表示购买最大数量

function BuyPetEquipPkg(buyMax)
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_Shop2_Env});ActivitySchedule_Shop2_Clicked(11)]])  -- 点击灵兽甲礼盒
    延时(100)
    if buyMax == -1 then
        LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy2_Env});ActivitySchedule_MBuy2_CalMax();]])  -- 点击最大
        延时(100)
    end
    LUA_Call([[setmetatable(_G, {__index = ActivitySchedule_MBuy2_Env});ActivitySchedule_MBuy2_OK_Clicked();]])  -- 点击购买
end




function GetPKGFirstPetEquipPos()
    -- 获取第一个珍兽装备的位置
    return LUA_取返回值([[
        local petEquipKeyList = {"·怯", "·慎", "·忠", "·狡", "·勇", "·怯", "·怯", }
        local currNum = DataPool:GetBaseBag_RealMaxNum();
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
			local sName = theAction:GetName();
			for k,v in pairs(petEquipKeyList) do
				if string.find(sName, v) ~= nil then
					return i
				end
			end
        end
    ]])
end

function GetPKGPetEquipNum()
    -- 获取背包兽装备的数量
    return LUA_取返回值([[
        local petEquipCount = 0
        local petEquipKeyList = {"·怯", "·慎", "·忠", "·狡", "·勇", "·怯", "·怯", }
        local currNum = DataPool:GetBaseBag_RealMaxNum();
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
			local sName = theAction:GetName();
			for k,v in pairs(petEquipKeyList) do
				if string.find(sName, v) ~= nil then
					petEquipCount = petEquipCount + 1
				end
			end
        end
        return petEquipCount
    ]])
end


function GetBagUnusedUnitCount()
    -- 获取背包道具栏未使用的格子数
    return LUA_取返回值([[
        local currNum = DataPool:GetBaseBag_Num();
        local UnusedCount = 0
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
            if theAction:GetID() == 0 then
                UnusedCount = UnusedCount + 1
            end
        end
        return UnusedCount
    ]])
end


function PetEquipDepart()
    对话NPC("云姗姗")
    延时(500)
    NPC二级对话("珍兽套装拆解")
    延时(1000)

    local firstPetEquipPos = GetPKGFirstPetEquipPos()
    local row = math.floor(tonumber(firstPetEquipPos) / 10)
    local col = math.floor(tonumber(firstPetEquipPos) % 10)
    if col == 0 then
        col = 10
    else
        row = row + 1
    end

    local pkgPetEquipCount = GetPKGPetEquipNum()

    -- 右键添加到拆解界面
    LUA_Call(string.format([[setmetatable(_G, {__index = Packet_Env});Packet_ItemBtnClicked(%d,%d);]], row, col))
    延时(100)

    local departCount = 0
    while departCount < tonumber(pkgPetEquipCount) do
		LUA_Call([[setmetatable(_G, {__index = PetEquipSuitDepart_Env});PetEquipSuitDepart_Buttons_Clicked();]])  -- 点击 套装拆解
		延时(200)
        LUA_Call([[setmetatable(_G, {__index = LoginSelectServerQuest_Env});SelectServerQuest_Bn1Click();]])  -- 点击确定
		departCount = departCount + 1
		延时(200)
    end
    延时(200)
    LUA_Call([[setmetatable(_G, {__index = PetEquipSuitDepart_Env});this:Hide();]])
end


function destroyPkg()
    -- 销毁 没用的灵兽装备
    LUA_Call([[
        local petEquipCount = 0
        local petEquipKeyList = {"灵兽甲", "灵兽面", "灵兽环", "灵兽饰", "灵兽爪", }
        local currNum = DataPool:GetBaseBag_RealMaxNum();
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
			local sName = theAction:GetName();
			for k,v in pairs(petEquipKeyList) do
				if sName == v then
					Clear_XSCRIPT()
                        Set_XSCRIPT_ScriptID( 124 )
                        Set_XSCRIPT_Function_Name( "OnDestroy" )
                        Set_XSCRIPT_Parameter( 0, i )
                        Set_XSCRIPT_ParamCount( 1 )
                    Send_XSCRIPT()
				end
			end
        end
        return petEquipCount
    ]])
end

function UsePetEquipPkgAndDepart()
    -- 边使用边清包
    while true do
		local unusedUnitCount = tonumber(GetBagUnusedUnitCount())
        usePkgCount = math.floor(unusedUnitCount/4)
        if tonumber(获取背包物品数量("灵兽金甲礼盒")) <= 0 then
            break
        end

        for i =1, usePkgCount do
            右键使用物品("灵兽金甲礼盒")
            延时(100)
        end
        延时(1000)
        执行功能("自动清包")
        延时(100)
        PetEquipDepart()
    end

    PetEquipDepart()
end


执行功能("自动清包")
跨图寻路("洛阳", 355, 236)
跨图寻路("洛阳", 355, 236)
延时(1000)
对话NPC("付云伤")
延时(500)
NPC二级对话("云锦行")
延时(1000)
if 购买灵兽金甲礼盒数量 == -1 then
    BuyPetEquipPkg(-1)
else
    for i = 1, 购买灵兽金甲礼盒数量 do
        BuyPetEquipPkg(0)
        延时(100)
    end
end
延时(2000)
跨图寻路("苏州", 354, 268)
延时(1000)
对话NPC("云姗姗")
延时(500)

UsePetEquipPkgAndDepart()

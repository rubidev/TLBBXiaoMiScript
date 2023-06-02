function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetRolePetCount()
    local rolePetCount = LUA_取返回值([[
    return Pet:GetPet_Count()
    ]])

    return rolePetCount
end

function GetNeedYanShouPetCount(rolePetCount)
    -- 附体状态 寿命 < 3W，或寿命等于0
    local count = LUA_取返回值(string.format([[
    local needYSPetCount = 0

    for i=0, %d do
        local petLife = Pet:GetNaturalLife(i);
        if Pet:GetIsPossession(i) then
            if petLife < 30000 then
                needYSPetCount = needYSPetCount + 1
            end
        else
            if petLife == 0 then
                needYSPetCount = needYSPetCount + 1
            end
        end
    end
    return needYSPetCount
    ]], tonumber(rolePetCount) - 1))
    return count
end


function PetYanShou(rolePetCount)
    for i = 0, rolePetCount-1 do
        local isNeedYanShou = LUA_取返回值(string.format([[
		    local petLife = Pet:GetNaturalLife(%d);
            if Pet:GetIsPossession(%d) then
                if petLife < 30000 then
					PushDebugMessage(111111)
                    return 1
                end
            else
                if petLife == 0 then
					PushDebugMessage(2222)
                    return 1
                end
            end
            return 0
        ]], i, i))

        if tonumber(isNeedYanShou) == 1 then
            MentalTip("第" .. tostring(i + 1) .. "只珍兽需要延寿")
			LUA_Call(string.format([[
			    local bagIndex, bindstate = PlayerPackage:FindFirstBindedItemIdxByIDTable( 30606023 )
                if bagIndex == nil or bagIndex < 0 or bindstate == 0 then
                    bagIndex, bindstate = PlayerPackage:FindFirstBindedItemIdxByIDTable( 30606001 )
                    if bagIndex == nil or bagIndex < 0 or bindstate == 0 then
                        bagIndex, bindstate = PlayerPackage:FindFirstBindedItemIdxByIDTable( 30606024 )
                        if bagIndex == nil or bagIndex < 0 or bindstate == 0 then
                            bagIndex, bindstate = PlayerPackage:FindFirstBindedItemIdxByIDTable( 30606002 )
                            if bagIndex == nil or bagIndex < 0 or bindstate == 0 then
                                bagIndex = PlayerPackage:GetBagPosByItemIndex( 30606023 )
                                if bagIndex == nil or bagIndex < 0 then
                                    bagIndex = PlayerPackage:GetBagPosByItemIndex( 30606001 )
                                    if bagIndex == nil or bagIndex < 0 then
                                        bagIndex = PlayerPackage:GetBagPosByItemIndex( 30606024 )
                                        if bagIndex == nil or bagIndex < 0 then
                                            bagIndex = PlayerPackage:GetBagPosByItemIndex( 30606002 )
                                            if bagIndex == nil or bagIndex < 0 then
                                                local hid,lid = Pet:GetGUID(%d);
                                                Clear_XSCRIPT();
                                                Set_XSCRIPT_Function_Name("PetSkillStudy_YanShou");
                                                Set_XSCRIPT_ScriptID(311111);
                                                Set_XSCRIPT_Parameter(0,1);
                                                Set_XSCRIPT_Parameter(1,hid);
                                                Set_XSCRIPT_Parameter(2,lid);
                                                Set_XSCRIPT_ParamCount(3);
                                                Send_XSCRIPT();
                                                return;
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                Pet:SkillStudy_Do(3, %d, bagIndex);
			]], i, i))
        end
		延时(1000)
    end
end

function BuyYanShouDanByYBBind(missCount)
    -- 打开元宝商店，切换到绑定元宝商店，选择珍兽商城，选择珍兽百宝箱，购买珍兽延年丹
    -- 如果缺少的数量大于1，需要循环多次购买或者使用批量购买
    local start = 0
    while start < missCount do
        LUA_Call([[setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();]])  -- 打开YB商店
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(1);]])  -- 切到绑定元宝
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList_Bind(3);]])  -- 切到珍兽商城
        延时(500)

        local queRenGouMaiStatus = LUA_取返回值([[return NpcShop:GetBuyDirectly()]])
        local clicked = false
        if tonumber(queRenGouMaiStatus) == 0 then
            -- 0表示勾选购买确认，会弹出确认框，这里要取消勾选
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
            clicked = true
        end

        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(7);]])  -- 购买延寿丹
        延时(500)
        if clicked then
            -- 购买确认按钮恢复原状
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
        end
        start = start + 1
    end
end

function BuyYanShouDanByHongLi(missCount)
    -- 打开元宝商店，切换到红利商店，选择珍兽商城，选择珍兽百宝箱，购买珍兽延年丹
    -- 如果缺少的数量大于1，需要循环多次购买或者使用批量购买
    local start = 0
    while start < missCount do
        LUA_Call([[setmetatable(_G, {__index = MiniMap_Env});MiniMap_YuanBaoFunc();]])  -- 打开YB商店
        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_ChangeTabIndex(5);]])  -- 切到红利商店
        延时(2000)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_UpdateList(3);]])  -- 切到珍兽商城
        延时(500)

        local queRenGouMaiStatus = LUA_取返回值([[return NpcShop:GetBuyDirectly()]])
        local clicked = false
        if tonumber(queRenGouMaiStatus) == 0 then
            -- 0表示勾选购买确认，会弹出确认框，这里要取消勾选
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
            clicked = true
        end

        延时(500)
        LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_GoodButton_Clicked(5);]])  -- 购买延寿丹
        延时(500)
        if clicked then
            -- 购买确认按钮恢复原状
            LUA_Call([[setmetatable(_G, {__index = YuanbaoShop_Env});YuanbaoShop_querengoumai_Clicked();]])  -- 点击购买确认
        end
        start = start + 1
    end
end

function PrepareYanShouDan(needYSDCount)
    -- 背包有
    -- 绑定元宝购买
    -- 红利购买
    local current_YSDCount = tonumber(获取背包物品数量("珍兽延年丹"))
    if current_YSDCount >= needYSDCount then
        MentalTip("珍兽延年丹数量充足")
        return
    end

    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 数量够了就退出函数
        return
    end

    MentalTip(string.format("一共需要购买%d个珍兽延年丹", missCount))
    local needYBBindAmount = missCount * 20
    local roleHasYBBindAmount = tonumber(获取人物信息(62))
    if roleHasYBBindAmount >= needYBBindAmount then
        -- 角色绑定元宝充足，购买剩下所需延年丹
		MentalTip(string.format("绑定元宝购买%d个珍兽延年丹", missCount))
        BuyYanShouDanByYBBind(missCount)
        return
    else
        -- 角色绑定元宝不足，购买最大数量延年丹
        local buyYSDByYBBindCount = math.floor(roleHasYBBindAmount / 20)
		MentalTip(string.format("绑定元宝购买%d个珍兽延年丹", buyYSDByYBBindCount))
        BuyYanShouDanByYBBind(buyYSDByYBBindCount)
    end

    local current_YSDCount = tonumber(获取背包物品数量("珍兽延年丹"))
    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 清算背包中延年丹数量，数量够了就退出函数
        return
    end

    local roleHongLiAmount = tonumber(获取人物信息(55))
    local needHongLiAmount = missCount * 20
    if roleHongLiAmount >= needHongLiAmount then
        -- 角色红利充足，购买剩下所需延年丹
		MentalTip(string.format("红利购买%d个珍兽延年丹", missCount))
        BuyYanShouDanByHongLi(missCount)
    else
        -- 角色红利不足，购买最大数量延年丹
        local buyYSDByHongLiCount = math.floor(roleHongLiAmount / 20)
		MentalTip(string.format("红利购买%d个珍兽延年丹", buyYSDByHongLiCount))
        BuyYanShouDanByHongLi(buyYSDByHongLiCount)
    end

    local current_YSDCount = tonumber(获取背包物品数量("珍兽延年丹"))
    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 清算背包中延年丹数量，数量够了就退出函数
        return
    else
        MentalTip(string.format("当前仍然缺少【%d】个珍兽延年丹, 请手动处理", missCount))
    end

end

function Main()
    local rolePetCount = GetRolePetCount()
    local needYSDCount = GetNeedYanShouPetCount(rolePetCount)
    PrepareYanShouDan(tonumber(needYSDCount))
    PetYanShou(rolePetCount)
end

-- --------执行-------------
Main()
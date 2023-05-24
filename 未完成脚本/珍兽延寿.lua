是否到仓库中取 = 1

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetRoleMaxPetCount()
    local roleLevel = 获取人物信息(26)
    local maxCount = 0
    if roleLevel < 21 then
        maxCount = 2
    elseif roleLevel < 41 then
        maxCount = 3
    elseif roleLevel < 61 then
        maxCount = 4
    elseif roleLevel < 81 then
        maxCount = 5
    else
        maxCount = 6
    end

    local rolePetExtranumCount = LUA_取返回值([[
    return Player:GetData("PET_EXTRANUM")
    ]])

    maxCount = maxCount + tonumber(rolePetExtranumCount)

    return maxCount
end

function GetNeedYanShouPetCount(rolePetMaxCount)
    local count = LUA_取返回值(string.format([[
    local needYSPetCount = 0
    for i=0, %d do
        if Pet:IsPresent(i) then
            local petLife = Pet:GetNaturalLife(i);
            if petLife < 5000 then
                needYSPetCount = needYSPetCount + 1
            end
    return needYSPetCount
    ]], tonumber(rolePetMaxCount)))
    return count
end

function PetYanShou(rolePetMaxCount)
    LUA_Call(string.format([[
    for i=0, %d do
        if Pet:IsPresent(i) then
            local petLife = Pet:GetNaturalLife(i);
            if petLife < 5000 then
                local hid,lid = Pet:GetGUID(i);
                Clear_XSCRIPT();
                Set_XSCRIPT_Function_Name("PetSkillStudy_YanShou");
                Set_XSCRIPT_ScriptID(311111);
                Set_XSCRIPT_Parameter(0,1);
                Set_XSCRIPT_Parameter(1,hid);
                Set_XSCRIPT_Parameter(2,lid);
                Set_XSCRIPT_ParamCount(3);
                Send_XSCRIPT();
                return
            end]], tonumber(rolePetMaxCount)))
end



function GetYanShouDanByCK()
    -- TODO 仓库中取
    -- 打开仓库， 取出所有珍兽延年丹
    local roleCurMap = 获取人物信息(16)
    local fourMainCity = {'大理', '苏州', '洛阳', '楼兰'}
    local isInMainCity = false
    for i = 1, #fourMainCity do
        if fourMainCity[i] == roleCurMap then
            isInMainCity = true
        end
    end

    if isInMainCity then
        if roleCurMap == '大理' then
            跨图寻路('大理', 123, 456)
            延时(1000)
            对话NPC("王伙计")
        elseif roleCurMap == '苏州' then
            跨图寻路('苏州', 123, 456)
            延时(1000)
            对话NPC("赵伙计")
        elseif roleCurMap == '洛阳' then
            跨图寻路('洛阳', 123, 456)
            延时(1000)
            对话NPC("李伙计")
        else
            跨图寻路('楼兰', 123, 456)
            延时(1000)
            对话NPC("孙伙计")
        end
    else
        执行功能('大理回城')
        延时(1000)
        跨图寻路('大理', 123, 456)
        延时(1000)
        对话NPC("王伙计")
    end
    延时(500)
    NPC二级对话("打开银行")
    if 窗口是否出现("Bank") == 1 then
        LUA_Call("setmetatable(_G, {__index = Bank_Env});Bank_ShowAll_Clicked();")  --变大仓库
    end

    -- TODO 取物品逻辑

end



function BuyYanShouDanByYBBind(missCount)
    -- TODO 绑定元宝购买
    -- 打开元宝商店，切换到绑定元宝商店，选择珍兽商城，选择珍兽百宝箱，购买珍兽延年丹
    -- 如果缺少的数量大于1，需要循环多次购买或者使用批量购买
end



function BuyYanShouDanByHongLi(missCount)
    -- TODO 红利购买
    -- 打开元宝商店，切换到红利商店，选择珍兽商城，选择珍兽百宝箱，购买珍兽延年丹
    -- 如果缺少的数量大于1，需要循环多次购买或者使用批量购买
end



function PrepareYanShouDan(needYSDCount)
    -- TODO
    -- 背包有
    -- 仓库取
    -- 绑定元宝购买
    -- 红利购买
    local current_YSDCount = 获取背包物品位置("珍兽延年丹")
    if current_YSDCount >= needYSDCount then
        MentalTip("珍兽延年丹数量充足")
        return
    end

    -- 1. 仓库拿取延年丹
    if 是否到仓库中取 == 1 then
        GetYanShouDanByCK()
    end

    local current_YSDCount = 获取背包物品位置("珍兽延年丹")
    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 数量够了就退出函数
        return
    end

    local needYBBindAmount = missCount * 20
    local roleHasYBBindAmount = 获取人物信息(62)
    if roleHasYBBindAmount >= needYBBindAmount then
        -- 角色绑定元宝充足，购买剩下所需延年丹
        BuyYanShouDanByYBBind(missCount)
        return
    else
        -- 角色绑定元宝不足，购买最大数量延年丹
        local buyYSDByYBBindCount = math.floor(roleHasYBBindAmount / 20)
        BuyYanShouDanByYBBind(buyYSDByYBBindCount)
    end

    local current_YSDCount = 获取背包物品位置("珍兽延年丹")
    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 清算背包中延年丹数量，数量够了就退出函数
        return
    end

    local roleHongLiAmount = 获取人物信息(55)
    local needHongLiAmount = missCount * 20
    if roleHongLiAmount >= needHongLiAmount then
        -- 角色红利充足，购买剩下所需延年丹
        BuyYanShouDanByHongLi(missCount)
    else
        -- 角色红利不足，购买最大数量延年丹
        local buyYSDByHongLiCount = math.floor(roleHongLiAmount / 20)
        BuyYanShouDanByHongLi(buyYSDByHongLiCount)
    end

    local current_YSDCount = 获取背包物品位置("珍兽延年丹")
    local missCount = needYSDCount - current_YSDCount
    if missCount <= 0 then
        -- 清算背包中延年丹数量，数量够了就退出函数
        return
    else
        MentalTip(string.format("当前仍然缺少【%d】个珍兽延年丹, 请手动处理", missCount))
    end

end

function Main()
    local rolePetMaxCount = GetRoleMaxPetCount()
    local needYSDCount = GetNeedYanShouPetCount(rolePetMaxCount)
    PrepareYanShouDan(needYSDCount)
    PetYanShou(rolePetMaxCount)
end


----------执行-------------
Main()
function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function equipIdentify(equipPos)
    -- 装备资质鉴定
    LUA_Call(string.format([[
        local Identify_Item = %d
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("FinishAdjust");
            Set_XSCRIPT_ScriptID(809261);
            Set_XSCRIPT_Parameter(0,Identify_Item);
            Set_XSCRIPT_ParamCount(1);
        Send_XSCRIPT();
    ]], equipPos))
end

function equipIdentifyTwice(equipPos)
    -- 重新鉴定资质
    -- 查看装备是否绑定
    local EB_FREE_BIND = 0  -- 无绑定限制
    local EB_BINDED = 1  -- 已经绑定
    local EB_GETUP_BIND = 2  -- 拾取绑定
    local EB_EQUIP_BIND = 3  -- 装备绑定
    local equipBindStatus = LUA_取返回值(string.format([[
        local Identify_Item = %d
        local equipBindStatus = PlayerPackage:GetItemBindStatusByIndex(Identify_Item);
        return equipBindStatus
    ]], equipPos))
    if tonumber(equipBindStatus) ~= 1 then
        MentalTip("当前装备不是已绑定装备, 不重新鉴定资质")
        return 1
    end

    -- 查看金刚锉是否绑定
    --local reIdentifyMaterialStatus = LUA_取返回值([[
    --    local Tb_idx = 30008034;  -- 金刚砂id？
    --    local jingangcuo_id = 30008048;  -- 金刚锉id
    --    local index,BindState = PlayerPackage:FindFirstBindedItemIdxByIDTable(tonumber(Tb_idx));
    --    local index2,BindState2 = PlayerPackage:FindFirstBindedItemIdxByIDTable(tonumber(jingangcuo_id));
    --    if(index == -1 and index2 == -1)then
    --        local str = "缺少#{_ITEM"..Tb_idx.."}或#{_ITEM"..jingangcuo_id.."}，或者它们被加锁。";
    --        PushDebugMessage(str);
    --        return -1
    --    end
    --    return 1
    --]])

    local reIdentifyRet = LUA_取返回值(string.format([[
        Identify_Item = %d
        local g_ZiZhiName = {
            [0] = "外攻资质",
            [1] = "外防资质",
            [2] = "内攻资质",
            [3] = "内防资质",
            [4] = "闪避资质",
            [5] = "命中资质",
        }
        local oldType1,oldValue1,oldType2,oldValue2 = DataPool : GetEquipZiZhi(Identify_Item);
        local oldZiZhi = ""
        if oldType1 ~= nil and oldType1 >= 0 then
            oldZiZhi = oldZiZhi .. g_ZiZhiName[oldType1] .. tostring(oldValue1)
        end
        if oldType2 ~= nil and oldType2 >= 0 then
            oldZiZhi = oldZiZhi .. g_ZiZhiName[oldType2] .. tostring(oldValue2)
        end
        PushDebugMessage("原资质: " .. oldZiZhi)

        if oldValue1 == 60 or oldValue2 == 60 then
            return
        end

        -- 重新鉴定
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("FinishReAdjust");
            Set_XSCRIPT_ScriptID(809261);
            Set_XSCRIPT_Parameter(0,Identify_Item);
            Set_XSCRIPT_Parameter(1,nMode);
            Set_XSCRIPT_Parameter(2,tonumber(IdentifyTwice_YuanBaoPay:GetCheck()));  -- 检查是否使用元宝购买
            Set_XSCRIPT_ParamCount(3);
        Send_XSCRIPT();

        -- 鉴定后结果判别并替换
        local str =  DataPool : GetEquipZiZhiRefreshDesc(Identify_Item);
        local type1,value1,type2,value2 = DataPool : GetEquipZiZhiCompare(Identify_Item);

        if oldValue1 < 20 and oldValue2 < 20 then
            if value1 >= 20 or value2 >= 20 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 20 or value2 == 20 then
            if value1 > 20 or value2 > 20 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 30 or value2 == 30 then
            if value1 > 30 or value2 > 30 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 35 or value2 == 35 then
            if value1 > 35 or value2 > 35 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 40 or value2 == 40 then
            if value1 > 40 or value2 > 40 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 45 or value2 == 45 then
            if value1 > 45 or value2 > 45 then
                -- 替换
                Clear_XSCRIPT();
                    Set_XSCRIPT_Function_Name("DoRefreshEquipZiZhi");
                    Set_XSCRIPT_ScriptID(809261);
                    Set_XSCRIPT_Parameter(0,Identify_Item);
                    Set_XSCRIPT_ParamCount(1);
                Send_XSCRIPT();
            end
        elseif oldValue1 == 60 or value2 == 60 then
            return 1
        end
        return -1
    ]], equipPos))  --TODO 测试Identify_Item是否是装备在背包中的位置：获取背包中位置("装备名称") - 1

    return tonumber(reIdentifyRet)
end

-- Main ------------------------------------------------------------------------------------------------------------
装备名字 = "佛语"   -- TODO 每次都需要修改装备名字
MentalTip(string.format("即将重新鉴定装备【%s】", 装备名字))
跨图寻路("苏州", 1, 2)  -- TODO
延时(2000)
对话NPC("欧治于")
延时(500)
NPC二级对话("重新鉴定资质")
延时(1000)
local equipIndex = 获取背包中位置(装备名字) - 1
右键使用物品(装备名字)
延时(1000)
while true do
    local tem = equipIdentifyTwice(equipIndex)
    if tem == 1 then
        break
    end
end
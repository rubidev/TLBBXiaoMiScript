g_bossRole = "樱╭ァ小染"   -- 老板号名字

-- 监控白名单
g_whileList = "′云．|′尘．|′霜．|′雪．|′星．|′露．|花影っ|キ倾城つ|凛凛寒风ヤ|姜姒．|｀折枝〃|﹎尛妹．ゝ|丶喵咪て|ご乘风破浪〆|℡驰骋霸道ゞ|老君|′﹎摆烂ゝ"
g_monitorDistance = 8   -- 监控多少范围内出现非白名单玩家，立刻收摊

g_NeedSaleItem = {
    "润魂石·破（1级）",
    "润魂石·击（1级）",
    "润魂石·暴（1级）",
    "润魂石·御（1级）",
    "破·释玄属性书",
    "破·沉冰属性书",
    "破·嗜毒属性书",
    "破·落炎属性书",
    "暴·穿冰属性书",
    "暴·暗火属性书",
    "暴·拔毒属性书",
    "暴·冲玄属性书",
    "御·参玄属性书",
    "御·疗毒属性书",
    "御·禀火属性书",
    "御·折冰属性书",
    "击·苍玄属性书",
    "击·创毒属性书",
    "击·炽焰属性书",
    "击·寒冰属性书",
    "灵兽丹·风（1级）",
    "灵兽丹·虚（1级）",
    "灵兽丹·震（1级）",
    "灵兽丹·合（1级）",
    "灵兽丹·咒（1级）",
    "真元精珀",
    "真元珀",
    "回天神石",
    "灵兽精魄",
    "金蚕丝",
    "圣兽鳞",
    "神兵符3级",
}
g_StallLocation = { 80, 55 }  -- 钱庄摆摊坐标

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function CancelStall()
    -- 取消摆摊
    LUA_Call("StallSale:CloseStall('cancel');")
end

function ShelfItem()
    --上架物品
    for k, v in pairs(g_NeedSaleItem) do
        local name = k
        local money = v
        for i = 0, 199 do
            local ret = LUA_取返回值(string.format([[
                local i = %d
                setmetatable(_G, {__index = Packet_Env});
                local theAction = EnumAction(i, "packageitem");
                local id = theAction:GetID();
                if id~=0 then
                    if theAction:GetName() == "%s" then
                        Packet_Space_Line10_Row10_button:SetActionItem(id);
                        Packet_Space_Line10_Row10_button:DoAction();
                        return 1
                    end
                end
            ]], i, name))
            if ret == "1" then
                延时(1000)
                LUA_取返回值(string.format([[
                    local theAction = EnumAction(%d, "packageitem");
                    local id = theAction:GetID();
                    if id~=0 then
                        local num = theAction:GetNum();
                        local name = theAction:GetName();
                        local money = 1
                        PushDebugMessage("物品["..name.."]"..num.."个 "..tostring(money))
                        StallSale:ReferItemPrice(money);
                        setmetatable(_G, {__index = InputYuanbao_Env});this:Hide();
                        setmetatable(_G, {__index = MessageBox_Self_Env});this:Hide();
                    end
                ]], i, money))
            end
        end
    end
end

function StallSaleItem()
    -- 摆摊
    while 窗口是否出现("StallSale") == 0 do
        坐骑_下坐骑()
        LUA_取返回值("PlayerPackage:OpenStallSaleFrame();StallSale:AgreeBeginStall();")
        延时(1000)
    end

    --设置主页面
    local mainPage = "0"  -- --0物品 1宝宝
    LUA_取返回值("StallSale:SetDefaultPage(" .. mainPage .. ")")
    延时(1000)

end

function BuyStallItem(roleName, roleID)
    -- 打开摊位
    LUA_Call(string.format([[
        ID =%d
        OpenStallSale(ID)
     ]], roleID), "n");
    延时(3000)

    if 窗口是否出现("StallBuy") then
        MentalTip(string.format("开始购买【%s】的摊位", roleName))
        for i = 0, 19 do
            local tem = LUA_取返回值(string.format([[
                i=%d
                local theAction = EnumAction(i, "st_other");
                g_nCurSelectItemID = theAction:GetID();
                local nItemName = StallBuy:GetItemName(g_nCurSelectItemID);
                local nItemNum  = StallBuy:GetItemNum(g_nCurSelectItemID);
                local nPriceYuanbao = StallBuy:GetPrice("item", i);
                AA=i+1
                if nItemName  then
                    if  tonumber(nPriceYuanbao) == 1 then      ----自己改价格,这是总价: 单价乘以数量的价格
                        --PushDebugMessage(AA..".   物品名称"..nItemName.."数量:"..nItemNum.."单价:"..nPriceYuanbao);
                        StallBuy:BuyItem(g_nCurSelectItemID,i);
                        return 1
                    end
                end
            ]], i), "n");
            if tonumber(tem) ~= 1 then
                延时(2000)
            else
                延时(500)
            end
        end
    end
end

function CheckMySaleItem()
    local ret = LUA_取返回值([[
        for i=0, 19 do
            local theAction = EnumAction(i, "st_self");
            if theAction:GetID() ~= 0 then
                return 1
            end
        end
        return -1
    ]])
    return tonumber(ret)
end

function CheckNeedSaleItem()
    for i = 0, 199 do
        for k, v in pairs(g_NeedSaleItem) do
            local ret = LUA_取返回值(string.format([[
                local theAction = EnumAction(%d, "packageitem");
                local id = theAction:GetID();
                if id~=0 then
                    local name = theAction:GetName();
                    if name = "%s" then
                        return 1
                    end
                end
                return -1
            ]], i, v))
            if tonumber(ret) == 1 then
                return 1
            end
        end
    end
    return -1
end

function main()
    MentalTip(string.format("钱庄(%d, %d)处摆摊交易元宝物品", g_StallLocation[1], g_StallLocation[2]))
    MentalTip(string.format("钱庄(%d, %d)处摆摊交易元宝物品", g_StallLocation[1], g_StallLocation[2]))
    执行功能("自动清包")
    local str = ""
    for k, v in pairs(g_NeedSaleItem) do
        str = str .. v .. "|"
    end

    取出物品(str)
    存物品(str, str, 1, 0, 1)  -- 存入绑定物品
    跨图寻路("钱庄", g_StallLocation[1], g_StallLocation[2])
    延时(1000)
    myName = 获取人物信息(12)

    if g_bossRole ~= myName then
        --摆摊号
        MentalTip("摆摊号开始摆摊")
        while true do
            -- 检测周围玩家
            local ret = 获取周围玩家(g_whileList, g_StallLocation[1], g_StallLocation[2], g_monitorDistance)
            if ret > 0 then
                MentalTip(string.format('%d米范围内出现非白名单玩家, 取消摆摊', g_monitorDistance))
                CancelStall()
                goto continue
            end

            if 窗口是否出现("StallMessage") == 0 then
                StallSaleItem()  -- 开始摆摊
            end

            local checkRet1 = CheckMySaleItem()
            local checkRet2 = CheckNeedSaleItem()
            if checkRet1 == -1 and checkRet2 == 1 then
                -- 当前上架的卖完, 并且背包中还有可以上架物品，继续上架物品
                ShelfItem()  -- 上架物品
            elseif checkRet2 == -1 then
                MentalTip('所有物品已转移完成, 退出摆摊')
                CancelStall()
                延时(1000)
                跨图寻路("洛阳", 330, 299)  -- 转移完成，离开
                break
            end
            :: continue ::
            延时(1000)
        end
    else
        -- 老板号买
        MentalTip("老板号请准备充足的元宝")
        while true do
            local roleName, roleID, _, _, _, _, _, _, _, _ = 遍历周围物品(1, g_whileList, 3)
            if roleID > 0 then
                BuyStallItem(roleName, roleID)
            end
        end
    end
end


-- ------------------------------ MAIN ----------------------------------
main()

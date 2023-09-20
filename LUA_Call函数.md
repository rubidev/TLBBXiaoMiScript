### 1、帮会喊话
```lua
    LUA_Call("setmetatable(_G, {__index = ChatFrame_Env});Talk : SendChatMessage('guild', '" .. 帮派喊话内容 .. "');")
```

### 2、打开帮会界面，缓冲帮会信息
```lua
LUA_Call("setmetatable(_G, {__index = MainMenuBar_Env});MainMenuBar_OnOpenGruidClick();")
延时(3000)
```

### 3、遍历帮派在线人
```lua
BangHuiMembersNum = tonumber(LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetMembersNum(3);"))
for i = 0, BangHuiMembersNum - 1 do
    local guildIdx = tonumber(LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetShowMembersIdx(" .. tostring(i) .. ");"))
    -- 获取在线人中当前人的name
    local szMsg = LUA_取返回值("setmetatable(_G, {__index = NewBangHui_Hygl_Env});return Guild:GetMembersInfo(" .. tostring(guildIdx) .. ", 'Name');")
    LUA_Call("DataPool:AddFriend(0, '" .. szMsg .. "')")   -- 根据名字加好友，放在第一个好友分组
    延时(1000)
end
```

### 4、获取装备位上耐久度
```lua
-- downIndex 取下装备时使用该index
-- equipIndex  装备位的index，获取装备位上装备信息时使用
local SelfEuipList = {
    [1] = { name = "武器", downIndex = 11, equipIndex = 0, equipName = "",
            gem = {
                { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                { "" },
                { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
            }
    }, --- 武器
    [2] = { name = "护腕", downIndex = 3, equipIndex = 14, equipName = "" }, --- 护腕
    [3] = { name = "戒指上", downIndex = 7, equipIndex = 6, equipName = "" }, --- 戒指（上）
    [4] = { name = "戒指下", downIndex = 8, equipIndex = 11, equipName = "" }, --- 戒指（下）
    [5] = { name = "护符上", downIndex = 9, equipIndex = 12, equipName = "" }, --- 护符（上）
    [6] = { name = "护符下", downIndex = 10, equipIndex = 13, equipName = "" }, --- 护符（下）
    [7] = { name = "衣服", downIndex = 12, equipIndex = 2, equipName = "" }, --- 衣服
    [8] = { name = "帽子", downIndex = 1, equipIndex = 1, equipName = "" }, --- 帽子
    [9] = { name = "护肩", downIndex = 2, equipIndex = 15, equipName = "" }, --- 肩膀
    [10] = { name = "手套", downIndex = 4, equipIndex = 3, equipName = "" }, --- 手套
    [11] = { name = "腰带", downIndex = 5, equipIndex = 5, equipName = "" }, --- 腰带
    [12] = { name = "鞋子", downIndex = 6, equipIndex = 4, equipName = "" }, --- 鞋子
    [13] = { name = "项链", downIndex = 13, equipIndex = 7, equipName = "" }, --- 项链
    [14] = { name = "暗器", downIndex = 14, equipIndex = 17, equipName = "",
             gem = {
                 { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                 { "" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
             }
    }, --- 暗器
    [15] = { name = "龙纹", downIndex = 25, equipIndex = 19, equipName = "", gem = { 体力宝石, 属性宝石, 抗性宝石, 属性宝石 }, },
    [16] = { name = "武魂", downIndex = "", equipIndex = 18, equipName = "" }, --- 武魂
    [17] = { name = "令牌", downIndex = 16, equipIndex = 20, equipName = "" }, --- 令牌
    [18] = { name = "豪侠印", downIndex = "", equipIndex = 21, equipName = "",
             gem = {
                 { "红宝石(4级)", "红宝石·红利(4级)", "红宝石(3级)", "红宝石·红利(3级)" },
                 { "" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
                 { "纯净&晶石(4级)", "纯净&晶石·红利(4级)", "纯净&晶石(3级)", "纯净&晶石·红利(3级)" },
             }
    }, --- 令牌
    [19] = { name = "物品包", downIndex = "", equipIndex = 9, equipName = "" },
    [20] = { name = "材料包", downIndex = "", equipIndex = 10, equipName = "" },
}
```

```lua
local tem = LUA_取返回值(string.format([[
    return EnumAction(%d,"equip"):GetEquipDur()
]], equipIndex))   -- 是上面的 equipIndex
```

### 5、获取装备位上装备ID
```lua
local tem = LUA_取返回值(string.format([[
    return EnumAction(%d,"equip"):GetID()
]], equipIndex))   -- 上面的 equipIndex
```

### 6、获取装备位上装备名字
```lua
LUA_取返回值(string.format([[
    return EnumAction(%d,"equip"):GetName()
]], equipIndex))   -- 上面的 equipIndex
```

### 7、获取装备位上装备等级
```lua
LUA_取返回值(string.format([[
    local  index = %d
    local ID = EnumAction(index,"equip"):GetID()
    if ID > 0 then
        return	DataPool:GetEquipLevel(index)  --装备等级 暗器99了
    end
    return -1
]], equipIndex))   -- 上面的 equipIndex
```

### 8、获取背包中装备等级
```lua
local aaa = LUA_取返回值(string.format([[
    return LifeAbility : Get_Equip_Level(%d);
]], index))     -- index是背包中的位置，获取背包物品位置(装备名称) - 1
```

### 9、获取背包装备已打孔的孔数
```lua
背包装备孔数量 = tonumber(LUA_取返回值(string.format([[
    return LifeAbility:GetEquip_HoleCount(%d)
]], index)))      -- index是背包中的位置，获取背包物品位置(装备名称) - 1
```

### 10、背包装备打孔前3个孔
```lua
LUA_Call(string.format([[
    Clear_XSCRIPT()
    Set_XSCRIPT_Function_Name("StilettoEx_3")
    Set_XSCRIPT_ScriptID(311200)
    Set_XSCRIPT_Parameter(0,%d)  --装备位置
    Set_XSCRIPT_Parameter(1,%d)  --材料位置
    Set_XSCRIPT_ParamCount(2)
    Send_XSCRIPT()
]], 序号, nIndex))  -- 序号表示装备在背包中的位置， nIndex表示打孔材料在背包中的位置
```

### 11、背包装备打孔第4个孔
```lua
材料类型 = 2
LUA_Call(string.format([[
    Clear_XSCRIPT()
    Set_XSCRIPT_Function_Name("StilettoEx_4")
    Set_XSCRIPT_ScriptID(311200)
    Set_XSCRIPT_Parameter(0,%d)   --装备位置
    Set_XSCRIPT_Parameter(1,%d)   -- 材料位置
    Set_XSCRIPT_Parameter(2,%d)  -- 四孔使用材料类型, 2 表示寒玉精粹，1 表示 点金之箭
    Set_XSCRIPT_ParamCount(3)
    Send_XSCRIPT()
]], 序号, nIndex, 材料类型))   -- 序号表示装备在背包中的位置， nIndex表示打孔材料在背包中的位置（获取背包物品位置(打孔材料) - 1）, 材料类型
```

### 12、获取背包装备宝石数量
```lua
local tem = LUA_取返回值(string.format([[
    local gemcount = LifeAbility:GetEquip_GemCount(%d)
    if gemcount==nil then
        return 0
    end
    return gemcount
]], bHave))  -- 背包中装备位置： bHave = 获取背包物品位置(装备名称) - 1
```

### 13、获取身上武魂的寿命
```lua
local tem = LUA_取返回值(string.format([[
    local ID =EnumAction(18,"equip"):GetID()
    if ID > 0 then
        tem= DataPool:GetKfsData("LIFE")
        return tem
    end
    return -1
]]))
```

### 14、取下装备放入背包
```lua
-- 1. 普通装备下装备
LUA_Call(string.format([[ 
    setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Equip_Click(%d,0)
]], downIndex))  -- 上面列表中的downIndex


-- 2. 侠印、武魂下装备特别对待
if 装备位置名称 == "豪侠印" then
    LUA_Call("setmetatable(_G, {__index = Xiulian_Env});Xiulian_JueWei_Page_Switch();");
    延时(2000)
    LUA_Call("setmetatable(_G, {__index = SelfJunXian_Env});SelfJunXian_Equip_Clicked(0);");
    延时(2000)
elseif 装备位置名称 == "武魂" then
    LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_Wuhun_Switch();")
    延时(2000)
    LUA_Call("setmetatable(_G, {__index =  Wuhun_Env});Wuhun_Equip_Clicked(0);")
    延时(2000)
end
```




### 15、九州商会搜索购买物品
```lua
-- 1. 打开搜索界面
NPC二级对话("查看所有商店")
延时(1000)
if 窗口是否出现("PS_ShopList") == 1 then
    LUA_Call([[setmetatable(_G, {__index = PS_ShopList_Env}) PS_ShopList_ChangeTabIndex(3)]])
    延时(1000)
end

-- 2. 搜索物品
LUA_Call(string.format([[
     PlayerShop:PacketSend_Search(2 , 2, 1, "%s", %d)		
]], 物品名称, qq))  -- 参数1表示目标商品名称， 参数2（qq）表示第几页
延时(1500)

-- 3. 遍历搜索结果当前页，比较名字、数量、单价是否满足，满足则购买
-- -- 如果需要遍历多页，需在外面使用循环
local tem = LUA_取返回值(string.format([[
    setmetatable(_G, {__index = PS_ShopSearch_Env})
    -- 1页有10条数据，所以遍历10次
    for i = 1 ,10 do
        local theAction = EnumAction( i - 1 , "playershop_cur_page")
        if theAction:GetID() ~= 0 then
            --物品名,店主名,所属商店ID,数量,总价格
            local pName ,pShopName, pShopID ,pCount ,pYB = PlayerShop:GetItemPSInfo( i - 1 )
            if pName ~= nil and pShopID ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
                if pName == "%s" and pCount <= %d and pYB/pCount <= %d then
                   --点击购买后,直接返回
                   PlayerShop:SearchPageBuyItem(i - 1, "item")
                   return true
                end
            end
        end
    end
    return false
]], 名称, 数量, 单价格), "b")
```

### 16、整理背包
```lua
LUA_Call(string.format("PlayerPackage:PackUpPacket(%d);", nTheTabIndex))  -- nTheTabIndex中1表示道具栏，2表示材料栏
```

### 17、宝石雕琢
```lua
local tem = LUA_取返回值(string.format([[
    local g_GemItemPos = %d  -- 背包中宝石位置
    local itemcount = PlayerPackage:GetBagItemNum(g_GemItemPos)
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("OnGemCarve");
        Set_XSCRIPT_ScriptID(800117);
        Set_XSCRIPT_Parameter(0,g_GemItemPos);
        Set_XSCRIPT_Parameter(1,%d);  -- 雕琢材料位置
        Set_XSCRIPT_Parameter(2,135);
        Set_XSCRIPT_Parameter(3, 0);
        Set_XSCRIPT_Parameter(4,itemcount);
        Set_XSCRIPT_ParamCount(5);
    Send_XSCRIPT();
]], LPindex, Needindex), "b")  -- LPindex = 获取背包物品位置(宝石名字) - 1， Needindex = 获取背包物品位置(雕琢材料名字) - 1
```

### 18、红利特惠本周剩余次数
```lua
local aaa = LUA_取返回值(string.format([[
    local nMD = math.mod(DataPool:GetPlayerMission_DataRound(1561),10);
    return nMD 
]]))
```


### 19、装备打宝石
```lua
LUA_Call(string.format([[
		g_EnchaseEx_Gem_pos=%d  -- 背包中宝石位置
		g_EnchaseEx_Equip_pos=%d    -- 背包中装备位置
		g_EnchaseEx_Material_pos=%d  -- 背包中镶嵌符位置
		g_EnchaseEx_Gem_hole=%d  -- 第几个孔打宝石
		if g_EnchaseEx_Gem_hole > 0 and g_EnchaseEx_Gem_hole < 4 then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("EnchaseEx_3")
			Set_XSCRIPT_ScriptID(701614)
			Set_XSCRIPT_Parameter(0,g_EnchaseEx_Gem_pos)  -- 背包中宝石位置
			Set_XSCRIPT_Parameter(1,g_EnchaseEx_Equip_pos)  -- 背包中装备位置
			Set_XSCRIPT_Parameter(2,g_EnchaseEx_Material_pos)  -- 背包中镶嵌符位置
			Set_XSCRIPT_Parameter(3,-1)
			Set_XSCRIPT_Parameter(4,g_EnchaseEx_Gem_hole-1)  -- 第几个孔打宝石
			Set_XSCRIPT_ParamCount(5)
		Send_XSCRIPT()
	elseif g_EnchaseEx_Gem_hole == 4 then
		Clear_XSCRIPT()
			Set_XSCRIPT_Function_Name("EnchaseEx_4")
			Set_XSCRIPT_ScriptID(701614)
			Set_XSCRIPT_Parameter(0,g_EnchaseEx_Gem_pos)
			Set_XSCRIPT_Parameter(1,g_EnchaseEx_Equip_pos)
			Set_XSCRIPT_Parameter(2,g_EnchaseEx_Material_pos)
			Set_XSCRIPT_Parameter(3,-1)
			Set_XSCRIPT_Parameter(4,3)
			Set_XSCRIPT_ParamCount(5)
		Send_XSCRIPT()
	end
]], bIndex, bHave, nIndex, 宝石位置)) -- 参数1：背包中宝石位置  参数2：背包中装备位置  参数3：背包中镶嵌符位置  参数4：第几个孔打宝石
```

### 20、请求帮会信息
**获取帮会信息前，必须要请求一次，否则会无法获取帮会信息**
```lua
LUA_Call("Guild:AskGuildDetailInfo()")
```

### 21、各种窗口汇总
```lua
窗口是否出现("SelfEquip")  -- 装备界面
窗口是否出现("NewBangHui_Bhxx") -- 帮会界面
窗口是否出现("PS_ShopSearch")  -- 九州商会搜索界面
窗口是否出现("PS_ShopList")   -- 九州商会查看所有商店界面
窗口是否出现("MessageBox_Self")  -- 确定、取消的confirm界面
窗口是否出现("YuanbaoShop")   -- 元宝商店界面
窗口是否出现("SelfJunXian")  -- 自身装备的侠印信息界面
窗口是否出现("Wuhun")  -- 自身装备的武魂信息界面
窗口是否出现("EquipLingPai_ShengJie")  -- 令牌升阶界面
窗口是否出现("EquipLingPai_Star")  -- 令牌升星界面
窗口是否出现("EquipLingPai_OperatingSJ")  -- 令牌四象宝珠打造与升级界面
窗口是否出现("YbMarket")   -- 钱庄寄售物品界面
窗口是否出现("EquipStrengthen")  -- 强化升级界面
```

### 22、关闭窗口
```lua
LUA_Call(string.format([[
    setmetatable(_G, {__index = %s_Env}) this:Hide()  
 ]], strWindowName))  -- 窗口名字参考上面
```

### 23、检测装备是否脱下
```lua
-- 返回值"0" 表示已经脱下, > 0表示已装备
LUA_取返回值(string.format([[
    return EnumAction(%d,'equip'):GetID();
]], equipIndex))  -- equipIndex在上面的list中可见
```

### 24、令牌升阶
```lua
-- 升阶点击确定按钮
LUA_Call("setmetatable(_G, {__index = EquipLingPai_ShengJie_Env});EquipLingPai_ShengJie_OnOK();")
```

### 25、令牌宝珠镶嵌
```lua
LPindex=获取背包物品位置(LPname)-1  -- 背包中令牌位置
ZBindex =获取背包物品位置(ZBname)-1  -- 背包中宝珠位置
index = 1 -- 宝珠要镶嵌的位置，即令牌宝珠的4个孔，可选为1、2、3、4
LUA_Call(string.format([[
        Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name( "RL_SetRs" );
        Set_XSCRIPT_ScriptID( 880001 );
        Set_XSCRIPT_Parameter( 0, %d);  
        Set_XSCRIPT_Parameter( 1, %d-1);  
        Set_XSCRIPT_Parameter( 2, %d );         --- 物品背包索引
        Set_XSCRIPT_ParamCount( 3 );
    Send_XSCRIPT();	
]], LPindex,index,ZBindex))
```

### 26_1、令牌宝珠升级-模拟点击
```lua
-- 1. 选择第几颗宝珠
LUA_Call(string.format([[
    setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnActionItemLClicked(%d);
]], BZIndex))  -- BZIndex表示第几颗宝珠，可选1、2、3、4

-- 2. 点击确定升1级
LUA_Call("setmetatable(_G, {__index = EquipLingPai_OperatingSJ_Env});EquipLingPai_OperatingSJ_OnOkClicked();")
```

### 26_2、令牌宝珠升级-调用源码脚本
```lua
LUA_Call(string.format([[	
    local m_EquipBagIndex = %d
    local nIndex = %d
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name( "RsLevelUp_RL" );
        Set_XSCRIPT_ScriptID( 880001 );
        Set_XSCRIPT_Parameter( 0, m_EquipBagIndex );         --- 令牌背包索引
        Set_XSCRIPT_Parameter( 1,nIndex - 1   );        --- 镶嵌的符石索引
        Set_XSCRIPT_ParamCount( 2 );
    Send_XSCRIPT();	
]], 背包中令牌位置, 升级宝珠位置))   -- 参数1：背包中令牌位置  参数2：要升级令牌上的哪颗宝珠（1,2,3,4）
```


### 27_1、令牌升星-模拟点击
```lua
LUA_Call("setmetatable(_G, {__index = EquipLingPai_Star_Env});EquipLingPai_Star_OnOkClicked();")
```

### 27_2、令牌升星-调用源码脚本
```lua
LUA_Call(string.format([[	
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name( "RL_StarLevelup" );
        Set_XSCRIPT_ScriptID( 880001 );
        Set_XSCRIPT_Parameter( 0, %d);         -- 装备背包索引
        Set_XSCRIPT_Parameter( 1, 0);         -- 参数2：0表示不购买，1 自动购买确认
        Set_XSCRIPT_ParamCount( 2 );
    Send_XSCRIPT();		
]], 背包中令牌位置))
```


### 28、背包中令牌某个宝珠的等级
```lua
aaa=  LUA_取返回值(string.format([[ 
    local m_EquipBagIndex = %d
    local nIndex = %d
    local uLevel = PlayerPackage:Lua_GetBagItemRl_RsLevel(m_EquipBagIndex , nIndex - 1)
    return uLevel
]], 令牌序号,宝珠序号))  -- 令牌序号为背包中令牌的位置，宝珠序号为令牌上宝珠的位置(可选项：1,2,3,4)
```

### 28、令牌扩展属性重铸
```lua
for yyy=1,10 do
    LUA_Call(string.format([[
        local resetExAttrTarget = %s
        LPindex=tonumber(%d)
        -- 第一条扩展属性
        local nExAttrID111 , nExAttrStr111 = PlayerPackage:Lua_GetBagRlExAttr(LPindex, 0)
        if string.find(nExAttrStr111, resetExAttrTarget) then
            aaa=1
        else
            aaa=0
        end
        
        -- 第二条扩展属性
        local  nExAttrID222 , nExAttrStr222 = PlayerPackage:Lua_GetBagRlExAttr(LPindex, 1)
        if string.find(nExAttrStr222, resetExAttrTarget) then
            bbb=1
        else
            bbb=0
        end

        -- 第三条扩展属性
        local  nExAttrID333 , nExAttrStr333 = PlayerPackage:Lua_GetBagRlExAttr(LPindex, 2)
        if string.find(nExAttrStr333, resetExAttrTarget) then
            ccc=1
        else
            ccc=0
        end

        PushDebugMessage(aaa..bbb..ccc)

        if aaa+bbb+ccc ==1 then
            PushDebugMessage("已经有1个血上限了需要天荒神石2个")
        elseif  aaa+bbb+ccc ==2 then
            PushDebugMessage("已经有2个血上限了需要天荒神石3个")
        elseif  aaa+bbb+ccc ==3 then
            PushDebugMessage("已经有3个血上限了无需再洗跳出循环")
            return
        end
        
        --开始重铸
        Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("RlResetExAttr");
        Set_XSCRIPT_ScriptID(880001);
        Set_XSCRIPT_Parameter(0,LPindex);
        Set_XSCRIPT_Parameter(1,aaa);
        Set_XSCRIPT_Parameter(2,bbb);
        Set_XSCRIPT_Parameter(3,ccc);
        Set_XSCRIPT_Parameter(4,0);
        Set_XSCRIPT_ParamCount(5);
        Send_XSCRIPT();	
    ]], "maxhp", 背包中令牌位置))  
    -- 参数1： "maxhp" 表示血上限，减抗下限冰火玄毒对应："equip_attr_resistother_cold"、"equip_attr_resistother_fire"、"equip_attr_resistother_light"、"equip_attr_resistother_poison"    
    -- 参数2: 背包中令牌位置：获取背包物品位置(令牌名称)-1
    延时(2000)--增加延时等待服务器响应
end
```

28、获取身上令牌信息
```lua
LUA_取返回值(string.format([[ 
        index = %d
        local nType,BaoZhu1,BaoZhu2,BaoZhu3,BaoZhu4,nQual = DataPool:GetLingPaiInfo()
        --local IconName,ItemName = DataPool:GetLingPaiBaoZhuIconName(1)
        if nType> 0 then
            if index == 1 then
                return BaoZhu1
            end
            if index == 2 then
                return BaoZhu2
            end
            if index == 3 then
                return BaoZhu3
            end
            if index == 4 then
                return BaoZhu4
            end	
            if index == 5 then
                return nQual
            end	
        end
        return -1
]], index))
```

### 29、装备精通淬炼
```lua
local tem =LUA_取返回值(string.format([[
	    local index = tonumber(%d)
		
		local equip_level = LifeAbility : Get_Equip_Level(index);
		if equip_level <80 then
            PushDebugMessage("装备等级不够不能淬炼")
            return 2
		end
		
		local selfMoney = Player:GetData("MONEY") + Player:GetData("MONEY_JZ")
		if selfMoney<50000 then
            PushDebugMessage("离火金币不够")
            return 2
		end

        local theAction = EnumAction(index, "packageitem")
        JT_ABC=tostring("%s")
        -- 第一条精通
        local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(0);
        if	string.find(pName, JT_ABC)  then	
            JT_AAA=1
            else
            JT_AAA=0
        end
        
        -- 第二条精通
        local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(1);		
        if	string.find(pName, JT_ABC)  then
            JT_BBB=1
        else
            JT_BBB=0
        end

        -- 第三条精通
        local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(2);		
        if string.find(pName,JT_ABC )  then
            JT_CCC=1
        else
            JT_CCC=0
        end	
        
        local JT_shuliang=JT_AAA+JT_BBB+JT_CCC
        if JT_shuliang>=1 then
            local itemneed=PlayerPackage:CountAvailableItemByIDTable(20700063) 
            if itemneed < 15 then
                PushDebugMessage("离火不够")
                return 2
            end
        end
		
        PushDebugMessage(JT_AAA..JT_BBB..JT_CCC)
        if JT_AAA+JT_BBB+JT_CCC>=%d then
            PushDebugMessage("%d精通已洗好，不再淬炼")
            return 2
        end

        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("EquipCuiLian");
            Set_XSCRIPT_ScriptID(890088);
            Set_XSCRIPT_Parameter(0,%d);
            Set_XSCRIPT_Parameter(1,JT_AAA)
            Set_XSCRIPT_Parameter(2,JT_BBB)
            Set_XSCRIPT_Parameter(3,JT_CCC)
            Set_XSCRIPT_ParamCount(4);
        Send_XSCRIPT();	
		]], LPindex,JT_SHUXING,数量,数量,LPindex), "d")
-- 参数1：LPindex背包中装备位置: LPindex=获取背包物品位置(装备名字)-1
-- 参数2：JT_SHUXING 目标属性：con(体力)、attack_cold(冰)、attack_fire(火)、attack_light(玄)、attack_poison(毒)
-- 参数3：洗出几条相同的属性
-- 参数4：洗出几条相同的属性
-- 参数5：LPindex背包中装备位置: LPindex=获取背包物品位置(装备名字)-1
```

### 30、精通升级
```lua
-- 这里
local tem =LUA_取返回值(string.format([[
        local index = tonumber(%d)
        local JT_ABC=tostring("%s") 
        local nlevel= tonumber(%d)
        
        local equip_level = LifeAbility : Get_Equip_Level(index);
        if equip_level <80 then
            PushDebugMessage("装备等级不够")
            return 2
        end
		
        local theAction = EnumAction(index, "packageitem")
        -- 获取能升级的精通序号
        local JT_XUHAO=-1   -- 精通序号
        for kkk=0,2 do
            local pName, pLevel, pBValue, pPercent, pRValue = theAction:GetEquipAttaProperty(kkk);
            if(pLevel ~= nil and pLevel > 0) then
                if	string.find(pName, JT_ABC)  then	
                    if tonumber(pLevel) < nlevel  then
                        JT_XUHAO= kkk+1
                        JT_MQDJ=pLevel
                    end
                end
            else
                PushDebugMessage("装备没有淬炼 无法升级")
                break	
            end		
        end		
        --PushDebugMessage("装备有属性对应位置:"..JT_XUHAO)
			
        if tonumber(JT_XUHAO)==-1 then
            return 2	
        end		

        -- 背包中拥有的精金石数量
        local itemneed= PlayerPackage:CountAvailableItemByIDTable(20700055)
        -- 计算各个等级需要精金石的数量
        if tonumber(JT_MQDJ) >= 30 and  tonumber(JT_MQDJ) < 40  then
                JT_XYJJS=14  
        elseif tonumber(JT_MQDJ) >= 20 and  tonumber(JT_MQDJ) < 30  then
				JT_XYJJS=12
        elseif tonumber(JT_MQDJ) >=1 and  tonumber(JT_MQDJ) < 10  then
				JT_XYJJS=1		
        elseif tonumber(JT_MQDJ) >=10 and  tonumber(JT_MQDJ) < 20  then
				JT_XYJJS=6
        elseif tonumber(JT_MQDJ) >=40 and  tonumber(JT_MQDJ) < 50  then
				JT_XYJJS=16
        elseif tonumber(JT_MQDJ) >=50 and  tonumber(JT_MQDJ) < 60  then
				JT_XYJJS=18
        elseif tonumber(JT_MQDJ) >=60 and  tonumber(JT_MQDJ) < 70  then
				JT_XYJJS=20
        elseif tonumber(JT_MQDJ) >=70 and  tonumber(JT_MQDJ) < 80  then
				JT_XYJJS=22
        elseif tonumber(JT_MQDJ) >=80 and  tonumber(JT_MQDJ) < 90  then
				JT_XYJJS=24
        elseif tonumber(JT_MQDJ) >=90 and  tonumber(JT_MQDJ) < 100  then
				JT_XYJJS=25
        else
				 JT_XYJJS=20
        end
        --PushDebugMessage("需要精金石:"..JT_XYJJS)
        if itemneed < JT_XYJJS then
            PushDebugMessage("精金石:不够")
            return 2
        end
								
        Clear_XSCRIPT();
            Set_XSCRIPT_Function_Name("EquipLevelupAtta");
            Set_XSCRIPT_ScriptID(890088);
            Set_XSCRIPT_Parameter(0,index); 
            Set_XSCRIPT_Parameter(1, tonumber(JT_XUHAO));
            Set_XSCRIPT_Parameter(2, 0);
            Set_XSCRIPT_ParamCount(3);
        Send_XSCRIPT();
		]], LPindex,JT_SHUXING,等级),"d")
-- 参数1： 背包中装备位置
-- 参数2：精通属性：con(体力)、attack_cold(冰)、attack_fire(火)、attack_light(玄)、attack_poison(毒)
-- 参数3：精通升级到多少级，用于判断是否需要升级
```


### 31、雕纹升级
```lua
local tem =LUA_取返回值(string.format([[
	    local index = tonumber(%d)
	    local todwlevel= tonumber(%d)	
		local IsHaveDiaowen = LifeAbility:IsEquipHaveDiaowen(index)  -- 装备是否有雕纹
	    local IsHaveDiaowenEx = LifeAbility:IsEquipHaveDiaowenEx(index)
		if  tonumber(IsHaveDiaowen)~=1 then
            PushDebugMessage("装备没有雕纹")
            return 2
		end
		
        local dwId,dwlevel = LifeAbility:GetEquitDiaowenID(index)  -- 雕纹ID和等级
        local dwIdEx,dwlevelEx = LifeAbility:GetEquitDiaowenIDEx(index)
			
        if dwlevel>=todwlevel then
            PushDebugMessage("雕纹已经够设置等级:"..todwlevel)
            return 2
        end
		
        Clear_XSCRIPT()
        Set_XSCRIPT_Function_Name("DoEquipDWLevelUp")
        Set_XSCRIPT_ScriptID(809272)
        Set_XSCRIPT_Parameter(0, index) --背包的序号
        Set_XSCRIPT_Parameter(1, todwlevel)  --第一个雕纹要升级的等级
        Set_XSCRIPT_Parameter(2, 0) --第二个雕纹要升级的等级
        Set_XSCRIPT_Parameter(3, 0)  --0代表不提示直接用 1代表有提示
        Set_XSCRIPT_ParamCount(4)
        Send_XSCRIPT()
]], LPindex,等级),"n")
-- 参数1：LPindex 背包中装备位置
-- 参数2：雕纹要升到多少级
```

### 32、点数兑换元宝
```lua
-- 1. 打开兑换元宝界面
LUA_Call(string.format([[
    Clear_XSCRIPT();
    Set_XSCRIPT_Function_Name("AskOpenDuihuanWindow");
    Set_XSCRIPT_ScriptID(181000);
    Set_XSCRIPT_ParamCount(0);
    Send_XSCRIPT();
]]))

-- 2. 点数兑换元宝
 LUA_Call(string.format([[
    YB=%d
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("BuyYuanbao");
        Set_XSCRIPT_ScriptID(181000);
        Set_XSCRIPT_Parameter(0,tonumber(YB));
        Set_XSCRIPT_Parameter(1,1);
        Set_XSCRIPT_ParamCount(2);
    Send_XSCRIPT();
]],index), "n")
```

### 33、获取我的钱庄元宝市场物品设置的单价
```lua
for kkk=1 ,10 do
    tem= LUA_取返回值(string.format([[ 
        local aaa=tonumber(%d)
        local theAction = EnumAction( aaa - 1 , "ybmarket_self")
        if theAction:GetID() ~= 0 then
            local pName , nowStatus ,price, itemlefttime = Auction:GetMySellBoxItemAuctionInfo(aaa- 1 )
            if pName ~= nil  then 
                g_itemNum = Auction:GetMySellBoxItemNum(aaa-1)
                --PushDebugMessage("[晴天]元宝店管理物品下架:"..pName)
                if  pName=="%s" then
                    if nowStatus == 1 then
                        return g_itemNum
                        --Auction:GetBackWhatOnSale(2 , aaa - 1  ,1)
                    elseif nowStatus == 2 then
                        Auction:GetBackExpired(2 , aaa- 1  ,1)
                    elseif  nowStatus ==  3 then
                        Auction:GetMoney(2 , aaa- 1 )
                    end
                end	
            end
        end			
        return -1
    ]], kkk,strKey), "n",1)
    -- kkk 表示我在售的多少个商品
    -- strKey 表示物品名字
end
```

### 34、钱庄寄售搜索物品获取市场价
```lua
-- 搜索指定物品
LUA_Call(string.format([[ 
    Auction:PacketSend_Search(2, 1, 1, "%s", 1) 
        -- 参数1：上方的类型：2 是物品市场, 1 是珍兽市场, 3 是装备市场
        -- 参数2：左边的子类型：从上到下一次为 1~8
        -- 参数3：排序方式：
        -- 参数4：物品名字
        -- 参数5：第几页
]], strKey), "s",1) -- strKey表示物品名字

-- 获取物品当前市场最低价
local wupindanjia=LUA_取返回值(string.format([[ 
    local pName , pSeller ,pCount ,pYB = Auction:GetItemAuctionInfo(0)
    if pName =="%s" and pSeller ~= nil and pCount ~= nil and pYB ~= nil and pCount > 0 then
        local AAA=pYB/pCount
        --PushDebugMessage(pName.."最低单价:"..AAA)
        return AAA
    end
]], strKey), "s",1) -- strKey表示物品名字
```

### 35、钱庄寄售上架物品
```lua
LUA_Call(string.format([[ 
    Auction:PacketSend_SellItem(tonumber(%d) , tonumber(%d) ,1) 
]],nIndex,bbb), "s",1)
-- 参数1：nIndex表示物品在背包中的位置
-- 参数2：bbb 表示上架物品的总价
```

### 36、钱庄寄售改价
```lua
for kkk=1 ,10 do
    LUA_Call(string.format([[ 
        g_Cur_Modify_Type =2
        g_Index =%d-1
        wantguidh, wantguidl = Auction:GetMyAuctionSellBoxItemGuid(g_Index)
        Auction:ChangePrice(g_Cur_Modify_Type ,g_Index , tonumber(%d), wantguidh, wantguidl)		
    ]], kkk,bbb), "n",1)
    -- 参数1：表示我的第几个已上架物品
    -- 参数2：bbb 表示上架物品的总价
end 
```

### 37、工具函数
```lua
-- 1. 字符串切分转换为列表
function SplitString(str, sep)
    -- str为原始字符串， sep为分隔标识符号，如 |、/等
    local tmp = {}
    for w in string.gmatch(str, string.format("([^%q]+)", sep)) do
        table.insert(tmp, w)
    end
    return tmp
end

-- 2. 美化提示
function 友情提示(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#cFF0000".."提示：".."#cFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
	]], strCode))
end
```


### 38、天机锦囊操作
```lua
-- 1. 打开天际锦囊
LUA_Call([[setmetatable(_G, {__index = Packet_Temporary_Env})]])

-- 2. 统计
```

### 39、统计天机锦囊指定物品数量
```lua
 local num = LUA_取返回值(string.format([[
    setmetatable(_G, {__index = Packet_Temporary_Env})  
    local szName = "%s"
        for i = 1, 120 do
            local theAction, bLocked = Bank:EnumTemItem(i - 1)
            if theAction:GetID() ~= 0 then
                if szName == theAction:GetName() then
                    return theAction:GetNum()
                end
            end
        end
        return 0
]], name))  -- name为指定物品的数量
```

### 40、右键点击天机锦囊物品取出
```lua
LUA_Call(string.format([[
    setmetatable(_G, {__index = Packet_Temporary_Env})
    local GRID_BUTTONS = {}
    local szName = "%s"
    for i = 1, 120 do
        local ItemBar = Packet_Temporary_ActionsList:AddItemElement( "ActionButtonItem", "Packet_Temporary", "", "")
        local ItemAcButton = ItemBar:GetLuaActionButton("Packet_Temporary")
        ItemAcButton:SetProperty("DragAcceptName", "p"..tostring(i))
        table.insert(GRID_BUTTONS,ItemAcButton);
    end
    for i = 1, 120 do
        local theAction, bLocked = Bank:EnumTemItem(i-1);
        if theAction:GetID() ~= 0 then
            GRID_BUTTONS[i]:SetActionItem(theAction:GetID())
            if szName == theAction:GetName() then
                GRID_BUTTONS[i]:DoAction()
                GRID_BUTTONS[i]:SetActionItem(-1)
            end
        end
    end
]], name))  -- name 为要取出的指定物品名字
```


### 41、获取服务器名称
```lua
local tem = LUA_取返回值(string.format([[
    local ZoneWorldID = DataPool:GetSelfZoneWorldID()  -- 当前服务器ID
    local strName = DataPool:GetServerName( ZoneWorldID )  -- 当前服务器name
    return strName
]]))
```

### 42、豪侠印升级
```lua
LUA_Call("SelfJunXian_EquipHXYLevelup();")
```


### 43、遍历背包中物品
```lua
-- 1. 判断是否绑定
if 是否绑定 ==0 or 是否绑定 == nil then
    tbangding =10
elseif  是否绑定 ==1 then
    tbangding = 0
elseif  是否绑定 ==2 then
    tbangding = 1
end
for i=0,199 do
    tem = LUA_取返回值(string.format([[
        tbangding =tostring("%s")
        i =%d
        ttname = "%s"
        local theAction=EnumAction(i,"packageitem")
        local GetName=theAction:GetName()   -- 物品名字
        local szItemNum =theAction:GetNum();   -- 物品数量
        local Status=GetItemBindStatus(i);   -- 物品绑定状态
            if GetName~=nil and GetName ~="" then
                if string.find(ttname,GetName ) then
                    if string.find(tbangding,tostring(Status)) then
                        PushDebugMessage("出售物品:"..GetName.."|背包位置:"..i)
                        return 1
                    end	
                end
            end
        return -1
    ]],tbangding, i,物品名字))
end


-- 2. 遍历道具栏、材料栏、任务栏
LUA_取返回值([[
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
```

### 44、获取背包中装备的星星数
```lua
local tem =LUA_取返回值(string.format([[
    local equipQual =PlayerPackage:GetSuperWeaponQual(%d)
    return equipQual
]], 背包中装备位置), "n")   -- 背包中装备位置：获取背包物品位置(装备名称)-1
```


### 45、遍历家园银行
```lua
local nBeginIndex, nGridNum = Bank:GetRentBoxInfo(8);
local nActIndex = nBeginIndex;
for i = 1, nGridNum do
    local theAction, bLocked = Bank:EnumItem(nActIndex);
    if theAction:GetID() ~= 0 then
        local itemName = theAction:GetName()
    end
end
```


### 46、家具仓库
```lua
local g_FurnitureInnerType = {
    [0] = { Name = "床帐", Pos = 1, Type = 1 },
    [1] = { Name = "桌", Pos = 1, Type = 2 },
    [2] = { Name = "条案", Pos = 1, Type = 3 },
    [3] = { Name = "茶几", Pos = 1, Type = 4 },
    [4] = { Name = "椅", Pos = 1, Type = 5 },
    [5] = { Name = "凳", Pos = 1, Type = 6 },
    [6] = { Name = "柜架", Pos = 1, Type = 7 },
    [7] = { Name = "屏风", Pos = 1, Type = 8 },
    [8] = { Name = "灯烛", Pos = 1, Type = 9 },
    [9] = { Name = "装饰", Pos = 1, Type = 10 },
    [10] = { Name = "隔断", Pos = 1, Type = 11 },
    [11] = { Name = "地毯", Pos = 1, Type = 12 },
}
local g_FurnitureOuterType = {
    [0] = { Name = "庭院桌", Pos = 0, Type = 1 },
    [1] = { Name = "庭院凳", Pos = 0, Type = 2 },
    [2] = { Name = "喷泉", Pos = 0, Type = 3 },
    [3] = { Name = "影壁", Pos = 0, Type = 4 },
    [4] = { Name = "风灯", Pos = 0, Type = 5 },
    [5] = { Name = "鼎", Pos = 0, Type = 6 },
    [6] = { Name = "奇石", Pos = 0, Type = 7 },
    [7] = { Name = "树木", Pos = 0, Type = 8 },
    [8] = { Name = "植栽", Pos = 0, Type = 9 },
    [9] = { Name = "玩物", Pos = 0, Type = 10 },
    [10] = { Name = "栏杆", Pos = 0, Type = 11 },
    [11] = { Name = "花草", Pos = 0, Type = 12 },
}

-- 庭院仓库中，某种类型的家具有多少种
local nXiYouCount = BieYeFurniture:GetFurTypeCntQulityInTbl(5, g_FurnitureOuterType[i].Type, g_FurnitureOuterType[i].Pos, 0)
for j = 1, nXiYouCount do
    local nQuality = BieYeFurniture:GetFurQulityInTbl(5, g_FurnitureOuterType[i].Type, g_FurnitureOuterType[i].Pos, 0, j)
    local nName = BieYeFurniture:GetFurNamenTbl(5, g_FurnitureOuterType[i].Type, g_FurnitureOuterType[i].Pos, 0, j)
end

-- 居室仓库中，某种类型的家具有多少种
local nXiYouCount = BieYeFurniture:GetFurTypeCntQulityInTbl(5, g_FurnitureInnerType[i].Type, g_FurnitureInnerType[i].Pos, 0)
for j = 1, nXiYouCount do
    local nQuality = BieYeFurniture:GetFurQulityInTbl(5, g_FurnitureInnerType[i].Type, g_FurnitureInnerType[i].Pos, 0, j)
    local nName = BieYeFurniture:GetFurNamenTbl(5, g_FurnitureInnerType[i].Type, g_FurnitureInnerType[i].Pos, 0, j)
end
```

### 47、右键使用物品
```lua
--背包序号
LUA_Call(string.format([[
    local theAction = EnumAction(%d, "packageitem");
    if theAction:GetID() ~= 0 then
        setmetatable(_G, {__index = Packet_Env});
        local oldid = Packet_Space_Line1_Row1_button:GetActionItem();
        Packet_Space_Line1_Row1_button:SetActionItem(theAction:GetID());
        Packet_Space_Line1_Row1_button:DoAction();
        Packet_Space_Line1_Row1_button:SetActionItem(oldid);
    end
]], itemPos))   -- itemPos 为背包中物品的位置
```

### 48、(有待测试)彻地符箓和VIP的瞬影符箓定位/传送
```lua
--
-- 1. 彻底符拍定位
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("SetPosition");
        Set_XSCRIPT_ScriptID(330059);
        Set_XSCRIPT_Parameter(0, %d)
        Set_XSCRIPT_Parameter(1, %d)
        Set_XSCRIPT_ParamCount(2)
    Send_XSCRIPT();
]], CTFLPos, CTFLIndex))
-- 参数1：彻地符箓的索引：获取背包物品位置("彻地符箓") - 1
-- 参数2：使用彻底符的第几个坐标位置拍定位

-- 2. VIP瞬影符箓拍定位
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("SetPosition");
        Set_XSCRIPT_ScriptID(330061);
        Set_XSCRIPT_Parameter(0, %d)
        Set_XSCRIPT_Parameter(1, %d)
        Set_XSCRIPT_ParamCount(2)
    Send_XSCRIPT();
]], SYFLPos, SYFLIndex))
-- 参数1：瞬影符箓的索引：获取背包物品位置("瞬影符箓") - 1
-- 参数2：使用瞬影符箓的第几个坐标位置拍定位

-- 3. 彻底符飞定位
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("SetUISelIdx");
        Set_XSCRIPT_ScriptID(330059);
        Set_XSCRIPT_Parameter(0, %d)
        Set_XSCRIPT_Parameter(1, %d)
        Set_XSCRIPT_ParamCount(2);
    Send_XSCRIPT();
    PlayerPackage:UseItem(Client_ItemIndex)
]], CTFLPos, CTFLIndex))
-- 参数1：彻地符箓的索引：获取背包物品位置("彻地符箓") - 1
-- 参数2：使用彻底符的第几个坐标位置飞定位

-- 4. 瞬影符箓飞定位
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("SetUISelIdx");
        Set_XSCRIPT_ScriptID(330061);
        Set_XSCRIPT_Parameter(0, %d)
        Set_XSCRIPT_Parameter(1, %d)
        Set_XSCRIPT_ParamCount(2);
    Send_XSCRIPT();
    PlayerPackage:UseItem(Client_ItemIndex)
]], SYFLPos, SYFLIndex))
-- 参数1：瞬影符箓的索引：获取背包物品位置("瞬影符箓") - 1
-- 参数2：使用瞬影符箓的第几个坐标位置飞定位
```


### 49、(有待测试)彻地符箓补充次数
```lua
-- 1. 使用绑定元宝补充
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("YuanbaoBind_AddFuZhou");
        Set_XSCRIPT_ScriptID(330059);
        Set_XSCRIPT_Parameter(0, %d);
        Set_XSCRIPT_ParamCount(1);
    Send_XSCRIPT();
]], SYFLPos)) -- 参数1：彻地符箓的索引：获取背包物品位置("彻地符箓") - 1

-- 2. 使用元宝补充
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("Yuanbao_AddFuZhou");
        Set_XSCRIPT_ScriptID(330059);
        Set_XSCRIPT_Parameter(0, %d);
        Set_XSCRIPT_ParamCount(1);
    Send_XSCRIPT();
]], SYFLPos)) -- 参数1：彻地符箓的索引：获取背包物品位置("彻地符箓") - 1

-- 3. 不知道是什么, 确认补充
LUA_Call(string.format([[
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("AddFuZhou");
        Set_XSCRIPT_ScriptID(330059);
        Set_XSCRIPT_Parameter(0, Client_ItemIndex)
        Set_XSCRIPT_ParamCount(1);
    Send_XSCRIPT();
]], SYFLPos)) -- 参数1：彻地符箓的索引：获取背包物品位置("彻地符箓") - 1
```

### 50、(有待测试)彻底符信息
```lua
-- 1. 必须请求一次背包中彻底符的数据，不然无法获取数据
LUA_Call([[
    PlayerPackage:AskDunJiaShuPosInfo()
]])

-- 2. 获取彻底符每个按钮上坐标信息
-- 总共有3页，每页有10个坐标
LUA_Call(string.format([[
    local flPos = %d
    for pageNum = 1, 3 do
        for i = 1, 10 do
            local nIdx = (pageNum-1)*10 + i-1
            -- 场景id，地图名字，符箓可用次数，X坐标，Y坐标，是否第一次使用
            local sceneid, strText, count, posx, posy, init = PlayerPackage:GetDunJiaShuPosInfo(flPos, nIdx)
        end
    end 
]], FLPos))  -- 参数1：符箓索引，获取背包物品位置("彻地符箓") - 1
```

### 51、(有待测试)瞬影符箓信息
```lua
-- 1. 必须请求一次背包中彻底符的数据，不然无法获取数据
LUA_Call([[
    PlayerPackage:AskDunJiaShuPosInfo()
]])

-- 2. 获取彻底符每个按钮上坐标信息
-- 总共有3页，每页有10个坐标
LUA_Call(string.format([[
    local flPos = %d
    for pageNum = 1, 3 do
        for i = 1, 10 do
            local nIdx = (pageNum-1)*10 + i-1
            -- 场景id，地图名字，X坐标，Y坐标，符箓已用用次数，最大次数
            local sceneid, strText, posx, posy, usedCount, maxUseCount = PlayerPackage:GetDunJiaShuVIPPosInfo(flPos, nIdx)
        end
    end 
]], FLPos))  -- 参数1：符箓索引，获取背包物品位置("彻地符箓") - 1
```

### 52、武意属性点
```lua
local g_Martial_WuYi_ShuXingLevelPoint = {
    [1] = 750, --血上限	
    [2] = 10, --冰攻击	
    [3] = 10, --火攻击	
    [4] = 10, --玄攻击	
    [5] = 10, --毒攻击	
    [6] = 110, --命中	
    [7] = 35, --闪避	
    [8] = 13, --穿刺伤害
    [9] = 13, --穿刺减免
    [10] = 5, --所有属性
    [11] = 100, --外功攻击
    [12] = 100, --内功攻击
}
local g_Martial_WuYi_ShuXing2Name = {
    [1] = "血上限",
    [2] = "冰攻击",
    [3] = "火攻击",
    [4] = "玄攻击",
    [5] = "毒攻击",
    [6] = "命中",
    [7] = "闪避",
    [8] = "穿刺伤害",
    [9] = "穿刺减免",
    [10] = "所有属性",
    [11] = "外功攻击",
    [12] = "内功攻击",
}

LUA_Call([[
    local data = MaritialSys:GetMaritiaAttrInfo()  -- 武意属性
    if(data ~= nil) then
		g_Martial_WuYi_ShuXing2Name = {}
		g_Martial_WuYi_ShuXingLevelPoint = {}
	end
    for i, v in ipairs(data) do
        g_Martial_WuYi_ShuXing2Name[v[1] + 1] = v[2];
        g_Martial_WuYi_ShuXingLevelPoint[v[1] + 1] = v[3];
    end
]])
```

### 53、武意等级信息
```lua
LUA_Call("
    local data = MaritialSys:GetMartialLevelInfo()
    
    if(data ~= nil) then
		g_Martial_WuYi_LevelExp = {}
		g_Martial_TalenLayerNeedLevel = {}
		g_Martial_WuYi_LevelAttrPoint = {}
		g_Martial_WuYi_LevelTalentPoint = {}
		g_Martial_WuYi_LevelLimit = {}
	end
	
	for i,v in ipairs(data) do
		local nLayer = v[5]
		g_Martial_WuYi_LevelExp[v[1]] = v[2]
		g_Martial_WuYi_LevelAttrPoint[v[1]] = v[3]
		g_Martial_WuYi_LevelTalentPoint[v[1]] = v[4]
		g_Martial_WuYi_LevelLimit[v[1]] = v[6]
 		if(nLayer ~= 0 and (g_Martial_TalenLayerNeedLevel[nLayer] == nil or g_Martial_TalenLayerNeedLevel[nLayer] > v[1])) then
			g_Martial_TalenLayerNeedLevel[nLayer] = v[1]
		end
	end
")
```

### 54、武意属性界面数据
```lua
-- 1. 今天的武意刷怪数
LUA_Call([[
    local nWuYiMonsterNum = MaritialSys:GetMaritialTodayNum()
]])

-- 2. 今天的多倍武意刷怪数
LUA_Call([[
    local nMultiWuYiMonsterNum = MaritialSys:GetMaritiaLTodayMultiNum()
]])

-- 3. 昨日剩余武意刷怪数
LUA_Call([[
    local nMonsterNum,nReward = MaritialSys:GetLastDayMonster()
]])

-- 4. 可分配点数
LUA_Call([[
    local nRemainPoint = MaritialSys:GetMaritiaRemainPoint()
]])

-- 5. 武意冻结状态
LUA_Call([[
    local nState = MaritialSys:GetMaritiaFreezeState()
]])

-- 6. 武意等级
LUA_Call([[
    local nMartialLevel = MaritialSys:GetMaritiaLevel()
]])

-- 7. 当前武意经验
LUA_Call([[
    local nCurExp = MaritialSys:GetMaritiaExp()
]])
```

### 55、 武意天赋界面数据
```lua
-- 1. 天赋信息, 天赋的所有信息，返回为一个table
LUA_Call([[
    local data = MaritialSys:GetTalentDescInfo()
]])

-- 2. 遍历天赋等级
LUA_Call([[
    for i=1,5 do
		local nId,nLevel = MaritialSys:GetTalentLevelBylayerID(i - 1)
    end
]])

-- 3. 天赋可分配点
LUA_Call([[
    local nRemain = MaritialSys:GetTalentRemainPoint()
]])
```

### 56、武意加点
```lua
LUA_Call([[
    Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "AddAttr" )
		Set_XSCRIPT_ScriptID( 507010 )
	Send_XSCRIPT()
]])
```

### 57、武意洗点
```lua
LUA_Call(string.format([[
    local nIdx = %d
    --武意接口脚本
    local g_Martial_WuYi_ScriptId = 507010 
    local g_Martial_WuYi_YuanbaoPay=1 -- 是否使用元宝购买
    -- 武意洗点道具ID
    local g_Martial_WuYi_ReclyItemID = 38002046
    local g_Martial_WuYi_ReclyItemID1 = 38002047
    local nValue = MaritialSys:GetMaritiaAttrByIndex(nIdx)  -- 某个属性的点数
    
    -- 检查洗点材料是否存在
    local bExist = IsItemExist(g_Martial_WuYi_ReclyItemID)
	local bExist1 = IsItemExist(g_Martial_WuYi_ReclyItemID1)
	
	-- 判断是否开启洗点确认
	local bComfirm = Martial_WuYi_Top_xidianqueren:GetCheck()
	
	-- 洗点
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "RecycleAttrPoint" )
		Set_XSCRIPT_ScriptID( g_Martial_WuYi_ScriptId )
		Set_XSCRIPT_Parameter(0,nIdx)
		Set_XSCRIPT_Parameter(1, 1)  -- 后面为0, 会购买紫府星髓，但是不会使用
		Set_XSCRIPT_ParamCount(2)
	Send_XSCRIPT()
]], pointIndex)) -- 参数1：重洗点属性的索引
```


### 58、帮会成员信息
```lua
-- 1. 请求帮会成员信息，必须请求一次，否则无法获取数据
LUA_Call([[
    Guild:AskGuildMembersInfo();
]])

-- 2. 成员信息
LUA_Call([[
    local totalNum = Guild:GetMembersNum(4);
		local i = 0;
		while i < totalNum do
			local guildIdx = Guild:GetShowMembersIdx(i);
			local color,strTips = Guild:GetMembersInfo(guildIdx, "ShowColor");
			szMsg = Guild:GetMembersInfo(guildIdx, "Name");   -- 成员名字
			local FirstManGuid = Guild:GetMembersInfo(guildIdx, "FirstManGuid");
			local tPos = Guild:GetMembersInfo(guildIdx, "Position")  -- 职位
			local level = Guild:GetMembersInfo(guildIdx, "Level")   -- 等级
			local nMenpai = Guild:GetMembersInfo(guildIdx, "MenPai")  -- 门派
			local nContriPerWeek = Guild:GetMembersInfo(guildIdx, "ContriPerWeek")   -- 每周帮贡
			local nEquipPoint = Guild:GetMembersInfo(guildIdx, "EquipPoint")   -- 装备评分
			local nguid = Guild:GetMembersInfo(guildIdx, "GUID")
]])
```

### 59、遍历锦囊
```lua
LUA_Call([[
    setmetatable(_G, {__index = Packet_Temporary_Env})  
    local szName = "%s"
    for i = 1, 120 do
        local theAction, bLocked = Bank:EnumTemItem(i - 1)
        if theAction:GetID() ~= 0 then
            local szName = theAction:GetName()
        end
    end
]])
```

### 60、锦囊右键取出物品
```lua
LUA_Call(string.format([[
    setmetatable(_G, {__index = Packet_Temporary_Env})
    local GRID_BUTTONS = {}
    local szName = "%s"
    for i = 1, 120 do
        local ItemBar = Packet_Temporary_ActionsList:AddItemElement( "ActionButtonItem", "Packet_Temporary", "", "")
        local ItemAcButton = ItemBar:GetLuaActionButton("Packet_Temporary")
        ItemAcButton:SetProperty("DragAcceptName", "p"..tostring(i))
        table.insert(GRID_BUTTONS,ItemAcButton);
    end
    for i = 1, 120 do
        local theAction, bLocked = Bank:EnumTemItem(i-1);
        if theAction:GetID() ~= 0 then
            GRID_BUTTONS[i]:SetActionItem(theAction:GetID())
            if szName == theAction:GetName() then
                GRID_BUTTONS[i]:DoAction()
                GRID_BUTTONS[i]:SetActionItem(-1)
            end
        end
    end
	]],name))  -- name表示要取出物品名字
```

### 61、(有待测试)人物Buff
```lua
LUA_Call([[
    -- 获取玩家身上的buff数量
    local buff_num = Player:GetBuffNumber();  
    if ( buff_num > 30 ) then
		buff_num = 30;
	end
	
	-- 生成buffIndex列表
	local BUFFINDEX_LIST = {};
	for jj=1,IMPACT_NUM do
		BUFFINDEX_LIST[jj] = -1;
	end
	
	-- buff优先级列表
	local BuffPriority = {}   
	for jj=1,buff_num do
		BuffPriority[jj] = {}
		BuffPriority[jj].key = jj-1;
		BuffPriority[jj].val = Player:GetBuffPriorityByIndex(jj-1);
	end
	
    -- 根据优先级从高到低排序buff
    for jj=buff_num,1,-1 do   
		for kk=1,jj-1 do
			if BuffPriority[kk].val < BuffPriority[kk+1].val then
				BuffPriority[kk],BuffPriority[kk+1] = BuffPriority[kk+1],BuffPriority[kk]
			end
		end
	end
	
	-- 将buffIndex和优先级关联
	for jj=1,buff_num do
		BUFFINDEX_LIST[jj] = BuffPriority[jj].key;
	end
	
	local i = 0;
    while i<buff_num do
        szIconName = Player:GetBuffIconNameByIndex(BUFFINDEX_LIST[i+1]);  -- buff名字？
        szToolTips = Player:GetBuffToolTipsByIndex(BUFFINDEX_LIST[i+1]);
        szTimeText = Player:GetBuffTimeTextByIndex(BUFFINDEX_LIST[i+1]);  -- buff剩余时间
]])
```


### 62、获取装备的属性
```lua
-- 获取背包中装备的所有属性，并拼接成字符串
LUA_Call(string.format([[
    local index = %d
    local theAction = EnumAction(index, "packageitem")
    if theAction:GetID() ~= 0 then
        local icon =  tostring(LifeAbility : Get_Item_Icon_Name(index))
        local num = theAction:GetEquipAttrCount()  -- 装备属性条数
		local str = ""
		for i = 0, num-1 do
			local tempstr = theAction:EnumEquipExtAttr(i)  -- 获取每一条属性
			local strTemp = ""
            if string.find(tempstr, "#{") then
                local left = string.find(tempstr, "#{")
                local left2 = string.find(tempstr, "}")
                strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))	
            end 
			str = str..strTemp
		end
		return str
    end
]], Index))  -- Index为装备在背包中的索引：获取背包位置(xxx) - 1
```


### 63、取装备重洗后的属性
```lua
local isWQ = LUA_取返回值(string.format([[
    local num =  DataPool : Lua_GetRecoinNum();
	local str = ""
	for i = 0, num-1 do
		local tempstr = DataPool :Lua_GetRecoinEnumAttr(i)
		local strTemp = ""
		if string.find(tempstr, "#{") then
			local left = string.find(tempstr, "#{")
			local left2 = string.find(tempstr, "}")
			strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))	
		end 
        str = str..strTemp.."|"
	end
	return  str
	]], "s"))
```


### 64、侠印升级
```lua
LUA_Call([[
    Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name( "HXY_LevelUp" )
		Set_XSCRIPT_ScriptID( 880006 )
		Set_XSCRIPT_ParamCount( 0 );
	Send_XSCRIPT();
]])
```


### 65、侠印减免效果激活/升级
```lua
-- 1. 获取减免效果
LUA_Call([[
    for i=1,7 do
        --    索引         减免等级  升级所需功勋  升级所需侠印等级   值
        local nIndex , iEffectLevel, iCost , iNeedHXYLevel , iValue = DataPool:Lua_GetHXYEffect( i - 1 )
        local nAddValueEffect = DataPool:Lua_GetHXYEffectRefixValue( i - 1 )   -- ???
        local strExAttr = strExAttr = DataPool:Lua_GetHXYExAttrInfo( i - 1 )  -- ???
        local nRefixValue = DataPool:Lua_GetHXYExAttrRefixValue( i - 1 )    -- ???
    end
]])

-- 2. 激活、升级
LUA_Call(string.format([[
    Clear_XSCRIPT()
		Set_XSCRIPT_ScriptID( 880006 )
		Set_XSCRIPT_Function_Name( "HXY_EffectLevelUp" )
		Set_XSCRIPT_Parameter( 0, %d )
		Set_XSCRIPT_Parameter( 1 , 1)
		Set_XSCRIPT_ParamCount( 2 )
	Send_XSCRIPT()
]], aryIndex))  -- aryIndex 为减免的索引：0~6
```

### 66、秘籍信息
```lua
-- 1. 遍历自己的3个秘籍
LUA_Call([[
    for Index = 1, 3 do
        local theAction = EnumAction(Index - 1, "combobook")
        if (theAction:GetID() ~= 0 ) then
            local nSumSkill = GetActionNum("skill");  -- 获取秘籍的技能数量，一般为3个
            local bookname = Player:GetComboBookInfo(Index, "bookname");  -- 秘籍名字
            local bookitemid = Player:GetComboBookInfo(Index, "bookitemId");   -- 秘籍ID
            local bookdesc = Player:GetComboBookInfo(Index, "bookdesc");    -- 秘籍描述
            local nLevel = Player:GetComboBookInfo(Index, "level");  -- 秘籍等级
            local skill1, skill2, skill3 = Player:GetComboBookInfo(Index, "comboskill");  -- 秘籍的3个技能的ID，如总决式、破箭式、破气式
            local rate1, rate2 = Player:GetComboBookInfo(Index, "rate");  -- 触发下一个技能的概率
            local nextrate1, nextrage2 = Player : GetComboBookInfo(Index, "nextlevelrate");
            local levelupneed =  Player : GetComboBookInfo(Index, "nextlevelexp");  -- 升到下一级需要的经验
            local nextlevelallxiuwei = Player : GetComboBookInfo(Index, "allxiuwei");  -- 秘籍的所有修为
        end
]])

-- 2. 获取自己的修为信息
LUA_Call([[
    local xiuweivalue =  Player : GetData( "XIUWEI" );  -- 自己当前修为值
    local tilte,level = SelfMiji_GetXiuWeiLevel(xiuweivalue)
    local nextlevelneed = GetXiuweiNextNeed(xiuweivalue)
    local lilianvalue =  Player : GetData( "LILIAN" );  历练值
]])

-- 3.遍历秘籍的技能
LUA_Call([[
    local nSumSkill = GetActionNum("skill");  -- 获取秘籍的技能数量，一般为3个
    local skill1, skill2, skill3 = Player:GetComboBookInfo(Index, "comboskill");
    for i = 1, nSumSkill do
        local thetempAction = EnumAction(i, "skill");
        local temp = thetempAction:GetID();
        local nCommonId = LifeAbility : GetLifeAbility_Number(temp);
        if nCommonId == skill1 then 
            local combobookSkill1Name = thetempAction:GetName()
        end
    end
]])

-- 4.遗忘某个秘籍
LUA_Call(string.format([[
    Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("CheckDeleteBook");
		Set_XSCRIPT_ScriptID(890099);
		Set_XSCRIPT_Parameter(0,Index);
		Set_XSCRIPT_ParamCount(1);
	Send_XSCRIPT();
]], miJiIndex))  -- miJiIndex秘籍索引：0,1,2

-- 5. 秘籍升级
LUA_Call(string.format([[
    AskLevelupComboBook(%d);
]], miJiIndex))   -- miJiIndex秘籍索引：0,1,2
```


### 67、九星神器
```lua
LUA_Call(string.format([[
    local g_SuperWeapon9_Change_WeaponIndex = %d
    local n9ID,str9WG,n8ID,str8WG,n5ID,str5WG,needMoney = PlayerPackage:GetSuperWeapon9WG(g_SuperWeapon9_Change_WeaponIndex,"tbl")
]], Index)) -- Index是啥，背包中神器的位置？

-- 2. 9星神器技能
LUA_Call([[
    local nSkillId = DataPool:GetSuperWeaponDIYSkillId()
	if nSkillId == nil or nSkillId <= 0 then
	    -- 未激活主动技能
		return
	end

    local theActionSkill = EnumAction(0 , "superweapondiyskill");
    if theActionSkill:GetID() ~= 0 then 
        local slotLevel = DataPool:GetSuperWeaponDIYSkillSlotLevel(1)
        if slotLevel ~= nil and slotLevel > 0 then
            PushDebugMessage("技能可用")
        end
    end
]])

-- 3. 9星神器3个技能等级
local g_SuperWeapon9_DIYSkill_Data = 
{
	[1] = { itemId = 38002040, bindId = 38002041, nameText = "#{JXSQ_170804_67}", lockText = "#{JXSQ_170804_70}", title = "#{JXSQ_170804_92}", costText = "#{JXSQ_170804_98}", itemText = "#{JXSQ_170804_102}", itemTextRed = "#{JXSQ_170829_265}", itemTip = "#{JXSQ_170829_219}", levelTip = "#{JXSQ_170829_207}", },
	[2] = { itemId = 38002042, bindId = 38002043, nameText = "#{JXSQ_170804_68}", lockText = "#{JXSQ_170804_71}", title = "#{JXSQ_170804_93}", costText = "#{JXSQ_170804_99}", itemText = "#{JXSQ_170804_103}", itemTextRed = "#{JXSQ_170829_266}", itemTip = "#{JXSQ_170829_220}", levelTip = "#{JXSQ_170829_247}", },
	[3] = { itemId = 38002044, bindId = 38002045, nameText = "#{JXSQ_170804_69}", lockText = "#{JXSQ_170804_72}", title = "#{JXSQ_170804_94}", costText = "#{JXSQ_170804_100}", itemText = "#{JXSQ_170804_104}", itemTextRed = "#{JXSQ_170829_267}", itemTip = "#{JXSQ_170829_221}", levelTip = "#{JXSQ_170829_248}", },
}

LUA_Call([[
    for nIndex = 1,3 do
        local slotLevel = DataPool:GetSuperWeaponDIYSkillSlotLevel(nIndex)   -- 获取当前第nIndex个插槽的等级
        if slotLevel == nil or slotLevel <= 0 then
            return
        end
        
        -- 3个插槽中每个升级需要魂玉数量
        local nCostNum, nCostMoney = DataPool:GetSuperWeaponDIYSkillLevelupData(slotLevel, nIndex)
        if nCostNum ~= nil and nCostNum > 0 then
			local nItemId = g_SuperWeapon9_DIYSkill_Data[nIndex].itemId
			local itemName = PlayerPackage:GetItemName(nItemId)
        end
        
        -- 获得当前插槽技能
        local impactIndex = DataPool:GetSuperWeaponDIYSkillImpactIndex(nIndex)
        if impactIndex == nil or impactIndex <= 0 then
            return
        end	
        local slotType, nCostNum, nSkillId = DataPool:GetSuperWeaponDIYSkillActiveData(impactIndex)
        if nCostNum == nil or nCostNum < 0 or nSkillId == nil or nSkillId <= 0 then
            return
        end
        local bRet,skillName = DataPool:GetSkillName(nSkillId)  -- 根据id获取技能名字
    end
]])

-- 4. 获取背包魂玉数量
LUA_Call([[
    for nIndex=1,3 do
        -- 1表示魂玉，2表示地魂玉，3表示天魂玉
        local itemId = g_SuperWeapon9_DIYSkill_Data[nIndex].itemId  -- 不绑定魂玉ID
		local bindId = g_SuperWeapon9_DIYSkill_Data[nIndex].bindId  -- 绑定魂玉ID
		local itemNum = PlayerPackage:CountAvailableItemByIDTable(itemId)  -- 不绑定魂玉数量
		local bindNum = PlayerPackage:CountAvailableItemByIDTable(bindId)   -- 绑定魂玉数量
    end
]])


-- 5. 神器3个插槽升级
LUA_Call(string.format([[
    local objCared = DataPool:GetCurDialogNpcId();
    g_TargetServerID = Get_XParam_INT(0);   -- 是否会报错
    g_ObjCared = objCared
    
    local g_TargetServerID = %d
    local g_SuperWeapon9_DIYSkill_WeaponIndex = %d
    local nIndex = %d
    Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name("SuperWeaponDIYSkill_LevelupSlot")
		Set_XSCRIPT_ScriptID(892471)
		Set_XSCRIPT_Parameter(0, g_TargetServerID)
		Set_XSCRIPT_Parameter(1, g_SuperWeapon9_DIYSkill_WeaponIndex)
		Set_XSCRIPT_Parameter(2, nIndex)
		Set_XSCRIPT_Parameter(3, 0)
		Set_XSCRIPT_ParamCount(4)
	Send_XSCRIPT()
]], a, b, c))
-- 参数1：？？？
-- 参数2：背包中神器的索引
-- 参数3：第几个插槽
```


### 68、(有待测试)好友列表
```lua
-- 1. 好友列表处理
-- 婚姻  Special 特殊处理
-- 结拜  Special 特殊处理
-- 师门  Special 特殊处理
-- 徒弟  Special 特殊处理
-- ①
-- ②
-- ③
-- ④
-- 黑名单
-- 仇人
-- 仇敌
-- 临时好友
-- 畅游精灵     其它处理


-- 2. 8个普通组
LUA_Call([[
    for i = 1 , 8 do   -- 8个普通组
		local j = i
		if i == 8 then
			j = 13
		end
		
		local FriendCount = 0 --好友总数
        local FriendInfo = {} --分组好友人数和在线好友人数
        FriendInfo[j] = ""
		for iTmp = 1, 4 do
            FriendCount = FriendCount + DataPool:GetFriendNumber( tonumber( iTmp ) );
            local groupCount = DataPool:GetFriendNumberCommon( tonumber( iTmp ) );--每组人数
            local onlienCount= DataPool:GetFriendOnlineNumberCommon( tonumber( iTmp ) );--每组在线人数
        end
        
        
        -- 当前channel的好友数量， j 范围：1~7, 13
        local relealFriendNumber = DataPool:GetFriendNumber( tonumber( j ) )  
]])


-- 每个channel中索引为Index的用户信息
LUA_Call([[
    for i = 1 , 8 do   -- 8个普通组
		local nChannel = i
		if i == 8 then
			nChannel = 13
		end
		
		-- 当前channel的好友数量， j 范围：1~7, 13
        local relealFriendNumber = DataPool:GetFriendNumber( tonumber( nChannel ) ) 
        
        local nIndex = 0;
        while nIndex < relealFriendNumber do
            local name = DataPool:GetFriend( nChannel, nIndex, "NAME" );  -- 名字
            local remark =  Friend_GetSpecialRemark( nChannel, nIndex )     -- 备注
            local emotion = DataPool:GetFriend( nChannel, nIndex, "MOOD" );     -- 心情
            local friendship = DataPool:GetFriend( nChannel, nIndex, "FRIENDSHIP" );    -- 友好度？？？
            local relationtype = DataPool:GetFriend( nChannel, nIndex, "RELATION_TYPE" );   -- 关系： 7:师傅 8：徒弟 3：结婚 2：结拜
            local imOnlineTime = DataPool:GetFriend( nChannel, nIndex, "IM_ONLINE_TIME" );
            local IMst = DataPool:GetFriend( nChannel, nIndex, "IM_STATUS" );
            local Sex = DataPool:GetFriend( nChannel, nIndex, "SEX" );
            local haveMsg = DataPool:GetFriend( nChannel, nIndex, "MSG" );
            local guid =  DataPool:GetFriend( nChannel, nIndex, "ID" );  -- ID
            local havePresent = DataPool:GetFriend(nChannel, nIndex, "FRIEND_PRESENT" );
            local nLevel = DataPool:GetFriend(nChannel, nIndex, "LEVEL");
            local zoneWorldID = DataPool:GetFriend(nChannel, nIndex, "ZONEWORLDID" )  -- 好友的服务器ID
            local selfZoneWorldID = DataPool:GetSelfZoneWorldID()  -- 我的服务器ID
        end
]])

```


### 69、阵法升级
```lua
LUA_Call(string.format([[
    local zfIndex = %d
    Clear_XSCRIPT();
        Set_XSCRIPT_Function_Name("QueryLevel");
        Set_XSCRIPT_ScriptID(891175);
        Set_XSCRIPT_Parameter(0,index);
        Set_XSCRIPT_ParamCount(1);
    Send_XSCRIPT();	

]], zfIndex))  
-- zfIndex 阵法索引
```


### 70、(有待测试)目标Target操作
```lua
LUA_Call([[
    local szName = Guild:GetMembersInfo(tonumber(currentGuildListIndex), "Name");

	if(nil ~= szName) then
		Target:SelectThePlayer(szName);
	end
]])


LUA_Call([[
    Target:SelectThePlayer(szSingleName,tZoneWorldId);
]])

```
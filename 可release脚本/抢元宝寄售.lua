取出物品("金币")
跨图寻路("洛阳", 256, 321)
延时(1000)
对话NPC("汀汀")
延时(500)
NPC二级对话("我想购买元宝")
延时(1000)
-- CommisionStall.lua
while true do
    for g_grad = 0, 2 do
        LUA_Call(string.format([[
            setmetatable(_G, {__index = CommisionStall_Env});
            CommisionStall_ChangeTabIndex(%d);
        ]], g_grad + 1))
        延时(500)

        -- 购买元宝
        LUA_Call(string.format([[
            g_grad = %d
            if(g_grad<=2)then
                -- 元宝店
				g_Type = 1
			else
				g_Type = 2
			end
            for idx = 1, 3 do
                -- 目前寄售的人少，无需遍历20个，只遍历前3个数据即可
                local theAction = CommisionShop:EnumAction(idx-1);
                if theAction:GetID() ~= 0 then
                    local Sailer = CommisionShop:EnumItem(tonumber(g_Type-1),tonumber(idx-1),"serial");

                    Clear_XSCRIPT();
                        Set_XSCRIPT_Function_Name("Buy");
                        Set_XSCRIPT_ScriptID(800116);
                        Set_XSCRIPT_Parameter(0,tonumber(191));
                        Set_XSCRIPT_Parameter(1,tonumber(g_grad));
                        Set_XSCRIPT_Parameter(2,tonumber(Sailer));
                        Set_XSCRIPT_ParamCount(3);
                    Send_XSCRIPT();
                end
            end
        ]], g_grad))  -- TODO g_grad为：0,1,2，分别对应寄售种类50点元宝，200点元宝，500点元宝
    end
end
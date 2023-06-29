---需要改的参数在尾行 其他不要动
---------------------------------------------------------------------------------------------------------------------------------------


function 晴天_取服务器名称()
    local tem = LUA_取返回值(string.format([[
		local ZoneWorldID = DataPool:GetSelfZoneWorldID()
	local strName = DataPool:GetServerName( ZoneWorldID )
	return strName 
		]]))
    return tem
end

----------------------------------------------------------------------------------------------------
function 晴天_取摊位名称()
    return LUA_取返回值(string.format([[
setmetatable(_G, {__index = StallBuy_Env});
aaa=StallBuy:GetStallerName()
return aaa
 ]]), "s");
end

----------------------------------------------------------------------------------------------------
function 晴天_购买周围摊位(地图, XXX, YYY, 服务器, 小号名称合集)
    if 晴天_取服务器名称() ~= 服务器 or 小号名称合集 == nil then
        屏幕提示("服务器名称不对,名字设置不对")
        return
    end

    跨图寻路(地图, XXX, YYY)
    ID顾虑 = ""
    for KKK = 1, 20 do
        物品名称, 物品ID, 物品X坐标, 物品Y坐标, 物品血量, 物品距离, 物品类别, 物品归属, 怪物判断, 头顶标注 = 遍历周围物品(1, 小号名称合集, 15.5, ID顾虑)
        if 物品ID > 0 then
            ID顾虑 = ID顾虑 .. "|" .. 物品ID
            屏幕提示(ID顾虑)
            跨图寻路("钱庄", 物品X坐标, 物品Y坐标)
            屏幕提示(物品名称 .. 物品ID .. "打开摊位")
            LUA_Call(string.format([[
	ID =%d
	OpenStallSale(ID)
 ]], 物品ID), "n");
            延时(3000)

            if 窗口是否出现("StallBuy") then
                if 晴天_取摊位名称() == 物品名称 then
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

                            if  tonumber(nPriceYuanbao) < 500 then      ----自己改价格  100这里 单价乘以数量的价格

                                PushDebugMessage(AA..".   物品名称"..nItemName.."数量:"..nItemNum.."单价:"..nPriceYuanbao);
                                StallBuy:BuyItem(g_nCurSelectItemID,i);
                                return 1
                            else
                                PushDebugMessage(AA..".    物品名称"..nItemName.."数量:"..nItemNum.."单价:"..nPriceYuanbao.."|不购买");
                            end
                            else
                                PushDebugMessage(AA.."没有物品延时2秒");
                            end
                         ]], i), "n");
                        if tonumber(tem) == 1 then
                            延时(2000)
                        else
                            延时(50)
                        end
                    end
                end
            end
        end
    end
end

while true do
    晴天_购买周围摊位("钱庄", 73, 57, "绝杀", "冰山上的来客 ")---需要改的参数
    --晴天_购买周围摊位("钱庄",60,30,"绝杀")
end

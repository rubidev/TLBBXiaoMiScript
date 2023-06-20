function FirstUse()
    -- 第一轮使用，打开礼盒
    local pkgCount = LUA_取返回值([[return GetActionNum("packageitem");]])
    local patternList = {
        '真元·.+符', '归宁澄心华盒', '静心雅盒', '.+运功典藏',
        '夏之锦幅', '极光流萤',
        '赤铜添福礼箱',
        '竹香筒粽',
        '动作：江湖我行',
        "表情包："
    }

    坐骑_下坐骑()
    延时(1000)

    for i = 1, tonumber(pkgCount) do
        local pkgItem = LUA_取返回值(string.format([[
            theAction,bLocked = PlayerPackage:EnumItem("base", %d - 1);  -- szPacketName = "base"、"material"、"quest"
            if theAction:GetID() ~= 0 then
                return theAction:GetName();
            end
            return -1
        ]], i))

        if pkgItem ~= -1 then
            for k, pattern in pairs(patternList) do
                if string.find(pkgItem, pattern) then
                    -- 真元·xx符、归宁澄心华盒、静心雅盒、任脉运功典藏
                    while true do
                        if tonumber(获取背包物品数量(pkgItem)) <= 0 then
                            break
                        end
                        右键使用物品(pkgItem)
                        延时(500)
                        LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
                        延时(100)
                    end
                end
            end
        end
    end
end

FirstUse()
延时(1000)
FirstUse()
延时(1000)
执行功能("自动清包")

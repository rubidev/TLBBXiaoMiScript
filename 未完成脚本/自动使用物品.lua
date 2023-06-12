function FirstUse()
    -- 第一轮使用，打开礼盒
    local pkgCount = LUA_取返回值([[return GetActionNum("packageitem");]])
    local patternList = {'真元·.+符', '归宁澄心华盒', '静心雅盒', '.+运功典藏'}
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
                    右键使用(pkgItem)
                    延时(100)
                end
            end
        end
    end
end

function SecondUse()
    -- 第二轮使用，使用道具或丢弃道具
    local pkgCount = LUA_取返回值([[return GetActionNum("packageitem");]])
    local patternList = {'真元·.+符', '归宁澄心华盒', '静心雅盒', '.+运功典藏'}
    local savedItem = {'天外飞仙', '七星聚首', '月落西山', '八阵图', '诛仙阵', '暴雨梨花针', '鹰击长空'}
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
                    右键使用(pkgItem)
                    延时(100)
                end
            end
        end
    end
end

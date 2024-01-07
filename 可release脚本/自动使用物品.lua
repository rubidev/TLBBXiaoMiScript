function FirstUse()
    -- 第一轮使用，打开礼盒
    local pkgCount = LUA_取返回值([[return GetActionNum("packageitem");]])
    local patternList = {
        '真元·.+符', '归宁澄心华盒', '静心雅盒', '.+运功典藏',
		'良品礼扎', '精品礼扎',
        '夏之锦幅', '极光流萤', "心心相印", "夏之圆舞", "荧舞缎飞", "恭贺中秋", "皓月流萤", "天舞宝轮", "人生如梦", "普天同庆","十月流火",
        '落英缤纷',
		'赤铜添福礼箱',
        '竹香筒粽',
        '动作：江湖我行',
        "表情包：",
		"雪芝药散",
        '端午节礼包', '七夕节礼包','盛会同乐礼盒',
        "坐骑：海波晏", "坐骑：鬼马龙舟", "坐骑：极光羽翼", "坐骑：金翼龙兽",
        "宋辽破竹礼·鹤鸣", "宋辽铩羽礼·鹤鸣", "宋辽破竹礼·鹰扬", "宋辽铩羽礼·鹰扬", "宋辽破竹礼·虎啸", "宋辽铩羽礼·虎啸", "宋辽破竹礼·龙腾", "宋辽铩羽礼·龙腾",
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
                        if 窗口是否出现("MessageBox_Self") == 1 then
                            LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
                            延时(1000)
                        end
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
FirstUse()
延时(1000)
执行功能("自动清包")

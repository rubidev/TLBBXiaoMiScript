myName = 获取人物信息(12)
seperateGifts = {}
if myName == "′云．" then
    -- 列出当前角色需要拆解的礼物
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "大红袍", "多宝塔碑帖", "焦尾琴", "山水图", "十样花罗", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "′尘．" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "′雾．" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "十样花罗", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "′星．" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "十样花罗", "天青汝窑瓷",
    }
elseif myName == "′霜．" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "冰素针", "山水图", "十样花罗", "天青汝窑瓷",
    }
elseif myName == "′露．" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "冰素针", "山水图", "十样花罗", "天青汝窑瓷",
    }
elseif myName == "﹎尛妹．ゝ" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "十样花罗", "天青汝窑瓷",
    }
elseif myName == "丶喵咪て" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "冰素针", "十样花罗", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "隐入尘烟" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "听荷丶" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "十样花罗", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "ツEvil、夕瑶" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "十样花罗", "上等马驹", "天青汝窑瓷",
    }
elseif myName == "′﹎摆烂ゝ" then
    seperateGifts = {
        "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "上等马驹", "天青汝窑瓷",
    }
end


-- 勿改
allGift = {
    "竹雅香炉", "青瓷梅子盏", "太湖银鱼", "大红袍", "多宝塔碑帖", "焦尾琴", "冰素针", "山水图", "十样花罗", "上等马驹", "天青汝窑瓷", "菩提木佛珠"
}

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

sepGiftStr = ""
if seperateGifts ~= nil then
    for k, v in pairs(seperateGifts) do
        sepGiftStr = v .. "|" .. sepGiftStr
    end
end
MentalTip(string.format([[您是: %s, 即将开始拆解配置的礼物]], myName))

function SeperateGift()
    for k, giftName in pairs(seperateGifts) do
        if tonumber(获取背包物品数量(giftName)) > 0 then
            MentalTip(string.format([[开始拆解: %s]], giftName))
            右键使用物品(giftName)
            延时(1000)

            LUA_Call([[
                setmetatable(_G, {__index = Gift_Reuse_Env});Gift_Reuse_ConfirmClick()
            ]])

            延时(1000)

            LUA_Call([[
                setmetatable(_G, {__index = MessageBox_Self3_Env});MessageBox_Self3_OnOk()
            ]])
            延时(1000)
        end
    end
end

function main()
    取出物品("竹雅香炉|青瓷梅子盏|太湖银鱼|大红袍|多宝塔碑帖|焦尾琴|冰素针|山水图|十样花罗|上等马驹|天青汝窑瓷|菩提木佛珠")
    while true do
        跨图寻路("大理", 206, 53)
        延时(500)
        local myX = 获取人物信息(7)
        local myY = 获取人物信息(8)
        if tonumber(myX) == 206 and tonumber(myY) == 53 then
            break
        end
    end

    对话NPC("沈暝楼")
    延时(1000)
    NPC二级对话("礼物拆解")
    延时(2000)

    SeperateGift()

    延时(500)

    LUA_Call([[setmetatable(_G, {__index = Gift_Reuse_Env});Gift_Reuse_OnClose()]])

end

main()
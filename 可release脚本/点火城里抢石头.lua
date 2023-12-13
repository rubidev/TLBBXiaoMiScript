帮火黑名单 = "不灭神话|‖众神之巅‖|天神山庄|德云社"  -- 多个帮用 | 分开, 帮会名支持模糊匹配, "" 表示不判断帮火


function StringSplit(str, reps)
    -- 字符串切割
    local resultStrList = {}
    string.gsub(str, '[^' .. reps .. ']+',
            function(w)
                table.insert(resultStrList, w)
            end
    )
    return resultStrList
end

function GetCurrentTime()
    local cur_hour = tonumber(os.date("%H", os.time()))
    local cur_minute = tonumber(os.date("%M", os.time()))
    local cur_second = tonumber(os.date("%S", os.time()))
    local current_timestamp = tonumber(os.time())
    return cur_hour, cur_minute, cur_second, current_timestamp
end

function judgeGuildWar(enemyGuildName)
    LUA_Call([[
        setmetatable(_G, {__index = MiniMap_Env});MiniMap_XuanZhanList();
    ]])
    延时(5000)
    LUA_Call([[setmetatable(_G, {__index = NewBangHui_RankingList_Env});NewBangHui_RankingList_Close();]])

    local is_fight = LUA_取返回值(string.format([[
        local enemyGuildName = "%s"
        local nRankListNum = City:GetBattleRankListNum();
        if nRankListNum == 0 then
            return 0;
        end

        for i = 0, nRankListNum-1 do
            local RivalGuildNameOnly = City:EnumBattleRankList(i,"RivalGuildNameOnly")
            local xzType             = City:EnumBattleRankList(i,"XuanZhanType")
            if string.find(RivalGuildNameOnly, enemyGuildName) then
                return 1
            end
        end
        return 0
    ]], enemyGuildName))

    if tonumber(is_fight) == 1 then
        MentalTip(string.format("当前有【%s】的火", enemyGuildName))
        return true
    else
        return false
    end
end

-- 主函数 ------------------------------------------------------------------------
-- 判断是否有黑名单帮火
waitInCity = false
local guildFireBlack = StringSplit(帮火黑名单, "|")
for i = 1, #guildFireBlack do
    local hasBlackFire = judgeGuildWar(guildFireBlack[i])
    if hasBlackFire then
        waitInCity = true
        break
    end
end

if waitInCity then
    MentalTip("您的帮会存在黑名单帮会帮火, 回城抢宝石！")
    执行功能("回城待命")
    执行功能("同步游戏时间")
    while true do
        LUA_Call([[setmetatable(_G, {__index = ChatFrame_Env});Chat_ChangeTabIndex(2);]])
        local cur_h, cur_m, cur_s, _ = GetCurrentTime()
        if cur_h == 23 and cur_m == 55 and cur_s == 59 then
            执行功能("存仓补给")
            break
        end
        执行功能("抢包世商")
        执行功能("存仓补给")
        延时(60000)
    end
end
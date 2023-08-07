-- 序号对应的按钮信息
-- 1 珍兽商店
-- 2 随身仓库
-- 3 表情包
-- 4 炫装
-- 5 周奖励
-- 6 定位
-- 7 修理装备
-- 8 增加可修理次数
-- 9 神器修理
-- 11 冻领双
-- 12 双人动作
-- 13 珍兽银行
-- 14 未知
-- 15 未知
-- 17 年终回馈
-- 18 武魂延寿
-- 19 未知
-- 21 宝石乾坤移
-- 22 年中回馈

-- 领周道具奖励
LUA_Call(string.format([[
    Clear_XSCRIPT()
        Set_XSCRIPT_Function_Name("OnUseVIP")
        Set_XSCRIPT_ScriptID(889644)
        Set_XSCRIPT_Parameter(0, %d)
        Set_XSCRIPT_ParamCount(1)
    Send_XSCRIPT()
]], 5))
延时(1000)

右键使用物品("赤铜添福礼箱")
右键使用物品("银丝纳福礼箱")
--右键使用物品("xxx礼箱")  -- VIP9 礼箱

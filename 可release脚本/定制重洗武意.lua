保留的属性 = { "血上限", "冰攻击", "火攻击", "玄攻击", "毒攻击"}
-- 保留的属性可选： "血上限", "冰攻击", "火攻击", "玄攻击", "毒攻击", "命中", "闪避", "穿刺伤害", "穿刺减免"

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品, 必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function GetAttrPoint(attrIndex)
    local attrPoint = LUA_取返回值(string.format([[
        local attrIndex = %d
        local point = MaritialSys:GetMaritiaAttrByIndex(attrIndex)
        return point
    ]], attrIndex))
    return tonumber(attrPoint)
end

function WashWuYi(attrIndex)
    LUA_Call(string.format([[
        local nIdx = %d
        Clear_XSCRIPT()
            Set_XSCRIPT_Function_Name( "RecycleAttrPoint" )
            Set_XSCRIPT_ScriptID( 507010 )
            Set_XSCRIPT_Parameter(0, nIdx)
            Set_XSCRIPT_Parameter(1, 1)  -- 后面为0, 会购买紫府星髓，但是不会使用
            Set_XSCRIPT_ParamCount(2)
        Send_XSCRIPT()
    ]], attrIndex))
end

function Main()
    local WuYi_ShuXing2Name = {
        [0] = "血上限",
        [1] = "冰攻击",
        [2] = "火攻击",
        [3] = "玄攻击",
        [4] = "毒攻击",
        [5] = "命中",
        [6] = "闪避",
        [7] = "穿刺伤害",
        [8] = "穿刺减免",
    }

    local ZFXSCount = 获取背包物品数量("紫府星髓")
    if ZFXSCount <= 0 then
        MentalTip("请确保背包中有【紫府星髓】")
        return
    end

    local uselessAttrIndex = {}
    for SXIndex, SXName in pairs(WuYi_ShuXing2Name) do
        local matched = 0
        for k, targetSXName in pairs(保留的属性) do
            if SXName == targetSXName then
                matched = 1
                break
            end
        end
        if matched == 0 then
            uselessAttrIndex[SXIndex] = SXIndex
        end
    end

    for i=8, 0, -1 do
        if uselessAttrIndex[i] ~= nil then
            if 获取背包物品数量("紫府星髓") <= 0 then
                MentalTip("背包中已没有【紫府星髓】")
                return
            end
			
            local delAttrIndex = uselessAttrIndex[i]
            local currentAttrPoint = GetAttrPoint(delAttrIndex)
            if currentAttrPoint > 0 then
                local canWashCount = 0
                if ZFXSCount > currentAttrPoint then
                    canWashCount = currentAttrPoint
                else
                    canWashCount = ZFXSCount
                end
                MentalTip(string.format("开始洗【%s】, 可洗【%d】次", WuYi_ShuXing2Name[delAttrIndex], canWashCount))

                for i = 1, canWashCount do
                    WashWuYi(delAttrIndex)
                    延时(200)
                end
            end
        end
    end
end

-- ------------------------- MAIN ----------------------------------------------------
local keepAttr = ""
for key, value in pairs(保留的属性) do
    keepAttr = keepAttr .. value .. ","
end
MentalTip(string.format("开始洗武意, 洗成以下属性：%s", keepAttr))
MentalTip(string.format("开始洗武意, 洗成以下属性：%s", keepAttr))
MentalTip(string.format("开始洗武意, 洗成以下属性：%s", keepAttr))
取出物品("紫府星髓")
延时(1000)
while true do
    if 获取背包物品数量("紫府星髓") <= 0 then
        MentalTip("背包中已没有【紫府星髓】")
        break
    end
    Main()
end

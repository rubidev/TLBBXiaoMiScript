需要的属性 = {
    "血上限",
    "毒攻击",
    "玄攻击",
    "火攻击",
    "冰攻击",
    "体力",
    "所有属性",
}

allSuperWeapon = "万壑松风扇|雷鸣离火扇|碧海银涛环|碎情雾影环|溶金落日刀|赤焰九纹刀|秋水无痕剑|含光弄影剑|紫阳绝翎弩|凌霄玉琼弩|碧海凌波杖|太虚归星杖|百代鸿光箫|天地乐同箫|大夏龙雀|大商尘影|大周岚夜|大周岚夜|大汉弘纲|大晋星痕|大隋凝霜|大唐昆岳|大宋君岑|归墟|幽冥|神隐|入灭|帝阙|天谕|伏龙|释迦|明尊"

function MentalTip(text, ...)
    local strCode = string.format(text, ...)
    LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【雨夜出品,必是精品】".."#eFF0000".."%s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function SuperWeaponWash(superWeaponName)
    if string.find(allSuperWeapon, superWeaponName) then
        if 窗口是否出现("SuperWeaponUpNEW") == 1 then
            右键使用物品(装备名称, 1)  --参数2为使用次数1次，可省略，默认为1次
            LUA_Call("setmetatable(_G, {__index = SuperWeaponUpNEW_Env});SuperWeaponUpNEW_Buttons_Clicked();")
            延时(1500)
            break
        end
    end

    延时(1500)
end

function checkWashAfterAttr()
    local newAttr = LUA_取返回值(string.format([[
		local num =  DataPool : Lua_GetRecoinNum();
		local str = ""
		for i = 0, num-1 do
			local tempstr = DataPool :Lua_GetRecoinEnumAttr(i)
			if string.find(tempstr, "#{") then
				local left = string.find(tempstr, "#{")
				local left2 = string.find(tempstr, "}")
				strTemp = GetDictionaryString(string.sub(tempstr, left+2, left2-1))
			end
			str = str..strTemp.."|"
		end
		return  str
	]], "s"))
    local satisfiedCount = 0
    for i = 1, #需要的属性 do
        if string.find(newAttr, 需要的属性[i]) then
            satisfiedCount = satisfiedCount + 1
        end
    end

    if satisfiedCount == #需要的属性 then
        return 1
    end
    return -1
end

function WashShenQi()
	MentalTip("开始洗炼魂")
    LUA_Call(string.format([[
    	local allSuperWeapon = "%s"
		local currNum = DataPool:GetBaseBag_RealMaxNum();
        for i=1, currNum do
            theAction,bLocked = PlayerPackage:EnumItem("base", i-1);  -- szPacketName = "base"、"material"、"quest"
			local sName = theAction:GetName();
			if string.find(allSuperWeapon, sName) ~= nil then
				petEquipCount = petEquipCount + 1
			end
        end
	]], allSuperWeapon, ))


	跨图寻路("苏州", 354, 240);
	延时(1500)
	对话NPC("欧治于")
	NPC二级对话("神器炼魂", 0)      --参数1：对话文本  参数2:模糊对话，0表示精确 1表示模糊
	延时(1500)
end
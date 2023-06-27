--获取暗器技能洗后的三个新技能
function GetAfterAttr()
	local aS1 = LUA_取返回值("setmetatable(_G, {__index = AnqiShuxingNEW_Env});return AnqiShuxingNEW_AfterAttrFirst:GetText()")
	local aS2 = LUA_取返回值("setmetatable(_G, {__index = AnqiShuxingNEW_Env});return AnqiShuxingNEW_AfterAttrSecond:GetText()")
	local aS3 = LUA_取返回值("setmetatable(_G, {__index = AnqiShuxingNEW_Env});return AnqiShuxingNEW_AfterAttrThird:GetText()")
	return aS1, aS2, aS3
end
--判断背包金钱是否充足,充足返回true，不够返回false
function 判断背包金钱是否充足()
	local Money = LUA_取返回值("return Player:GetData('MONEY')")
	local JZ = LUA_取返回值("return Player:GetData('MONEY_JZ')")
	if (tonumber(Money) + tonumber(JZ)) >= 50000 then
		return true
	else
		return false
	end
end

function 关闭窗口(strWindowName)
    if 窗口是否出现(strWindowName)==1 then
		屏幕提示("关闭窗口")
		LUA_Call(string.format([[
	        setmetatable(_G, {__index = %s_Env}) this:Hide()  
		]], strWindowName), "n")
	end
end

function 取下暗器(暗器名称)
    while 获取背包物品数量(暗器名称) == 0  do 
		延时(1000)
		LUA_Call("MainMenuBar_SelfEquip_Clicked();")
		if 窗口是否出现 ("SelfEquip") ==1 then
			延时(500)
			LUA_Call("SelfEquip_Equip_Click(14,0);")
			延时(500)
			LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});SelfEquip_CloseUI();")
			延时(500)
		end
	end
end

function 取材料()
    取出物品("忘无石")  
	取出物品("金币") 
	--存物品 ("千淬神玉|百淬神玉",0,1,1) ---多次一举只为了用不绑定物品 老区可以取消掉
    if 获取背包物品数量("忘无石") == 0 then
	   屏幕提示("没有材料") 
	   return		
    end
end

function 装备暗器(暗器名称)
    for i=1,5 do
        if 窗口是否出现("AnqiShuxingNEW") == 1 then 
	        关闭窗口("AnqiShuxingNEW")
			右键使用物品(暗器名称,1)														
        else
            右键使用物品(暗器名称,1)    --参数2:为使用次数
        end
        延时(1000)
        if  tonumber(LUA_取返回值("return EnumAction(17,'equip'):GetID();")) > 0 then  --装备成功
            break   
        end
    end
end


local 暗器名称 = LUA_取返回值("return EnumAction(17,'equip'):GetName();")
屏幕提示(暗器名称) 
--local str = "冰属性攻击|火属性攻击|玄属性攻击|毒属性攻击|" --str 只取其中一个

取材料()	
取下暗器(暗器名称)
跨图寻路("洛阳",208,343)
延时(1000)
if 对话NPC("燕青")==1 then
	延时(1000)
	NPC二级对话("重洗暗器基础技能")
	延时(500)
	if 窗口是否出现("AnqiShuxingNEW") == 1 then
		右键使用物品(暗器名称, 1)
		延时(1000)
		while (判断背包金钱是否充足() == true and 获取背包物品数量("忘无石") > 0) do
			LUA_Call("setmetatable(_G, {__index = AnqiShuxingNEW_Env});AnqiShuxingNEW_OK_Clicked();")--这里是洗的确认按钮
			延时(1000)
			local aS1, aS2, aS3 = GetAfterAttr()
			if string.find(aS3,"血上限")  and string.find(aS3, "气上限") and string.find(aS2, "散功") then
				LUA_Call("setmetatable(_G, {__index = AnqiShuxingNEW_Env});AnqiShuxingNEW_SaveChange_Clicked(0);")--点击替换按钮
				break
			end
		end
	end
end
跨图寻路("洛阳",208,321)
装备暗器(暗器名称)
执行功能("自动存仓")


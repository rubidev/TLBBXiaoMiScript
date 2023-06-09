
function 晴天_友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#e0000ff".."【晴天提示】".."#eFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
	]], strCode))
end

function 晴天_取背包物品数量(物品列表,是否绑定)
	if 是否绑定 ==0 or 是否绑定 == nil then
		tbangding =10
	elseif  是否绑定 ==1 then
		tbangding = 0
	elseif  是否绑定 ==2 then
		tbangding = 1
	end
	local tem = LUA_取返回值(string.format([[
		tem = 0
		for i= 0, 200 do
			tbangding =tostring("%s")
			ttname = "%s"
			local theAction=EnumAction(i,"packageitem")
			local GetName=theAction:GetName()
			
			local Status=GetItemBindStatus(i);
			if GetName~=nil and GetName ~="" then
				if string.find(ttname,GetName ,1,true) then
					if string.find(tbangding,tostring(Status)) then
						local szItemNum =theAction:GetNum();
						tem=tem+szItemNum
					end	
				end
			end
		end	
		return tem
			]],tbangding,物品列表))
	return tonumber(tem)		
end
		
		
function 晴天_龙纹重洗(index)
	LUA_Call(string.format([[
		local atime =DataPool:GetServerDayTime()
		if atime >= 20220201 then
			return
		end
		m_Equip_Idx=%d
		Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("Lw_PropertyReset");
			Set_XSCRIPT_ScriptID(809273);
			Set_XSCRIPT_Parameter(0,m_Equip_Idx);
			Set_XSCRIPT_ParamCount(1);
		Send_XSCRIPT();
		 ]], index))
end


function 晴天_龙纹确定(序号)
	LUA_Call(string.format([[
			 Clear_XSCRIPT();
			Set_XSCRIPT_Function_Name("DoRefreshLw_Property");
			Set_XSCRIPT_ScriptID(809273);
			Set_XSCRIPT_Parameter(0,%d);
			Set_XSCRIPT_Parameter(1,0);
			Set_XSCRIPT_ParamCount(2);
		Send_XSCRIPT();
		 ]], 序号))
end

		
		
function 晴天_取龙纹重洗后重的属性()
	local isWQ = LUA_取返回值(string.format([[
		local atime =DataPool:GetServerDayTime()
		if atime >= 20220201 then
			return
		end
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
	return tostring(isWQ) 
end
		
function 晴天_取龙纹重洗后重的属性条数()
	local isWQ = LUA_取返回值(string.format([[
		local num =  DataPool : Lua_GetRecoinNum();
		return num
				 ]], "n"))
	return tonumber(isWQ) 
end


-------------------------------------------------------------------------
不要属性=
{ 
"内功攻击",
"外功攻击",
"灵气",
"力量",
"内功防御",
"外功防御",
"定力",
"气上限",
"会心防御",
}

		
		

			
function 晴天_自动龙纹极品重洗(总条数,不要条数)
		跨图寻路("凤鸣镇",125,201);延时(1500)
		序号 = 获取背包物品位置("龙纹")-1
		晴天_友情提示("序号"..序号)
		
		if tonumber(序号) < 0 then
			return
		end

	while  true do

		if 晴天_取背包物品数量("净云水",2) < 7 then
			晴天_友情提示("净云水少于7个停止")
			return
		end	
		晴天_龙纹重洗(序号)
		延时(3000)
		if 晴天_取龙纹重洗后重的属性条数() >=总条数 then
			重洗后的属性= 晴天_取龙纹重洗后重的属性()
			晴天_友情提示(重洗后的属性)
			条数 = 0
			for i=1,#不要属性 do
				if string.find(重洗后的属性,不要属性[i]) then
					条数=条数+1
				end
			end
			晴天_友情提示("不要属性条数:"..条数)
			延时(3000)
			if tonumber(条数) <= 不要条数 then
				晴天_龙纹确定(序号)
				return
			end	
		end
		延时(3000)
	end
end
-------------------------------------------------------------------------------------------

local 人物名称,门派,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()

确定属性 ={
["天山"]={ "血上限","冰攻击","体力","外功",},
["鬼谷"]={ "血上限","冰攻击","体力","外功",},

["逍遥"]={ "血上限","冰攻击","体力","外功",},


}

function 晴天_自动龙纹门派重洗()
		跨图寻路("凤鸣镇",125,201);延时(1500)
		序号 = 获取背包物品位置("龙纹")-1
		晴天_友情提示("序号"..序号)
		
		if tonumber(序号) < 0 then
			return
		end

	while  true do
		延时(3000)
		if 获取背包物品数量("净云水") < 7 then
			晴天_友情提示("净云水少于7个停止")
			return
		end	
			重洗后的属性= 晴天_取龙纹重洗后重的属性()
			晴天_友情提示(重洗后的属性)
			tem = 0
			
			for i=1,#确定属性[门派] do
				if  string.find(重洗后的属性,确定属性[门派][i]) then
					tem =tem +1
				end
			end
			if tem ==table.getn(#天山) then
				晴天_友情提示("属性确定啦:"..tem)
				延时(3000)
				晴天_龙纹确定(序号)
				return
			end	
		晴天_龙纹重洗(序号)
		延时(3000)
	end
end
--晴天_自动龙纹门派重洗()
---------------------------------------------------------------------------------------------------------------------

--晴天_自动龙纹极品重洗(总条数,不要条数)  
--总条数 大于等于
--不要条数小于等于

晴天_自动龙纹极品重洗(7,1)  

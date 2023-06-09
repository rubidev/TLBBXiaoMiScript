
function PushDebugMessage(str, ...)
	local str = string.format(str, ...)
	屏幕提示(str)
end
function IsPetPresent(index)
	local n = LUA_取返回值(string.format([[
		if Pet:IsPresent(%d) then
			return 1
		else
			return 0
		end
	]],index))
	if tonumber(n) == 1 then
		return true
	else
		return false
	end
end
function GetPetGuid(index)
	local nHigh = LUA_取返回值(string.format("local nHigh, nLow = Pet:GetGUID(%d);return nHigh",index))
	nHigh = tonumber(nHigh)
	local nLow = LUA_取返回值(string.format("local nHigh, nLow = Pet:GetGUID(%d);return nLow",index))
	nLow = tonumber(nLow)
	return nHigh,nLow
end

------------------------------------------------------------------------
PushDebugMessage("开始执行珍兽血脉觉醒任务")

	    跨图寻路("苏州",171,230)
        对话NPC("云瞳瞳")
        延时(1000)
        NPC二级对话("珍兽血脉觉醒")
		延时(1000)
local par={
	[0] = {nHigh = 0, nLow = 0},
	[1] = {nHigh = 0, nLow = 0},
	[2] = {nHigh = 0, nLow = 0},
	[3] = {nHigh = 0, nLow = 0},
	[4] = {nHigh = 0, nLow = 0},
	[5] = {nHigh = 0, nLow = 0},
	[6] = {nHigh = 0, nLow = 0},
	[7] = {nHigh = 0, nLow = 0},
	[8] = {nHigh = 0, nLow = 0},
	[9] = {nHigh = 0, nLow = 0},	
}
for i=0,9 do
	if IsPetPresent(i) then
		par[i].nHigh, par[i].nLow = GetPetGuid(i)
		local nTakeLevel = LUA_取返回值(string.format("return Pet:GetAllPetTakeLevelByGUID(%d, %d)",par[i].nHigh, par[i].nLow))
		local nPetTradeTime = LUA_取返回值(string.format("local nToBeGrade, nToBeLevel, nCurNeedExp, nPetTradeTime, nCurExp, nJinJieGrade, nJinJieLevel = Pet:GetCanBeJinJieInfo(%d, %d, 33980);return nPetTradeTime",par[i].nHigh, par[i].nLow))
		local nJinJieGrade = LUA_取返回值(string.format("local nToBeGrade, nToBeLevel, nCurNeedExp, nPetTradeTime, nCurExp, nJinJieGrade, nJinJieLevel = Pet:GetCanBeJinJieInfo(%d, %d, 33980);return nJinJieGrade",par[i].nHigh, par[i].nLow))
		nTakeLevel, nPetTradeTime, nJinJieGrade = tonumber(nTakeLevel), tonumber(nPetTradeTime), tonumber(nJinJieGrade)
		if nTakeLevel < 55 or nJinJieGrade >= 10 or nPetTradeTime == nil then
			par[i].nHigh=0
			par[i].nLow=0
		end
	end
end

LUA_Call(string.format([[
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "OnPetAwake" )
		Set_XSCRIPT_ScriptID( 892305 )
		Set_XSCRIPT_Parameter( 0, 0 )
		Set_XSCRIPT_Parameter( 1, %d )
		Set_XSCRIPT_Parameter( 2, %d )
		Set_XSCRIPT_Parameter( 3, %d )
		Set_XSCRIPT_Parameter( 4, %d )
		Set_XSCRIPT_Parameter( 5, %d )
		Set_XSCRIPT_Parameter( 6, %d )
		Set_XSCRIPT_Parameter( 7, %d )
		Set_XSCRIPT_Parameter( 8, %d )
		Set_XSCRIPT_Parameter( 9, %d )
		Set_XSCRIPT_Parameter( 10, %d )
		Set_XSCRIPT_ParamCount( 11 )
	Send_XSCRIPT()
]],par[0].nHigh,par[0].nLow,par[1].nHigh,par[1].nLow,par[2].nHigh,par[2].nLow,par[3].nHigh,par[3].nLow,par[4].nHigh,par[4].nLow))

Sleep(1000)

LUA_Call(string.format([[
	Clear_XSCRIPT()
		Set_XSCRIPT_Function_Name( "OnPetAwake" )
		Set_XSCRIPT_ScriptID( 892305 )
		Set_XSCRIPT_Parameter( 0, 0 )
		Set_XSCRIPT_Parameter( 1, %d )
		Set_XSCRIPT_Parameter( 2, %d )
		Set_XSCRIPT_Parameter( 3, %d )
		Set_XSCRIPT_Parameter( 4, %d )
		Set_XSCRIPT_Parameter( 5, %d )
		Set_XSCRIPT_Parameter( 6, %d )
		Set_XSCRIPT_Parameter( 7, %d )
		Set_XSCRIPT_Parameter( 8, %d )
		Set_XSCRIPT_Parameter( 9, %d )
		Set_XSCRIPT_Parameter( 10, %d )
		Set_XSCRIPT_ParamCount( 11 )
	Send_XSCRIPT()
]],par[5].nHigh,par[5].nLow,par[6].nHigh,par[6].nLow,par[7].nHigh,par[7].nLow,par[8].nHigh,par[8].nLow,par[9].nHigh,par[9].nLow))

取出物品("福降令")

延时(2000)

FJLCount = 获取背包物品数量("福降令")

if tonumber(FJLCount) > 0 then
	while true do
	    跨图寻路("洛阳",270,256)
		延时(2000)
		local myX = tonumber(获取人物信息(7))
		local myY = tonumber(获取人物信息(8))
		if myX == 270 and myY == 256 then
			break
		end
	end
	延时(2000)

	对话NPC("乔致广")
	延时(1000)
	NPC二级对话("福降天龙")
	延时(2000)
	LUA_Call([[setmetatable(_G, {__index = FuJiangTianLongHD_Env});FuJiangTianLongHD_DoBless();]])
	--LUA_Call([[
	--local bConfirm = tonumber( NpcShop:GetFuJiangTLBuyDirectly() );
	--local isHasFJL = PlayerPackage:CountAvailableItemByIDTable(g_FJL_ItemID) + Bank:GetUnlockTemBankItemCount(g_FJL_ItemID);
	--
	--if isHasFJL >= 1 then
	--	Clear_XSCRIPT();
	--		Set_XSCRIPT_Function_Name( "bConfirm_FJL" );	-- 函数名
	--		Set_XSCRIPT_ScriptID( 890509 );			-- 脚本号
	--		Set_XSCRIPT_ParamCount( 0 );			-- 参数个数
	--	Send_XSCRIPT();  --2019福降令
	--elseif ( bConfirm >= 1 ) then
	--	-- 执行脚本
	--	Clear_XSCRIPT();
	--		Set_XSCRIPT_Function_Name( "DoBless" );	-- 函数名
	--		Set_XSCRIPT_ScriptID( 890509 );			-- 脚本号
	--		Set_XSCRIPT_Parameter( 0, 1 );			-- 0:非活动界面 1:活动界面
	--		Set_XSCRIPT_ParamCount( 1 );			-- 参数个数
	--	Send_XSCRIPT();
	--
	--]])
	延时(1000)
	LUA_Call([[setmetatable(_G, {__index = MessageBox_Self_Env});MessageBox_Self_OK_Clicked();]])
	
end



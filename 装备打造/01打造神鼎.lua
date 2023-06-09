屏幕提示("等级100级以上自动判断最高属性,否则设置好门派冰火玄毒")

function 取角色主属性()
local  人物名称,menpai,PID,远近攻击,内外攻击,角色账号,门派地址,技能状态,性别=获取人物属性()
if tonumber(获取人物信息(26))>=100 then
    local tem =LUA_取返回值(string.format([[
	local iIceAttack  		= Player:GetData( "ATTACKCOLD" );
	local iFireAttack 		= Player:GetData( "ATTACKFIRE" );
	local iThunderAttack	= Player:GetData( "ATTACKLIGHT" );
	local iPoisonAttack		= Player:GetData( "ATTACKPOISON" );
	local tt={ iIceAttack, iFireAttack, iThunderAttack,iPoisonAttack}
	if iIceAttack==math.max(unpack(tt)) then
		maxOfT =1;PushDebugMessage("人物主属性:冰");
	elseif  iFireAttack==math.max(unpack(tt)) then
		maxOfT =2;PushDebugMessage("人物主属性:火");
	elseif  iThunderAttack==math.max(unpack(tt)) then
		maxOfT =3;PushDebugMessage("人物主属性:玄");
	elseif  iPoisonAttack==math.max(unpack(tt)) then
		maxOfT =4;PushDebugMessage("人物主属性:毒");
	end
	return maxOfT 
	]]), "n")
	return tonumber(tem)
else
if string.find("峨嵋|天山|武当", menpai) then
	属性攻击=1;屏幕提示("人物主属性:冰"..属性攻击)
elseif  string.find("逍遥|明教|", menpai) then
	属性攻击=2;屏幕提示("人物主属性:火"..属性攻击)
elseif  string.find("天龙|少林|鬼谷|慕容|", menpai) then
	属性攻击=3;屏幕提示("人物主属性:玄"..属性攻击)
elseif  string.find("唐门|星宿|丐帮", menpai) then
	属性攻击=4;屏幕提示("人物主属性:毒"..属性攻击)
end
	return tonumber(属性攻击)
end
end



function 关闭窗口(strWindowName)
	if 窗口是否出现(strWindowName)==1 then
		屏幕提示("关闭窗口:"..strWindowName)
	  LUA_Call(string.format([[
		setmetatable(_G, {__index = %s_Env}) this:Hide()  
	 ]], strWindowName))  
	 end
end

function 自动判断打开窗口()
    if 窗口是否出现("SelfShenDing")==0 then
		if 窗口是否出现("SelfEquip")==0 then
			屏幕提示("打开装备包裹")
			LUA_Call ("MainMenuBar_SelfEquip_Clicked();")
			延时(2000)
		end
		 if 窗口是否出现("SelfShenDing")==0 then
			屏幕提示("选择神木王鼎")
			LUA_Call("setmetatable(_G, {__index = SelfEquip_Env});Other_ShenDing_Page_Switch();")
			延时(2000)
		end
    end
	
end


function 乾元凝丹()
	LUA_Call(string.format([[
		setmetatable(_G, {__index = SelfShenDing_Env});
		SelfShenDing_ChangeTabIndex(0);
		setmetatable(_G, {__index = SelfShenDing_Env});
		SelfShenDing_NingLian();
	 ]]))  
end	

function 坤武凝丹()
	LUA_Call(string.format([[
		setmetatable(_G, {__index = SelfShenDing_Env});
		SelfShenDing_ChangeTabIndex(1);
		setmetatable(_G, {__index = SelfShenDing_Env});
		SelfShenDing2_NingLian();
	 ]],AAA))  
end	
------------------------------------------------------------
function 取药尘数量()
local tem=LUA_取返回值(string.format([[
local nYaoChen = Player:GetData("YaoChenValue");
return tonumber(nYaoChen) 
	 ]])) 
		return tonumber(tem)
end

function 取乾元需要药尘数量()
local tem=LUA_取返回值(string.format([[
	setmetatable(_G, {__index = SelfShenDing_Env});
local str=SelfShenDing_XuYaoYaoChen_Text:GetText();
local n1 = string.find(str,'：')
if n1 then
return tonumber(string.sub(str, n1+2))
end
return 0
		 ]]))  
		return tonumber(tem)
end

function 取坤武需要药尘数量()
local tem=LUA_取返回值(string.format([[
	setmetatable(_G, {__index = SelfShenDing_Env});
local str=SelfShenDing_XuYaoYaoChen_Text:GetText();
local n1 = string.find(str,'：')
if n1 then
return tonumber(string.sub(str, n1+2))
end
return 0
		 ]]))  
		return tonumber(tem)
end

function 神木王鼎自动加点(AAA)
	LUA_Call(string.format([[	
		local tem= tonumber(Player:GetData("Attack_QianNengPoint"));
		if tem <=0 then
			return
		end
	
		local nIce, nFire, nThunder, nPoison = Player:GetData("Attack_IFTPValue");
		local Index=tonumber(%d)
		if Index==1 then
			PushDebugMessage("神鼎属性点数:"..tem.."|自动加属性:冰")
			nIce2=tem;nFire2=0;nThunder2=0;nPoison2=0;
		end
		if Index==2 then
			PushDebugMessage("神鼎属性点数:"..tem.."|自动加属性:火")
			nIce2=0;nFire2=tem;nThunder2=0;nPoison2=0;
		end
		if Index==3 then
			PushDebugMessage("神鼎属性点数:"..tem.."|自动加属性:玄")
			nIce2=0;nFire2=0;nThunder2=tem;nPoison2=0;
		end
		if Index==4 then
			PushDebugMessage("神鼎属性点数:"..tem.."|自动加属性:毒")
			nIce2=0;nFire2=0;nThunder2=0;nPoison2=tem;
		end
	
	Clear_XSCRIPT();
		Set_XSCRIPT_Function_Name("OnLianDanLuQianNengAccept");
		Set_XSCRIPT_ScriptID(339011);
		Set_XSCRIPT_Parameter(0, tonumber(nIce)+nIce2)
		Set_XSCRIPT_Parameter(1, tonumber( nFire)+nFire2 )
		Set_XSCRIPT_Parameter(2, tonumber(nThunder) +nThunder2)
		Set_XSCRIPT_Parameter(3, tonumber(nPoison) +nPoison2)
		Set_XSCRIPT_ParamCount(4);
	Send_XSCRIPT();
  ]],AAA))  
end		
		
function 全自动判断神木王鼎()
	屏幕提示("★★★★晴天★★★★---全自动判断神木王鼎")
	取出物品("玄机药尘")  
	while 获取背包物品数量("玄机药尘")>=1 do
		屏幕提示("玄机药尘-自动使用")
		延时(500)
		右键使用物品("玄机药尘",1)  
		延时(500)
	end 
	for i=1,5 do
		自动判断打开窗口()
		if 取药尘数量()>=取乾元需要药尘数量() then
			乾元凝丹()
			延时(2000)
		end
		if 取药尘数量()>=取坤武需要药尘数量() then
			坤武凝丹()
			延时(2000)	
		end
	end
	神木王鼎自动加点(取角色主属性())
	关闭窗口("SelfShenDing")
end

全自动判断神木王鼎()
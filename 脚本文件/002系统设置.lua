local 附近频道 = "1"
local 队伍频道 = "0"
local 世界频道 = "0"
local 私聊信息 = "0"
local 系统频道 = "0"
local 自建频道 = "0"		--系统预留功能，为0就好
local 帮会频道 = "0"
local 门派频道 = "0"
local 个人信息 = "1"
local 帮助频道 = "0"
local 喇叭频道 = "1"
local 同城频道 = "0"
local 同盟频道 = "0"
local 团队频道 = "0"
local 小队频道 = "0"		--系统预留功能，为0就好
local 千里传音 = "0"		--系统预留功能，为0就好
local 古境频道 = "0"
local 势力频道 = "0"		--系统预留功能，为0就好
local 征召频道 = "0"		--系统预留功能，为0就好
local 传音入密 = "0"		--系统预留功能，为0就好
local T服信息 = "0"		--系统预留功能，为0就好
local 连杀信息 = "0"
local 世族频道 = "0"		--2014Q1大世界改造，世族功能去除。为0就好
--只改上面，1=选中，0=取消
local strConfig = 附近频道
strConfig=strConfig..队伍频道
strConfig=strConfig..世界频道
strConfig=strConfig..私聊信息
strConfig=strConfig..系统频道
strConfig=strConfig..自建频道
strConfig=strConfig..帮会频道
strConfig=strConfig..门派频道
strConfig=strConfig..个人信息
strConfig=strConfig..帮助频道
strConfig=strConfig..喇叭频道
strConfig=strConfig..同城频道
strConfig=strConfig..同盟频道
strConfig=strConfig..团队频道
strConfig=strConfig..小队频道
strConfig=strConfig..千里传音
strConfig=strConfig..古境频道
strConfig=strConfig..势力频道
strConfig=strConfig..征召频道
strConfig=strConfig..传音入密
strConfig=strConfig..T服信息
strConfig=strConfig..连杀信息
strConfig=strConfig..世族频道
local isFenpingOpen = tonumber(LUA_取返回值("return Talk:IsFenpingOpen()") )
if isFenpingOpen == 0 then
	LUA_Call("Talk:CreateFenping('"..strConfig.."');")
end
if isFenpingOpen == 1 then
	LUA_Call("Talk:ConfigFenping('"..strConfig.."');")
end

local 游戏设置lua = [[
SystemSetup:View_SetData( "wtdh",0 );    --物体动画
SystemSetup:View_SetData( "dhgxzl",0 );   --角色动画
SystemSetup:View_SetData( "ksfw",0 );   --显示模型数 可视范围
SystemSetup:View_SetData( "mxxslj",0 );   --模型显示, NPC 和 玩家 优先
SystemSetup:View_SetData( "yszl",0 );
SystemSetup:View_SetData( "rwyy",0 );   --人物阴影
SystemSetup:View_SetData( "dxyy",0 );
SystemSetup:View_SetData( "txdjsz",0 );   --粒子效果
SystemSetup:View_SetData( "miwu",0 );   --显示迷雾
SystemSetup:View_SetData( "zdbt",0 );   --遮挡半透
SystemSetup:View_SetData( "cztb",0 );  --垂直同步
SystemSetup:View_SetData( "mrsj",0 );-- 经典视距
SystemSetup:View_SetData( "jzcj",0 );
SystemSetup:View_SetData( "rt",0 );
SystemSetup:View_SetData( "mxtx",0 );  --模型特效
SystemSetup:View_SetData( "tksj",0 );   --天空视角
SystemSetup:View_SetData( "tm",1 );-- 替模
SystemSetup:View_SetData( "fhj",0 );   --全屏抗锯齿
SystemSetup:View_SetData( "cy",0 );   --采样
SystemSetup:View_SetData( "qpfg",0 );   --全屏泛光
SystemSetup:View_SetData( "hdr",0 );   --HDR
Variable:SetVariable("View_Resoution", "1280,720", 0);   -- 设置分辨率
SystemSetup:SaveGameSetup (0,0,0,0,0,0,0,0,0,0.89999997615814,0,0,0,0,0,1,1,0,1,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0); -- 游戏性设置
Variable:SetVariable("EnableBGSound", "0", 0);   -- 音效设置
Variable:SetVariable("Enable3DSound", "0", 0);
Variable:SetVariable("EnableSKSound", "0", 0);
Variable:SetVariable("EnableUISound", "0", 0);
]]
LUA_Call(游戏设置lua)
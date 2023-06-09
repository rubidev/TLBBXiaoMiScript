
local ItemSource = "稀世珍宝图"

--字符串分割函数,分隔符为"|"
function SplitString(str, sep)
	local tmp ={}
	for w in string.gmatch(str, string.format("([^%q]+)",sep)) do 
		table.insert(tmp,w)
	end
	return tmp	
end
--设置需要上架的物品名字

function 友情提示(text,...)
	local strCode = string.format(text,...)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = DebugListBox_Env})
		str= "#cFF0000".."提示：".."#cFF0000".."%-88s"
		DebugListBox_ListBox:AddInfo(str)
		--橙色 #e0000ff#u#g0ceff3
		--蓝色 #e0000ff#g28f1ff
		--#Y
	]], strCode))
end
--=====================================================================================================
local ItemList = SplitString(ItemSource, "|") 
local OwnItem = {}
---------------函---数---区---域-----------------------------------
function Sleep(ms)
	延时(ms)
end
function QuestFrameOptionClicked(str)
	NPC二级对话(str) 
end
function PushDebugMessage(str, ...)
	local str = string.format(str, ...)
	屏幕提示(str)
end
function IsWindowShow(str)
	return 窗口是否出现(str)
end
function MoveToNPC(posx, posy, sceneName, NpcName)
	while true do
		跨图寻路(sceneName, posx, posy);Sleep(1000)
		if 对话NPC(NpcName) == 1 then
			break
		end
	end
end

function CloseWindow(str)
	LUA_Call(string.format("setmetatable(_G, {__index = %s_Env});this:Hide()",str))
end

--判断天机锦囊中是否有要出售的物品的函数
function FindTemBagItem(NameList)
	local tmpItem = {}
	for k, v in pairs(NameList) do 
		local itemname = LUA_取返回值(string.format([[ 
			setmetatable(_G, {__index = Packet_Temporary_Env})  
			local szName = "%s"
				for i = 1, 120 do
					local theAction, bLocked = Bank:EnumTemItem(i - 1)
					if theAction:GetID() ~= 0 then
						if szName == theAction:GetName() then
							return theAction:GetName()
						end
					end
				end
			return ""
		]],v))
		if itemname ~= "" then
			table.insert(tmpItem, itemname)
		end
	end
	return tmpItem
end
--天机锦囊右键点击
function TemPacketRclick(name)
	LUA_Call(string.format([[
		setmetatable(_G, {__index = Packet_Temporary_Env})
		local GRID_BUTTONS = {}
		local szName = "%s"
		for i = 1, 120 do
			local ItemBar = Packet_Temporary_ActionsList:AddItemElement( "ActionButtonItem", "Packet_Temporary", "", "")
			local ItemAcButton = ItemBar:GetLuaActionButton("Packet_Temporary")
			ItemAcButton:SetProperty("DragAcceptName", "p"..tostring(i))
			table.insert(GRID_BUTTONS,ItemAcButton);
		end
		for i = 1, 120 do
			local theAction, bLocked = Bank:EnumTemItem(i-1);
			if theAction:GetID() ~= 0 then
				GRID_BUTTONS[i]:SetActionItem(theAction:GetID())
				if szName == theAction:GetName() then
					GRID_BUTTONS[i]:DoAction()
					GRID_BUTTONS[i]:SetActionItem(-1)
				end
			end
		end
	]],name))
end
--统计锦囊中物品数量的函数
function CountTemBagItemNum(name)
    local num = LUA_取返回值(string.format([[
        setmetatable(_G, {__index = Packet_Temporary_Env})  
        local szName = "%s"
            for i = 1, 120 do
                local theAction, bLocked = Bank:EnumTemItem(i - 1)
                if theAction:GetID() ~= 0 then
                    if szName == theAction:GetName() then
                        return theAction:GetNum()
                    end
                end
            end
            return 0
	]],name))
	return tonumber(num)
end

for i = 1, 10 do
	local statecounttotalmax = LUA_取返回值(string.format([[
	local itemidx,count,itemid,price,time,totalmax,state,money,pos = GuiShiUI:LuaFnGetMarketUserSellInfoByID(0,%d-1);
	if itemid > 0 then
	    return state .. "|" .. count .. "|" .. totalmax
	end
	]],i))
	Sleep(100)
	local tmp = SplitString(statecounttotalmax, "|")
	table.insert(OwnItem,{indx = i, state = tonumber(tmp[1]), count = tonumber(tmp[2]), totalmax = tonumber(tmp[3])})
end
function  取服务器名称()
        local tem=  LUA_取返回值(string.format([[
                local ZoneWorldID = DataPool:GetSelfZoneWorldID()
        local strName = DataPool:GetServerName( ZoneWorldID )
        return strName
                ]]))
        return  tem
end
function 天机锦囊取物()
if  string.find("天若有情|",取服务器名称()) then
                local Item = FindTemBagItem(ItemList)

         for k, v in pairs(Item) do
        	TemPacketRclick(v);Sleep(1000) --右键点击需要的物品
         end
CloseWindow("GuiShi_MarketOnSell",true) --关闭上架界面
CloseWindow("GuiShi_Market",true) --关闭森罗市界面
                延时(3000)
                else
                友情提示("本脚本只限制于【天若有情】服务器取藏宝图使用，若要其他用途，联系QQ3707181")
                友情提示("本脚本只限制于【天若有情】服务器取藏宝图使用，若要其他用途，联系QQ3707181")
                友情提示("本脚本只限制于【天若有情】服务器取藏宝图使用，若要其他用途，联系QQ3707181")
                友情提示("本脚本只限制于【天若有情】服务器取藏宝图使用，若要其他用途，联系QQ3707181")
                友情提示("本脚本只限制于【天若有情】服务器取藏宝图使用，若要其他用途，联系QQ3707181")
                return
  end
--获取天机锦囊中要上架的物品名字
end 
天机锦囊取物()
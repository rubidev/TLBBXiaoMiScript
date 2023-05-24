function PushDebugMessage(str, ...)
	屏幕提示(string.format(str, ...))
end

function QuestFrameOptionClicked(MissionOption)
	NPC二级对话(MissionOption)
end

function Sleep(ms)
	延时(ms)
end

function MoveToNPC(posx, posy, sceneName, NpcName)
	while true do
		跨图寻路(sceneName, posx, posy)
		延时(1000)
		等待过图完毕()
		if 对话NPC(NpcName) == 1 then
			break
		end
	end
end

function BankGetItem(str,num)
	取出物品(str,num)
end

function GetBagItemCount(itemName)
	return 获取背包物品数量(itemName)
end

function BankSaveItem(str)
	存物品(str,"",0,0,0)
end

local Item = {
	["合成中级勾天彩"] = {"初级勾天彩","初级勾天彩合成符" },
	["合成高级勾天彩"] = {"中级勾天彩","中级勾天彩合成符" },
	["合成幻色勾天彩"] = {"高级勾天彩","高级勾天彩合成符" },
}

local ItemList = "初级勾天彩|初级勾天彩合成符|中级勾天彩|中级勾天彩合成符|高级勾天彩|高级勾天彩合成符|幻色勾天彩"
----------------------------------------------------------------------------------------------------------------------


--合成勾天彩开始逻辑
PushDebugMessage("开始前往凤鸣镇进行合成[勾天彩]")

BankGetItem("初级勾天彩|初级勾天彩合成符|中级勾天彩|中级勾天彩合成符",-1)

MoveToNPC(368, 421, "金陵", "焦鹰")


QuestFrameOptionClicked("勾天彩合成");Sleep(1000)


for k, v in pairs(Item) do
	PushDebugMessage("开始[%s]!", k);Sleep(500)
	while GetBagItemCount(v[1]) >= 5 and GetBagItemCount(v[2]) >= 1 do
		QuestFrameOptionClicked(k);Sleep(1000)
	end
end

BankSaveItem(ItemList)

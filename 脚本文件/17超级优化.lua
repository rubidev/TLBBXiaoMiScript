-------------------------------------------------------------------------处理地图界面---------------
function 晴天_黑化小地图()
	     LUA_Call(string.format([[ 

	function zidingyi_MiniMap_OnEvent(event)
	if event=="SCENE_TRANSED" then
		this:Hide()
	PushDebugMessage("【晴天友情提示】QQ 531896440 群 641700076 定制小蜜助手文本百分之99.99操作")
	PushDebugMessage("【晴天友情提示】QQ 531896440 群 641700076 定制小蜜助手文本百分之99.99操作")
	PushDebugMessage("【晴天友情提示】QQ 531896440 群 641700076 定制小蜜助手文本百分之99.99操作")
	end	
	end

if TT_MiniMap_OnEvent == nil then
   TT_MiniMap_OnEvent = MiniMap_OnEvent
    function MiniMap_OnEvent(event)
        TT_MiniMap_OnEvent(event);
        zidingyi_MiniMap_OnEvent(event);
    end
end
]]))
end
function 晴天_还原小地图()	
	     LUA_Call(string.format([[ 
	MiniMap_OnEvent=TT_MiniMap_OnEvent --还原
	TT_MiniMap_OnEvent=nil
]]))
end
-------------------------------------------------------------------------------------------

function 晴天_黑化聊天()
	     LUA_Call(string.format([[ 
function TT_ChatFrame_OnEvent(event)
	if event=="PLAYER_ENTERING_WORLD" then
		this:Hide()
		PushDebugMessage("【晴天友情提示】QQ 531896440 群 641700076 定制小蜜助手文本百分之99.99操作")
	end	
end

if XTT_ChatFrame_OnEvent == nil then
    XTT_ChatFrame_OnEvent = ChatFrame_OnEvent
    function ChatFrame_OnEvent(event)
        XTT_ChatFrame_OnEvent(event);
        TT_ChatFrame_OnEvent(event);
    end
end
]]))
end

function 晴天_还原小地图()	
	     LUA_Call(string.format([[ 
	ChatFrame_OnEvent=XTT_ChatFrame_OnEvent
	XTT_ChatFrame_OnEvent=nil
]]))
end


晴天_黑化小地图()
晴天_黑化聊天()
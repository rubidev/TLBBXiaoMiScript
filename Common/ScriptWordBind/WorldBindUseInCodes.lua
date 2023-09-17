function AudgeQmFu()
    local tmp = LUA_取返回值([[
        local zoneworldid =  DataPool:GetSelfZoneWorldID()
        return zoneworldid
    ]])
    return tmp
end

ttpRet = AudgeQmFu()
if ttpRet ~= nil and ttpRet ~= "" then
    -- TODO 参照 ServerIdNameList.json 修改
    if tonumber(ttpRet) == 155 then
        屏幕提示()
    else
        MentalTip("非指定区无法使用")
        return
    end
else
    return
end
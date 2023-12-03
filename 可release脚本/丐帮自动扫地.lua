skillList = {
    "龙战于野", "横扫乾坤"
}

while true do
    for _, skillName in pairs(skillList) do
        if 判断技能冷却(skillName) == 1 then
            坐骑_下坐骑()
            延时(100)
            local HideSkillID = 获取技能ID(skillName)
            使用技能(HideSkillID)
        end
        延时(200)
    end
end
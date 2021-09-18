--[[
    0:7k, 1:5k, 2:12k, 3:10k, 4:9k, 5:select, 6:decide, 7:result, 15:courceresult, 16:24k, 17:24kDouble
]]
local function load(type)
    local property = {
        type = type,
        name = "ResultTemp" .."(MCTE)",   --(MCTE)表記は消さないで！
        w = 1920,
        h = 1080,
        scene = 3600000,
        input = 2500,          -- スキップ可能 timer1で重要
        fadeout = 1000,      -- フェードアウト時にこの時間が過ぎると次のシーンへ timer2で重要
        property = PROPERTY.property,
        filepath = PROPERTY.filepath,
        offset = PROPERTY.offset,
        category = PROPERTY.category
    }
    return property
end

return {
    load = load
}
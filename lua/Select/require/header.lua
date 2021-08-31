--[[
    header情報
    @author KASAKO
]]

local function load()
    local ver = 0.1
    local m = {
        type = 5,    -- 0:7k, 1:5k, 2:12k, 3:10k, 4:9k, 5:select, 6:decide, 7:result, 15:courceresult, 16:24k, 17:24kDouble
        name = "ModernChicTemplateEngine-Select-" ..ver .."(MCTE)", --(MCTE)の部分は削除しないで下さい
        w = 1920,
        h = 1080,
        fadeout = 500,
        scene = 3000,   -- スキップ可能 timer1で重要
        input = 500,    -- フェードアウト時にこの時間が過ぎると次のシーンへ timer2で重要
        property = PROPERTY.property,
        filepath = PROPERTY.filepath,
        offset = PROPERTY.offset,
        category = PROPERTY.category
    }
    return m
end

return{
    load = load
}
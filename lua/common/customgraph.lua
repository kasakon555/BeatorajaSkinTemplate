--[[
    カスタムグラフを定義する場合はここに記述
    graph定義のvalueプロパティで使用
    グラフは1を100％として表示
    @author : KASAKO
]]
local m = {}
-- SLOW割合
m.SlowRate = function()
    local slowNum = main_state.number(MAIN.NUM.TOTALLATE)
    local fastNum = main_state.number(MAIN.NUM.TOTALEARLY)
    local allNum = slowNum + fastNum
    return slowNum / allNum
end
-- FAST割合
m.FastRate = function()
    local slowNum = main_state.number(MAIN.NUM.TOTALLATE)
    local fastNum = main_state.number(MAIN.NUM.TOTALEARLY)
    local allNum = slowNum + fastNum
    return fastNum / allNum
end
return m
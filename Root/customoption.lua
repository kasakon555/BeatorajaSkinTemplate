--[[
    カスタムオプションを定義する場合はここに記述
    @author : KASAKO
]]
local m = {}

-- ゲージがアシストイージー状態
m.isGaugeAssistEasy = function()
    if main_state.gauge_type() == 0 then
        return true
    else
        return false
    end
end
-- ゲージがイージー状態
m.isGaugeEasy = function()
    if main_state.gauge_type() == 1 then
        return true
    else
        return false
    end
end
-- ゲージがノーマル状態
m.isGaugeNormal = function()
    if main_state.gauge_type() == 2 then
        return true
    else
        return false
    end
end
-- ゲージがハード状態
m.isGaugeHard = function()
    if main_state.gauge_type() == 3 then
        return true
    else
        return false
    end
end
-- ゲージがEXハード状態
m.isGaugeExHard = function()
    if main_state.gauge_type() == 4 then
        return true
    else
        return false
    end
end
-- ゲージがハザード状態
m.isGaugeHazard = function()
    if main_state.gauge_type() == 5 then
        return true
    else
        return false
    end
end
-- ゲージが段位ゲージ状態（ノーマル）
m.isGaugeGrade = function()
    if main_state.gauge_type() == 6 then
        return true
    else
        return false
    end
end
-- ゲージが段位ゲージ状態（ハード）
m.isGaugeExGrade = function()
    if main_state.gauge_type() == 7 then
        return true
    else
        return false
    end
end
-- ゲージが段位ゲージ状態（EXハード）
m.isGaugeExhardGrade = function()
    if main_state.gauge_type() == 8 then
        return true
    else
        return false
    end
end

-- 途中で閉店したのかを判定する
-- TODO 意図的に中断した時に表示されてしまう
m.isInTheMiddleFailed = function()
    local totalNotes = main_state.number(MAIN.NUM.TOTALNOTES)
    local processNotes = main_state.number(MAIN.NUM.PERFECT) + main_state.number(MAIN.NUM.GREAT) + main_state.number(MAIN.NUM.GOOD) + main_state.number(MAIN.NUM.BAD) + main_state.number(MAIN.NUM.POOR)
    return main_state.option(91) and totalNotes ~= processNotes
end


return m
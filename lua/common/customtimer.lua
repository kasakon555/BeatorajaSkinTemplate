--[[
    カスタムタイマー
    author : KASAKO
]]
local CUSTOMTIMER_ID = 9999
-- タイマー値をインクリメント
local function getCustomtimerId()
    CUSTOMTIMER_ID = CUSTOMTIMER_ID + 1
    return CUSTOMTIMER_ID
end

local m = {}
m.example = getCustomtimerId()

-- タイマーの発動指定
m.customTimers = {
    {id = m.example, timer = timer_util.timer_observe_boolean(function()
        return true
    end)},
}

return m
--[[
    カスタムタイマーを定義する場合はここに記述
    dst定義のtimerプロパティで使用
    @author : KASAKO
]]
local timer_util = require("timer_util")
-- カスタムタイマーは9999から
local CUSTOMTIMER_ID = 9999
-- タイマー値をインクリメント
local function getCustomtimerId()
    CUSTOMTIMER_ID = CUSTOMTIMER_ID + 1
    return CUSTOMTIMER_ID
end

local m = {}
-- タイマー名
-- テストタイマー（常にtrueを返す）
m.example = getCustomtimerId()

-- タイマー挙動
m.customTimers = {
    {id = m.example, timer = timer_util.timer_observe_boolean(function()
        return true
    end)},
}

return m
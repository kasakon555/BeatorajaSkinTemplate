--[[
    カスタムナンバーを定義する場合はここに記述
    value定義のvalueプロパティで使用
    @author : KASAKO
]]
local m = {}
-- マスターボリューム
m.masterVolumeNum = function()
    return main_state.volume_sys() * 100
end
-- キーボリューム
m.keyVolumeNum = function()
    return main_state.volume_key() * 100
end
-- BGMボリューム
m.bgmVolumeNum = function()
    return main_state.volume_bg() * 100
end
-- 画面遷移後の時間（マイクロ秒）
m.elapsedTimeMicroNum = function()
    return main_state.time()
end
-- 画面遷移後の時間（ミリ秒）
m.elapsedTimeMilliNum = function()
    return main_state.time() / 1000
end
-- 画面遷移後の時間（秒）
m.elapsedTimeNum = function()
    return main_state.time() / 1000 / 1000
end
-- 現在のスコアレート
m.nowScoreRateNum = function()
    return main_state.rate()
end
-- 現在のEXスコア
m.nowExScoreNum = function()
    return main_state.exscore()
end
-- 現在のゲージ％数
m.nowGaugePercentNum = function()
    return main_state.gauge()
end
-- 現在のPG数
m.nowPGCountNum = function()
    return main_state.judge(0)
end
-- 現在のグレート数
m.nowGreatCountNum = function()
    return main_state.judge(1)
end
-- 現在のグッド数
m.nowGoodCountNum = function()
    return main_state.judge(2)
end
-- 現在のバッド数
m.nowBadCountNum = function()
    return main_state.judge(3)
end
-- 現在のプア数
m.nowPoorCountNum = function()
    return main_state.judge(4)
end
-- 現在のミス数
m.nowMissCountNum = function()
    return main_state.judge(5)
end
return m
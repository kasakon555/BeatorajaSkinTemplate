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
return m
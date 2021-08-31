--[[
    カスタムオプションを定義する場合はここに記述
    dst定義のdrawプロパティで使用
    @author : KASAKO
]]
local m = {}
--[[
    サンプル
    オンライン時かどうかを判定するカスタムオプション
]]
m.isOnline = function()
    if(main_state.option(MAIN.OP.ONLINE)) then
        return true
    else
        return false
    end
end

return m
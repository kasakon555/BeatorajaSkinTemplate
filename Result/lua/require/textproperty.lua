
local module = {}

if PROPERTY.isOutlineFont() then
    -- 画像フォントなし
    module.font = {
        {id = 0, path = "Result/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "Result/font/ttf/mgenplus-1c-medium.ttf"}
    }
    module.text = {}
elseif PROPERTY.isBitmapFont() then
    -- 画像フォントあり
    module.font = {
        {id = 0, path = "Result/font/fnt/main.fnt"},
        {id = 1, path = "Result/font/fnt/sub.fnt"}
    }
    module.text = {}
end

return module
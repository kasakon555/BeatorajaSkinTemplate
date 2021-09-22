--[[
	フォント定義
	@author : KASAKO
]]
local module = {}
if PROPERTY.isOutlineFont() then
    -- アウトラインフォント
    module.font =  {
        {id = 1, path = "Decide/font/ttf/mgenplus-1c-medium.ttf"},
        {id = 0, path = "Decide/font/ttf/mgenplus-1c-black.ttf"},
    }
    module.text = {}
elseif PROPERTY.isBitmapFont() then
    -- ビットマップフォント（ちと重い）
    module.font =  {
        {id = 0, path = "Decide/font/fnt/main.fnt", type = 1},
        {id = 1, path = "Decide/font/fnt/sub.fnt", type = 1},
    }
    module.text = {}
end
return module

local module = {}

if PROPERTY.isOutlineFont() then
    module.font = {
        {id = 0, path = "Select/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "Select/font/ttf/mgenplus-1c-medium.ttf"},
    }
    module.text = {
    }
elseif  PROPERTY.isBitmapFont() then
    module.font = {
        {id = 0, path = "Select/font/fnt/bartext.fnt"},
        {id = 1, path = "Select/font/fnt/main.fnt", type = 1},
        {id = 2, path = "Select/font/fnt/sub.fnt", type = 1}
    }
    module.text = {}
end

return module
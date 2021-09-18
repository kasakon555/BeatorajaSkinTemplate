local module = {}

if PROPERTY.isOutlineFont() then
    module.font = {
        {id = 0, path = "Play/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "Play/font/ttf/mgenplus-1c-medium.ttf"}
    }
    module.text = {}
elseif PROPERTY.isBitmapFont() then
    module.font = {
        {id = 0, path = "Play/font/fnt/title.fnt"},
        {id = 1, path = "Play/font/fnt/info.fnt"},
        {id = 2, path = "Play/font/fnt/top.fnt"}
    }
    module.text = {}
end

return module
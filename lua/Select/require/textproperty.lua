--[[
    テキスト関連
    align
        0:左
        1:中央
        2:右
]]

local module = {}

local function createFullArtist()
    local fullArtist
    if main_state.text(15) == "" then
        fullArtist = main_state.text(14)
    else
        fullArtist = main_state.text(14) .." " ..main_state.text(15)
    end
    return fullArtist
end

local version = "Ver-0.1"
local courseRef = {150, 151, 152, 153, 154, 155, 156, 157, 158, 159}
local irRankNameRef = {120, 121, 122, 123, 124, 125, 126, 127, 128, 129}

if PROPERTY.isOutlineFont() then
    -- 画像フォント未使用
    local main = {
        shadowOffsetX = 4,
        shadowOffsetY = 4
    }
    local sub = {
        shadowOffsetX = 2,
        shadowOffsetY = 2
    }
    module.font = {
        {id = 0, path = "../Select/font/ttf/mgenplus-1c-black.ttf"},
        {id = 1, path = "../Select/font/font/ttf/mgenplus-1c-medium.ttf"},
    }
    module.text = {
        {id = "title", font = 0, size = 70, ref = 10, overflow = 1, align = 2, shadowOffsetX = main.shadowOffsetX, shadowOffsetY = main.shadowOffsetY},
        {id = "subtitle", font = 0, size = 170, ref = 11, overflow = 1},
        {id = "artist", font = 1, size = 30, ref = 14, overflow = 1, align = 2, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "subartist", font = 1, size = 30, ref = 15, overflow = 1, align = 2, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "fullArtist", font = 1, size = 30, overflow = 1, align = 2, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY, value = function()
            return createFullArtist()
        end},
        {id = "genre", font = 1, size = 30, ref = 13, overflow = 1, align = 2, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "bartext", font = 1, size = 35, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "search", font = 1, size = 30, ref = 30},
        {id = "yourname", font = 1, size = 35, ref = 2, overflow = 1, align = 1, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "rivalname", font = 1, size = 35, ref = 1, overflow = 1, align = 1, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "directory", font = 1, size = 25, ref = 1000, overflow = 1, align = 2, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY},
        {id = "version", font = 0, size = 16, constantText = version, overflow = 1},
    }
    -- コース名
    for i = 1, 10, 1 do
        table.insert(module.text, {
            id = "course" ..i, font = 1, size = 30, ref = courseRef[i], overflow = 1, align = 1, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY,
        })
    end
    -- IRTOP10
    for i = 1, 10, 1 do
        table.insert(module.text, {
            id = "irRankName"..i, font = 1, size = 16, ref = irRankNameRef[i], align = 0, overflow = 1
        })
    end
    -- IRTOP10（サイドメニュー用）
    for i = 1, 10, 1 do
        table.insert(module.text, {
            id = "s_irRankName"..i, font = 1, size = 25, ref = irRankNameRef[i], align = 0, overflow = 1, shadowOffsetX = sub.shadowOffsetX, shadowOffsetY = sub.shadowOffsetY
        })
    end
elseif  PROPERTY.isBitmapFont() then
    -- 画像フォント使用
    local main = {
        outlineColor = "111111ff",
        outlineWidth = 0.8
    }
    local sub = {
        outlineColor = "222222ff",
        outlineWidth = 1
    }

    module.font = {
        {id = 0, path = "../Select/font/fnt/bartext.fnt"},
        {id = 1, path = "../Select/font/fnt/main.fnt", type = 1},
        {id = 2, path = "../Select/font/fnt/sub.fnt", type = 1}
    }
    module.text = {
        {id = "title", font = 1, size = 70, ref = 10, overflow = 1, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth, align = 2},
        {id = "subtitle", font = 1, size = 170, ref = 11, overflow = 1},
        {id = "artist", font = 2, size = 30, ref = 14, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = 2},
        {id = "subartist", font = 2, size = 30, ref = 15, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = 2},
        {id = "fullArtist", font = 2, size = 30, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = 2, value = function()
            return createFullArtist()
        end},
        {id = "genre", font = 2, size = 30, ref = 13, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, align = 2},
        {id = "bartext", font = 0, size = 35},
        {id = "search", font = 2, size = 30, ref = 30},
        {id = "yourname", font = 2, size = 35, ref = 2, overflow = 1, align = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
        {id = "rivalname", font = 2, size = 35, ref = 1, overflow = 1, align = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
        {id = "directory", font = 2, size = 25, ref = 1000, overflow = 1, align = 2, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth},
        {id = "version", font = 1, size = 16, constantText = version, overflow = 1, outlineColor = main.outlineColor, outlineWidth = main.outlineWidth},
    }
    -- コース名
    for i = 1, 10, 1 do
        table.insert(module.text, {
            id = "course" ..i, font = 0, size = 30, ref = courseRef[i], overflow = 1, align = 1
        })
    end
    -- IRTOP10
    for i = 1, 10, 1 do
        table.insert(
            module.text,{id = "irRankName"..i, font = 2, size = 16, ref = irRankNameRef[i], align = 0, overflow = 1, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth
        })
    end
    -- IRTOP10（サイドメニュー用）
    for i = 1, 10, 1 do
        table.insert(module.text,{
            id = "s_irRankName"..i, font = 2, size = 25, ref = irRankNameRef[i], align = 0, outlineColor = sub.outlineColor, outlineWidth = sub.outlineWidth, overflow = 1
        })
    end
end

return module
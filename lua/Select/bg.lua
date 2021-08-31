--[[
    背景を表示する
]]

local function load()
    local parts = {}
    parts.source = {}
    parts.image = {}
    parts.destination = {}

    if PROPERTY.isBgImage() then
        table.insert(parts.source, {id = 1, path = "../Select/bg/image/*.png"})
        table.insert(parts.image, {id = "background", src = 1, x = 0, y = 0, w = 1920, h = 1080})
    elseif PROPERTY.isBgMovie() then
        table.insert(parts.source, {id = 1, path = "../Select/bg/movie/*.mp4"})
        table.insert(parts.image, {id = "background", src = 1, x = 0, y = 0, w = 1920, h = 1080})
    end

    table.insert(parts.destination, {
        id = "background", dst = {
            {x = 0, y = 0, w = 1920, h = 1080},
        }
    })
    return parts
end

return {
    load = load
}
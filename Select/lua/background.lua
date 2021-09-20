--[[
    背景表示
]]
local function load()
    local parts = {}
    parts.image = {}
    parts. destination = {}

    if PROPERTY.isBgImage() then
        table.insert(parts.image, {
            id = "background", src = 1, x = 0, y = 0, w = 1920, h = 1080
        })
    elseif PROPERTY.isBgMovie() then
        table.insert(parts.image, {
            id = "background", src = 2, x = 0, y = 0, w = 1920, h = 1080
        })
    end

	-- 背景表示
	table.insert(parts.destination, {
		id = "background", dst = {
			{x = 0, y = 0, w = 1920, h = 1080}
		}
	})

    return parts
end

return {
    load = load
}
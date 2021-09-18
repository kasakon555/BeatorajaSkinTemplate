--[[
    背景表示
]]

local function load(imageId)
    local parts = {}
    parts.image = {}
    parts.destination = {}
    -- 背景
    table.insert(parts.image, {id = "bg", src = imageId, x = 0, y = 0, w = 1920, h = 1080})
	table.insert(parts.destination, {
		id = "bg", dst = {
			{x = 0, y = 0, w = 1920, h = 1080}
		}
	})
	-- 背景の明るさ調節
	table.insert(parts.destination, {
		id = -110, offset = PROPERTY.offsetBgBrightness.num, dst = {
			{x = 0, y = 0, w = 1920, h = 1080, a = 0},
		}
	})
    return parts
end

return {
    load = load
}
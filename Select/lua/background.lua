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

    table.insert(parts.image, {
        id = "main-bg", src = 5, x = 1401, y = 1240, w = 50, h = 50
    })

	-- 背景
	table.insert(parts.destination, {
		id = "background", dst = {
			{x = 0, y = 0, w = 1920, h = 1080}
		}
	})
	-- 背景の明るさ調整
	table.insert(parts.destination,	{
		id = -110, offsets = {PROPERTY.offsetBgBrightness}, dst = {
			{x = 0, y = 0, w = 1920, h = 1080, a = 0},
		}
	})

	--ステージファイルとバナー
	if PROPERTY.isStagefileTypeA() then
		table.insert(parts.destination, {
			id = MAIN.IMAGE.STAGEFILE, loop = 300, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
				{time = 0, x = 120, y = 406, w = 480, h = 360, a = 0},
				{time = 300, x = 80, a = 255}
			}
		})
		-- バナー
		table.insert(parts.destination, {
			id = MAIN.IMAGE.BANNER, loop = 300, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
				{time = 0, x = 700, y = 785, w = 300, h = 80, a = 0},
				{time = 300, a = 255}
			}
		})
	end
	-- ステージファイルのみ
	if PROPERTY.isStagefileTypeB() then
		table.insert(parts.destination, {
			id = MAIN.IMAGE.STAGEFILE, loop = 300, timer = MAIN.TIMER.SONGBAR_CHANGE, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 0},
				{time = 300, a = 255}
			}
		})
	end
	-- サブタイトル
	if PROPERTY.isSubtitleScrollOn() then
		table.insert(parts.destination, {
			id = "subtitle", loop = 0, dst = {
				{time = 0, x = 1920, y = 500, w = 1920, h = 170, r = 255, g = 255, b = 0, a = 170},
				{time = 10000, x = -1920}
			}
		})
		table.insert(parts.destination, {
			-- サブタイトルを表示させるための背景
			id = "main-bg", dst = {
				{x = 0, y = 406, w = 1920, h = 360},
			}
		})
	end

    return parts
end

return {
    load = load
}
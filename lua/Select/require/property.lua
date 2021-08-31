local m = {}

--[[
	初期値
	カスタムオプション：900-999
	オフセット：40-
]]
local customoptionNumber = 899
local categoryNumber = 0
local offsetNumber = 39

-- カテゴリナンバーの付与
local function addCategoryNumber()
	categoryNumber = categoryNumber + 1
	return categoryNumber
end

-- カスタムオプションナンバーの付与
local function addCustomoptionNumber()
	customoptionNumber = customoptionNumber + 1
	if customoptionNumber > 999 then
		print("警告：カスタムナンバーが上限を超えています")
	end
	return customoptionNumber
end

-- オフセットナンバーを付与
local function addOffsetNumber()
	offsetNumber = offsetNumber + 1
	return offsetNumber
end

local customoption = {
    -- カスタムオプション項目作成
    parent = function(name)
        return {
            name = name,
            label = addCategoryNumber()
        }
	end,
	-- カスタムオプション小項目作成
	chiled = function(name)
		return {
			name = name,
			num = addCustomoptionNumber()
		}
	end,
	-- ファイルパス項目作成
	filepath = function(name, path)
		return {
			name = name,
			path = path,
			label = addCategoryNumber(),
			def = "#default"
		}
	end,
	-- オフセット項目作成
	offset = function(name)
		return {
			name = name,
			label = addCategoryNumber(),
			num = addOffsetNumber()
		}
	end,
    -- カスタムオプション簡易条件式
    createCondition = function(name, customoptionNumber)
        return function()
            return skin_config.option[name] == customoptionNumber
        end
	end,
	-- オフセット情報アクセス用
	offsetInfo = function(offset)
		return {
			num = offset.num,
			x = function()
				return skin_config.offset[offset.name].x
			end,
			y = function()
				return skin_config.offset[offset.name].y
			end,
			width = function()
				return skin_config.offset[offset.name].w
			end,
			height = function()
				return skin_config.offset[offset.name].h
			end,
			alpha = function()
				return skin_config.offset[offset.name].a
			end
		}
	end
}

-- ここから -----------------------------------------------------------------------------------------
local bgPattern = customoption.parent("背景の種類")
bgPattern.image = customoption.chiled("静止画")
bgPattern.movie = customoption.chiled("動画")
m.isBgImage = customoption.createCondition(bgPattern.name, bgPattern.image.num)
m.isBgMovie = customoption.createCondition(bgPattern.name, bgPattern.movie.num)
local bitmapFont = customoption.parent("画像フォントの使用")
bitmapFont.off = customoption.chiled("使用しない")
bitmapFont.on = customoption.chiled("使用する")
m.isOutlineFont = customoption.createCondition(bitmapFont.name, bitmapFont.off.num)
m.isBitmapFont = customoption.createCondition(bitmapFont.name, bitmapFont.on.num)

-- filepath
local bgImage = customoption.filepath("背景（静止画）", "../Select/bg/image/*.png")
local bgMovie = customoption.filepath("背景（動画）", "../Select/bg/movie/*.mp4")

-- offset
local bgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
m.offsetBgBrightness = bgBrightness.num

m.property = {
	{name = bgPattern.name, def = bgPattern.image.name, category = bgPattern.label, item = {
		{name = bgPattern.image.name, op = bgPattern.image.num},
		{name = bgPattern.movie.name, op = bgPattern.movie.num},
	}},
	{name = bitmapFont.name, def = bitmapFont.on.name, category = bitmapFont.label, item = {
		{name = bitmapFont.off.name, op = bitmapFont.off.num},
		{name = bitmapFont.on.name, op = bitmapFont.on.num},
	}},
}

m.filepath = {
	{name = bgImage.name, path = bgImage.path, category = bgImage.label, def = bgImage.def},
	{name = bgMovie.name, path = bgMovie.path, category = bgMovie.label, def = bgImage.def},
}

-- offsetのユーザー定義は40以降
m.offset = {
	{name = bgBrightness.name, category = bgBrightness.label, id = bgBrightness.num, a = 0},
}

--[[
	カスタムカテゴリ
	カスタムオプション、ファイルパス、オフセットを関連付け
]]
m.category = {
	{name = "メインオプション", item = {
		bitmapFont.label,
	}},
	{name = "背景", item = {
		bgPattern.label,
		bgImage.label,
		bgMovie.label,
		bgBrightness.label
	}},
}

if DEBUG then
	print("セレクトカスタムオプション最大値：" ..customoptionNumber .."\nセレクトカテゴリ最大値：" ..categoryNumber .."\nセレクトオフセット最大値：" ..offsetNumber)
end

return m
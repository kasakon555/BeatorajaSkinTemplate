local module = {}

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
		print("カスタムナンバーが上限を超えています")
	end
	return customoptionNumber
end
-- オフセットナンバーを付与
local function addOffsetNumber()
	offsetNumber = offsetNumber + 1
	return offsetNumber
end

local customoption = {
    -- カスタムオプション項目を作成
    parent = function(name)
        return {
            name = name,
            label = addCategoryNumber()
        }
	end,
	-- カスタムオプション小項目を作成する
	chiled = function(cName, pName)
		local num = addCustomoptionNumber()
		local chiled = {name = cName, num = num}
		local condition = function() return skin_config.option[pName] == num end
		return chiled, condition
	end,
	-- ファイルパス項目を作成
	filepath = function(name, path)
		return {
			name = name,
			path = path,
			label = addCategoryNumber(),
			def = "#default"
		}
	end,
	-- オフセット項目を作成
	offset = function(name)
		local label = addCategoryNumber()
		local num = addOffsetNumber()
		local offset = {name = name, label = label, num = num}
		local info = {
			num = num,
			alpha = function() return skin_config.offset[name].a end,
			width = function() return skin_config.offset[name].w end,
			height = function() return skin_config.offset[name].h end,
			x = function() return skin_config.offset[name].x end,
			y = function() return skin_config.offset[name].y end
		}
		return offset, info
	end
}

local bgPattern = customoption.parent("背景の種類")
bgPattern.image, module.isBgImage = customoption.chiled("静止画", bgPattern.name)
bgPattern.movie, module.isBgMovie = customoption.chiled("動画", bgPattern.name)

module.property = {
	-- カスタムオプション定義
	{name = bgPattern.name, def = bgPattern.image.name, category = bgPattern.label, item = {
		{name = bgPattern.image.name, op = bgPattern.image.num},
		{name = bgPattern.movie.name, op = bgPattern.movie.num},
	}},
}

module.filepath = {

}

-- offsetのユーザー定義は40以降
module.offset = {

}

--[[
	カスタムカテゴリ
	カスタムオプション、ファイルパス、オフセットを関連付け
]]
module.category = {

}

if DEBUG then
	print("セレクトカスタムオプション最大値：" ..customoptionNumber .."\nセレクトカテゴリ最大値：" ..categoryNumber .."\nセレクトオフセット最大値：" ..offsetNumber)
end

return module
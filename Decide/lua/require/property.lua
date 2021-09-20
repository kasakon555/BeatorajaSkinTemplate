local module = {}

--[[
	初期値
	カスタムオプション：900-999
	オフセット：40-
]]
local customoptionNumber = 899
local categoryNumber = 0
local offsetNumber = 39

-- カテゴリ分け用のナンバーを付与
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
		return {
			name = name,
			label = addCategoryNumber(),
			num = addOffsetNumber()
		}
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

local bgPattern = customoption.parent("背景の種類")
bgPattern.image, module.isBgImage = customoption.chiled("静止画", bgPattern.name)
bgPattern.movie, module.isBgMovie = customoption.chiled("動画", bgPattern.name)
local bitmapFont = customoption.parent("画像フォントの使用")
bitmapFont.off, module.isOutlineFont = customoption.chiled("使用しない", bitmapFont.name)
bitmapFont.on, module.isBitmapFont = customoption.chiled("使用する", bitmapFont.name)
local stageFile = customoption.parent("ステージファイル")
stageFile.off, module.isStagefileOff = customoption.chiled("表示しない", stageFile.name)
stageFile.on, module.isStagefileOn = customoption.chiled("表示する", stageFile.name)
local notesGraph = customoption.parent("ノーツ分布グラフ")
notesGraph.off, module.isNotesGraphOff = customoption.chiled("表示しない", notesGraph.name)
notesGraph.on, module.isNotesGraphOn = customoption.chiled("表示する", notesGraph.name)

local bgImage = customoption.filepath("背景（静止画）Decide/bg/image/*.png", "Decide/bg/image/*.png")
local bgMovie = customoption.filepath("背景（動画）Decide/bg/movie/*.mp4", "Decide/bg/movie/*.mp4")

module.property = {
    --カスタムオプション定義
    {name = bgPattern.name, category = bgPattern.label, def = bgPattern.image.name, item = {
        {name = bgPattern.image.name, op = bgPattern.image.num},
        {name = bgPattern.movie.name, op = bgPattern.movie.num},
    }},
    {name = bitmapFont.name, category = bitmapFont.label, def = bitmapFont.off.name, item = {
        {name = bitmapFont.off.name, op = bitmapFont.off.num},
        {name = bitmapFont.on.name, op = bitmapFont.on.num},
    }},
    {name = stageFile.name, category = stageFile.label, def = stageFile.on.name, item = {
        {name = stageFile.off.name, op = stageFile.off.num},
        {name = stageFile.on.name, op = stageFile.on.num},
    }},
	{name = notesGraph.name, category = notesGraph.label, def = notesGraph.on.name, item = {
		{name = notesGraph.off.name, op = notesGraph.off.num},
		{name = notesGraph.on.name, op = notesGraph.on.num},
	}}
}

module.filepath = {
    {name = bgImage.name, path = bgImage.path, category = bgImage.label, def = "sample"},
    {name = bgMovie.name, path = bgMovie.path, category = bgMovie.label, def = "sample"},
}

--[[
	リザルト用カスタムカテゴリ
	カスタムオプション、ファイルパス、オフセットを関連付け
]]
module.category = {
    --カスタムオプション定義
	{name = "メインオプション", item = {
        bitmapFont.label,
        stageFile.label,
		notesGraph.label,
	}},
	{name = "背景パターン", item = {
        bgPattern.label,
        bgImage.label,
        bgMovie.label
	}},
}

if DEBUG then
	print("決定時カスタムオプション最大値：" ..customoptionNumber .."\n決定時カテゴリ最大値：" ..categoryNumber .."\n決定時オフセット最大値：" ..offsetNumber)
end

return module
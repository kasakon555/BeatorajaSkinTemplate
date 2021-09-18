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
    chiled = function(name)
        return {
            name = name,
            num = addCustomoptionNumber()
        }
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

local bgPattern = customoption.parent("背景の種類")
bgPattern.image = customoption.chiled("静止画")
bgPattern.movie = customoption.chiled("動画")
module.isBgImage = customoption.createCondition(bgPattern.name, bgPattern.image.num)
module.isBgMovie = customoption.createCondition(bgPattern.name, bgPattern.movie.num)

local bitmapFont = customoption.parent("画像フォントの使用")
bitmapFont.off = customoption.chiled("使用しない")
bitmapFont.on = customoption.chiled("使用する")
module.isOutlineFont = customoption.createCondition(bitmapFont.name, bitmapFont.off.num)
module.isBitmapFont = customoption.createCondition(bitmapFont.name, bitmapFont.on.num)

local stageFile = customoption.parent("ステージファイル")
stageFile.off = customoption.chiled("表示しない")
stageFile.on = customoption.chiled("表示する")
module.isStagefileOff = customoption.createCondition(stageFile.name, stageFile.off.num)
module.isStagefileOn = customoption.createCondition(stageFile.name, stageFile.on.num)

local notesGraph = customoption.parent("ノーツ分布グラフ")
notesGraph.off = customoption.chiled("表示しない")
notesGraph.on = customoption.chiled("表示する")
module.isNotesGraphOff = customoption.createCondition(notesGraph.name, notesGraph.off.num)
module.isNotesGraphOn = customoption.createCondition(notesGraph.name, notesGraph.on.num)

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
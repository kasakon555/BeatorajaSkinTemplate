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

local extendFiles = customoption.parent("ステージ＆バナーファイル")
extendFiles.both = customoption.chiled("両方表示")
extendFiles.full = customoption.chiled("ステージファイルをフルサイズ表示")
module.isStagefileTypeA = customoption.createCondition(extendFiles.name, extendFiles.both.num)
module.isStagefileTypeB = customoption.createCondition(extendFiles.name, extendFiles.full.num)

local listPattern = customoption.parent("曲リストの並び")
listPattern.straight = customoption.chiled("直線")
listPattern.arch = customoption.chiled("曲線")
listPattern.diagonal = customoption.chiled("斜め")
module.isSonglistStraight = customoption.createCondition(listPattern.name, listPattern.straight.num)
module.isSonglistArch = customoption.createCondition(listPattern.name, listPattern.arch.num)
module.isSonglistDiagonally = customoption.createCondition(listPattern.name, listPattern.diagonal.num)

local subtitleScroll = customoption.parent("サブタイトルのスクロール")
subtitleScroll.off = customoption.chiled("しない")
subtitleScroll.on = customoption.chiled("する")
module.isSubtitleScrollOff = customoption.createCondition(subtitleScroll.name, subtitleScroll.off.num)
module.isSubtitleScrollOn = customoption.createCondition(subtitleScroll.name, subtitleScroll.on.num)

local beam = customoption.parent("ビーム（装飾）")
beam.off = customoption.chiled("しない")
beam.on = customoption.chiled("する")
module.isIlluminationOff = customoption.createCondition(beam.name, beam.off.num)
module.isIlluminationOn = customoption.createCondition(beam.name, beam.on.num)

local startAnimation = customoption.parent("開始パターン")
startAnimation.fadein = customoption.chiled("フェードイン")
startAnimation.shutter = customoption.chiled("シャッター")
module.isStartFadein = customoption.createCondition(startAnimation.name, startAnimation.fadein.num)
module.isStartShutter = customoption.createCondition(startAnimation.name, startAnimation.shutter.num)

local rateSwitch = customoption.parent("IR情報表示")
rateSwitch.cfrate = customoption.chiled("クリアレート&フルコンボレート")
rateSwitch.ranking = customoption.chiled("ランキング")
module.isIrClearrateFullcomborate = customoption.createCondition(rateSwitch.name, rateSwitch.cfrate.num)
module.isIrRanking = customoption.createCondition(rateSwitch.name, rateSwitch.ranking.num)

local sidemenuRetentionSwitch = customoption.parent("サイドメニューの開閉状態を保持する")
sidemenuRetentionSwitch.off = customoption.chiled("しない")
sidemenuRetentionSwitch.on = customoption.chiled("する")
module.isSideMenuRetentionOff = customoption.createCondition(sidemenuRetentionSwitch.name, sidemenuRetentionSwitch.off.num)
module.isSideMenuRetentionOn = customoption.createCondition(sidemenuRetentionSwitch.name, sidemenuRetentionSwitch.on.num)

local skinCheck = customoption.parent("スキン更新チェック")
skinCheck.off = customoption.chiled("しない")
skinCheck.on = customoption.chiled("する")
module.isCheckNewVersion = customoption.createCondition(skinCheck.name, skinCheck.on.num)

local language = customoption.parent("言語")
language.jpn = customoption.chiled("日本語")
language.en = customoption.chiled("English")
language.cn = customoption.chiled("Chinese")
module.isLanguageJPN = customoption.createCondition(language.name, language.jpn.num)
module.isLanguageEN = customoption.createCondition(language.name, language.en.num)
module.isLanguageCN = customoption.createCondition(language.name, language.cn.num)

local bgImage = customoption.filepath("背景（静止画）Select/bg/image/*.png", "Select/bg/image/*.png")
local bgMovie = customoption.filepath("背景（動画）Select/bg/movie/*.mp4", "Select/bg/movie/*.mp4")

local bgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
module.offsetBgBrightness = bgBrightness.num

-- 使用カスタムオプション値
--print("選曲スキン最大カスタムオプション値：" ..customoptionNumber)

module.property = {
	-- カスタムオプション定義
	{name = bgPattern.name, def = bgPattern.image.name, category = bgPattern.label, item = {
		{name = bgPattern.image.name, op = bgPattern.image.num},
		{name = bgPattern.movie.name, op = bgPattern.movie.num},
	}},
	{name = bitmapFont.name, def = bitmapFont.on.name, category = bitmapFont.label, item = {
		{name = bitmapFont.off.name, op = bitmapFont.off.num},
		{name = bitmapFont.on.name, op = bitmapFont.on.num},
	}},
	{name = extendFiles.name, def = extendFiles.both.name, category = extendFiles.label, item = {
		{name = extendFiles.both.name, op = extendFiles.both.num},
		{name = extendFiles.full.name, op = extendFiles.full.num},
	}},
	{name = listPattern.name, def = listPattern.straight.name, category = listPattern.label, item = {
		{name = listPattern.straight.name, op = listPattern.straight.num},
		{name = listPattern.arch.name, op = listPattern.arch.num},
		{name = listPattern.diagonal.name, op = listPattern.diagonal.num},
	}},
	{name = subtitleScroll.name, def = subtitleScroll.on.name, category = subtitleScroll.label, item = {
		{name = subtitleScroll.off.name, op = subtitleScroll.off.num},
		{name = subtitleScroll.on.name, op = subtitleScroll.on.num},
	}},
	{name = beam.name, def = beam.on.name, category = beam.label, item = {
		{name = beam.off.name, op = beam.off.num},
		{name = beam.on.name, op = beam.on.num},
	}},
	{name = startAnimation.name, def = startAnimation.fadein.name, category = startAnimation.label, item = {
		{name = startAnimation.fadein.name, op = startAnimation.fadein.num},
		{name = startAnimation.shutter.name, op = startAnimation.shutter.num},
	}},
	{name = rateSwitch.name, def = rateSwitch.cfrate.name, category = rateSwitch.label, item = {
		{name = rateSwitch.cfrate.name, op = rateSwitch.cfrate.num},
		{name = rateSwitch.ranking.name, op = rateSwitch.ranking.num},
	}},
	{name = sidemenuRetentionSwitch.name, def = sidemenuRetentionSwitch.off.name, category = sidemenuRetentionSwitch.label, item = {
		{name = sidemenuRetentionSwitch.off.name, op = sidemenuRetentionSwitch.off.num},
		{name = sidemenuRetentionSwitch.on.name, op = sidemenuRetentionSwitch.on.num},
	}},
	{name = skinCheck.name, def = skinCheck.on.name, category = skinCheck.label, item = {
		{name = skinCheck.off.name, op = skinCheck.off.num},
		{name = skinCheck.on.name, op = skinCheck.on.num},
	}},
	{name = language.name, def = language.jpn.name, category = language.label, item = {
		{name = language.jpn.name, op = language.jpn.num},
		{name = language.en.name, op = language.en.num},
		{name = language.cn.name, op = language.cn.num},
	}},
}

module.filepath = {
	{name = bgImage.name, path = bgImage.path, category = bgImage.label, def = "#default"},
	{name = bgMovie.name, path = bgMovie.path, category = bgMovie.label, def = "Abstract"},
}

-- offsetのユーザー定義は40以降
module.offset = {
	{name = bgBrightness.name, category = bgBrightness.label, id = bgBrightness.num, a = 0},
}

--[[
	カスタムカテゴリ
	カスタムオプション、ファイルパス、オフセットを関連付け
]]
module.category = {
	--カスタムオプション定義
	{name = "メインオプション", item = {
		language.label,
		bitmapFont.label,
		extendFiles.label,
		listPattern.label,
		subtitleScroll.label,
		beam.label,
		startAnimation.label,
		rateSwitch.label,
		sidemenuRetentionSwitch.label,
		skinCheck.label
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

return module
-- リザルト用プロパティ

local module = {}

-- 初期値
local offsetNumber = 39
local customoptionNumber = 899
local categoryNumber = 0

-- カテゴリナンバーの付与
local function addCategoryNumber()
	categoryNumber = categoryNumber + 1
	return categoryNumber
end

-- カスタムオプションナンバーの付与
local function addCustomoptionNumber()
	customoptionNumber = customoptionNumber + 1
	if customoptionNumber > 999 then
		print("警告：カスタムオプションが上限を超えています")
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

local function load(isResult)
	local bitmapFont = customoption.parent("画像フォントの使用")
	bitmapFont.off = customoption.chiled("使用しない")
	bitmapFont.on = customoption.chiled("使用する")
	module.isOutlineFont = customoption.createCondition(bitmapFont.name, bitmapFont.off.num)
	module.isBitmapFont = customoption.createCondition(bitmapFont.name, bitmapFont.on.num)

	local mainmenuPosition = customoption.parent("グラフ&スコア表示位置")
	mainmenuPosition.left = customoption.chiled("左")
	mainmenuPosition.right = customoption.chiled("右")
	module.isMainmenuLeft = customoption.createCondition(mainmenuPosition.name, mainmenuPosition.left.num)
	module.isMainmenuRight = customoption.createCondition(mainmenuPosition.name, mainmenuPosition.right.num)

	local showItem = customoption.parent("項目表示切り替え")
	showItem.combo = customoption.chiled("コンボ数表示")
	showItem.misscount = customoption.chiled("ミスカウント表示")
	module.isShowItemCombo = customoption.createCondition(showItem.name, showItem.combo.num)
	module.isShowItemMisscount = customoption.createCondition(showItem.name, showItem.misscount.num)

	local startAnimation = customoption.parent("開始時アニメーション")
	startAnimation.off = customoption.chiled("なし")
	startAnimation.on = customoption.chiled("あり")
	module.isStartAnimationOff = customoption.createCondition(startAnimation.name, startAnimation.off.num)
	module.isStartAnimationOn = customoption.createCondition(startAnimation.name, startAnimation.on.num)

	local stageFile = customoption.parent("ステージファイル表示")
	stageFile.off = customoption.chiled("なし")
	stageFile.on = customoption.chiled("あり")
	module.isStageFileOff = customoption.createCondition(stageFile.name, stageFile.off.num)
	module.isStageFileOn = customoption.createCondition(stageFile.name, stageFile.on.num)

	local timeStamp = customoption.parent("タイムスタンプ")
	timeStamp.off = customoption.chiled("なし")
	timeStamp.on = customoption.chiled("あり")
	module.isTimestampOff = customoption.createCondition(timeStamp.name, timeStamp.off.num)
	module.isTimestampOn = customoption.createCondition(timeStamp.name, timeStamp.on.num)

	local beam = customoption.parent("修飾（ビーム）")
	beam.off = customoption.chiled("なし")
	beam.on = customoption.chiled("あり")
	module.isBeamOff = customoption.createCondition(beam.name, beam.off.num)
	module.isBeamOn = customoption.createCondition(beam.name, beam.on.num)

	local ring = customoption.parent("修飾（リング）")
	ring.off = customoption.chiled("なし")
	ring.on = customoption.chiled("あり")
	module.isRingOff = customoption.createCondition(ring.name, ring.off.num)
	module.isRingOn = customoption.createCondition(ring.name, ring.on.num)

	local skinCheck = customoption.parent("スキン更新チェック")
	skinCheck.off = customoption.chiled("しない")
	skinCheck.on = customoption.chiled("する")
	module.isCheckNewVersion = customoption.createCondition(skinCheck.name, skinCheck.on.num)

	local bgPattern = customoption.parent("背景表示パターン")
	bgPattern.cf = customoption.chiled("Clear or Failed")
	bgPattern.all = customoption.chiled("ALL")
	bgPattern.rank = customoption.chiled("Rank")
	bgPattern.clearType = customoption.chiled("ClearType")
	module.isBackgroundClearFailed = customoption.createCondition(bgPattern.name, bgPattern.cf.num)
	module.isBackgroundAll = customoption.createCondition(bgPattern.name, bgPattern.all.num)
	module.isBackgroundRank = customoption.createCondition(bgPattern.name, bgPattern.rank.num)
	module.isBackgroundClearType = customoption.createCondition(bgPattern.name, bgPattern.clearType.num)

	local charSwitch = customoption.parent("キャラクター表示")
	charSwitch.off = customoption.chiled("なし")
	charSwitch.on = customoption.chiled("あり")
	module.isCharOff = customoption.createCondition(charSwitch.name, charSwitch.off.num)
	module.isCharOn = customoption.createCondition(charSwitch.name, charSwitch.on.num)

	local charPattern = customoption.parent("キャラクター表示パターン")
	charPattern.cf = customoption.chiled("Clear or Failed")
	charPattern.all = customoption.chiled("ALL")
	charPattern.rank = customoption.chiled("Rank")
	charPattern.clearType = customoption.chiled("ClearType")
	module.isCharClearFailed = customoption.createCondition(charPattern.name, charPattern.cf.num)
	module.isCharAll = customoption.createCondition(charPattern.name, charPattern.all.num)
	module.isCharRank = customoption.createCondition(charPattern.name, charPattern.rank.num)
	module.isCharClearType = customoption.createCondition(charPattern.name, charPattern.clearType.num)

	local irMenuSwitch = customoption.parent("IRメニュー表示")
	irMenuSwitch.off = customoption.chiled("なし")
	irMenuSwitch.on = customoption.chiled("あり（オンライン時のみ表示されます）")
	module.isIrmenuOff = customoption.createCondition(irMenuSwitch.name, irMenuSwitch.off.num)
	module.isIrmenuOn = customoption.createCondition(irMenuSwitch.name, irMenuSwitch.on.num)

	local irMenuPattern = customoption.parent("IRメニューの種類")
	irMenuPattern.top10 = customoption.chiled("IRランキングTOP10")
	irMenuPattern.clear = customoption.chiled("IRクリア状況")
	module.isIrRankingTop10 = customoption.createCondition(irMenuPattern.name, irMenuPattern.top10.num)
	module.isIrClearType = customoption.createCondition(irMenuPattern.name, irMenuPattern.clear.num)

	local TDGMagnificationPattern = customoption.parent("タイミンググラフ倍率")
	TDGMagnificationPattern.low = customoption.chiled("低倍率（+-225ms）")
	TDGMagnificationPattern.normal = customoption.chiled("標準倍率（+-150ms）")
	TDGMagnificationPattern.high = customoption.chiled("高倍率（+-75ms）")
	module.isTDGMagnificationLow = customoption.createCondition(TDGMagnificationPattern.name, TDGMagnificationPattern.low.num)
	module.isTDGMagnificationNormal = customoption.createCondition(TDGMagnificationPattern.name, TDGMagnificationPattern.normal.num)
	module.isTDGMagnificationHigh = customoption.createCondition(TDGMagnificationPattern.name, TDGMagnificationPattern.high.num)

	local TDGColorPattern = customoption.parent("タイミンググラフ配色パターン")
	TDGColorPattern.normal = customoption.chiled("通常")
	TDGColorPattern.red = customoption.chiled("赤基調")
	TDGColorPattern.green = customoption.chiled("緑基調")
	TDGColorPattern.blue = customoption.chiled("青基調")
	module.isTDGColorNormal = customoption.createCondition(TDGColorPattern.name, TDGColorPattern.normal.num)
	module.isTDGColorRed = customoption.createCondition(TDGColorPattern.name, TDGColorPattern.red.num)
	module.isTDGColorGreen = customoption.createCondition(TDGColorPattern.name, TDGColorPattern.green.num)
	module.isTDGColorBlue = customoption.createCondition(TDGColorPattern.name, TDGColorPattern.blue.num)

	local clearRankParts = customoption.filepath("クリアランクイメージ", "Result/parts/rank/*.png")
	local irCoverParts = customoption.filepath("IRカバー", "Result/parts/irmask/*.png")
	local gaugeParts = customoption.filepath("ゲージ", "Result/parts/gauge/*.png")

	-- 背景
	local background = {}
	background.clear = customoption.filepath("背景（Clear）", "Result/parts/bg/isclear/clear/*.png")
	background.failed = customoption.filepath("背景（Failed）", "Result/parts/bg/isclear/failed/*.png")
	background.all = customoption.filepath("背景（ALL）", "Result/parts/bg/all/*.png")
	background.AAA = customoption.filepath("背景（AAA）", "Result/parts/bg/rank/AAA/*.png")
	background.AA = customoption.filepath("背景（AA）", "Result/parts/bg/rank/AA/*.png")
	background.A = customoption.filepath("背景（A）", "Result/parts/bg/rank/A/*.png")
	background.B = customoption.filepath("背景（B）", "Result/parts/bg/rank/B/*.png")
	background.C = customoption.filepath("背景（C）", "Result/parts/bg/rank/C/*.png")
	background.D = customoption.filepath("背景（D）", "Result/parts/bg/rank/D/*.png")
	background.E = customoption.filepath("背景（E）", "Result/parts/bg/rank/E/*.png")
	background.F = customoption.filepath("背景（F）", "Result/parts/bg/rank/F/*.png")
	background.failed2 = customoption.filepath("背景（Failed）", "Result/parts/bg/clearType/failed/*.png")
	background.assist = customoption.filepath("背景（Assist）", "Result/parts/bg/clearType/assist/*.png")
	background.laAssist = customoption.filepath("背景（LaAssist）", "Result/parts/bg/clearType/laassist/*.png")
	background.easy = customoption.filepath("背景（Easy）", "Result/parts/bg/clearType/easy/*.png")
	background.normal = customoption.filepath("背景（Normal and NoPlay）", "Result/parts/bg/clearType/normal/*.png")
	background.hard = customoption.filepath("背景（Hard）", "Result/parts/bg/clearType/hard/*.png")
	background.exhard = customoption.filepath("背景（Exhard）", "Result/parts/bg/clearType/exhard/*.png")
	background.fullcombo = customoption.filepath("背景（FullCombo）", "Result/parts/bg/clearType/fullcombo/*.png")
	background.perfect = customoption.filepath("背景（Perfect）", "Result/parts/bg/clearType/perfect/*.png")
	background.max = customoption.filepath("背景（Max）", "Result/parts/bg/clearType/max/*.png")

	-- 重ね絵
	local charBG = {}
	charBG.clear = customoption.filepath("キャラクター（Clear）", "Result/parts/char/isclear/clear/*.png")
	charBG.failed = customoption.filepath("キャラクター（Failed）", "Result/parts/char/isclear/failed/*.png")
	charBG.all = customoption.filepath("キャラクター（ALL）", "Result/parts/char/all/*.png")
	charBG.AAA = customoption.filepath("キャラクター（AAA）", "Result/parts/char/rank/AAA/*.png")
	charBG.AA = customoption.filepath("キャラクター（AA）", "Result/parts/char/rank/AA/*.png")
	charBG.A = customoption.filepath("キャラクター（A）", "Result/parts/char/rank/A/*.png")
	charBG.B = customoption.filepath("キャラクター（B）", "Result/parts/char/rank/B/*.png")
	charBG.C = customoption.filepath("キャラクター（C）", "Result/parts/char/rank/C/*.png")
	charBG.D = customoption.filepath("キャラクター（D）", "Result/parts/char/rank/D/*.png")
	charBG.E = customoption.filepath("キャラクター（E）", "Result/parts/char/rank/E/*.png")
	charBG.F = customoption.filepath("キャラクター（F）", "Result/parts/char/rank/F/*.png")
	charBG.failed2 = customoption.filepath("キャラクター（Failed）", "Result/parts/char/clearType/failed/*.png")
	charBG.assist = customoption.filepath("キャラクター（Assist）", "Result/parts/char/clearType/assist/*.png")
	charBG.laAssist = customoption.filepath("キャラクター（LaAssist）", "Result/parts/char/clearType/laassist/*.png")
	charBG.easy = customoption.filepath("キャラクター（Easy）", "Result/parts/char/clearType/easy/*.png")
	charBG.normal = customoption.filepath("キャラクター（Normal and NoPlay）", "Result/parts/char/clearType/normal/*.png")
	charBG.hard = customoption.filepath("キャラクター（Hard）", "Result/parts/char/clearType/hard/*.png")
	charBG.exhard = customoption.filepath("キャラクター（Exhard）", "Result/parts/char/clearType/exhard/*.png")
	charBG.fullcombo = customoption.filepath("キャラクター（FullCombo）", "Result/parts/char/clearType/fullcombo/*.png")
	charBG.perfect = customoption.filepath("キャラクター（Perfect）", "Result/parts/char/clearType/perfect/*.png")
	charBG.max = customoption.filepath("キャラクター（Max）", "Result/parts/char/clearType/max/*.png")

	-- オフセット関連
	local bgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
	module.offsetBgBrightness = bgBrightness.num
	local charPosition = customoption.offset("キャラクター表示位置調整")
	module.offsetCharPosition = charPosition.num

	module.property = {
		--カスタムオプション定義
		{name = bitmapFont.name, def = bitmapFont.off.name, category = bitmapFont.label, item = {
			{name = bitmapFont.off.name, op = bitmapFont.off.num},
			{name = bitmapFont.on.name, op = bitmapFont.on.num},
		}},
		{name = mainmenuPosition.name, def = mainmenuPosition.left.name, category = mainmenuPosition.label, item = {
			{name = mainmenuPosition.left.name, op = mainmenuPosition.left.num},
			{name = mainmenuPosition.right.name, op = mainmenuPosition.right.num},
		}},
		{name = showItem.name, def = showItem.combo.name, category = showItem.label, item = {
			{name = showItem.combo.name, op = showItem.combo.num},
			{name = showItem.misscount.name, op = showItem.misscount.num},
		}},
		{name = irMenuSwitch.name, def = irMenuSwitch.on.name, category = irMenuSwitch.label, item = {
			{name = irMenuSwitch.off.name, op = irMenuSwitch.off.num},
			{name = irMenuSwitch.on.name, op = irMenuSwitch.on.num},
		}},
		{name = irMenuPattern.name, def = irMenuPattern.top10.name, category = irMenuPattern.label, item = {
			{name = irMenuPattern.top10.name, op = irMenuPattern.top10.num},
			{name = irMenuPattern.clear.name, op = irMenuPattern.clear.num},
		}},
		{name = startAnimation.name, def = startAnimation.on.name, category = startAnimation.label, item = {
			{name = startAnimation.off.name, op = startAnimation.off.num},
			{name = startAnimation.on.name, op = startAnimation.on.num},
		}},
		{name = timeStamp.name, def = timeStamp.on.name, category = timeStamp.label, item = {
			{name = timeStamp.off.name, op = timeStamp.off.num},
			{name = timeStamp.on.name, op = timeStamp.on.num},
		}},
		{name = beam.name, def = beam.on.name, category = beam.label, item = {
			{name = beam.off.name, op = beam.off.num},
			{name = beam.on.name, op = beam.on.num},
		}},
		{name = ring.name, def = ring.on.name, category = ring.label, item = {
			{name = ring.off.name, op = ring.off.num},
			{name = ring.on.name, op = ring.on.num},
		}},
		{name = charSwitch.name, def = charSwitch.off.name, category = charSwitch.label, item = {
			{name = charSwitch.off.name, op = charSwitch.off.num},
			{name = charSwitch.on.name, op = charSwitch.on.num},
		}},
	}

	module.filepath = {
		{name = clearRankParts.name, path = clearRankParts.path, category = clearRankParts.label, def = "#default"},
		{name = irCoverParts.name, path = irCoverParts.path, category = irCoverParts.label, def = "#default"},
		{name = gaugeParts.name, path = gaugeParts.path, category = gaugeParts.label, def = "#default"},
		{name = background.clear.name, path = background.clear.path, category = background.clear.label, def = "#default"},
		{name = background.failed.name, path = background.failed.path, category = background.failed.label, def = "#default"},
		{name = background.all.name, path = background.all.path, category = background.all.label, def = "#default"},
		{name = background.AAA.name, path = background.AAA.path, category = background.AAA.label, def = "#default"},
		{name = background.AA.name, path = background.AA.path, category = background.AA.label, def = "#default"},
		{name = background.A.name, path = background.A.path, category = background.A.label, def = "#default"},
		{name = background.B.name, path = background.B.path, category = background.B.label, def = "#default"},
		{name = background.C.name, path = background.C.path, category = background.C.label, def = "#default"},
		{name = background.D.name, path = background.D.path, category = background.D.label, def = "#default"},
		{name = background.E.name, path = background.E.path, category = background.E.label, def = "#default"},
		{name = background.F.name, path = background.F.path, category = background.F.label, def = "#default"},

		{name = charBG.clear.name, path = charBG.clear.path, category = charBG.clear.label, def = "#default"},
		{name = charBG.failed.name, path = charBG.failed.path, category = charBG.failed.label, def = "#default"},
		{name = charBG.all.name, path = charBG.all.path, category = charBG.all.label, def = "#default"},
		{name = charBG.AAA.name, path = charBG.AAA.path, category = charBG.AAA.label, def = "#default"},
		{name = charBG.AA.name, path = charBG.AA.path, category = charBG.AA.label, def = "#default"},
		{name = charBG.A.name, path = charBG.A.path, category = charBG.A.label, def = "#default"},
		{name = charBG.B.name, path = charBG.B.path, category = charBG.B.label, def = "#default"},
		{name = charBG.C.name, path = charBG.C.path, category = charBG.C.label, def = "#default"},
		{name = charBG.D.name, path = charBG.D.path, category = charBG.D.label, def = "#default"},
		{name = charBG.E.name, path = charBG.E.path, category = charBG.E.label, def = "#default"},
		{name = charBG.F.name, path = charBG.F.path, category = charBG.F.label, def = "#default"},
	}

	-- offsetのユーザー定義は40以降
	module.offset = {
		{name = bgBrightness.name, category = bgBrightness.label, id = bgBrightness.num, a = 0},
		{name = charPosition.name, category = charPosition.label, id = charPosition.num, x = 0, y = 0},
	}

	--[[
		カスタムオプション、ファイルパス、オフセットを関連付け
	]]
	module.category = {
		--カスタムオプション定義
		{name = "メインオプション", item = {
			bitmapFont.label,
			mainmenuPosition.label,
			showItem.label,
			startAnimation.label,
			timeStamp.label,
			beam.label,
			ring.label,
			clearRankParts.label,
			gaugeParts.label
		}},
		{name = "背景パターン", item = {
			bgPattern.label,
			bgBrightness.label
		}},
		{name = "背景選択（Clear or Failed）", item = {
			background.clear.label,
			background.failed.label
		}},
		{name = "背景選択（ALL）", item = {
			background.all.label
		}},
		{name = "背景選択（Rank）", item = {
			background.AAA.label,
			background.AA.label,
			background.A.label,
			background.B.label,
			background.C.label,
			background.D.label,
			background.E.label,
			background.F.label
		}},
		{name = "キャラクター表示", item = {
			charSwitch.label,
			charPattern.label,
			charPosition.label
		}},
		{name = "キャラクター選択（Clear or Failed）", item = {
			charBG.clear.label,
			charBG.failed.label
		}},
		{name = "キャラクター選択（ALL）", item = {
			charBG.all.label
		}},
		{name = "キャラクター選択（Rank）", item = {
			charBG.AAA.label,
			charBG.AA.label,
			charBG.A.label,
			charBG.B.label,
			charBG.C.label,
			charBG.D.label,
			charBG.E.label,
			charBG.F.label
		}},
		{name = "IRメニュー", item = {
			irMenuSwitch.label,
			irMenuPattern.label,
			irCoverParts.label
		}},
	}

	if isResult then
		-- 通常リザルト
		table.insert(module.property, {
			name = bgPattern.name, def = bgPattern.cf.name, category = bgPattern.label, item = {
				{name = bgPattern.cf.name, op = bgPattern.cf.num},
				{name = bgPattern.all.name, op = bgPattern.all.num},
				{name = bgPattern.rank.name, op = bgPattern.rank.num},
				{name = bgPattern.clearType.name, op = bgPattern.clearType.num},
			}
		})
		-- キャラ表示パターン
		table.insert(module.property, {
			name = charPattern.name, def = charPattern.cf.name, category = charPattern.label, item = {
				{name = charPattern.cf.name, op = charPattern.cf.num},
				{name = charPattern.all.name, op = charPattern.all.num},
				{name = charPattern.rank.name, op = charPattern.rank.num},
				{name = charPattern.clearType.name, op = charPattern.clearType.num},
			}
		})
		-- スキンチェック
		table.insert(module.property, {
			name = skinCheck.name, def = skinCheck.on.name, category = skinCheck.label, item = {
				{name = skinCheck.off.name, op = skinCheck.off.num},
				{name = skinCheck.on.name, op = skinCheck.on.num},
			}
		})
		-- ステージファイル表示
		table.insert(module.property, {
			name = stageFile.name, def = stageFile.off.name, category = stageFile.label, item = {
				{name = stageFile.off.name, op = stageFile.off.num},
				{name = stageFile.on.name, op = stageFile.on.num},
			}
		})
		-- タイミンググラフ倍率
		table.insert(module.property, {
			name = TDGMagnificationPattern.name, def = TDGMagnificationPattern.normal.name, category = TDGMagnificationPattern.label, item = {
				{name = TDGMagnificationPattern.low.name, op = TDGMagnificationPattern.low.num},
				{name = TDGMagnificationPattern.normal.name, op = TDGMagnificationPattern.normal.num},
				{name = TDGMagnificationPattern.high.name, op = TDGMagnificationPattern.high.num},
			}
		})
		-- タイミンググラフ配色
		table.insert(module.property, {
			name = TDGColorPattern.name, def = TDGColorPattern.normal.name, category = TDGColorPattern.label, item = {
				{name = TDGColorPattern.normal.name, op = TDGColorPattern.normal.num},
				{name = TDGColorPattern.red.name, op = TDGColorPattern.red.num},
				{name = TDGColorPattern.green.name, op = TDGColorPattern.green.num},
				{name = TDGColorPattern.blue.name, op = TDGColorPattern.blue.num},
			}
		})

		table.insert(module.filepath, {name = background.failed2.name, path = background.failed2.path, category = background.failed2.label, def = "#default"})
		table.insert(module.filepath, {name = background.assist.name, path = background.assist.path, category = background.assist.label, def = "#default"})
		table.insert(module.filepath, {name = background.laAssist.name, path = background.laAssist.path, category = background.laAssist.label, def = "#default"})
		table.insert(module.filepath, {name = background.easy.name, path = background.easy.path, category = background.easy.label, def = "#default"})
		table.insert(module.filepath, {name = background.normal.name, path = background.normal.path, category = background.normal.label, def = "#default"})
		table.insert(module.filepath, {name = background.hard.name, path = background.hard.path, category = background.hard.label, def = "#default"})
		table.insert(module.filepath, {name = background.exhard.name, path = background.exhard.path, category = background.exhard.label, def = "#default"})
		table.insert(module.filepath, {name = background.fullcombo.name, path = background.fullcombo.path, category = background.fullcombo.label, def = "#default"})
		table.insert(module.filepath, {name = background.perfect.name, path = background.perfect.path, category = background.perfect.label, def = "#default"})
		table.insert(module.filepath, {name = background.max.name, path = background.max.path, category = background.max.label, def = "#default"})

		table.insert(module.filepath, {name = charBG.failed2.name, path = charBG.failed2.path, category = charBG.failed2.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.assist.name, path = charBG.assist.path, category = charBG.assist.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.laAssist.name, path = charBG.laAssist.path, category = charBG.laAssist.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.easy.name, path = charBG.easy.path, category = charBG.easy.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.normal.name, path = charBG.normal.path, category = charBG.normal.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.hard.name, path = charBG.hard.path, category = charBG.hard.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.exhard.name, path = charBG.exhard.path, category = charBG.exhard.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.fullcombo.name, path = charBG.fullcombo.path, category = charBG.fullcombo.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.perfect.name, path = charBG.perfect.path, category = charBG.perfect.label, def = "#default"})
		table.insert(module.filepath, {name = charBG.max.name, path = charBG.max.path, category = charBG.max.label, def = "#default"})

		table.insert(module.category, 6, {
			name = "背景選択（ClearType）", item = {
				background.failed2.label,
				background.assist.label,
				background.laAssist.label,
				background.easy.label,
				background.normal.label,
				background.hard.label,
				background.exhard.label,
				background.fullcombo.label,
				background.perfect.label,
				background.max.label
			}
		})
		table.insert(module.category, 11, {
			name = "キャラクター選択（ClearType）", item = {
				charBG.failed2.label,
				charBG.assist.label,
				charBG.laAssist.label,
				charBG.easy.label,
				charBG.normal.label,
				charBG.hard.label,
				charBG.exhard.label,
				charBG.fullcombo.label,
				charBG.perfect.label,
				charBG.max.label
			}
		})
		table.insert(module.category, {
			name = "ステージファイル表示", item = {
				stageFile.label
			}
		})
		table.insert(module.category, {
			name = "グラフ関連", item = {
				TDGMagnificationPattern.label,
				TDGColorPattern.label
			}
		})
		table.insert(module.category, {
			name = "バージョンチェック", item = {
				skinCheck.label
			}
		})
	else
		-- コースリザルト
		table.insert(module.property, {
			name = bgPattern.name, def = bgPattern.cf.name, category = bgPattern.label, item = {
				{name = bgPattern.cf.name, op = bgPattern.cf.num},
				{name = bgPattern.all.name, op = bgPattern.all.num},
				{name = bgPattern.rank.name, op = bgPattern.rank.num},
			}
		})
		table.insert(module.property, {
			name = charPattern.name, def = charPattern.cf.name, category = charPattern.label, item = {
				{name = charPattern.cf.name, op = charPattern.cf.num},
				{name = charPattern.all.name, op = charPattern.all.num},
				{name = charPattern.rank.name, op = charPattern.rank.num},
			}
		})
	end

	if DEBUG then
		print("リザルトカスタムオプション最大値：" ..customoptionNumber .."\nリザルトカテゴリ最大値：" ..categoryNumber .."\nリザルトオフセット最大値：" ..offsetNumber)
	end

	return module
end

return{
	load = load
}
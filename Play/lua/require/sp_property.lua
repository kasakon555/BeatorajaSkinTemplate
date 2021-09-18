-- SP用（5鍵、7鍵）用プロパティ
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
		print("警告）カスタムナンバーが上限を超えています")
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
			alpha = function()
				return skin_config.offset[offset.name].a
			end,
			width = function()
				return skin_config.offset[offset.name].w
			end,
			height = function()
				return skin_config.offset[offset.name].h
			end,
			x = function()
				return skin_config.offset[offset.name].x
			end,
			y = function()
				return skin_config.offset[offset.name].y
			end,
		}
	end
}

local function load(is5keys)
	local playSide = customoption.parent("プレイサイド")
	playSide.left = customoption.chiled("1P（左スクラッチ）")
	playSide.right = customoption.chiled("2P（右スクラッチ）")
	module.isLeftScratch = customoption.createCondition(playSide.name, playSide.left.num)
	module.isRightScratch = customoption.createCondition(playSide.name, playSide.right.num)

	local playPosition = customoption.parent("プレイ位置")
	playPosition.left = customoption.chiled("1P（左側表示）")
	playPosition.right = customoption.chiled("2P（右側表示）")
	module.isLeftPosition = customoption.createCondition(playPosition.name, playPosition.left.num)
	module.isRightPosition = customoption.createCondition(playPosition.name, playPosition.right.num)

	local bitmapFont = customoption.parent("画像フォントの使用")
	bitmapFont.off = customoption.chiled("使用しない")
	bitmapFont.on = customoption.chiled("使用する")
	module.isOutlineFont = customoption.createCondition(bitmapFont.name, bitmapFont.off.num)
	module.isBitmapFont = customoption.createCondition(bitmapFont.name, bitmapFont.on.num)

	local scoreGraphPosition = customoption.parent("スコアグラフ、ノート分布、タイミングエリアの配置")
	scoreGraphPosition.typeA = customoption.chiled("TYPEA（グラフ：左、ノート、タイミング：右）")
	scoreGraphPosition.typeB = customoption.chiled("TYPEB（ノート、タイミング：左、グラフ：右）")
	module.isInfoDisplayTypeA = customoption.createCondition(scoreGraphPosition.name, scoreGraphPosition.typeA.num)
	module.isInfoDisplayTypeB = customoption.createCondition(scoreGraphPosition.name, scoreGraphPosition.typeB.num)

	local graphStretchAngle = customoption.parent("グラフバーの伸びる向き")
	graphStretchAngle.left = customoption.chiled("左方向")
	graphStretchAngle.right = customoption.chiled("右方向")
	module.isGraphbarStretchLeft = customoption.createCondition(graphStretchAngle.name, graphStretchAngle.left.num)
	module.isGraphbarStretchRight = customoption.createCondition(graphStretchAngle.name, graphStretchAngle.right.num)

	local graphHidden = customoption.parent("グラフエリア隠し")
	graphHidden.off = customoption.chiled("なし")
	graphHidden.on = customoption.chiled("あり")
	module.isGraphareaCoverOff = customoption.createCondition(graphHidden.name, graphHidden.off.num)
	module.isGraphareaCoverOn = customoption.createCondition(graphHidden.name, graphHidden.on.num)

	local bgaPattern = customoption.parent("BGA表示パターン")
	bgaPattern.typeA = customoption.chiled("1:1")
	bgaPattern.typeB = customoption.chiled("16:9")
	bgaPattern.typeC = customoption.chiled("1:1 x2")
	bgaPattern.typeD = customoption.chiled("16:9 x4")
	bgaPattern.typeE = customoption.chiled("表示しない")
	module.isBgaPattern1_1 = customoption.createCondition(bgaPattern.name, bgaPattern.typeA.num)
	module.isBgaPattern16_9 = customoption.createCondition(bgaPattern.name, bgaPattern.typeB.num)
	module.isBgaPattern1_1_x2 = customoption.createCondition(bgaPattern.name, bgaPattern.typeC.num)
	module.isBgaPattern16_9_x4 = customoption.createCondition(bgaPattern.name, bgaPattern.typeD.num)
	module.isNoBGA = customoption.createCondition(bgaPattern.name, bgaPattern.typeE.num)

	local generalBgaPattern = customoption.parent("汎用BGAの種類")
	generalBgaPattern.movie = customoption.chiled("動画")
	generalBgaPattern.image = customoption.chiled("画像")
	generalBgaPattern.none = customoption.chiled("表示しない")
	module.isHanyoTypeMovie = customoption.createCondition(generalBgaPattern.name, generalBgaPattern.movie.num)
	module.isHanyoTypeImage = customoption.createCondition(generalBgaPattern.name, generalBgaPattern.image.num)
	module.isHanyoDisable = customoption.createCondition(generalBgaPattern.name, generalBgaPattern.none.num)

	local targetSwitch = customoption.parent("ターゲット差分表示")
	targetSwitch.off = customoption.chiled("なし")
	targetSwitch.on = customoption.chiled("あり")
	module.isDiffTargetOff = customoption.createCondition(targetSwitch.name, targetSwitch.off.num)
	module.isDiffTargetOn = customoption.createCondition(targetSwitch.name, targetSwitch.on.num)

	local targetPattern = customoption.parent("ターゲット差分の種類")
	targetPattern.rank = customoption.chiled("目標ランク")
	targetPattern.mybest = customoption.chiled("自己ベスト")
	module.isTargetRank = customoption.createCondition(targetPattern.name, targetPattern.rank.num)
	module.isTargetMybest = customoption.createCondition(targetPattern.name, targetPattern.mybest.num)

	local targetPosition = customoption.parent("ターゲット差分表示位置")
	targetPosition.typeA = customoption.chiled("TYPE-A(判定文字上)")
	targetPosition.typeB = customoption.chiled("TYPE-B（判定文字横）")
	targetPosition.typeC = customoption.chiled("TYPE-C（判定ライン横）")
	targetPosition.typeD = customoption.chiled("TYPE-D（判定文字下）")
	module.isDiffTargetTypeA = customoption.createCondition(targetPosition.name, targetPosition.typeA.num)
	module.isDiffTargetTypeB = customoption.createCondition(targetPosition.name, targetPosition.typeB.num)
	module.isDiffTargetTypeC = customoption.createCondition(targetPosition.name, targetPosition.typeC.num)
	module.isDiffTargetTypeD = customoption.createCondition(targetPosition.name, targetPosition.typeD.num)

	local judgetimingSwitch = customoption.parent("判定タイミング表示")
	judgetimingSwitch.off = customoption.chiled("なし")
	judgetimingSwitch.on = customoption.chiled("あり")
	module.isJudgeTimingOff = customoption.createCondition(judgetimingSwitch.name, judgetimingSwitch.off.num)
	module.isJudgeTimingOn = customoption.createCondition(judgetimingSwitch.name, judgetimingSwitch.on.num)

	local judgetimingPattern = customoption.parent("判定タイミングの種類")
	judgetimingPattern.typeA = customoption.chiled("FAST/SLOW")
	judgetimingPattern.typeB = customoption.chiled("+-ms")
	module.isJudgeTimingWord = customoption.createCondition(judgetimingPattern.name, judgetimingPattern.typeA.num)
	module.isJudgeTimingMs = customoption.createCondition(judgetimingPattern.name, judgetimingPattern.typeB.num)

	local judgetimingPosition = customoption.parent("判定タイミング表示位置")
	judgetimingPosition.typeA = customoption.chiled("TYPE-A(判定文字上)")
	judgetimingPosition.typeB = customoption.chiled("TYPE-B（判定文字横）")
	judgetimingPosition.typeC = customoption.chiled("TYPE-C（判定ライン横）")
	judgetimingPosition.typeD = customoption.chiled("TYPE-D（判定文字下）")
	module.isJudgeTimingTypeA = customoption.createCondition(judgetimingPosition.name, judgetimingPosition.typeA.num)
	module.isJudgeTimingTypeB = customoption.createCondition(judgetimingPosition.name, judgetimingPosition.typeB.num)
	module.isJudgeTimingTypeC = customoption.createCondition(judgetimingPosition.name, judgetimingPosition.typeC.num)
	module.isJudgeTimingTypeD = customoption.createCondition(judgetimingPosition.name, judgetimingPosition.typeD.num)

	local keybeamHeight = customoption.parent("キービームの高さ")
	keybeamHeight.size100 = customoption.chiled("100%")
	keybeamHeight.size90 = customoption.chiled("90%")
	keybeamHeight.size80 = customoption.chiled("80%")
	keybeamHeight.size70 = customoption.chiled("70%")
	keybeamHeight.size60 = customoption.chiled("60%")
	keybeamHeight.size50 = customoption.chiled("50%（短い）")
	keybeamHeight.size40 = customoption.chiled("40%")
	keybeamHeight.size30 = customoption.chiled("30%（とても短い）")
	keybeamHeight.size20 = customoption.chiled("20%")
	keybeamHeight.size10 = customoption.chiled("10%")
	module.isBeamHeight100 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size100.num)
	module.isBeamHeight90 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size90.num)
	module.isBeamHeight80 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size80.num)
	module.isBeamHeight70 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size70.num)
	module.isBeamHeight60 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size60.num)
	module.isBeamHeight50 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size50.num)
	module.isBeamHeight40 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size40.num)
	module.isBeamHeight30 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size30.num)
	module.isBeamHeight20 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size20.num)
	module.isBeamHeight10 = customoption.createCondition(keybeamHeight.name, keybeamHeight.size10.num)

	local keybeamDisappearanceTime = customoption.parent("キービームの消失時間")
	keybeamDisappearanceTime.normal = customoption.chiled("通常")
	keybeamDisappearanceTime.short = customoption.chiled("短い")
	keybeamDisappearanceTime.long = customoption.chiled("長い")
	module.isBeamDisappearanceTimeNormal = customoption.createCondition(keybeamDisappearanceTime.name, keybeamDisappearanceTime.normal.num)
	module.isBeamDisappearanceTimeShort = customoption.createCondition(keybeamDisappearanceTime.name, keybeamDisappearanceTime.short.num)
	module.isBeamDisappearanceTimeLong = customoption.createCondition(keybeamDisappearanceTime.name, keybeamDisappearanceTime.long.num)

	local keybeamDisappearancePattern = customoption.parent("キービームの消失パターン")
	keybeamDisappearancePattern.typeL = customoption.chiled("TYPE-L")
	keybeamDisappearancePattern.typeB = customoption.chiled("TYPE-B")
	module.isBeamDisappearanceTypeL = customoption.createCondition(keybeamDisappearancePattern.name, keybeamDisappearancePattern.typeL.num)
	module.isBeamDisappearanceTypeB = customoption.createCondition(keybeamDisappearancePattern.name, keybeamDisappearancePattern.typeB.num)

	local bombPattern = customoption.parent("ボムの種類")
	bombPattern.modernchic = customoption.chiled("ModernChic規格")
	bombPattern.oadx = customoption.chiled("OADX規格")
	module.isModernChicBomb = customoption.createCondition(bombPattern.name, bombPattern.modernchic.num)
	module.isOADXBomb = customoption.createCondition(bombPattern.name, bombPattern.oadx.num)

	local timingBomb = customoption.parent("判定タイミングボムの使用")
	timingBomb.off = customoption.chiled("使わない")
	timingBomb.on = customoption.chiled("使う（早いか遅いかでボムの色が変化します）")
	module.isJudgeTimingBombOff = customoption.createCondition(timingBomb.name, timingBomb.off.num)
	module.isJudgeTimingBombOn = customoption.createCondition(timingBomb.name, timingBomb.on.num)

	local glowlampSwitch = customoption.parent("グローランプ表示")
	glowlampSwitch.off = customoption.chiled("なし")
	glowlampSwitch.on = customoption.chiled("あり")
	module.isGlowLampOff = customoption.createCondition(glowlampSwitch.name, glowlampSwitch.off.num)
	module.isGlowLampOn = customoption.createCondition(glowlampSwitch.name, glowlampSwitch.on.num)

	local indicatorSwitch = customoption.parent("ゲージMAXインジケータ表示")
	indicatorSwitch.off = customoption.chiled("なし")
	indicatorSwitch.on = customoption.chiled("あり")
	module.isGaugeMaxIndicatorOff = customoption.createCondition(indicatorSwitch.name, indicatorSwitch.off.num)
	module.isGaugeMaxIndicatorOn = customoption.createCondition(indicatorSwitch.name, indicatorSwitch.on.num)

	local gaugeSwitch = customoption.parent("ゲージ隠し")
	gaugeSwitch.off = customoption.chiled("なし")
	gaugeSwitch.on = customoption.chiled("あり")
	module.isGaugeCoverOff = customoption.createCondition(gaugeSwitch.name, gaugeSwitch.off.num)
	module.isGaugeCoverOn = customoption.createCondition(gaugeSwitch.name, gaugeSwitch.on.num)

	local notesDistributionSwitch = customoption.parent("ノート分布隠し")
	notesDistributionSwitch.off = customoption.chiled("なし")
	notesDistributionSwitch.on = customoption.chiled("あり")
	module.isnotesDistributionCoverOff = customoption.createCondition(notesDistributionSwitch.name, notesDistributionSwitch.off.num)
	module.isnotesDistributionCoverOn = customoption.createCondition(notesDistributionSwitch.name, notesDistributionSwitch.on.num)

	local timinggraphSwitch = customoption.parent("タイミンググラフ隠し")
	timinggraphSwitch.off = customoption.chiled("なし")
	timinggraphSwitch.on = customoption.chiled("あり")
	module.isTiminggraphCoverOff = customoption.createCondition(timinggraphSwitch.name, timinggraphSwitch.off.num)
	module.isTiminggraphCoverOn = customoption.createCondition(timinggraphSwitch.name, timinggraphSwitch.on.num)

	local timinggraphPattern = customoption.parent("タイミンググラフパターン")
	timinggraphPattern.typeA = customoption.chiled("分布グラフ")
	timinggraphPattern.typeB = customoption.chiled("棒グラフ")
	module.isTiminggraphTypeA = customoption.createCondition(timinggraphPattern.name, timinggraphPattern.typeA.num)
	module.isTiminggraphTypeB = customoption.createCondition(timinggraphPattern.name, timinggraphPattern.typeB.num)

	local timinggraphMagnification = customoption.parent("タイミンググラフ倍率")
	timinggraphMagnification.low = customoption.chiled("低倍率（+-225ms）")
	timinggraphMagnification.normal = customoption.chiled("標準倍率（+-150ms）")
	timinggraphMagnification.high = customoption.chiled("高倍率（+-75ms）")
	module.isTiminggraphMagnificationLow = customoption.createCondition(timinggraphMagnification.name, timinggraphMagnification.low.num)
	module.isTiminggraphMagnificationNormal = customoption.createCondition(timinggraphMagnification.name, timinggraphMagnification.normal.num)
	module.isTiminggraphMagnificationHigh = customoption.createCondition(timinggraphMagnification.name, timinggraphMagnification.high.num)

	local timinggraphColorPattern = customoption.parent("タイミンググラフ配色パターン")
	timinggraphColorPattern.normal = customoption.chiled("通常")
	timinggraphColorPattern.red = customoption.chiled("赤基調")
	timinggraphColorPattern.green = customoption.chiled("緑基調")
	timinggraphColorPattern.blue = customoption.chiled("青基調")
	module.isTiminggraphColorNormal = customoption.createCondition(timinggraphColorPattern.name, timinggraphColorPattern.normal.num)
	module.isTiminggraphColorRed = customoption.createCondition(timinggraphColorPattern.name, timinggraphColorPattern.red.num)
	module.isTiminggraphColorGreen = customoption.createCondition(timinggraphColorPattern.name, timinggraphColorPattern.green.num)
	module.isTiminggraphColorBlue = customoption.createCondition(timinggraphColorPattern.name, timinggraphColorPattern.blue.num)

	local infomationSwitch = customoption.parent("オートプレイ＆リプレイ時の案内")
	infomationSwitch.off = customoption.chiled("表示しない")
	infomationSwitch.on = customoption.chiled("表示する")
	module.isAutoplayInfoOff = customoption.createCondition(infomationSwitch.name, infomationSwitch.off.num)
	module.isAutoplayInfoOn = customoption.createCondition(infomationSwitch.name, infomationSwitch.on.num)

	local fivekeysCoverSwitch = customoption.parent("5鍵用レーンカバー（5鍵モード時のみ）")
	fivekeysCoverSwitch.off = customoption.chiled("なし")
	fivekeysCoverSwitch.on = customoption.chiled("あり")
	module.is5keyLanecoverOff = customoption.createCondition(fivekeysCoverSwitch.name, fivekeysCoverSwitch.off.num)
	module.is5keyLanecoverOn = customoption.createCondition(fivekeysCoverSwitch.name, fivekeysCoverSwitch.on.num)

	local attackModeSwitch = customoption.parent("戦闘モード")
	attackModeSwitch.off = customoption.chiled("なし")
	attackModeSwitch.on = customoption.chiled("あり")
	module.isAttackModeOff = customoption.createCondition(attackModeSwitch.name, attackModeSwitch.off.num)
	module.isAttackModeOn = customoption.createCondition(attackModeSwitch.name, attackModeSwitch.on.num)

	local finishCoverSwitch = customoption.parent("終了時にレーンカバーを下ろす")
	finishCoverSwitch.off = customoption.chiled("なし")
	finishCoverSwitch.on = customoption.chiled("あり")
	module.isFinishCoverOff = customoption.createCondition(finishCoverSwitch.name, finishCoverSwitch.off.num)
	module.isFinishCoverOn = customoption.createCondition(finishCoverSwitch.name, finishCoverSwitch.on.num)


	local bg = customoption.filepath("背景", "Play/parts/common/bg/*.png")
	local graphbg = customoption.filepath("グラフバー用背景", "Play/parts/sp_hw/graphbg/*.png")
	local generalBgaMovie = customoption.filepath("汎用BGA（動画）", "Play/parts/common/BGA/movie/*.mp4")
	local generalBgaImage = customoption.filepath("汎用BGA（画像）", "Play/parts/common/BGA/image/*.png")
	local keybeamParts = customoption.filepath("キービーム", "Play/parts/common/keybeam/*.png")
	local modernchicBomb = customoption.filepath("ボム（ModernChic規格）", "Play/parts/common/bomb/*.png")
	local oadxBomb = customoption.filepath("ボム（OADX規格）", "Play/parts/common/oadx_bomb/*.png")
	local notesParts = customoption.filepath("ノーツ", "Play/parts/common/notes/*.png")
	local judgeParts = customoption.filepath("判定文字", "Play/parts/common/judge/*.png")
	local laneCoverParts = customoption.filepath("レーンカバー", "Play/parts/sp_hw/lanecover/*.png")
	local liftParts = customoption.filepath("リフト", "Play/parts/sp_hw/lift/*.png")
	local fcParts = customoption.filepath("フルコンボエフェクト", "Play/parts/common/fullcombo/*.png")
	local keyImageParts = customoption.filepath("キーイメージ", "Play/parts/common/key/*.png")
	local keyFlashParts = customoption.filepath("キーフラッシュ", "Play/parts/common/keyflash/*.png")
	local judgelineParts = customoption.filepath("判定ライン色", "Play/parts/common/judgeline/*.png")
	local glowlampParts = customoption.filepath("グローランプ（判定ライン上のやつ）", "Play/parts/common/glow/*.png")
	local progressParts = customoption.filepath("プログレスランプ（進捗バーのあれ）", "Play/parts/common/progress/*.png")
	local indicatorParts = customoption.filepath("ゲージMAXインジケータランプ", "Play/parts/common/lamp/*.png")
	local gaugeParts = customoption.filepath("ゲージ", "Play/parts/common/gauge/*.png")
	local scratchImageParts = customoption.filepath("スクラッチイメージ", "Play/parts/common/scratch/*.png")


	local bgBrightness = customoption.offset("背景の明るさ 0~255 (255で真っ暗になります)")
	module.offsetBgBrightness = customoption.offsetInfo(bgBrightness)
	local graphBrightness = customoption.offset("グラフエリア背景画像の明るさ 0~255 (255で真っ暗になります)")
	module.offsetGraphBrightness = customoption.offsetInfo(graphBrightness)
	local bgaBrightness = customoption.offset("BGAの明るさ 0~255 (255で真っ暗になります)")
	module.offsetBgaBrightness = customoption.offsetInfo(bgaBrightness)
	local tarjudgeOffset = customoption.offset("ターゲット差分、判定タイミングの位置")
	module.offsetTarjudge = customoption.offsetInfo(tarjudgeOffset)
	local bombSize = customoption.offset("ボムの大きさ 1~100%（範囲外は100%になります）")
	module.offsetBombSize = customoption.offsetInfo(bombSize)
	local laneBrightness = customoption.offset("レーンの明るさ 0~255（255で真っ暗になります）")
	module.offsetLaneBrightness = customoption.offsetInfo(laneBrightness)
	local barlineBrightness = customoption.offset("小節線の明るさ 0~255（255で見えなくなります）")
	module.offsetBarlineBrightness = customoption.offsetInfo(barlineBrightness)
	local judgelineHeight = customoption.offset("判定ラインの高さ（0以下はデフォルト値12になります）")
	module.offsetJudgelineHeight = customoption.offsetInfo(judgelineHeight)
	local glowlampHeight = customoption.offset("グローランプの高さ（0以下はデフォルト値48になります）")
	module.offsetGlowlampHeight = customoption.offsetInfo(glowlampHeight)

	--カスタムオプション定義
	module.property = {
		{name = playSide.name, def = playSide.left.name, category = playSide.label, item = {
			{name = playSide.left.name, op = playSide.left.num},
			{name = playSide.right.name, op = playSide.right.num},
		}},
		{name = playPosition.name, def = playPosition.left.name, category = playPosition.label, item = {
			{name = playPosition.left.name, op = playPosition.left.num},
			{name = playPosition.right.name, op = playPosition.right.num},
		}},
		{name = targetSwitch.name, def = targetSwitch.off.name, category = targetSwitch.label, item = {
			{name = targetSwitch.off.name, op = targetSwitch.off.num},
			{name = targetSwitch.on.name, op = targetSwitch.on.num},
		}},
		{name = targetPattern.name, def = targetPattern.rank.name, category = targetPattern.label, item = {
			{name = targetPattern.rank.name, op = targetPattern.rank.num},
			{name = targetPattern.mybest.name, op = targetPattern.mybest.num},
		}},
		{name = targetPosition.name, def = targetPosition.typeA.name, category = targetPosition.label, item = {
			{name = targetPosition.typeA.name, op = targetPosition.typeA.num},
			{name = targetPosition.typeB.name, op = targetPosition.typeB.num},
			{name = targetPosition.typeC.name, op = targetPosition.typeC.num},
			{name = targetPosition.typeD.name, op = targetPosition.typeD.num},
		}},
		{name = judgetimingSwitch.name, def = judgetimingSwitch.off.name, category = judgetimingSwitch.label, item = {
			{name = judgetimingSwitch.off.name, op = judgetimingSwitch.off.num},
			{name = judgetimingSwitch.on.name, op = judgetimingSwitch.on.num},
		}},
		{name = judgetimingPattern.name, def = judgetimingPattern.typeA.name, category = judgetimingPattern.label, item = {
			{name = judgetimingPattern.typeA.name, op = judgetimingPattern.typeA.num},
			{name = judgetimingPattern.typeB.name, op = judgetimingPattern.typeB.num},
		}},
		{name = judgetimingPosition.name, def = judgetimingPosition.typeA.name, category = judgetimingPosition.label, item = {
			{name = judgetimingPosition.typeA.name, op = judgetimingPosition.typeA.num},
			{name = judgetimingPosition.typeB.name, op = judgetimingPosition.typeB.num},
			{name = judgetimingPosition.typeC.name, op = judgetimingPosition.typeC.num},
			{name = judgetimingPosition.typeD.name, op = judgetimingPosition.typeD.num},
		}},
		{name = timingBomb.name, def = timingBomb.off.name, category = timingBomb.label, item = {
			{name = timingBomb.off.name, op = timingBomb.off.num},
			{name = timingBomb.on.name, op = timingBomb.on.num},
		}},
		{name = bombPattern.name, def = bombPattern.modernchic.name, category = bombPattern.label, item = {
			{name = bombPattern.modernchic.name, op = bombPattern.modernchic.num},
			{name = bombPattern.oadx.name, op = bombPattern.oadx.num},
		}},
		{name = graphStretchAngle.name, def = graphStretchAngle.left.name, category = graphStretchAngle.label, item = {
			{name = graphStretchAngle.left.name, op = graphStretchAngle.left.num},
			{name = graphStretchAngle.right.name, op = graphStretchAngle.right.num},
		}},
		{name = scoreGraphPosition.name, def = scoreGraphPosition.typeA.name, category = scoreGraphPosition.label, item = {
			{name = scoreGraphPosition.typeA.name, op = scoreGraphPosition.typeA.num},
			{name = scoreGraphPosition.typeB.name, op = scoreGraphPosition.typeB.num},
		}},
		{name = bitmapFont.name, def = bitmapFont.off.name, category = bitmapFont.label, item = {
			{name = bitmapFont.off.name, op = bitmapFont.off.num},
			{name = bitmapFont.on.name, op = bitmapFont.on.num},
		}},
		-- パーツ表示有無
		{name = glowlampSwitch.name, def = glowlampSwitch.on.name, category = glowlampSwitch.label, item = {
			{name = glowlampSwitch.off.name, op = glowlampSwitch.off.num},
			{name = glowlampSwitch.on.name, op = glowlampSwitch.on.num},
		}},
		{name = indicatorSwitch.name, def = indicatorSwitch.on.name, category = indicatorSwitch.label, item = {
			{name = indicatorSwitch.off.name, op = indicatorSwitch.off.num},
			{name = indicatorSwitch.on.name, op = indicatorSwitch.on.num},
		}},
		{name = gaugeSwitch.name, def = gaugeSwitch.off.name, category = gaugeSwitch.label, item = {
			{name = gaugeSwitch.off.name, op = gaugeSwitch.off.num},
			{name = gaugeSwitch.on.name, op = gaugeSwitch.on.num},
		}},
		{name = graphHidden.name, def = graphHidden.off.name, category = graphHidden.label, item = {
			{name = graphHidden.off.name, op = graphHidden.off.num},
			{name = graphHidden.on.name, op = graphHidden.on.num},
		}},
		{name = notesDistributionSwitch.name, def = notesDistributionSwitch.off.name, category = notesDistributionSwitch.label, item = {
			{name = notesDistributionSwitch.off.name, op = notesDistributionSwitch.off.num},
			{name = notesDistributionSwitch.on.name, op = notesDistributionSwitch.on.num},
		}},
		{name = timinggraphSwitch.name, def = timinggraphSwitch.off.name, category = timinggraphSwitch.label, item = {
			{name = timinggraphSwitch.off.name, op = timinggraphSwitch.off.num},
			{name = timinggraphSwitch.on.name, op = timinggraphSwitch.on.num},
		}},
		{name = timinggraphPattern.name, def = timinggraphPattern.typeA.name, category = timinggraphPattern.label, item = {
			{name = timinggraphPattern.typeA.name, op = timinggraphPattern.typeA.num},
			{name = timinggraphPattern.typeB.name, op = timinggraphPattern.typeB.num},
		}},
		{name = timinggraphMagnification.name, def = timinggraphMagnification.normal.name, category = timinggraphMagnification.label, item = {
			{name = timinggraphMagnification.low.name, op = timinggraphMagnification.low.num},
			{name = timinggraphMagnification.normal.name, op = timinggraphMagnification.normal.num},
			{name = timinggraphMagnification.high.name, op = timinggraphMagnification.high.num},
		}},
		{name = timinggraphColorPattern.name, def = timinggraphColorPattern.normal.name, category = timinggraphColorPattern.label, item = {
			{name = timinggraphColorPattern.normal.name, op = timinggraphColorPattern.normal.num},
			{name = timinggraphColorPattern.red.name, op = timinggraphColorPattern.red.num},
			{name = timinggraphColorPattern.green.name, op = timinggraphColorPattern.green.num},
			{name = timinggraphColorPattern.blue.name, op = timinggraphColorPattern.blue.num},
		}},
		{name = infomationSwitch.name, def = infomationSwitch.on.name, category = infomationSwitch.label, item = {
			{name = infomationSwitch.off.name, op = infomationSwitch.off.num},
			{name = infomationSwitch.on.name, op = infomationSwitch.on.num},
		}},
		{name = keybeamHeight.name, def = keybeamHeight.size50.name, category = keybeamHeight.label, item = {
			{name = keybeamHeight.size100.name, op = keybeamHeight.size100.num},
			{name = keybeamHeight.size90.name, op = keybeamHeight.size90.num},
			{name = keybeamHeight.size80.name, op = keybeamHeight.size80.num},
			{name = keybeamHeight.size70.name, op = keybeamHeight.size70.num},
			{name = keybeamHeight.size60.name, op = keybeamHeight.size60.num},
			{name = keybeamHeight.size50.name, op = keybeamHeight.size50.num},
			{name = keybeamHeight.size40.name, op = keybeamHeight.size40.num},
			{name = keybeamHeight.size30.name, op = keybeamHeight.size30.num},
			{name = keybeamHeight.size20.name, op = keybeamHeight.size20.num},
			{name = keybeamHeight.size10.name, op = keybeamHeight.size10.num},
		}},
		{name = keybeamDisappearanceTime.name, def = keybeamDisappearanceTime.normal.name, category = keybeamDisappearanceTime.label, item = {
			{name = keybeamDisappearanceTime.normal.name, op = keybeamDisappearanceTime.normal.num},
			{name = keybeamDisappearanceTime.short.name, op = keybeamDisappearanceTime.short.num},
			{name = keybeamDisappearanceTime.long.name, op = keybeamDisappearanceTime.long.num},
		}},
		{name = keybeamDisappearancePattern.name, def = keybeamDisappearancePattern.typeB.name, category = keybeamDisappearancePattern.label, item = {
			{name = keybeamDisappearancePattern.typeL.name, op = keybeamDisappearancePattern.typeL.num},
			{name = keybeamDisappearancePattern.typeB.name, op = keybeamDisappearancePattern.typeB.num},
		}},
		{name = bgaPattern.name, def = bgaPattern.typeB.name, category = bgaPattern.label, item = {
			{name = bgaPattern.typeA.name, op = bgaPattern.typeA.num},
			{name = bgaPattern.typeB.name, op = bgaPattern.typeB.num},
			{name = bgaPattern.typeC.name, op = bgaPattern.typeC.num},
			{name = bgaPattern.typeD.name, op = bgaPattern.typeD.num},
			{name = bgaPattern.typeE.name, op = bgaPattern.typeE.num},
		}},
		{name = generalBgaPattern.name, def = generalBgaPattern.movie.name, category = generalBgaPattern.label, item = {
			{name = generalBgaPattern.movie.name, op = generalBgaPattern.movie.num},
			{name = generalBgaPattern.image.name, op = generalBgaPattern.image.num},
			{name = generalBgaPattern.none.name, op = generalBgaPattern.none.num},
		}},
		{name = attackModeSwitch.name, def = attackModeSwitch.off.name, category = attackModeSwitch.label, item = {
			{name = attackModeSwitch.off.name, op = attackModeSwitch.off.num},
			{name = attackModeSwitch.on.name, op = attackModeSwitch.on.num}
		}},
		{name = finishCoverSwitch.name, def = finishCoverSwitch.on.name, category = finishCoverSwitch.label, item = {
			{name = finishCoverSwitch.off.name, op = finishCoverSwitch.off.num},
			{name = finishCoverSwitch.on.name, op = finishCoverSwitch.on.num}
		}}
	}

	-- ファイルパス
	module.filepath = {
		{name = bg.name, path = bg.path, category = bg.label, def = "#default"},
		{name = graphbg.name, path = graphbg.path, category = graphbg.label, def = "#default"},
		{name = generalBgaMovie.name, path = generalBgaMovie.path, category = generalBgaMovie.label, def = "#default"},
		{name = generalBgaImage.name, path = generalBgaImage.path, category = generalBgaImage.label, def = "#default"},
		{name = notesParts.name, path = notesParts.path, category = notesParts.label, def = "#default"},
		{name = judgeParts.name, path = judgeParts.path, category = judgeParts.label, def = "#default"},
		{name = laneCoverParts.name, path = laneCoverParts.path, category = laneCoverParts.label, def = "#default"},
		{name = liftParts.name, path = liftParts.path, category = liftParts.label, def = "#default"},
		{name = modernchicBomb.name, path = modernchicBomb.path, category = modernchicBomb.label, def = "diamond SCUROed."},
		{name = oadxBomb.name, path = oadxBomb.path, category = oadxBomb.label, def = "DEFAULT"},
		{name = fcParts.name, path = fcParts.path, category = fcParts.label, def = "#default"},
		{name = keybeamParts.name, path = keybeamParts.path, category = keybeamParts.label, def = "#default"},
		{name = keyImageParts.name, path = keyImageParts.path, category = keyImageParts.label, def = "harf"},
		{name = keyFlashParts.name, path = keyFlashParts.path, category = keyFlashParts.label, def = "#default"},
		{name = judgelineParts.name, path = judgelineParts.path, category = judgelineParts.label, def = "#default"},
		{name = glowlampParts.name, path = glowlampParts.path, category = glowlampParts.label, def = "#default"},
		{name = progressParts.name, path = progressParts.path, category = progressParts.label, def = "#default"},
		{name = indicatorParts.name, path = indicatorParts.path, category = indicatorParts.label, def = "#default"},
		{name = gaugeParts.name, path = gaugeParts.path, category = gaugeParts.label, def = "#default"},
		{name = scratchImageParts.name, path = scratchImageParts.path, category = scratchImageParts.label, def = "#default"}
	}

	-- offsetのユーザー定義は40以降
	module.offset = {
		{name = bgaBrightness.name, id = bgaBrightness.num, category = bgaBrightness.label, a = 0},
		{name = bgBrightness.name, id = bgBrightness.num, category = bgBrightness.label, a = 0},
		{name = laneBrightness.name, id = laneBrightness.num, category = laneBrightness.label, a = 0},
		{name = barlineBrightness.name, id = barlineBrightness.num, category = barlineBrightness.label, a = 0},
		{name = graphBrightness.name, id = graphBrightness.num, category = graphBrightness.label, a = 0},
		{name = judgelineHeight.name, id = judgelineHeight.num, category = judgelineHeight.label, h = 0},
		{name = glowlampHeight.name, id = glowlampHeight.num, category = glowlampHeight.label, h = 0},
		{name = tarjudgeOffset.name, id = tarjudgeOffset.num, category = tarjudgeOffset.label, x = 0, y = 0},
		{name = bombSize.name, id = bombSize.num, category = bombSize.label, w = 0},
	}

	--[[
		カスタムカテゴリ
		カスタムオプション、ファイルパス、オフセットを関連付け
	]]
	module.category = {
		--カスタムオプション定義
		{name = "メインオプション", item = {
			playSide.label,
			playPosition.label,
			bitmapFont.label,
			scoreGraphPosition.label,
			finishCoverSwitch.label
		}},
		{name = "背景", item = {
			bg.label,
			bgBrightness.label
		}},
		{name = "グラフエリア", item = {
			graphbg.label,
			graphStretchAngle.label,
			graphHidden.label,
			graphBrightness.label
		}},
		{name = "BGA", item = {
			bgaPattern.label,
			generalBgaPattern.label,
			generalBgaMovie.label,
			generalBgaImage.label,
			bgaBrightness.label
		}},
		{name = "ターゲットと判定タイミング", item = {
			targetSwitch.label,
			targetPattern.label,
			targetPosition.label,
			judgetimingSwitch.label,
			judgetimingPattern.label,
			judgetimingPosition.label,
			tarjudgeOffset.label
		}},
		{name = "キービーム", item = {
			keybeamParts.label,
			keybeamHeight.label,
			keybeamDisappearanceTime.label,
			keybeamDisappearancePattern.label
		}},
		{name = "ボム", item = {
			bombPattern.label,
			timingBomb.label,
			modernchicBomb.label,
			oadxBomb.label,
			bombSize.label
		}},
		{name = "判定タイミンググラフ", item = {
			timinggraphPattern.label,
			timinggraphSwitch.label,
			timinggraphMagnification.label,
			timinggraphColorPattern.label
		}},
		{name = "パーツ選択", item = {
			notesParts.label,
			judgeParts.label,
			laneCoverParts.label,
			liftParts.label,
			fcParts.label,
			keyImageParts.label,
			keyFlashParts.label,
			judgelineParts.label,
			glowlampParts.label,
			progressParts.label,
			indicatorParts.label,
			gaugeParts.label,
			scratchImageParts.label
		}},
		{name = "オフセット（位置、大きさ、明暗調整）", item = {
			laneBrightness.label,
			barlineBrightness.label,
			judgelineHeight.label,
			glowlampHeight.label
		}},
	}

	if is5keys then
		table.insert(module.property, {
			name = fivekeysCoverSwitch.name, def = fivekeysCoverSwitch.on.name, category = fivekeysCoverSwitch.label, item = {
				{name = fivekeysCoverSwitch.off.name, op = fivekeysCoverSwitch.off.num},
				{name = fivekeysCoverSwitch.on.name, op = fivekeysCoverSwitch.on.num},
			}
		})
		table.insert(module.category, #module.category, {
			name = "パーツ表示有無", item = {
				glowlampSwitch.label,
				indicatorSwitch.label,
				gaugeSwitch.label,
				notesDistributionSwitch.label,
				infomationSwitch.label,
				fivekeysCoverSwitch.label,
				attackModeSwitch.label
			}
		})
	else
		table.insert(module.category, #module.category, {
			name = "パーツ表示有無", item = {
				glowlampSwitch.label,
				indicatorSwitch.label,
				gaugeSwitch.label,
				notesDistributionSwitch.label,
				infomationSwitch.label,
				attackModeSwitch.label
			}
		})
	end

	if DEBUG then
		print("SP用カスタムオプション最大値：" ..customoptionNumber .."\nSP用カテゴリ最大値：" ..categoryNumber .."\nSP用オフセット最大値：" ..offsetNumber)
	end
	
	return module
end

return{
	load = load
}
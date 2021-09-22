--[[
	スキン基本設定
	@author : KASAKO
]]
local header = {
	type = 6,	-- 0:7k, 1:5k, 2:12k, 3:10k, 4:9k, 5:select, 6:decide, 7:result, 15:courceresult, 16:24k, 17:24kDouble
	name = "DecideTemp-" .."(MCTE)",   --(MCTE)表記は消さないで！
	w = 1920,
	h = 1080,
	fadeout = 1000,	-- フェードアウト時間（メインシーン後）
	scene = 3000,	-- メインシーン時間
	input = 500,	-- スキップ可能時間
	property = PROPERTY.property,
	filepath = PROPERTY.filepath,
	category = PROPERTY.category
}
return header
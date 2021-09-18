local header = {
	type = 6,
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
--[[
	閉店ガラガラ
--]]

local function load(imageId)
	local parts = {}
	
	local frameClosetime = 500
	local frameCloseacc = MAIN.ACC.DECELERATE
	
	parts.image = {
		{id = "close_frame_top", src = imageId, x = 0, y = 0, w = 1920, h = 565},
		{id = "close_frame_bottom", src = imageId, x = 0, y = 600, w = 1920, h = 565},
		{id = "close_msg_window", src = imageId, x = 0, y = 1200, w = 1920, h = 317},
		{id = "close_msg_arrow", src = imageId, x = 0, y = 1600, w = 2200, h = 105},
		{id = "close_msg_arrow2", src = imageId, x = 0, y = 1900, w = 2200, h = 66},
		{id = "close_word_stage", src = imageId, x = 250, y = 1750, w = 700, h = 150},
		{id = "close_word_failed", src = imageId, x = 950, y = 1750, w = 730, h = 150},
		-- クイックリトライのお知らせ
		{id = "close_quickRetry", src = imageId, x = 0, y = 1980, w = 800, h = 108},
		-- 修飾パーツ
		{id = "close_beam", src = imageId, x = 1981, y = 1, w = 57, h = 19, divx = 3, cycle = 100},
	}
	
	parts.destination = {}
	
	-- フレーム
	table.insert(parts.destination,	{
		id = "close_frame_top", loop = frameClosetime, timer = MAIN.TIMER.FAILED, dst = {
			{time = 0, x = 0, y = 1080, w = 1920, h = 565, acc = frameCloseacc},
			{time = frameClosetime, y = 515}
		}
	})
		
	table.insert(parts.destination,	{
		id = "close_frame_bottom", loop = frameClosetime, timer = MAIN.TIMER.FAILED, dst = {
			{time = 0, x = 0, y = -565, w = 1920, h = 565, acc = frameCloseacc},
			{time = frameClosetime, y = 0}
		}
	})
		
	table.insert(parts.destination,	{
		id = "close_msg_window", loop = 800, timer = MAIN.TIMER.FAILED, dst = {
			{time = 500, x = 0, y = 540, w = 1920, h = 0, acc = 1},
			{time = 800, y = 381, h = 317}
		}
	})
	table.insert(parts.destination,	{
		id = "close_msg_arrow", loop = 3000, timer = MAIN.TIMER.FAILED, dst = {
			{time = 800, x = 0, y = 487, w = 2200, h = 105, a = 100, acc = MAIN.ACC.DECELERATE},
			{time = 3000, x = -200, a = 255}
		}
	})
	table.insert(parts.destination,	{
		id = "close_msg_arrow2", loop = 3000, timer = MAIN.TIMER.FAILED, dst = {
			{time = 800, x = -200, y = 814, w = 2200, h = 66, a = 100, acc = MAIN.ACC.DECELERATE},
			{time = 3000, x = 0, a = 255}
		}
	})
	table.insert(parts.destination,	{
		id = "close_msg_arrow2", loop = 3000, timer = MAIN.TIMER.FAILED, dst = {
			{time = 800, x = -200, y = 220, w = 2200, h = 66, a = 100, acc = MAIN.ACC.DECELERATE},
			{time = 3000, x = 0, a = 255}
		}
	})
	table.insert(parts.destination,	{
		id = "close_word_stage", loop = 3000, timer = MAIN.TIMER.FAILED, dst = {
			{time = 800, x = 960, y = 460, w = 700, h = 150, a = 0, acc = MAIN.ACC.DECELERATE},
			{time = 1500, x = 280, a = 255, acc = 0},
			{time = 3000, x = 250},
		}
	})
	table.insert(parts.destination,	{
		id = "close_word_failed", loop = 3000, timer = MAIN.TIMER.FAILED, dst = {
			{time = 800, x = 480, y = 460, w = 700, h = 150, a = 0, acc = MAIN.ACC.DECELERATE},
			{time = 1500, x = 940, a = 255, acc = 0},
			{time = 3000, x = 970},
		}
	})

	-- クイックリトライのお知らせ
	if main_state.option(32) then
		if main_state.option(-290) then
			table.insert(parts.destination, {
				id = "close_quickRetry", loop = 600, timer = MAIN.TIMER.FAILED, dst = {
					{time = 500, x = 560, y = 793, w = 800, h = 108, a = 0},
					{time = 600, a = 255}
				}
			})
		end
	end
	
	-- 修飾パーツ
	do
		local num = 10
		local delayTime = 0
		for i = 1, num, 1 do
			delayTime = delayTime + 100
			table.insert(parts.destination,{
				id = "close_beam", timer = MAIN.TIMER.FAILED, loop = -1, dst = {
					{time = 700 + delayTime, x = -19, y = 688, w = 19, h = 19, acc = 1},
					{time = 1500 + delayTime, x = 1939}
				}
			})
			table.insert(parts.destination,{
				id = "close_beam", timer = MAIN.TIMER.FAILED, loop = -1, dst = {
					{time = 700 + delayTime, x = 1939, y = 372, w = 19, h = 19, acc = 1},
					{time = 1500 + delayTime, x = -19}
				}
			})
		end
	end
	
	-- フェードアウト処理
	table.insert(parts.destination,	{
		id = -110, timer = MAIN.TIMER.FAILED, loop = 3000, dst = {
			{time = 2500, x = 0, y = 0, w = 1920, h = 1080, a = 0},
			{time = 3000, a = 255}
		}
	})
	
	return parts
end

return {
	load = load
}
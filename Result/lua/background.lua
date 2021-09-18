--[[
	背景表示
]]

-- コース中のリザルトなのか？（op280~293が機能しない？）
local function isCourse()
	-- コース1タイトルがあればコースであると判断
	if main_state.text(MAIN.STRING.COURSE1_TITLE) ~= "" then
		return true
	else
		return false
	end
end

local function createColorNum()
	local red
	local green
	local blue
	if main_state.option(MAIN.OP.RESULT_CLEAR) then
		-- clear
		red = math.random(50, 100)
		green = math.random(50, 100)
		blue = math.random(150, 255)
	elseif main_state.option(MAIN.OP.RESULT_FAIL) then
		-- failed
		red = math.random(150, 255)
		green = math.random(50, 100)
		blue = math.random(50, 100)
	end
	return {red, green, blue}
end

local function load()
	local parts = {}

	local bgWidth = 1920
	local bgHeight = 1080

	parts.source = {}
	parts.image = {
		-- 修飾
		{id = "ring", src = 0, x = 0, y = 0, w = 1920, h = 1080},
		{id = "beam", src = 2, x = 0, y = 1778, w = 960, h = 30},
	}
	parts.imageset = {}
	parts.destination = {}

	-- 背景
	if PROPERTY.isBackgroundClearFailed() then
		local wd = {"bgClear", "bgFailed"}
		local path = {"clear", "failed"}
		local op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
		for i = 1, #wd, 1 do
			table.insert(parts.source, {id = wd[i], path = "Result/parts/bg/isclear/" ..path[i] .."/*.png"})
			table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
			table.insert(parts.destination, {
				id = wd[i], op = {op[i]}, dst = {
					{x = 0, y = 0, w = 1920, h = 1080},
				}
			})
		end
	elseif PROPERTY.isBackgroundAll() then
		table.insert(parts.source, {id = 10, path = "Result/parts/bg/all/*.png"})
		table.insert(parts.image, {id = "bgAll", src = 10, x = 0, y = 0, w = 1920, h = 1080})
		table.insert(parts.destination, {
			id = "bgAll", dst = {
				{x = 0, y = 0, w = 1920, h = 1080},
			}
		})
	elseif PROPERTY.isBackgroundRank() then
		local wd = {"bgRankAAA", "bgRankAA", "bgRankA", "bgRankB", "bgRankC", "bgRankD", "bgRankE", "bgRankF"}
		local path = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
		local op = {MAIN.OP.RESULT_AAA_1P,MAIN.OP.RESULT_AA_1P, MAIN.OP.RESULT_A_1P, MAIN.OP.RESULT_B_1P, MAIN.OP.RESULT_C_1P, MAIN.OP.RESULT_D_1P, MAIN.OP.RESULT_E_1P, MAIN.OP.RESULT_F_1P}
		for i = 1, #wd, 1 do
			table.insert(parts.source, {id = wd[i], path = "Result/parts/bg/rank/" ..path[i] .."/*.png"})
			table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
			table.insert(parts.destination, {
				id = wd[i], op = {op[i]}, dst = {
					{x = 0, y = 0, w = 1920, h = 1080},
				}
			})
		end
	elseif PROPERTY.isBackgroundClearType() then
		-- コース通過時のリザルトでClearTypeにしていた場合はisBackgroundClearFailedの挙動に
		if isCourse() then
			local wd = {"bgClear", "bgFailed"}
			local path = {"clear", "failed"}
			local op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
			for i = 1, #wd, 1 do
				table.insert(parts.source, {id = wd[i], path = "Result/parts/bg/isclear/" ..path[i] .."/*.png"})
				table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
				table.insert(parts.destination, {
					id = wd[i], op = {op[i]}, dst = {
						{x = 0, y = 0, w = 1920, h = 1080},
					}
				})
			end
		else
			local wd = {"bgFailed2", "bgAssist", "bgLaAssist", "bgEasy", "bgNormal", "bgHard", "bgExhard", "bgFullCombo", "bgPerfect", "bgMax"}
			local path = {"failed", "assist", "laassist", "easy", "normal", "hard", "exhard", "fullcombo", "perfect", "max"}
			for i = 1, #wd, 1 do
				table.insert(parts.source, {id = wd[i], path = "Result/parts/bg/clearType/" ..path[i] .."/*.png"})
				table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
			end
			table.insert(parts.imageset,{
				id = "bgClearType", ref = MAIN.NUM.CLEAR, images = {"bgNormal", "bgFailed2", "bgAssist", "bgLaAssist", "bgEasy", "bgNormal", "bgHard", "bgExhard", "bgFullCombo", "bgPerfect", "bgMax"}
			})
			table.insert(parts.destination, {
				id = "bgClearType", dst = {
					{x = 0, y = 0, w = 1920, h = 1080},
				}
			})
		end
	end

	-- 背景用明るさ調整
	table.insert(parts.destination, {
		id = -110, offsets = {PROPERTY.offsetBgBrightness}, dst = {
			{x = 0, y = 0, w = 1920, h = 1080, a = 0},
		}
	})

	-- 修飾
	if PROPERTY.isRingOn() then
		table.insert(parts.destination, {
			id = "ring", blend = 2, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 1080, a = 30},
				{time = 20000, angle = 360},
			}
		})
	end
	if PROPERTY.isBeamOn() then
		local rgb = createColorNum()
		table.insert(parts.destination, {
			id = "beam", blend = MAIN.BLEND.ADDITION, dst = {
				{time = 0, x = 0, y = 0, w = 1920, h = 30, r = rgb[1], g = rgb[2], b = rgb[3], a = 200},
				{time = 5000, y = 1080 / 2, a = 0},
				{time = 6500}
			}
		})
	end

	-- 重ね絵機能
	if PROPERTY.isCharOn() then
		local animationTime = 200
		if PROPERTY.isCharClearFailed() then
			local wd = {"charClear", "charFailed"}
			local path = {"clear", "failed"}
			local op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
			for i = 1, #wd, 1 do
				table.insert(parts.source, {id = wd[i], path = "Result/parts/char/isclear/" ..path[i] .."/*.png"})
				table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
				table.insert(parts.destination, {
					id = wd[i], op = {op[i]}, loop = animationTime, offsets = {PROPERTY.offsetCharPosition}, dst = {
						{time = 0, x = - (bgWidth / 2), y = - (bgHeight / 2), w = bgWidth * 2, h = bgHeight * 2},
						{time = animationTime, x = 0, y = 0, w = bgWidth, h = bgHeight}
					}
				})
			end
		elseif PROPERTY.isCharAll() then
			table.insert(parts.source, {id = "charAll", path = "Result/parts/char/all/*.png"})
			table.insert(parts.image, {id = "charAll", src = "charAll", x = 0, y = 0, w = 1920, h = 1080})
			table.insert(parts.destination, {
				id = "charAll", loop = animationTime, offsets = {PROPERTY.offsetCharPosition}, dst = {
					{time = 0, x = - (bgWidth / 2), y = - (bgHeight / 2), w = bgWidth * 2, h = bgHeight * 2},
					{time = animationTime, x = 0, y = 0, w = bgWidth, h = bgHeight}
				}
			})
		elseif PROPERTY.isCharRank() then
			local wd = {"charRankAAA", "charRankAA", "charRankA", "charRankB", "charRankC", "charRankD", "charRankE", "charRankF"}
			local path = {"AAA", "AA", "A", "B", "C", "D", "E", "F"}
			local op = {MAIN.OP.RESULT_AAA_1P,MAIN.OP.RESULT_AA_1P, MAIN.OP.RESULT_A_1P, MAIN.OP.RESULT_B_1P, MAIN.OP.RESULT_C_1P, MAIN.OP.RESULT_D_1P, MAIN.OP.RESULT_E_1P, MAIN.OP.RESULT_F_1P}
			for i = 1, #wd, 1 do
				table.insert(parts.source, {id = wd[i], path = "Result/parts/char/rank/" ..path[i] .."/*.png"})
				table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
				table.insert(parts.destination, {
					id = wd[i], op = {op[i]}, loop = animationTime, offsets = {PROPERTY.offsetCharPosition}, dst = {
						{time = 0, x = - (bgWidth / 2), y = - (bgHeight / 2), w = bgWidth * 2, h = bgHeight * 2},
						{time = animationTime, x = 0, y = 0, w = bgWidth, h = bgHeight}
					}
				})
			end
		elseif PROPERTY.isCharClearType() then
			-- コース通過時のリザルトでClearTypeにしていた場合はisBackgroundClearFailedの挙動に
			if isCourse() then
				local wd = {"charClear", "charFailed"}
				local path = {"clear", "failed"}
				local op = {MAIN.OP.RESULT_CLEAR, MAIN.OP.RESULT_FAIL}
				for i = 1, #wd, 1 do
					table.insert(parts.source, {id = wd[i], path = "Result/parts/char/isclear/" ..path[i] .."/*.png"})
					table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
					table.insert(parts.destination, {
						id = wd[i], op = {op[i]}, loop = animationTime, offsets = {PROPERTY.offsetCharPosition}, dst = {
							{time = 0, x = - (bgWidth / 2), y = - (bgHeight / 2), w = bgWidth * 2, h = bgHeight * 2},
							{time = animationTime, x = 0, y = 0, w = bgWidth, h = bgHeight}
						}
					})
				end
			else
				local wd = {"charFailed2", "charAssist", "charLaAssist", "charEasy", "charNormal", "charHard", "charExhard", "charFullCombo", "charPerfect", "charMax"}
				local path = {"failed", "assist", "laassist", "easy", "normal", "hard", "exhard", "fullcombo", "perfect", "max"}
				for i = 1, #wd, 1 do
					table.insert(parts.source, {id = wd[i], path = "Result/parts/char/clearType/" ..path[i] .."/*.png"})
					table.insert(parts.image, {id = wd[i], src = wd[i], x = 0, y = 0, w = 1920, h = 1080})
				end
				table.insert(parts.imageset,{
					id = "charClearType", ref = MAIN.NUM.CLEAR, images = {"charNormal", "charFailed2", "charAssist", "charLaAssist", "charEasy", "charNormal", "charHard", "charExhard", "charFullCombo", "charPerfect", "charMax"}
				})

				table.insert(parts.destination, {
					id = "charClearType", loop = animationTime, offsets = {PROPERTY.offsetCharPosition}, dst = {
						{time = 0, x = - (bgWidth / 2), y = - (bgHeight / 2), w = bgWidth * 2, h = bgHeight * 2},
						{time = animationTime, x = 0, y = 0, w = bgWidth, h = bgHeight}
					}
				})
			end
		end
	end

	return parts
end

return {
	load = load
}
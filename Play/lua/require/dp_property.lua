-- DP用（10鍵、14鍵）用プロパティ
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

local function load(is10keys)
	local targetSwitch = customoption.parent("ターゲット差分表示")
	targetSwitch.off, module.isDiffTargetOff = customoption.chiled("なし", targetSwitch.name)
	targetSwitch.on, module.isDiffTargetOn = customoption.chiled("あり", targetSwitch.name)

	module.property = {
		--カスタムオプション定義
		{name = targetSwitch.name, def = targetSwitch.off.name, category = targetSwitch.label, item = {
			{name = targetSwitch.off.name, op = targetSwitch.off.num},
			{name = targetSwitch.on.name, op = targetSwitch.on.num},
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
		print("DP用カスタムオプション最大値：" ..customoptionNumber .."\nDP用カテゴリ最大値：" ..categoryNumber .."\nDP用オフセット最大値：" ..offsetNumber)
	end

	return module
end

return{
	load = load
}
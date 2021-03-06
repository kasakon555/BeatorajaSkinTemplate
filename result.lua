--[[
	リザルト画面
	blog: https://www.kasacontent.com/tag/modernchic/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
timer_util = require("timer_util")
PROPERTY = require("Result.lua.require.property").load(true)
-- ヘッダ読み込み
local header = require("Result.lua.require.header").load(7)

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	-- テキスト関連
	local textProperty = require("Result.lua.require.textproperty")
	-- カスタムタイマー
	local CUSTOMTIMER_ID = 9999
	-- タイマー値をインクリメント
	function get_customTimer_id()
		CUSTOMTIMER_ID = CUSTOMTIMER_ID + 1
		return CUSTOMTIMER_ID
	end
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)

	skin.source =  {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.imageset = {}
	skin.value = {}
	skin.slider = {}
	skin.graph = {}
	skin.gauge = {}
	skin.gaugegraph = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingdistributiongraph = {}
	skin.customTimers = {}
	skin.customEvents = {}
	skin.destination = {}

	-- サンプル
	do
		local path = skin_config.get_path("Result/lua/background.lua")
		local status, parts = pcall(function()
			return dofile(path).load()
		end)
		if status and parts then
			CUSTOM.ADD_ALL(skin.source, parts.source)
			CUSTOM.ADD_ALL(skin.image, parts.image)
			CUSTOM.ADD_ALL(skin.imageset, parts.imageset)
			CUSTOM.ADD_ALL(skin.destination, parts.destination)
		end
	end
	
	return skin
end

return{
	header = header,
	main = main
}
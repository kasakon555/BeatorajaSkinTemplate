--[[
	コースリザルト画面(MCTE)
	blog: https://www.kasacontent.com/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
timer_util = require("timer_util")
-- requireはディレクトリ区切りを.で表す
PROPERTY = require("Result.lua.require.property").load(false)
-- ヘッダ読み込み
local header = require("Result.lua.require.header").load(15)

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
	--[[
		ここから-----------------------------------------------------------------------------
	]]
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

	return skin
end
--[[
	ここまで-----------------------------------------------------------------------------
]]
return{
	header = header,
	main = main
}
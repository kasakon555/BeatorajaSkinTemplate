--[[
	曲選択画面(MCTE)
	blog : https://www.kasacontent.com/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
timer_util = require("timer_util")
PROPERTY = require("Select.lua.require.property")
local header = require("Select.lua.require.header")

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	-- テキスト関連
	local textProperty = require("Select.lua.require.textproperty")
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
	skin.source = {}
	skin.image = {}
	skin.imageset = {}
	skin.graph = {}
	skin.slider = {}
	skin.value = {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.songlist = {}
	skin.customTimers = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
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
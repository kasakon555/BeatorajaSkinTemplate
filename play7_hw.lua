--[[
	7鍵用メインLua(MCTE)
	blog: https://www.kasacontent.com/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
-- requireはディレクトリ区切りを.で表す
PROPERTY = require("Play.lua.require.sp_property").load(false)
COMMONFUNC = require("Play.lua.require.common")
-- ヘッダ読み込み
local header = require("Play.lua.require.header").load(0)

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	-- テキスト
	local textProperty = require("Play.lua.require.textproperty")
	-- カスタムタイマー
	local CUSTOMTIMER_ID = 9999
	-- カスタムタイマーインクリメント
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
	skin.note = {}
	skin.value = {}
	skin.slider = {}
	skin.hiddenCover = {}
	skin.liftCover = {}
	skin.graph = {}
	skin.bga = {id = "bga"}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingvisualizer = {}
	skin.judge = {}
	skin.gauge = {}
	skin.destination = {}
	
	-- サンプル
	do
		local background_path = skin_config.get_path("Play/lua/background.lua")
		local background_status, background_parts = pcall(function()
			return dofile(background_path).load(3)
		end)
		if background_status and background_parts then
			CUSTOM.ADD_ALL(skin.image, background_parts.image)
			CUSTOM.ADD_ALL(skin.destination, background_parts.destination)
		end
	end
	
	return skin
end

return{
	header = header,
	main = main
}
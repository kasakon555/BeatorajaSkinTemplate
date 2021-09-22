--[[
	10鍵用メインLua(MCTE)
	blog: https://www.kasacontent.com/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
-- requireはディレクトリ区切りを.で表す
PROPERTY = require("Play.lua.require.dp_property").load(true)
COMMONFUNC = require("Play.lua.require.common")
-- ヘッダ読み込み
local header = require("Play.lua.require.header").load(3)

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	-- テキスト
	local textProperty = require("Play.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
--[[
	ここから-----------------------------------------------------------------------------
]]
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
	skin.bga = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.timingvisualizer = {}
	skin.judge = {}
	skin.gauge = {}
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
--[[
	曲決定画面(MCTE)
	blog: https://www.kasacontent.com/
]]
DEBUG = false
-- モジュール読み込み
main_state = require("main_state")
PROPERTY = require("Decide.lua.require.property")
local header = require("Decide.lua.require.header")

local function main()
	-- 基本定義読み込み
	MAIN = require("Root.define")
	CUSTOM = require("Root.define2")
	-- テキスト関連
	local textProperty = require("Decide.lua.require.textproperty")
	local skin = {}
	CUSTOM.LOAD_HEADER(skin, header)
	
	skin.source =  {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.image = {}
	skin.value = {}
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.destination = {}
	
	return skin
end

return{
	header = header,
	main = main
}
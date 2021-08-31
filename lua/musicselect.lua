--[[
	曲選択画面
	blog : https://www.kasacontent.com/tag/modernchictemplateengine/
    @author : KASAKO
]]
DEBUG = false
main_state = require("main_state")
-- スキンプロパティ
PROPERTY = require("Select.require.property")
-- スキンヘッダ
local header = require("Select.require.header").load()
-- テーブルに要素を追加する
local function add_all(list, t)
	if t then
		for i, v in ipairs(t) do
			table.insert(list, v)
		end
	end
end

local function main()
	-- 基本定義読み込み
	MAIN = require("common.define")
	CUSTOM = require("common.define2")
	-- テキスト関連
	local textProperty = require("Select.require.textproperty")
	local skin = {}
    -- ヘッダ情報のコピー
	for k, v in pairs(header) do
		skin[k] = v
	end
    -- 構成要素
	skin.source = {}
	skin.image = {}
	skin.imageset = {}
	skin.graph = {}
	skin.slider = {}
	skin.value = {}
	skin.font = textProperty.font
	skin.text = textProperty.text
	skin.songlist = {}
	skin.customTimers = CUSTOM.TIMER.customTimers
	skin.judgegraph = {}
	skin.bpmgraph = {}
	skin.destination = {}

    -- ここから各部品を追加していく ---------------------------------------------------------------
	-- 背景
	do
		local bg_path = skin_config.get_path("Select/bg.lua")
		local bg_status, bg_parts = pcall(function()
			return dofile(bg_path).load()
		end)
		if bg_status and bg_parts then
            add_all(skin.source, bg_parts.source)
			add_all(skin.image, bg_parts.image)
			add_all(skin.destination, bg_parts.destination)
		end
	end
    -- ここまで -----------------------------------------------------------------------------------
	return skin
end

return{
	header = header,
	main = main
}
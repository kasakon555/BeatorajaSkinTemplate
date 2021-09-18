--[[
    カスタムパラメータ定義
    DATE:21/09/11
    @author : KASAKO
]]
local m = {}
-- ヘッダ情報読み込み
m.LOAD_HEADER = function(skin, header)
	for i, v in pairs(header) do
		skin[i] = v
	end
end
-- テーブルに要素を追加する
m.ADD_ALL = function(list, t)
	if t then
		for i, v in ipairs(t) do
			table.insert(list, v)
		end
	end
end

m.OP = require("Root.customoption")
m.NUM = require("Root.customnumber")
m.GRAPH = require("Root.customgraph")
m.SLIDER = require("Root.customslider")
return m
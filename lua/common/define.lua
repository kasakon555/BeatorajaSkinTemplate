--[[
    基本パラメータ定義
]]
local m = {}
m.ACC = {
    CONSTANT = 0,
    ACCELERATION = 1,
    DECELERATE = 2,
    DISCONTINUOUS = 3
}
m.BLEND = {
    OFF = 0,
    ALPHA = 1,
    ADDITION = 2,
    SUBTRACTION = 3,
    MULTIPLY = 4,
    XOR = 6,
    MULTIPLYINVERSION = 9,
    INVERSION = 10,
    MULTIPLYALPHA = 11
}
m.FILTER = {
    OFF = 0,
    ON = 1
}
m.ALIGN = {
    RIGHT = 0,
    LEFT = 1,
    CENTER = 2
}
m.ANGLE = {
    RIGHT = 0,
    DOWN = 1
}
m.CLICK = {
    OFF = 0,
    ON = 1
}
-- Destinationの領域の端で折り返す
m.WRAPPING = {
    OFF = false,
    ON = true
}
-- WRAPPINGがfalseの時にはみ出した場合
m.OVERFLOW = {
    NOTHING = 0,
    SHRINK = 1,
    TRUNCATION = 2
}
m.OP = require("common.mainoption")
m.NUM = require("common.mainnumber")
m.TIMER = require("common.maintimer")
m.STRING = require("common.mainstring")
m.BUTTON = require("common.mainbutton")
m.OFFSET = require("common.mainoffset")
m.GRAPH = require("common.maingraph")
m.SLIDER = require("common.mainslider")
m.IMAGE = require("common.mainimage")
return m
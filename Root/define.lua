--[[
    基本パラメータ定義
    DATE:21/09/13
    @author : KASAKO
]]
local m = {}
m.ACC = {
    -- 等速
    CONSTANT = 0,
    -- 加速
    ACCELERATION = 1,
    -- 減速
    DECELERATE = 2,
    -- 不連続
    DISCONTINUOUS = 3
}
m.BLEND = {
    -- なし
    OFF = 0,
    -- アルファ
    ALPHA = 1,
    -- 加算描画
    ADDITION = 2,
    -- 減算描画
    SUBTRACTION = 3,
    -- 乗算描画
    MULTIPLY = 4,
    -- XOR
    XOR = 6,
    -- 描画先の色の反転値を掛ける
    MULTIPLYINVERSION = 9,
    -- 反転描画
    INVERSION = 10,
    -- αチャンネル考慮付き乗算
    MULTIPLYALPHA = 11
}
m.FILTER = {
    OFF = 0,
    ON = 1
}
-- 表示位置（数値用）
m.N_ALIGN = {
    RIGHT = 0,
    LEFT = 1,
    CENTER = 2
}
-- 表示位置（テキスト用）
m.T_ALIGN = {
    LEFT = 0,
    CENTER = 1,
    RIGHT = 2
}
-- 移動方向（graph用）
m.G_ANGLE = {
    RIGHT = 0,
    DOWN = 1
}
-- 移動方向（slider用）
m.S_ANGLE = {
    UP = 0,
    RIGHT = 1,
    DOWN = 2,
    LEFT = 3
}
m.I_CLICK = {
    OFF = 0,
    ON = 1
}
-- Destinationの領域の端で折り返す
m.T_WRAPPING = {
    OFF = false,
    ON = true
}
-- WRAPPINGがfalseの時にはみ出した場合
m.T_OVERFLOW = {
    NOTHING = 0,
    SHRINK = 1,
    TRUNCATION = 2
}
-- 画像の伸縮
m.STRETCH = {
    -- 描画先の範囲に合わせて伸縮する
    STRETCH = 0,
    -- アスペクト比を保ちつつ描画先の範囲に収まるように伸縮する
    FIT_INNER = 1,
    -- アスペクト比を保ちつつ描画先の範囲全体を覆うように伸縮する
    FIT_OUTER = 2,
    -- アスペクト比を保ちつつ描画先の範囲全体を覆うように伸縮する
    FIT_OUTER_TRIMMED = 3,
    -- アスペクト比を保ちつつ描画先の横幅に合わせて伸縮する
    FIT_WIDTH = 4,
    -- アスペクト比を保ちつつ描画先の横幅に合わせて伸縮する
    FIT_WIDTH_TRIMMED = 5,
    -- アスペクト比を保ちつつ描画先の縦幅に合わせて伸縮する
    FIT_HEIGHT = 6,
    -- アスペクト比を保ちつつ描画先の縦幅に合わせて伸縮する
    FIT_HEIGHT_TRIMMED = 7,
    -- 描画先に収まらない場合にはアスペクト比を保ちつつ縮小する
    NO_EXPANDING = 8,
    -- 伸縮しない（中央に合わせる）
    NO_RESIZE = 9,
    -- 伸縮しない（中央に合わせる）
    NO_RESIZE_TRIMMED = 10,
}
m.N_ZEROPADDING = {
    OFF = 0,
    ON = 1
}
m.JUDGEGRAPH = {
    -- グラフ区切り部分
    NOGAP = {
        -- 区切りあり
        OFF = 0,
        -- 区切りなし
        ON = 1
    },
    ORDERREVERSE = {
        -- 良いものを下に（イメージ）
        OFF = 0,
        -- 良いものを上に（イメージ）
        ON = 1
    },
    TYPE = {
        -- ノート構成グラフ
        NOTES = 0,
        -- 判定グラフ
        JUDGE = 1,
        -- FastSlowグラフ
        FASTSLOW = 2
    },
    BACKTEX = {
        -- 透過なし
        OFF = 0,
        -- 背景を透過
        ON = 1
    }
}
m.TIMINGDISTRIBUTIONGRAPH = {
    DRAW_AVERAGE = {
        OFF = 0,
        ON = 1
    },
    DRAW_DEV = {
        OFF = 0,
        ON = 1
    }
}
m.TIMINGVISUALIZER = {
    TRANSPARENT = {
        OFF = 0,
        ON = 1
    },
    DRAWDECAY = {
        OFF = 0,
        ON = 1
    }
}

m.OP = require("Root.mainoption")
m.NUM = require("Root.mainnumber")
m.TIMER = require("Root.maintimer")
m.STRING = require("Root.mainstring")
m.BUTTON = require("Root.mainbutton")
m.OFFSET = require("Root.mainoffset")
m.GRAPH = require("Root.maingraph")
m.SLIDER = require("Root.mainslider")
m.IMAGE = require("Root.mainimage")
return m
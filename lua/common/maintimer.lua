--[[
    メインタイマー
    @author KASAKO
]]

local m = {}

m.STARTINPUT = 1
m.FADEOUT = 2
m.FAILED = 3

m.SONGBAR_MOVE = 10
m.SONGBAR_CHANGE = 11
m.SONGBAR_MOVE_UP = 12
m.SONGBAR_MOVE_DOWN = 13
m.SONGBAR_STOP = 14
m.README_BEGIN = 15
m.README_END = 16

m.PANEL1_ON = 21
m.PANEL2_ON = 22
m.PANEL3_ON = 23
m.PANEL4_ON = 24
m.PANEL5_ON = 25
m.PANEL6_ON = 26
m.PANEL1_OFF = 31
m.PANEL2_OFF = 32
m.PANEL3_OFF = 33
m.PANEL4_OFF = 34
m.PANEL5_OFF = 35
m.PANEL6_OFF = 36

m.READY = 40
m.PLAY = 41
m.GAUGE_INCLEASE_1P = 42
m.GAUGE_INCLEASE_2P = 43
m.GAUGE_MAX_1P = 44
m.GAUGE_MAX_2P = 45
m.JUDGE_1P = 46
m.JUDGE_2P = 47
m.JUDGE_3P = 247
m.COMBO_1P = 446
m.COMBO_2P = 447
m.COMBO_3P = 448
m.FULLCOMBO_1P = 48
m.SCORE_A = 348
m.SCORE_AA = 349
m.SCORE_AAA = 350
m.SCORE_BEST = 351
m.SCORE_TARGET = 352
m.FULLCOMBO_2P = 49
m.BOMB_1P_SCRATCH = 50
m.BOMB_1P_KEY1 = 51
m.HCN_ACTIVE_1P_SCRATCH = 250
m.HCN_ACTIVE_1P_KEY1 = 251
m.BOMB_1P_KEY2 = 52
m.BOMB_1P_KEY3 = 53
m.BOMB_1P_KEY4 = 54
m.BOMB_1P_KEY5 = 55
m.BOMB_1P_KEY6 = 56
m.BOMB_1P_KEY7 = 57
m.BOMB_1P_KEY8 = 58
m.BOMB_1P_KEY9 = 59
m.BOMB_2P_SCRATCH = 60
m.BOMB_2P_KEY1 = 61
m.BOMB_2P_KEY2 = 62
m.BOMB_2P_KEY3 = 63
m.BOMB_2P_KEY4 = 64
m.BOMB_2P_KEY5 = 65
m.BOMB_2P_KEY6 = 66
m.BOMB_2P_KEY7 = 67
m.BOMB_2P_KEY8 = 68
m.BOMB_2P_KEY9 = 69
m.HOLD_1P_SCRATCH = 70
m.HOLD_1P_KEY1 = 71
m.HCN_DAMAGE_1P_SCRATCH = 270
m.HCN_DAMAGE_1P_KEY1 = 271
m.HOLD_2P_SCRATCH = 80
m.HOLD_2P_KEY1 = 81
m.KEYON_1P_SCRATCH = 100
m.KEYON_1P_KEY1 = 101
m.KEYON_1P_KEY2 = 102
m.KEYON_1P_KEY3 = 103
m.KEYON_1P_KEY4 = 104
m.KEYON_1P_KEY5 = 105
m.KEYON_1P_KEY6 = 106
m.KEYON_1P_KEY7 = 107
m.KEYON_1P_KEY8 = 108
m.KEYON_1P_KEY9 = 109
m.KEYON_2P_SCRATCH = 110
m.KEYON_2P_KEY1 = 111
m.KEYON_2P_KEY2 = 112
m.KEYON_2P_KEY3 = 113
m.KEYON_2P_KEY4 = 114
m.KEYON_2P_KEY5 = 115
m.KEYON_2P_KEY6 = 116
m.KEYON_2P_KEY7 = 117
m.KEYON_2P_KEY8 = 118
m.KEYON_2P_KEY9 = 119
m.KEYOFF_1P_SCRATCH = 120
m.KEYOFF_1P_KEY1 = 121
m.KEYOFF_1P_KEY2 = 122
m.KEYOFF_1P_KEY3 = 123
m.KEYOFF_1P_KEY4 = 124
m.KEYOFF_1P_KEY5 = 125
m.KEYOFF_1P_KEY6 = 126
m.KEYOFF_1P_KEY7 = 127
m.KEYOFF_1P_KEY8 = 128
m.KEYOFF_1P_KEY9 = 129
m.KEYOFF_2P_SCRATCH = 130
m.KEYOFF_2P_KEY1 = 131
m.KEYOFF_2P_KEY2 = 132
m.KEYOFF_2P_KEY3 = 133
m.KEYOFF_2P_KEY4 = 134
m.KEYOFF_2P_KEY5 = 135
m.KEYOFF_2P_KEY6 = 136
m.KEYOFF_2P_KEY7 = 137
m.KEYOFF_2P_KEY8 = 138
m.KEYOFF_2P_KEY9 = 139
m.RHYTHM = 140
m.ENDOFNOTE_1P = 143
m.ENDOFNOTE_2P = 144

m.RESULTGRAPH_BEGIN = 150
m.RESULTGRAPH_END = 151
m.RESULT_UPDATESCORE = 152

m.IR_CONNECT_BEGIN = 172
m.IR_CONNECT_SUCCESS = 173
m.IR_CONNECT_FAIL = 174

m.PM_CHARA_1P_NEUTRAL = 900
m.PM_CHARA_1P_FEVER = 901
m.PM_CHARA_1P_GREAT = 902
m.PM_CHARA_1P_GOOD = 903
m.PM_CHARA_1P_BAD = 904
m.PM_CHARA_2P_NEUTRAL = 905
m.PM_CHARA_2P_GREAT = 906
m.PM_CHARA_2P_BAD = 907
m.MUSIC_END = 908
-- FEVERWIN WIN LOSEはOPTION_1P_100とOPTION_1P_BORDER_OR_MOREを用いて分岐
m.PM_CHARA_DANCE = 909

m.BOMB_1P_KEY10 = 1010
m.BOMB_1P_KEY99 = 1099
m.BOMB_2P_KEY10 = 1110
m.BOMB_2P_KEY99 = 1199
m.HOLD_1P_KEY10 = 1210
m.HOLD_1P_KEY99 = 1299
m.HOLD_2P_KEY10 = 1310
m.HOLD_2P_KEY99 = 1399
m.KEYON_1P_KEY10 = 1410
m.KEYON_1P_KEY99 = 1499
m.KEYON_2P_KEY10 = 1510
m.KEYON_2P_KEY99 = 1599
m.KEYOFF_1P_KEY10 = 1610
m.KEYOFF_1P_KEY99 = 1699
m.KEYOFF_2P_KEY10 = 1710
m.KEYOFF_2P_KEY99 = 1799
m.HCN_ACTIVE_1P_KEY10 = 1810
m.HCN_ACTIVE_2P_KEY10 = 1910
m.HCN_DAMAGE_1P_KEY10 = 2010
m.HCN_DAMAGE_2P_KEY10 = 2110

m.MAX = 2999

return m
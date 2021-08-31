--[[
    ナンバー
    @author KASAKO
]]

local m = {}
m.HISPEED_LR2 = 10
m.HISPEED = 310
m.HISPEED_AFTERDOT = 311
m.DURATION = 312
m.DURATION_GREEN = 313
m.DURATION_LANECOVER_ON = 1312
m.DURATION_GREEN_LANECOVER_ON = 1313
m.DURATION_LANECOVER_OFF = 1314
m.DURATION_GREEN_LANECOVER_OFF = 1315
m.MAINBPM_DURATION_LANECOVER_ON = 1316
m.MAINBPM_DURATION_GREEN_LANECOVER_ON = 1317
m.MAINBPM_DURATION_LANECOVER_OFF = 1318
m.MAINBPM_DURATION_GREEN_LANECOVER_OFF = 1319
m.MINBPM_DURATION_LANECOVER_ON = 1320
m.MINBPM_DURATION_GREEN_LANECOVER_ON = 1321
m.MINBPM_DURATION_LANECOVER_OFF = 1322
m.MINBPM_DURATION_GREEN_LANECOVER_OFF = 1323
m.MAXBPM_DURATION_LANECOVER_ON = 1324
m.MAXBPM_DURATION_GREEN_LANECOVER_ON = 1325
m.MAXBPM_DURATION_LANECOVER_OFF = 1326
m.MAXBPM_DURATION_GREEN_LANECOVER_OFF = 1327
m.JUDGETIMING = 12
m.LANECOVER1 = 14
m.LIFT1 = 314
m.HIDDEN1 = 315

m.TOTALPLAYTIME_HOUR = 17
m.TOTALPLAYTIME_MINUTE = 18
m.TOTALPLAYTIME_SECOND = 19
m.CURRENT_FPS = 20
m.TIME_YEAR = 21
m.TIME_MONTH = 22
m.TIME_DAY = 23
m.TIME_HOUR = 24
m.TIME_MINUTE = 25
m.TIME_SECOND = 26
m.OPERATING_TIME_HOUR = 27
m.OPERATING_TIME_MINUTE = 28
m.OPERATING_TIME_SECOND = 29

m.TOTALPLAYCOUNT = 30
m.TOTALCLEARCOUNT = 31
m.TOTALFAILCOUNT = 32
m.TOTALPERFECT = 33
m.TOTALGREAT = 34
m.TOTALGOOD = 35
m.TOTALBAD = 36
m.TOTALPOOR = 37
m.TOTALPLAYNOTES = 333
m.FOLDER_BEGINNER = 45
m.FOLDER_NORMAL = 46
m.FOLDER_HYPER = 47
m.FOLDER_ANOTHER = 48
m.FOLDER_INSANE = 49
m.CLEAR = 370
m.TARGET_CLEAR = 371
m.AVERAGE_DURATION = 372
m.AVERAGE_DURATION_AFTERDOT = 373
m.AVERAGE_TIMING = 374
m.AVERAGE_TIMING_AFTERDOT = 375
m.STDDEV_TIMING = 376
m.STDDEV_TIMING_AFTERDOT = 377
m.SCORE = 71
m.MAXSCORE = 72
m.TOTALNOTES = 74
m.MAXCOMBO = 75
m.MISSCOUNT = 76
m.PLAYCOUNT = 77
m.CLEARCOUNT = 78
m.FAILCOUNT = 79
m.PERFECT2 = 80
m.GREAT2 = 81
m.GOOD2 = 82
m.BAD2 = 83
m.POOR2 = 84
m.PERFECT_RATE = 85
m.GREAT_RATE = 86
m.GOOD_RATE = 87
m.BAD_RATE = 88
m.POOR_RATE = 89
m.MAXBPM = 90
m.MINBPM = 91
m.MAINBPM = 92
m.PLAYLEVEL = 96
m.POINT = 100
m.SCORE2 = 101
m.SCORE_RATE = 102
m.SCORE_RATE_AFTERDOT = 103
m.COMBO = 104
m.MAXCOMBO2 = 105
m.TOTALNOTES2 = 106
m.GROOVEGAUGE = 107
m.GROOVEGAUGE_AFTERDOT = 407
m.DIFF_EXSCORE = 108
m.PERFECT = 110
m.EARLY_PERFECT = 410
m.LATE_PERFECT = 411
m.GREAT = 111
m.EARLY_GREAT = 412
m.LATE_GREAT = 413
m.GOOD = 112
m.EARLY_GOOD = 414
m.LATE_GOOD = 415
m.BAD = 113
m.EARLY_BAD = 416
m.LATE_BAD = 417
m.POOR = 114
m.EARLY_POOR = 418
m.LATE_POOR = 419
m.MISS = 420
m.EARLY_MISS = 421
m.LATE_MISS = 422
m.TOTALEARLY = 423
m.TOTALLATE = 424
m.COMBOBREAK = 425
m.POOR_PLUS_MISS = 426
m.BAD_PLUS_POOR_PLUS_MISS = 427
m.TOTAL_RATE = 115
m.TOTAL_RATE_AFTERDOT = 116
m.TARGET_SCORE = 121
m.TARGET_SCORE_RATE = 122
m.TARGET_SCORE_RATE_AFTERDOT = 123
m.DIFF_EXSCORE2 = 128
m.TARGET_TOTAL_RATE = 135
m.TARGET_TOTAL_RATE_AFTERDOT = 136

m.HIGHSCORE = 150
m.TARGET_SCORE2 = 151
m.DIFF_HIGHSCORE = 152
m.DIFF_TARGETSCORE = 153
m.DIFF_NEXTRANK = 154
m.SCORE_RATE2 = 155
m.SCORE_RATE_AFTERDOT2 = 156
m.TARGET_SCORE_RATE2 = 157
m.TARGET_SCORE_RATE_AFTERDOT2 = 158
m.NOWBPM = 160
m.PLAYTIME_MINUTE = 161
m.PLAYTIME_SECOND = 162
m.TIMELEFT_MINUTE = 163
m.TIMELEFT_SECOND = 164
m.SONGLENGTH_MINUTE = 1163
m.SONGLENGTH_SECOND = 1164
m.LOADING_PROGRESS = 165
m.HIGHSCORE2 = 170
m.SCORE3 = 171
m.DIFF_HIGHSCORE2 = 172
m.TARGET_MAXCOMBO = 173
m.MAXCOMBO3 = 174
m.DIFF_MAXCOMBO = 175
m.TARGET_MISSCOUNT = 176
m.MISSCOUNT2 = 177
m.DIFF_MISSCOUNT = 178
m.IR_RANK = 179
m.IR_TOTALPLAYER = 180
m.IR_CLEARRATE = 181
m.IR_PREVRANK = 182
m.BEST_RATE = 183
m.BEST_RATE_AFTERDOT = 184

m.RIVAL_SCORE = 271
m.RIVAL_MAXSCORE = 272
m.RIVAL_TOTALNOTES = 274
m.RIVAL_MAXCOMBO = 275
m.RIVAL_MISSCOUNT = 276
m.RIVAL_PLAYCOUNT = 277
m.RIVAL_CLEARCOUNT = 278
m.RIVAL_FAILCOUNT = 279
m.RIVAL_PERFECT = 280
m.RIVAL_GREAT = 281
m.RIVAL_GOOD = 282
m.RIVAL_BAD = 283
m.RIVAL_POOR = 284
m.RIVAL_PERFECT_RATE = 285
m.RIVAL_GREAT_RATE = 286
m.RIVAL_GOOD_RATE = 287
m.RIVAL_BAD_RATE = 288
m.RIVAL_POOR_RATE = 289

m.FOLDER_TOTALSONGS = 300

m.FOLDER_NOPLAY = 320
m.FOLDER_FAILED = 321
m.FOLDER_ASSIST = 322
m.FOLDER_LASSIST = 323
m.FOLDER_EASY = 324
m.FOLDER_GROOOVE = 325
m.FOLDER_HARD = 326
m.FOLDER_EXHARD = 327
m.FOLDER_FULLCOMBO = 328
m.FOLDER_PERFECT = 329
m.FOLDER_MAX = 330

m.TOTALNOTE_NORMAL = 350
m.TOTALNOTE_LN = 351
m.TOTALNOTE_SCRATCH = 352
m.TOTALNOTE_BSS = 353
m.TOTALNOTE_MINE = 354

m.DENSITY_ENDPEAK = 364
m.DENSITY_ENDPEAK_AFTERDOT = 365

m.SONGGAUGE_TOTAL = 368
return m
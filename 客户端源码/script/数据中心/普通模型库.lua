
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-02 16:34:40
--======================================================================--


function 引擎.取模型(ch,wq)
	local chs = {}
	local ch2 = ch
	if wq == nil or wq == "" then
		wq = "普通"
	end
	if ch == nil then
		return
	end
	if ch == "巫蛮儿" or ch == "杀破狼" or ch == "羽灵神" or ch == "逍遥生" or ch == "偃无师" or ch == "桃夭夭" or ch == "鬼潇潇" or ch == "影精灵"then
	   	s = "_"..wq
	else
	 	s = "_普通"
	end
	ch = ch..s
	if ch == "竹节双剑_飞燕女_普通" then
		chs[1] = 2478979274 --站立 8方向
		chs[2] = 683536595 ---移动 8方向
		chs[3] = "普通模型.wdf"

	elseif ch == "无极丝_玄彩娥_普通" then
		chs[1] = 1086469645
		chs[2] = 2643257844
		chs[3] = "普通模型.wdf"
	elseif ch == "羽灵神_法杖" then
		chs[1] = 2581796502
		chs[2] = 3940257408
		chs[3] = "普通模型.wdf"
	elseif ch == "狼牙锤_虎头怪_普通" then
		chs[1] = 900073506
		chs[2] = 556692511
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_药店老板_普通" then
		chs[1] = 3772542355
		chs[2] = 3278008898
		chs[3] = "普通模型.wdf"
	elseif ch == "腾云杖_巫蛮儿_普通" then
		chs[1] = 3237314719
		chs[2] = 1747492117
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_老伯_普通" then
		chs[1] = 1322524307
		chs[2] = 1037435576
		chs[3] = "普通模型.wdf"
	elseif ch == "文伯_普通" then
		chs[1] = 0x4ED41E93
		chs[2] = 0x4ED41E93
		chs[3] = "普通模型.wdf"
	elseif ch == "仓库保管员_普通" then
		chs[1] = 0x0BB9C549
		chs[2] = 0x703420B3
		chs[3] = "普通模型.wdf"
   	elseif ch == "罗百万_普通" then
		chs[1] = 0x165AEB4C
		chs[2] = 0x703420B3
		chs[3] = "普通模型.wdf"
   	elseif ch == "摇钱树_普通" then
		chs[1] = 0x56FFF012
		chs[2] = 0x56FFF012
		chs[3] = "普通模型.wdf"
  	 elseif ch == "银子_普通" then
		chs[1] = 0xC880FF79
		chs[2] = 0xC880FF79
		chs[3] = "普通模型.wdf"
   	elseif ch == "摇钱树苗_普通" then
		chs[1] = 0x4A2078C9
		chs[2] = 0x4A2078C9
		chs[3] = "普通模型.wdf"
   	elseif ch == "校尉_普通" then
		chs[1] = 0x589A2894
		chs[2] = 0x7ECE7DB2
		chs[3] = "普通模型.wdf"
   elseif ch == "太白金星_普通" then
		chs[1] = 0xCA3334FF
		chs[2] = 0x5745E837
		chs[3] = "普通模型.wdf"
    elseif ch == "马猴_普通" then
		chs[1] = 0xBDD0DC76
		chs[2] = 0xBDD0DC76
		chs[3] = "普通模型.wdf"
    elseif ch == "袁天罡_普通" then
		chs[1] = 0x41B1D8EC
		chs[2] = 0x41B1D8EC
		chs[3] = "普通模型.wdf"
     elseif ch == "南极仙翁_普通" then
		chs[1] = 0xB4DA85C7
		chs[2] = 0xB4DA85C7
		chs[3] = "普通模型.wdf"
    elseif ch == "少女_普通" then
		chs[1] = 0x1BB1AF36
		chs[2] = 0xA69EAB9D
		chs[3] = "普通模型.wdf"
    elseif ch == "陈妈妈_普通" then
		chs[1] = 0xFF25D8BA
		chs[2] = 0x879921C3
		chs[3] = "普通模型.wdf"
    elseif ch == "珍品商人_普通" then
		chs[1] = 0xD7A74DE2
		chs[2] = 0xF846C711
		chs[3] = "普通模型.wdf"
	elseif jp == "奸商_普通" then
		jps[1] = 0x0BB9C549
		jps[2] = 0x0BB9C549
		jps[3] = "普通模型.wdf"
	elseif ch == "逍遥生_剑" then
		chs[1] = 1492865095
		chs[2] = 304945535
		chs[3] = "普通模型.wdf"
	elseif ch == "逍遥生_普通" then
		chs[1] = 1492865095
		chs[2] = 304945535
		chs[3] = "普通模型.wdf"
	elseif ch == "逍遥生_扇" then
		chs[1] = 0x22CED97B
		chs[2] = 304945535
		chs[3] = "普通模型.wdf"
	elseif ch == "柳叶刀_剑侠客_普通" then
		chs[1] = 1229743190
		chs[2] = 194354478
		chs[3] = "普通模型.wdf"
	elseif ch == "游龙剑_剑侠客_普通" then
		chs[1] = 4239696014
		chs[2] = 1495300408
		chs[3] = "普通模型.wdf"
	elseif ch == "物件_缝纫台_普通" then
		chs[1] = 837447295
		chs[2] = 837447295
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_师爷_普通" then
		chs[1] = 1066523733
		chs[2] = 1377566628
		chs[3] = "普通模型.wdf"
	elseif ch == "青铜短剑_逍遥生_普通" then
		chs[1] = 614590386
		chs[2] = 2214774214
		chs[3] = "普通模型.wdf"
	elseif ch == "飞燕女_普通" then
		chs[1] = 2708080383
		chs[2] = 1337608376
		chs[3] = "普通模型.wdf"
	elseif ch == "七彩罗刹_玄彩娥_普通" then
		chs[1] = 2992307123
		chs[2] = 3171287220
		chs[3] = "普通模型.wdf"
	elseif ch == "神火扇_龙太子_普通" then
		chs[1] = 3998986408
		chs[2] = 207256533
		chs[3] = "普通模型.wdf"
	elseif ch == "青铜斧_虎头怪_普通" then
		chs[1] = 1495520707
		chs[2] = 1952969514
		chs[3] = "普通模型.wdf"
	elseif ch == "青龙牙_骨精灵_普通" then
		chs[1] = 819272546
		chs[2] = 4143052600
		chs[3] = "普通模型.wdf"
	elseif ch == "如意宝珠_杀破狼_普通" then
		chs[1] = 3027466503
		chs[2] = 3046998488
		chs[3] = "普通模型.wdf"
	elseif ch == "二郎神_普通" then
		chs[1] = 526337028
		chs[2] = 4168999919
		chs[3] = "普通模型.wdf"
	elseif ch == "二郎神_坐_普通" then
		chs[1] = 0xCF6966D6
		chs[2] = 4168999919
		chs[3] = "普通模型.wdf"
	elseif ch == "程咬金_普通" then
		chs[1] = 3785433343
		chs[2] = 1492432483
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖鸡_普通" then
		chs[1] = 3432834403
		chs[2] = 2637511668
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖龙_普通" then
		chs[1] = 2144981948
		chs[2] = 681342781
		chs[3] = "普通模型.wdf"
	elseif ch == "宝石商人_普通" then
		chs[1] = 0xDA498AD2
		chs[2] = 0xBB95D714
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_苦力_普通" then
		chs[1] = 446699857
		chs[2] = 1576680377
		chs[3] = "普通模型.wdf"
	elseif ch == "翡翠珠_巫蛮儿_普通" then
		chs[1] = 1191800816
		chs[2] = 1331598936
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_老书生_普通" then
		chs[1] = 2910460883
		chs[2] = 3140407182
		chs[3] = "普通模型.wdf"
	elseif ch == "点金棒_骨精灵_普通" then
		chs[1] = 2615197180
		chs[2] = 3429205695
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖蛇_普通" then
		chs[1] = 2969016345
		chs[2] = 2148157529
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖猴_普通" then
		chs[1] = 2861633535
		chs[2] = 1375492904
		chs[3] = "普通模型.wdf"
	elseif ch == "鸣鸿_巨魔王_普通" then
		chs[1] = 2272535883
		chs[2] = 4183963940
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_赵姨娘_普通" then
		chs[1] = 3648925936
		chs[2] = 4130858842
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_王大嫂_普通" then
		chs[1] = 740448683
		chs[2] = 2955218414
		chs[3] = "普通模型.wdf"
	elseif ch == "牛皮鞭_英女侠_普通" then
		chs[1] = 2721039077
		chs[2] = 4092691055
		chs[3] = "普通模型.wdf"
	elseif ch == "钢结鞭_狐美人_普通" then
		chs[1] = 1358766658
		chs[2] = 219014606
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_万圣公主_普通" then
		chs[1] = 3358028002
		chs[2] = 822208599
		chs[3] = "普通模型.wdf"
	elseif ch == "折扇_逍遥生_普通" then
		chs[1] = 2120322561
		chs[2] = 4052148846
		chs[3] = "普通模型.wdf"
	elseif ch == "神树_普通" then
		chs[1] = 0xC4953810
		chs[2] = 0xC4953810
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖马_普通" then
		chs[1] = 2144882665
		chs[2] = 1301159692
		chs[3] = "普通模型.wdf"
	elseif ch == "裂天_虎头怪_普通" then
		chs[1] = 161677133
		chs[2] = 2342305231
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_老孙头_普通" then
		chs[1] = 3603513852
		chs[2] = 546575178
		chs[3] = "普通模型.wdf"
	elseif ch == "青刚刺_狐美人_普通" then
		chs[1] = 943875548
		chs[2] = 2075432907
		chs[3] = "普通模型.wdf"
	elseif ch == "金背大砍刀_剑侠客_普通" then
		chs[1] = 3102182178
		chs[2] = 1238352835
		chs[3] = "普通模型.wdf"
	elseif ch == "腾云杖_羽灵神_普通" then
		chs[1] = 1584570480
		chs[2] = 1046023851
		chs[3] = "普通模型.wdf"
	elseif ch == "龙太子_普通" then
		chs[1] = 2944637360
		chs[2] = 4098637790
		chs[3] = "普通模型.wdf"
	elseif ch == "小孩_飞儿_普通" then
		chs[1] = 1968548048
		chs[2] = 1147692687
		chs[3] = "普通模型.wdf"
	elseif ch == "弑皇_龙太子_普通" then
		chs[1] = 2305995091
		chs[2] = 1956552460
		chs[3] = "普通模型.wdf"
	elseif ch == "双弦钺_巨魔王_普通" then
		chs[1] = 4111880178
		chs[2] = 2679811341
		chs[3] = "普通模型.wdf"
	elseif ch == "擒龙_剑侠客_普通" then
		chs[1] = 3544836379
		chs[2] = 1980184881
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_店小二_普通" then
		chs[1] = 2405317089
		chs[2] = 3709933830
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖狗_普通" then
		chs[1] = 4095696952
		chs[2] = 3730360943
		chs[3] = "普通模型.wdf"
	elseif ch == "狼牙锤_神天兵_普通" then
		chs[1] = 952314130
		chs[2] = 1577638509
		chs[3] = "普通模型.wdf"
	elseif ch == "红缨枪_神天兵_普通" then
		chs[1] = 3564813918
		chs[2] = 2236546380
		chs[3] = "普通模型.wdf"
	elseif ch == "青锋剑_逍遥生_普通" then
		chs[1] = 540655754
		chs[2] = 526326278
		chs[3] = "普通模型.wdf"
	elseif ch == "哮天犬_普通" then
		chs[1] = 154473363
		chs[2] = 2317895520
		chs[3] = "普通模型.wdf"
	elseif ch == "如意宝珠_巫蛮儿_普通" then
		chs[1] = 2417421936
		chs[2] = 2197534441
		chs[3] = "普通模型.wdf"
	elseif ch == "空度禅师_普通" then
		chs[1] = 3073716657
		chs[2] = 116026999
		chs[3] = "普通模型.wdf"
	elseif ch == "翡翠珠_杀破狼_普通" then
		chs[1] = 1314894172
		chs[2] = 433513441
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_丫鬟_普通" then
		chs[1] = 464629558
		chs[2] = 2795416477
		chs[3] = "普通模型.wdf"
	elseif ch == "东海龙王_普通" then
		chs[1] = 2165191785
		chs[2] = 2004123762
		chs[3] = "普通模型.wdf"
	elseif ch == "狐美人_普通" then
		chs[1] = 3753105193
		chs[2] = 3988533543
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖虎_普通" then
		chs[1] = 1507261243
		chs[2] = 3621557214
		chs[3] = "普通模型.wdf"
	elseif ch == "满天星_骨精灵_普通" then
		chs[1] = 412146092
		chs[2] = 59782698
		chs[3] = "普通模型.wdf"
	elseif ch == "骨精灵_普通" then
		chs[1] = 812821174
		chs[2] = 493656179
		chs[3] = "普通模型.wdf"






	elseif ch == "琉璃珠_巫蛮儿_普通" then
		chs[1] = 4171731900
		chs[2] = 143410001
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_兰虎_普通" then
		chs[1] = 116514429
		chs[2] = 934142410
		chs[3] = "普通模型.wdf"
	elseif ch == "帮派机关人_普通" then
		chs[1] = 0x48EFADFA
		chs[2] = 0x48EFADFA
		chs[3] = "普通模型.wdf"
	elseif ch == "小孩_雷黑子_普通" then
		chs[1] = 3707150672
		chs[2] = 2084261815
		chs[3] = "普通模型.wdf"
	elseif ch == "硬木弓_杀破狼_普通" then
		chs[1] = 2500153518
		chs[2] = 34690017
		chs[3] = "普通模型.wdf"
	elseif ch == "宝雕长弓_杀破狼_普通" then
		chs[1] = 3168212514
		chs[2] = 1524411866
		chs[3] = "普通模型.wdf"
	elseif ch == "玄铁矛_龙太子_普通" then
		chs[1] = 2397764102
		chs[2] = 2300479837
		chs[3] = "普通模型.wdf"
	elseif ch == "巨魔王_普通" then
		chs[1] = 2213567130
		chs[2] = 1051618199
		chs[3] = "普通模型.wdf"
	elseif ch == "青藤柳叶鞭_狐美人_普通" then
		chs[1] = 2017171936
		chs[2] = 1015863531
		chs[3] = "普通模型.wdf"
	elseif ch == "宝雕长弓_羽灵神_普通" then
		chs[1] = 487656505
		chs[2] = 162322797
		chs[3] = "普通模型.wdf"
	elseif ch == "连珠神弓_羽灵神_普通" then
		chs[1] = 3702678012
		chs[2] = 2163189324
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_钓鱼_普通" then
		chs[1] = 1987089858
		chs[2] = 932361715
		chs[3] = "普通模型.wdf"
	elseif ch == "硬木弓_羽灵神_普通" then
		chs[1] = 3985633058
		chs[2] = 2192045984
		chs[3] = "普通模型.wdf"
	elseif ch == "物件_打铁炉_普通" then
		chs[1] = 2074974822
		chs[2] = 2074974822
		chs[3] = "普通模型.wdf"
	elseif ch == "震天锤_神天兵_普通" then
		chs[1] = 3106536422
		chs[2] = 4262815425
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_巫医_普通" then
		chs[1] = 974580077
		chs[2] = 3706440168
		chs[3] = "普通模型.wdf"
	elseif ch == "墨铁拐_巫蛮儿_普通" then
		chs[1] = 2710601924
		chs[2] = 495554266
		chs[3] = "普通模型.wdf"
	elseif ch == "曲柳杖_巫蛮儿_普通" then
		chs[1] = 438684246
		chs[2] = 2418364461
		chs[3] = "普通模型.wdf"
	elseif ch == "狼牙刀_巨魔王_普通" then
		chs[1] = 1185865684
		chs[2] = 2820957694
		chs[3] = "普通模型.wdf"
	elseif ch == "赤明_杀破狼_宝珠_普通" then
		chs[1] = 3482219011
		chs[2] = 3906907508
		chs[3] = "普通模型.wdf"
	elseif ch == "细木棒_骨精灵_普通" then
		chs[1] = 1202797055
		chs[2] = 4178020883
		chs[3] = "普通模型.wdf"
	elseif ch == "星瀚_逍遥生_普通" then
		chs[1] = 791015559
		chs[2] = 3682713078
		chs[3] = "普通模型.wdf"
	elseif ch == "柳叶刀_巨魔王_普通" then
		chs[1] = 4115620300
		chs[2] = 3330022961
		chs[3] = "普通模型.wdf"
	elseif ch == "蛇形月_舞天姬_普通" then
		chs[1] = 1644759402
		chs[2] = 1759014159
		chs[3] = "普通模型.wdf"
	elseif ch == "蛇形月_飞燕女_普通" then
		chs[1] = 3586173418
		chs[2] = 732948875
		chs[3] = "普通模型.wdf"
	elseif ch == "金刺轮_舞天姬_普通" then
		chs[1] = 2807451206
		chs[2] = 138314297
		chs[3] = "普通模型.wdf"
	elseif ch == "墨铁拐_羽灵神_普通" then
		chs[1] = 2848235637
		chs[2] = 2266600687
		chs[3] = "普通模型.wdf"
	elseif ch == "黄铜圈_舞天姬_普通" then
		chs[1] = 194575710
		chs[2] = 2421095781
		chs[3] = "普通模型.wdf"
	elseif ch == "杀破狼_宝珠" then
		chs[1] = 2930414626
		chs[2] = 4291811931
		chs[3] = "普通模型.wdf"
	elseif ch == "杀破狼_普通" then
		chs[1] = 652210495
		chs[2] = 1032044905
		chs[3] = "普通模型.wdf"
	elseif ch == "杀破狼_弓弩" then
		chs[1] = 0652210495
		chs[2] = 1032044905
		chs[3] = "普通模型.wdf"
	elseif ch == "杀破狼_弓弩1" then
		chs[1] = 0652210495
		chs[2] = 4291811931
		chs[3] = "普通模型.wdf"
	elseif ch == "玄彩娥_普通" then
		chs[1] = 1362263605
		chs[2] = 3715462681
		chs[3] = "普通模型.wdf"
	elseif ch == "黄铜圈_飞燕女_普通" then
		chs[1] = 737601414
		chs[2] = 1669143734
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_镖头_普通" then
		chs[1] = 3492453301
		chs[2] = 1292545852
		chs[3] = "普通模型.wdf"
	elseif ch == "双短剑_英女侠_普通" then
		chs[1] = 2246741733
		chs[2] = 2201236800
		chs[3] = "普通模型.wdf"
	elseif ch == "青藤柳叶鞭_英女侠_普通" then
		chs[1] = 3009625218
		chs[2] = 2830037944
		chs[3] = "普通模型.wdf"
	elseif ch == "钢结鞭_英女侠_普通" then
		chs[1] = 1003144235
		chs[2] = 1524918418
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_打铁_普通" then
		chs[1] = 120900042
		chs[2] = 3034289392
		chs[3] = "普通模型.wdf"
	elseif ch == "羽灵神_弓弩" then
		chs[1] = 2581796502
		chs[2] = 1858805344
		chs[3] = "普通模型.wdf"
	elseif ch == "羽灵神_弓弩1" then
		chs[1] = 0262638661
		chs[2] = 3940257408
		chs[3] = "普通模型.wdf"
	elseif ch == "震天锤_虎头怪_普通" then
		chs[1] = 676548466
		chs[2] = 1816923096
		chs[3] = "普通模型.wdf"
	elseif ch == "剑侠客_普通" then
		chs[1] = 1228435406
		chs[2] = 1425276052
		chs[3] = "普通模型.wdf"
	elseif ch == "金刺轮_飞燕女_普通" then
		chs[1] = 860305472
		chs[2] = 4154736570
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_财主_普通" then
		chs[1] = 3662252754
		chs[2] = 3147159316
		chs[3] = "普通模型.wdf"
	elseif ch == "狼牙刀_剑侠客_普通" then
		chs[1] = 213847515
		chs[2] = 3147078622
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_村长_普通" then
		chs[1] = 4248935980
		chs[2] = 4088599810
		chs[3] = "普通模型.wdf"
	elseif ch == "青龙牙_狐美人_普通" then
		chs[1] = 3750219087
		chs[2] = 346973613
		chs[3] = "普通模型.wdf"
	elseif ch == "赤焰双剑_英女侠_普通" then
		chs[1] = 1427570181
		chs[2] = 3478724046
		chs[3] = "普通模型.wdf"
	elseif ch == "满天星_玄彩娥_普通" then
		chs[1] = 1121013667
		chs[2] = 291147333
		chs[3] = "普通模型.wdf"
	elseif ch == "点金棒_玄彩娥_普通" then
		chs[1] = 1581306371
		chs[2] = 1230293004
		chs[3] = "普通模型.wdf"
	elseif ch == "金背大砍刀_巨魔王_普通" then
		chs[1] = 2395375353
		chs[2] = 3599969440
		chs[3] = "普通模型.wdf"
	elseif ch == "巫蛮儿_宝珠" then
		chs[1] = 202554088
		chs[2] = 255156094
		chs[3] = "普通模型.wdf"
	elseif ch == "神火扇_逍遥生_普通" then
		chs[1] = 1076608023
		chs[2] = 2463492889
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_程夫人_普通" then
		chs[1] = 2938169672
		chs[2] = 2750714270
		chs[3] = "普通模型.wdf"
	elseif ch == "铁面扇_龙太子_普通" then
		chs[1] = 506375536
		chs[2] = 4142026495
		chs[3] = "普通模型.wdf"
	elseif ch == "英女侠_普通" then
		chs[1] = 2898894124
		chs[2] = 3708489082
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_驿站老板_普通" then
		chs[1] = 1928246157
		chs[2] = 1869355644
		chs[3] = "普通模型.wdf"
	elseif ch == "折扇_龙太子_普通" then
		chs[1] = 506375536
		chs[2] = 4142026495
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_小白龙_普通" then
		chs[1] = 3428945982
		chs[2] = 702338287
		chs[3] = "普通模型.wdf"
	elseif ch == "青刚刺_骨精灵_普通" then
		chs[1] = 4186507615
		chs[2] = 2094848573
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_道士_普通" then
		chs[1] = 3078659296
		chs[2] = 362597535
		chs[3] = "普通模型.wdf"
	elseif ch == "松木锤_神天兵_普通" then
		chs[1] = 385167718
		chs[2] = 887944587
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_钟馗_普通" then
		chs[1] = 4058540435
		chs[2] = 966910991
		chs[3] = "普通模型.wdf"
	elseif ch == "巫蛮儿_法杖" then
		chs[1] = 202554088
		chs[2] = 4185651500
		chs[3] = "普通模型.wdf"
	elseif ch == "铁爪_骨精灵_普通" then
		chs[1] = 980144775
		chs[2] = 630615359
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_衙役_普通" then
		chs[1] = 1085390019
		chs[2] = 2328269737
		chs[3] = "普通模型.wdf"
	elseif ch == "铁爪_狐美人_普通" then
		chs[1] = 3977087148
		chs[2] = 1562072464
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖兔_普通" then
		chs[1] = 2644091149
		chs[2] = 1380884632
		chs[3] = "普通模型.wdf"
	elseif ch == "七彩罗刹_舞天姬_普通" then
		chs[1] = 903786802
		chs[2] = 2633357816
		chs[3] = "普通模型.wdf"
	elseif ch == "无极丝_舞天姬_普通" then
		chs[1] = 4219745722
		chs[2] = 3471825039
		chs[3] = "普通模型.wdf"
	elseif ch == "五色缎带_玄彩娥_普通" then
		chs[1] = 3852826693
		chs[2] = 1284868321
		chs[3] = "普通模型.wdf"
	elseif ch == "五色缎带_舞天姬_普通" then
	    chs[1] = 4201646940
		chs[2] = 2449560215
		chs[3] = "普通模型.wdf"
	elseif ch == "羽灵神_普通" then
		chs[1] = 2581796502
		chs[2] = 1858805344
		chs[3] = "普通模型.wdf"
	elseif ch == "琉璃珠_杀破狼_普通" then
		chs[1] = 2754911857
		chs[2] = 2888668416
		chs[3] = "普通模型.wdf"
	elseif ch == "竹节双剑_英女侠_普通" then
		chs[1] = 1476049499
		chs[2] = 2441717360
		chs[3] = "普通模型.wdf"
	elseif ch == "双短剑_飞燕女_普通" then
		chs[1] = 932337963
		chs[2] = 1862513649
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_胖和尚_普通" then
		chs[1] = 3834802119
		chs[2] = 3160835837
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖牛_普通" then
		chs[1] = 1715773510
		chs[2] = 889866680
		chs[3] = "普通模型.wdf"
	elseif ch == "连珠神弓_杀破狼_普通" then
		chs[1] = 824051161
		chs[2] = 3255758268
		chs[3] = "普通模型.wdf"
	elseif ch == "青铜短剑_剑侠客_普通" then
		chs[1] = 3428752505
		chs[2] = 696309892
		chs[3] = "普通模型.wdf"
	elseif ch == "乌金三叉戟_龙太子_普通" then
		chs[1] = 1709314112
		chs[2] = 50056701
		chs[3] = "普通模型.wdf"
	elseif ch == "青锋剑_剑侠客_普通" then
		chs[1] = 2459468380
		chs[2] = 702488915
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_赵姨娘_普通" then
		chs[1] = 3648925936
		chs[2] = 4130858842
		chs[3] = "普通模型.wdf"
	elseif ch == "双弦钺_虎头怪_普通" then
		chs[1] = 1464696308
		chs[2] = 1468494251
		chs[3] = "普通模型.wdf"
	elseif ch == "玄铁矛_神天兵_普通" then
		chs[1] = 491583081
		chs[2] = 2008609870
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_染色师_普通" then
		chs[1] = 3618065890
		chs[2] = 4165388049
		chs[3] = "普通模型.wdf"
	elseif ch == "乌金三叉戟_神天兵_普通" then
		chs[1] = 733304931
		chs[2] = 235606285
		chs[3] = "普通模型.wdf"
	elseif ch == "乌金鬼头镰_巨魔王_普通" then
		chs[1] = 1147867834
		chs[2] = 3049186137
		chs[3] = "普通模型.wdf"
	elseif ch == "红缨枪_龙太子_普通" then
		chs[1] = 2274614746
		chs[2] = 1825813896
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖猪_普通" then
		chs[1] = 1620533879
		chs[2] = 529730008
		chs[3] = "普通模型.wdf"
	elseif ch == "浮犀_飞燕女_普通" then
		chs[1] = 3366765078
		chs[2] = 3831481111
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖羊_普通" then
		chs[1] = 3736848475
		chs[2] = 142369761
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_将军_普通" then
		chs[1] = 905298755
		chs[2] = 42701270
		chs[3] = "普通模型.wdf"
	elseif ch == "武器_男人_将军_普通" then
		chs[1] = 0xD67AC350
		chs[2] = 0x61332E9A
		chs[3] = "普通模型.wdf"
	elseif ch == "武器_进阶凤凰_普通" then
		chs[1] = 0x519D5917
		chs[2] = 0xFE804156
		chs[3] = "普通模型.wdf"
	elseif ch =="武器_迭代鬼将_普通" or  ch =="武器_进阶迭代鬼将_普通" then
		chs[1] = 0x00005178
		chs[2] = 0x00005184
		chs[3] ="anhebb.wdf"
    elseif ch =="武器_青花瓷鬼将_普通" then
		chs[1] = 0x00000072
		chs[2] = 0x00000072
		chs[3] ="靓号.wdf"
	elseif ch =="武器_迭代金刚_普通" or  ch =="武器_进阶迭代金刚_普通" then
		chs[1] = 0x00000341
		chs[2] = 0x00000346
		chs[3] ="anhebb.wdf"
	elseif ch == "牛皮鞭_狐美人_普通" then
		chs[1] = 476936950
		chs[2] = 387504165
		chs[3] = "普通模型.wdf"
	elseif ch == "青铜斧_巨魔王_普通" then
		chs[1] = 550609107
		chs[2] = 1015351627
		chs[3] = "普通模型.wdf"
	elseif ch == "GM_普通" then
		chs[1] = 1196102199
		chs[2] = 3275427641
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_酒店老板_普通" then
		chs[1] = 2273562498
		chs[2] = 2938341026
		chs[3] = "普通模型.wdf"
	elseif ch == "细木棒_玄彩娥_普通" then
		chs[1] = 534278293
		chs[2] = 4175187443
		chs[3] = "普通模型.wdf"
	elseif ch == "菩提老祖_普通" then
		chs[1] = 2022476
		chs[2] = 2045279
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_老财_普通" then
		chs[1] = 2851575530
		chs[2] = 4130858842
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_书生_普通" then
		chs[1] = 2927756557
		chs[2] = 2377172812
		chs[3] = "普通模型.wdf"
	elseif ch == "白无常_普通" then
		chs[1] = 0x67B85348
		chs[2] = 0x67B85348
		chs[3] = "普通模型.wdf"
   	elseif ch == "黑无常_普通" then
		chs[1] = 0xF250443E
		chs[2] = 0xF250443E
		chs[3] = "普通模型.wdf"
	elseif ch == "神天兵_普通" then
		chs[1] = 2115558165
		chs[2] = 1433167185
		chs[3] = "普通模型.wdf"
	elseif ch == "松木锤_虎头怪_普通" then
		chs[1] = 1728983487
		chs[2] = 2655200756
		chs[3] = "普通模型.wdf"
	elseif ch == "普陀_接引仙女_普通" then
		chs[1] = 2006103770
		chs[2] = 3675375637
		chs[3] = "普通模型.wdf"
	elseif ch == "曲柳杖_羽灵神_普通" then
		chs[1] = 1868152845
		chs[2] = 460325915
		chs[3] = "普通模型.wdf"
	elseif ch == "舞天姬_普通" then
		chs[1] = 0x326C8C14
		chs[2] = 0x122CC513
		chs[3] = "普通模型.wdf"
	elseif ch == "铁面扇_逍遥生_普通" then
		chs[1] = 696084557
		chs[2] = 2358358928
		chs[3] = "普通模型.wdf"
	elseif ch == "赤焰双剑_飞燕女_普通" then
		chs[1] = 4061318075
		chs[2] = 2660522564
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_服装店老板_普通" then
		chs[1] = 783558512
		chs[2] = 1281544799
		chs[3] = "普通模型.wdf"
	elseif ch == "游龙剑_逍遥生_普通" then
		chs[1] = 1313817198
		chs[2] = 3892924667
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_方丈_普通" then
		chs[1] = 569041301
		chs[2] = 2786499860
		chs[3] = "普通模型.wdf"
	elseif ch == "巫蛮儿_普通" then
		chs[1] = 0x0C12BAE8
		chs[2] = 4185651500
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_特产商人_普通" then
		chs[1] = 1692779847
		chs[2] = 3191205382
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_铁匠_普通" then
		chs[1] = 120900042
		chs[2] = 3034289392
		chs[3] = "普通模型.wdf"
	elseif ch == "乌金鬼头镰_虎头怪_普通" then
		chs[1] = 3940375773
		chs[2] = 3876300955
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_武器店老板_普通" then
		chs[1] = 1931741111
		chs[2] = 1149246646
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_土地_普通" then
		chs[1] = 2173263235
		chs[2] = 1853905913
		chs[3] = "普通模型.wdf"
	elseif ch == "生肖鼠_普通" then
		chs[1] = 3670560660
		chs[2] = 957963203
		chs[3] = "普通模型.wdf"
	elseif ch == "虎头怪_普通" then
		chs[1] = 571142035
		chs[2] = 803245291
		chs[3] = "普通模型.wdf"
	elseif ch == "暗夜_龙太子_普通" then
		chs[1] = 0906768777
		chs[2] = 0402972999
		chs[3] = "普通模型.wdf"
	elseif ch == "暗夜_神天兵_普通" then
		chs[1] = 3587304792
		chs[2] = 3537373418
		chs[3] = "普通模型.wdf"
	elseif ch == "梨花_龙太子_普通" then
		chs[1] = 3562006868
		chs[2] = 0563824081
		chs[3] = "普通模型.wdf"
	elseif ch == "梨花_神天兵_普通" then
		chs[1] = 3155530506
		chs[2] = 4149381636
		chs[3] = "普通模型.wdf"
	elseif ch == "霹雳_龙太子_普通" then
		chs[1] = 0663241555
		chs[2] = 0882577208
		chs[3] = "普通模型.wdf"
	elseif ch == "霹雳_神天兵_普通" then
		chs[1] = 3690872798
		chs[2] = 3942970730
		chs[3] = "普通模型.wdf"
	elseif ch == "刑天之逆_龙太子_普通" then
		chs[1] = 0x31CA69F0
		chs[2] = 0x898AF13F
		chs[3] = "普通模型.wdf"
	elseif ch == "五虎断魂_龙太子_普通" then
		chs[1] = 0x929158FC
		chs[2] = 0xC2E1216A
		chs[3] = "普通模型.wdf"
	elseif ch == "飞龙在天_龙太子_普通" then
		chs[1] = 0x15E284F9
		chs[2] = 0x0A73B2E0
		chs[3] = "普通模型.wdf"
	elseif ch == "天龙破城_龙太子_普通" then
		chs[1] = 1524391868
		chs[2] = 3805099760
		chs[3] = "普通模型.wdf"
	elseif ch == "刑天之逆_神天兵_普通" then
		chs[1] = 0xDBFE3FDE
		chs[2] = 0xEB04F56A
		chs[3] = "普通模型.wdf"
	elseif ch == "五虎断魂_神天兵_普通" then
		chs[1] = 0xEF75190E
		chs[2] = 0x7A0C3835
		chs[3] = "普通模型.wdf"
	elseif ch == "飞龙在天_神天兵_普通" then
		chs[1] = 0x37F26C44
		chs[2] = 0xD751042A
		chs[3] = "普通模型.wdf"
	elseif ch == "天龙破城_神天兵_普通" then
		chs[1] = 3154146622
		chs[2] = 2015118453
		chs[3] = "普通模型.wdf"
	elseif ch == "弑皇_神天兵_普通" then
		chs[1] = 1837680668
		chs[2] = 0689112756
		chs[3] = "普通模型.wdf"
	elseif ch == "破魄_虎头怪_普通" then
		chs[1] = 0x53F914DE
		chs[2] = 0x8102D783
		chs[3] = "普通模型.wdf"
	elseif ch == "破魄_巨魔王_普通" then
		chs[1] = 0x02CECBCB
		chs[2] = 0xB8554947
		chs[3] = "普通模型.wdf"
	elseif ch == "肃魂_虎头怪_普通" then
		chs[1] = 0xE8866C8F
		chs[2] = 0x16B86A5E
		chs[3] = "普通模型.wdf"
	elseif ch == "肃魂_巨魔王_普通" then
		chs[1] = 0x726F7762
		chs[2] = 0x199CF19E
		chs[3] = "普通模型.wdf"
	elseif ch == "无敌_虎头怪_普通" then
		chs[1] = 0xD88565BC
		chs[2] = 0x375756CE
		chs[3] = "普通模型.wdf"
	elseif ch == "无敌_巨魔王_普通" then
		chs[1] = 0x6AE68E94
		chs[2] = 0x29FE3B3E
		chs[3] = "普通模型.wdf"
	elseif ch == "五丁开山_巨魔王_普通" then
		chs[1] = 0xDDE32A30
		chs[2] = 0x7D02D5DB
		chs[3] = "普通模型.wdf"
	elseif ch == "元神禁锢_巨魔王_普通" then
		chs[1] = 0x6693BB73
		chs[2] = 0x4E32D0BC
		chs[3] = "普通模型.wdf"
	elseif ch == "护法灭魔_巨魔王_普通" then
		chs[1] = 0x75E45C94
		chs[2] = 0xDA6126C5
		chs[3] = "普通模型.wdf"
	elseif ch == "碧血干戚_巨魔王_普通" then
		chs[1] = 1651186704
		chs[2] = 1048057784
		chs[3] = "普通模型.wdf"
	elseif ch == "裂天_巨魔王_普通" then
		chs[1] = 3160261512
		chs[2] = 0098835428
		chs[3] = "普通模型.wdf"
	elseif ch == "五丁开山_虎头怪_普通" then
		chs[1] = 0x2261BF73
		chs[2] = 0xB02E0452
		chs[3] = "普通模型.wdf"
	elseif ch == "元神禁锢_虎头怪_普通" then
		chs[1] = 0xFC8BAA37
		chs[2] = 0xC133DEC4
		chs[3] = "普通模型.wdf"
	elseif ch == "护法灭魔_虎头怪_普通" then
		chs[1] = 0x0F200DE2
		chs[2] = 0xEE971A2F
		chs[3] = "普通模型.wdf"
	elseif ch == "碧血干戚_虎头怪_普通" then
		chs[1] = 2740822575
		chs[2] = 1846382457
		chs[3] = "普通模型.wdf"
	elseif ch == "裂天_虎头怪_普通" then
		chs[1] = 0161677133
		chs[2] = 2342305231
		chs[3] = "普通模型.wdf"
	elseif ch == "鱼肠_剑侠客_普通" then
		chs[1] = 3889393968
		chs[2] = 0792072082
		chs[3] = "普通模型.wdf"
	elseif ch == "鱼肠_逍遥生_普通" then
		chs[1] = 0x39BAEA10
		chs[2] = 0xE9D644EA
		chs[3] = "普通模型.wdf"
	elseif ch == "倚天_剑侠客_普通" then
		chs[1] = 2329390480
		chs[2] = 0026468517
		chs[3] = "普通模型.wdf"
	elseif ch == "倚天_逍遥生_普通" then
		chs[1] = 0745286869
		chs[2] = 1361011629
		chs[3] = "普通模型.wdf"
	elseif ch == "湛卢_剑侠客_普通" then
		chs[1] = 1840181339
		chs[2] = 0603337468
		chs[3] = "普通模型.wdf"
	elseif ch == "湛卢_逍遥生_普通" then
		chs[1] = 0x439811D3
		chs[2] = 0x6DE2CCCB
		chs[3] = "普通模型.wdf"
	elseif ch == "画龙点睛_逍遥生_普通" then
		chs[1] = 0xF38680F5
		chs[2] = 0xBDC4259D
		chs[3] = "普通模型.wdf"
	elseif ch == "秋水人家_逍遥生_普通" then
		chs[1] = 0x9B3FF437
		chs[2] = 0xEEFDA661
		chs[3] = "普通模型.wdf"
	elseif ch == "逍遥江湖_逍遥生_普通" then
		chs[1] = 0x08D4818E
		chs[2] = 0x0FF23BFF
		chs[3] = "普通模型.wdf"
	elseif ch == "浩气长舒_逍遥生_普通" then
		chs[1] = 3196397447
		chs[2] = 0378375394
		chs[3] = "普通模型.wdf"
	elseif ch == "星瀚_逍遥生_普通" then
		chs[1] = 0791015559
		chs[2] = 3682713078
		chs[3] = "普通模型.wdf"
	elseif ch == "魏武青虹_剑侠客_普通" then
		chs[1] = 0x241DF4E3
		chs[2] = 0x3DDB7FF0
		chs[3] = "普通模型.wdf"
	elseif ch == "灵犀神剑_剑侠客_普通" then
		chs[1] = 0x31034D66
		chs[2] = 0xDFC62A73
		chs[3] = "普通模型.wdf"
	elseif ch == "四法青云_剑侠客_普通" then
		chs[1] = 0xDF749306
		chs[2] = 0x1BEC0D8A
		chs[3] = "普通模型.wdf"
	elseif ch == "霜冷九州_剑侠客_普通" then
		chs[1] = 0007350584
		chs[2] = 2444149863
		chs[3] = "普通模型.wdf"
	elseif ch == "擒龙_剑侠客_普通" then
		chs[1] = 1376642035
		chs[2] = 1247967770
		chs[3] = "普通模型.wdf"
	elseif ch == "魏武青虹_逍遥生_普通" then
		chs[1] = 0x2562AA24
		chs[2] = 0x2C0190DC
		chs[3] = "普通模型.wdf"
	elseif ch == "灵犀神剑_逍遥生_普通" then
		chs[1] = 0xB532E559
		chs[2] = 0x55AA2A03
		chs[3] = "普通模型.wdf"
	elseif ch == "四法青云_逍遥生_普通" then
		chs[1] = 0x345FD6AC
		chs[2] = 0x5763E3AE
		chs[3] = "普通模型.wdf"
	elseif ch == "霜冷九州_逍遥生_普通" then
		chs[1] = 3023520771
		chs[2] = 3722552317
		chs[3] = "普通模型.wdf"
	elseif ch == "擒龙_逍遥生_普通" then
		chs[1] = 1376642035
		chs[2] = 1247967770
		chs[3] = "普通模型.wdf"
	elseif ch == "太极_逍遥生_普通" then
		chs[1] = 0568453373
		chs[2] = 3793189291
		chs[3] = "普通模型.wdf"
	elseif ch == "太极_龙太子_普通" then
		chs[1] = 0x58D20E79
		chs[2] = 0xA963CEE9
		chs[3] = "普通模型.wdf"
	elseif ch == "玉龙_逍遥生_普通" then
		chs[1] = 1635836812
		chs[2] = 4197667404
		chs[3] = "普通模型.wdf"
	elseif ch == "玉龙_龙太子_普通" then
		chs[1] = 0x44BEAA26
		chs[2] = 0xE819C83D
		chs[3] = "普通模型.wdf"
	elseif ch == "秋风_逍遥生_普通" then
		chs[1] = 3028020838
		chs[2] = 4268258437
		chs[3] = "普通模型.wdf"
	elseif ch == "秋风_龙太子_普通" then
		chs[1] = 0x387B481F
		chs[2] = 0xFB69C03A
		chs[3] = "普通模型.wdf"
	elseif ch == "画龙点睛_龙太子_普通" then
		chs[1] = 0x741AAD01
		chs[2] = 0x7691CE27
		chs[3] = "普通模型.wdf"
	elseif ch == "秋水人家_龙太子_普通" then
		chs[1] = 0xB68FBD09
		chs[2] = 0x9A1E802B
		chs[3] = "普通模型.wdf"
	elseif ch == "逍遥江湖_龙太子_普通" then
		chs[1] = 0xD1FABFBB
		chs[2] = 0x46AB4BEC
		chs[3] = "普通模型.wdf"
	elseif ch == "浩气长舒_龙太子_普通" then
		chs[1] = 0xD5E7FC6E
		chs[2] = 0x804E4F85
		chs[3] = "普通模型.wdf"
	elseif ch == "星瀚_龙太子_普通" then
		chs[1] = 0xBD8FF16C
		chs[2] = 0xC7E0CEC1
		chs[3] = "普通模型.wdf"
	elseif ch == "冷月_巨魔王_普通" then
		chs[1] = 1674010879
		chs[2] = 1438363487
		chs[3] = "普通模型.wdf"
	elseif ch == "冷月_剑侠客_普通" then
		chs[1] = 0xDA08D26D
		chs[2] = 0x6C6F4579
		chs[3] = "普通模型.wdf"
	elseif ch == "屠龙_巨魔王_普通" then
		chs[1] = 2271660461
		chs[2] = 0895095420
		chs[3] = "普通模型.wdf"
	elseif ch == "屠龙_剑侠客_普通" then
		chs[1] = 3479012312
		chs[2] = 2635216567
		chs[3] = "普通模型.wdf"
	elseif ch == "血刃_巨魔王_普通" then
		chs[1] = 3645677695
		chs[2] = 1888150636
		chs[3] = "普通模型.wdf"
	elseif ch == "血刃_剑侠客_普通" then
		chs[1] = 0x85D0D994
		chs[2] = 0x50DA4A82
		chs[3] = "普通模型.wdf"
	elseif ch == "偃月青龙_剑侠客_普通" then
		chs[1] = 0xC68B564D
		chs[2] = 0x922E909A
		chs[3] = "普通模型.wdf"
	elseif ch == "斩妖泣血_剑侠客_普通" then
		chs[1] = 0x0EFA39F2
		chs[2] = 0x16FE7AF5
		chs[3] = "普通模型.wdf"
	elseif ch == "晓风残月_剑侠客_普通" then
		chs[1] = 0xE6AD88AE
		chs[2] = 0x6ED6B121
		chs[3] = "普通模型.wdf"
	elseif ch == "业火三灾_剑侠客_普通" then
		chs[1] = 4059506148
		chs[2] = 1966900337
		chs[3] = "普通模型.wdf"
	elseif ch == "鸣鸿_剑侠客_普通" then
		chs[1] = 1616701029
		chs[2] = 1774867550
		chs[3] = "普通模型.wdf"
	elseif ch == "偃月青龙_巨魔王_普通" then
		chs[1] = 0xF6A68E4C
		chs[2] = 0xB20BA1E9
		chs[3] = "普通模型.wdf"
	elseif ch == "斩妖泣血_巨魔王_普通" then
		chs[1] = 0x15B2D6D4
		chs[2] = 0x14997A50
		chs[3] = "普通模型.wdf"
	elseif ch == "晓风残月_巨魔王_普通" then
		chs[1] = 0x4B2232FE
		chs[2] = 0x2D70D93E
		chs[3] = "普通模型.wdf"
	elseif ch == "业火三灾_巨魔王_普通" then
		chs[1] = 4160821910
		chs[2] = 2586259872
		chs[3] = "普通模型.wdf"
	elseif ch == "鸣鸿_巨魔王_普通" then
		chs[1] = 2272535883
		chs[2] = 4183963940
		chs[3] = "普通模型.wdf"
	elseif ch == "沧海_骨精灵_普通" then
		chs[1] = 3768392022
		chs[2] = 3372471073
		chs[3] = "普通模型.wdf"
	elseif ch == "沧海_玄彩娥_普通" then
		chs[1] = 0xC1ACB479
		chs[2] = 0x6A9147F7
		chs[3] = "普通模型.wdf"
	elseif ch == "红莲_骨精灵_普通" then
		chs[1] = 2232215638
		chs[2] = 1432534548
		chs[3] = "普通模型.wdf"
	elseif ch == "红莲_玄彩娥_普通" then
		chs[1] = 0x0ADFB109
		chs[2] = 0xCA7E32B9
		chs[3] = "普通模型.wdf"
	elseif ch == "盘龙_骨精灵_普通" then
		chs[1] = 3403515550
		chs[2] = 00912832719
		chs[3] = "普通模型.wdf"
	elseif ch == "盘龙_玄彩娥_普通" then
		chs[1] = 0x69036521
		chs[2] = 0x02E73DE2
		chs[3] = "普通模型.wdf"
	elseif ch == "降魔玉杵_骨精灵_普通" then
		chs[1] = 0x51F29AF8
		chs[2] = 0x77E6448E
		chs[3] = "普通模型.wdf"
	elseif ch == "墨玉骷髅_骨精灵_普通" then
		chs[1] = 0x41184BFA
		chs[2] = 0x1C9639D1
		chs[3] = "普通模型.wdf"
	elseif ch == "青藤玉树_骨精灵_普通" then
		chs[1] = 0x162DD3BA
		chs[2] = 0xC603E808
		chs[3] = "普通模型.wdf"
	elseif ch == "丝萝乔木_骨精灵_普通" then
		chs[1] = 1422256901
		chs[2] = 3988348379
		chs[3] = "普通模型.wdf"
	elseif ch == "醍醐_骨精灵_普通" then
		chs[1] = 0609424635
		chs[2] = 4017665874
		chs[3] = "普通模型.wdf"
	elseif ch == "降魔玉杵_玄彩娥_普通" then
		chs[1] = 0xB3AB79E6
		chs[2] = 0x87E2D3A6
		chs[3] = "普通模型.wdf"
	elseif ch == "墨玉骷髅_玄彩娥_普通" then
		chs[1] = 0x89AFF2A0
		chs[2] = 0x791841F4
		chs[3] = "普通模型.wdf"
	elseif ch == "青藤玉树_玄彩娥_普通" then
		chs[1] = 0x98440F9D
		chs[2] = 0xA6807253
		chs[3] = "普通模型.wdf"
	elseif ch == "丝萝乔木_玄彩娥_普通" then
		chs[1] = 2492839980
		chs[2] = 0908131256
		chs[3] = "普通模型.wdf"
	elseif ch == "醍醐_玄彩娥_普通" then
		chs[1] = 2560304889
		chs[2] = 3032370082
		chs[3] = "普通模型.wdf"
	elseif ch == "八卦_神天兵_普通" then
		chs[1] = 0885266650
		chs[2] = 1350386258
		chs[3] = "普通模型.wdf"
	elseif ch == "八卦_虎头怪_普通" then
		chs[1] = 0xA438A403
		chs[2] = 0xAC1BAB97
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼牙_神天兵_普通" then
		chs[1] = 0050371172
		chs[2] = 1900721739
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼牙_虎头怪_普通" then
		chs[1] = 0x56DA382F
		chs[2] = 0x959DF477
		chs[3] = "普通模型.wdf"
	elseif ch == "雷神_神天兵_普通" then
		chs[1] = 1937688127
		chs[2] = 3648341818
		chs[3] = "普通模型.wdf"
	elseif ch == "雷神_虎头怪_普通" then
		chs[1] = 0x8CF27534
		chs[2] = 0xDA17EC9A
		chs[3] = "普通模型.wdf"
	elseif ch == "混元金锤_虎头怪_普通" then
		chs[1] = 0x8E7866EB
		chs[2] = 0x9101F598
		chs[3] = "普通模型.wdf"
	elseif ch == "九瓣莲花_虎头怪_普通" then
		chs[1] = 0xA7B9EF31
		chs[2] = 0xF5C7E01A
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼王蚀日_虎头怪_普通" then
		chs[1] = 0xA14E222D
		chs[2] = 0x757CC5CE
		chs[3] = "普通模型.wdf"
	elseif ch == "狂澜碎岳_虎头怪_普通" then
		chs[1] = 0981496208
		chs[2] = 1685513235
		chs[3] = "普通模型.wdf"
	elseif ch == "碎寂_虎头怪_普通" then
		chs[1] = 0512165103
		chs[2] = 2912368983
		chs[3] = "普通模型.wdf"
	elseif ch == "混元金锤_神天兵_普通" then
		chs[1] = 4173823692
		chs[2] = 0903872944
		chs[3] = "普通模型.wdf"
	elseif ch == "九瓣莲花_神天兵_普通" then
		chs[1] = 1960543447
		chs[2] = 1550557054
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼王蚀日_神天兵_普通" then
		chs[1] = 1056981959
		chs[2] = 0461194116
		chs[3] = "普通模型.wdf"
	elseif ch == "狂澜碎岳_神天兵_普通" then
		chs[1] = 4056574244
		chs[2] = 2900798348
		chs[3] = "普通模型.wdf"
	elseif ch == "碎寂_神天兵_普通" then
		chs[1] = 0577319844
		chs[2] = 2305127073
		chs[3] = "普通模型.wdf"
	elseif ch == "撕天_狐美人_普通" then
		chs[1] = 2959598354
		chs[2] = 3959909274
		chs[3] = "普通模型.wdf"
	elseif ch == "撕天_骨精灵_普通" then
		chs[1] = 0x3DF34F1E
		chs[2] = 0xE5D43556
		chs[3] = "普通模型.wdf"
	elseif ch == "毒牙_狐美人_普通" then
		chs[1] = 3492190917
		chs[2] = 0057548694
		chs[3] = "普通模型.wdf"
	elseif ch == "毒牙_骨精灵_普通" then
		chs[1] = 0xD6EF0627
		chs[2] = 0x831F74AE
		chs[3] = "普通模型.wdf"
	elseif ch == "胭脂_狐美人_普通" then
		chs[1] = 3087805369
		chs[2] = 0210949852
		chs[3] = "普通模型.wdf"
	elseif ch == "胭脂_骨精灵_普通" then
		chs[1] = 0x7D916F78
		chs[2] = 0xF65B1CC4
		chs[3] = "普通模型.wdf"
	elseif ch == "九阴勾魂_骨精灵_普通" then
		chs[1] = 0x63413CA4
		chs[2] = 0x9C82F08B
		chs[3] = "普通模型.wdf"
	elseif ch == "雪蚕之刺_骨精灵_普通" then
		chs[1] = 0xF1E4D97A
		chs[2] = 0x5D773943
		chs[3] = "普通模型.wdf"
	elseif ch == "贵霜之牙_骨精灵_普通" then
		chs[1] = 0xAE948CBB
		chs[2] = 0x7E47B81B
		chs[3] = "普通模型.wdf"
	elseif ch == "忘川三途_骨精灵_普通" then
		chs[1] = 2856473183
		chs[2] = 2645115155
		chs[3] = "普通模型.wdf"
	elseif ch == "离钩_骨精灵_普通" then
		chs[1] = 1495713199
		chs[2] = 2314275840
		chs[3] = "普通模型.wdf"
	elseif ch == "九阴勾魂_狐美人_普通" then
		chs[1] = 0xC2DC1244
		chs[2] = 0xB0ED001E
		chs[3] = "普通模型.wdf"
	elseif ch == "雪蚕之刺_狐美人_普通" then
		chs[1] = 0xC4B56A00
		chs[2] = 0x0381802B
		chs[3] = "普通模型.wdf"
	elseif ch == "贵霜之牙_狐美人_普通" then
		chs[1] = 0x762F7556
		chs[2] = 0xCDD20A7E
		chs[3] = "普通模型.wdf"
	elseif ch == "忘川三途_狐美人_普通" then
		chs[1] = 1211891114
		chs[2] = 0425062404
		chs[3] = "普通模型.wdf"
	elseif ch == "离钩_狐美人_普通" then
		chs[1] = 1495713199
		chs[2] = 1510775202
		chs[3] = "普通模型.wdf"
	elseif ch == "彩虹_舞天姬_普通" then
		chs[1] = 0x4EA5BCD9
		chs[2] = 0xD0D7B4C6
		chs[3] = "普通模型.wdf"
	elseif ch == "彩虹_玄彩娥_普通" then
		chs[1] = 0573669624
		chs[2] = 1480465175
		chs[3] = "普通模型.wdf"
	elseif ch == "流云_舞天姬_普通" then
		chs[1] = 0xC0499E98
		chs[2] = 0x4F0D82C7
		chs[3] = "普通模型.wdf"
	elseif ch == "流云_玄彩娥_普通" then
	    chs[1] = 1071235145
		chs[2] = 2395250490
		chs[3] = "普通模型.wdf"
	elseif ch == "碧波_舞天姬_普通" then
		chs[1] = 0x809C371A
		chs[2] = 0xC0A2F354
		chs[3] = "普通模型.wdf"
	elseif ch == "碧波_玄彩娥_普通" then
	    chs[1] = 2358752644
		chs[2] = 3055396661
		chs[3] = "普通模型.wdf"
	elseif ch == "秋水落霞_舞天姬_普通" then
		chs[1] = 0xBC559AEB
		chs[2] = 0xBC89D4EB
		chs[3] = "普通模型.wdf"
	elseif ch == "晃金仙绳_舞天姬_普通" then
		chs[1] = 0x14918F2D
		chs[2] = 0x7AEB22FC
		chs[3] = "普通模型.wdf"
	elseif ch == "此最相思_舞天姬_普通" then
		chs[1] = 0xB04EF3E7
		chs[2] = 0xE47097A9
		chs[3] = "普通模型.wdf"
	elseif ch == "揽月摘星_舞天姬_普通" then
		chs[1] = 2425294287
		chs[2] = 0718029991
		chs[3] = "普通模型.wdf"
	elseif ch == "九霄_舞天姬_普通" then
		chs[1] = 1944035871
		chs[2] = 0335082726
		chs[3] = "普通模型.wdf"
	elseif ch == "别情离恨_舞天姬_普通" then
		chs[1] = 0xF420B6F9
		chs[2] = 0x0958E12B
		chs[3] = "普通模型.wdf"
	elseif ch == "金玉双环_舞天姬_普通" then
		chs[1] = 0x93CDA250
		chs[2] = 0xA50B0DB0
		chs[3] = "普通模型.wdf"
	elseif ch == "九天金线_舞天姬_普通" then
		chs[1] = 0xF5E7C6EF
		chs[2] = 0x0218E725
		chs[3] = "普通模型.wdf"
	elseif ch == "无关风月_舞天姬_普通" then
		chs[1] = 1007231129
		chs[2] = 1829725423
		chs[3] = "普通模型.wdf"
	elseif ch == "朝夕_舞天姬_普通" then
		chs[1] = 2753598378
		chs[2] = 0871520866
		chs[3] = "普通模型.wdf"
	elseif ch == "秋水落霞_玄彩娥_普通" then
		chs[1] = 0x8BF9992F
		chs[2] = 0x17D413B7
		chs[3] = "普通模型.wdf"
	elseif ch == "晃金仙绳_玄彩娥_普通" then
		chs[1] = 0xEBA114CC
		chs[2] = 0x8FDCA745
		chs[3] = "普通模型.wdf"
	elseif ch == "此最相思_玄彩娥_普通" then
		chs[1] = 0xBEF9E038
		chs[2] = 0xFCF69018
		chs[3] = "普通模型.wdf"
	elseif ch == "揽月摘星_玄彩娥_普通" then
		chs[1] = 4239911535
		chs[2] = 1327298920
		chs[3] = "普通模型.wdf"
	elseif ch == "九霄_玄彩娥_普通" then
		chs[1] = 1385035033
		chs[2] = 2513919345
		chs[3] = "普通模型.wdf"
	elseif ch == "龙筋_英女侠_普通" then
		chs[1] = 0120114237
		chs[2] = 4185441630
		chs[3] = "普通模型.wdf"
	elseif ch == "龙筋_狐美人_普通" then
		chs[1] = 0xD76152B7
		chs[2] = 0xB241D7A6
		chs[3] = "普通模型.wdf"
	elseif ch == "百花_英女侠_普通" then
		chs[1] = 3000747610
		chs[2] = 0571279871
		chs[3] = "普通模型.wdf"
	elseif ch == "百花_狐美人_普通" then
		chs[1] = 0x888C7C46
		chs[2] = 0xE7CBB64B
		chs[3] = "普通模型.wdf"
	elseif ch == "吹雪_英女侠_普通" then
		chs[1] = 1309495973
		chs[2] = 0159974487
		chs[3] = "普通模型.wdf"
	elseif ch == "吹雪_狐美人_普通" then
		chs[1] = 0xBC2F95EF
		chs[2] = 0x16AC35C8
		chs[3] = "普通模型.wdf"
	elseif ch == "游龙惊鸿_狐美人_普通" then
		chs[1] = 0xB11264BE
		chs[2] = 0x7C2A8EF7
		chs[3] = "普通模型.wdf"
	elseif ch == "仙人指路_狐美人_普通" then
		chs[1] = 0x87BE19F7
		chs[2] = 0x10C7E94F
		chs[3] = "普通模型.wdf"
	elseif ch == "血之刺藤_狐美人_普通" then
		chs[1] = 0x430429EE
		chs[2] = 0xAB7969FB
		chs[3] = "普通模型.wdf"
	elseif ch == "牧云清歌_狐美人_普通" then
		chs[1] = 0846824610
		chs[2] = 3304484241
		chs[3] = "普通模型.wdf"
	elseif ch == "霜陨_狐美人_普通" then
		chs[1] = 1215671834
		chs[2] = 1056698647
		chs[3] = "普通模型.wdf"
	elseif ch == "如意_舞天姬_普通" then
		chs[1] = 2798387657
		chs[2] = 0709983425
		chs[3] = "普通模型.wdf"
	elseif ch == "如意_飞燕女_普通" then
		chs[1] = 0x108FFF69
		chs[2] = 0xEEB4814C
		chs[3] = "普通模型.wdf"
	elseif ch == "乾坤_舞天姬_普通" then
		chs[1] = 4117773016
		chs[2] = 0888040957
		chs[3] = "普通模型.wdf"
	elseif ch == "乾坤_飞燕女_普通" then
		chs[1] = 0x516AC342
		chs[2] = 0x6011B8EA
		chs[3] = "普通模型.wdf"
	elseif ch == "月光双环_舞天姬_普通" then
		chs[1] = 2969095231
		chs[2] = 3586695559
		chs[3] = "普通模型.wdf"
	elseif ch == "月光双环_飞燕女_普通" then
		chs[1] = 0xD2011BDE
		chs[2] = 0x118B2316
		chs[3] = "普通模型.wdf"
	elseif ch == "阴阳_飞燕女_普通" then
		chs[1] = 0006565675
		chs[2] = 0527831083
		chs[3] = "普通模型.wdf"
	elseif ch == "阴阳_英女侠_普通" then
		chs[1] = 0xB8D3407A
		chs[2] = 0xA776D93A
		chs[3] = "普通模型.wdf"
	elseif ch == "月光双剑_飞燕女_普通" then
		chs[1] = 1968668223
		chs[2] = 1806180317
		chs[3] = "普通模型.wdf"
	elseif ch == "月光双剑_英女侠_普通" then
		chs[1] = 0x0E469C32
		chs[2] = 0x4B68D6FE
		chs[3] = "普通模型.wdf"
	elseif ch == "灵蛇_飞燕女_普通" then
		chs[1] = 0585049597
		chs[2] = 0883345409
		chs[3] = "普通模型.wdf"
	elseif ch == "灵蛇_英女侠_普通" then
		chs[1] = 0x36D0EAA0
		chs[2] = 0xC4ED7657
		chs[3] = "普通模型.wdf"
	elseif ch == "游龙惊鸿_英女侠_普通" then
		chs[1] = 0x3E7DDDB1
		chs[2] = 0x339E1DD5
		chs[3] = "普通模型.wdf"
	elseif ch == "仙人指路_英女侠_普通" then
		chs[1] = 0x36FA7E8F
		chs[2] = 0x33825F90
		chs[3] = "普通模型.wdf"
	elseif ch == "血之刺藤_英女侠_普通" then
		chs[1] = 0xCEF9D441
		chs[2] = 0xCB134023
		chs[3] = "普通模型.wdf"
	elseif ch == "牧云清歌_英女侠_普通" then
		chs[1] = 2729481727
		chs[2] = 1717626599
		chs[3] = "普通模型.wdf"
	elseif ch == "霜陨_英女侠_普通" then
		chs[1] = 1215671834
		chs[2] = 1056698647
		chs[3] = "普通模型.wdf"
	elseif ch == "金龙双剪_飞燕女_普通" then
		chs[1] = 0x88E2548C
		chs[2] = 0xC70FF23A
		chs[3] = "普通模型.wdf"
	elseif ch == "连理双树_飞燕女_普通" then
		chs[1] = 0xBFBE4DC9
		chs[2] = 0x4894EB42
		chs[3] = "普通模型.wdf"
	elseif ch == "祖龙对剑_飞燕女_普通" then
		chs[1] = 0x088A1188
		chs[2] = 0x0D3ED468
		chs[3] = "普通模型.wdf"
	elseif ch == "紫电青霜_飞燕女_普通" then
		chs[1] = 4174514804
		chs[2] = 3343319550
		chs[3] = "普通模型.wdf"
	elseif ch == "浮犀_飞燕女_普通" then
		chs[1] = 3366765078
		chs[2] = 3831481111
		chs[3] = "普通模型.wdf"
	elseif ch == "别情离恨_飞燕女_普通" then
		chs[1] = 0x72013AF5
		chs[2] = 0xF2FB1AFA
		chs[3] = "普通模型.wdf"
	elseif ch == "金玉双环_飞燕女_普通" then
		chs[1] = 0xA1661BC0
		chs[2] = 0xB6C5947A
		chs[3] = "普通模型.wdf"
	elseif ch == "九天金线_飞燕女_普通" then
		chs[1] = 0x454E8758
		chs[2] = 0x2D8326FB
		chs[3] = "普通模型.wdf"
	elseif ch == "无关风月_飞燕女_普通" then
		chs[1] = 0888561149
		chs[2] = 3212121801
		chs[3] = "普通模型.wdf"
	elseif ch == "朝夕_飞燕女_普通" then
		chs[1] = 0961373825
		chs[2] = 1399381898
		chs[3] = "普通模型.wdf"
	elseif ch == "金龙双剪_英女侠_普通" then
		chs[1] = 0xB2D36625
		chs[2] = 0x373FA8FC
		chs[3] = "普通模型.wdf"
	elseif ch == "连理双树_英女侠_普通" then
		chs[1] = 0x2F82163D
		chs[2] = 0xA051D73F
		chs[3] = "普通模型.wdf"
	elseif ch == "祖龙对剑_英女侠_普通" then
		chs[1] = 0x466B6959
		chs[2] = 0xEE3BCF6B
		chs[3] = "普通模型.wdf"
	elseif ch == "紫电青霜_英女侠_普通" then
		chs[1] = 4174514804
		chs[2] = 0254271220
		chs[3] = "普通模型.wdf"
	elseif ch == "浮犀_英女侠_普通" then
		chs[1] = 1454482476
		chs[2] = 3425270325
		chs[3] = "普通模型.wdf"
	elseif ch == "离火_巫蛮儿_普通" then
		chs[1] = 3491744635
		chs[2] = 3429826897
		chs[3] = "普通模型.wdf"
	elseif ch == "离火_杀破狼_普通" then
		chs[1] = 2641155879
		chs[2] = 1590716186
		chs[3] = "普通模型.wdf"
	elseif ch == "飞星_巫蛮儿_普通" then
		chs[1] = 3062034163
		chs[2] = 3170325397
		chs[3] = "普通模型.wdf"
	elseif ch == "飞星_杀破狼_普通" then
		chs[1] = 2717746866
		chs[2] = 1504946577
		chs[3] = "普通模型.wdf"
	elseif ch == "月华_巫蛮儿_普通" then
		chs[1] = 4115068184
		chs[2] = 2364973462
		chs[3] = "普通模型.wdf"
	elseif ch == "月华_杀破狼_普通" then
		chs[1] = 2389596849
		chs[2] = 2983597511
		chs[3] = "普通模型.wdf"
	elseif ch == "回风舞雪_杀破狼_普通" then
		chs[1] = 3286763223
		chs[2] = 1088084197
		chs[3] = "普通模型.wdf"
	elseif ch == "紫金葫芦_杀破狼_普通" then
		chs[1] = 3085783481
		chs[2] = 2243295981
		chs[3] = "普通模型.wdf"
	elseif ch == "裂云啸日_杀破狼_普通" then
		chs[1] = 3958823224
		chs[2] = 1544529746
		chs[3] = "普通模型.wdf"
	elseif ch == "云雷万里_杀破狼_普通" then
		chs[1] = 2031537277
		chs[2] = 1403541362
		chs[3] = "普通模型.wdf"
	elseif ch == "赤明_杀破狼_普通" then
		chs[1] = 3883902194
		chs[2] = 0xD74EF908
		chs[3] = "普通模型.wdf"
	elseif ch == "回风舞雪_巫蛮儿_普通" then
		chs[1] = 3587358129
		chs[2] = 3378197526
		chs[3] = "普通模型.wdf"
	elseif ch == "紫金葫芦_巫蛮儿_普通" then
		chs[1] = 0668840870
		chs[2] = 3082640737
		chs[3] = "普通模型.wdf"
	elseif ch == "裂云啸日_巫蛮儿_普通" then
		chs[1] = 0033586962
		chs[2] = 3500204883
		chs[3] = "普通模型.wdf"
	elseif ch == "云雷万里_巫蛮儿_普通" then
		chs[1] = 0086034382
		chs[2] = 2492569356
		chs[3] = "普通模型.wdf"
	elseif ch == "赤明_巫蛮儿_普通" then
		chs[1] = 3482219011
		chs[2] = 0125440945
		chs[3] = "普通模型.wdf"
	elseif ch == "非攻_杀破狼_普通" then
		chs[1] = 2360647601
		chs[2] = 3580642624
		chs[3] = "普通模型.wdf"
	elseif ch == "非攻_羽灵神_普通" then
		chs[1] = 4118502147
		chs[2] = 1301985929
		chs[3] = "普通模型.wdf"
	elseif ch == "幽篁_杀破狼_普通" then
		chs[1] = 1961778763
		chs[2] = 2093379552
		chs[3] = "普通模型.wdf"
	elseif ch == "幽篁_羽灵神_普通" then
		chs[1] = 0044473302
		chs[2] = 0943743279
		chs[3] = "普通模型.wdf"
	elseif ch == "百鬼_杀破狼_普通" then
		chs[1] = 3918682738
		chs[2] = 3616556566
		chs[3] = "普通模型.wdf"
	elseif ch == "百鬼_羽灵神_普通" then
		chs[1] = 4227459057
		chs[2] = 0226502213
		chs[3] = "普通模型.wdf"
	elseif ch == "冥火薄天_羽灵神_普通" then
		chs[1] = 1329583138
		chs[2] = 2921186180
		chs[3] = "普通模型.wdf"
	elseif ch == "龙鸣寒水_羽灵神_普通" then
		chs[1] = 2146481723
		chs[2] = 1237674101
		chs[3] = "普通模型.wdf"
	elseif ch == "太极流光_羽灵神_普通" then
		chs[1] = 0635066655
		chs[2] = 0454346244
		chs[3] = "普通模型.wdf"
	elseif ch == "九霄风雷_羽灵神_普通" then
		chs[1] = 1118851042
		chs[2] = 3857072095
		chs[3] = "普通模型.wdf"
	elseif ch == "若木_羽灵神_普通" then
		chs[1] = 2140866752
		chs[2] = 0300870526
		chs[3] = "普通模型.wdf"
	elseif ch == "冥火薄天_杀破狼_普通" then
		chs[1] = 4237566348
		chs[2] = 3313167169
		chs[3] = "普通模型.wdf"
	elseif ch == "龙鸣寒水_杀破狼_普通" then
		chs[1] = 1522717413
		chs[2] = 0xECB3ED94
		chs[3] = "普通模型.wdf"
	elseif ch == "太极流光_杀破狼_普通" then
		chs[1] = 3966436183
		chs[2] = 3741875286
		chs[3] = "普通模型.wdf"
	elseif ch == "九霄风雷_杀破狼_普通" then
		chs[1] = 0929770205
		chs[2] = 3222657771
		chs[3] = "普通模型.wdf"
	elseif ch == "若木_杀破狼_普通" then
		chs[1] = 1083623074
		chs[2] = 3047863049
		chs[3] = "普通模型.wdf"
	elseif ch == "业焰_羽灵神_普通" then
		chs[1] = 0834237487
		chs[2] = 3629386269
		chs[3] = "普通模型.wdf"
	elseif ch == "业焰_巫蛮儿_普通" then
		chs[1] = 0830839494
		chs[2] = 1738625165
		chs[3] = "普通模型.wdf"
	elseif ch == "玉辉_羽灵神_普通" then
		chs[1] = 0713952553
		chs[2] = 3757988895
		chs[3] = "普通模型.wdf"
	elseif ch == "玉辉_巫蛮儿_普通" then
		chs[1] = 0378020939
		chs[2] = 3913240810
		chs[3] = "普通模型.wdf"
	elseif ch == "鹿鸣_羽灵神_普通" then
		chs[1] = 1396998121
		chs[2] = 2061375933
		chs[3] = "普通模型.wdf"
	elseif ch == "鹿鸣_巫蛮儿_普通" then
		chs[1] = 1036718398
		chs[2] = 1545197282
		chs[3] = "普通模型.wdf"
	elseif ch == "庄周梦蝶_羽灵神_普通" then
		chs[1] = 4147727634
		chs[2] = 3250095538
		chs[3] = "普通模型.wdf"
	elseif ch == "凤翼流珠_羽灵神_普通" then
		chs[1] = 3818690168
		chs[2] = 3332193101
		chs[3] = "普通模型.wdf"
	elseif ch == "雪蟒霜寒_羽灵神_普通" then
		chs[1] = 1208982538
		chs[2] = 3271417203
		chs[3] = "普通模型.wdf"
	elseif ch == "碧海潮生_羽灵神_普通" then
		chs[1] = 3786902490
		chs[2] = 0069282931
		chs[3] = "普通模型.wdf"
	elseif ch == "弦月_羽灵神_普通" then
		chs[1] = 4218574639
		chs[2] = 3403641761
		chs[3] = "普通模型.wdf"
	elseif ch == "庄周梦蝶_巫蛮儿_普通" then
		chs[1] = 0383346255
		chs[2] = 0788977205
		chs[3] = "普通模型.wdf"
	elseif ch == "凤翼流珠_巫蛮儿_普通" then
		chs[1] = 2738200746
		chs[2] = 3013213807
		chs[3] = "普通模型.wdf"
	elseif ch == "雪蟒霜寒_巫蛮儿_普通" then
		chs[1] = 2446794254
		chs[2] = 2344781059
		chs[3] = "普通模型.wdf"
	elseif ch == "碧海潮生_巫蛮儿_普通" then
		chs[1] = 3147201779
		chs[2] = 3842138961
		chs[3] = "普通模型.wdf"
	elseif ch == "弦月_巫蛮儿_普通" then
		chs[1] = 2558772509
		chs[2] = 0994443450
		chs[3] = "普通模型.wdf"
	elseif ch == "地藏王_普通" then
		chs[1] = 0x3A11C300
		chs[2] = 0x32C68CC9
		chs[3] = "普通模型.wdf"
	elseif ch == "阎罗王_普通" then
		chs[1] = 0xA5B436EE
		chs[2] = 0x558B14D5
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_判官_普通" then
		chs[1] = 0x56738B45
		chs[2] = 0x6617CE07
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_杨戬_普通" then
		chs[1] = 0x1D8F9ABB
		chs[2] = 0x04103E1D
		chs[3] = "普通模型.wdf"
	elseif ch == "李靖_普通" then
		chs[1] = 0x2596EC14
		chs[2] = 0x431A24FA
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_玉帝_普通" then
		chs[1] = 0xEB00DE5F
		chs[2] = 0x3C7DB1FD
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_王母_普通" then
		chs[1] = 0x248A3E4C
		chs[2] = 0x2B2CC199
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_哪吒_普通" then
		chs[1] = 0x5903D418
		chs[2] = 0x259EC5A7
		chs[3] = "普通模型.wdf"
	elseif ch == "牛魔王_普通" then
		chs[1] = 0x0B69B44D
		chs[2] = 0xD8CFAC15
		chs[3] = "战斗模型.wdf"
	elseif ch =="武器_牛魔王_普通"then
		chs[1]=0x64E51B02
		chs[2]=0x393490E0
		chs[3] ="战斗模型.wdf"
	elseif ch == "观音姐姐_普通" then
		chs[1] = 0x000E77E4
		chs[2] = 0x000EBE57
		chs[3] = "普通模型.wdf"
	elseif ch == "观音姐姐1_普通" then
		chs[1] = 0x0405C585
		chs[2] = 0x0405C585
		chs[3] = "普通模型.wdf"
	elseif ch == "镇元子_普通" then
		chs[1] = 0x003002BF
		chs[2] = 0x00305C86
		chs[3] = "普通模型.wdf"
	elseif ch == "大大王_普通" then
		chs[1] = 0x000A5293
		chs[2] = 0x000A9704
		chs[3] = "普通模型.wdf"
	elseif ch == "春十三娘_普通" then
		chs[1] = 0x2E305A78
		chs[2] = 0x61A8F3FF
		chs[3] = "普通模型.wdf"
	elseif ch == "白晶晶_普通" then
		chs[1] = 0xF5D47E2E
		chs[2] = 0x9957A256
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_太上老君_普通" then
		chs[1] = 0x3599D5C3
		chs[2] = 0x16505471
		chs[3] = "普通模型.wdf"
	elseif ch == "巫师_普通" then
		chs[1] = 0xB692F3E2
		chs[2] = 0xD569F35B
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_云小奴_普通" then
		chs[1] = 0x18791291
		chs[2] = 0x90065904
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_满天星_普通" then
		chs[1] = 0x6D96A509
		chs[2] = 0x90065904
		chs[3] = "普通模型.wdf"
	elseif ch == "巫奎虎_普通" then
		chs[1] = 0x062150F6
		chs[2] = 0x922CB5F2
		chs[3] = "普通模型.wdf"
	elseif ch == "地涌夫人_普通" then
		chs[1] = 0x2EDEAF19
		chs[2] = 0xE46EA6C3
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_灵鼠娃娃_普通" then
		chs[1] = 0x738F33AF
		chs[2] = 0x9A5FA693
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_道童_普通" then
		chs[1] = 0xF4848781
		chs[2] = 0x7376DB37
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_翠花_普通" then
		chs[1] = 0x70357245
		chs[2] = 0x3790FE0A
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_栗栗娘_普通" then
		chs[1] = 0x2C2259AB
		chs[2] = 0x7376DB37
		chs[3] = "普通模型.wdf"
  	elseif ch == "女兵_普通" then
		chs[1] = 0xE7D72D11
		chs[2] = 0x6E8CD009
		chs[3] = "普通模型.wdf"
  elseif ch == "女官_普通" then
		chs[1] = 0x40D087F9
		chs[2] = 0xD104A2CD
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_绿儿_普通" then
		chs[1] = 0x9493C216
		chs[2] = 0xF269B9B7
		chs[3] = "普通模型.wdf"
	elseif ch == "孙婆婆_普通" then
		chs[1] = 0x81F4F89D
		chs[2] = 0x600BA182
		chs[3] = "普通模型.wdf"
	elseif ch == "二大王_普通" then
		chs[1] = 0x50355C48
		chs[2] = 0x403A153E
		chs[3] = "普通模型.wdf"
	elseif ch == "三大王_普通" then
		chs[1] = 0x228D340F
		chs[2] = 0x2059CBB0
		chs[3] = "普通模型.wdf"
	elseif ch == "女人_孟婆_普通" then
		chs[1] = 0xAFA62A72
		chs[2] = 0xCB62E343
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_诗中仙_普通" then
		chs[1] = 0x41B1D8EC
		chs[2] = 0x5FD74EE1
		chs[3] = "普通模型.wdf"
	elseif ch == "蚩尤_旧_普通" then
		chs[1] = 0x001D3490
		chs[2] = 0x001D4FCE
		chs[3] = "普通模型.wdf"
	elseif ch == "桃夭夭_普通" then
		chs[1] = 0xC8FDA448
		chs[2] = 0xC8FDA142
		chs[3] = "普通模型.wdf"
	elseif ch == "桃夭夭_飘带" then
		chs[1] = 0xC8FDA448
		chs[2] = 0xC8FDA142
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼潇潇_普通" then
		chs[1] = 0xC8FDA390
		chs[2] = 0xC8FDA400
		chs[3] = "普通模型.wdf"
	elseif ch == "鬼潇潇_爪刺" then
		chs[1] = 0xC8FDA390
		chs[2] = 0xC8FDA400
		chs[3] = "普通模型.wdf"
	elseif ch == "男人_马副将_普通" then
		chs[1] = 0x6843A912
		chs[2] = 0x4EE87EE9
		chs[3] = "普通模型.wdf"
	elseif ch == "樵夫_普通" then
		chs[1] = 0xBC6BD1E8
		chs[2] = 0x8736E40D
		chs[3] = "普通模型.wdf"
	elseif ch == "武器_男人_马副将_普通" then
		chs[1] = 0xDA6A56D6
		chs[2] = 0x0E0B110D
		chs[3] = "普通模型.wdf"
	elseif ch == "哮天犬_普通" then
		chs[1] = 0x09351393
		chs[2] = 0x8A284760
		chs[3] = "普通模型.wdf"
	elseif ch == "考官1_普通" then
		chs[1] = 0xAD7A1BD3
		chs[2] = 0xBB2ECF8E
		chs[3] = "普通模型.wdf"
   elseif ch == "热心仙人_普通" then
		chs[1] = 0xA831A782
		chs[2] = 0xA831A782
		chs[3] = "普通模型.wdf"
	elseif ch == "考官2_普通" then
		chs[1] = 0x6ABF75AD
		chs[2] = 0x8DDC27F7
		chs[3] = "普通模型.wdf"
	elseif ch == "雪人1_普通" then
		chs[1] = 0xDA74178C
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "雪人2_普通" then
		chs[1] = 0xBE52981A
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "雪人3_普通" then
		chs[1] = 0xF6655BCB
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "雪人4_普通" then
		chs[1] = 0x7ED2C0BE
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "雪人5_普通" then
		chs[1] = 0x6843DF1A
		chs[2] = 0x6843DF1A
		chs[3] = "普通模型.wdf"
	elseif ch == "和尚3_普通" then
		chs[1] = 0xA831A782
		chs[2] = 0xA7362DEF
		chs[3] = "普通模型.wdf"
	elseif ch == "和尚2_普通" then
		chs[1] = 0xD5A91213
		chs[2] = 0xD5A91213
		chs[3] = "普通模型.wdf"
	elseif ch == "和尚1_普通" then
		chs[1] = 0x6341E0D6
		chs[2] = 0x177CDA70
		chs[3] = "普通模型.wdf"
	elseif ch == "五行大师_普通" then
		chs[1] = 0x21EAE195
		chs[2] = 0x21EAE195
		chs[3] = "普通模型.wdf"
	elseif ch == "皇帝_普通" then
		chs[1] = 0xB28A3DB1
		chs[2] = 0xBE8A3EC9
		chs[3] = "普通模型.wdf"
	elseif ch == "将军1_普通" then
		chs[1] = 0x589A2894
		chs[2] = 0x7ECE7DB2
		chs[3] = "普通模型.wdf"
	elseif ch == "道观_普通" then
		chs[1] = 0x639E73B0
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "南极仙翁_普通" then
		chs[1] = 0xB4DA85C7
		chs[2] = 0xBE41583A
		chs[3] = "普通模型.wdf"
	elseif ch == "宝箱_普通" then
		chs[1] = 0xEFFD57F2
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "民房_普通" then
		chs[1] = 0x474B1237
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "华宅_普通" then
		chs[1] = 0x474B1237
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "豪宅_普通" then
		chs[1] = 0x474B1237
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "唐僧_普通" then
		chs[1] = 0xF707EA37
		chs[2] = 0xFF76393B
		chs[3] = "普通模型.wdf"
	elseif ch == "鲁班_普通" then
		chs[1] = 0x5641D9BE
		chs[2] = 0x9D836B06
		chs[3] = "普通模型.wdf"
	elseif ch == "至尊宝_普通" then
		chs[1] = 0xEA27AD31
		chs[2] = 0xFB629346
		chs[3] = "普通模型.wdf"
	elseif ch == "吴刚_普通" then
		chs[1] = 0xBC6BD1E8
		chs[2] = 0x8736E40D
		chs[3] = "普通模型.wdf"
	elseif ch == "武器_吴刚_普通" then
		chs[1] = 0xF4D3AC42
		chs[2] = 0xF4D3AC42
		chs[3] = "普通模型.wdf"
	elseif ch == "桃树_普通" then
		chs[1] = 0x544A2675
		chs[2] = nil
		chs[3] = "普通模型.wdf"
	elseif ch == "秦琼_普通" then
		chs[1] = 0x4D41D5D2
		chs[2] = 0x8A05EDF0
		chs[3] = "普通模型.wdf"
	elseif ch == "帮派妖兽_普通" then
		chs[1] = 0x0001738D
		chs[2] = 0x0001ABEB
		chs[3] = "普通模型.wdf"
	elseif ch == "吴刚_普通" then
		chs[1] = 0x4BC6BD1E8
		chs[2] = 0x8736E40D
		chs[3] = "普通模型.wdf"
	elseif ch == "僵尸倒地_普通" then
		chs[1] = 0x5723F6F9
		chs[2] = 0x5723F6F9
		chs[3] = "普通模型.wdf"
	elseif ch == "赌徒倒地_普通" then
		chs[1] = 0x93371DC2
		chs[2] = 0x93371DC2
		chs[3] = "普通模型.wdf"
	elseif ch == "逍遥生坐下_普通" then
		chs[1] = 0x81105904
		chs[2] = 0x81105904
		chs[3] = "普通模型.wdf"
	elseif ch == "英女侠坐下_普通" then
		chs[1] = 0x8AE7E3A4
		chs[2] = 0x8AE7E3A4
		chs[3] = "普通模型.wdf"
	elseif ch == "玄彩娥坐下_普通" then
		chs[1] = 0xF6820612
		chs[2] = 0xF6820612
		chs[3] = "普通模型.wdf"
	elseif ch == "舞天姬坐下_普通" then
		chs[1] = 3933281088
		chs[2] = 3933281088
		chs[3] = "普通模型.wdf"
	elseif ch == "神天兵坐下_普通" then
		chs[1] = 0xA4D3F138
		chs[2] = 0xA4D3F138
		chs[3] = "普通模型.wdf"
	elseif ch == "龙太子坐下_普通" then
		chs[1] = 0x1D76393F
		chs[2] = 0x1D76393F
		chs[3] = "普通模型.wdf"
	elseif ch == "巨魔王坐下_普通" then
		chs[1] = 0x8349ECD1
		chs[2] = 0x8349ECD1
		chs[3] = "普通模型.wdf"
	elseif ch == "剑侠客坐下_普通" then
		chs[1] = 0xCA7EED95
		chs[2] = 0xCA7EED95
		chs[3] = "普通模型.wdf"
	elseif ch == "虎头怪坐下_普通" then
		chs[1] = 0x0431506B
		chs[2] = 0x0431506B
		chs[3] = "普通模型.wdf"
	elseif ch == "狐美人坐下_普通" then
		chs[1] = 0x9C1633C8
		chs[2] = 0x9C1633C8
		chs[3] = "普通模型.wdf"
	elseif ch == "骨精灵坐下_普通" then
		chs[1] = 0x72AFA4E9
		chs[2] = 0x72AFA4E9
		chs[3] = "普通模型.wdf"
	elseif ch == "飞燕女坐下_普通" then
		chs[1] = 0x45988F73
		chs[2] = 0x45988F73
		chs[3] = "普通模型.wdf"
	elseif ch == "巫蛮儿坐下_普通" then
		chs[1] = 0803847012
		chs[2] = 0803847012
		chs[3] = "普通模型.wdf"
	elseif ch == "杀破狼坐下_普通" then
		chs[1] = 448666846
		chs[2] = 448666846
		chs[3] = "普通模型.wdf"
	elseif ch == "羽灵神坐下_普通" then
		chs[1] = 0775868075
		chs[2] = 0775868075
		chs[3] = "普通模型.wdf"
	elseif ch == "偃无师坐下_普通" then
		chs[1] = 0x00000098
		chs[2] = 0x00000102
		chs[3] = "common/shape.wda"
	elseif ch == "桃夭夭坐下_普通" then
		chs[1] = 0x00000091
		chs[2] = 0x00000090
		chs[3] = "common/shape.wdb"
	elseif ch == "鬼潇潇坐下_普通" then
		chs[1] = 0x00000065
		chs[2] = 0x00000053
		chs[3] = "common/shape.wdc"
	elseif ch == "超级玉兔_普通" then
		chs[1] = 0x1DA4FE4F
		chs[2] = 0x7E1310CA
		chs[3] = "common/shape.wd1"
	elseif ch == "偃无师_普通" then
		chs[1] = 0x00000098
		chs[2] = 0x00000102
		chs[3] = "common/shape.wda"
	elseif ch == "偃无师_剑" then
		chs[1] = 0xC8FDA120
		chs[2] = 0xC8FDA132
		chs[3] = "普通模型.wdf"
	elseif ch == "偃无师_巨剑" then
		chs[1] = 0x00000098
		chs[2] = 0x00000102
		chs[3] = "common/shape.wda"
	elseif ch == "壁玉长铗_偃无师_普通" then
		chs[1] = 0x00000071
		chs[2] = 0x00000060
		chs[3] = "common/shape.wda"
	elseif ch == "钝铁重剑_偃无师_普通" then
		chs[1] = 0x00000078
		chs[2] = 0x00000058
		chs[3] = "common/shape.wda"
	elseif ch == "惊涛雪_偃无师_普通" then
		chs[1] = 0x00000073
		chs[2] = 0x00000061
		chs[3] = "common/shape.wda"
	elseif ch == "鸦九_偃无师_普通" then
		chs[1] = 0x00000079
		chs[2] = 0x00000050
		chs[3] = "common/shape.wda"
	elseif ch == "昆吾_偃无师_普通" then
		chs[1] = 0x00000074
		chs[2] = 0x00000062
		chs[3] = "common/shape.wda"
	elseif ch == "弦歌_偃无师_普通" then
		chs[1] = 0x00000081
		chs[2] = 0x00000069
		chs[3] = "common/shape.wda"
	elseif ch == "墨骨枯麟_偃无师_普通" then
		chs[1] = 0x00000075
		chs[2] = 0x00000056
		chs[3] = "common/shape.wda"
	elseif ch == "腾蛇郁刃_偃无师_普通" then
		chs[1] = 0x00000077
		chs[2] = 0x00000065
		chs[3] = "common/shape.wda"
	elseif ch == "秋水澄流_偃无师_普通" then
		chs[1] = 0x00000076
		chs[2] = 0x00000104
		chs[3] = "common/shape.wda"
	elseif ch == "百辟镇魂_偃无师_普通" then
		chs[1] = 0x00000070
		chs[2] = 0x00000059
		chs[3] = "common/shape.wda"
	elseif ch == "长息_偃无师_普通" then
		chs[1] = 0x00000080
		chs[2] = 0x00000068
		chs[3] = "common/shape.wda"
	elseif ch == "桃夭夭_灯笼" then
		chs[1] = 0x00000091
		chs[2] = 0x00000090
		chs[3] = "common/shape.wdb"
	elseif ch == "素纸灯_桃夭夭_普通" then
		chs[1] = 0x00000059
		chs[2] = 0x00000096
		chs[3] = "common/shape.wdb"
	elseif ch == "如意宫灯_桃夭夭_普通" then
		chs[1] = 0x00000058
		chs[2] = 0x00000097
		chs[3] = "common/shape.wdb"
	elseif ch == "玉兔盏_桃夭夭_普通" then
		chs[1] = 0x00000061
		chs[2] = 0x00000098
		chs[3] = "common/shape.wdb"
	elseif ch == "蟠龙_桃夭夭_普通" then
		chs[1] = 0x00000057
		chs[2] = 0x00000099
		chs[3] = "common/shape.wdb"
	elseif ch == "云鹤_桃夭夭_普通" then
		chs[1] = 0x00000063
		chs[2] = 0x00000100
		chs[3] = "common/shape.wdb"
	elseif ch == "风荷_桃夭夭_普通" then
		chs[1] = 0x00000053
		chs[2] = 0x00000042
		chs[3] = "common/shape.wdb"
	elseif ch == "金风玉露_桃夭夭_普通" then
		chs[1] = 0x00000056
		chs[2] = 0x00000104
		chs[3] = "common/shape.wdb"
	elseif ch == "凰火燎原_桃夭夭_普通" then
		chs[1] = 0x00000103
		chs[2] = 0x00000044
		chs[3] = "common/shape.wdb"
	elseif ch == "月露清愁_桃夭夭_普通" then
		chs[1] = 0x00000062
		chs[2] = 0x00000101
		chs[3] = "common/shape.wdb"
	elseif ch == "夭桃秾李_桃夭夭_普通" then
		chs[1] = 0x00000060
		chs[2] = 0x00000105
		chs[3] = "common/shape.wdb"
	elseif ch == "荒尘_桃夭夭_普通" then
		chs[1] = 0x00000102
		chs[2] = 0x00000045
		chs[3] = "common/shape.wdb"
	elseif ch == "鬼潇潇_伞" then
		chs[1] = 0x00000065
		chs[2] = 0x00000053
		chs[3] = "common/shape.wdc"
	elseif ch == "红罗伞_鬼潇潇_普通" then
		chs[1] = 0x00000058
		chs[2] = 0x00000106
		chs[3] = "common/shape.wdc"
	elseif ch == "琳琅盖_鬼潇潇_普通" then
		chs[1] = 0x00000060
		chs[2] = 0x00000050
		chs[3] = "common/shape.wdc"
	elseif ch == "金刚伞_鬼潇潇_普通" then
		chs[1] = 0x00000110
		chs[2] = 0x00000072
		chs[3] = "common/shape.wdc"
	elseif ch == "鬼骨_鬼潇潇_普通" then
		chs[1] = 0x00000057
		chs[2] = 0x00000112
		chs[3] = "common/shape.wdc"
	elseif ch == "云梦_鬼潇潇_普通" then
		chs[1] = 0x00000064
		chs[2] = 0x00000113
		chs[3] = "common/shape.wdc"
	elseif ch == "枕霞_鬼潇潇_普通" then
		chs[1] = 0x00000059
		chs[2] = 0x00000066
		chs[3] = "common/shape.wdc"
	elseif ch == "碧火琉璃_鬼潇潇_普通" then
		chs[1] = 0x00000055
		chs[2] = 0x00000043
		chs[3] = "common/shape.wdc"
	elseif ch == "雪羽穿云_鬼潇潇_普通" then
		chs[1] = 0x00000062
		chs[2] = 0x00000117
		chs[3] = "common/shape.wdc"
	elseif ch == "月影星痕_鬼潇潇_普通" then
		chs[1] = 0x00000063
		chs[2] = 0x00000051
		chs[3] = "common/shape.wdc"
	elseif ch == "浮生归梦_鬼潇潇_普通" then
		chs[1] = 0x00000056
		chs[2] = 0x00000069
		chs[3] = "common/shape.wdc"
	elseif ch == "晴雪_鬼潇潇_普通" then
		chs[1] = 0x00000061
		chs[2] = 0x00000049
		chs[3] = "common/shape.wdc"
	elseif ch == "进阶毗舍童子_普通" then
		chs[1] = 0x7C15F7DE
        chs[2] = 0x1C29D8BC
        chs[3] = "普通模型.wdf"
    elseif ch == "进阶真陀护法_普通" then
		chs[1] = 0x06B907B8
        chs[2] = 0x0E6CDB9E
        chs[3] = "普通模型.wdf"
    elseif ch == "进阶持国巡守_普通" then
		chs[1] = 0x990FC5A1
        chs[2] = 0xA5E9EF08
        chs[3] = "普通模型.wdf"
	elseif ch == "狂豹_普通" then
		chs[1] = 0x19900125
        chs[2] = 0x19900131
        chs[3] = "普通模型.wdf"
	elseif ch == "毗舍童子_普通" then
		chs[1] = 0x60D45B9C
        chs[2] = 0x3AEB838B
        chs[3] = "普通模型.wdf"
	elseif ch == "流浪剑客_普通" then
		chs[1] = 0xA9DD17BC
        chs[2] = 0x4BC4A592
        chs[3] = "普通模型.wdf"
	elseif ch == "超级小仙女_普通" then
		chs[1] = 0x1D02CCE3
        chs[2] = 0xF0156D8A
        chs[3] = "普通模型.wdf"
     elseif ch == "超级神狗_普通" then
	   chs[1]  = 0x03000009
	   chs[2]  = 0x03000010
	   chs[3] = "铃铛界面.wdf"
    elseif ch == "超级神鼠_普通" then
    	chs[1] = 0x04000009
        chs[2]  = 0x04000010
        chs[3] = "铃铛界面.wdf"
    elseif ch == "超级神猪_普通" then
    	chs[1] = 0x05000009
        chs[2]  = 0x05000010
        chs[3] = "铃铛界面.wdf"
	elseif ch == "白熊_普通" then
		chs[1] = 0x0000C82C
        chs[2] = 0x0000E996
        chs[3] = "普通模型.wdf"
	elseif ch == "大蝙蝠_普通" then
		chs[1] = 0x000A02FB
        chs[2] = 0x000A2FAA
        chs[3] = "普通模型.wdf"
	elseif ch == "大海龟_普通" then
		chs[1] = 0x000AA917
        chs[2] = 0x000AD1C5
        chs[3] = "普通模型.wdf"
    elseif ch == "海星_普通" then
		chs[1] = 0x7260A22B
		chs[2] = 0x71253EE7
		chs[3] = "普通模型.wdf"
	elseif ch == "地狱战神_普通" then
		chs[1] = 0x000C22C0
        chs[2] = 0x000C5573
        chs[3] = "普通模型.wdf"
	elseif ch == "赌徒_普通" then
		chs[1] = 0x000C88C9
        chs[2] = 0x000CA948
        chs[3] = "普通模型.wdf"
	elseif ch == "风伯_普通" then
		chs[1] = 0x000CE315
        chs[2] = 0x000D0376
        chs[3] = "普通模型.wdf"
	elseif ch == "凤凰_普通" then
		chs[1] = 0x000D1F75
        chs[2] = 0x000D40BC
        chs[3] = "普通模型.wdf"
	elseif ch == "芙蓉仙子_普通" then
		chs[1] = 0x000D63B5
        chs[2] = 0x000D9587
        chs[3] = "普通模型.wdf"
	elseif ch == "蛤蟆精_普通" then
		chs[1] = 0x000DCED1
        chs[2] = 0x000DF77F
        chs[3] = "普通模型.wdf"
	elseif ch == "九头精怪_普通" then
		chs[1] = 0x00163F50
        chs[2] = 0x001677E7
        chs[3] = "普通模型.wdf"
	elseif ch == "猪八戒_普通" then
		chs[1] = 0x003145E1
        chs[2] = 0x003177B8
        chs[3] = "普通模型.wdf"
	elseif ch == "老虎_普通" then
		chs[1] = 0x0018CF66
        chs[2] = 0x0018EF6D
        chs[3] = "普通模型.wdf"
	elseif ch == "蛟龙_普通" then
		chs[1] = 0x0014EBFB
        chs[2] = 0x00150EEB
        chs[3] = "普通模型.wdf"
	elseif ch =="天将_普通" then
	    chs[1] = 0x002464D4
	    chs[2] = 0x002485DF
	    chs[3] = "普通模型.wdf"
	elseif ch =="如意仙子_普通" then
		chs[1] = 0x0020114F
		chs[2] = 0x002043F3
		chs[3] ="普通模型.wdf"
	elseif ch =="牛头_普通" then
		chs[1] = 0xE6E7DE44
		chs[2] = 0x7F2ABF21
		chs[3] ="普通模型.wdf"
	elseif ch =="黑熊_普通" then
		chs[1] = 0x00103EE5
		chs[2] = 0x00106090
		chs[3] ="普通模型.wdf"
	elseif ch =="小龙女_普通" then
		chs[1] = 0x0028395D
		chs[2] = 0x002861E3
		chs[3] ="普通模型.wdf"
	elseif ch =="花妖_普通" then
		chs[1] = 0x0012939F
		chs[2] = 0x0012B4FF
		chs[3] ="普通模型.wdf"
	elseif ch =="雨师_普通" then
		chs[1] = 0x002EF98A
		chs[2] = 0x002F1AD6
		chs[3] ="普通模型.wdf"
	elseif ch =="牛妖_普通" then
		chs[1] = 0xF58E06E8
		chs[2] = 0x5274F324
		chs[3] ="普通模型.wdf"
	elseif ch =="山贼_普通" then
		chs[1] = 0x0020BA8D
		chs[2] = 0x0020DC7E
		chs[3] ="普通模型.wdf"
	elseif ch =="护卫_普通" then
		chs[1] = 0x001257AC
		chs[2] = 0x001277B8
		chs[3] ="普通模型.wdf"
	elseif ch =="兔子怪_普通" then
		chs[1]=0x0024E0E4
		chs[2]=0x00250A3C
		chs[3] ="普通模型.wdf"
	elseif ch =="沙僧_普通"then
  		chs[1]=0x00207811
		chs[2]=0x00209E60
		chs[3] ="普通模型.wdf"
	elseif ch =="孙悟空_普通"then
  		chs[1]=0x00233BF4
		chs[2]=0x00236EE5
		chs[3] ="普通模型.wdf"
	elseif ch =="骷髅怪_普通"then
  		chs[1]=0x00178CE5
		chs[2]=0x0017B73C
		chs[3] ="普通模型.wdf"
	elseif ch =="黑山老妖_普通"then
  		chs[1]=0x000FF7CB
		chs[2]=0x00100BB9
		chs[3] ="普通模型.wdf"
	elseif ch =="僵尸_普通"then
  		chs[1]=0x00149FEC
		chs[2]=0x0014BFA3
		chs[3] ="普通模型.wdf"
	elseif ch =="马面_普通"then
  		chs[1]=0x001CD349
		chs[2]=0x001CF56C
		chs[3] ="普通模型.wdf"
	elseif ch =="黑熊精_普通"then
  		chs[1]=0x0010800D
		chs[2]=0x0010A8C5
		chs[3] ="普通模型.wdf"
	elseif ch =="龟丞相_普通"then
  		chs[1]=0x000F0A7D
		chs[2]=0x000F1B23
		chs[3] ="普通模型.wdf"
	elseif ch =="蜘蛛精_普通"then
  		chs[1]=0x00307F10
		chs[2]=0x0030A7C8
		chs[3] ="普通模型.wdf"
	elseif ch =="雷鸟人_普通"then
  		chs[1]=0x00192EE6
		chs[2]=0x001958AC
		chs[3] ="普通模型.wdf"
	elseif ch =="巡游天神_普通"then
  		chs[1]=0x002B1829
		chs[2]=0x002B4A82
		chs[3] ="普通模型.wdf"
	elseif ch =="羊头怪_普通"then
  		chs[1]=0x002C215B
		chs[2]=0x002C4AF4
		chs[3] ="普通模型.wdf"
	elseif ch =="虾兵_普通"then
  		chs[1]=0x00276F42
		chs[2]=0x002790A7
		chs[3] ="普通模型.wdf"
	elseif ch =="巨蛙_普通"then
  		chs[1]=0x00171011
		chs[2]=0x001731D5
		chs[3] ="普通模型.wdf"
	elseif ch =="树怪_普通"then
  		chs[1]=0x00224D37
		chs[2]=0x00226F32
		chs[3] ="普通模型.wdf"
	elseif ch =="星灵仙子_普通"then
  		chs[1]=0x002AAE7F
		chs[2]=0x002AE079
		chs[3] ="普通模型.wdf"
	elseif ch =="海毛虫_普通"then
  		chs[1]=0x000F8DAB
		chs[2]=0x000FB50A
		chs[3] ="普通模型.wdf"
	elseif ch =="野鬼_普通"then
  		chs[1]=0x002C8B95
		chs[2]=0x002CACC8
		chs[3] ="普通模型.wdf"
	elseif ch =="天兵_普通"then
  		chs[1]=0x002425D7
		chs[2]=0x00244827
		chs[3] ="普通模型.wdf"
	elseif ch =="蝴蝶仙子_普通"then
  		chs[1]=0x0012022B
		chs[2]=0x001234D9
		chs[3] ="普通模型.wdf"
	elseif ch =="蟹将_普通"then
  		chs[1]=0x002A6BDA
		chs[2]=0x002A8BF0
		chs[3] ="普通模型.wdf"
	elseif ch =="狐狸精_普通"then
  		chs[1]=0x001149EC
		chs[2]=0x00116B0E
		chs[3] ="普通模型.wdf"
	elseif ch =="古代瑞兽_普通"then
  		chs[1]=0x000E1D90
		chs[2]=0x000E4FB7
		chs[3] ="普通模型.wdf"
	elseif ch =="泡泡_普通"then
  		chs[1]=0x001E9944
		chs[2]=0x001EBB03
		chs[3] ="普通模型.wdf"
	-- elseif ch =="恶魔泡泡_普通"then
 --  		chs[1]="恶魔泡泡行走"
	-- 	chs[2]="恶魔泡泡站立"
	-- 	chs[3] ="新宝宝.gpk"
	-- elseif ch =="超级飞廉_普通"then
 --  		chs[1]="超级飞廉行走"
	-- 	chs[2]="超级飞廉站立"
	-- 	chs[3] ="新宝宝.gpk"
	-- elseif ch =="自在心猿_普通"then
 --  		chs[1]="自在心猿行走"
	-- 	chs[2]="自在心猿站立"
	-- 	chs[3] ="新宝宝.gpk"
	-- elseif ch =="进阶沙暴_普通"then
 --  		chs[1]="进阶沙暴奔跑"
	-- 	chs[2]="进阶沙暴站立"
	-- 	chs[3] ="新宝宝.gpk"
	-- elseif ch =="超级红孩儿_普通"then
 --  		chs[1]="红孩儿行走"
	-- 	chs[2]="红孩儿站立"
	-- 	chs[3] ="新宝宝.gpk"
	-- elseif ch =="超级神柚_普通"then
 --  		chs[1]="超级神柚站立"
	-- 	chs[2]="超级神柚行走"
	-- 	chs[3] ="新宝宝.gpk"

	elseif ch =="超级红孩儿_普通"then
		chs[1] = 0x10000002
		chs[2] = 0x10000004
		chs[3] ="xbb.wdf"
	elseif ch =="自在心猿_普通"then
		chs[1] = 0x20000012
		chs[2] = 0x20000012
		chs[3] ="xbb.wdf"
	elseif ch =="进阶沙暴_普通"then
		chs[1] = 0x00000236
		chs[2] = 0x00000237
		chs[3] ="xbb.wdf"
	elseif ch =="恶魔泡泡_普通"then
		chs[1] = 0x51E72D28
		chs[2] = 0x51E72D27
		chs[3] ="xbb.wdf"
	elseif ch =="超级飞廉_普通"then
	    chs[1]= 0xC0000045
		chs[2]= 0xC0000046
		chs[3] ="xbb.wdf"
	elseif ch =="超级神柚_普通"then
	    chs[1]= 0xC0000054
		chs[2]= 0xC0000053
		chs[3] ="xbb.wdf"









	elseif ch =="强盗_普通"then
  		chs[1]=0x001FB345
		chs[2]=0x001FD39C
		chs[3] ="普通模型.wdf"
	elseif ch =="野猪_普通"then
  		chs[1]=0x002CC94D
		chs[2]=0x002CEB11
		chs[3] ="普通模型.wdf"
	elseif ch =="狼_普通"then
  		chs[1]=0x00189DC7
		chs[2]=0x0018B6D5
		chs[3] ="普通模型.wdf"
	elseif ch =="小魔头_普通"then
  		chs[1]=0x0028F2F2
		chs[2]=0x0028FAB7
		chs[3] ="普通模型.wdf"
	elseif ch =="小精灵_普通"then
  		chs[1]=0x00280F19
		chs[2]=0x00281F21
		chs[3] ="普通模型.wdf"
	elseif ch =="小丫丫_普通"then
  		chs[1]=0x0029EAD3
		chs[2]=0x0029FAF1
		chs[3] ="普通模型.wdf"
	elseif ch =="小仙女_普通"then
  		chs[1]=0x002998E4
		chs[2]=0x0029A8DC
		chs[3] ="普通模型.wdf"
	elseif ch =="小仙灵_普通"then
  		chs[1]=0x0029466F
		chs[2]=0x00295719
		chs[3] ="普通模型.wdf"
	elseif ch =="小毛头_普通"then
  		chs[1]=0x0028AA99
		chs[2]=0x0028BA5F
		chs[3] ="普通模型.wdf"
	elseif ch =="幽灵_普通"then
  		chs[1]=0x002E62EB
		chs[2]=0x002E706D
		chs[3] ="普通模型.wdf"
	elseif ch =="龙龟_普通"then
  		chs[1]=0x001B87E1
		chs[2]=0x001BB7B0
		chs[3] ="普通模型.wdf"
	elseif ch =="灵符女娲_普通"then
		chs[1] = 0x001A5490
		chs[2] = 0x001A6862
		chs[3] ="普通模型.wdf"
	elseif ch =="净瓶女娲_普通"then
		chs[1] = 0x0015DE44
		chs[2] = 0x00161791
		chs[3] ="普通模型.wdf"
	elseif ch =="鬼将_普通"then
		chs[1] = 0x000F3A90
		chs[2] = 0x000F61EF
		chs[3] ="普通模型.wdf"
	elseif ch =="迭代鬼将_普通" or  ch =="进阶迭代鬼将_普通" then
		chs[1] = 0x00005170
		chs[2] = 0x00005172
		chs[3] ="anhebb.wdf"
    elseif ch =="青花瓷鬼将_普通"  then
		chs[1] = 0x00000071
		chs[2] = 0x00000071
		chs[3] ="靓号.wdf"

	elseif ch =="律法女娲_普通"then
		chs[1] = 0x001C6C83
		chs[2] = 0x001C7F71
		chs[3] ="普通模型.wdf"
	elseif ch =="蚩尤_普通"then
		chs[1] = 0x001D1273
		chs[2] = 0x001D423C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蚩尤_普通" or ch =="蚩尤魔影_普通" then
		chs[1] = 0xB547D6C5
		chs[2] = 0x84E89BDB
		chs[3] ="战斗模型.wdf"
	elseif ch =="吸血鬼_普通"then
		chs[1] = 0x0026556F
		chs[2] = 0x00266645
		chs[3] ="普通模型.wdf"
	elseif ch =="雾中仙_普通"then
		chs[1] = 0x0025BE13
		chs[2] = 0x0025E85B
		chs[3] ="普通模型.wdf"
	elseif ch =="大力金刚_普通"then
		chs[1] = 0x000AF74E
		chs[2] = 0x000B2821
		chs[3] ="普通模型.wdf"
    elseif ch =="迭代金刚_普通" or  ch =="进阶迭代金刚_普通" then
		chs[1] = 0x00000333
		chs[2] = 0x00000335
		chs[3] = "anhebb.wdf"
		----------------------
	elseif ch =="炎魔神_普通"then
		chs[1] = 0x002B7E5C
		chs[2] = 0x002BA7C8
		chs[3] ="普通模型.wdf"
	elseif ch =="夜罗刹_普通"then
		chs[1] = 0x002D5DA6
		chs[2] = 0x002D864F
		chs[3] ="普通模型.wdf"
	elseif ch =="灵鹤_普通"then
		chs[1] = 0x001A8B55
		chs[2] = 0x001AACE7
		chs[3] ="普通模型.wdf"
	elseif ch =="噬天虎_普通"then
		chs[1] = 0x0021941F
		chs[2] = 0x0021BCD2
		chs[3] ="普通模型.wdf"
	elseif ch =="狸_普通"then
		chs[1] = 0x3CDBAFB2
		chs[2] = 0x0E6210D6
		chs[3] ="普通模型.wdf"
	elseif ch =="蜃气妖_普通"then
		chs[1] = 0xA3F8CD7E
		chs[2] = 0x5E9E8FEE
		chs[3] ="普通模型.wdf"
	elseif ch =="蔓藤妖花_普通"then
		chs[1] = 0x6C4BB701
		chs[2] = 0x07F93745
		chs[3] ="普通模型.wdf"
	elseif ch =="曼珠沙华_普通"then
		chs[1] = 0x45ACDEDF
		chs[2] = 0x727FCE05
		chs[3] ="普通模型.wdf"
	elseif ch =="修罗傀儡鬼_普通"then
		chs[1] = 0xD70E1A23
		chs[2] = 0x4C5B945B
		chs[3] ="普通模型.wdf"
	elseif ch =="金身罗汉_普通"then
		chs[1] = 0x7B1F88D8
		chs[2] = 0xD2B03C99
		chs[3] ="普通模型.wdf"
	elseif ch =="修罗傀儡妖_普通"then
		chs[1] = 0x32FC3B00
		chs[2] = 0x658404D2
		chs[3] ="普通模型.wdf"
	elseif ch =="巴蛇_普通"then
		chs[1] = 0x000040E6
		chs[2] = 0x00004E30
		chs[3] ="普通模型.wdf"
	elseif ch =="百足将军_普通"then
		chs[1] = 0x00010C71
		chs[2] = 0x0001476C
		chs[3] ="普通模型.wdf"
	elseif ch =="蚌精_普通"then
		chs[1] = 0x0001DCA3
		chs[2] = 0x00020A49
		chs[3] ="普通模型.wdf"
	elseif ch =="碧水夜叉_普通"then
		chs[1] = 0x00022C44
		chs[2] = 0x00025C72
		chs[3] ="普通模型.wdf"
	elseif ch =="长眉灵猴_普通"then
		chs[1] = 0x0002B1F9
		chs[2] = 0x0002EB8C
		chs[3] ="普通模型.wdf"
	elseif ch =="红萼仙子_普通"then
		chs[1] = 0x0010CF0C
		chs[2] = 0x001115CC
		chs[3] ="普通模型.wdf"
	elseif ch =="葫芦宝贝_普通"then
		chs[1] = 0x00119839
		chs[2] = 0x0011D97A
		chs[3] ="普通模型.wdf"
	elseif ch =="画魂_普通"then
		chs[1] = 0x0012CF5C
		chs[2] = 0x0012F03B
		chs[3] ="普通模型.wdf"
	elseif ch =="知了王_普通"then
		chs[1] = 0x00131598
		chs[2] = 0x00134D87
		chs[3] ="普通模型.wdf"
	elseif ch =="混沌兽_普通"then
		chs[1] = 0x00137082
		chs[2] = 0x0001476C
		chs[3] ="普通模型.wdf"
	elseif ch =="机关鸟_普通"then
		chs[1] = 0x0013D041
		chs[2] = 0x0014032E
		chs[3] ="普通模型.wdf"
	elseif ch =="机关兽_普通"then
		chs[1] = 0x001426AB
		chs[2] = 0x0014594A
		chs[3] ="普通模型.wdf"
	elseif ch =="鲛人_普通"then
		chs[1] = 0x00152C66
		chs[2] = 0x00154F1A
		chs[3] ="普通模型.wdf"
	elseif ch =="锦毛貂精_普通"then
		chs[1] = 0x0015798D
		chs[2] = 0x0015AB7D
		chs[3] ="普通模型.wdf"
	elseif ch =="巨力神猿_普通"then
		chs[1] = 0x0016B31F
		chs[2] = 0x0016ED54
		chs[3] ="普通模型.wdf"
	elseif ch =="狂豹人形_普通"then
		chs[1] = 0x0017DABD
		chs[2] = 0x00181583
		chs[3] ="普通模型.wdf"
	elseif ch =="狂豹兽形_普通"then
		chs[1] = 0x00183914
		chs[2] = 0x0018746D
		chs[3] ="普通模型.wdf"
	elseif ch =="连弩车_普通"then
		chs[1] = 0x0019CE82
		chs[2] = 0x0018746D
		chs[3] ="普通模型.wdf"
	elseif ch =="猫灵人形_普通"then
		chs[1] = 0x001ACCFA
		chs[2] = 0x001B0806
		chs[3] ="普通模型.wdf"
	elseif ch =="猫灵兽形_普通"then
		chs[1] = 0x001B2BBF
		chs[2] = 0x001B675E
		chs[3] ="普通模型.wdf"
	elseif ch =="千年蛇魅_普通"then
		chs[1] = 0x001F4B2A
		chs[2] = 0x001F7347
		chs[3] ="普通模型.wdf"
	elseif ch =="远古神魔_普通"then
		chs[1] = 0x00211338
		chs[2] = 0x00213A77
		chs[3] ="普通模型.wdf"
	elseif ch =="鼠先锋_普通"then
		chs[1] = 0x0021FAC7
		chs[2] = 0x00222D0A
		chs[3] ="普通模型.wdf"
	elseif ch =="踏云兽_普通"then
		chs[1] = 0x00239210
		chs[2] = 0x0023CB2B
		chs[3] ="普通模型.wdf"
	elseif ch =="犀牛将军人形_普通"then
		chs[1] = 0x00268F98
		chs[2] = 0x0026C8D6
		chs[3] ="普通模型.wdf"
	elseif ch =="犀牛将军兽形_普通"then
		chs[1] = 0x002703E5
		chs[2] = 0x00273D8C
		chs[3] ="普通模型.wdf"
	elseif ch =="蝎子精_普通"then
		chs[1] = 0x002A1516
		chs[2] = 0x002A4D35
		chs[3] ="普通模型.wdf"
	elseif ch =="野猪精_普通"then
		chs[1] = 0x002D0AA2
		chs[2] = 0x002D3B53
		chs[3] ="普通模型.wdf"
	elseif ch =="阴阳伞_普通"then
		chs[1] = 0x002DBD1B
		chs[2] = 0x002DF812
		chs[3] ="普通模型.wdf"
	elseif ch =="幽萤娃娃_普通"then
		chs[1] = 0x002E91A0
		chs[2] = 0x002ED6B5
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶龙龟_普通"then
		chs[1] = 0x2933FC41
		chs[2] = 0xE38771B9
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶修罗傀儡鬼_普通"then
		chs[1] = 0x554EBB15
		chs[2] = 0xA49270BA
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶灵鹤_普通"then
		chs[1] = 0xB15E456E
		chs[2] = 0xDE8086CE
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶芙蓉仙子_普通"then
		chs[1] = 0x2206E612
		chs[2] = 0x96BC94AC
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶如意仙子_普通"then
		chs[1] = 0x2F00B37A
		chs[2] = 0x4198CF0C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶鲛人_普通"then
		chs[1] = 0x78ED4C3F
		chs[2] = 0x01D4B3DC
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶金身罗汉_普通"then
		chs[1] = 0x2D9806FA
		chs[2] = 0x73625A2A
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶大力金刚_普通"then
		chs[1] = 0xC875C4BE
		chs[2] = 0x02F7CD64
		chs[3] ="普通模型.wdf"

	elseif ch =="进阶蔓藤妖花_普通"then
		chs[1] = 0x7118D645
		chs[2] = 0xDC43CAD3
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶巨力神猿_普通"then
		chs[1] = 0x06B8518E
		chs[2] = 0x039BDA0E
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶巴蛇_普通"then
		chs[1] = 0x7A7EF4C7
		chs[2] = 0x6E93E040
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶红萼仙子_普通"then
		chs[1] = 0x0E997872
		chs[2] = 0xC5891CD4
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶鼠先锋_普通"then
		chs[1] = 0x89A1831C
		chs[2] = 0xE0DFA185
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶炎魔神_普通"then
		chs[1] = 0x9F3AE035
		chs[2] = 0x32EA9C0B
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶曼珠沙华_普通"then
		chs[1] = 0x886801BB
		chs[2] = 0xD8E30A74
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶地狱战神_普通"then
		chs[1] = 0x6B19D682
		chs[2] = 0x0A0351C4
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蚌精_普通"then
		chs[1] = 0x31454554
		chs[2] = 0x50DB2F65
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶风伯_普通"then
		chs[1] = 0x21E83685
		chs[2] = 0x5D4A0DA2
		chs[3] ="普通模型.wdf"

	elseif ch =="进阶葫芦宝贝_普通"then
		chs[1] = 0x586B462C
		chs[2] = 0x36A02292
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶修罗傀儡妖_普通"then
		chs[1] = 0x9ADB6CAC
		chs[2] = 0x6783BDA7
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶凤凰_普通"then
		chs[1] = 0x8AE90761
		chs[2] = 0xDA528ED1
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶长眉灵猴_普通"then
		chs[1] = 0x4D9B1187
		chs[2] = 0xC14B977D
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶幽萤娃娃_普通"then
		chs[1] = 0x11FF6780
		chs[2] = 0x3A093FAF
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶巡游天神_普通"then
		chs[1] = 0x0F27607E
		chs[2] = 0x447F4F60
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶混沌兽_普通"then
		chs[1] = 0x87E78098
		chs[2] = 0x2E8D1286
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶野猪精_普通"then
		chs[1] = 0x91BB8E60
		chs[2] = 0x977F1043
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶犀牛将军兽形_普通"then
		chs[1] = 0x48D01363
		chs[2] = 0x605E3B33
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶机关人_普通"then
		chs[1] = 0xE05C3F97
		chs[2] = 0xE3E7268D
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶古代瑞兽_普通"then
		chs[1] = 0x1798EA00
		chs[2] = 0x2C2FA1CA
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶碧水夜叉_普通"then
		chs[1] = 0x1EDA1CD8
		chs[2] = 0xC2B09D04
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶黑山老妖_普通"then
		chs[1] = 0x94258F07
		chs[2] = 0xFA5075B4
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶雨师_普通"then
		chs[1] = 0x7D912078
		chs[2] = 0x18EF6634
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶龙龟_普通"then
		chs[1] = 0x2933FC41
		chs[2] = 0xE38771B9
		chs[3] ="普通模型.wdf"
	elseif ch =="真陀护法_普通"then
		chs[1] = 0x06B907B8
		chs[2] = 0x2D2984EB
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶阴阳伞_普通"then
		chs[1] = 0x1AFDC3F6
		chs[2] = 0x45F9345B
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶净瓶女娲_普通"then
		chs[1] = 0x1B5425E6
		chs[2] = 0xE6E208F4
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶机关鸟_普通"then
		chs[1] = 0x7FBF3FBC
		chs[2] = 0x557E8420
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶天兵_普通"then
		chs[1] = 0x263409F7
		chs[2] = 0x5F4DDF7F
		chs[3] ="普通模型.wdf"
	elseif ch =="新手召唤兽_普通"then
		chs[1]=0x000F0A7D
		chs[2]=0x000F1B23
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶噬天虎_普通"then
		chs[1] = 0x4B31B9DB
		chs[2] = 0x88628ABC
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶百足将军_普通"then
		chs[1] = 0x358DCB43
		chs[2] = 0x6F6B53A9
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶天将_普通"then
		chs[1] = 0x236C7E78
		chs[2] = 0x2F969199
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶星灵仙子_普通"then
		chs[1] = 0x75E24AAD
		chs[2] = 0x9DB4E74E
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蜃气妖_普通"then
		chs[1] = 0x304CE44C
		chs[2] = 0xF4DD7911
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶鬼将_普通"then
		chs[1] = 0x275E43D0
		chs[2] = 0xBD7075E0
		chs[3] ="普通模型.wdf"

	elseif ch =="进阶狂豹人形_普通"then
		chs[1] = 0xE9E47BF8
		chs[2] = 0xEA42D997
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶踏云兽_普通"then
		chs[1] = 0x4B1AAA96
		chs[2] = 0x4194B6ED
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶白熊_普通"then
		chs[1] = 0x456ED9AE
		chs[2] = 0xC2E91BB6
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶机关兽_普通"then
		chs[1] = 0x3C4007F5
		chs[2] = 0x729B428B
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蝎子精_普通"then
		chs[1] = 0xC433446F
		chs[2] = 0x3295E9E7
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蛟龙_普通"then
		chs[1] = 0xA3DA0874
		chs[2] = 0x768EC51E
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶千年蛇魅_普通"then
		chs[1] = 0xA14F4A62
		chs[2] = 0xA4AC72C1
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶犀牛将军人形_普通"then
		chs[1] = 0xB1156F73
		chs[2] = 0xCFFE9FB9
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶锦毛貂精_普通"then
		chs[1] = 0x99544991
		chs[2] = 0x8CFB251C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶夜罗刹_普通"then
		chs[1] = 0x9FB38604
		chs[2] = 0xC5A45B35
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶幽灵_普通"then
		chs[1] = 0x5990A7C9
		chs[2] = 0x3D0C212C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶雷鸟人_普通"then
		chs[1] = 0x20393E62
		chs[2] = 0x1281D163
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶律法女娲_普通"then
		chs[1] = 0x6275654E
		chs[2] = 0x1CB46D32
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶吸血鬼_普通"then
		chs[1] = 0x573B321A
		chs[2] = 0xCE5EB1D9
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶蝴蝶仙子_普通"then
		chs[1] = 0x40267F4C
		chs[2] = 0xA07F8533
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶画魂_普通"then
		chs[1] = 0xBAEE2ABE
		chs[2] = 0x42260944
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶雾中仙_普通"then
		chs[1] = 0x2D88FD84
		chs[2] = 0x83538E76
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶灵符女娲_普通"then
		chs[1] = 0xC07F9136
		chs[2] = 0xB0A1E3E5
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶金铙僧_普通"then
		chs[1] = 0x8D076633
		chs[2] = 0x3418E55B
		chs[3] ="普通模型.wdf"
	elseif ch =="镜妖_普通"then
		chs[1] = 0x41CADB40
		chs[2] = 0x218810C3
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶镜妖_普通"then
		chs[1] = 0xB57EB974
		chs[2] = 0xDCAF8298
		chs[3] ="普通模型.wdf"
	elseif ch =="金铙僧_普通"then
		chs[1] = 0x8631C2B1
		chs[2] = 0x9B3CF0EA
		chs[3] ="普通模型.wdf"
	elseif ch =="泪妖_普通"then
		chs[1] = 0x27BECE4E
		chs[2] = 0x147F84A6
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶泪妖_普通"then
		chs[1] = 0x13F0C5C2
		chs[2] = 0x6272607D
		chs[3] ="普通模型.wdf"
	elseif ch =="增长巡守_普通"then
		chs[1] = 0x1E06D7E8
		chs[2] = 0xC0FCC4AE
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶增长巡守_普通"then
		chs[1] = 0x1E06D7E8
		chs[2] = 0xC0FCC4AE
		chs[3] ="战斗模型.wdf"
	elseif ch =="持国巡守_普通"then
		chs[1] = 0x45763667
		chs[2] = 0xCCC693A8
		chs[3] ="普通模型.wdf"
	elseif ch =="般若天女_普通"then
		chs[1] = 0x3E01B3D0
		chs[2] = 0x7DFE4872
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶般若天女_普通"then
		chs[1] = 0x78B01CF9
		chs[2] = 0x6A0FF793
		chs[3] ="普通模型.wdf"
	elseif ch =="灵灯侍者_普通"then
		chs[1] = 0x5723E136
		chs[2] = 0xD06B232C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶灵灯侍者_普通"then
		chs[1] = 0x8B46AE73
		chs[2] = 0x6C8D5D7F
		chs[3] ="普通模型.wdf"
	elseif ch =="琴仙_普通"then
		chs[1] = 0x23944B4F
		chs[2] = 0x0C1E363C
		chs[3] ="普通模型.wdf"
	elseif ch =="进阶琴仙_普通"then
		chs[1] = 0x24E7E45C
		chs[2] = 0x5E0B0694
		chs[3] ="普通模型.wdf"
	elseif ch == "超级腾蛇_普通" then
		chs[1] = 0x277A9966
        chs[2] = 0x8CFB271D
        chs[3] = "普通模型.wdf"
	elseif ch =="超级神鸡_普通"then
		chs[1] = 0x2BDAF419
		chs[2] = 0x82EEF8AD
		chs[3] ="普通模型.wdf"
	elseif ch =="超级土地公公_普通"then
		chs[1] = 0xC41A7327
		chs[2] = 0x29576B3D
		chs[3] ="战斗模型.wdf"
	elseif ch == "武器_进阶猫灵人形_普通" then
		chs[1] = 0xA12B4BDC
		chs[2] = 0xA12B4BDC
		chs[4] = 0xA12B4BDC
		chs[3] = "普通模型.wdf"
	elseif ch == "进阶猫灵人形_普通" then
		chs[1] = 0xD7ADADFC
		chs[2] = 0xD7ADADFC
		chs[4] = 0xD7ADADFC
		chs[3] = "普通模型.wdf"
	elseif ch == "进阶猫灵兽形_普通" then
		chs[1] = 0x5D711007
		chs[2] = 0x0580F3FE
		chs[3] = "战斗模型.wdf"

	elseif ch =="超级人参娃娃_普通"then
		chs[1] = 0x2BC67A5F
		chs[2] = 0xB3BE1374
		chs[3] ="普通模型.wdf"
	elseif ch =="超级筋斗云_普通"then
		chs[1] = 0x02379071
		chs[2] = 0x256F1AF4
		chs[3] ="普通模型.wdf"
	elseif ch =="超级大鹏_普通"then
		chs[1] = 0x3AF99E76
		chs[2] = 0x8A6EB7CC
		chs[3] ="普通模型.wdf"
	elseif ch =="超级麒麟_普通"then
		chs[1] = 0xFF1A400D
		chs[2] = 0x3F2F2665
		chs[3] ="普通模型.wdf"
	elseif ch =="超级孔雀_普通"then
		chs[1] = 0x6A788030
		chs[2] = 0xDD1B6B4A
		chs[3] ="普通模型.wdf"
	elseif ch =="超级大熊猫_普通"then
		chs[1] = 0x24EAC80D
		chs[2] = 0xD1BDA75F
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神马_普通"then
		chs[1] = 0x7F354CC7
		chs[2] = 0xC198AE91
		chs[3] ="普通模型.wdf"
	elseif ch =="超级六耳猕猴_普通"then
		chs[1] = 0x0D9EBABC
		chs[2] = 0xDE8F6E5A
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神龙_普通"then
		chs[1] = 0x5FF3EEFD
		chs[2] = 0x3B42F8B4
		chs[3] ="普通模型.wdf"
	elseif ch =="超级大象_普通"then
		chs[1] = 0x8E5B6E48
		chs[2] = 0xD26F85A4
		chs[3] ="普通模型.wdf"
	elseif ch =="超级金猴_普通"then
		chs[1] = 0x5CFB35A4
		chs[2] = 0x2A76AF8E
		chs[3] ="普通模型.wdf"
	elseif ch =="超级泡泡_普通"then
		chs[1] = 0xE2D684A7
		chs[2] = 0xAFEE30DC
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神羊_普通"then
		chs[1] = 0x2296B535
		chs[2] = 0xBF961C95
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神虎_普通"then
		chs[1] = 0x1174DEC2
		chs[2] = 0xDE5B6EB0
		chs[3] ="普通模型.wdf"
	elseif ch =="超级青鸾_普通"then
		chs[1] = 0xC1E9A273
		chs[2] = 0xC369D5F9
		chs[3] ="普通模型.wdf"
	elseif ch =="超级赤焰兽_普通"then
		chs[1] = 0x183AB443
		chs[2] = 0x2B9DCF67
		chs[3] ="普通模型.wdf"
	elseif ch =="超级白泽_普通"then
		chs[1] = 0xDE06522C
		chs[2] = 0xA45E50B2
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神蛇_普通"then
		chs[1] = 0x6EA5597F
		chs[2] = 0x9911DED2
		chs[3] ="普通模型.wdf"
	elseif ch =="超级海豚_普通"then
		chs[1] = 0x4B592393
		chs[2] = 0x84D2F6B7
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神兔_普通"then
		chs[1] = 0xF9777AA1
		chs[2] = 0x54370885
		chs[3] ="普通模型.wdf"

	elseif ch =="超级灵鹿_普通"then
		chs[1] = 0x49578F89
		chs[2] = 0xCAC235C1
		chs[3] ="普通模型.wdf"
	elseif ch =="超级神牛_普通"then
		chs[1] = 0xA9C5802F
		chs[2] = 0xB068D594
		chs[3] ="普通模型.wdf"
	elseif ch == "超级神猴_普通" then
		chs[1] = 0x14692807
        chs[2] = 0xCCAC3F69
        chs[3] = "普通模型.wdf"
    elseif ch == "超级腾蛇_普通" then
		chs[1] = 0x277A9966
        chs[2] = 0x8CFB271D
        chs[3] = "普通模型.wdf"
    elseif ch == "周杰伦_普通" then
		chs[1] = 0x5DACE991
        chs[2] = 0x1E12FFC4
        chs[3] = "普通模型.wdf"
  elseif ch == "木桩_普通" then
		chs[1] = 0x00000002
	    chs[2] = 0x00000002
	    chs[3] = "xcwsc.wdf"
    elseif ch == "普智_普通" then
    	chs[1] = 0x00000214--静立
		chs[2]= 0x00000210--跑
		chs[3] = "素材修复.wdf"
	elseif ch == "花无缺_普通" then
	   chs[1] = 0x00000114--静立
	   chs[2] = 0x00000109--跑
	   chs[3] = "素材修复.wdf"

	elseif ch == "吕布_普通" then
		chs[1] = 0x00000202--静立
		chs[2] = 0x00000197--跑
		chs[3] = "素材修复.wdf"
	elseif ch == "剑圣_普通" then
		chs[2]= 0x00000121--跑
		chs[1] = 0x00000126--静立
		chs[3] = "素材修复.wdf"
    elseif ch == "关羽_普通" then
		chs[1] = 0x00000096--静立
		chs[2] = 0x00000091--跑
		chs[3] = "素材修复.wdf"
    elseif ch == "召唤兽造型进阶_普通" then
		chs[1] = 0x9C565325--静立
		chs[2] = 0x30B204B2--跑
		chs[3] = "房屋图标.wdf"
    elseif ch == "小小盲僧_普通" then
    	chs[1] = 0x00000076--静立
		chs[2]= 0x00000078--跑
		chs[3] = "靓号.wdf"
    elseif ch == "盲僧眼珠_普通" then
    	chs[1] = 0x00000083--静立
		chs[2]= 0x00000085--跑
		chs[3] = "靓号.wdf"



	---------------------------------------------------人物施法攻击特效

	elseif ch == "青铜短剑_偃无师_普通" then
		chs[1] = 0xA3A53EE1
		chs[2] = 0x5FCB90C5
		chs[3] = "audio/1222.mp3"
	elseif ch == "青锋剑_偃无师_普通" then
		chs[1] = 0x184828C5
		chs[2] = 0x85F1E16F
		chs[3] = "audio/1222.mp3"
	elseif ch == "游龙剑_偃无师_普通" then
		chs[1] = 0x421AA16F
		chs[2] = 0x06552D73
		chs[3] = "audio/1222.mp3"
	elseif ch == "鱼肠_偃无师_普通" then
		chs[1] = 0x6FBAB8B7
		chs[2] = 0xC4278104
		chs[3] = "audio/1222.mp3"
	elseif ch == "倚天_偃无师_普通" then
		chs[1] = 0x0FFBAC97
		chs[2] = 0x283E8C79
		chs[3] = "audio/1222.mp3"
	elseif ch == "湛卢_偃无师_普通" then
		chs[1] = 0x536861B9
		chs[2] = 0x7E265C51
		chs[3] = "audio/1222.mp3"
	elseif ch == "魏武青虹_偃无师_普通" then
		chs[1] = 0xFDD3ECBB
		chs[2] = 0x2E4C5BA9
		chs[3] = "audio/1222.mp3"
	elseif ch == "灵犀神剑_偃无师_普通" then
		chs[1] = 0xFDD5C98E
		chs[2] = 0x30E9FB89
		chs[3] = "audio/1222.mp3"
	elseif ch == "四法青云_偃无师_普通" then
		chs[1] = 0x8AC69053
		chs[2] = 0xEF01B789
		chs[3] = "audio/1222.mp3"
	elseif ch == "霜冷九州_偃无师_普通" then
		chs[1] = 0x48224B34
		chs[2] = 0x6B9319A9
		chs[3] = "audio/1222.mp3"
	elseif ch == "擒龙_偃无师_普通" then
		chs[1] = 0x66D72341
		chs[2] = 0x9D706607
		chs[3] = "audio/1222.mp3"
    elseif ch == "五色缎带_桃夭夭_普通" then
		chs[1] = 0xACFD4797
		chs[2] = 0xEE59D055
		chs[3] = "audio/1222.mp3"
	elseif ch == "无极丝_桃夭夭_普通" then
		chs[1] = 0x6AFC59F7
		chs[2] = 0x32736853
		chs[3] = "audio/1222.mp3"
	elseif ch == "七彩罗刹_桃夭夭_普通" then
		chs[1] = 0x0EC2CE1B
		chs[2] = 0x109AC390
		chs[3] = "audio/1222.mp3"
	elseif ch == "彩虹_桃夭夭_普通" then
		chs[1] = 0x5FCCE5D5
		chs[2] = 0x55516619
		chs[3] = "audio/1222.mp3"
	elseif ch == "流云_桃夭夭_普通" then
		chs[1] = 0x51A9F58B
		chs[2] = 0xEF3A3A78
		chs[3] = "audio/1222.mp3"
	elseif ch == "碧波_桃夭夭_普通" then
		chs[1] = 0x800185FA
		chs[2] = 0xF56C2C31
		chs[3] = "audio/1222.mp3"
	elseif ch == "秋水落霞_桃夭夭_普通" then
		chs[1] = 0x79FE3E9D
		chs[2] = 0xFBA71A70
		chs[3] = "audio/1222.mp3"
	elseif ch == "晃金仙绳_桃夭夭_普通" then
		chs[1] = 0xF4C0C1F6
		chs[2] = 0xA7546F17
		chs[3] = "audio/1222.mp3"
	elseif ch == "此最相思_桃夭夭_普通" then
		chs[1] = 0x8700D110
		chs[2] = 0xBB8F8820
		chs[3] = "audio/1222.mp3"
	elseif ch == "揽月摘星_桃夭夭_普通" then
		chs[1] = 0xCE670726
		chs[2] = 0xD3DAC606
		chs[3] = "audio/1222.mp3"
	elseif ch == "九霄_桃夭夭_普通" then
		chs[1] = 0xD196466D
		chs[2] = 0x48D96197
		chs[3] = "audio/1222.mp3"
	elseif ch == "铁爪_鬼潇潇_普通" then
		chs[1] = 0x2F5A4D48
		chs[2] = 0xCB494EF8
		chs[3] = "audio/1222.mp3"
	elseif ch == "青龙牙_鬼潇潇_普通" then
		chs[1] = 0xC4598E51
		chs[2] = 0x9091BFCB
		chs[3] = "audio/1222.mp3"
	elseif ch == "青刚刺_鬼潇潇_普通" then
		chs[1] = 0x64EA234B
		chs[2] = 0x59BE69A2
		chs[3] = "audio/1222.mp3"
	elseif ch == "撕天_鬼潇潇_普通" then
		chs[1] = 0xDDD2427E
		chs[2] = 0x9F8667CD
		chs[3] = "audio/1222.mp3"
	elseif ch == "毒牙_鬼潇潇_普通" then
		chs[1] = 0xEFA1B021
		chs[2] = 0x32EA26BB
		chs[3] = "audio/1222.mp3"
	elseif ch == "胭脂_鬼潇潇_普通" then
		chs[1] = 0x71917206
		chs[2] = 0xE178F1F8
		chs[3] = "audio/1222.mp3"
	elseif ch == "九阴勾魂_鬼潇潇_普通" then
		chs[1] = 0xDDB52DE7
		chs[2] = 0xD3BA6091
		chs[3] = "audio/1222.mp3"
	elseif ch == "雪蚕之刺_鬼潇潇_普通" then
		chs[1] = 0x95535295
		chs[2] = 0x6294455A
		chs[3] = "audio/1222.mp3"
	elseif ch == "贵霜之牙_鬼潇潇_普通" then
		chs[1] = 0x67455B85
		chs[2] = 0x8BC6755F
		chs[3] = "audio/1222.mp3"
	elseif ch == "忘川三途_鬼潇潇_普通" then
		chs[1] = 0xA227EAE0
		chs[2] = 0x517613B8
		chs[3] = "audio/1222.mp3"
	elseif ch == "离钩_鬼潇潇_普通" then
		chs[1] = 0x27BFA1CB
		chs[2] = 0x540C068E
		chs[3] = "audio/1222.mp3"
	elseif ch == "银两_普通" then
		chs[1] = 0xC880FF79
		chs[2] = 0xC880FF79
		chs[3] =  "普通模型.wdf"
	elseif ch == "食物_普通" then
		chs[1] =  0xCEC4E67F
		chs[2] =  0xCEC4E67F
		chs[3] =  "普通模型.wdf"
	elseif ch == "口粮_普通" then
		chs[1] =  0xD13C14A1
		chs[2] =  0xD13C14A1
		chs[3] =  "普通模型.wdf"
	elseif ch == "摄妖香_普通" then
		chs[1] =  0x7FC3DE36
		chs[2] =  0x7FC3DE36
		chs[3] =  "普通模型.wdf"
	elseif ch == "药品_普通" then
		chs[1] =  0x66CC7A29
		chs[2] =  0x66CC7A29
		chs[3] =  "普通模型.wdf"


	elseif ch == "炼丹炉_普通" then
		chs[1] = 0x79F8AA95
		chs[2] = 0x79F8AA95
		chs[3] = "物品图标.wdf"
	--剧情动作
	elseif ch == "狸攻击_普通" then
		chs[1] = 0xB6DB9CCB
		chs[2] = 0xB6DB9CCB
		chs[3] = "战斗模型.wdf"
	elseif ch == "家具_桌子_普通" then
		chs[1] = 0x000799C4
		chs[2] = 0x000799C4
		chs[3] = "铃铛界面.wdf"
	elseif ch == "英女侠_倒下_普通" then
		chs[1] = 0x20D42CE0
		chs[2] = 0x20D42CE0
		chs[3] = "战斗模型.wdf"
	elseif ch == "影精灵_普通" then
		chs[1] = 0x10000323---站立
		chs[2] = 0x10000321--行走
		chs[3] = "yjlsc.wdf"
	elseif ch == "影精灵_双斧" then
		chs[1] = 0x10000323
		chs[2] = 0x10000321
		chs[3] = "yjlsc.wdf"
	elseif ch == "影精灵_魔棒" then
		chs[1] = 0x10000314
		chs[2] = 0x10000312
		chs[3] = "yjlsc.wdf"
	elseif ch == "影精灵_爪刺" then
		chs[1] = 0x10000332
		chs[2] = 0x10000330
		chs[3] = "yjlsc.wdf"



	elseif ch == "细木棒_影精灵_普通" then
	chs[1] = 0x10000398
	chs[2] = 0x10000397
	chs[3] = "yjlsc.wdf"
	elseif ch == "金丝魔棒_影精灵_普通" then
	chs[1] = 0x10000398
	chs[2] = 0x10000397
	chs[3] = "yjlsc.wdf"
	elseif ch == "玉如意_影精灵_普通" then
	chs[1] = 0x10000398
	chs[2] = 0x10000397
	chs[3] = "yjlsc.wdf"

	elseif ch == "点金棒_影精灵_普通" then
	chs[1] = 0x10000452
	chs[2] = 0x10000451
	chs[3] = "yjlsc.wdf"
	elseif ch == "云龙棒_影精灵_普通" then
	chs[1] = 0x10000452
	chs[2] = 0x10000451
	chs[3] = "yjlsc.wdf"
	elseif ch == "幽路引魂_影精灵_普通" then
	chs[1] = 0x10000452
	chs[2] = 0x10000451
	chs[3] = "yjlsc.wdf"
	elseif ch == "满天星_影精灵_普通" then
	chs[1] = 0x10000514
	chs[2] = 0x10000513
	chs[3] = "yjlsc.wdf"
	elseif ch == "水晶棒_影精灵_普通" then
	chs[1] = 0x10000514
	chs[2] = 0x10000513
	chs[3] = "yjlsc.wdf"
	elseif ch == "日月光华_影精灵_普通" then
	chs[1] = 0x10000514
	chs[2] = 0x10000513
	chs[3] = "yjlsc.wdf"
	elseif ch == "沧海_影精灵_普通" then
	chs[1] = 0x10000624
	chs[2] = 0x10000623
	chs[3] = "yjlsc.wdf"
	elseif ch == "红莲_影精灵_普通" then
	chs[1] = 0x10000670
	chs[2] = 0x10000669
	chs[3] = "yjlsc.wdf"
	elseif ch == "盘龙_影精灵_普通" then
	chs[1] = 0x10000014
	chs[2] = 0x10000013
	chs[3] = "yjlsc.wdf"
	elseif ch == "降魔玉杵_影精灵_普通" then
	chs[1] = 0x10000064
	chs[2] = 0x10000063
	chs[3] = "yjlsc.wdf"
	elseif ch == "青藤玉树_影精灵_普通" then
	chs[1] = 0x10000114
	chs[2] = 0x10000113
	chs[3] = "yjlsc.wdf"
	elseif ch == "墨玉骷髅_影精灵_普通" then
	chs[1] = 0x10000164
	chs[2] = 0x10000163
	chs[3] = "yjlsc.wdf"
	elseif ch == "丝萝乔木_影精灵_普通" then
	chs[1] = 0x10000214
	chs[2] = 0x10000213
	chs[3] = "yjlsc.wdf"
	elseif ch == "醍醐_影精灵_普通" then
	chs[1] = 0x10000264
	chs[2] = 0x10000263
	chs[3] = "yjlsc.wdf"






	elseif ch == "铁爪_影精灵_普通" then
	chs[1] = 0x10000434
	chs[2] = 0x10000433
	chs[3] = "yjlsc.wdf"
	elseif ch == "天狼爪_影精灵_普通" then
	chs[1] = 0x10000434
	chs[2] = 0x10000433
	chs[3] = "yjlsc.wdf"
	elseif ch == "幽冥鬼爪_影精灵_普通" then
	chs[1] = 0x10000434
	chs[2] = 0x10000433
	chs[3] = "yjlsc.wdf"
	elseif ch == "青龙牙_影精灵_普通" then
	chs[1] = 0x10000486
	chs[2] = 0x10000485
	chs[3] = "yjlsc.wdf"
	elseif ch == "勾魂爪_影精灵_普通" then
	chs[1] = 0x10000486
	chs[2] = 0x10000485
	chs[3] = "yjlsc.wdf"
	elseif ch == "玄冰刺_影精灵_普通" then
	chs[1] = 0x10000486
	chs[2] = 0x10000485
	chs[3] = "yjlsc.wdf"
	elseif ch == "青刚刺_影精灵_普通" then
	chs[1] = 0x10000550
	chs[2] = 0x10000549
	chs[3] = "yjlsc.wdf"
	elseif ch == "华光刺_影精灵_普通" then
	chs[1] = 0x10000550
	chs[2] = 0x10000549
	chs[3] = "yjlsc.wdf"
	elseif ch == "龙鳞刺_影精灵_普通" then
	chs[1] = 0x10000550
	chs[2] = 0x10000549
	chs[3] = "yjlsc.wdf"
	elseif ch == "撕天_影精灵_普通" then
	chs[1] = 0x10000660
	chs[2] = 0x10000659
	chs[3] = "yjlsc.wdf"
	elseif ch == "毒牙_影精灵_普通" then
	chs[1] = 0x10000706
	chs[2] = 0x10000705
	chs[3] = "yjlsc.wdf"
	elseif ch == "胭脂_影精灵_普通" then
	chs[1] = 0x10000050
	chs[2] = 0x10000049
	chs[3] = "yjlsc.wdf"
	elseif ch == "九阴勾魂_影精灵_普通" then
	chs[1] = 0x10000100
	chs[2] = 0x10000099
	chs[3] = "yjlsc.wdf"
	elseif ch == "雪蚕之刺_影精灵_普通" then
	chs[1] = 0x10000150
	chs[2] = 0x10000149
	chs[3] = "yjlsc.wdf"
	elseif ch == "贵霜之牙_影精灵_普通" then
	chs[1] = 0x10000200
	chs[2] = 0x10000199
	chs[3] = "yjlsc.wdf"
	elseif ch == "忘川三途_影精灵_普通" then
	chs[1] = 0x10000250
	chs[2] = 0x10000249
	chs[3] = "yjlsc.wdf"
	elseif ch == "离钩_影精灵_普通" then
	chs[1] = 0x10000300
	chs[2] = 0x10000299
	chs[3] = "yjlsc.wdf"


	elseif ch == "顽石双斧(乾)_影精灵_普通" then
	chs[1] = 0x10000411
	chs[2] = 0x10000410
	chs[3] = "yjlsc.wdf"
	elseif ch == "顽石双斧(坤)_影精灵_普通" then
	chs[1] = 0x10000424
	chs[2] = 0x10000423
	chs[3] = "yjlsc.wdf"
	elseif ch == "镔铁双斧(乾)_影精灵_普通" then
	chs[1] = 0x10000411
	chs[2] = 0x10000410
	chs[3] = "yjlsc.wdf"
	elseif ch == "镔铁双斧(坤)_影精灵_普通" then
	chs[1] = 0x10000424
	chs[2] = 0x10000423
	chs[3] = "yjlsc.wdf"
	elseif ch == "黑曜双斧(乾)_影精灵_普通" then
	chs[1] = 0x10000411
	chs[2] = 0x10000410
	chs[3] = "yjlsc.wdf"
	elseif ch == "黑曜双斧(坤)_影精灵_普通" then--20
	chs[1] = 0x10000424
	chs[2] = 0x10000423
	chs[3] = "yjlsc.wdf"

	elseif ch == "枭首双斧(乾)_影精灵_普通" then
	chs[1] = 0x10000465
	chs[2] = 0x10000464
	chs[3] = "yjlsc.wdf"
	elseif ch == "枭首双斧(坤)_影精灵_普通" then--20
	chs[1] = 0x10000478
	chs[2] = 0x10000477
	chs[3] = "yjlsc.wdf"

    elseif ch == "破军双斧(乾)_影精灵_普通" then
	chs[1] = 0x10000465
	chs[2] = 0x10000464
	chs[3] = "yjlsc.wdf"
	elseif ch == "破军双斧(坤)_影精灵_普通" then--20
	chs[1] = 0x10000478
	chs[2] = 0x10000477
	chs[3] = "yjlsc.wdf"

    elseif ch == "隳城双戚(乾)_影精灵_普通" then
	chs[1] = 0x10000465
	chs[2] = 0x10000464
	chs[3] = "yjlsc.wdf"
	elseif ch == "隳城双戚(坤)_影精灵_普通" then--20
	chs[1] = 0x10000478
	chs[2] = 0x10000477
	chs[3] = "yjlsc.wdf"

    elseif ch == "飞头蛮(乾)_影精灵_普通" then
	chs[1] = 0x10000527
	chs[2] = 0x10000526
	chs[3] = "yjlsc.wdf"
	elseif ch == "飞头蛮(坤)_影精灵_普通" then--20
	chs[1] = 0x10000540
	chs[2] = 0x10000539
	chs[3] = "yjlsc.wdf"

   elseif ch == "竹叶青(乾)_影精灵_普通" then
	chs[1] = 0x10000563
	chs[2] = 0x10000562
	chs[3] = "yjlsc.wdf"
	elseif ch == "竹叶青(坤)_影精灵_普通" then--20
	chs[1] = 0x10000576
	chs[2] = 0x10000575
	chs[3] = "yjlsc.wdf"

   elseif ch == "鲛煞(乾)_影精灵_普通" then
	chs[1] = 0x10000597
	chs[2] = 0x10000596
	chs[3] = "yjlsc.wdf"
	elseif ch == "鲛煞(坤)_影精灵_普通" then--20
	chs[1] = 0x10000610
	chs[2] = 0x10000609
	chs[3] = "yjlsc.wdf"
   elseif ch == "啖月(乾)_影精灵_普通" then
	chs[1] = 0x10000637
	chs[2] = 0x10000636
	chs[3] = "yjlsc.wdf"
	elseif ch == "啖月(坤)_影精灵_普通" then--20
	chs[1] = 0x10000650
	chs[2] = 0x10000649
	chs[3] = "yjlsc.wdf"
   elseif ch == "义战(乾)_影精灵_普通" then
	chs[1] = 0x10000683
	chs[2] = 0x10000682
	chs[3] = "yjlsc.wdf"
	elseif ch == "义战(坤)_影精灵_普通" then--20
	chs[1] = 0x10000696
	chs[2] = 0x10000695
	chs[3] = "yjlsc.wdf"
   elseif ch == "恶来(乾)_影精灵_普通" then
	chs[1] = 0x10000027
	chs[2] = 0x10000026
	chs[3] = "yjlsc.wdf"
	elseif ch == "恶来(坤)_影精灵_普通" then--20
	chs[1] = 0x10000040
	chs[2] = 0x10000039
	chs[3] = "yjlsc.wdf"
   elseif ch == "烬世野火(乾)_影精灵_普通" then
	chs[1] = 0x10000077
	chs[2] = 0x10000076
	chs[3] = "yjlsc.wdf"
	elseif ch == "烬世野火(坤)_影精灵_普通" then--20
	chs[1] = 0x10000090
	chs[2] = 0x10000089
	chs[3] = "yjlsc.wdf"
   elseif ch == "九州海沸(乾)_影精灵_普通" then
	chs[1] = 0x10000127
	chs[2] = 0x10000126
	chs[3] = "yjlsc.wdf"
	elseif ch == "九州海沸(坤)_影精灵_普通" then--20
	chs[1] = 0x10000140
	chs[2] = 0x10000139
	chs[3] = "yjlsc.wdf"
   elseif ch == "八狱末劫(乾)_影精灵_普通" then
	chs[1] = 0x10000177
	chs[2] = 0x10000176
	chs[3] = "yjlsc.wdf"
	elseif ch == "八狱末劫(坤)_影精灵_普通" then--20
	chs[1] = 0x10000190
	chs[2] = 0x10000189
	chs[3] = "yjlsc.wdf"
   elseif ch == "罗喉计都(乾)_影精灵_普通" then
	chs[1] = 0x10000227
	chs[2] = 0x10000226
	chs[3] = "yjlsc.wdf"
	elseif ch == "罗喉计都(坤)_影精灵_普通" then--20
	chs[1] = 0x10000240
	chs[2] = 0x10000239
	chs[3] = "yjlsc.wdf"
   	elseif ch == "非天(乾)_影精灵_普通" then
		chs[1] = 0x10000277
		chs[2] = 0x10000276
		chs[3] = "yjlsc.wdf"
	elseif ch == "非天(坤)_影精灵_普通" then--20
		chs[1] = 0x10000290
		chs[2] = 0x10000289
		chs[3] = "yjlsc.wdf"


    elseif ch =="刑天_普通" then  ---九黎
	    chs[1] = 0x10000793--站立
	    chs[2] = 0x10000800--行走
	    chs[3] = "yjlsc.wdf"
    elseif ch =="风祖飞廉_普通" then ---九黎
	    chs[1] = 0x10000760--站立
	    chs[2] = 0x10000767--行走
	    chs[3] = "yjlsc.wdf"
    elseif ch =="食铁兽_普通" then
	   chs[1] = 0x10000776--站立
	   chs[2] = 0x10000783--行走
	   chs[3] = "yjlsc.wdf"
    elseif ch =="有苏鸠_普通" then ---新宝宝
	   chs[1] = 0x00000093--站立
	   chs[2] = 0x00000094--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="司雨_普通" then
	   chs[1] = 0x00000059--站立
	   chs[2] = 0x00000060--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="进阶司雨_普通" then
	   chs[1] = 0x00000030--站立
	   chs[2] = 0x00000031--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="觉醒涂山雪_普通" then
	   chs[1] = 0x00000038--站立
	   chs[2] = 0x00000039--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·飞燕女_普通" then
	   chs[1] = 0x00000130--站立
	   chs[2] = 0x00000132--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·骨精灵_普通" then
	   chs[1] = 0x00000137--站立
	   chs[2] = 0x00000139--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·剑侠客_普通" then
	   chs[1] = 0x00000144--站立
	   chs[2] = 0x00000146--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·龙太子_普通" then
	   chs[1] = 0x00000151--站立
	   chs[2] = 0x00000153--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·杀破狼_普通" then
	   chs[1] = 0x00000158--站立
	   chs[2] = 0x00000160--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·神天兵_普通" then
	   chs[1] = 0x00000165--站立
	   chs[2] = 0x00000167--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·巫蛮儿_普通" then
	   chs[1] = 0x00000172--站立
	   chs[2] = 0x00000174--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="泡泡仙灵·羽灵神_普通" then
	   chs[1] = 0x00000179--站立
	   chs[2] = 0x00000181--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="暗黑谛听_普通"then
	   chs[1] = 0x00000001--站立
	   chs[2] = 0x00000068--行走
	   chs[3] = "anhebb.wdf"
    elseif ch =="暗黑童子_普通"then
	   chs[1] = 0x00000010--站立
	   chs[2] = 0x00000009--行走
	   chs[3] = "anhebb.wdf"
    elseif ch =="彩蝶女孩_普通"then
	   chs[1] = 0x69007834--站立
	   chs[2] = 0x69007836--行走
	   chs[3] = "xcwsc.wdf"
    elseif ch =="彩蝶男孩_普通"then
	   chs[1] = 0x69007841--站立
	   chs[2] = 0x69007836--行走
	   chs[3] = "xcwsc.wdf"
	end
	-- if chs[3]==nil and chs[1]==nil then
	-- 	chs[1] = 0x474B1237
	-- 	chs[2] = 0xC33B0F39
	-- 	chs[3] = "普通模型.wdf"
	-- end
	return chs
end
--1.普通站立  2.普通走路  3.WDF文件



--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
--======================================================================--
function 引擎.取头像(jp)
	local jps = {}
	----------------人物头像
	if jp == "虎头怪" then
		jps[2] = 0X6DF97509 --44X44
		jps[3] = 0X994A57CA --125X111
		jps[4] = 0X5E6B1F0D --243X193
		jps[5] = 0XC8371EBE --65X65
		jps[6] = 0X339DEFD2 --222X211
		jps[7] = "物品图标.wdf"


	elseif jp == "飞燕女" then
		jps[2] = 343987807
		jps[3] = 2821539099
		jps[4] = 1784035300
		jps[5] = 819471807
		jps[6] = 3149034421
		jps[7] = "物品图标.wdf"
	elseif jp == "英女侠" then
		jps[2] = 4082176052
		jps[3] = 1714055813
		jps[4] = 112453972
		jps[5] = 1619905405
		jps[6] = 3703514110
		jps[7] = "物品图标.wdf"
	elseif jp == "巫蛮儿" then
		jps[2] = 1969001626
		jps[3] = 4127390861
		jps[4] = 1288146214
		jps[5] = 2569948308
		jps[6] = 2921462013
		jps[7] = "物品图标.wdf"
	elseif jp == "逍遥生" then
		jps[2] = 3988784113
		jps[3] = 2557559806
		jps[4] = 4177070114
		jps[5] = 3996010872
		jps[6] = 92987728
		jps[7] = "物品图标.wdf"
	elseif jp == "剑侠客" then
		jps[2] = 3615876352
		jps[3] = 3402595886
		jps[4] = 1410056737
		jps[5] = 366914688
		jps[6] = 485626985
		jps[7] = "物品图标.wdf"
	elseif jp == "狐美人" then
		jps[2] = 193125810
		jps[3] = 1337913854
		jps[4] = 3274417234
		jps[5] = 764631086
		jps[6] = 507487855
		jps[7] = "物品图标.wdf"
	elseif jp == "骨精灵" then
		jps[2] = 1580183394
		jps[3] = 2126719765
		jps[4] = 3992137269
		jps[5] = 1433642861
		jps[6] = 2072196139
		jps[7] = "物品图标.wdf"

	elseif jp == "杀破狼" then
		jps[2] = 2873683137
		jps[3] = 2518794069
		jps[4] = 3753428933
		jps[5] = 1033988096
		jps[6] = 1978306148
		jps[7] = "物品图标.wdf"
	elseif jp == "巨魔王" then
		jps[2] = 1285321634
		jps[3] = 2476120802
		jps[4] = 3683691832
		jps[5] = 4077790929
		jps[6] = 3295538630
		jps[7] = "物品图标.wdf"
	elseif jp == "舞天姬" then
		jps[2] = 4183923439
		jps[3] = 837105923
		jps[4] = 3547289847
		jps[5] = 2410388328
		jps[6] = 783365583
		jps[7] = "物品图标.wdf"
	elseif jp == "玄彩娥" then
		jps[2] = 1823274963
		jps[3] = 1560323955
		jps[4] = 2423018618
		jps[5] = 947503475
		jps[6] = 838654255
		jps[7] = "物品图标.wdf"
	elseif jp == "羽灵神" then
		jps[2] = 4194685178
		jps[3] = 983360139
		jps[4] = 1939929797
		jps[5] = 311711491
		jps[6] = 415704253
		jps[7] = "物品图标.wdf"
    elseif jp == "神天兵" then
		jps[2] = 3633356312
		jps[3] = 2078571550
		jps[4] = 419903813
		jps[5] = 3805405383
		jps[6] = 2041810656
		jps[7] = "物品图标.wdf"
	elseif jp == "龙太子" then
		jps[2] = 2968964991
		jps[3] = 3724855951
		jps[4] = 269238848
		jps[5] = 1570362097
		jps[6] = 2585947038
		jps[7] = "物品图标.wdf"
	elseif jp == "桃夭夭" then
		jps[2] = 10559810
		jps[3] = 10559813
		jps[4] = 10559811
		jps[5] = 10559825
		jps[6] = 10559812
		jps[7] = "物品图标.wdf"
	elseif jp == "偃无师" then
		jps[2] = 10559816
		jps[3] = 10559817
		jps[4] = 10559815
		jps[5] = 10559824
		jps[6] = 10559814
		jps[7] = "物品图标.wdf"
	elseif jp == "鬼潇潇" then
		jps[2] = 10559800
		jps[3] = 10559809
		jps[4] = 10559801
		jps[5] = 10559826
		jps[6] = 10559808
		jps[7] = "物品图标.wdf"
    --宝宝
    elseif jp == "野猪" then
		jps[1] = 0xDF608E1D
		jps[2] = 0x087F188A
		jps[4] = 0xBD2DBF43
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "巨蛙" then
		jps[1] = 0xAD983A7D
		jps[2] = 0x2D8CFBA2
		jps[4] = 0x3F9317BB
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "大海龟" then
		jps[1] = 0xA1D1788D
		jps[2] = 0xC39E889A
		jps[4] = 0x12F27887
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "树怪" then
		jps[1] = 0x30283E25
		jps[2] = 0x7D06D3B0
		jps[4] = 0XE3B6336F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "赌徒" then
		jps[1] = 0x1DF9E861
		jps[2] = 0x06B0A60D
		jps[4] = 0xFC840EA4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "大蝙蝠" then
		jps[1] = 0xCD03B9B4
		jps[2] = 0x90ECA422
		jps[4] = 0x6A827437
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "强盗" then
		jps[1] = 0x90B8EAEA
		jps[2] = 0x326CC5C6
		jps[4] = 0xD206038F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "山贼" then
		jps[1] = 0xA5D4465C
		jps[2] = 0xED08D563
		jps[4] = 0x670D2012
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "海毛虫" then
		jps[1] = 0x82B64797
		jps[2] = 0x5786AD5A
		jps[4] = 0xC9D5AC2C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "护卫" then
		jps[1] = 0xB3000CA6
		jps[2] = 0x1B6CEF18
		jps[4] = 0xA8B839FB
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "海星" then
		jps[1] = 0xF903F3A5
		jps[2] = 0xF6FC4C5E
		jps[4] = 0xDDB1800D
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "章鱼" then
		jps[1] = 0x8CB06DED
		jps[2] = 0xC701081D
		jps[4] = 0x4111B83B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "浣熊" or jp == "狸" then
		jps[1] = 0x20ED8F8F
		jps[2] = 0xBD62D8A1
		jps[4] = 0xFDDAB4FC
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "骷髅怪" then
		jps[1] = 0x7D0A4C59
		jps[2] = 0xE358B4CA
		jps[4] = 0xFB588E74
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "羊头怪" then
		jps[1] = 0xB6D11E31
		jps[2] = 0xCD722FCC
		jps[4] = 0xA3D8CF41
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "黑熊" then
		jps[1] = 0x391491B5
		jps[2] = 0x716CAC43
		jps[4] = 0x6F826A9A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蛤蟆精" then
		jps[1] = 0xEA73096F
		jps[2] = 0xFF46A6F0
		jps[4] = 0xABB5D563
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "狐狸精" then
		jps[1] = 0xAFAD55A4
		jps[2] = 0x9AB2C1B6
		jps[4] = 0xE2BDA627
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "花妖" then
		jps[1] = 0x8B6165CA
		jps[2] = 0x866ABD8C
		jps[4] = 0xC9829481
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "老虎" then
		jps[1] = 0xABF4C334
		jps[2] = 0x06B92734
		jps[4] = 0x2BBE6961
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "牛妖" then
		jps[1] = 0xC12CEA44
		jps[2] = 0x0A969C5A
		jps[4] = 0xF5108507
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小龙女" then
		jps[1] = 0x3C45F1BC
		jps[2] = 0x4CE7BFFF
		jps[4] = 0x3AE8E649
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
    elseif jp == "野鬼" then
		jps[1] = 0x6F35B36B
		jps[2] = 0x62663668
		jps[4] = 0x5F37AE22
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "狼" then
		jps[1] = 0x6242A2EC
		jps[2] = 0x3C920EEA
		jps[4] = 0x6EA6C37F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "虾兵" then
		jps[1] = 0xDC7C4250
		jps[2] = 0xFF844C07
		jps[4] = 0xA309B1F5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蟹将" then
		jps[1] = 0x24D3F0A1
		jps[2] = 0x4970522D
		jps[4] = 0xC15BCAD3
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "兔子怪" then
		jps[1] = 0x3A19399F
		jps[2] = 0xC9B56A98
		jps[4] = 0x2F144964
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蜘蛛精" then
		jps[1] = 0x0E91A957
		jps[2] = 0xE67F149E
		jps[4] = 0xE148FC17
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "僵尸" then
		jps[1] = 0xE079A778
		jps[2] = 0xF481072B
		jps[4] = 0x12F1D6D1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "黑熊精" then
		jps[1] = 0x57BDB8F9
		jps[2] = 0x79CEA1EA
		jps[4] = 0x3DAAEC8C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "龟丞相" then
		jps[1] = 0xEC1CEB45
		jps[2] = 0xAA3785D1
		jps[4] = 0x935EEC21
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "牛头" then
		jps[1] = 0x6DB89271
		jps[2] = 0xCDD130C4
		jps[4] = 0x1777351E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "马面" then
		jps[1] = 0x37AB66AF
		jps[2] = 0xA5C7D24B
		jps[4] = 0xA8737330
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "古代瑞兽" then
		jps[1] = 0xA50A1D29
		jps[2] = 0x05E04219
		jps[4] = 0xDBE940E7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶古代瑞兽" then
		jps[1] = 0x07470E5F
		jps[2] = 0x169DF68B
		jps[4] = 0x7AB4492A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "雷鸟人" then
		jps[1] = 0x24359F3E
		jps[2] = 0xA7EE2B7B
		jps[4] = 0x682F5D07
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶雷鸟人" then
		jps[1] = 0x889ADB49
		jps[2] = 0xF3DC6441
		jps[4] = 0x9412D9A5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蝴蝶仙子"then
		jps[1] = 0x63FB33ED
		jps[2] = 0xF3307792
		jps[4] = 0x99F2D6C7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蝴蝶仙子" then
		jps[1] = 0x34E3FA38
		jps[2] = 0xAE5074AB
		jps[4] = 0x74DE4984
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "白熊" then
		jps[1] = 0xA03A62ED
		jps[2] = 0x49DCC4AE
		jps[4] = 0xA8AE532E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶白熊" then
		jps[1] = 0xB47F2149
		jps[2] = 0xDDB1C111
		jps[4] = 0x14FA4D9B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "黑山老妖" then
		jps[1] = 0xC55C704D
		jps[2] = 0xF447F3CB
		jps[4] = 0xBEE87DE0
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶黑山老妖" then
		jps[1] = 0xD58C883C
		jps[2] = 0x4F942965
		jps[4] = 0x17979901
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "天兵" then
		jps[1] = 0xE3A356D4
		jps[2] = 0xF7159B8A
		jps[4] = 0xB836DAF9
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶天兵" then
		jps[1] = 0xB56ECBA9
		jps[2] = 0x338A1A07
		jps[4] = 0xF14B1666
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "天将" then
		jps[1] = 0x2B1FC562
		jps[2] = 0x78F204D8
		jps[4] = 0xF333F834
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶天将" then
		jps[1] = 0xFE5AED33
		jps[2] = 0x1BA73176
		jps[4] = 0x4C12C540
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "地狱战神" then
		jps[1] = 0x8CA33C58
		jps[2] = 0x2C7C0D0E
		jps[4] = 0xE65B948A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶地狱战神" then
		jps[1] = 0xDB8EDC6F
		jps[2] = 0xAF801569
		jps[4] = 0xB9FB91B0
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "风伯" then
		jps[1] = 0xC19E85CA
		jps[2] = 0x2AE672A0
		jps[4] = 0x382053A7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶风伯" then
		jps[1] = 0xA081F972
		jps[2] = 0x1562D6BB
		jps[4] = 0x0D747F00
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "凤凰" then
		jps[1] = 0xA9E3213B
		jps[2] = 0x23870ED4
		jps[4] = 0xCE1D8427
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶凤凰" then
		jps[1] = 0xC2C70463
		jps[2] = 0x5F75075C
		jps[4] = 0x8217B8DC
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "碧水夜叉" then
		jps[1] = 0x45FB4FA3
		jps[2] = 0x01987AF6
		jps[4] = 0xE8E3E7EF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
    elseif jp == "进阶碧水夜叉" then
		jps[1] = 0x78263198
		jps[2] = 0x448C6BD1
		jps[4] = 0xD7EC25CB
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "雨师" then
		jps[1] = 0x8326B8FA
		jps[2] = 0x01265B89
		jps[4] = 0x5BAB5E62
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶雨师" then
		jps[1] = 0x970D69AB
		jps[2] = 0x27D380F8
		jps[4] = 0x67E3B916
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蚌精" then
		jps[1] = 0xDAAED84D
		jps[2] = 0x3D61BEBA
		jps[4] = 0xB1979CB5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蚌精" then
		jps[1] = 0x8E7FDE48
		jps[2] = 0x9C4F4F05
		jps[4] = 0x8D65D1C6
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "鲛人" then
		jps[1] = 0xB288965B
		jps[2] = 0xDCA5D6A5
		jps[4] = 0x5A7D1D79
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶鲛人" then
		jps[1] = 0x76D75D59
		jps[2] = 0x2C03DE10
		jps[4] = 0x28958C68
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蛟龙" then
		jps[1] = 0xD11D19BB
		jps[2] = 0xF40767A3
		jps[4] = 0xE092C49C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蛟龙" then
		jps[1] = 0x3DE0EC5F
		jps[2] = 0x01B5CA10
		jps[4] = 0x6562E4B2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "巡游天神" then
		jps[1] = 0xEDB096B7
		jps[2] = 0x7D314BCB
		jps[4] = 0x79D8BFB0
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶巡游天神" then
		jps[1] = 0x2287BA3A
		jps[2] = 0x3D23BB40
		jps[4] = 0xD5CCD377
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "芙蓉仙子" then
		jps[1] = 0xF5AF49BD
		jps[2] = 0xA686FF51
		jps[4] = 0x9F3CAA62
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶芙蓉仙子" then
		jps[1] = 0x05629025
		jps[2] = 0xE02D2612
		jps[4] = 0xD8D7F589
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "星灵仙子" then
		jps[1] = 0x2D07ACA5
		jps[2] = 0xB4B2CE74
		jps[4] = 0x79053E58
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
    elseif jp == "进阶星灵仙子" then
		jps[1] = 0x0D637B35
		jps[2] = 0xE0798D11
		jps[4] = 0x6A0687F4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "如意仙子" then
		jps[1] = 0xF5A6C5EE
		jps[2] = 0x1D5EF06C
		jps[4] = 0xCDE92089
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶如意仙子" then
		jps[1] = 0x5A7B589D
		jps[2] = 0x61631DC2
		jps[4] = 0x6FC80832
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "锦毛貂精" then
		jps[1] = 0xE49549D0
		jps[2] = 0x2CBD658C
		jps[4] = 0x35C88896
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶锦毛貂精" then
		jps[1] = 0xFBE50E8E
		jps[2] = 0x6882B54D
		jps[4] = 0x20A129D9
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "千年蛇魅" then
		jps[1] = 0x39F807E5
		jps[2] = 0xAB2ED147
		jps[4] = 0x879899EC
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶千年蛇魅" then
		jps[1] = 0x5B3E9AC6
		jps[2] = 0x389718FA
		jps[4] = 0x9CEE85F2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "百足将军" then
		jps[1] = 0x96AFF285
		jps[2] = 0x8F377E02
		jps[4] = 0x18886385
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶百足将军" then
		jps[1] = 0xD0C8C11A
		jps[2] = 0xA56931AA
		jps[4] = 0xE6721E60
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "犀牛将军人形" then
		jps[1] = 0xB0F27967
		jps[2] = 0xE87D7BE8
		jps[4] = 0xBAE75C40
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶犀牛将军人形" then
		jps[1] = 0xDB8B5108
		jps[2] = 0x87CCFBC2
		jps[4] = 0x4045D281
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "犀牛将军兽形" then
		jps[1] = 0x3ACA3DA0
		jps[2] = 0x40391D43
		jps[4] = 0x0D905862
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶犀牛将军兽形" then
		jps[1] = 0x67F3C026
		jps[2] = 0x104306B5
		jps[4] = 0x6B1D603C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "野猪精" then
		jps[1] = 0x0A05B822
		jps[2] = 0x6FF278EE
		jps[4] = 0x91818070
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶野猪精" then
		jps[1] = 0x8356BCC8
		jps[2] = 0x8CFBF7CA
		jps[4] = 0xBB7354EB
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "鼠先锋" then
		jps[1] = 0xC01B0A96
		jps[2] = 0x2FFD0CF6
		jps[4] = 0x4FFE22D8
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶鼠先锋" then
		jps[1] = 0x4058F6F2
		jps[2] = 0x0E8A2F73
		jps[4] = 0x7F884D37
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "泪妖" then
		jps[1] = 0x9095F45E
		jps[2] = 0x007CCCDB
		jps[4] = 0x2E032526
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶泪妖" then
		jps[1] = 0xDF4EFEAD
		jps[2] = 0xD92AAE2F
		jps[4] = 0x4A4BCD11
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "镜妖" then
		jps[1] = 0xDDBE8053
		jps[2] = 0x2632B907
		jps[4] = 0x657FBBE2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶镜妖" then
		jps[1] = 0xAE67D62E
		jps[2] = 0x36D0A7F0
		jps[4] = 0x123C6106
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "阴阳伞" then
		jps[1] = 0x745485EC
		jps[2] = 0xFABAA53C
		jps[4] = 0x29FADBA2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶阴阳伞" then
		jps[1] = 0x424AC904
		jps[2] = 0xD40FD213
		jps[4] = 0x1F63B17E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "律法女娲" then
		jps[1] = 0x49E3AF4D
		jps[2] = 0x9F5BB257
		jps[4] = 0xA2DFFD74
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶律法女娲" then
		jps[1] = 0xFDF5DD4E
		jps[2] = 0x33E14781
		jps[4] = 0xB0A284B9
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
--===================================================================下面开始没核对wdf
	elseif jp == "炎魔神" then
		jps[1] = 0xDEE937E2
		jps[2] = 0xC0DF0BB3
		jps[4] = 0xB70F9CFF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶炎魔神" then
		jps[1] = 0x51AA95E8
		jps[2] = 0xFFB30D11
		jps[4] = 0x189C10BE
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "画魂" then
		jps[1] = 0x5FF60C89
		jps[2] = 0xD0D5C17E
		jps[4] = 0x2565C19F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶画魂" then
		jps[1] = 0x8EBBBD08
		jps[2] = 0xBEC6885C
		jps[4] = 0x76554054
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "灵符女娲" then
		jps[1] = 0xE04223AA
		jps[2] = 0x9BDF74F8
		jps[4] = 0x07107B2E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶灵符女娲" then
		jps[1] = 0x18F4D8E6
		jps[2] = 0xAFA2C78F
		jps[4] = 0x2ABCBBB1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "吸血鬼" then
		jps[1] = 0x523C25F2
		jps[2] = 0xE276EEEE
		jps[4] = 0x4847A23B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶吸血鬼" then
		jps[1] = 0x104B7ED0
		jps[2] = 0x7A6D1196
		jps[4] = 0x8F07C67F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "巴蛇" then
		jps[1] = 0x7211A04B
		jps[2] = 0x7228F80D
		jps[4] = 0x5B2272A2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶巴蛇" then
		jps[1] = 0x4830D9AC
		jps[2] = 0x1FA85CCB
		jps[4] = 0xDB6BC86C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "净瓶女娲" then
		jps[1] = 0xE2FB23F9
		jps[2] = 0xF371BECC
		jps[4] = 0xE0038C5B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶净瓶女娲" then
		jps[1] = 0x575F5122
		jps[2] = 0x4DAF7A6B
		jps[4] = 0x4F8AF53E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "踏云兽" then
		jps[1] = 0xFB368388
		jps[2] = 0x24C4114C
		jps[4] = 0x7AC3A8B7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶踏云兽" then
		jps[1] = 0xCABBCC20
		jps[2] = 0xAA349A7E
		jps[4] = 0x9FEA2B83
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "龙龟" then
		jps[1] = 0x93916DC7
		jps[2] = 0x661758CD
		jps[4] = 0x29A4A68B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶龙龟" then
		jps[1] = 0x771BE319
		jps[2] = 0xE0656D44
		jps[4] = 0x3798DEC5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "红萼仙子" then
		jps[1] = 0xAD0EA485
		jps[2] = 0x678D3BEF
		jps[4] = 0xC772C514
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶红萼仙子" then
		jps[1] = 0x4A1D90BB
		jps[2] = 0x19800FE4
		jps[4] = 0x180576C5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "噬天虎" then
		jps[1] = 0xBC672A71
		jps[2] = 0x001A739A
		jps[4] = 0xF72EA501
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶噬天虎" then
		jps[1] = 0xF2C12D8C
		jps[2] = 0x664D0D94
		jps[4] = 0x0E8D35A3
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "灵鹤" then
		jps[1] = 0x8C05FBA0
		jps[2] = 0x4A9A53AC
		jps[4] = 0xBF49EAA2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶灵鹤" then
		jps[1] = 0x9B5EFDA5
		jps[2] = 0x2EB49559
		jps[4] = 0xF856DDA8
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "大力金刚" or jp == "迭代金刚" then
		jps[1] = 0xBAB53438
		jps[2] = 0x803AC4BA
		jps[4] = 0x936F0B3F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶大力金刚" or jp =="进阶迭代金刚" then
		jps[1] = 0x5E3A7173
		jps[2] = 0x23491143
		jps[4] = 0xA3319022
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "机关鸟" then
		jps[1] = 0x6853513E
		jps[2] = 0xCE2E6380
		jps[4] = 0x6238418C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶机关鸟" then
		jps[1] = 0x90563C9F
		jps[2] = 0xCC60E5F8
		jps[4] = 0xF588F5AD
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "鬼将" or jp == "迭代鬼将" then
		jps[1] = 0xE3DB5D8A
		jps[2] = 0x4647B146
		jps[4] = 0xE84A1BD5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶鬼将" or jp == "进阶迭代鬼将" then
		jps[1] = 0x7166C4B0
		jps[2] = 0x9B5056BC
		jps[4] = 0x7EC96CE3
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "葫芦宝贝" then
		jps[1] = 0xECBF79F6
		jps[2] = 0x3A745390
		jps[4] = 0xDDFFBC85
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶葫芦宝贝" then
		jps[1] = 0xED21E5BD
		jps[2] = 0xE4D1C361
		jps[4] = 0x1BE9CEAF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "机关人" then
		jps[1] = 0xC9A17DF0
		jps[2] = 0x72AA73A3
		jps[4] = 0x22D979E5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶机关人" then
		jps[1] = 0x029820FC
		jps[2] = 0xA14FE521
		jps[4] = 0x74C8DA04
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "幽灵" then
		jps[1] = 0x2B7B7347
		jps[2] = 0x04E257A3
		jps[4] = 0xB9FAFFE0
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶幽灵" then
		jps[1] = 0x49C7656D
		jps[2] = 0x99C9B06E
		jps[4] = 0x58E84AA3
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "幽萤娃娃" then
		jps[1] = 0x85A4CDA2
		jps[2] = 0x74988FAA
		jps[4] = 0x9CAD68C1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶幽萤娃娃" then
		jps[1] = 0x9C1DCFE6
		jps[2] = 0xFF1A6ACE
		jps[4] = 0x9AE1E54D
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "雾中仙" then
		jps[1] = 0x1DEE9FAF
		jps[2] = 0x0FD7CCBD
		jps[4] = 0x70A11319
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶雾中仙" then
		jps[1] = 0x61634205
		jps[2] = 0xC59FEED1
		jps[4] = 0x52822010
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "夜罗刹" then
		jps[1] = 0xDCB316A5
		jps[2] = 0x2FF488AD
		jps[4] = 0x3483A111
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶夜罗刹" then
		jps[1] = 0xCEA91403
		jps[2] = 0x63642CBA
		jps[4] = 0x77DC22AF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "连弩车" then
		jps[1] = 0x6311F6B5
		jps[2] = 0x064A508B
		jps[4] = 0xB2B06815
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶连弩车" then
		jps[1] = 0x5B266F16
		jps[2] = 0x46474602
		jps[4] = 0x64D4DCE4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "机关兽" then
		jps[1] = 0xB2768F45
		jps[2] = 0x9344867F
		jps[4] = 0x18662B0C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶机关兽" then
		jps[1] = 0x356C7A50
		jps[2] = 0x18A2200A
		jps[4] = 0x811DF376
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "琴仙" then
		jps[1] = 0x767B5ADF
		jps[2] = 0xE38EA162
		jps[4] = 0x37AB386F
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶琴仙" then
		jps[1] = 0x08933B51
		jps[2] = 0x0D26E185
		jps[4] = 0x14E19BCE
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "金铙僧" then
		jps[1] = 0xCAFE7210
		jps[2] = 0x4F7F6856
		jps[4] = 0x56EC97B7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶金铙僧" then
		jps[1] = 0xAF9B8C7A
		jps[2] = 0x7D03C394
		jps[4] = 0x82EA677D
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "混沌兽" then
		jps[1] = 0x2624AA5D
		jps[2] = 0xFD5D97F4
		jps[4] = 0x966AD1A1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶混沌兽" then
		jps[1] = 0x75271272
		jps[2] = 0x7AE84C6F
		jps[4] = 0x780FB38A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "猫灵人形" then
		jps[1] = 0x8DC67AD2
		jps[2] = 0xC5B785D6
		jps[4] = 0x59A1378C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶猫灵人形" then
		jps[1] = 0xB1CE2D78
		jps[2] = 0xF808B6DE
		jps[4] = 0x55F596EF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "猫灵兽形" then
		jps[1] = 0x4877C0E7
		jps[2] = 0xDCF4C65B
		jps[4] = 0x43D79120
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶猫灵兽形" then
		jps[1] = 0x94160141
		jps[2] = 0x8698D7A6
		jps[4] = 0x150D7488
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "狂豹人形" then
		jps[1] = 0x0D17D382
		jps[2] = 0x5ADE76FE
		jps[4] = 0xE544351B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶狂豹人形" then
		jps[1] = 0x2E77E22D
		jps[2] = 0x299E9267
		jps[4] = 0xAED39D9A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "狂豹兽形" then
		jps[1] = 0x007411E9
		jps[2] = 0x51DD0C75
		jps[4] = 0xB58A25B2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶狂豹兽形" then
		jps[1] = 0x7DE142E6
		jps[2] = 0x9CE69D03
		jps[4] = 0xA7154AB2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蝎子精" then
		jps[1] = 0x22FC262A
		jps[2] = 0x455347A8
		jps[4] = 0xE2C0E97B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蝎子精" then
		jps[1] = 0xBEBE2DE2
		jps[2] = 0x7E4C42CB
		jps[4] = 0xA9492BBC
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蜃气妖" then
		jps[1] = 0xC13F272A
		jps[2] = 0xDD34FDF2
		jps[4] = 0x3382B99C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蜃气妖" then
		jps[1] = 0xD08C301F
		jps[2] = 0x05C2D7FA
		jps[4] = 0xA7EB4FFE
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "曼珠沙华" then
		jps[1] = 0x0C0EC59C
		jps[2] = 0x3AEAC686
		jps[4] = 0xA9BF2A70
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶曼珠沙华" then
		jps[1] = 0x10F50864
		jps[2] = 0x917F4983
		jps[4] = 0x3290F1E8
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "长眉灵猴" then
		jps[1] = 0x6CD0A68C
		jps[2] = 0xED53371C
		jps[4] = 0xD3A40262
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶长眉灵猴" then
		jps[1] = 0x9FA88D38
		jps[2] = 0x060B8DB4
		jps[4] = 0x990F4826
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "巨力神猿" then
		jps[1] = 0xC8DA49A9
		jps[2] = 0x520D9528
		jps[4] = 0x78647E78
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶巨力神猿" then
		jps[1] = 0x018EA183
		jps[2] = 0x4A4A014E
		jps[4] = 0x137F323A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "金身罗汉" then
		jps[1] = 0x6701D105
		jps[2] = 0xB3A2A9E0
		jps[4] = 0xD00C9DA9
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶金身罗汉" then
		jps[1] = 0x073C81E6
		jps[2] = 0x44C0FAB2
		jps[4] = 0xFEA664CC
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "蔓藤妖花" then
		jps[1] = 0x0B13B2CE
		jps[2] = 0x07D0DC47
		jps[4] = 0x0D782089
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶蔓藤妖花" then
		jps[1] = 0xCF8279AC
		jps[2] = 0xF5A58149
		jps[4] = 0xB01BAE4E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "修罗傀儡鬼" then
		jps[1] = 0xF1738910
		jps[2] = 0xA0FA8D38
		jps[4] = 0xA79D1138
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶修罗傀儡鬼" then
		jps[1] = 0xF939992C
		jps[2] = 0x1D5E937A
		jps[4] = 0x1C18BBC4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "修罗傀儡妖" then
		jps[1] = 0xFF6EB365
		jps[2] = 0x0EBC029C
		jps[4] = 0xAD07D8A2
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶修罗傀儡妖" then
		jps[1] = 0x21808A04
		jps[2] = 0x10C6D8CE
		jps[4] = 0xA87B7E1C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"

	elseif jp == "毗舍童子" then
		jps[1] = 0x47FA6C7C
		jps[2] = 0x29C2068F
		jps[4] = 0xDEE48C77
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶毗舍童子" then
		jps[1] = 0x898D54DA
		jps[2] = 0xCE1979FF
		jps[4] = 0x10B40E5B
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "持国巡守" then
		jps[1] = 0x8F038D77
		jps[2] = 0xDC166219
		jps[4] = 0xA684CDBD
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶持国巡守" then
		jps[1] = 0xD5DF37EC
		jps[2] = 0x3C633096
		jps[4] = 0x8E0E0A44
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "真陀护法" then
		jps[1] = 0xFD534DBF
		jps[2] = 0xD76F4018
		jps[4] = 0xFFBCDA90
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶真陀护法" then
		jps[1] = 0x3BF2EE43
		jps[2] = 0xD9E7E041
		jps[4] = 0x448482C6
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "增长巡守" then
		jps[1] = 0xD5C9E162
		jps[2] = 0x618A19B3
		jps[4] = 0x35F2BD1E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶增长巡守" then
		jps[1] = 0x736BF280
		jps[2] = 0x4F47A21E
		jps[4] = 0x1EA94960
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "灵灯侍者" then
		jps[1] = 0x531C4EFB
		jps[2] = 0x4883A916
		jps[4] = 0x5365A558
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶灵灯侍者" then
		jps[1] = 0x649272A9
		jps[2] = 0xB356762F
		jps[4] = 0xA80F234A
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "般若天女" then
		jps[1] = 0x1D585652
		jps[2] = 0xA4E9EA96
		jps[4] = 0x72763F59
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "进阶般若天女" then
		jps[1] = 0x6F0B4A78
		jps[2] = 0x5F325FAC
		jps[4] = 0xD0EF876C
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "泡泡" or jp == "进阶泡泡" or jp == "盲僧眼珠" then
		jps[1] = 0xF1706FCB
		jps[2] = 0x035617B0
		jps[4] = 0xFF17FA58
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
  --  	elseif jp == "恶魔泡泡"  then
		-- jps[1] = "恶魔泡泡小"
		-- jps[2] = "恶魔泡泡中"
		-- jps[4] = "恶魔泡泡大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"
  --   elseif jp == "超级飞廉"  then
		-- jps[1] = "超级飞廉头像小"
		-- jps[2] = "超级飞廉头像大"
		-- jps[4] = "超级飞廉头像大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"
  --    elseif jp == "自在心猿"  then
		-- jps[1] = "自在心猿小头像"
		-- jps[2] = "自在心袁中"
		-- jps[4] = "自在心袁大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"
  --    elseif jp == "进阶沙暴"  then
		-- jps[1] = "进阶沙暴小"
		-- jps[2] = "进阶沙暴大"
		-- jps[4] = "进阶沙暴大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"
  --    elseif jp == "超级红孩儿"  then
		-- jps[1] = "超级红孩儿小"
		-- jps[2] = "超级红孩儿大"
		-- jps[4] = "超级红孩儿大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"
  -- elseif jp == "超级神柚"  then
		-- jps[1] = "超级神柚小"
		-- jps[2] = "超级神柚大"
		-- jps[4] = "超级神柚大"
		-- jps[7] = "新宝宝.gpk"
		-- jps[8] = "新宝宝.gpk"
		-- jps[10] = "新宝宝.gpk"

elseif jp == "自在心猿"   then ----新宝宝
		jps[1] = 0x20000009
		jps[2] = 0x20000002
		--jps[4] = 0x20000001
		jps[7] = "xbb.wdf"
		jps[8] = "xbb.wdf"
		--jps[10] = "自在.wdf"
		elseif jp == "进阶沙暴"   then
		jps[1] = 0xC0000040
		jps[2] = 0xC0000039
		--jps[4] = 0x20000001
		jps[7] ="xbb.wdf"
		jps[8] = "xbb.wdf"
		--jps[10] = "自在.wdf"
		elseif jp == "恶魔泡泡"   then
		jps[1] = 0x51E72D26
		jps[2] = 0x51E72D29
		jps[4] = 0x51E72D22
		jps[7] = "xbb.wdf"
		jps[8] = "xbb.wdf"
		jps[10] = "xbb.wdf"
	elseif jp == "超级红孩儿"   then
		jps[1] = 0xC0000041
		jps[2] = 0xC0000042
		jps[4] = 0xC0000059
		jps[7] = "xbb.wdf"
		jps[8] = "xbb.wdf"
		jps[10] = "xbb.wdf"
	elseif jp == "超级飞廉"  then
		jps[1] = 0xC0000043
		jps[2] = 0xC0000044
		jps[4] = 0xC0000044
		jps[7] = "xbb.wdf"
		jps[8] = "xbb.wdf"
		jps[10] = "xbb.wdf"
	elseif jp == "超级神柚"  then
		jps[1] = 0xC0000051
		jps[2] = 0xC0000052
		jps[4] = 0xC0000060
		jps[7] = "xbb.wdf"
		jps[8] = "xbb.wdf"
		jps[10] = "xbb.wdf"
	elseif jp == "有苏鸠"  then ---
		jps[1] = 0x00000092
		jps[2] = 0x00000099
		jps[4] = 0x00000088
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "司雨"  then ---
		jps[1] = 0x00000058
		jps[2] = 0x00000100
		jps[4] = 0x00000054
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "进阶司雨"  then ---
		jps[1] = 0x00000029
		jps[2] = 0x00000101
		jps[4] = 0x00000025
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "觉醒涂山雪"  then ---
		jps[1] = 0x00000037
		jps[2] = 0x00000102
		jps[4] = 0x00000033
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"

	elseif jp == "泡泡仙灵·飞燕女"  then ---
		jps[1] = 0x00000103
		jps[2] = 0x00000104
		jps[4] = 0x00000105
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "泡泡仙灵·骨精灵"  then ---
		jps[1] = 0x00000106
		jps[2] = 0x00000107
		jps[4] = 0x00000108
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"

	elseif jp == "泡泡仙灵·剑侠客"  then ---
		jps[1] = 0x00000109
		jps[2] = 0x00000110
		jps[4] = 0x00000111
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "泡泡仙灵·龙太子"  then ---
		jps[1] = 0x00000112
		jps[2] = 0x00000113
		jps[4] = 0x00000114
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"

	elseif jp == "泡泡仙灵·杀破狼"  then ---
		jps[1] = 0x00000115
		jps[2] = 0x00000116
		jps[4] = 0x00000117
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "泡泡仙灵·神天兵"  then ---
		jps[1] = 0x00000118
		jps[2] = 0x00000119
		jps[4] = 0x00000120
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"

	elseif jp == "泡泡仙灵·巫蛮儿"  then ---
		jps[1] = 0x00000121
		jps[2] = 0x00000122
		jps[4] = 0x00000123
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "泡泡仙灵·羽灵神"  then ---
		jps[1] = 0x00000124
		jps[2] = 0x00000125
		jps[4] = 0x00000126
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
   elseif jp == "暗黑谛听"  then
		jps[1] = 0x00000068
		jps[2] = 0x00000067
		jps[4] = 0x00000067
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
	elseif jp == "暗黑童子" then
		jps[1] = 0x47FA6C7C
		jps[2] = 0x29C2068F
		jps[4] = 0xDEE48C77
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "彩蝶女孩" then
		jps[1] = 0x69007845
		jps[2] = 0x69007846
		jps[4] = 0x69007846
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "彩蝶男孩" then
		jps[1] = 0x69007847
		jps[2] = 0x69007848
		jps[4] = 0x69007848
		jps[7] = "xcwsc.wdf"
		jps[8] = "xcwsc.wdf"
		jps[10] = "xcwsc.wdf"
	elseif jp == "龙马" or jp == "进阶龙马"  then
		jps[1] = 0xB1E73C63
		jps[2] = 0x62ADD87C
		jps[4] = 0xF2D36051
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神龙" or jp == "进阶超级神龙"  then
		jps[1] = 0x34766E90
		jps[2] = 0xAF34F9DE
		jps[4] = 0xF9F462EF
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级孔雀" or jp == "进阶超级孔雀"  then
		jps[1] = 0x4AC8F5DE
		jps[2] = 0x443DEFFC
		jps[4] = 0xF0085B15
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级灵狐" or jp == "进阶超级灵狐"  then
		jps[1] = 0x3B5A1A91
		jps[2] = 0xA84A8DA4
		jps[4] = 0xF44C4B78
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级麒麟" or jp == "进阶超级麒麟"  then
		jps[1] = 0xCD8DC32B
		jps[2] = 0xF0CF707B
		jps[4] = 0x2AFEF029
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级大鹏" or jp == "进阶超级大鹏"  then
		jps[1] = 0xE01F8A25
		jps[2] = 0xD7282D50
		jps[4] = 0xE54449AD
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级赤焰兽" or jp == "进阶超级赤焰兽"  then
		jps[1] = 0xF8D24976
		jps[2] = 0x066DFAFB
		jps[4] = 0x97D49726
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级白泽" or jp == "进阶超级白泽"  then
		jps[1] = 0x178DEE01
		jps[2] = 0x6875C546
		jps[4] = 0x5DD2DF02
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级灵鹿" or jp == "进阶超级灵鹿"  then
		jps[1] = 0xD4BBF19C
		jps[2] = 0x043FA1FC
		jps[4] = 0x36D8B919
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级大象" or jp == "进阶超级大象"  then
		jps[1] = 0xC284AEC7
		jps[2] = 0x32E7F885
		jps[4] = 0x479D3DAE
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级金猴" or jp == "进阶超级金猴"  then
		jps[1] = 0x237D8B3E
		jps[2] = 0x84F9623A
		jps[4] = 0x450785A4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级大熊猫" or jp == "进阶超级大熊猫"  then
		jps[1] = 0x74E05925
		jps[2] = 0x37FA7B7E
		jps[4] = 0x15CC9BB5
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级泡泡" or jp == "进阶超级泡泡"  then
		jps[1] = 0x6EC5F31C
		jps[2] = 0x5D49C79F
		jps[4] = 0xD6DBEF71
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神兔" or jp == "进阶超级神兔"  then
		jps[1] = 0xA3ADD383
		jps[2] = 0x00FB291A
		jps[4] = 0xF3881D27
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神虎" or jp == "进阶超级神虎"  then
		jps[1] = 0x3017595B
		jps[2] = 0xDC24F5D8
		jps[4] = 0x9CED4F42
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神狗" or jp == "进阶超级神狗" then
		jps[1] = 0x10000102
		jps[2] = 0x10000103
		jps[4] = 0x10000103
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"
	elseif jp == "超级神鼠" or jp == "进阶超级神鼠" then
		jps[1] = 0x10000104
		jps[2] = 0x10000105
		jps[4] = 0x10000105
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"
	elseif jp == "超级神猪" or jp == "进阶超级神猪" then
		jps[1] = 0x10000106
		jps[2] = 0x10000107
		jps[4] = 0x10000107
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"
	elseif jp == "超级猪小戒" or jp == "进阶超级猪小戒" then
		jps[1] = 0x10000110
		jps[2] = 0x10000111
		jps[4] = 0x10000111
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"
	elseif jp == "飞天" or jp == "进阶飞天" then
		jps[1] = 0x10000100
		jps[2] = 0x10000101
		jps[4] = 0x10000101
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"
	elseif jp == "超级神牛" or jp == "进阶超级神牛"  then
		jps[1] = 0xA520757C
		jps[2] = 0x00881F84
		jps[4] = 0x53EAB6E1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级海豚" or jp == "进阶超级海豚"  then
		jps[1] = 0xAABF9D5E
		jps[2] = 0xC960684E
		jps[4] = 0xEF2AEBB7
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级人参娃娃" or jp == "进阶超级人参娃娃"  then
		jps[1] = 0x2B6361F6
		jps[2] = 0x09FA1385
		jps[4] = 0x93D56020
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级青鸾" or jp == "进阶超级青鸾"  then
		jps[1] = 0xD085CF36
		jps[2] = 0x09C4A188
		jps[4] = 0xC0A7E9B1
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级腾蛇" or jp == "进阶超级腾蛇"  then
		jps[1] = 0x1554198D
		jps[2] = 0xB118ECE8
		jps[4] = 0x66F2BEB4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级土地公公" or jp == "进阶超级土地公公"  then
		jps[1] = 0x85512FAA
		jps[2] = 0x5D4FACC0
		jps[4] = 0x2361D268
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级六耳猕猴" or jp == "进阶超级六耳猕猴"  then
		jps[1] = 0x2DEC09F9
		jps[2] = 0x4EDDACD0
		jps[4] = 0x41C69D1E
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神鸡" or jp == "进阶超级神鸡"  then
		jps[1] = 0xC30F84BF
		jps[2] = 0x6A8966BE
		jps[4] = 0x5075BFD4
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级玉兔" or jp == "进阶超级玉兔"  then
		jps[1] = 0x00F276B5
		jps[2] = 0x00F276B4
		jps[4] = 0x00F276B6
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神猴" or jp == "进阶超级神猴"  then
		jps[1] = 0xFA16B987
		jps[2] = 0x50C0FCB1
		jps[4] = 0x3F155EFA
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神马" or jp == "进阶超级神马"  then
		jps[1] = 0x212B8B39
		jps[2] = 0xFB118648
		jps[4] = 0x3AB6C3F3
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神羊" or jp == "进阶超级神羊"  then
		jps[1] = 0x85603ADA
		jps[2] = 0xE8841FF2
		jps[4] = 0xDBFBE4AD
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级神蛇" or jp == "进阶超级神蛇"  then
		jps[1] = 0x5C1C53DF
		jps[2] = 0x13F12535
		jps[4] = 0xBB449983
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "超级筋斗云" or jp == "进阶超级筋斗云"  then
		jps[1] = 0xA69F6B2F
		jps[2] = 0xEDB5E789
		jps[4] = 0x448EC476
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小毛头" or jp == "进阶小毛头"  then
		jps[1] = 0xF1CF62EE
		jps[2] = 0xC8D41161
		jps[4] = 0x4ADB4261
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小丫丫" or jp == "进阶小丫丫"  then
		jps[1] = 0x9E313CA0
		jps[2] = 0xFBE6FF99
		jps[4] = 0xA974BA37
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小仙灵" or jp == "进阶小仙灵"  then
		jps[1] = 0x160BAC92
		jps[2] = 0xBBFFA377
		jps[4] = 0xCC5FD880
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小仙女" or jp == "进阶小仙女"  then
		jps[1] = 0xF02B3FE7
		jps[2] = 0x778895A7
		jps[4] = 0x8641F7A6
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小精灵" or jp == "进阶小精灵"  then
		jps[1] = 0x3560646D
		jps[2] = 0xD294A300
		jps[4] = 0x8C9213B6
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	elseif jp == "小魔头" or jp == "进阶小魔头"  then
		jps[1] = 0xC424DB10
		jps[2] = 0xE168C387
		jps[4] = 0xBDAA9353
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
    elseif jp == "超级武罗" then
		jps[1] = 0x00000048
		jps[2] = 0x00000047
		jps[4] = 0x00000047
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
    elseif jp == "超级小猴子" then
		jps[1] = 0x00000058
		jps[2] = 0x00000057
		jps[4] = 0x00000057
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
    elseif jp == "谛听" then
		jps[1] = 0x00000068
		jps[2] = 0x00000067
		jps[4] = 0x00000067
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
	elseif jp == "独角兽" then
		jps[1] = 0x00000068
		jps[2] = 0x00000067
		jps[4] = 0x00000067
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"

   elseif jp == "画江湖" then
		jps[1] = 0x00000119
		jps[2] = 0x00000118
		jps[4] = 0x00000118
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
		elseif jp == "葬送者" then
		jps[1] = 0x00000310
		jps[2] = 0x00000309
		jps[4] = 0x00000309
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
  elseif jp == "小精灵" then
		jps[1] = 0x00000277
		jps[2] = 0x00000276
		jps[4] = 0x00000276
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
    elseif jp == "裁决者" then
		jps[1] = 0x00000042
		jps[2] = 0x00000041
		jps[4] = 0x00000041
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
    elseif jp == "月影" then
		jps[1] = 0x00000308
		jps[2] = 0x00000307
		jps[4] = 0x00000307
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
    elseif jp == "花仙" then
		jps[1] = 0x00000117
		jps[2] = 0x00000116
		jps[4] = 0x00000116
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
     elseif jp == "雪仙" then
		jps[1] = 0x00000295
		jps[2] = 0x00000294
		jps[4] = 0x00000294
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
     elseif jp == "超级尾巴" then
		jps[1] = 0x00000052
		jps[2] = 0x00000051
		jps[4] = 0x00000051
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
elseif jp == "超级阿狸" then
		jps[1] = 0x00000044
		jps[2] = 0x00000043
		jps[4] = 0x00000043
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
   elseif jp == "超级小八戒" then
		jps[1] = 0x00000054
		jps[2] = 0x00000053
		jps[4] = 0x00000053
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
elseif jp == "超级小白龙" then
		jps[1] = 0x00000056
		jps[2] = 0x00000055
		jps[4] = 0x00000055
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"

elseif jp == "超级小萝莉" then
		jps[1] = 0x00000060
		jps[2] = 0x00000059
		jps[4] = 0x00000059
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "超级帝释天" then
		jps[1] = 0x00000046
		jps[2] = 0x00000045
		jps[4] = 0x00000045
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "超级贪狼" then
		jps[1] = 0x00000050
		jps[2] = 0x00000049
		jps[4] = 0x00000049
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "超级翼龙" then
		jps[1] = 0x00000062
		jps[2] = 0x00000061
		jps[4] = 0x00000061
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
  elseif jp == "赵云" then
		jps[1] = 0x00000005
		jps[2] = 0x00000007
		jps[4] = 0x00000002
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "紫霞仙子" then
		jps[1] = 0x00000013
		jps[2] = 0x00000015
		jps[4] = 0x00000010
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "阿朱" then
		jps[1] = 0x00000021
		jps[2] = 0x00000016
		jps[4] = 0x00000016
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "白子画" then
		jps[1] = 0x00000028
		jps[2] = 0x00000030
		jps[4] = 0x00000025
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "碧瑶" then
		jps[1] = 0x00000039
		jps[2] = 0x00000033
		jps[4] = 0x00000033
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "貂蝉" then
		jps[1] = 0x00000074
		jps[2] = 0x00000076
		jps[4] = 0x00000071
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "凤九" then
		jps[1] = 0x00000084
		jps[2] = 0x00000086
		jps[4] = 0x00000081
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 -- elseif jp == "关羽" then
	-- 	jps[1] = 0x00000095
	-- 	jps[2] = 0x00000092
	-- 	jps[4] = 0x00000092
	-- 	jps[7] = "素材修复.wdf"
	-- 	jps[8] = "素材修复.wdf"
	-- 	jps[10] = "素材修复.wdf"
 elseif jp == "鬼厉" then
		jps[1] = 0x00000102
		jps[2] = 0x00000097
		jps[4] = 0x00000097
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "花无缺" then
		jps[1] = 0x00000113
		jps[2] = 0x00000115
		jps[4] = 0x00000110
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "剑圣" then
		jps[1] = 0x00000125
		jps[2] = 0x00000127
		jps[4] = 0x00000122
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "巨灵神" then
		jps[1] = 0x00000133
		jps[2] = 0x00000135
		jps[4] = 0x00000130
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "李蓉蓉" then
		jps[1] = 0x00000139
		jps[2] = 0x00000138
		jps[4] = 0x00000138
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "李逍遥" then
		jps[1] = 0x00000150
		jps[2] = 0x00000152
		jps[4] = 0x00000147
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "怜星" then
		jps[1] = 0x00000158
		jps[2] = 0x00000160
		jps[4] = 0x00000155
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "凌凌漆" then
		jps[1] = 0x00000166
		jps[2] = 0x00000168
		jps[4] = 0x00000163
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "龙儿" then
		jps[1] = 0x00000176
		jps[2] = 0x00000171
		jps[4] = 0x00000171
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "陆雪琪" then
		jps[1] = 0x00000185
		jps[2] = 0x00000180
		jps[4] = 0x00000180
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "洛神" then
		jps[1] = 0x00000193
		jps[2] = 0x00000195
		jps[4] = 0x00000189
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "吕布" then
		jps[1] = 0x00000201
		jps[2] = 0x00000203
		jps[4] = 0x00000198
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "普智" then
		jps[1] = 0x00000213
		jps[2] = 0x00000208
		jps[4] = 0x00000208
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "青霞仙子" then
		jps[1] = 0x00000222
		jps[2] = 0x00000224
		jps[4] = 0x00000219
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "人皇" then
		jps[1] = 0x00000231
		jps[2] = 0x00000233
		jps[4] = 0x00000227
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "杀阡陌" then
		jps[1] = 0x00000239
		jps[2] = 0x00000241
		jps[4] = 0x00000236
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "通臂猿猴" then
		jps[1] = 0x00000255
		jps[2] = 0x00000250
		jps[4] = 0x00000250
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "万人往" then
		jps[1] = 0x00000263
		jps[2] = 0x00000265
		jps[4] = 0x00000259
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "尉迟恭" then
		jps[1] = 0x00000271
		jps[2] = 0x00000273
		jps[4] = 0x00000268
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "小昭" then
		jps[1] = 0x00000283
		jps[2] = 0x00000285
		jps[4] = 0x00000280
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "雄霸" then
		jps[1] = 0x00000291
		jps[2] = 0x00000293
		jps[4] = 0x00000288
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
 elseif jp == "邀月" then
		jps[1] = 0x00000302
		jps[2] = 0x00000304
		jps[4] = 0x00000298
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
elseif jp == "张小凡" then
		jps[1] = 0x00000316
		jps[2] = 0x00000318
		jps[4] = 0x00000313
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
elseif jp == "赵敏" then
		jps[1] = 0x00000324
		jps[2] = 0x00000326
		jps[4] = 0x00000321
		jps[7] = "素材修复.wdf"
		jps[8] = "素材修复.wdf"
		jps[10] = "素材修复.wdf"
elseif jp == "召唤兽造型进阶" then
		jps[1] = 0x0CC301B3
		jps[2] = 0x0CC301B3
		jps[4] = 0x0CC301B3
		jps[7] = "房屋图标.wdf"
		jps[8] = "房屋图标.wdf"
		jps[10] = "房屋图标.wdf"






--npc
	elseif jp == "GM" then
		jps[4] = 2954963460
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_马副将" then
		jps[4] = 0x67B62ED5
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_钟馗" then
		jps[4] = 911604837
		jps[7] = "物品图标.wdf"
   	elseif jp == "五行大师" or jp == "男人_方丈" then
		jps[4] = 0x0A0BC629
		jps[7] = "物品图标.wdf"
   	elseif jp == "热心仙人" then
		jps[4] = 0x12210C6A
		jps[7] = "物品图标.wdf"
    elseif jp == "马猴" then
		jps[4] = 0x87DB4BCC
		jps[7] = "物品图标.wdf"
    elseif jp == "珍品商人" then
		jps[4] = 0x1C9CBA0C
		jps[7] = "物品图标.wdf"
    elseif jp == "白无常" then
		jps[4] = 0x2EAD989A
		jps[7] = "物品图标.wdf"
	elseif jp == "黑无常" then
		jps[4] = 0x8CAD1F2F
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_将军" then
		jps[4] = 1892571830
		jps[7] = "物品图标.wdf"
	elseif jp == "熊猫泡泡" then
		jps[4] = 0xA02C86C6
		jps[7] = "房屋图标.wdf"


	elseif jp == "女人_染色师" then
		jps[4] = 480033292
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_衙役" then
		jps[4] = 4162524865
		jps[7] = "物品图标.wdf"
   	elseif jp == "罗百万" then
		jps[4] = 0x00F98F61
		jps[7] = "物品图标.wdf"
   	elseif jp == "太白金星" then
		jps[4] = 0x3E2EE17D
		jps[7] = "物品图标.wdf"
    elseif jp == "南极仙翁" then
		jps[4] = 0x304E494E
		jps[7] = "物品图标.wdf"
    elseif jp == "孙悟空" then
		jps[4] = 0x3FA3472C
		jps[7] = "物品图标.wdf"
   	elseif jp == "少女" then
		jps[4] = 0x421D6F27
		jps[7] = "物品图标.wdf"
   	elseif jp == "陈妈妈" then
		jps[4] = 0x0E756971
		jps[7] = "物品图标.wdf"
    elseif jp == "文伯" then
		jps[4] = 0x61117204
		jps[7] = "物品图标.wdf"
   	elseif jp == "袁天罡" then
		jps[4] = 0xF9CC9FCF
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_老伯" then
		jps[4] = 1628533252
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_赵姨娘" then
		jps[4] = 2355335750
		jps[7] = "物品图标.wdf"
	elseif jp == "仓库保管员" then
		jps[4] = 0x6081AD14
		jps[7] = "物品图标.wdf"
	elseif jp == "奸商" then
		jps[4] = 0x6081AD14
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_程夫人" then
		jps[4] = 1679184112
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_巫医" then
		jps[4] = 4118131077
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_兰虎"then
		jps[4] = 2294980292
		jps[7] = "物品图标.wdf"
	elseif jp == "神树" then
		jps[4] = 2294980292
		jps[7] = "物品图标.wdf"
	elseif jp == "帮派机关人" then
		jps[4] = 2294980292
		jps[7] = "物品图标.wdf"
	elseif jp == "帮派传送" then
		jps[4] = 2294980292
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_师爷" then
		jps[4] = 1814687522
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_王大嫂" then
		jps[4] = 1960181513
		jps[7] = "物品图标.wdf"
	elseif jp == "小孩_雷黑子" then
		jps[4] = 228320831
		jps[7] = "物品图标.wdf"
	elseif jp == "小孩_飞儿" then
		jps[4] = 532741292
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_丫鬟" then
		jps[4] = 1109225255
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_万圣公主" then
		jps[4] = 779713906
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_钓鱼" then
		jps[4] = 3801299271
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_道士" then
		jps[4] = 2438497070
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_土地" then
		jps[4] = 1388762331
		jps[7] = "物品图标.wdf"
	elseif jp == "程咬金" then
		jps[4] = 1487235894
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_村长" then
		jps[4] = 3943196492
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_苦力" then
		jps[4] = 3813740252
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_酒店老板" then
		jps[4] = 822917658
		jps[7] = "物品图标.wdf"
	elseif jp == "空度禅师" then
		jps[4] = 168543785
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_驿站老板" then
		jps[4] = 2033100888
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_老孙头" then
		jps[4] = 112144826
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_老财" then
		jps[4] = 4009791583
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_财主" then
		jps[4] = 1238039746
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_老书生" then
		jps[4] = 2687352542
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_武器店老板" then
		jps[4] = 1972346464
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_服装店老板" then
		jps[4] = 873292509
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_特产商人" then
		jps[4] = 820615594
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_店小二" then
		jps[4] = 1314051870
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_胖和尚" then
		jps[4] = 2343936794
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_药店老板" then
		jps[4] = 3265788014
		jps[7] = "物品图标.wdf"
	elseif jp == "普陀_接引仙女" then
		jps[4] = 2139408709
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_小白龙" then
		jps[4] = 4193268133
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_书生" then
		jps[4] = 2000255336
		jps[7] = "物品图标.wdf"
	elseif jp == "女兵" then
		jps[4] = 0x3483A111
		jps[7] = "物品图标.wdf"
   elseif jp == "校尉" then
		jps[4] = 0x1CA66D04
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_镖头" then
		jps[4] = 3664176840
		jps[7] = "物品图标.wdf"
	elseif jp == "东海龙王" then
		jps[4] = 0xECF36B2F
		jps[7] = "物品图标.wdf"
	elseif jp == "菩提祖师" then
		jps[4] = 0x8D656188
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_判官" then
		jps[4] = 0x7530532F
		jps[7] = "物品图标.wdf"
	elseif jp == "阎罗王" then
		jps[4] = 0x7A22D6D1
		jps[7] = "物品图标.wdf"
	elseif jp == "地藏王" then
		jps[4] = 0xE9F0579D
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_二郎神" then
		jps[4] = 0xB061E863
		jps[7] = "物品图标.wdf"
	elseif jp == "李靖" then
		jps[4] = 0xDAE855F8
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_玉帝" then
		jps[4] = 0x23DB547E
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_王母" then
		jps[4] = 0x77B7E4FF
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_哪吒" then
		jps[4] = 0x0D24234C
		jps[7] = "物品图标.wdf"
	elseif jp == "牛魔王" then
		jps[4] = 0x83547F15
		jps[7] = "物品图标.wdf"
    elseif jp == "至尊宝" then
		jps[4] = 0x8309B5DC
		jps[7] = "物品图标.wdf"
	elseif jp == "九头精怪" then
		jps[4] = 4215520146
		jps[7] = "物品图标.wdf"
	elseif jp == "观音姐姐" then
		jps[4] = 2353721001
		jps[7] = "物品图标.wdf"
	elseif jp == "镇元子" then
		jps[4] = 1686391246
		jps[7] = "物品图标.wdf"
	elseif jp == "大大王" then
		jps[4] = 0x1CDF6FF5
		jps[7] = "物品图标.wdf"
	elseif jp == "春十三娘" then
		jps[4] = 322188931
		jps[7] = "物品图标.wdf"
	elseif jp == "白晶晶" then
		jps[4] = 3660656729
		jps[7] = "物品图标.wdf"
	elseif jp == "哮天犬" then
		jps[4] = 1870550313
		jps[7] = "物品图标.wdf"
	elseif jp == "二郎神" then
		jps[4] = 1473040466
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_太上老君" then
		jps[4] = 3134952256
		jps[7] = "物品图标.wdf"
	elseif jp == "巫师" then
		jps[4] = 0x2F728796
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_满天星" then
		jps[4] = 0x221DF8A8
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_云小奴" then
		jps[4] = 0xEED08D0E
		jps[7] = "物品图标.wdf"
	elseif jp == "巫奎虎" then
		jps[4] = 0x7ABE5099
		jps[7] = "物品图标.wdf"
	elseif jp == "地涌夫人" then
		jps[4] = 1261711986
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_灵鼠娃娃" then
		jps[4] = 1359318316
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_道童" then
		jps[4] = 505350540
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_翠花" then
		jps[4] = 0x2FB1A687
		jps[7] = "物品图标.wdf"
	elseif jp == "孙婆婆" then
		jps[4] = 0xEEB6DF92
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_绿儿" then
		jps[4] = 0xA74969CD
		jps[7] = "物品图标.wdf"
	elseif jp == "二大王" then
		jps[4] = 0x2478FFCE
		jps[7] = "物品图标.wdf"
	elseif jp == "三大王" then
		jps[4] = 0x425EE9E7
		jps[7] = "物品图标.wdf"
	elseif jp == "女人_孟婆" then
		jps[4] = 0x0167D818
		jps[7] = "物品图标.wdf"
	elseif jp == "男人_诗中仙" then
		jps[4] = 0xF9CC9FCF
		jps[7] = "物品图标.wdf"
	elseif jp == "蚩尤" then
		jps[4] = 0x5822CC97
		jps[7] = "物品图标.wdf"
	elseif jp == "知了王" then
		jps[4] = 3808489609
		jps[7] = "物品图标.wdf"
	elseif jp == "和尚3" then
		jps[4] = 0x12210C6A
		jps[7] = "物品图标.wdf"
	elseif jp == "考官2" then
		jps[4] = 0xEC3608BC
		jps[7] = "物品图标.wdf"
	elseif jp == "将军1" then
		jps[4] = 0x1CA66D04
		jps[7] = "物品图标.wdf"
	elseif jp == "和尚2" then
		jps[4] = 0x2B43EB3E
		jps[7] = "物品图标.wdf"
	elseif jp == "和尚1" then
		jps[4] = 0xB365FAC7
		jps[7] = "物品图标.wdf"
	elseif jp == "南极仙翁" then
		jps[4] = 810436942
		jps[7] = "物品图标.wdf"
	elseif jp == "唐僧" then
		jps[4] = 2279413445
		jps[7] = "物品图标.wdf"
	elseif jp == "孙悟空" then
		jps[4] = 0x3FA3472C
		jps[7] = "物品图标.wdf"
	elseif jp == "猪八戒" then
		jps[4] = 0x93557CA2
		jps[7] = "物品图标.wdf"
	elseif jp == "沙僧" then
		jps[4] = 0x40488B18
		jps[7] = "物品图标.wdf"
	elseif jp == "福星" then
		jps[4] = 0x279B729D
		jps[7] = "物品图标.wdf"
	elseif jp == "帮派妖兽" then
		jps[4] = 0x49A7562B
		jps[7] = "物品图标.wdf"
	elseif jp == "吴刚" then
		jps[4] = 0xEB321EDA
		jps[7] = "物品图标.wdf"
	elseif jp == "皇帝" then
		jps[4] = 0xBBA4ED07
		jps[7] = "物品图标.wdf"
	elseif jp == "周杰伦" then
		jps[4] = 0x962BD68A
		jps[7] = "物品图标.wdf"
	elseif jp == "木桩" then
		jps[4] = 0x962BD68A
		jps[7] = "物品图标.wdf"
	elseif jp == "银两" then
		jps[4] = 0x3F3F5DD1
		jps[7] = "物品图标.wdf"
	elseif jp == "物件_打铁炉" then
		jps[4] = 2074974822
		jps[7] = "普通模型.wdf"
	elseif jp == "食物" then
		jps[4] = 0x33BBE002
		jps[7] = "物品图标.wdf"
	elseif jp == "口粮" then
		jps[4] = 0X33BBE002
		jps[7] = "物品图标.wdf"
	elseif jp == "摄妖香" then
		jps[4] = 0xF0643AC7
		jps[7] = "物品图标.wdf"
	elseif jp == "药品" then
		jps[4] = 0x1E547A7E
		jps[7] = "物品图标.wdf"



	elseif jp == "影精灵" then
		jps[2] = 0x10000347--{"影精灵x44","影精灵x44_2","影精灵x44_3","影精灵x44_4"}
		jps[3] = 0x10000351--{"影精灵背包","影精灵背包_2","影精灵背包_3","影精灵背包_4"}
		jps[4] = 0x10000355--243X193
		jps[5] = 0x10000307--65X65
		jps[6] = 0x10000355--222X211
		jps[7] = "yjlsc.wdf"

	elseif jp == "刑天"  then   -----九黎
		jps[1] = 0x10000785
		jps[2] = 0x10000786
		jps[4] = 0x10000787
		jps[7] = "yjlsc.wdf"
		jps[99] = {0x10000787,0x10000788,0x10000789,0x10000790,0x10000791}
	elseif jp == "风祖飞廉"  then  -----九黎
		jps[1] = 0x10000805
		jps[2] = 0x10000806
		jps[4] = 0x10000801
		jps[7] = "yjlsc.wdf"
		jps[99] = {0x10000801,0x10000802,0x10000803,0x10000804}
	elseif jp == "食铁兽"  then
		jps[1] =  0x10000773
		jps[2] =  0x10000774
		jps[4] =  0x10000768
		jps[7] = "yjlsc.wdf"
		jps[99] = {0x10000768,0x10000769,0x10000770,0x10000771,0x10000772}

--########################################################?自己修改?##########################################
    else
    	jps[1] = 3043937193
		jps[2] = 864688647
		jps[4] = 4048229990
		jps[7] = "物品图标.wdf"
		jps[8] = "物品图标.wdf"
		jps[10] = "物品图标.wdf"
	end
	if not jps[1] then
		jps[1] = 3043937193
	end
	if not jps[2] then
		jps[2] = 864688647
	end
	if not jps[4] then
		jps[4] = 4048229990
	end
	if not jps[7] then
		jps[7] = "物品图标.wdf"
	end



	return jps
end

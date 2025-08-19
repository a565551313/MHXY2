--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-02 02:01:34
--======================================================================--
function 引擎.取音效(yx)
	local yxs = {}
	-----------------------------------------------------------------------------------------------------------人物音效
		if yx == "飞燕女" then
		yxs = {攻击=0x8D07C630,挨打=0x5CE4D624,施法=0x00E5E050,防御=0x1A35AEDA,死亡=0x6D81CA3B,资源="sound.wdf"}
		elseif yx == "飞燕女_环圈" then
		yxs = {攻击=0x8D07C630,挨打=0x5CE4D624,施法=0x00E5E050,防御=0x1A35AEDA,死亡=0x6D81CA3B,资源="sound.wdf"}
		elseif yx == "飞燕女_双短剑" then
		yxs = {攻击=0xDA2F70D2,挨打=0x87D6DB09,施法=0x4E2FA831,防御=0xE5FEE391,死亡=0x970200BA,资源="sound.wdf"}

		elseif yx == "英女侠" then
		yxs = {攻击=0x9B3F9ABE,挨打=0xB1634ECE,施法=0x9B353987,防御=0x9A06B5F8,死亡=0x7BE67DCD,资源="sound.wdf"}
		elseif yx == "英女侠_双短剑" then
		yxs = {攻击=0x9B3F9ABE,挨打=0xB1634ECE,施法=0x9B353987,防御=0x9A06B5F8,死亡=0x7BE67DCD,资源="sound.wdf"}
		elseif yx == "英女侠_鞭" then
		yxs = {攻击=0x9B3F9ABE,挨打=0xB1634ECE,施法=0x9B353987,防御=0x3EEC0360,死亡=0x7BE67DCD,资源="sound.wdf"}

		elseif yx == "巫蛮儿" then
		yxs = {攻击=0xC4FD75A8,挨打=0x8FB12C3F,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "巫蛮儿_法杖" then
		yxs = {攻击=0xC4FD75A8,挨打=0x8FB12C3F,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "巫蛮儿_宝珠" then
		yxs = {攻击=0xC4FD75A8,挨打=0x8FB12C3F,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}

		elseif yx == "偃无师" then
		yxs = {攻击=0x17E18D73,挨打=0x093F94E4,施法=0x131B52D5,防御=0x07E26E1D,死亡=0x4F1D43F8,资源="sound.wdf"}
		elseif yx == "偃无师_巨剑" then
		yxs = {攻击=0x17E18D73,挨打=0x093F94E4,施法=0x131B52D5,防御=0x07E26E1D,死亡=0x4F1D43F8,资源="sound.wdf"}
		elseif yx == "偃无师_剑" then
		yxs = {攻击=0xCDBC5B50,挨打=0x837A7CC6,施法=0x758B5E56,防御=0x8D30EA0D,死亡=0x616EF73A,资源="sound.wdf"}

		elseif yx == "逍遥生" or yx == "彩蝶男孩"  then
		yxs = {攻击=0x74FA3644,挨打=0x9DE15357,施法=0x78014430,防御=0xF0EF43B4,死亡=0x1EEF0B4D,资源="sound.wdf"}
		elseif yx == "逍遥生_剑" then
		yxs = {攻击=0x74FA3644,挨打=0x9DE15357,施法=0x78014430,防御=0xF0EF43B4,死亡=0x1EEF0B4D,资源="sound.wdf"}
		elseif yx == "逍遥生_扇" then
		yxs = {攻击=0xF002353C,挨打=0x265EB335,施法=0xDF489E5A,防御=0x06E94050,死亡=0x59A0AD28,资源="sound.wdf"}

		elseif yx == "剑侠客" then
		yxs = {攻击=0x17E18D73,挨打=0x093F94E4,施法=0x131B52D5,防御=0x07E26E1D,死亡=0x4F1D43F8,资源="sound.wdf"}
		elseif yx == "剑侠客_刀" then
		yxs = {攻击=0x17E18D73,挨打=0x093F94E4,施法=0x131B52D5,防御=0x07E26E1D,死亡=0x4F1D43F8,资源="sound.wdf"}
		elseif yx == "剑侠客_剑" then
		yxs = {攻击=0xCDBC5B50,挨打=0x837A7CC6,施法=0x758B5E56,防御=0x8D30EA0D,死亡=0x616EF73A,资源="sound.wdf"}


		elseif yx == "狐美人" then
		yxs = {攻击=0x5F4CAE8D,挨打=0x8FB12C3F,施法=0x2FE29187,防御=0x5856D5AC,死亡=0x0D47CD0F,资源="sound.wdf"}
		elseif yx == "狐美人_鞭" then
		yxs = {攻击=0x5F4CAE8D,挨打=0x8FB12C3F,施法=0x2FE29187,防御=0x5856D5AC,死亡=0x0D47CD0F,资源="sound.wdf"}
		elseif yx == "狐美人_爪刺" then
		yxs = {攻击=0xBA882151,挨打=0xEF60B8F2,施法=0x3E7DA76E,防御=0xB4C9A8E0,死亡=0x218D2A2C,资源="sound.wdf"}

		elseif yx == "骨精灵" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "骨精灵_魔棒" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "骨精灵_爪刺" then
		yxs = {攻击=0x1DC5C317,挨打=0x91E9EB7B,施法=0x3E51C7DA,防御=0xDB75ABC8,死亡=0x3C887DDF,资源="sound.wdf"}
		elseif yx == "影精灵" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "影精灵_双斧" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "影精灵_魔棒" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "影精灵_爪刺" then
		yxs = {攻击=0x1DC5C317,挨打=0x91E9EB7B,施法=0x3E51C7DA,防御=0xDB75ABC8,死亡=0x3C887DDF,资源="sound.wdf"}

		elseif yx == "鬼潇潇" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "鬼潇潇_伞" then
		yxs = {攻击=0x68DBA74A,挨打=0xC00F60E5,施法=0xBF13CC2B,防御=0xE73EBCC8,死亡=0x60FAD7D4,资源="sound.wdf"}
		elseif yx == "鬼潇潇_爪刺" then
		yxs = {攻击=0x1DC5C317,挨打=0x91E9EB7B,施法=0x3E51C7DA,防御=0xDB75ABC8,死亡=0x3C887DDF,资源="sound.wdf"}

		elseif yx == "杀破狼" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "杀破狼_宝珠" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "杀破狼_弓弩" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "杀破狼_弓弩1" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}

		elseif yx == "虎头怪" then
		yxs = {攻击=0x841369B5,挨打=0xACD043F0,施法=0xF2C5A3CD,防御=0xA8ADC9AC,死亡=0xE15F9806,资源="sound.wdf"}
		elseif yx == "虎头怪_锤" then
		yxs = {攻击=0x841369B5,挨打=0xACD043F0,施法=0xF2C5A3CD,防御=0xA8ADC9AC,死亡=0xE15F9806,资源="sound.wdf"}
		elseif yx == "虎头怪_斧钺" then
		yxs = {攻击=0x4AA34783,挨打=0x7C6CC4E7,施法=0x8D88CDAC,防御=0x0B26B4AF,死亡=0xAFC70B91,资源="sound.wdf"}

		elseif yx == "巨魔王" then
		yxs = {攻击=0x025FCC8B,挨打=0x369FA868,施法=0x55389EED,防御=0xB73D1C5B,死亡=0x8A7637EE,资源="sound.wdf"}
		elseif yx == "巨魔王_斧钺" then
		yxs = {攻击=0x025FCC8B,挨打=0x369FA868,施法=0x55389EED,防御=0xB73D1C5B,死亡=0x8A7637EE,资源="sound.wdf"}
		elseif yx == "巨魔王_刀" then
		yxs = {攻击=0x28642ACE,挨打=0x5476654C,施法=0xFE8594E2,防御=0xDFB7A019,死亡=0x9DAF226A,资源="sound.wdf"}


		elseif yx == "舞天姬" then
		yxs = {攻击=0x2FF674EE,挨打=0x4CCAEE4D,施法=0xB865C712,防御=0xF836A9DB,死亡=0x0C3694B7,资源="sound.wdf"}
		elseif yx == "舞天姬_飘带" then
		yxs = {攻击=0x2FF674EE,挨打=0x4CCAEE4D,施法=0xB865C712,防御=0xF836A9DB,死亡=0x0C3694B7,资源="sound.wdf"}
		elseif yx == "舞天姬_环圈" then
		yxs = {攻击=0x3D9E3182,挨打=0xEDEEF46B,施法=0xF4DE8179,防御=0x8F939D62,死亡=0xEA8D6634,资源="sound.wdf"}

		elseif yx == "玄彩娥" or yx == "彩蝶女孩" then
		yxs = {攻击=0xC4FD75A8,挨打=0x249F1445,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "玄彩娥_魔棒" then
		yxs = {攻击=0xC4FD75A8,挨打=0x249F1445,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "玄彩娥_飘带" then
		yxs = {攻击=0xE6072A32,挨打=0x837941C0,施法=0x893F0FB4,防御=0x84D6DE9E,死亡=0x5BF1BAAB,资源="sound.wdf"}

		elseif yx == "桃夭夭" then
		yxs = {攻击=0xC4FD75A8,挨打=0x249F1445,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "桃夭夭_灯笼" then
		yxs = {攻击=0xC4FD75A8,挨打=0x249F1445,施法=0x6AD3D5D3,防御=0xFC029511,死亡=0x5BF1BAAB,资源="sound.wdf"}
		elseif yx == "桃夭夭_飘带" then
		yxs = {攻击=0xE6072A32,挨打=0x837941C0,施法=0x893F0FB4,防御=0x84D6DE9E,死亡=0x5BF1BAAB,资源="sound.wdf"}

		elseif yx == "羽灵神" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "羽灵神_法杖" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "羽灵神_弓弩" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "羽灵神_弓弩1" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}

		elseif yx == "龙太子" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "龙太子_扇" then
		yxs = {攻击=0x0BAC8762,挨打=0xCB139041,施法=0xB31C5987,防御=0xDCB60BED,死亡=0x928CE1E1,资源="sound.wdf"}
		elseif yx == "龙太子_枪矛" then
		yxs = {攻击=0x00085193,挨打=0xED605E67,施法=0xDF2D05C9,防御=0x6C9F6213,死亡=0xF904345D,资源="sound.wdf"}

		elseif yx == "神天兵" then
		yxs = {攻击=0x81B89F88,挨打=0x2E7C9873,施法=0xB4005117,防御=0x05DE025C,死亡=0x271F03E8,资源="sound.wdf"}
		elseif yx == "神天兵_枪矛" then
		yxs = {攻击=0x81B89F88,挨打=0x2E7C9873,施法=0xB4005117,防御=0x05DE025C,死亡=0x271F03E8,资源="sound.wdf"}
		elseif yx == "神天兵_锤" then
		yxs = {攻击=0x27486A5C,挨打=0xB55DC704,施法=0xD0566D8B,防御=0xFC9BB005,死亡=0xDB274D75,资源="sound.wdf"}
	-----------------------------------------------------------------------------------------------------------人物音效

	-----------------------------------------------------------------------------------------------------------宠物音效
		elseif yx == "泡泡"  then
		yxs = {死亡=2069724230,挨打=4055472634,施法=2322934290,攻击=3876088364,防御=112926784,资源="sound.wdf"}
        elseif yx == "恶魔泡泡"  then
		yxs = {死亡=2069724230,挨打=4055472634,施法=2322934290,攻击=3876088364,防御=112926784,资源="sound.wdf"}
		elseif yx == "超级飞廉"  then
		yxs = {死亡=0,攻击=0x2A06235C,挨打=0x82C78C10,施法=0x9269D193,防御=0xABAB2922,资源="sound.wdf"}
		elseif yx == "自在心猿" then
		yxs = {攻击=0x5380F79F,暴击=0x5380F79F,挨打=0x6C7F397F,施法=0x9616A05D,防御=0xCC84FA0E,死亡=0x4E6CB35C,资源="sound.wdf"}
		elseif yx == "进阶沙暴" then
		yxs = {死亡=511113157,挨打=4135167637,施法=0xFBA099F0,攻击=1776209400,防御=2880121122,资源="sound.wdf"}
		elseif yx == "超级红孩儿" then
		yxs = {攻击=0x00085193,挨打=0xED605E67,施法=0xDF2D05C9,防御=0x6C9F6213,死亡=0xF904345D,资源="sound.wdf"}
		elseif yx == "超级神柚" then
		yxs = {死亡=0,挨打=3519019586,施法=3837633016,攻击=4160726282,防御=2880121122,资源="sound.wdf"}
		elseif yx == "大海龟" then
		yxs = {死亡=871240528,挨打=3131487772,施法=2707547291,攻击=2127205477,防御=3957482735,资源="sound.wdf"}
		elseif yx == "巨蛙" then
		yxs = {死亡=2999070547,挨打=1795177224,施法=1888910843,攻击=3008582154,防御=3414599612,资源="sound.wdf"}
		elseif yx == "海毛虫" then
		yxs = {死亡=838273552,挨打=4035138027,施法=1553258660,攻击=1590450855,防御=3631720163,资源="sound.wdf"}
		elseif yx == "海星" then
		yxs = {死亡=0,挨打=2194115600,施法=1437469676,攻击=34505741,防御=2880121122,资源="sound.wdf"}
		elseif yx == "章鱼" then
		yxs = {死亡=0,挨打=2194115600,施法=7452289,攻击=52752290,防御=52752290,资源="sound.wdf"}
		elseif yx == "浣熊" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=2194115600,防御=2880121122,资源="sound.wdf"}
		elseif yx == "树怪" then
		yxs = {死亡=1668550238,挨打=350566834,施法=3303750905,攻击=3618060822,防御=1459245093,资源="sound.wdf"}
		elseif yx == "野猪" then
		yxs = {死亡=194273491,挨打=3721479617,施法=2574066915,攻击=1685697597,防御=3636788168,资源="sound.wdf"}
		elseif yx == "赌徒" then
		yxs = {死亡=563557440,挨打=2978707923,施法=1485725321,攻击=1485725321,防御=3756606716,资源="sound.wdf"}
		elseif yx == "山贼" then
		yxs = {死亡=943533248,挨打=1293847218,施法=16908835,攻击=3321555335,防御=2880121122,资源="sound.wdf"}
		elseif yx == "强盗" then
		yxs = {死亡=3124902859,挨打=814292021,施法=3339097640,攻击=3943194138,防御=1179874618,资源="sound.wdf"}
		elseif yx == "大蝙蝠" then
		yxs = {死亡=3421749718,挨打=1245546270,施法=1666501049,攻击=3518277960,防御=3102202973,资源="sound.wdf"}
		elseif yx == "护卫" then
		yxs = {死亡=511113157,挨打=1557199780,施法=2732679302,攻击=2334207220,防御=1754055816,资源="sound.wdf"}
		elseif yx == "骷髅怪" then
		yxs = {死亡=3560494956,挨打=1245546270,施法=523531882,攻击=818944834,防御=784784891,资源="sound.wdf"}
		elseif yx == "羊头怪" then
		yxs = {死亡=319998428,挨打=1178246524,施法=1177119848,攻击=2516357468,防御=2661218083,资源="sound.wdf"}
		elseif yx == "蛤蟆精" then
		yxs = {死亡=1431920351,挨打=602028705,施法=393201907,攻击=1276533297,防御=1570262764,资源="sound.wdf"}
		elseif yx == "老虎" then
		yxs = {死亡=652298838,挨打=1050657571,施法=1219687599,攻击=2043984545,防御=1710948577,资源="sound.wdf"}
		elseif yx == "黑熊" then
		yxs = {死亡=490810214,挨打=2822661914,施法=3083387154,攻击=4259283484,防御=3603070735,资源="sound.wdf"}
		elseif yx == "花妖" then
		yxs = {死亡=3042612186,挨打=1867247498,施法=2972372550,攻击=3143425208,防御=2633715194,资源="sound.wdf"}
		elseif yx == "狐狸精" then
		yxs = {死亡=624071037,挨打=2255953070,施法=3538259135,攻击=3652014537,防御=447335069,资源="sound.wdf"}
		elseif yx == "牛妖" or yx == "牛幺" then
		yxs = {死亡=3212655002,挨打=925054982,施法=1954866876,攻击=2637302114,防御=48383547,资源="sound.wdf"}
		elseif yx == "小龙女" then
		yxs = {死亡=1591572490,挨打=3049184326,施法=3049184326,攻击=789882072,防御=3547355172,资源="sound.wdf"}
		elseif yx == "野鬼" then
		yxs = {死亡=2007276527,挨打=621481322,施法=3750445058,攻击=1079371167,防御=1079371167,资源="sound.wdf"}
		elseif yx == "狼" then
		yxs = {死亡=2708113174,挨打=3133455853,施法=3842906130,攻击=3316056138,防御=475350356,资源="sound.wdf"}
		elseif yx == "虾兵" then
		yxs = {死亡=1261853798,挨打=1587602365,施法=3627563328,攻击=561385427,防御=1668221049,资源="sound.wdf"}
		elseif yx == "蟹将" then
		yxs = {死亡=2861076852,挨打=1315200530,施法=780788950,攻击=484676069,防御=1326035271,资源="sound.wdf"}
		elseif yx == "龟丞相" then
		yxs = {死亡=388532813,挨打=2685029276,施法=4060523007,攻击=2646214528,防御=3496984894,资源="sound.wdf"}
		elseif yx == "兔子怪" then
		yxs = {死亡=3070774280,挨打=2547845711,施法=1981901691,攻击=2302249515,防御=12321819,资源="sound.wdf"}
		elseif yx == "蜘蛛精" then
		yxs = {死亡=407080408,挨打=1015767490,施法=930686860,攻击=1618653484,防御=3083137918,资源="sound.wdf"}
		elseif yx == "黑熊精" then
		yxs = {死亡=1759306014,挨打=4245326009,施法=827568683,攻击=3989023880,防御=3173669447,资源="sound.wdf"}
		elseif yx == "僵尸" then
		yxs = {死亡=389403591,挨打=2974405975,施法=2197612092,攻击=19687065,防御=4070699672,资源="sound.wdf"}
		elseif yx == "牛头" then
		yxs = {死亡=3373303673,挨打=2032596974,施法=2925753758,攻击=3349447201,防御=3150225918,资源="sound.wdf"}
		elseif yx == "马面" then
		yxs = {死亡=543104812,挨打=4079987514,施法=780788950,攻击=1888054507,防御=563150282,资源="sound.wdf"}
		elseif yx == "雷鸟人" or yx == "进阶雷鸟人" then
		yxs = {死亡=3672377755,挨打=1509049151,施法=3775307605,攻击=3237925644,防御=2798717351,资源="sound.wdf"}
		elseif yx == "蝴蝶仙子" or yx == "进阶蝴蝶仙子" then
		yxs = {死亡=4016824274,挨打=3760228976,施法=1568204826,攻击=1275875469,防御=4112272317,资源="sound.wdf"}
		elseif yx == "古代瑞兽" or yx == "进阶古代瑞兽" then
		yxs = {死亡=2869533871,挨打=3272663421,施法=640035134,攻击=2869533871,防御=2192138994,资源="sound.wdf"}
		elseif yx == "白熊" or yx == "进阶白熊" then
		yxs = {死亡=2141423483,挨打=1753531635,施法=1950310209,攻击=3715878608,防御=2234245875,资源="sound.wdf"}
		elseif yx == "黑山老妖" or yx == "进阶黑山老妖" then
		yxs = {死亡=2636731460,挨打=3799816302,施法=1727732694,攻击=4203145572,防御=3220309884,资源="sound.wdf"}
		elseif yx == "天兵" or yx == "进阶天兵" or yx == "影卫" then
		yxs = {死亡=367923792,挨打=2411204702,施法=2562583651,攻击=3865709012,防御=1912915351,资源="sound.wdf"}
		elseif yx == "天将" or yx == "进阶天将" then
		yxs = {死亡=2453907670,挨打=3490324928,施法=4200965191,攻击=628525694,防御=1251547833,资源="sound.wdf"}
		elseif yx == "地狱战神" or yx == "进阶地狱战神" then
		yxs = {死亡=1711283247,挨打=746002057,施法=4218442141,攻击=1570228677,防御=1897410428,资源="sound.wdf"}
		elseif yx == "风伯" or yx == "进阶风伯" then
		yxs = {死亡=51091117,挨打=1269429483,施法=3647964645,攻击=2393779394,防御=2215513543,资源="sound.wdf"}
		elseif yx == "凤凰" or yx == "进阶凤凰" then
		yxs = {死亡=802634997,挨打=2893660229,施法=2242027434,攻击=4180273224,防御=865894152,资源="sound.wdf"}
		elseif yx == "蛟龙" or yx == "进阶蛟龙" then
		yxs = {死亡=3329377485,挨打=2970665478,施法=1959454355,攻击=1222830518,防御=931042917,资源="sound.wdf"}
		elseif yx == "雨师" or yx == "进阶雨师" or yx == "司雨" or yx == "进阶司雨"then
		yxs = {死亡=3573873885,挨打=1459468329,施法=7452289,攻击=3708916370,防御=1748656363,资源="sound.wdf"}
		elseif yx == "蚌精" or yx == "进阶蚌精" then
		yxs = {死亡=0,挨打=1389231832,施法=3837633016,攻击=705045340,防御=2880121122,资源="sound.wdf"}
		elseif yx == "鲛人" or yx == "进阶鲛人" then
		yxs = {死亡=0,挨打=3569051100,施法=3837633016,攻击=159830263,防御=2880121122,资源="sound.wdf"}
		elseif yx == "碧水夜叉" or yx == "进阶碧水夜叉" then
		yxs = {死亡=0,挨打=3837633016,施法=3837633016,攻击=653574113,防御=2880121122,资源="sound.wdf"}
		elseif yx == "如意仙子" or yx == "进阶如意仙子" then
		yxs = {死亡=4021736912,挨打=2609187034,施法=364403254,攻击=2982724910,防御=4183002674,资源="sound.wdf"}
		elseif yx == "芙蓉仙子" or yx == "进阶芙蓉仙子" then
		yxs = {死亡=3960602968,挨打=1710537164,施法=4210261291,攻击=818418342,防御=3853960820,资源="sound.wdf"}
		elseif yx == "巡游天神" or yx == "进阶巡游天神" then
		yxs = {死亡=583330905,挨打=741807116,施法=4227780475,攻击=2296360938,防御=1728600899,资源="sound.wdf"}
		elseif yx == "星灵仙子" or yx == "进阶星灵仙子" then
		yxs = {死亡=1540473805,挨打=2834322465,施法=4155523088,攻击=1268762037,防御=3765776993,资源="sound.wdf"}
		elseif yx == "锦毛貂精" or yx == "进阶锦毛貂精" then
		yxs = {死亡=0,挨打=495028856,施法=3832438398,攻击=3832438398,防御=2880121122,资源="sound.wdf"}
		elseif yx == "千年蛇魅" or yx == "进阶千年蛇魅" then
		yxs = {死亡=0,挨打=1715665584,施法=3837633016,攻击=190071159,防御=2880121122,资源="sound.wdf"}
		elseif yx == "犀牛将军兽形" or yx == "犀牛将军人形" or yx == "进阶犀牛将军兽形" or yx == "进阶犀牛将军人形" then
		yxs = {死亡=2999070547,挨打=4135167637,施法=3837633016,攻击=1776209400,防御=2880121122,资源="sound.wdf"}
		elseif yx == "野猪精" or yx == "进阶野猪精" then
		yxs = {死亡=194273491,挨打=3721479617,施法=2574066915,攻击=1685697597,防御=3636788168,资源="sound.wdf"}
		elseif yx == "鼠先锋" or yx == "进阶鼠先锋" then
		yxs = {死亡=3144522577,挨打=3712770835,施法=1503709144,攻击=4081372887,防御=2880121122,资源="sound.wdf"}
		elseif yx == "百足将军" or yx == "进阶百足将军" then
		yxs = {死亡=996019855,挨打=1929768413,施法=266523058,攻击=2649300220,防御=2880121122,资源="sound.wdf"}
		elseif yx == "镜妖" or yx == "进阶镜妖"  then
		yxs = {死亡=3144522577,挨打=3712770835,施法=1503709144,攻击=4081372887,防御=2880121122,资源="sound.wdf"}
		elseif yx == "泪妖" or yx == "进阶泪妖" then
		yxs = {死亡=2999070547,挨打=1710537164,施法=4221606384,攻击=804680942,防御=3414599612,资源="sound.wdf"}
		elseif yx == "律法女娲" or yx == "进阶律法女娲" then
		yxs = {死亡=4255712904,挨打=1873908350,施法=3341541225,攻击=1540887421,防御=2880121122,资源="sound.wdf"}
		elseif yx == "灵符女娲" or yx == "进阶灵符女娲" then
		yxs = {死亡=0,挨打=2160835279,施法=4221606384,攻击=3332257767,防御=2880121122,资源="sound.wdf"}
		elseif yx == "幽灵" or yx == "进阶幽灵" then
		yxs = {死亡=2610842059,挨打=2139087151,施法=1270233730,攻击=1923445066,防御=2880121122,资源="sound.wdf"}
		elseif yx == "吸血鬼" or yx == "进阶吸血鬼" then
		yxs = {死亡=656318663,挨打=3078005202,施法=177375547,攻击=2289549345,防御=3997612676,资源="sound.wdf"}
		elseif yx == "阴阳伞" or yx == "进阶阴阳伞" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=2547905352,防御=2880121122,资源="sound.wdf"}
		elseif yx == "鬼将" or yx == "进阶鬼将"  or yx == "迭代鬼将" or yx == "进阶迭代鬼将" then
		yxs = {死亡=1416021503,挨打=3628019536,施法=776657085,攻击=628825018,防御=2880121122,资源="sound.wdf"}
		elseif yx == "净瓶女娲" or yx == "进阶净瓶女娲" then
		yxs = {死亡=1181749929,挨打=3439683191,施法=3341541225,攻击=3332257767,防御=2880121122,资源="sound.wdf"}
		elseif yx == "画魂" or yx == "进阶画魂"  then
		yxs = {死亡=0,挨打=3439683191,施法=1057608231,攻击=2606196116,防御=2423858235,资源="sound.wdf"}
		elseif yx == "幽萤娃娃" or yx == "进阶幽萤娃娃"  then
		yxs = {死亡=0,挨打=3519019586,施法=1867036243,攻击=2096418495,防御=2880121122,资源="sound.wdf"}
		elseif yx == "雾中仙" or yx == "进阶雾中仙" then
		yxs = {死亡=2382579566,挨打=2493182138,施法=1057608231,攻击=4226488868,防御=2880121122,资源="sound.wdf"}
		elseif yx == "灵鹤" or yx == "进阶灵鹤"then
		yxs = {死亡=3568179012,挨打=690082626,施法=1758652696,攻击=4094384674,防御=2880121122,资源="sound.wdf"}
		elseif yx == "炎魔神" or yx == "进阶炎魔神" then
		yxs = {死亡=1308418699,挨打=291502600,施法=3653656369,攻击=1973126590,防御=2880121122,资源="sound.wdf"}
		elseif yx == "噬天虎" or yx == "进阶噬天虎" then
		yxs = {死亡=1387891793,挨打=3491671125,施法=26937970,攻击=132336716,防御=2880121122,资源="sound.wdf"}
		elseif yx == "大力金刚" or yx == "进阶大力金刚" or yx == "迭代金刚" or yx == "进阶迭代金刚" then
		yxs = {死亡=1251425422,挨打=1532537522,施法=3414094801,攻击=3162946826,防御=2880121122,资源="sound.wdf"}
		elseif yx == "夜罗刹" or yx == "进阶夜罗刹" then
		yxs = {死亡=3874120041,挨打=1873908350,施法=2020017406,攻击=1050928977,防御=2880121122,资源="sound.wdf"}
		elseif yx == "琴仙" or yx == "进阶琴仙" then
		yxs = {死亡=3960602968,挨打=1710537164,施法=1015578079,攻击=3304945064,防御=3853960820,资源="sound.wdf"}
		elseif yx == "金铙僧" or yx == "进阶金铙僧" then
		yxs = {死亡=389403591,挨打=2974405975,施法=2197612092,攻击=19687065,防御=4070699672,资源="sound.wdf"}
		elseif yx == "踏云兽" or yx == "进阶踏云兽" or yx == "牛虱" then
		yxs = {死亡=3569227376,挨打=594622824,施法=1427173121,攻击=1358395955,防御=2880121122,资源="sound.wdf"}
		elseif yx == "红萼仙子" or yx == "进阶红萼仙子" then
		yxs = {死亡=0,挨打=1923679999,施法=1543411045,攻击=190071159,防御=1923679999,资源="sound.wdf"}
		elseif yx == "蝎子精" or yx == "进阶蝎子精" then
		yxs = {死亡=0,挨打=2729136424,施法=656200786,攻击=4081372887,防御=2880121122,资源="sound.wdf"}
		elseif yx == "葫芦宝贝" or yx == "进阶葫芦宝贝" then
		yxs = {死亡=0,挨打=3519019586,施法=3837633016,攻击=4160726282,防御=2880121122,资源="sound.wdf"}
		elseif yx == "龙龟" or yx == "进阶龙龟" or yx == "谛听" or yx == "进阶谛听" or yx == "进阶谛听" then
		yxs = {死亡=2212267125,挨打=2194115600,施法=3081630765,攻击=1910937308,防御=2880121122,资源="sound.wdf"}
		elseif yx == "机关车" or yx == "进阶机关车" then
		yxs = {攻击=0x04C8EF50,挨打=0x04C8EF50,施法=0x4E6C91E0,防御=0xE4BDA1F8,死亡=0xABAB2922,资源="sound.wdf"}
		elseif yx == "机关人" or yx == "进阶机关人" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=78516386,防御=2880121122,资源="sound.wdf"}
		elseif yx == "猫灵兽形" or yx == "进阶猫灵兽形" then
		yxs = {死亡=0,挨打=2194115600,施法=1421404486,攻击=705045340,防御=2559105037,资源="sound.wdf"}
		elseif yx == "狂豹兽形" or yx == "进阶狂豹兽形" or yx == "狂豹人形" or yx == "进阶狂豹人形" then
		yxs = {死亡=0,挨打=3144614980,施法=3144614980,攻击=705045340,防御=2880121122,资源="sound.wdf"}
		elseif yx == "机关鸟" or yx == "进阶机关鸟" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=3531190471,防御=2880121122,资源="sound.wdf"}
		elseif yx == "机关兽" or yx == "进阶机关兽" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=2855753258,防御=2880121122,资源="sound.wdf"}
		elseif yx == "连弩车" or yx == "进阶连弩车" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=2798251516,防御=2880121122,资源="sound.wdf"}
		elseif yx == "巴蛇" or yx == "进阶巴蛇" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=352101457,防御=2880121122,资源="sound.wdf"}
		elseif yx == "长眉灵猴" or yx == "进阶长眉灵猴" then
		yxs = {死亡=487913509,挨打=3021936694,施法=2115031259,攻击=1929267837,防御=2880121122,资源="sound.wdf"}
		elseif yx == "巨力神猿" or yx == "进阶巨力神猿" then
		yxs = {死亡=487913509,挨打=3021936694,施法=668863761,攻击=1223183938,防御=2880121122,资源="sound.wdf"}
		elseif yx == "修罗傀儡鬼" or yx == "进阶修罗傀儡鬼" then
		yxs = {死亡=0,挨打=1873908350,施法=3341541225,攻击=3213730902,防御=2880121122,资源="sound.wdf"}
		elseif yx == "蔓藤妖花" or yx == "进阶蔓藤妖花" then
		yxs = {死亡=0,挨打=495028856,施法=3653656369,攻击=3465790549,防御=2880121122,资源="sound.wdf"}
		elseif yx == "蜃气妖" or yx == "进阶蜃气妖" then
		yxs = {死亡=0,挨打=2194115600,施法=1437469676,攻击=3959208329,防御=2880121122,资源="sound.wdf"}
		elseif yx == "猫灵人形" or yx == "进阶猫灵人形" then
		yxs = {死亡=0,挨打=64142213,施法=82170304,攻击=2641029083,防御=2559105037,资源="sound.wdf"}
		-- elseif yx == "狂豹人形" or yx == "进阶狂豹人形" then
		-- yxs = {死亡=652298838,挨打=1050657571,施法=1219687599,攻击=2043984545,防御=1710948577,资源="sound.wdf"}
		elseif yx == "混沌兽" or yx == "进阶混沌兽"  then
		yxs = {死亡=756393989,挨打=2809241142,施法=3464961617,攻击=4081372887,防御=2880121122,资源="sound.wdf"}
		elseif yx == "修罗傀儡妖" or yx == "进阶修罗傀儡妖" then
		yxs = {死亡=0,挨打=3960267172,施法=3341541225,攻击=236023717,防御=2880121122,资源="sound.wdf"}
		elseif yx == "金身罗汉" or yx == "进阶金身罗汉" then
		yxs = {死亡=0,挨打=4135167637,施法=3414094801,攻击=986965302,防御=986965302,资源="sound.wdf"}
		elseif yx == "曼珠沙华" or yx == "进阶曼珠沙华" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=83721517,防御=2880121122,资源="sound.wdf"}
		elseif yx == "灵灯侍者" or yx == "进阶灵灯侍者" then
		yxs = {死亡=389403591,挨打=2974405975,施法=2197612092,攻击=19687065,防御=4070699672,资源="sound.wdf"}
		elseif yx == "持国巡守" or yx == "进阶持国巡守" then
		yxs = {死亡=0,挨打=1532537522,施法=3414094801,攻击=3162946826,防御=2880121122,资源="sound.wdf"}
		elseif yx == "真陀护法" or yx == "进阶真陀护法" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=705045340,防御=2880121122,资源="sound.wdf"}
		elseif yx == "毗舍童子" or yx == "进阶毗舍童子"  or yx == "有苏鸠" or yx == "暗黑童子"  then
		yxs = {死亡=0,攻击=0x2A06235C,挨打=0x82C78C10,施法=0x9269D193,防御=0xABAB2922,资源="sound.wdf"}
		elseif yx == "增长巡守" or yx == "进阶增长巡守" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=705045340,防御=2880121122,资源="sound.wdf"}
		elseif yx == "般若天女" or yx == "进阶般若天女"  or yx == "飞天" or yx == "进阶飞天" or yx == "觉醒涂山雪" then
		yxs = {死亡=3960602968,挨打=1710537164,施法=1015578079,攻击=3304945064,防御=3853960820,资源="sound.wdf"}
		-----------------------------------------------------------------------------------------------------------宠物音效


		-----------------------------------------------------------------------------------------------------------NPC音效
		elseif yx == "帮派妖兽" then
		yxs = {死亡=0,挨打=1532537522,施法=76460801,攻击=76460801,防御=2880121122,资源="sound.wdf"}
		elseif yx == "知了王" then
		yxs = {死亡=0,挨打=2194115600,施法=1437469676,攻击=78516386,防御=2880121122,资源="sound.wdf"}
		elseif yx == "哮天犬" then
		yxs = {死亡=2708113174,挨打=3133455853,施法=3842906130,攻击=3316056138,防御=475350356,资源="sound.wdf"}
		elseif yx == "蚩尤" or yx == "进阶蚩尤" or yx == "蚩尤魔影"  then
		yxs = {攻击=0x5527B727,暴击=0x7D68A42E,挨打=0x7E6935F0,施法=0x3E86CF17,防御=0xABAB2922,死亡=0x622FA242,资源="sound.wdf"}
		elseif yx == "程咬金" then
		yxs = {死亡=511113157,挨打=1557199780,施法=2732679302,攻击=2334207220,防御=1754055816,资源="sound.wdf"}
		elseif yx == "空度禅师" then
		yxs = {死亡=3573873885,挨打=1459468329,施法=0x7E10D0DB,攻击=0x72FE4A7D,防御=1748656363,资源="sound.wdf"}
		elseif yx == "东海龙王" then
		yxs = {死亡=3329377485,挨打=2970665478,施法=1959454355,攻击=1222830518,防御=931042917,资源="sound.wdf"}
		elseif yx == "孙婆婆" then
		yxs = {死亡=3874120041,挨打=1873908350,施法=2020017406,攻击=1050928977,防御=2880121122,资源="sound.wdf"}
		elseif yx == "牛魔王" then
		yxs = {死亡=3569227376,挨打=594622824,施法=1427173121,攻击=1358395955,防御=2880121122,资源="sound.wdf"}
		elseif yx == "镇元大仙" then
		yxs = {死亡=51091117,挨打=1269429483,施法=3647964645,攻击=2393779394,防御=2215513543,资源="sound.wdf"}
		elseif yx == "菩提祖师" then
		yxs = {死亡=563557440,挨打=2978707923,施法=1485725321,攻击=1485725321,防御=3756606716,资源="sound.wdf"}
		elseif yx == "白晶晶" or yx == "春十三娘" then
		yxs = {死亡=3042612186,挨打=1867247498,施法=2972372550,攻击=3143425208,防御=2633715194,资源="sound.wdf"}
		elseif yx == "李靖" then
		yxs = {死亡=511113157,挨打=4135167637,施法=0xFBA099F0,攻击=1776209400,防御=2880121122,资源="sound.wdf"}
		elseif yx == "地藏王" then
		yxs = {死亡=3263486412,挨打=1315738080,施法=3045913148,攻击=2547905352,防御=2880121122,资源="sound.wdf"}
		elseif yx == "观音姐姐" then
		yxs = {死亡=1181749929,挨打=3439683191,施法=3341541225,攻击=3332257767,防御=2880121122,资源="sound.wdf"}
		elseif yx == "大大王" then
		yxs = {死亡=1387891793,挨打=3491671125,施法=26937970,攻击=132336716,防御=2880121122,资源="sound.wdf"}
		elseif yx == "地涌夫人"  then
		yxs = {死亡=0xCD056677,挨打=0x467012A9,施法=0xC72BDF69,攻击=0x9B2AAE02,防御=0xABAB2922,资源="sound.wdf"}
		elseif yx == "二郎神" then
		yxs = {死亡=0x2E7C9873,挨打=0x2E7C9873,施法=0xD0566D8B,攻击=0x81B89F88,防御=0xABAB2922,资源="sound.wdf"}
		elseif yx == "巫奎虎" then
		yxs = {死亡=0xBB6F0444,挨打=0xBB6F0444,施法=0x5B58AAB2,攻击=0x18122891,防御=0xABAB2922,资源="sound.wdf"}
		-----------------------------------------------------------------------------------------------------------NPC音效


        -----------------------------------------------------------------------------------------------------------孩子音效
		elseif yx == "小毛头" or yx == "进阶小毛头" then
		yxs = {攻击=0x4E3E787E,暴击=0x258C426C,挨打=0x694A6A02,施法=0x4E3E787E,防御=0xABAB2922,死亡=0xE93442EC,资源="sound.wdf"}
		elseif yx == "小丫丫" or yx == "进阶小丫丫" then
		yxs = {攻击=0xE422AE85,暴击=0xE422AE85,挨打=0x6E2AE110,施法=0x5DB8ECC0,防御=0xABAB2922,死亡=0xC66E0B78,资源="sound.wdf"}
		elseif yx == "小仙灵" or yx == "进阶小仙灵"  then
		yxs = {攻击=0x3B940879,暴击=0xF23AC3E3,挨打=0x21EE0152,施法=0x5DB8ECC0,防御=0xABAB2922,死亡=0x590FFB01,资源="sound.wdf"}
		elseif yx == "小仙女" or yx == "进阶小仙女" then
		yxs = {攻击=0xBE70C7D8,暴击=0xBE70C7D8,挨打=0x686773CF,施法=0x9269D193,防御=0xABAB2922,死亡=0x590FFB01,资源="sound.wdf"}
		elseif yx == "小精灵" or yx == "进阶小精灵" or yx == "超级猪小戒" or yx == "进阶超级猪小戒" then
		yxs = {攻击=0xF8A64313,暴击=0xF8A64313,挨打=0x1A1EDC49,施法=0x9269D193,防御=0xABAB2922,死亡=0x35AD9904,资源="sound.wdf"}
		elseif yx == "小魔头" or yx == "进阶小魔头" then
		yxs = {攻击=0xF344CED7,暴击=0xF344CED7,挨打=0xE5EBB797,施法=0x5DB8ECC0,防御=0xABAB2922,死亡=0x44DD663F,资源="sound.wdf"}
		-----------------------------------------------------------------------------------------------------------孩子音效


		-----------------------------------------------------------------------------------------------------------神兽音效
		elseif yx == "超级神虎" or yx == "超级神狗" or yx == "进阶超级神狗" then
		yxs = {死亡=652298838,挨打=1050657571,施法=1219687599,攻击=2043984545,防御=1710948577,资源="sound.wdf"}
		elseif yx == "超级神牛" then
		yxs = {死亡=0,挨打=925054982,施法=2456408467,攻击=810033887,防御=2880121122,资源="sound.wdf"}
		elseif yx == "超级赤焰兽" or yx == "超级神鼠" or yx == "进阶超级神鼠" then
		yxs = {死亡=3672377755,挨打=1509049151,施法=3775307605,攻击=3237925644,防御=2798717351,资源="sound.wdf"}
		elseif yx == "超级白泽" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=2260404585,防御=2880121122,资源="sound.wdf"}
		elseif yx == "超级青鸾" then
		yxs = {死亡=2372137339,挨打=3272663421,施法=640035134,攻击=2869533871,防御=2192138994,资源="sound.wdf"}
		elseif yx == "超级玉兔" then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=0x0023CACE,暴击=0x054C5638,防御=2880121122,资源="sound.wdf"}
		elseif yx == "超级海豚" or yx == "鲲鹏" or yx == "进阶鲲鹏"  then
		yxs = {死亡=0,挨打=2194115600,施法=2456408467,攻击=0x4D7EA2D5,暴击=0x2742826F,防御=1300144853,资源="sound.wdf"}
		elseif yx == "超级泡泡" or  yx == "泡泡仙灵·飞燕女"or  yx == "泡泡仙灵·骨精灵"  or  yx == "泡泡仙灵·剑侠客"  or  yx == "泡泡仙灵·龙太子" or  yx == "泡泡仙灵·杀破狼" or  yx == "泡泡仙灵·神天兵" or  yx == "泡泡仙灵·巫蛮儿" or  yx == "泡泡仙灵·羽灵神" then
		yxs = {攻击=0xA3BD4A03,暴击=0xD8942965,挨打=0xF1B999FA,施法=0x3027F161,防御=0x06BB2040,死亡=0x5270E9A3,资源="sound.wdf"}
		elseif yx == "超级大熊猫"  then
		yxs = {攻击=0xC5FAE987,暴击=0xC5FAE987,挨打=0x1126C263,施法=0xCDF0C355,防御=0xABAB2922,死亡=0x1D14F825,资源="sound.wdf"}
		elseif yx == "超级金猴" then
		yxs = {攻击=0xC5FAE987,暴击=0xC5FAE987,挨打=0x1126C263,施法=0xCDF0C355,防御=0xABAB2922,死亡=0x1D14F825,资源="sound.wdf"}
		elseif yx == "超级大象" or yx == "二大王" or yx == "超级神猪" or yx == "进阶超级神猪" then
		yxs = {攻击=0x7436E9E9,暴击=0x7436E9E9,挨打=0x21990613,施法=0x8C77E82D,防御=0xABAB2922,死亡=0xFD34EC3D,资源="sound.wdf"}
		elseif yx == "超级灵鹿" then
		yxs = {攻击=0x36A153F9,暴击=0x36A153F9,挨打=0x1CB6183D,施法=0x9269D193,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级大鹏" then
		yxs = {攻击=0xC0FED30C,暴击=0xC0FED30C,挨打=0x59F2433F,施法=0xE1069F55,防御=0xA6D109A7,死亡=0xDAE4099B,资源="sound.wdf"}
		elseif yx == "善财童子" then
		yxs = {攻击=0x86BB0969,暴击=0x86BB0969,挨打=0xD1BFFA42,施法=0x6F48B653,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级筋斗云" then
		yxs = {攻击=0xF23AC3E3,暴击=0x564F1090,挨打=0xA8DF3614,施法=0x9269D193,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级人参娃娃" then
		yxs = {攻击=0xCE93C455,暴击=0xCE93C455,挨打=0x8BD51EF7,施法=0x6F48B653,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级孔雀" then
		yxs = {攻击=0xF40B5A22,暴击=0xF40B5A22,挨打=0x2921D342,施法=0x68D2E918,防御=0xABAB2922,死亡=0xD4AE1744,资源="sound.wdf"}
		elseif yx == "超级灵狐"  then
		yxs = {攻击=0x2A06235C,暴击=0xC2152ECF,挨打=0x82C78C10,施法=0x54B8E946,防御=0x9888D80D,死亡=0,资源="sound.wdf"}
		elseif yx == "超级麒麟" then
		yxs = {攻击=0xAB099CAF,暴击=0xAB099CAF,挨打=0xC310E17D,施法=0x2626293E,防御=0x82A962F2,死亡=0x8D63F17B,资源="sound.wdf"}
		elseif yx == "超级六耳猕猴" then
		yxs = {攻击=0x5380F79F,暴击=0x5380F79F,挨打=0x6C7F397F,施法=0x9616A05D,防御=0xCC84FA0E,死亡=0x4E6CB35C,资源="sound.wdf"}
		elseif yx == "超级土地公公" then
		yxs = {死亡=487913509,挨打=3021936694,施法=2115031259,攻击=1929267837,防御=2880121122,资源="sound.wdf"}
		elseif yx == "超级神兔" then
		yxs = {攻击=0xDCDC131A,暴击=0xFD0CCC82,挨打=0xA395ED8B,施法=0x9269D193,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级神龙" or yx == "超级小白龙" or yx == "进阶超级小白龙" then
		yxs = {攻击=0xC6ECAB78,暴击=0xC6ECAB78,挨打=0x82C78C10,施法=0x318685B7,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级神蛇" or yx == "超级腾蛇" then
		yxs = {攻击=0x86BB0969,暴击=0x86BB0969,挨打=0x82C78C10,施法=0x4EF4DFD8,防御=0xABAB2922,死亡=0,资源="sound.wdf"}
		elseif yx == "超级神马" or yx == "龙马" then
		yxs = {攻击=0x578991A9,暴击=0x578991A9,挨打=0xF32FAB3A,施法=0x2E89E4D6,防御=0x2190FDCA,死亡=0x205F1F2C,资源="sound.wdf"}
		elseif yx == "超级神羊" then
		yxs = {攻击=0x95FC915C,暴击=0x95FC915C,挨打=0x463A9D7C,施法=0x46296C68,防御=0x9E9EF723,死亡=0x1312C9DC,资源="sound.wdf"}
		elseif yx == "超级神猴" then
		yxs = {攻击=0xC5FAE987,暴击=0xC5FAE987,挨打=0x1126C263,施法=0xCDF0C355,防御=0xABAB2922,死亡=0x1D14F825,资源="sound.wdf"}
		elseif yx == "超级神鸡" then
		yxs = {攻击=0xC0FED30C,暴击=0xC0FED30C,挨打=0x59F2433F,施法=0xE1069F55,防御=0xA6D109A7,死亡=0xDAE4099B,资源="sound.wdf"}

		-----------------------------------------------------------------------------------------------------------神兽音效

		-----------------------------------------------------------------------------------------------------------法术音效
		--孩子技能
		elseif yx == "还魂咒" then
		yxs = {资源="sound.wdf",文件=0x97283C40}
		elseif yx == "仙人指路" then
		yxs = {资源="sound.wdf",文件=0xFBD946FB}
		elseif yx == "四面埋伏" or yx == "食指大动" then
		yxs = {资源="sound.wdf",文件=0x1A67E919}
		elseif yx == "峰回路转" then
		yxs = {资源="sound.wdf",文件=0x53E82E61}
		--化圣技能
		elseif yx == "其疾如风" then
		yxs = {资源="sound.wdf",文件=1617017747}
		elseif yx == "其徐如林" then
		yxs = {资源="sound.wdf",文件=0x251670FB}
		elseif yx == "不动如山 " then
		yxs = {资源="sound.wdf",文件=0x52BA8E8D}
		elseif yx == "侵掠如火" then
		yxs = {资源="sound.wdf",文件=4104677014}
		elseif yx == "动物套效果" then
		yxs = {资源="sound.wdf",文件=0x04E42236}
		--特技
		elseif yx == "弱点击破" or yx == "破血狂攻" or yx == "千蛛噬魂" or yx == "琴音三叠"  then
		yxs = {资源="sound.wdf",文件=0x4B800708}
		elseif yx == "气疗术" or yx == "命疗术" or yx == "气归术" or yx == "命归术" then
		yxs = {资源="sound.wdf",文件=0x53E82E61}
		elseif yx == "凝气诀" or yx == "凝神诀" then
		yxs = {资源="sound.wdf",文件=0x4B800708}
		elseif yx == "水清诀" or yx == "冰清诀" or yx == "心疗术" then
		yxs = {资源="sound.wdf",文件=0xE6339003}
		elseif yx == "玉清诀" or yx == "晶清诀" then
		yxs = {资源="sound.wdf",文件=0xFBD946FB}
		elseif yx == "四海升平" then
		yxs = {资源="sound.wdf",文件=0x04E42236}
		elseif yx == "回魂咒" or yx == "起死回生" then
		yxs = {资源="sound.wdf",文件=0x97283C40}
		elseif yx == "野兽之力" or yx == "魔兽之印" then
		yxs = {资源="sound.wdf",文件=0x019B0A72}
		elseif yx == "光辉之甲" or yx == "圣灵之甲" then
		yxs = {资源="sound.wdf",文件=0x245321A8}
		elseif yx == "流云诀" or yx == "啸风诀" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "太极护法" or yx == "罗汉金钟" then
		yxs = {资源="sound.wdf",文件=0x3BF3590C}
		elseif yx == "破碎无双" then
		yxs = {资源="sound.wdf",文件=0x104B1B46}
		elseif yx == "笑里藏刀" then
		yxs = {资源="sound.wdf",文件=0xCE582B31}
		elseif yx == "绝幻魔音" then
		yxs = {资源="sound.wdf",文件=0xCE582B31}
		elseif yx == "修罗咒" then
		yxs = {资源="sound.wdf",文件=0x1A67E919}
		elseif yx == "天衣无缝" or yx == "流沙轻音" then
		yxs = {资源="sound.wdf",文件=0x40701F91}
		elseif yx == "放下屠刀" or yx == "河东狮吼" then
		yxs = {资源="sound.wdf",文件=0x426F46C8}
		elseif yx == "破甲术" or yx == "碎甲术" or yx == "凝滞术" or yx == "停陷术" then
		yxs = {资源="sound.wdf",文件=0x70F1E396}
		elseif yx == "慈航普渡" or yx == "百草神木复苏" or yx == "百草复苏"  or yx == "百草诀" or yx == "滋养" or yx == "焕生咒" or yx == "燃血术"  then
		yxs = {资源="sound.wdf",文件=0x084168D9}
		elseif yx == "冥王暴杀" then
		yxs = {资源="sound.wdf",文件=0x104B1B46}
		--大唐官府
		elseif yx == "后发制人" or yx == "先发制人"  then
		yxs = {资源="sound.wdf",文件=0x39D047A5}
		elseif yx == "杀气诀" or yx == "安神诀" then
		yxs = {资源="sound.wdf",文件=0x095B5FC6}
		elseif yx == "反间之计" then
		yxs = {资源="sound.wdf",文件=0x0B2ED764}
		elseif yx == "破釜沉舟_敌方" or yx == "破釜沉舟_我方" then
		yxs = {资源="sound.wdf",文件=0x795E59BA}
		elseif yx == "破釜沉舟" then
		yxs = {资源="sound.wdf",文件=819432687}
		elseif yx == "横扫千军" or yx == "武神怒击"  or  yx=="神来气旺" or  yx=="哼哼哈兮" or  yx=="水击三千"  then
		yxs = {资源="sound.wdf",文件=819432687}
		elseif yx == "千里神行" then
		yxs = {资源="sound.wdf",文件=81851589}
		elseif yx == "刀光剑影" then
		yxs = {资源="sound.wdf",文件=0x564F1090}
		elseif yx == "毁灭之光" then
		yxs = {资源="sound.wdf",文件=0x564F1090}
		elseif yx == "翩鸿一击" or yx == "长驱直入" or yx == "摧枯拉朽" then
		yxs = {资源="sound.wdf",文件=0x04E0F4C5}
		elseif yx == "斩龙诀" then
		yxs = {资源="sound.wdf",文件=0x795E59BA}
		--化生寺
		elseif yx == "推拿" or yx == "活血" or yx == "推气过宫" or yx == "妙悟" then
		yxs = {资源="sound.wdf",文件=82059830}
		elseif yx == "唧唧歪歪" or  yx == "谆谆教诲"  then
		yxs = {资源="sound.wdf",文件=3686303330}
		elseif yx == "金刚护法" or yx == "金刚护体" or yx == "诸天看护" or yx == "渡劫金身" or yx == "菩提心佑" then
		yxs = {资源="sound.wdf",文件=3231847826}
		elseif yx == "韦陀护法" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "我佛慈悲" then
		yxs = {资源="sound.wdf",文件=0x97283C40}
		elseif yx == "佛法无边" or yx == "紫气东来" then
		yxs = {资源="sound.wdf",文件=0x3E128ADA}
		elseif yx == "达摩护体" or yx == "身似菩提"  then
		yxs = {资源="sound.wdf",文件=0x084168D9}
		elseif yx == "一苇渡江" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "解毒" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		elseif yx == "舍身取义" or  yx == "绝处逢生" or yx == "百草古树长青" or yx == "百草十香" or yx == "百草定神"  or yx == "百草红雪" or yx == "百草回春龙沙"  then
		yxs = {资源="sound.wdf",文件=0xCE259E8C}
	   --龙宫
		elseif yx == "龙卷雨击" then
		yxs = {资源="sound.wdf",文件=2744863907}
		elseif yx == "龙吟" or yx == "龙啸九天" then
		yxs = {资源="sound.wdf",文件=2693627185}
		elseif yx == "龙腾" or  yx == "亢龙归海" then
		yxs = {资源="sound.wdf",文件=1426439228}
		elseif yx == "逆鳞" then
		yxs = {资源="sound.wdf",文件=0xC0A21592}
		elseif yx == "乘风破浪" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "解封" or yx == "清心" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		elseif yx == "二龙戏珠" then
		yxs = {资源="sound.wdf",文件=1871130489}
		elseif yx == "神龙摆尾" then
		yxs = {资源="sound.wdf",文件=0x64AAF170}
		-- elseif yx == "亢龙归海" then
		-- yxs = {资源="sound.wdf",文件=1326039389}
		elseif yx == "雷浪穿云" then
		yxs = {资源="sound.wdf",文件=0x040584F3}
		--魔王寨
		elseif yx == "摇头摆尾" then
		yxs = {资源="sound.wdf",文件=1427041343}
		elseif yx == "无敌牛虱" or yx == "无敌牛妖" then
		yxs = {资源="sound.wdf",文件=0x40E67E07}
		elseif yx == "火甲术" then
		yxs = {资源="sound.wdf",文件=0x3E2A375C}
		elseif yx == "飞砂走石" or yx == "秘传飞砂走石" then
		yxs = {资源="sound.wdf",文件=1427041343}
		elseif yx == "踏山裂石" then
		yxs = {资源="sound.wdf",文件=1448022160}
		elseif yx == "三昧真火" or yx == "魔焰滔天" or yx == "秘传三昧真火" or yx == "超级三昧真火" then
		yxs = {资源="sound.wdf",文件=4104677014}
		--elseif yx == "牛劲" or yx == "魔王回首" or yx == "烈焰真诀" then
	    elseif yx == "牛劲" or yx == "魔王回首" then
		yxs = {资源="sound.wdf",文件=0xED47E570}
		--神木林
		elseif yx == "冰川怒" then
		yxs = {资源="sound.wdf",文件=4150925370}
		elseif yx == "血雨" then
		yxs = {资源="sound.wdf",文件=0x13848F75}
		elseif yx == "蜜润" then
		yxs = {资源="sound.wdf",文件=0x1C7EE63E}
		elseif yx == "蝼蚁蚀天" then
		yxs = {资源="sound.wdf",文件=0x13848F75}
		elseif yx == "落叶萧萧" or yx == "风卷残云" or yx == "枯木逢春" then
		yxs = {资源="sound.wdf",文件=1617017747}
		elseif yx == "荆棘舞" or yx == "蛊树迷瘴"  then
		yxs = {资源="sound.wdf",文件=0xE6F9B619}
		elseif yx == "尘土刃" then
		yxs = {资源="sound.wdf",文件=0x245321A8}
		elseif yx == "雾杀" then
		yxs = {资源="sound.wdf",文件=0xA37E8B19}
		elseif yx == "星月之惠" then
		yxs = {资源="sound.wdf",文件=0xC0942A07}
		elseif yx == "炎护" then
		yxs = {资源="sound.wdf",文件=0x5007BB0C}
		elseif yx == "凋零之歌"  then
		yxs = {资源="sound.wdf",文件=0x95C06373}
		--狮驼岭
		elseif yx == "鹰击" or yx == "鹰击长空" then
		yxs = {资源="sound.wdf",文件=1634240280}
		elseif yx == "狮搏" or yx == "幼狮之搏" then
		yxs = {资源="sound.wdf",文件=4083313644}
		elseif yx == "连环击" or yx == "最佳搭档" or yx == "困兽之斗"  then
		yxs = {资源="sound.wdf",文件=805076874}
		elseif yx == "象形" then
		yxs = {资源="sound.wdf",文件=2096780433}
		elseif yx == "变身" or yx == "狂怒" then
		yxs = {资源="sound.wdf",文件=0xB90610BF}
		elseif yx == "魔兽啸天" or yx == "背水" then
		yxs = {资源="sound.wdf",文件=0x35B1FE83}
		elseif yx == "天魔解体" then
		yxs = {资源="sound.wdf",文件=0x1C7EE63E}
		elseif yx == "威慑" then
		yxs = {资源="sound.wdf",文件=0x019B0A72}
		elseif yx == "定心术" or yx == "魔息术" then
		yxs = {资源="sound.wdf",文件=0x40701F91}
		elseif yx == "极度疯狂" then
		yxs = {资源="sound.wdf",文件=0x6961CB02}
		--凌波城
		elseif yx == "不动如山" then
		yxs = {资源="sound.wdf",文件=0xED47E570}
		elseif yx == "碎星诀" then
		yxs = {资源="sound.wdf",文件=0xB90610BF}
		elseif yx == "镇魂诀" then
		yxs = {资源="sound.wdf",文件=0x40701F91}
		elseif yx == "指地成钢" then
		yxs = {资源="sound.wdf",文件=0x14E55AF2}
		elseif yx == "裂石" then
		yxs = {资源="sound.wdf",文件=0x30D78CEF}
		elseif yx == "断岳势" then
		yxs = {资源="sound.wdf",文件=0x39D047A5}
		elseif yx == "天崩地裂" then
		yxs = {资源="sound.wdf",文件=0x795E59BA}
		elseif yx == "浪涌" then
		yxs = {资源="sound.wdf",文件=0x30D78CEF}
		elseif yx == "惊涛怒" then
		yxs = {资源="sound.wdf",文件=0x318685B7}
		elseif yx == "翻江搅海1" then
		yxs = {资源="sound.wdf",文件=0xA08D7D31}
		elseif yx == "翻江搅海" then
		yxs = {资源="sound.wdf",文件=0x318685B7}
		elseif yx == "腾雷" then
		yxs = {资源="sound.wdf",文件=0xDDD270F5}
		elseif yx == "真君显灵" then
		yxs = {资源="sound.wdf",文件=0x40701F91}
        --无底洞
		elseif yx == "地涌金莲" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "夺命咒" then
		yxs = {资源="sound.wdf",文件=0x98BDEC63}
		elseif yx == "同舟共济" then
		yxs = {资源="sound.wdf",文件=0xBB1E59E8}
		elseif yx == "移魂化骨" then
		yxs = {资源="sound.wdf",文件=0xB6A8CB18}
		elseif yx == "夺魄令" then
		yxs = {资源="sound.wdf",文件=0x12A308C0}
		elseif yx == "煞气诀"then
		yxs = {资源="sound.wdf",文件=0x245321A8}
		elseif yx == "惊魂掌" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "摧心术" then
		yxs = {资源="sound.wdf",文件=0xED520CA0}
		elseif yx == "明光宝烛" then
		yxs = {资源="sound.wdf",文件=0xFBA099F0}
		elseif yx == "金身舍利" then
		yxs = {资源="sound.wdf",文件=0xFBA099F0}
		elseif yx == "万木凋枯" then
		yxs = {资源="sound.wdf",文件=0x814AE8F4}
		-- elseif yx == "由己渡人" then
		-- yxs = {资源="sound.wdf",文件=0x97283C40}
		elseif yx == "妖风四起" then
		yxs = {资源="sound.wdf",文件=0xA0F588C2}
        --五庄观
		elseif yx == "天地同寿" then
		yxs = {资源="sound.wdf",文件=0x24A434E5}
		elseif yx == "乾坤妙法" then
		yxs = {资源="sound.wdf",文件=0x9197B5A6}
		elseif yx == "太极生化" then
		yxs = {资源="sound.wdf",文件=0x9197B5A6}
		elseif yx == "驱魔" or yx == "驱尸" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		elseif yx == "烟雨剑法" or yx == "飘渺式" or yx == "天命剑法" or yx == "敲金击玉"  or yx == "天神怒斩" or yx == "剑意莲心" or yx == "金击式"  then
		yxs = {资源="sound.wdf",文件=0x30D78CEF}
		elseif yx == "日月乾坤" then
		yxs = {资源="sound.wdf",文件=0xA7B1C535}
		elseif yx == "炼气化神" or yx == "生命之泉" then
		yxs = {资源="sound.wdf",文件=0x24A434E5}
		elseif yx == "三花聚顶" then
		yxs = {资源="sound.wdf",文件=0x24A434E5}
		elseif yx == "清风望月" then
		yxs = {资源="sound.wdf",文件=0x9197B5A6}
        --天宫
		elseif yx == "知己知彼" then
		yxs = {资源="sound.wdf",文件=0xA12CF973}
		elseif yx == "天神护法"  or yx == "潜龙在渊" or yx == "电光火石"  then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "天神护体" then
		yxs = {资源="sound.wdf",文件=0xC0A21592}
		elseif yx == "天诛地灭" then
		yxs = {资源="sound.wdf",文件=0x251670FB}
		elseif yx == "五雷轰顶" then
		yxs = {资源="sound.wdf",文件=0xDB4F9338}
		elseif yx == "雷霆万钧" or yx == "雷霆汹涌"  then
		yxs = {资源="sound.wdf",文件=0x040584F3}
		elseif yx == "天雷斩" or yx == "风雷斩"  then
		yxs = {资源="sound.wdf",文件=0x251670FB}
		elseif yx == "宁心" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		elseif yx == "镇妖" then
		yxs = {资源="sound.wdf",文件=0x318685B7}
		elseif yx == "错乱" then
		yxs = {资源="sound.wdf",文件=0x5703EB56}
		elseif yx == "百万神兵" then
		yxs = {资源="sound.wdf",文件=0x318685B7}
		elseif yx == "金刚镯" then
		yxs = {资源="sound.wdf",文件=0xA12CF973}
		elseif yx == "画地为牢" then
		yxs = {资源="sound.wdf",文件=0xA12CF973}
		elseif yx == "风雷韵动" or yx == "噬毒"  then
		yxs = {资源="sound.wdf",文件=0x040584F3}
		--地府
		elseif yx == "寡欲令" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		elseif yx == "魂飞魄散" then
		yxs = {资源="sound.wdf",文件=0x814AE8F4}
		elseif yx == "阎罗令" then
		yxs = {资源="sound.wdf",文件=0x12A308C0}
		elseif yx == "判官令" then
		yxs = {资源="sound.wdf",文件=0xB6A8CB18}
		elseif yx == "锢魂术" then
		yxs = {资源="sound.wdf",文件=0x7FDACB76}
		elseif yx == "黄泉之息" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "还阳术" then
		yxs = {资源="sound.wdf",文件=0x97283C40}
		elseif yx == "幽冥鬼眼" or yx == "天眼神通" or yx == "耳目一新" then
		yxs = {资源="sound.wdf",文件=0xFBA099F0}
		elseif yx == "冤魂不散" then
		yxs = {资源="sound.wdf",文件=0xED520CA0}
		elseif yx == "尸腐毒" or yx == "尸腐毒 "  then
		yxs = {资源="sound.wdf",文件=0x98BDEC63}
		elseif yx == "修罗隐身" then
		yxs = {资源="sound.wdf",文件=0xBB1E59E8}
		elseif  yx == "百爪狂杀"  or yx == "血影蚀心" or yx == "六道无量" or yx == "绝命毒牙" or yx == "无赦咒令" or yx == "生杀予夺" or yx == "百鬼噬魂"
		or yx == "五雷挪移"  or yx == "轻歌飘舞"  or yx == "风回旋舞"  or yx == "嫣然曼舞"  or yx == "惊鸿起舞"
		or yx == "映日妙舞"  or yx == "翩跃飞舞"  or yx == "余韵索心"  then
		yxs = {资源="sound.wdf",文件=0x4B800708}
		-- elseif yx == "魑魅缠身" then
		-- yxs = {资源="sound.wdf",文件=0xBB1E59E8}
		--普陀
		elseif yx == "紧箍咒" then
		yxs = {资源="sound.wdf",文件=0xD00F519D}
		elseif yx == "杨柳甘露" then
		yxs = {资源="sound.wdf",文件=0xA4B9B11E}
		elseif yx == "莲花心音" then
		yxs = {资源="sound.wdf",文件=0xEFB621F4}
		elseif yx == "灵动九天" or yx == "普渡众生" or yx == "波澜不惊" or yx == "自在心法"  or yx == "霹雳弦惊" or yx == "雷怒霆激"
			 or yx == "心随意动"   or yx == "魍魉追魂"  or yx == "追魂刺"   then
		yxs = {资源="sound.wdf",文件=0x2550B4D0}
		elseif yx == "颠倒五行" then
		yxs = {资源="sound.wdf",文件=0xA37E8B19}
		elseif yx == "五行错位" then
		yxs = {资源="sound.wdf",文件=0x0B2ED764}
		elseif yx == "日光华" then
		yxs = {资源="sound.wdf",文件=0xCE259E8C}
		elseif yx == "靛沧海" then
		yxs = {资源="sound.wdf",文件=0xE957CD44}
		elseif yx == "苍茫树" then
		yxs = {资源="sound.wdf",文件=0x251670FB}
		elseif yx == "巨岩破" then
		yxs = {资源="sound.wdf",文件=0x52BA8E8D}
		elseif yx == "地裂火" then
		yxs = {资源="sound.wdf",文件=0x1366C86B}
		elseif yx == "莲心剑意" then
		yxs = {资源="sound.wdf",文件=0x39D047A5}
		--女儿
		elseif yx == "雨落寒沙" or yx == "子母神针" then
		yxs = {资源="sound.wdf",文件=0xFE189BCC}
		elseif yx == "红袖添香" then
		yxs = {资源="sound.wdf",文件=0xBF36842D}
		elseif yx == "楚楚可怜" then
		yxs = {资源="sound.wdf",文件=0xBB1E59E8}
		elseif yx == "一笑倾城" or yx == "飞花摘叶" then
		yxs = {资源="sound.wdf",文件=0x51F82D7D}
		elseif yx == "满天花雨" or yx == "鸿渐于陆" then
		yxs = {资源="sound.wdf",文件=0xC99B2900}
		elseif yx == "情天恨海" then
		yxs = {资源="sound.wdf",文件=0xFE189BCC}
		elseif yx == "莲步轻舞" or yx == "如花解语" or yx == "似玉生香" or yx == "娉婷袅娜" or yx == "无畏布施" or yx == "北冥之渊"  then
		yxs = {资源="sound.wdf",文件=0xBDCD9588}
		elseif yx == "百毒不侵" then
		yxs = {资源="sound.wdf",文件=0x57726FFB}
		--盘丝
		elseif yx == "夺命蛛丝" then
		yxs = {资源="sound.wdf",文件=0x95C06373}
		elseif yx == "含情脉脉" or yx == "落花成泥" or yx == "偷龙转凤" then
		yxs = {资源="sound.wdf",文件=0x7F5FD02A}
		elseif yx== "复苏" or yx == "姐妹同心" then
		yxs = {资源="sound.wdf",文件=0x5007BB0C}
		elseif yx == "魔音摄魂" then
		yxs = {资源="sound.wdf",文件=0xE6F9B619}
		elseif yx == "勾魂" or yx == "摄魄" or yx == "瘴气" then
		yxs = {资源="sound.wdf",文件=0xC0942A07}
		elseif yx == "天罗地网" or yx == "利刃" or yx == "蛛丝缠绕" then
		yxs = {资源="sound.wdf",文件=0x13848F75}
		elseif yx == "幻镜术" then
		yxs = {资源="sound.wdf",文件=0x245321A8}
		elseif yx == "盘丝阵" then
		yxs = {资源="sound.wdf",文件=2742979353}
		--方寸
		elseif yx == "三星灭魔" then
		yxs = {资源="sound.wdf",文件=0xA309D8A4}
		elseif yx == "离魂符" or yx == "落魄符" or yx == "失忆符" or yx == "追魂符" or yx == "失魂符" or yx == "定身符" then
		yxs = {资源="sound.wdf",文件=0xF6BED451}
		elseif yx == "五雷咒" or yx == "五雷正法" or yx == "雷法崩裂" or yx == "雷法震煞" or yx == "雷法坤伏" or yx == "雷法翻天"or yx == "雷法倒海" then
		yxs = {资源="sound.wdf",文件=0xDDD270F5}
		---elseif yx == "催眠符" or yx == "碎甲符" or yx == "飞符炼魂" then
	    elseif yx == "催眠符" or yx == "碎甲符"  then
		yxs = {资源="sound.wdf",文件=0xAEABE4AC}
		elseif yx == "失心符" then
		yxs = {资源="sound.wdf",文件=0x9A1A2884}
		elseif yx == "归元咒" or yx == "凝神术" or yx == "顺势而为" then
		yxs = {资源="sound.wdf",文件=0x04E42236}
		elseif yx == "乾天罡气" then
		yxs = {资源="sound.wdf",文件=82059830}
		elseif yx == "分身术" then
		yxs = {资源="sound.wdf",文件=0x4644FF98}
		elseif yx == "落雷符" then
		yxs = {资源="sound.wdf",文件=0xDDD270F5}
		elseif yx == "钟馗论道" then
		yxs = {资源="sound.wdf",文件=0xA309D8A4}
		--宠物技能
		elseif yx == "水攻" or yx == "扶摇万里" then
		yxs = {资源="sound.wdf",文件=7452289}
		elseif yx == "雷击" then
		yxs = {资源="sound.wdf",文件=0xDDD270F5}
		elseif yx == "善恶有报" then
		yxs = {资源="sound.wdf",文件=561268351}
		elseif yx == "上古灵符" then
		yxs = {资源="sound.wdf",文件=1448022160}
		elseif yx == "力劈华山" then
		yxs = {资源="sound.wdf",文件=587133534}
		elseif yx == "泰山压顶" or yx == "超级泰山压顶"then
		yxs = {资源="sound.wdf",文件=587133534}
		elseif yx == "地狱烈火" or yx == "超级地狱烈火"then
		yxs = {资源="sound.wdf",文件=0xD148D483}
		elseif yx == "天降灵葫" then
		yxs = {资源="sound.wdf",文件=0xA0F588C2}
		elseif yx == "八凶法阵" then
		yxs = {资源="sound.wdf",文件=0x3E2A375C}
		elseif yx == "叱咤风云" then
		yxs = {资源="sound.wdf",文件=0xA08D7D31}
		elseif yx == "烈火" then
		yxs = {资源="sound.wdf",文件=1042954076}
		elseif yx == "夜舞倾城" then
		yxs = {资源="sound.wdf",文件=2517237236}
		elseif yx == "水漫金山" or yx == "超级水漫金山" then
		yxs = {资源="sound.wdf",文件=1326039389}
		elseif yx == "落岩" then
		yxs = {资源="sound.wdf",文件=1448022160}
		elseif yx == "奔雷咒" or yx == "超级奔雷咒" then
		yxs = {资源="sound.wdf",文件=0x040584F3}
		elseif yx == "惊心一剑" then
		yxs = {资源="sound.wdf",文件=0x675E4E20}
		elseif yx == "死亡召唤" then
		yxs = {资源="sound.wdf",文件=0x739A0BAB}
		elseif yx == "剑荡四方" or yx == "壁垒击破" then
		yxs = {资源="sound.wdf",文件=0x0504D379}
		elseif yx == "月光" then
		yxs = {资源="sound.wdf",文件=0x9609FDF4}
		elseif yx == "击飞" then
		yxs = {资源="sound.wdf",文件=1382520422}
		elseif yx == "保护" then
		yxs = {资源="sound.wdf",文件=1256173805}
		-----------------------------------------------------------------------------------------------------------法术音效
	end
	return  yxs
end
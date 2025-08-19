--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
--======================================================================--
function 引擎.取音效1(战斗序号)

	local 音效="Audio/战斗1.mp3"
	if 战斗序号>= 200000 or 战斗序号 == 110001 or 战斗序号 == 110002 or 战斗序号 == 110004 or 战斗序号 == 110099 then
		local 战斗音效1 = {"Audio/战斗6.mp3","Audio/战斗7.mp3","Audio/战斗8.mp3","Audio/战斗9.mp3","Audio/战斗10.mp3","Audio/战斗11.mp3"}
    	local 战斗播放音效1=战斗音效1[取随机数(1,#战斗音效1)]
    	音效=战斗播放音效1
	else
		local 战斗音效 = {"Audio/战斗1.mp3","Audio/战斗2.mp3","Audio/战斗3.mp3","Audio/战斗4.mp3","Audio/战斗5.mp3"}
    	local 战斗播放音效=战斗音效[取随机数(1,#战斗音效)]
    	音效=战斗播放音效
	end
	return 音效
end
function 取冒泡框(zj)
	local zjs = {}
	if zj == "灿烂葵花" then
		zjs[1] = 0xcd2c5fb5
		zjs[2] = 0x7ee380be
		zjs[3] = 0xb37a9e8a
		zjs[4] = 0x8af1df70
		zjs[5] = 0x2d4ec852
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "冰清玉洁" then
		zjs[1] = 0x77ea18da
		zjs[2] = 0xa1dfcd65
		zjs[3] = 0x37baa64f
		zjs[4] = 0x1e2e1e43
		zjs[5] = 0x706b9381
		zjs[6] = "新界面.wdf"
		zjs[7] = 23
	elseif zj == "甜蜜葡萄" then
		zjs[1] = 0xaef4e92b
		zjs[2] = 0x204429bb
		zjs[3] = 0xe4b7807c
		zjs[4] = 0x93f56713
		zjs[5] = 0xf2565916
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "觅缘" then
		zjs[1] = 0xbd1bdf99
		zjs[2] = 0xdadfb05c
		zjs[3] = 0x30c73574
		zjs[4] = 0x3b06a859
		zjs[5] = 0x737ab5c6
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "喜结连理" then
		zjs[1] = 0x526cee7c
		zjs[2] = 0xab953826
		zjs[3] = 0x80c10829
		zjs[4] = 0xb9e8cc57
		zjs[5] = 0x9b531254
		zjs[6] = "新界面.wdf"
		zjs[7] = 5


	elseif zj == "秋意浓" then
		zjs[1] = 0xbb5b6b49
		zjs[2] = 0x5bb86395
		zjs[3] = 0x2313ad48
		zjs[4] = 0x53bfab4a
		zjs[5] = 0x110cc05d
		zjs[6] = "新界面.wdf"
		zjs[7] = 0

	elseif zj == "竹下饮" then
		zjs[1] = 0x2f61f868
		zjs[2] = 0xca459fb8
		zjs[3] = 0xcd7909be
		zjs[4] = 0x78271e77
		zjs[5] = 0x8e7c0a5e
		zjs[6] = "新界面.wdf"
		zjs[7] = 5
	elseif zj == "午夜惊魂" then
		zjs[1] = 0x6e017041
		zjs[2] = 0xa13b2579
		zjs[3] = 0x3196a572
		zjs[4] = 0xd22e1433
		zjs[5] = 0x96c0c430
		zjs[6] = "新界面.wdf"
		zjs[7] = 10
	elseif zj == "暖暖线球" then
		zjs[1] = 0xfc114b6e
		zjs[2] = 0xe8bbe0d8
		zjs[3] = 0x871d415c
		zjs[4] = 0xc4c7ff87
		zjs[5] = 0x5ac719c1
		zjs[6] = "新界面.wdf"
		zjs[7] = 12
	elseif zj == "云中传音" then
		zjs[1] = 0x51737b69
		zjs[2] = 0x75b35290
		zjs[3] = 0x2f7a851c
		zjs[4] = 0xf22180ca
		zjs[5] = 0x2b58bd46
		zjs[6] = "新界面.wdf"
		zjs[7] = 10
	elseif zj == "夏日西瓜" then
		zjs[1] = 0xe147b711
		zjs[2] = 0xf54f7779
		zjs[3] = 0xbf3f4ac1
		zjs[4] = 0x4858709b
		zjs[5] = 0x423c7d69
		zjs[6] = "新界面.wdf"
		zjs[7] = 20

	elseif zj == "中国结" then
		zjs[1] = 0x8fce5371
		zjs[2] = 0xab968e41
		zjs[3] = 0x9fe52d7e
		zjs[4] = 0xeb8ef380
		zjs[5] = 0x69922009
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "冰雪天地" then
		zjs[1] = 0x82fb7c04
		zjs[2] = 0x692f87b3
		zjs[3] = 0x4decdaf3
		zjs[4] = 0x6949b8ff
		zjs[5] = 0x5997460a
		zjs[6] = "新界面.wdf"
		zjs[7] = 25
	elseif zj == "星月童话" then
		zjs[1] = 0x71ea22fb
		zjs[2] = 0x692fa263
		zjs[3] = 0xc650cd70
		zjs[4] = 0xc090f28d
		zjs[5] = 0x19b3703e
		zjs[6] = "新界面.wdf"
		zjs[7] = 5
	elseif zj == "绯色蔷薇" then
		zjs[1] = 0x798faf7b
		zjs[2] = 0xadd32f00
		zjs[3] = 0xf2716114
		zjs[4] = 0x90e807a7
		zjs[5] = 0xf1ce4544
		zjs[6] = "新界面.wdf"
		zjs[7] = 0

	elseif zj == "如梦似幻" then
		zjs[1] = 0x8dd12e8a
		zjs[2] = 0xbb993984
		zjs[3] = 0xfafec47e
		zjs[4] = 0x14f77e50
		zjs[5] = 0x1c790250
		zjs[6] = "新界面.wdf"
		zjs[7] = 25
	elseif zj == "四叶草" then
		zjs[1] = 0x6de7b5d8
		zjs[2] = 0x439d494e
		zjs[3] = 0x3356cc31
		zjs[4] = 0x951250b2
		zjs[5] = 0xd9c07d45
		zjs[6] = "新界面.wdf"
		zjs[7] = 0

	elseif zj == "木纹回忆" then
		zjs[1] = 0x1c3ab104
		zjs[2] = 0xcbcaf06b
		zjs[3] = 0x71409476
		zjs[4] = 0xc268eee8
		zjs[5] = 0x7c4d7435
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "悦动之心" then
		zjs[1] = 0x76817e92
		zjs[2] = 0xabb29ea6
		zjs[3] = 0xa9779f8d
		zjs[4] = 0x3449d74a
		zjs[5] = 0x9eff260e
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "飞翔之翼" then
		zjs[1] = 0x8b8be1b0
		zjs[2] = 0x52bc2f26
		zjs[3] = 0x5c7ce3bc
		zjs[4] = 0x13892b93
		zjs[5] = 0x15de1910
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "花之浪漫" then
		zjs[1] = 0x263f5811
		zjs[2] = 0xcb54b12f
		zjs[3] = 0x39edc327
		zjs[4] = 0xf4730c1a
		zjs[5] = 0x38d8ad3d
		zjs[6] = "新界面.wdf"
		zjs[7] = 0

	elseif zj == "龙虎斗" then
		zjs[1] = 0x201e0ad6
		zjs[2] = 0x21f08540
		zjs[3] = 0x1965935a
		zjs[4] = 0x15189c63
		zjs[5] = 0x8e406176
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	elseif zj == "如意" then
		zjs[1] = 0x11897893 -- 上
		zjs[2] = 0xaaeaa916 -- 下
		zjs[3] = 0xffb0b729 -- 中
		zjs[4] = 0x4ced68bf -- 小模型
		zjs[5] = 0x91a91d56 -- 大模型
		zjs[6] = "新界面.wdf"
		zjs[7] = 0
	-- elseif zj == "糖果" then
	-- 	zjs[1] = 0x66deb664
	-- 	zjs[2] = 0xf3d8c38
	-- 	zjs[3] = 0x1965935a
	-- 	zjs[4] = 0x89caa377
	-- 	zjs[5] = 0xaa95f67a
	-- 	zjs[6] = "新界面.wdf"
	-- 	zjs[7] = 7
	end
	return zjs
end


function 引擎.取阵法效果(tx)
	local n={}
	if tx == "普通" then
	   n[1]=0X0EFB9CC5
	   n[2]="登陆资源.wdf"
	elseif  tx == "天覆阵" then
	   n[1]=0XE7195F87
	   n[2]="登陆资源.wdf"
	elseif  tx == "风扬阵" then
	   n[1]=0X604C17C8
	   n[2]="登陆资源.wdf"
	elseif  tx == "地载阵" then
	   n[1]=0X0B9D8699
	   n[2]="登陆资源.wdf"
	elseif  tx == "虎翼阵" then
	   n[1]=0X0711D67B
	   n[2]="登陆资源.wdf"
	elseif  tx == "雷绝阵" then
	   n[1]=0XFBD5C34F
	   n[2]="登陆资源.wdf"
	elseif  tx == "龙飞阵" then
	   n[1]=0XE693FE63
	   n[2]="登陆资源.wdf"
	elseif  tx == "鸟翔阵" then
	   n[1]=0XACD2EFAA
	   n[2]="登陆资源.wdf"
	elseif  tx == "蛇蟠阵" then
	   n[1]=0XEE6FB5B5
	   n[2]="登陆资源.wdf"
	elseif  tx == "鹰啸阵" then
	   n[1]=0XFAD3E4FF
	   n[2]="登陆资源.wdf"
	elseif  tx == "云垂阵" then
	   n[1]=0XE26843B8
	   n[2]="登陆资源.wdf"
	end
	return n
end

function 引擎.特效库(tx)
	local txs = {}
	--孩子技能
	if tx == "还魂咒" then
	txs[1] = 2391977602
	txs[2] = "法术效果.wdf"
	elseif tx == "仙人指路" then
	txs[1] = 388205471
	txs[2] = "法术效果.wdf"
	elseif tx == "峰回路转" then
	txs[1] = 0xF3B31E4E
	txs[2] = "法术效果.wdf"

	elseif tx == "流沙轻音" then
	txs[1] = 0x7BE878E0
	txs[2] = "铃铛界面.wdf"
	elseif tx == "食指大动" then
	txs[1] = 0x774B7CEF
	txs[2] = "铃铛界面.wdf"

	elseif tx == "四面埋伏" then
	txs[1] = 0x32A07D29
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_四面埋伏" then
	txs[1] = 0x1E1AF8D9
	txs[2] = "法术效果.wdf"
	--化圣技能
	elseif tx == "其疾如风" then
	txs[1] = 0xC447B3E4
	txs[2] = "法术效果.wdf"
	elseif tx == "其徐如林" then
	txs[1] = 0x837DCF3D
	txs[2] = "法术效果.wdf"
	elseif tx == "不动如山 " then
	txs[1] = 0xE36378D7
	txs[2] = "法术效果.wdf"
	elseif tx == "侵掠如火" then
	txs[1] = 0x84132036
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_其疾如风" then
	txs[1] = 0x98753F94
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_不动如山 " then
	txs[1] = 0x0D25E055
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_侵掠如火" then
	txs[1] = 0x0CEAF91A
	txs[2] = "法术效果.wdf"
	elseif tx == "动物套效果" then
	txs[1] = 0xADF90980
	txs[2] = "法术效果.wdf"
    --特技
    elseif tx == "笑里藏刀" then
	txs[1] = 0x5DE57BA4
	txs[2] = "法术效果.wdf"
	elseif tx == "绝幻魔音" then
	txs[1] = 0x14E3155E
	txs[2] = "法术效果.wdf"
	elseif tx == "流云诀" then
	txs[1] = 0xFE27EBCF
	txs[2] = "法术效果.wdf"
	elseif tx == "啸风诀" then
	txs[1] = 0xFE27EBCF
	txs[2] = "法术效果.wdf"
	elseif tx == "弱点击破"  then
	txs[1] = 0xB1822745
	txs[2] = "法术效果.wdf"
	elseif tx == "破血狂攻" or tx == "千蛛噬魂" or tx == "琴音三叠" then
	txs[1] = 387269810
	txs[2] = "法术效果.wdf"
	elseif tx == "气疗术" then
	txs[1] = 0xF3B31E4E
	txs[2] = "法术效果.wdf"
	elseif tx == "命疗术" then
	txs[1] = 0xF3B31E4E
	txs[2] = "法术效果.wdf"
	elseif tx == "气归术" then
	txs[1] = 0xD077C3A0
	txs[2] = "法术效果.wdf"
	elseif tx == "命归术" then
	txs[1] = 0x30F2B60C
	txs[2] = "法术效果.wdf"
	elseif tx == "凝气诀" then
	txs[1] = 0x899241C3
	txs[2] = "法术效果.wdf"
	elseif tx == "凝神诀" then
	txs[1] = 0x7EE33126
	txs[2] = "法术效果.wdf"
	elseif tx == "晶清诀" then
	txs[1] = 0x66150076
	txs[2] = "法术效果.wdf"
	elseif tx == "冰清诀" or tx == "玉清诀" or tx == "水清诀" or tx == "同生共死" then
	txs[1] = 0x17238B9F
	txs[2] = "法术效果.wdf"
	elseif tx == "心疗术" then
	txs[1] = 0xFBF89980
	txs[2] = "法术效果.wdf"
	elseif tx == "四海升平" then
	txs[1] = 0xD077C3A0
	txs[2] = "法术效果.wdf"
	elseif tx == "回魂咒" then
	txs[1] = 0x8E92AE82
	txs[2] = "法术效果.wdf"
	elseif tx == "起死回生" then
	txs[1] = 0x8E92AE82
	txs[2] = "法术效果.wdf"
	elseif tx == "野兽之力" then
	txs[1] = 0x203B8C75
	txs[2] = "法术效果.wdf"
	elseif tx == "魔兽之印" then
	txs[1] = 0x203B8C75
	txs[2] = "法术效果.wdf"
	elseif tx == "罗汉金钟" then
	txs[1] = 0x9B23F38E
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_罗汉金钟" then
	txs[1] = 0x5C5C1544
	txs[2] = "法术效果.wdf"
	elseif tx == "慈航普渡" or tx == "百草神木复苏" or tx == "百草复苏" or tx == "百草诀" or tx == "滋养" or tx == "焕生咒" or tx == "燃血术"  then
	txs[1] = 0xE1084D39
	txs[2] = "法术效果.wdf"
	elseif tx == "太极护法" then
	txs[1] = 0x9B23F38E
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_太极护法" then
	txs[1] = 0x5C5C1544
	txs[2] = "法术效果.wdf"
	elseif tx == "光辉之甲" then
	txs[1] = 0x38FD76EA
	txs[2] = "法术效果.wdf"
	elseif tx == "圣灵之甲" then
	txs[1] = 0x38FD76EA
	txs[2] = "法术效果.wdf"
	elseif tx == "破碎无双" then
	txs[1] = 0x21FAE73F
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_修罗咒" then
	txs[1] = 0x547C4B68
	txs[2] = "法术效果.wdf"
	elseif tx == "修罗咒" then
	txs[1] = 0x95065313
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天衣无缝" then
	txs[1] = 0xFAF4A2D4
	txs[2] = "法术效果.wdf"
	elseif tx == "天衣无缝" then
	txs[1] = 0xC183DB1E
	txs[2] = "法术效果.wdf"
	elseif tx == "放下屠刀" then
	txs[1] = 0x81B4599F
	txs[2] = "法术效果.wdf"
   elseif tx == "河东狮吼" then
	txs[1] = 0xD20E78BF
	txs[2] = "法术效果.wdf"
   elseif tx == "破甲术" then
	txs[1] = 0xD0EEC915
	txs[2] = "法术效果.wdf"
   elseif tx == "碎甲术" then
	txs[1] = 0xD5FFC526
	txs[2] = "法术效果.wdf"
   elseif tx == "凝滞术" then
	txs[1] = 0xD1E593CE
	txs[2] = "法术效果.wdf"
   elseif tx == "停陷术" then
	txs[1] = 0x47C69103
	txs[2] = "法术效果.wdf"
   elseif tx == "冥王暴杀" then
	txs[1] = 0xA5199709
	txs[2] = "法术效果.wdf"
	--大唐官府
	elseif tx == "破釜沉舟_敌方" then
	txs[1] = 0xA3C28611
	txs[2] = "法术效果.wdf"
	elseif tx == "破釜沉舟_我方" then
	txs[1] = 0xDAAE7E11
	txs[2] = "法术效果.wdf"
	elseif tx == "破釜沉舟" then
	txs[1] = 2896471370
	txs[2] = "法术效果.wdf"
	elseif tx == "长驱直入" or tx == "翩鸿一击" or tx =="摧枯拉朽" then
	txs[1] = 0x352F1BBD
	txs[2] = "法术效果.wdf"
	elseif tx == "横扫千军" or  tx=="神来气旺" or  tx=="哼哼哈兮" or  tx=="水击三千"  then
	txs[1] = 2896471370
	txs[2] = "法术效果.wdf"
	elseif tx == "武神怒击" then
	txs[1] = 0x3A63D8A8
	txs[2] = "法术效果.wdf"
	elseif tx == "武神怒击1" then
	txs[1] = 0xF08C56E8
	txs[2] = "法术效果.wdf"
	elseif tx == "武神怒击2" then
	txs[1] = 0x3DD71DF3
	txs[2] = "法术效果.wdf"
	elseif tx == "刀光剑影3" then
	txs[1] = 0xDFC4A4F2
	txs[2] = "法术效果.wdf"
		elseif tx == "刀光剑影2" then
	txs[1] = 0x0F28E2DC
	txs[2] = "法术效果.wdf"
		elseif tx == "刀光剑影1" then
	txs[1] = 0xF08C56E8
	txs[2] = "法术效果.wdf"
	elseif tx == "毁灭之光3" then
	txs[1] = 0xE5FB4983
	txs[2] = "法术效果.wdf"
	elseif tx == "毁灭之光2" then
	txs[1] = 0xC13CB3DD
	txs[2] = "法术效果.wdf"
	elseif tx == "毁灭之光1" then
	txs[1] = 0xF08C56E8
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_横扫千军" or tx == "状态_破釜沉舟" or tx == "状态_重创"  then
	txs[1] = 3645258252
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_翩鸿一击" then
	txs[1] = 0x67C338A5
	txs[2] = "法术效果.wdf"
	elseif tx == "后发制人" or tx == "先发制人"  then
	txs[1] = 968268166
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_后发制人" or  tx == "状态_先发制人" then
	txs[1] = 707397219
	txs[2] = "法术效果.wdf"
	elseif tx == "威仪九霄" then
	txs[1] = 0xAF07277F
	txs[2] = "法术效果.wdf"


	elseif tx == "狂怒" or tx == "催化"  then
	txs[1] = 0xA5D7B0F7
	txs[2] = "法术效果.wdf"
    elseif tx == "状态_狂怒" then
	txs[1] = 0xA5D7B0F7
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_龙骇龙腾" then
	txs[1] = 0xBEC7680A
	txs[2] = "法术效果.wdf"
    elseif tx == "状态_龙骇龙卷" then
	txs[1] = 0xCA4F1AC5
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_龙魂" or tx == "状态_催化" then
	txs[1] = 0x04EBA6E1
	txs[2] = "法术效果.wdf"
	elseif tx == "安神诀" then
	txs[1] = 0xE61DB8B4
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_安神诀" then
	txs[1] = 0xE61DB8B4
	txs[2] = "法术效果.wdf"
	elseif tx == "杀气诀" then
	txs[1] = 0xC29A0737
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_杀气诀" then
	txs[1] = 0x62EDD1CB
	txs[2] = "法术效果.wdf"
	elseif tx == "反间之计" or tx == "疯狂" then
	txs[1] = 1804814488
	txs[2] = "法术效果.wdf"
	elseif tx == "斩龙诀" then
	txs[1] = 0x81B4599F
	txs[2] = "法术效果.wdf"
	--化生寺
	elseif tx == "紫气东来" then
	txs[1] = 0xA742E8AB
	txs[2] = "法术效果.wdf"
	elseif tx == "唧唧歪歪" or tx == "谆谆教诲" then
	txs[1] = 3240896099
	txs[2] = "法术效果.wdf"
	elseif tx == "金刚护法"  then
	txs[1] = 0x04DB6C0A
	txs[2] = "法术效果.wdf"
	elseif tx == "诸天看护" then
	txs[1] = 0x8CBA06E2
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_金刚护法" then
	txs[1] = 0x16B27FFC
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_诸天看护" then
	txs[1] = 0xDA034679
	txs[2] = "法术效果.wdf"
	elseif tx == "推拿" then
	txs[1] = 51617616
	txs[2] = "法术效果.wdf"
	elseif tx == "活血" then
	txs[1] = 51617616
	txs[2] = "法术效果.wdf"
	elseif tx == "推气过宫" then
	txs[1] = 3899242890
	txs[2] = "法术效果.wdf"
	elseif tx == "渡劫金身" or tx == "菩提心佑" then
	txs[1] = 0x7EEC276B
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_渡劫金身"  or tx == "状态_绝处逢生" or tx == "状态_菩提心佑"  then
	txs[1] = 0x74A85C95
	txs[2] = "法术效果.wdf"
	elseif tx == "舍身取义" or tx == "妙悟" or tx == "绝处逢生" or tx == "百草古树长青" or tx == "百草十香" or tx == "百草定神"  or tx == "百草红雪" or tx == "百草回春龙沙"  then
	txs[1] = 0xADF90980
	txs[2] = "法术效果.wdf"

	elseif tx == "金刚护体" then
	txs[1] = 952243307
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_金刚护体_我方" then
	txs[1] = 0x369C6A29
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_金刚护体_敌方" then
	txs[1] = 0x369C6A29
	txs[2] = "法术效果.wdf"
	elseif tx == "韦陀护法" then
	txs[1] = 2493890284
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_韦陀护法" then
	txs[1] = 2243155697
	txs[2] = "法术效果.wdf"
	elseif tx == "我佛慈悲" then
	txs[1] = 540772211
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_佛法无边" then
	txs[1] = 0xEA4D704A
	txs[2] = "法术效果.wdf"
	elseif tx == "佛法无边" then
	txs[1] = 0xC8011EF1
	txs[2] = "法术效果.wdf"
	elseif tx == "达摩护体" or tx == "身似菩提" or tx == "状态_达摩护体" or tx == "状态_身似菩提" then
	txs[1] = 2565901429
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_一苇渡江" then
	txs[1] = 382287583
	txs[2] = "法术效果.wdf"
	elseif tx == "一苇渡江" then
	txs[1] = 4082420920
	txs[2] = "法术效果.wdf"
	elseif tx == "解毒" then
	txs[1] = 3727996990
	txs[2] = "法术效果.wdf"
	--龙宫
	-- elseif tx == "亢龙归海" then
	-- txs[1] = 0x2ED86FD0
	-- txs[2] = "法术效果.wdf"
	elseif tx == "雷浪穿云" then
	txs[1] = 0x2067A573
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_雷浪穿云" then
	txs[1] = 0x7CD6EADC
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_逆鳞" then
	txs[1] = 2243155697
	txs[2] = "法术效果.wdf"
	elseif tx == "逆鳞" then
	txs[1] = 81488906
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击1" then
	txs[1] = 3911640280
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击2" then
	txs[1] = 3592299801
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击3" then
	txs[1] = 3592299801
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击4" then
	txs[1] = 3592299801
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击5" then
	txs[1] = 3592299801
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击6" then
	txs[1] = 3514247917
	txs[2] = "法术效果.wdf"
	elseif tx == "龙卷雨击7" then
	txs[1] = 1459200517
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟" then
	txs[1] = 1667259533
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟1" then
	txs[1] = 0xA5199709
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟2" then
	txs[1] = 0x5EC2D5BB
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟3" then
	txs[1] = 0x3D74BE12
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟4" then
	txs[1] = 0x63605C8D
	txs[2] = "法术效果.wdf"
	elseif tx == "龙吟5" then
	txs[1] = 0x9FE48849
	txs[2] = "法术效果.wdf"
	elseif tx == "龙腾" or tx == "亢龙归海" then
	txs[1] = 1936174863
	txs[2] = "法术效果.wdf"
	elseif tx == "解封" then
	txs[1] = 1833750106
	txs[2] = "法术效果.wdf"
	elseif tx == "清心" then
	txs[1] = 822452251
	txs[2] = "法术效果.wdf"
	elseif tx == "二龙戏珠" then
	txs[1] = 2793449505
	txs[2] = "法术效果.wdf"
	elseif tx == "神龙摆尾" then
	txs[1] = 0xA4790CE1
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_神龙摆尾" then
	txs[1] = 0xF184BD59
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_乘风破浪" then
	txs[1] = 3366209335
	txs[2] = "法术效果.wdf"
	elseif tx == "乘风破浪" then
	txs[1] = 1172493695
	txs[2] = "法术效果.wdf"
	elseif tx == "龙啸九天" then
	txs[1] = 0x20D80D98
	txs[2] = "法术效果.wdf"
	--魔王寨
	elseif tx == "摇头摆尾" then
	txs[1] = 0x47FE2CC6
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_摇头摆尾" then
	txs[1] = 0x048B222C
	txs[2] = "法术效果.wdf"
	elseif tx == "无敌牛妖" then
	txs[1] = 0x2AEB8662
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_无敌牛妖" then
	txs[1] = 0xA168E26F
	txs[2] = "法术效果.wdf"
	elseif tx == "无敌牛虱" then
	txs[1] = 0x2AEB8662
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_无敌牛虱" then
	txs[1] = 0xA168E26F
	txs[2] = "法术效果.wdf"
	elseif tx == "火甲术"  then
	txs[1] = 0x4B621DF7
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_火甲术"  then
	txs[1] = 0x82D17DF8
	txs[2] = "法术效果.wdf"
	elseif tx == "踏山裂石"  then
	txs[1] = 0xA68B3211
	txs[2] = "法术效果.wdf"
	elseif tx == "牛劲" then
	txs[1] = 0x26F090BE
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_牛劲" then
	txs[1] = 0xA168E26F
	txs[2] = "护盾括号.wdf"
	elseif tx == "魔王回首" then
	txs[1] = 0x16B27FFC
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_魔王回首" then
	txs[1] = 0xBBEA83F4
	txs[2] = "法术效果.wdf"
	elseif tx == "三昧真火" or tx == "秘传三昧真火" then
	txs[1] = 0xFCDCCCEC
	txs[2] = "法术效果.wdf"
    elseif tx == "超级三昧真火"  then
	txs[1] = 0xFCDCCCEC
	txs[2] = "法术效果.wdf"
	elseif tx == "魔焰滔天" then
	txs[1] = 0x8A506A89
	txs[2] = "法术效果.wdf"
	-- elseif tx == "烈焰真诀" then
	-- txs[1] = 0x9F9F85EF
	-- txs[2] = "法术效果.wdf"
	-- elseif tx == "状态_烈焰真诀" then
	-- txs[1] = 0xCE4013A9
	-- txs[2] = "法术效果.wdf"
	elseif tx == "飞砂走石1"   then
	txs[1] = 0x49CBD108
	txs[2] = "法术效果.wdf"
	elseif tx == "飞砂走石2" then
	txs[1] = 0x2ABF191D
	txs[2] = "法术效果.wdf"
	elseif tx == "飞砂走石3" then
	txs[1] = 0x49CBD108
	txs[2] = "法术效果.wdf"
	elseif tx == "飞砂走石4" then
	txs[1] = 0x49CBD108
	txs[2] = "法术效果.wdf"
	elseif tx == "飞砂走石5" then
	txs[1] = 0x2ABF191D
	txs[2] = "法术效果.wdf"
	--神木林
	elseif tx == "冰川怒" then
	txs[1] = 1425547471
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_冰川怒" then
	txs[1] = 0x0D25E055
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_冰川怒伤" then
	txs[1] = 0xAF07277F
	txs[2] = "法术效果.wdf"
	elseif tx == "血雨" then
	txs[1] = 0x70758FA3
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_血雨" then
	txs[1] = 3645258252
	txs[2] = "法术效果.wdf"
	elseif tx == "蜜润" then
	txs[1] = 0x59DB9699
	txs[2] = "法术效果.wdf"
	elseif tx == "蝼蚁蚀天" then
	txs[1] = 0xCEEA8F28
	txs[2] = "法术效果.wdf"
	elseif tx == "凋零之歌" then
	txs[1] = 0x60AF6327
	txs[2] = "法术效果.wdf"

	elseif tx == "风卷残云" then
	txs[1] = 0x36BFE018
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧" then
	txs[1] = 3177673254
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧1" then
	txs[1] = 3177673254
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧2" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧3" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧4" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧5" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧6" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧7" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧8" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧9" then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "落叶萧萧10"  then
	txs[1] = 0x94931579
	txs[2] = "法术效果.wdf"
	elseif tx == "荆棘舞" or tx == "蛊树迷瘴" then
	txs[1] = 636234317
	txs[2] = "法术效果.wdf"
	elseif tx == "尘土刃" then
	txs[1] = 2645145495
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_雾杀" or tx == "状态_凋零之歌"  then
	txs[1] = 1506044316
	txs[2] = "法术效果.wdf"
	elseif tx == "雾杀" then
	txs[1] = 1264783402
	txs[2] = "法术效果.wdf"
	elseif tx == "星月之惠" then
	txs[1] = 3298164407
	txs[2] = "法术效果.wdf"
	elseif tx == "炎护" then
	txs[1] = 1863894572
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_炎护" then
	txs[1] = 0x3D23738F
	txs[2] = "法术效果.wdf"
	-- elseif tx == "状态_雾痕" then
	-- txs[1] = 0x34999043
	-- txs[2] = "法术效果.wdf"
	--狮驼岭
	elseif tx == "状态_象形" then
	txs[1] = 0x3646A4D9
	txs[2] = "法术效果.wdf"
	elseif tx == "鹰击" or tx == "鹰击长空" then
	txs[1] = 0xA463C055
	txs[2] = "法术效果.wdf"
	elseif tx == "象形" then
	txs[1] = 3188881443
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_鹰击" then
	txs[1] = 0x58628406
	txs[2] = "法术效果.wdf"
	elseif tx == "威慑" then
	txs[1] = 0x8476181B
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_威慑" then
	txs[1] = 0x20FCCE94
	txs[2] = "法术效果.wdf"
	elseif tx == "魔兽啸天" then
	txs[1] = 0x42F0386F
	txs[2] = "法术效果.wdf"
	elseif tx == "天魔解体" then
	txs[1] = 0x718754A2
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天魔解体" then
	txs[1] = 0x718754A2
	txs[2] = "法术效果.wdf"
	elseif tx == "魔息术" then
	txs[1] = 0x3240F0D4
	txs[2] = "法术效果.wdf"
	elseif tx =="状态_魔息术" then
	txs[1] = 0xA8D0CA5A
	txs[2] = "法术效果.wdf"
	elseif tx == "背水" or tx == "状态_背水" then
	txs[1] = 0x0B361FA6
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_变身" or tx == "变身" then
	txs[1] = 702028255
	txs[2] = "法术效果.wdf"
	elseif tx == "狮搏" or tx == "幼狮之搏" then
	txs[1] = 1754178891
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_定心术" then
	txs[1] = 0x2D07CCEC
	txs[2] = "法术效果.wdf"
	elseif tx == "定心术" then
	txs[1] = 0x2D07CCEC
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_连环击" then
	txs[1] = 3645258252
	txs[2] = "法术效果.wdf"
	elseif tx == "连环击" or tx == "最佳搭档" or tx == "困兽之斗"  then
	txs[1] = 1441516140
	txs[2] = "法术效果.wdf"
	elseif tx == "极度疯狂" then
	txs[1] = 0x16B27FFC
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_极度疯狂" then
	txs[1] = 0xBBEA83F4
	txs[2] = "法术效果.wdf"
--凌波城
	elseif tx == "指地成钢" then
	txs[1] = 0x4C7470BF
	txs[2] = "法术效果.wdf"
	elseif tx == "裂石" then
	txs[1] = 0x32FEE53D
	txs[2] = "法术效果.wdf"
	elseif tx == "断岳势" then
	txs[1] = 0x92915A94
	txs[2] = "法术效果.wdf"
	elseif tx == "天崩地裂" then
	txs[1] = 0x05391F73
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_不动如山" then
	txs[1] = 281904888
	txs[2] = "法术效果.wdf"
	elseif tx == "浪涌" then
	txs[1] = 1065487884
	txs[2] = "法术效果.wdf"
	elseif tx == "不动如山" then
	txs[1] = 4106497964
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_碎星诀" then
	txs[1] = 814399755
	txs[2] = "法术效果.wdf"
	elseif tx == "碎星诀" then
	txs[1] = 2704907892
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_镇魂诀" then
	txs[1] = 0xA1399E74
	txs[2] = "法术效果.wdf"
	elseif tx == "镇魂诀" then
	txs[1] = 0x8E04515D
	txs[2] = "法术效果.wdf"
	elseif tx == "翻江搅海1" then
	txs[1] = 3385103645
	txs[2] = "法术效果.wdf"
	elseif tx == "翻江搅海" then
	txs[1] = 0xBE97A345
	txs[2] = "法术效果.wdf"
	elseif tx == "无穷妙道" then
	txs[1] = 1833750106
	txs[2] = "法术效果.wdf"
   elseif tx == "状态_无穷妙道" then
	txs[1] = 1833750106
	txs[2] = "法术效果.wdf"
	elseif tx == "腾雷" then
	txs[1] = 0x5BCBB64F
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_腾雷" then
	txs[1] = 0x8E04515D
	txs[2] = "法术效果.wdf"
    elseif tx == "真君显灵" then
	txs[1] = 0x65955666
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_真君显灵" then
	txs[1] = 0x2ED4AF64
	txs[2] = "法术效果.wdf"
	elseif tx == "惊涛怒" then
	txs[1] = 3197608773
	txs[2] = "法术效果.wdf"
	--无底洞
	elseif tx == "煞气诀" then
	txs[1] = 0x3C876325
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_煞气诀" then
	txs[1] = 0x7EBEB9CB
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_煞气诀1" then
	txs[1] = 0x7EBEB9CB
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_摧心术" then
	txs[1] = 0x69180378
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_惊魂掌" then
	txs[1] = 2156799976
	txs[2] = "法术效果.wdf"
	elseif tx == "摧心术" then
	txs[1] = 0xA114D468
	txs[2] = "法术效果.wdf"
	elseif tx == "惊魂掌" then
	txs[1] = 3285527731
	txs[2] = "法术效果.wdf"
	elseif tx == "金身舍利" then
	txs[1] = 0x74A85C95
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_金身舍利" then
	txs[1] = 0xECEC37F7
	txs[2] = "法术效果.wdf"
	elseif tx == "万木凋枯" then
	txs[1] = 0x15AE9E20
	txs[2] = "法术效果.wdf"
	elseif tx == "同舟共济" then
	txs[1] = 0x5DC6FFDD
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_同舟共济" then
	txs[1] = 0x5826238A
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_夺魄令1" then
	txs[1] = 566328485
	txs[2] = "法术效果.wdf"
	elseif tx == "夺魄令1" then
	txs[1] = 2668097987
	txs[2] = "法术效果.wdf"
    elseif tx == "状态_夺魄令" then
	txs[1] = 566328485
	txs[2] = "法术效果.wdf"
	elseif tx == "夺魄令" then
	txs[1] = 2668097987
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_妖风四起" then
	txs[1] = 0x1A13CECE
	txs[2] = "法术效果.wdf"
	elseif tx == "妖风四起" then
	txs[1] = 0x89C0CCF0
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_移魂化骨" then
	txs[1] = 759125516
	txs[2] = "法术效果.wdf"
	elseif tx == "移魂化骨" then
	txs[1] = 330324521
	txs[2] = "法术效果.wdf"
	elseif tx == "夺命咒" then
	txs[1] = 2699497351
	txs[2] = "法术效果.wdf"
	elseif tx == "明光宝烛" then
	txs[1] = 1479134995
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_明光宝烛" then
	txs[1] = 540412418
	txs[2] = "法术效果.wdf"
	elseif tx == "地涌金莲" then
	txs[1] = 0xC0A21E7F
	txs[2] = "法术效果.wdf"
	-- elseif tx == "由己渡人" then
	-- txs[1] = 0xA1A5E0CD
	-- txs[2] = "法术效果.wdf"
	--五庄观
	elseif tx == "天地同寿" then
	txs[1] = 0X64FB6A90
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天地同寿" then
	txs[1] = 0xB1BA79C9
	txs[2] = "法术效果.wdf"
	elseif tx == "乾坤妙法" then
	txs[1] = 0X89B2D33A
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_乾坤妙法" then
	txs[1] = 0x56E05B32
	txs[2] = "法术效果.wdf"
	elseif tx == "太极生化" then
	txs[1] = 0X14E3155E
	txs[2] = "法术效果.wdf"
	elseif tx == "清风望月" then
	txs[1] = 0XC495FEB7
	txs[2] = "法术效果.wdf"
	elseif tx == "天命剑法" or tx == "剑意莲心" then
	txs[1] = 0x66BEBCBA
	txs[2] = "法术效果.wdf"
	elseif tx=="状态_驱魔" then
	txs[1] = 0xE89A19DF
	txs[2] = "法术效果.wdf"
	elseif tx == "驱魔" or tx == "驱尸" then
	txs[1] = 0x726AC447
	txs[2] = "法术效果.wdf"
	elseif tx == "烟雨剑法" or tx == "敲金击玉" or tx == "天神怒斩"  or tx == "金击式" or tx == "百鬼噬魂"   then
	txs[1] = 3496024499
	txs[2] = "法术效果.wdf"
	elseif tx == "飘渺式" then
	txs[1] = 3496024499
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_日月乾坤" then
	txs[1] = 826002553
	txs[2] = "法术效果.wdf"
	elseif tx == "日月乾坤" then
	txs[1] = 2802651747
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_蓝灯" or tx =="状态_炼气化神" then
	txs[1] = 1906144895
	txs[2] = "法术效果.wdf"
	elseif tx == "炼气化神" then
	txs[1] = 910697598
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_红灯" then
	txs[1] = 4176381242
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_生命之泉" then
	txs[1] = 4176381242
	txs[2] = "法术效果.wdf"
	elseif tx == "生命之泉" then
	txs[1] = 3537672915
	txs[2] = "法术效果.wdf"
	elseif tx == "三花聚顶" then
	txs[1] = 2002768611
	txs[2] = "法术效果.wdf"
	--天宫
	elseif tx == "天诛地灭" then
	txs[1] = 0xE4A2B66E
	txs[2] = "法术效果.wdf"
	elseif tx == "镇妖" then
	txs[1] = 0x1EB0026B
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_镇妖" then
	txs[1] = 0x98753F94
	txs[2] = "法术效果.wdf"
	elseif tx == "知己知彼" then
	txs[1] = 0x21F550FF
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_知己知彼" then
	txs[1] = 0x2CE2133E
	txs[2] = "法术效果.wdf"
	elseif tx == "金刚镯" then
	txs[1] = 0x434750DE
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_金刚镯" then
	txs[1] = 0x426C0CC4
	txs[2] = "法术效果.wdf"
    elseif tx == "画地为牢" then
	txs[1] = 0x5BCBB64F
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_画地为牢" then
	txs[1] = 0xDC6AE6D7
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_轰鸣" then
	txs[1] = 0xFAF4A2D4
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_电芒" then
	txs[1] = 0x159F4562
	txs[2] = "法术效果.wdf"
	elseif tx == "风雷韵动" or tx == "噬毒" then
	txs[1] = 0x2406DA40
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天神护体" then
	txs[1] = 1724676649
	txs[2] = "法术效果.wdf"
	elseif tx == "天神护体" then
	txs[1] = 3231493430
	txs[2] = "法术效果.wdf"
	elseif tx == "天神护法" or tx == "潜龙在渊" or tx == "电光火石"  then
	txs[1] = 0x73604A57
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天神护法" then
	txs[1] = 3562887539
	txs[2] = "法术效果.wdf"
	elseif tx == "五雷轰顶" then
	txs[1] = 4292234442
	txs[2] = "法术效果.wdf"
	elseif tx == "雷霆万钧" or tx == "雷霆汹涌" then
	txs[1] = 664467571
	txs[2] = "法术效果.wdf"
	elseif tx == "天雷斩" or tx == "风雷斩"  then
	txs[1] = 3054771897
	txs[2] = "法术效果.wdf"
	elseif tx == "宁心" then
	txs[1] = 0xA72FDB18
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_宁心" then
	txs[1] = 0x7DCEE534
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_错乱" or tx == "状态_反间之计" or tx == "状态_疯狂" then
	txs[1] = 2557820820
	txs[2] = "法术效果.wdf"
	elseif tx == "错乱" then
	txs[1] = 783501166
	txs[2] = "法术效果.wdf"
	elseif tx == "百万神兵" then
	txs[1] = 2340755185
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_百万神兵" then
	txs[1] = 3297426043
	txs[2] = "法术效果.wdf"
	--地府
	elseif tx == "修罗隐身" then
	txs[1] = 0xBA7D5CD7
	txs[2] = "法术效果.wdf"
    elseif tx == "盾气" then
	txs[1] = 0xBA7D5CD7
	txs[2] = "法术效果.wdf"
	elseif tx == "魂飞魄散" then
	txs[1] = 0xDF5559A5
	txs[2] = "法术效果.wdf"
	elseif tx == "锢魂术" then
	txs[1] = 0x5C0073EE
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_锢魂术" then
	txs[1] = 0xE02F2E6D
	txs[2] = "法术效果.wdf"
	elseif tx == "黄泉之息" then
	txs[1] = 0xCEEA8F28
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_黄泉之息" then
	txs[1] = 0x61CB13B5
	txs[2] = "法术效果.wdf"
	elseif tx == "冤魂不散" then
	txs[1] = 0xFA8837EE
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_汲魂" then
	txs[1] = 0xDF5559A5
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_魍魉追魂" then
	txs[1] = 0x2D3F560C
	txs[2] = "法术效果.wdf"
	elseif tx == "魍魉追魂" or tx == "追魂刺"  then
	txs[1] = 0x63BADFEC
	txs[2] = "法术效果.wdf"
   elseif tx == "五雷挪移" then---奇经八脉
	txs[1] = 0x21F550FF
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_五雷挪移" then
	txs[1] = 0x2CE2133E
	txs[2] = "法术效果.wdf"



	elseif tx == "寡欲令" then
	txs[1] = 0xFDE4BF24
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_寡欲令" then
	txs[1] = 0xE89A19DF
	txs[2] = "法术效果.wdf"
	elseif tx == "阎罗令" then
	txs[1] = 2662404697
	txs[2] = "法术效果.wdf"
	elseif tx == "判官令" then
	txs[1] = 605841034
	txs[2] = "法术效果.wdf"
	elseif tx == "百爪狂杀"  or tx == "血影蚀心"  or tx == "六道无量"  or tx == "绝命毒牙" or tx == "无赦咒令"
		or tx == "生杀予夺"  or tx == "轻歌飘舞"  or tx == "风回旋舞"  or tx == "嫣然曼舞"  or tx == "惊鸿起舞"
		or tx == "映日妙舞"  or tx == "翩跃飞舞"  or tx == "余韵索心"
		 then
	txs[1] = 0x171544B2
	txs[2] = "法术效果.wdf"
	elseif tx == "还阳术" then
	txs[1] = 1538345049
	txs[2] = "法术效果.wdf"
	elseif tx == "幽冥鬼眼" or tx == "天眼神通" or tx == "耳目一新" or  tx == "智眼" or  tx == "怒眼" or  tx == "天眼" then
	txs[1] = 0x07DF52CA
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_幽冥鬼眼"  or  tx == "状态_智眼" or  tx == "状态_怒眼" or  tx == "状态_天眼"  or  tx == "状态_返场"  or  tx == "状态_夺目" then
	txs[1] = 0x21435203
	txs[2] = "法术效果.wdf"
	elseif tx == "尸腐毒" or tx == "尸腐毒 "  then
	txs[1] = 353158077
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_尸腐毒" or tx == "状态_尸腐毒 " or tx == "状态_六道无量" then
	txs[1] = 2208088730
	txs[2] = "法术效果.wdf"
	--普陀山
	elseif tx == "自在心法" then
	txs[1] = 0x77592664
	txs[2] = "法术效果.wdf"
	elseif tx == "紧箍咒" then
	txs[1] = 1417725769
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_紧箍咒" then
	txs[1] = 4024909497
	txs[2] = "法术效果.wdf"
	elseif tx == "杨柳甘露" or tx == "救死扶伤" then
	txs[1] = 939734977
	txs[2] = "法术效果.wdf"
	elseif tx == "莲花心音" then
	txs[1] = 0xF001A7B5
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_普渡众生"  then
	txs[1] = 0xD8857128
	txs[2] = "法术效果.wdf"
	elseif tx == "灵动九天"  then
	txs[1] = 0xAB5DAE52
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_灵动九天"  then
	txs[1] = 0x95FF4460
	txs[2] = "法术效果.wdf"
	elseif tx == "普渡众生" then
	txs[1] = 804734328
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_颠倒五行" then
	txs[1] = 923673984
	txs[2] = "法术效果.wdf"
	elseif tx == "颠倒五行" then
	txs[1] = 923673984
	txs[2] = "法术效果.wdf"
	elseif tx == "五行错位" then
	txs[1] = 0x5A07D50A
	txs[2] = "法术效果.wdf"
	elseif tx == "日光华" then
	txs[1] = 0x45CA9913
	txs[2] = "法术效果.wdf"
	elseif tx == "靛沧海" then
	txs[1] = 0x6C5F8376
	txs[2] = "法术效果.wdf"
	elseif tx == "苍茫树" then
	txs[1] = 0x9CCB6E84
	txs[2] = "法术效果.wdf"
	elseif tx == "巨岩破" then
	txs[1] = 180555238
	txs[2] = "法术效果.wdf"
	elseif tx == "地裂火" then
	txs[1] = 0x18E13BE9
	txs[2] = "法术效果.wdf"
	elseif tx == "波澜不惊"  or tx == "霹雳弦惊" or tx == "雷怒霆激"  or tx == "毒萃"  or tx == "心随意动"   then
	txs[1] = 0xB493EF60
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_波澜不惊" then
	txs[1] = 0xCDE5D209
	txs[2] = "法术效果.wdf"
	elseif tx == "莲心剑意" then
	txs[1] = 0x935FA878
	txs[2] = "法术效果.wdf"

	elseif tx == "状态_莲心剑意" or tx == "状态_霹雳弦惊" or tx == "状态_雷怒霆激"  or tx == "状态_毒萃"  or tx == "状态_心随意动"  then
	txs[1] = 0xE70C0E89
	txs[2] = "法术效果.wdf"
	--盘丝
	elseif tx == "夺命蛛丝" then
	txs[1] = 0x7CD9C342
	txs[2] = "法术效果.wdf"
	elseif tx == "瘴气" then
	txs[1] = 0x849E48FB
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_瘴气" then
	txs[1] = 0x83FD8292
	txs[2] = "法术效果.wdf"
	elseif tx == "魔音摄魂" then
	txs[1] = 0x78246FE4
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_魔音摄魂" then
	txs[1] = 0xC4AA8E18
	txs[2] = "法术效果.wdf"
	elseif tx == "复苏" then
	txs[1] = 0xDC756B6F
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_复苏" then
	txs[1] = 0x7DCEE534
	txs[2] = "法术效果.wdf"
	elseif tx == "幻镜术" then
	txs[1] = 0x8CD6756E
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_幻镜术" then
	txs[1] = 0xC30D6DC9
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_迷瘴" then
	txs[1] = 0xDA03A73D
	txs[2] = "法术效果.wdf"
	elseif tx == "落花成泥" then
	txs[1] = 0x9B69747B
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_落花成泥" then
	txs[1] = 0xD08A073D
	txs[2] = "法术效果.wdf"
	elseif tx == "姐妹同心" then
	txs[1] = 0x05AE199D
	txs[2] = "法术效果.wdf"

	elseif tx == "偷龙转凤" then
	txs[1] = 0x3D0C6FF1
	txs[2] = "法术效果.wdf"
	elseif tx == "含情脉脉" then
	txs[1] = 1399041837
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_含情脉脉" then
	txs[1] = 2164502482
	txs[2] = "法术效果.wdf"
	elseif tx == "勾魂" then
	txs[1] = 0x1B472F2F
	txs[2] = "法术效果.wdf"
	elseif tx == "摄魄" then
	txs[1] = 0x59BD69F1
	txs[2] = "法术效果.wdf"
	elseif tx == "盘丝阵" then
	txs[1] = 1774142217
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_盘丝阵" then
	txs[1] = 0x369C6A29
	txs[2] = "法术效果.wdf"
	elseif tx == "天罗地网" or tx == "蛛丝缠绕"  then
	txs[1] = 513152598
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_天罗地网" then
	txs[1] = 0xD671B65E
	txs[2] = "法术效果.wdf"
	--女儿
	elseif tx == "状态_自矜" then
	txs[1] = 0x4F116543
	txs[2] = "法术效果.wdf"
	elseif tx == "红袖添香" then
	txs[1] = 3858048292
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_红袖添香" then
	txs[1] = 0x60DAADA3
	txs[2] = "法术效果.wdf"
	elseif tx == "情天恨海" then
	txs[1] = 0xC1825B80
	txs[2] = "法术效果.wdf"
	elseif tx == "娉婷袅娜" then
	txs[1] = 0x430A96A6
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_娉婷袅娜" then
	txs[1] = 0x760B7BD7
	txs[2] = "法术效果.wdf"
	elseif tx == "飞花摘叶" then
	txs[1] = 0x78BF64A4
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_飞花摘叶" then
	txs[1] = 0xA9C8EA87
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_花护" then
	txs[1] = 0x7DCEE534
	txs[2] = "法术效果.wdf"
	elseif tx == "似玉生香"  then
	txs[1] = 1187493750
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_似玉生香" then
	txs[1] = 0x59D77EF9
	txs[2] = "法术效果.wdf"
	elseif tx == "鸿渐于陆" then
	txs[1] = 0xF4B50BFF
	txs[2] = "法术效果.wdf"
	elseif tx == "楚楚可怜" then
	txs[1] = 405595707
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_楚楚可怜" then
	txs[1] = 1923968442
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_一笑倾城" then
	txs[1] = 0x760B7BD7
	txs[2] = "法术效果.wdf"
	elseif tx == "一笑倾城" then
	txs[1] = 0x430A96A6
	txs[2] = "法术效果.wdf"
	elseif tx == "满天花雨" then
	txs[1] = 0xF4B50BFF
	txs[2] = "法术效果.wdf"
	elseif tx == "雨落寒沙_敌方" then
	txs[1] = 0x4DFA3CE0
	txs[2] = "法术效果.wdf"
	elseif tx == "雨落寒沙_我方" then
	txs[1] = 0x665F869A
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_如花解语" or tx == "状态_北冥之渊"  then
	txs[1] = 505084121
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_莲步轻舞" or tx == "状态_无畏布施"  then
	txs[1] = 3387695093
	txs[2] = "法术效果.wdf"
	elseif tx == "莲步轻舞"  or tx == "无畏布施" then
	txs[1] = 2556614190
	txs[2] = "法术效果.wdf"
	elseif tx == "如花解语"  or tx == "北冥之渊" then
	txs[1] = 2319038367
	txs[2] = "法术效果.wdf"
	elseif tx == "百毒不侵" then
	txs[1] = 0xD69CAE82
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_百毒不侵" then
	txs[1] = 0x860E67C9
	txs[2] = "法术效果.wdf"
	--方寸
	elseif tx == "三星灭魔" then
	txs[1] = 0x4850F165
	txs[2] = "法术效果.wdf"
	elseif tx == "凝神术" then
	txs[1] = 0xF896F41C
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_凝神术" then
	txs[1] = 0x308AC10B
	txs[2] = "法术效果.wdf"
	elseif tx == "乙木仙遁" or tx == "分身术" then
	txs[1] = 0x941ABBD8
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_分身术" then
	txs[1] = 0xDE1AC16B
	txs[2] = "法术效果.wdf"
	elseif tx == "离魂符" then
	txs[1] = 421114130
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_离魂符" then
	txs[1] = 3655438388
	txs[2] = "法术效果.wdf"
	elseif tx == "失魂符" then
	txs[1] = 0x7BCD8BC0
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_失魂符" then
	txs[1] = 0x8B43833D
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_定身符" then
	txs[1] = 2461182746
	txs[2] = "法术效果.wdf"
	elseif tx == "定身符" then
	txs[1] = 3729668740
	txs[2] = "法术效果.wdf"
	elseif tx == "碎甲符" then
	txs[1] = 0xC27C1229
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_碎甲符" then
	txs[1] = 0xEB3D0AC1
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_失心符" then
	txs[1] = 0x8B43833D
	txs[2] = "法术效果.wdf"
	elseif tx == "失心符" then
	txs[1] = 152755655
	txs[2] = "法术效果.wdf"
	elseif tx == "落雷符" then
	txs[1] = 4292234442
	txs[2] = "法术效果.wdf"
	elseif tx == "五雷咒" or tx == "五雷正法" or tx == "雷法崩裂" or tx == "雷法震煞" or tx == "雷法坤伏" or tx == "雷法翻天"or tx == "雷法倒海" then
	txs[1] = 947658475
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_催眠符" then
	txs[1] = 3398426285
	txs[2] = "法术效果.wdf"
	elseif tx == "催眠符" then
	txs[1] = 2663408206
	txs[2] = "法术效果.wdf"
	elseif tx == "落魄符" then
	txs[1] = 1337287235
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_落魄符" then
	txs[1] = 3635978625
	txs[2] = "法术效果.wdf"
	elseif tx == "失忆符" then
	txs[1] = 3567923082
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_失忆符" then
	txs[1] = 0xEB3D0AC1
	txs[2] = "法术效果.wdf"
	elseif tx == "追魂符" then
	txs[1] = 3556918902
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_追魂符" then
	txs[1] = 3655438388
	txs[2] = "法术效果.wdf"
	elseif tx == "归元咒"  then
	txs[1] = 0x517656E2
	txs[2] = "法术效果.wdf"
	elseif tx == "乾天罡气" then
	txs[1] = 0x144AF3F8
	txs[2] = "法术效果.wdf"
	elseif tx == "顺势而为" then
	txs[1] = 0x09CCB0F3
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_顺势而为" then
	txs[1] = 0x5ECEBEDD
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_不灭" then
	txs[1] = 0xEC3149BB
	txs[2] = "法术效果.wdf"
	elseif tx == "飞符炼魂" then
	txs[1] = 0xC1731A60
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_摧心" then
	txs[1] = 0xBFC4004F
	txs[2] = "法术效果.wdf"
	elseif tx == "钟馗论道" then
	txs[1] = 0xD6BF55AD
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_钟馗论道" then
	txs[1] = 0xDCCB25E2
	txs[2] = "法术效果.wdf"
	--宠物技能
	elseif tx == "状态_法术防御" then
	txs[1] = 0xDEDEE983
	txs[2] = "法术效果.wdf"
	elseif tx == "八凶法阵" then
	txs[1] = 0x139426B5
	txs[2] = "法术效果.wdf"
	elseif tx == "天降灵葫" then
	txs[1] = 0XF99822CE
	txs[2] = "法术效果.wdf"
	elseif tx == "叱咤风云" then
	txs[1] = 0xA19EAB31
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_死亡召唤" then
	txs[1] = 0x2C6223D4
	txs[2] = "法术效果.wdf"
	elseif tx == "上古灵符(怒雷)" then
	txs[1] = 0x538C9770
	txs[2] = "法术效果.wdf"
	elseif tx == "上古灵符(流沙)" then
	txs[1] = 0x538C9770
	txs[2] = "法术效果.wdf"
	elseif tx == "上古灵符(心火)" then
	txs[1] = 0x9779B893
	txs[2] = "法术效果.wdf"
	elseif tx == "水攻" or tx == "扶摇万里"  then
	txs[1] = 4180877467
	txs[2] = "法术效果.wdf"
 --    elseif tx == "扶摇万里" then
	-- txs[1] = 0x69007820
	-- txs[2] = "xcwsc.wdf"
	elseif tx == "落岩" then
	txs[1] = 180555238
	txs[2] = "法术效果.wdf"
	elseif tx == "惊心一剑" then
	txs[1] = 1000651155
	txs[2] = "法术效果.wdf"
	elseif tx == "雷击" then
	txs[1] = 238079300
	txs[2] = "法术效果.wdf"
	elseif tx == "牛刀小试" then
	txs[1] = 1000651155
	txs[2] = "法术效果.wdf"
	elseif tx == "烈火" then
	txs[1] = 3507654973
	txs[2] = "法术效果.wdf"
	elseif tx == "月光" then
	txs[1] = 685510219
	txs[2] = "法术效果.wdf"
	elseif tx == "力劈华山" then
	txs[1] = 4281577710
	txs[2] = "法术效果.wdf"
	elseif tx == "壁垒击破" then
	txs[1] = 2581447466
	txs[2] = "法术效果.wdf"
	elseif tx == "善恶有报" then
	txs[1] = 0x8D8A818D
	txs[2] = "法术效果.wdf"
	elseif tx == "剑荡四方"  then
	txs[1] = 0x729ADE62
	txs[2] = "法术效果.wdf"
	elseif tx == "上古灵符" then
	txs[1] = 48901659
	txs[2] = "法术效果.wdf"
	elseif tx == "夜舞倾城" then
	txs[1] = 0xF18C76DD
	txs[2] = "法术效果.wdf"
	elseif tx == "泰山压顶" or tx == "超级泰山压顶" then
	txs[1] = 0xAABB006D
	txs[2] = "法术效果.wdf"
	elseif tx == "泰山压顶1" then
	txs[1] = 0xAABB006D
	txs[2] = "法术效果.wdf"
	elseif tx == "泰山压顶2" then
	txs[1] = 0xDF4C3BE3
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火" or tx == "超级地狱烈火" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火1" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火2" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火3" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火4" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火5" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火6" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火7" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火8" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火9" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火10" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火11" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火12" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火13" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火14" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火15" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火16" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火17" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火18" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火19" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火20" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火21" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火22" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火23" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火24" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火25" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火26" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火27" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火28" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火29" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火30" then
	txs[1] = 0xBE325D99
	txs[2] = "法术效果.wdf"
	elseif tx == "地狱烈火31" then
	txs[1] = 0x257635EE
	txs[2] = "法术效果.wdf"
 --    elseif tx == "扶摇万里" then
	-- txs[1] = 0x6EFC43B9
	-- txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山" or tx == "超级水漫金山" then
	txs[1] = 0x6EFC43B9
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山1" then
	txs[1] = 0x6EFC43B9
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山2" then
	txs[1] = 0x90E8589F
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山3" then
	txs[1] = 0x6EFC43B9
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山4" then
	txs[1] = 0x90E8589F
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山5" then
	txs[1] = 0x6EFC43B9
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山6" then
	txs[1] = 0x90E8589F
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山7" then
	txs[1] = 0x6EFC43B9
	txs[2] = "法术效果.wdf"
	elseif tx == "水漫金山8" then
	txs[1] = 0x90E8589F
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒" or tx == "超级奔雷咒" then----金色闪电
	txs[1] = 0xF54C4026
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒1" then
	txs[1] = 0xF1F26922
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒2" then
	txs[1] = 0x2A997658
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒3" then
	txs[1] = 0x4C117B7C
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒4" then
	txs[1] = 0xF54C4025
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒5" then
	txs[1] = 0xF54C4025
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒6" then
	txs[1] = 0xF54C4025
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒7" then
	txs[1] = 0xF1F26922
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒8" then
	txs[1] = 0x2A997658
	txs[2] = "法术效果.wdf"
	elseif tx == "奔雷咒9" then
	txs[1] = 0x4C117B7C
	txs[2] = "法术效果.wdf"
	--杂项
	elseif tx == "逃跑" then
	txs[1] = 0xF5189E48
	txs[2] = "法术效果.wdf"
	elseif tx == "自爆" then
	txs[1] = 0xA5199709
	txs[2] = "法术效果.wdf"
	elseif tx == "捕捉开始" then
	--txs[1] = 3195920150
	--txs[2] = "法术效果.wdf"
    txs[1] = 0x10000044
	txs[2] = "房屋图标.wdf"
	elseif tx == "加血" then
	txs[1] = 2010253357
	txs[2] = "法术效果.wdf"
	elseif tx == "加愤怒" then
	txs[1] = 2156718962
	txs[2] = "法术效果.wdf"
	elseif tx == "防御" then
	txs[1] = 908223343
	txs[2] = "法术效果.wdf"
	elseif tx == "飞镖" then
	txs[1] = 0x494DC152
	txs[2] = "法术效果.wdf"
	elseif tx == "弓弩攻击" then
	txs[1] = 3804004647
	txs[2] = "法术效果.wdf"
	elseif tx == "加蓝" then
	txs[1] = 1049700101
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_冰封" then
	txs[1] = 324036383
	txs[2] = "法术效果.wdf"
	elseif tx == "保护" then
	txs[1] = 0xF013CEDF
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_毒" or tx == "状态_暗器毒" then
	txs[1] = 3687768876
	txs[2] = "法术效果.wdf"
	elseif tx == "被击中" or tx == "连击" or tx == "高级连击" or tx == "超级连击" or tx == "理直气壮" then
	txs[1] = 490729788
	txs[2] = "法术效果.wdf"
	elseif tx == "反震" then
	txs[1] = 3690777786
	txs[2] = "法术效果.wdf"
	elseif tx == "无" then
	txs[1] = 0xF013CEDF
	txs[2] = "法术效果.wdf"
	elseif tx == "暴击" then
	txs[1] = 3973111811
	txs[2] = "法术效果.wdf"
	elseif tx == "法暴" then
	txs[1] = 0xdad8ac20
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_捕捉成功" then
	txs[1] = 2601915514
	txs[2] = "法术效果.wdf"
	elseif tx == "乾坤袋" then
		txs[1] = 2601915514
		txs[2] = "法术效果.wdf"
	elseif tx == "BOSS绝杀" then
	txs[1] = 3188881443
	txs[2] = "法术效果.wdf"
	elseif tx == "升级" then
	txs[1] = 2604332261
	txs[2] = "法术效果.wdf"
	--法宝
	elseif tx == "状态_苍白纸人_敌方" then
	txs[1] = 0x2F45B9F0
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_苍白纸人_我方" then
	txs[1] = 0x592EBD89
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_混元伞_敌方" or tx == "状态_五彩娃娃_敌方" then
	txs[1] = 0x2F45B9F0
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_混元伞_我方" or tx == "状态_五彩娃娃_我方" then
	txs[1] = 0x592EBD89
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_乾坤玄火塔_敌方" then
	txs[1] = 0x325A1F6A
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_乾坤玄火塔" then
	txs[1] = 0xC236BF21
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_干将莫邪_敌方" then
	txs[1] = 0x47F867FF
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_干将莫邪_我方" then
	txs[1] = 0x7838CE56
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_发瘟匣" then
	txs[1] = 0xB87F3249
	txs[2] = "法术效果.wdf"
   elseif tx == "点石成金" then
	txs[1] = 0x2ECC6DAC
	txs[2] = "法术效果.wdf"
	elseif tx == "发瘟匣" then
	txs[1] = 0xE9EC95CD
	txs[2] = "法术效果.wdf"
	elseif tx == "腾挪劲" then
	txs[1] = 0xAC3D253B
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_碎甲刃" then
	txs[1] = 0x5525C5FB
	txs[2] = "铃铛界面.wdf"
    elseif tx == "状态_盾气_我方" then
	txs[1] = 0xAABBCC01
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_盾气_敌方" then
	txs[1] = 0xAABBCC00
	txs[2] = "法术效果.wdf"
	elseif tx == "金甲仙衣_敌方" then
	txs[1] = 0xCAE3F950
	txs[2] = "法术效果.wdf"
	elseif tx == "金甲仙衣_我方" then
	txs[1] = 0xCAE3F950
	txs[2] = "法术效果.wdf"
  	elseif tx == "状态_缚妖索" or tx=="状态_捆仙绳" or tx=="状态_缚龙索" then
	txs[1] = 0xD671B65E
	txs[2] = "法术效果.wdf"
	elseif tx == "缚妖索" or tx=="捆仙绳" or tx=="缚龙索" then
	txs[1] = 0XDC8C69E8
	txs[2] = "法术效果.wdf"
	elseif tx =="无魂傀儡_我方" or tx =="断线木偶_我方" or tx =="降魔斗篷_我方" then
	txs[1] = 602645836
	txs[2] = "法术效果.wdf"
	elseif tx =="无魂傀儡_敌方" or tx =="断线木偶_敌方" or tx =="降魔斗篷_敌方" then
	txs[1] = 0x7AEF08A1
	txs[2] = "法术效果.wdf"
	elseif tx =="无魂傀儡_我方" or tx =="断线木偶_我方" or tx =="降魔斗篷_我方" then
	txs[1] = 0x23EBA54C
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_无魂傀儡" or tx == "状态_断线木偶" or tx == "状态_无尘扇" then
	txs[1] = 0xEAA3EC9B
	txs[2] = "法术效果.wdf"
	elseif tx == "无尘扇" then
	txs[1] = 0x0B8C9232
	txs[2] = "法术效果.wdf"
	elseif tx == "混元伞" or tx == "五彩娃娃" then
	txs[1] = 0x1F334661
	txs[2] = "法术效果.wdf"
	elseif tx == "干将莫邪_敌方" then
	txs[1] = 0x47F867FF
	txs[2] = "法术效果.wdf"
	elseif tx == "干将莫邪_我方" then
	txs[1] = 0x7838CE56
	txs[2] = "法术效果.wdf"
    elseif tx == "状态_护盾_敌方" then
	txs[1] = 0x0056ACAB
	txs[2] = "护盾括号.wdf"
	elseif tx == "状态_护盾_我方" then
	txs[1] = 0x00F9DAAB
	txs[2] = "护盾括号.wdf"
	elseif tx == "清心咒" then
	txs[1] = 0x6BF02DCF
	txs[2] = "法术效果.wdf"
	elseif tx == "苍白纸人" then
	txs[1] = 0x899DFF11
	txs[2] = "法术效果.wdf"
	elseif tx == "断线木偶" or tx=="无魂傀儡" then
	txs[1] = 0x23EBA54C
	txs[2] = "法术效果.wdf"
	elseif tx == "鬼泣" or tx=="惊魂铃" then
	txs[1] = 0x96E5FD5D
	txs[2] = "法术效果.wdf"
	elseif tx == "失心钹"  then
	txs[1] = 0xB5DC4541
	txs[2] = "法术效果.wdf"
	elseif tx == "乾坤玄火塔"  then
	txs[1] = 0xE4A2B66E
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_摄魂" or tx=="摄魂"  then
	txs[1] = 0xE02F2E6D
	txs[2] = "法术效果.wdf"
	elseif tx == "状态_断线木偶" or tx=="状态_无魂傀儡" then
	txs[1] = 0xEAA3EC9B
	txs[2] = "法术效果.wdf"
	elseif tx == "七宝玲珑灯"  then
	txs[1] = 0x44302D8B
	txs[2] = "法术效果.wdf"
---------------------------------------------------------灵宝
    elseif tx == "断穹巨剑_敌方" then
		txs[1] =0x69d8c3e0
		txs[2] ="zztx.wdf"

	elseif tx == "断穹巨剑_我方" then
		txs[1] =0x7fdd0de0
		txs[2] ="zztx.wdf"
		elseif tx == "静心禅珠" then
		txs[1] =0x1ED96EE0
		txs[2] ="zztx.wdf"
	elseif tx == "宁心道符" then
		txs[1] =0xedf566e0
		txs[2] ="zztx.wdf"
	elseif tx == "状态_宁心道符" then
		txs[1] =0x195303e0
		txs[2] ="zztx.wdf"
	elseif tx == "相思寒针" then
		txs[1] =0xab04e6ab
		txs[2] ="zztx.wdf"
	elseif tx == "状态_相思寒针" then
		txs[1] =0x1e054ce0
		txs[2] ="zztx.wdf"
	elseif tx == "风舞心经_敌方" then
		txs[1] =0x8200f2e0
		txs[2] ="zztx.wdf"
	elseif tx == "风舞心经_我方" then
		txs[1] =0x5dd8c0e0
		txs[2] ="zztx.wdf"
	elseif tx == "锢魂命谱" then
		txs[1] =0xbf04fae0
		txs[2] ="zztx.wdf"
	elseif tx == "青狮獠牙" then
		txs[1] =0xe4ca53e0
		txs[2] ="zztx.wdf"
	elseif tx == "冥火炼炉" then
		txs[1] =0x69cf86e0
		txs[2] ="zztx.wdf"
	elseif tx == "缚仙蛛丝" then
		txs[1] =0x6140e704
		txs[2] ="zztx.wdf"
	elseif tx == "煞魂冥灯" then
		txs[1] =0xf570fde0
		txs[2] ="zztx.wdf"
	elseif tx == "九霄龙锥" then
		txs[1] =0x3aef41e0
		txs[2] ="zztx.wdf"
	elseif tx == "化怨清莲" then
		txs[1] =0x8eecabe0
		txs[2] ="zztx.wdf"
	elseif tx == "状态_化怨清莲" then
		txs[1] =0xa268fde0
		txs[2] ="zztx.wdf"
	elseif tx == "真阳令旗" then
		txs[1] =0x2C0204DF
		txs[2] ="zztx.wdf"
	elseif tx == "天雷音鼓" then
		txs[1] =0xe3ac32e0
		txs[2] ="zztx.wdf"
	elseif tx == "寒霜盾戟" then
		txs[1] =0xcd3741e0
		txs[2] ="zztx.wdf"
	elseif tx == "乾坤金卷" then
		txs[1] =0xc93a4fe0
		txs[2] ="zztx.wdf"
	elseif tx == "乾坤木卷" then
		txs[1] =0xc93a4fe0
		txs[2] ="zztx.wdf"
	elseif tx == "乾坤水卷" then
		txs[1] =0xc93a4fe0
		txs[2] ="zztx.wdf"
	elseif tx == "乾坤火卷" then
		txs[1] =0xc93a4fe0
		txs[2] ="zztx.wdf"
	elseif tx == "乾坤土卷" then
		txs[1] =0xc93a4fe0
		txs[2] ="zztx.wdf"
	elseif tx == "定神仙琴" then
		txs[1] =0xbf0fa1e0
		txs[2] ="zztx.wdf"
	elseif tx == "状态_定神仙琴" then
		txs[1] =0x6659aee0
		txs[2] ="zztx.wdf"
	elseif tx == "赤炎战笛" then
		txs[1] =0x4559e871
		txs[2] ="zztx.wdf"
	elseif tx == "状态_赤炎战笛" then
		txs[1] =0xf848bae0
		txs[2] ="zztx.wdf"
	elseif tx == "护体灵盾" then
		txs[1] =0x4cd30be0
		txs[2] ="zztx.wdf"
	elseif tx == "惊兽云尺" then
		txs[1] =0xc27b9ee0
		txs[2] ="zztx.wdf"
	elseif tx == "战神宝典" then
		txs[1] =0x79C39027
		txs[2] ="zztx.wdf"




--########################################################?自己修改?##########################################
	elseif tx == "战斗暴击"  then
		txs[1] = 0xECD0E003
		txs[2] = "法术效果.wdf"
	elseif tx == "战斗头标"  then
		txs[1] = 0x97C79EDB
		txs[2] = "法术效果.wdf"
	elseif tx == "打雷加电"  then
		txs[1] = 0x51EEBFF3
		txs[2] ="法术效果.wdf"
	elseif tx == "特赦令牌"  then
		txs[1] = 0x7A55F632
		txs[2] ="法术效果.wdf"
	elseif tx == "远程攻击" then
		txs[1] = 0x2843A984
		txs[2] = "法术效果.wdf"
	elseif tx == "状态_战意1"  then
		txs[1] = 0xC4FE8E3F
		txs[2] = "法术效果.wdf"
	elseif tx == "状态_战意2" then
		txs[1] = 0x3D3C8D10
		txs[2] = "法术效果.wdf"
	elseif tx == "状态_战意3" then
		txs[1] = 0x8B468339
		txs[2] = "法术效果.wdf"
    elseif  tx == "状态_超级战意1" then
		txs[1] = 0xAABBCB01
		txs[2] = "经脉特效.wdf"
	elseif  tx == "状态_超级战意2" then
		txs[1] = 0xAABBCB02
		txs[2] = "经脉特效.wdf"
	elseif  tx == "状态_超级战意3" then
		txs[1] = 0xAABBCB03
		txs[2] = "经脉特效.wdf"


	elseif tx == "召唤" then
		txs[1] = 0xF90D5594
		txs[2] = "护盾括号.wdf"
	elseif tx == "状态_爪印" then
		txs[1] = 0xA5D7B0F7
		txs[2] = "护盾括号.wdf"
	elseif tx == "状态_风灵" or tx == "状态_魔冥" or tx == "状态_风魂" or tx == "状态_剑意" or tx == "状态_轮回"  then
		txs[1] = 0x1FDF16A3
		txs[2] = "法术效果.wdf"
	elseif tx == "状态_符咒1" or tx == "状态_雷法崩裂" or tx == "状态_雷法震煞" or tx == "状态_雷法坤伏" or tx == "状态_雷法翻天"
	      or tx == "状态_雷法倒海" then
		txs[1] = 0x00000012
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_符咒2" then
		txs[1] = 0x00000013
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_符咒3" then
		txs[1] = 0x00000001
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_符咒4" then
		txs[1] = 0x00000002
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_符咒5" then
		txs[1] = 0x00000003
		txs[2] = "经脉特效.wdf"


	elseif tx == "状态_人参娃娃1" then
		txs[1] = 0x3470E85A
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_人参娃娃2" then
		txs[1] = 0x3470E85B
		txs[2] = "经脉特效.wdf"
	elseif tx == "状态_人参娃娃3" then
		txs[1] = 0x3470E85D
		txs[2] = "经脉特效.wdf"


    elseif tx == "状态_五行珠金" or tx == "状态_灵药黄"  then
     	txs[1] = 0x00000005
		txs[2] = "经脉特效.wdf"
    elseif tx == "状态_五行珠木" then
     	txs[1] = 0x00000006
		txs[2] = "经脉特效.wdf"
	 elseif tx == "状态_五行珠水" or tx == "状态_灵药蓝" then
     	txs[1] = 0x00000008
		txs[2] = "经脉特效.wdf"
    elseif tx == "状态_五行珠火"  or tx == "状态_灵药红" then
     	txs[1] = 0x00000004
		txs[2] = "经脉特效.wdf"
    elseif tx == "状态_五行珠土" then
     	txs[1] = 0x00000009
		txs[2] = "经脉特效.wdf"
    elseif tx == "状态_神焰" then
     	txs[1] = 0x00000C29
		txs[2] = "mapani.wd2"
     elseif tx == "状态_清净" then
		txs[1] = 0x52736AED
		txs[2] = "法术效果.wdf"
    elseif tx == "利刃" then------未用到效果
		txs[1] = 0x92915A94
		txs[2] = "法术效果.wdf"




    elseif tx == "枫影二刃" then
        txs[1] = 0x00000015
		txs[2] = "jljnsc.wdf"
    elseif tx == "一斧开天" then
        txs[1] = 0x00000021
		txs[2] = "jljnsc.wdf"
    elseif tx == "铁血生风" then
        txs[1] = 0x00000019
		txs[2] = "jljnsc.wdf"
    elseif tx == "力劈苍穹" or tx == "魔神之刃"  then
        txs[1] = 0x00000003
		txs[2] = "jljnsc.wdf"
	elseif tx == "铁火双扬" then
        txs[1] = 0x00000003
		txs[2] = "jljnsc.wdf"
-- 00000001.力劈苍穹人物攻击
-- 00000002.力劈苍穹人物行走
-- 00000004.力劈苍穹影子特效
--"铁火双扬"

    elseif tx == "三荒尽灭"  then
        txs[1] = 0x00000018
		txs[2] = "jljnsc.wdf"


	elseif tx == "怒哮" then
        txs[1] = 0x00000020
		txs[2] = "jljnsc.wdf"
	elseif tx == "炎魂" then
        txs[1] = 0x00000020
		txs[2] = "jljnsc.wdf"
	elseif tx == "浮空" then
        txs[1] = 0x00000017
		txs[2] = "jljnsc.wdf"

  --   elseif tx == "状态_炎魂" then
  --       txs[1] = 0x00000020
		-- txs[2] = "jljnsc.wdf"
    elseif tx == "状态_浮空" then
        txs[1] = 0x00000023
		txs[2] = "jljnsc.wdf"
    elseif tx == "状态_怒哮" then
        txs[1] = 0x00000022
		txs[2] = "jljnsc.wdf"
    else

    	 txs[1] = 0x00000022
		txs[2] = "jljnsc.wdf"

	end
	return txs
end

function 引擎.取光环(tx)
	local n={}
	if tx == "烈焰澜翻" then
	   	n[1]=0x52A385FE
	   	n[2]=0x60FB8930
	   	n[3]=0x1CDB4C3F
	   	n[4]="法术效果.wdf"
	elseif tx == "水墨游龙" then
	   	n[1]=0x0DF5F610
	   	n[2]=0x8109B081
	   	n[3]=0xFFCF398C
	   	n[4]="法术效果.wdf"
	elseif tx == "星光熠熠" then
	   	n[1]=0xCA82DD54
	   	n[2]=0xFCC5CE3A
	   	n[3]=0xCA82DD54
	    n[4]="法术效果.wdf"
	elseif tx == "双鲤寄情" then
	   	n[1]=0xC056D8DD
	   	n[2]=0x865FF084
	   	n[3]=0x654EAD9E
	    n[4]="法术效果.wdf"
	elseif tx == "凌波微步" then
	   	n[1]=0x6F1A7860
	   	n[2]=0x242264D2
	   	n[3]=0xE1D6A08F
	    n[4]="法术效果.wdf"
	elseif tx == "浩瀚星河" then
	   	n[1]=0x200B20C2
	  	n[2]=0x1E064D72
	   	n[3]=0x04A28CA1
	    n[4]="法术效果.wdf"
	elseif tx == "荷塘涟漪" then
	   	n[1]=0x085A1CE8
	   	n[2]=0x4F049527
	   	n[3]=0x268ED6D4
	    n[4]="法术效果.wdf"
	elseif tx == "雪花飘落" then
	   	n[1]=0x12907C0F
	   	n[2]=0xDE953084
	   	n[3]=0xDE953084
	    n[4]="法术效果.wdf"
	elseif tx == "花的海洋" then
	   	n[1]=0xCA3B3A8F
	   	n[2]=0xBACF8614
	   	n[3]=0xCA3B3A8F
	    n[4]="法术效果.wdf"
	elseif tx == "九霄云图" then
	   	n[1]=0x00000045          ---新加光环 -特效
	   	n[2]=0x00000045
	   	n[3]=0x00000045
	    n[4]="ghtb.wdf"
	elseif tx == "财源滚滚" then
	   	n[1]=0x00000046          ---新加光环 -特效
	   	n[2]=0x00000046
	   	n[3]=0x00000046
	    n[4]="ghtb.wdf"
	elseif tx == "寒霜冰凌" then
	   	n[1]=0x00000047         ---新加光环 -特效   寒霜冰凌 金枝春绽 九尾庞庞 浪淘沙墨黑 浪淘沙月白 凌霄天宫 凌霄天宫墨黑 凌霄天宫月白 流云蝶影 琪草瑶花 琪草瑶花
	   	n[2]=0x00000047                              --沙骨王座   午夜魔蝠 星驰剑阵 星驰剑阵染 月半潮 月半潮墨黑 月半潮月白 云龙梦 云龙梦墨黑 云龙梦月白
	   	n[3]=0x00000047
	    n[4]="ghtb.wdf"
	elseif tx == "金枝春绽" then
	   	n[1]=0x00000048          ---新加光环 -特效
	   	n[2]=0x00000048
	   	n[3]=0x00000048
	    n[4]="ghtb.wdf"
	elseif tx == "九尾庞庞" then
	   	n[1]=0x00000049          ---新加光环 -特效
	   	n[2]=0x00000049
	   	n[3]=0x00000049
	    n[4]="ghtb.wdf"
	elseif tx == "浪淘沙墨黑" then
	   	n[1]=0x00000050         ---新加光环 -特效
	   	n[2]=0x00000050
	   	n[3]=0x00000050
	    n[4]="ghtb.wdf"
	elseif tx == "浪淘沙月白" then
	   	n[1]=0x00000051         ---新加光环 -特效
	   	n[2]=0x00000051
	   	n[3]=0x00000051
	    n[4]="ghtb.wdf"
	elseif tx == "凌霄天宫" then
	   	n[1]=0x00000052          ---新加光环 -特效
	   	n[2]=0x00000052
	   	n[3]=0x00000052
	    n[4]="ghtb.wdf"
	elseif tx == "凌霄天宫墨黑" then
	   	n[1]=0x00000053          ---新加光环 -特效
	   	n[2]=0x00000053
	   	n[3]=0x00000053
	    n[4]="ghtb.wdf"
	elseif tx == "凌霄天宫月白" then
	   	n[1]=0x00000054          ---新加光环 -特效
	   	n[2]=0x00000054
	   	n[3]=0x00000054
	    n[4]="ghtb.wdf"
	elseif tx == "流云蝶影" then
	   	n[1]=0x00000055         ---新加光环 -特效
	   	n[2]=0x00000055
	   	n[3]=0x00000055
	    n[4]="ghtb.wdf"
	elseif tx == "琪草瑶花" then
	   	n[1]=0x00000056         ---新加光环 -特效
	   	n[2]=0x00000056
	   	n[3]=0x00000056
	    n[4]="ghtb.wdf"
	elseif tx == "琪花瑶草" then
	   	n[1]=0x00000057          ---新加光环 -特效
	   	n[2]=0x00000057
	   	n[3]=0x00000057
	    n[4]="ghtb.wdf"
	-- elseif tx == "沙骨王座" then
	--    	n[1]="沙骨王座"          ---新加光环 -特效
	--    	n[2]="沙骨王座"
	--    	n[3]="沙骨王座"
	--     n[4]="ghtb.wdf"
	elseif tx == "午夜魔蝠" then
	   	n[1]=0x00000058          ---新加光环 -特效
	   	n[2]=0x00000058
	   	n[3]=0x00000058
	    n[4]="ghtb.wdf"
	elseif tx == "星驰剑阵" then
	   	n[1]=0x00000059         ---新加光环 -特效
	   	n[2]=0x00000059
	   	n[3]=0x00000059
	    n[4]="ghtb.wdf"
	elseif tx == "星驰剑阵染" then
	   	n[1]=0x00000060          ---新加光环 -特效
	   	n[2]=0x00000060
	   	n[3]=0x00000060
	    n[4]="ghtb.wdf"
	elseif tx == "月半潮" then
	   	n[1]=0x00000061          ---新加光环 -特效
	   	n[2]=0x00000061
	   	n[3]=0x00000061
	    n[4]="ghtb.wdf"
	elseif tx == "月半潮墨黑" then
	   	n[1]=0x00000062          ---新加光环 -特效
	   	n[2]=0x00000062
	   	n[3]=0x00000062
	    n[4]="ghtb.wdf"
	elseif tx == "月半潮月白" then
	   	n[1]=0x00000063          ---新加光环 -特效
	   	n[2]=0x00000063
	   	n[3]=0x00000063
	    n[4]="ghtb.wdf"
	elseif tx == "云龙梦" then
	   	n[1]=0x00000064          ---新加光环 -特效
	   	n[2]=0x00000064
	   	n[3]=0x00000064
	    n[4]="ghtb.wdf"
  elseif tx == "云龙梦墨黑" then
        n[1]=0x00000065          ---新加光环 -特效
        n[2]=0x00000065
        n[3]=0x00000065
	    n[4]="ghtb.wdf"
	elseif tx == "云龙梦月白" then
	   	n[1]=0x00000066         ---新加光环 -特效
	   	n[2]=0x00000066
	   	n[3]=0x00000066
	    n[4]="ghtb.wdf"

--------------------------------------------------------------------------


	elseif tx == "爱的光影" then
	   	n[1]=0xF0CBB55B
	   	n[2]=0xF0CBB55B
	   	n[3]=0xF0CBB55B
	    n[4]="法术效果.wdf"
	elseif tx == "祥云瑞气" then
	   	n[1]=0xD5E2F0A8
	   	n[2]=0x84BE68C9
	   	n[3]=0x50907DFA
	    n[4]="法术效果.wdf"
	elseif tx == "珠落玉盘" then
	   	n[1]=0xAAC2A157
	   	n[2]=0xAAC2A157
	   	n[3]=0xAAC2A157
	    n[4]="法术效果.wdf"
	elseif tx == "红叶随风" then
	   	n[1]=0x00000017
	   	n[2]=0x00000017
	   	n[3]=0x00000017
	    n[4]="法术效果.wdf"
	elseif tx == "月影婆娑" then
	   	n[1]=0x00000018
	   	n[2]=0x00000018
	   	n[3]=0x00000018
	    n[4]="法术效果.wdf"
	end
	return n
end

function 引擎.取足迹(tx)
	local n={}
	if tx == "龙卷风足迹" then
	   n[1]=0x00000019
	   n[4]="法术效果.wdf"
    elseif tx == "皮球足迹" then
	   n[1]=0x9C146BBA
	   n[4]="法术效果.wdf"
	elseif tx == "雀屏足迹" then
	   n[1]=0xFFED8401
	   n[4]="法术效果.wdf"
	elseif tx == "旋律足迹" then
	   n[1]=0xD8D8AFFF
	   n[4]="法术效果.wdf"
	elseif tx == "枫叶足迹" then
	   n[1]=0xF879A813
	   n[4]="法术效果.wdf"
	elseif tx == "飞天足迹" then
	   n[1]=0xE7B37A0B
	   n[4]="法术效果.wdf"
	elseif tx == "两心相悦足迹" then
	   n[1]=0x7D75476A
	   n[4]="法术效果.wdf"
	elseif tx == "心花怒放" then
	   n[1]=0xD5933DC2
	   n[4]="法术效果.wdf"
	elseif tx == "雷电足迹" then
	   n[1]=0xC3060301
	   n[4]="法术效果.wdf"
	elseif tx == "寒冰足迹" then
	   n[1]=0xD588789A
	   n[4]="法术效果.wdf"
	elseif tx == "星星祈愿" then
	   n[1]=0xFCA197EB
	   n[4]="法术效果.wdf"
	elseif tx == "地狱焰火" then
	   n[1]=0x7D931979
	   n[4]="法术效果.wdf"
	elseif tx == "元宝足迹" then
	   n[1]=0x8E5FA0FF
	   n[4]="法术效果.wdf"
	elseif tx == "光剑足迹" then
	   n[1]=0x988D7A27
	   n[4]="法术效果.wdf"
	elseif tx == "雪花足迹" then
	   n[1]=0xF7071DAB
	   n[4]="法术效果.wdf"
	end
	return n
end
-- [16then"财源滚滚","锦衣","财源滚滚",500},
-- [17then"寒霜冰凌","锦衣","寒霜冰凌",500},
-- [18then"金枝春绽","锦衣","金枝春绽",500},
-- [19then"九尾庞庞","锦衣","九尾庞庞",500},
-- [20then"浪淘沙墨黑","锦衣","浪淘沙墨黑",500},
-- [21then"浪淘沙月白","锦衣","浪淘沙月白",500},
-- [22then"凌霄天宫墨黑","锦衣","凌霄天宫墨黑",500},
-- [23then"凌霄天宫月白","锦衣","凌霄天宫月白",500},
-- [24then"流云蝶影","锦衣","流云蝶影",500},
-- [25then"琪草瑶花","锦衣","琪草瑶花",500},
-- [26then"琪花瑶草","锦衣","琪花瑶草",500},
-- [27then"沙骨王座","锦衣","沙骨王座",500},
-- [28then"午夜魔蝠","锦衣","午夜魔蝠",500},
-- [29then"星驰剑阵","锦衣","星驰剑阵",500},
-- [30then"星驰剑阵染","锦衣","星驰剑阵染",500},
-- [31then"月半潮","锦衣","月半潮",500},
-- [32then"月半潮墨黑","锦衣","月半潮墨黑",500},
-- [33then"月半潮月白","锦衣","月半潮月白",500},
-- [34then"云龙梦","锦衣","云龙梦",500},
-- [35then"云龙梦墨黑","锦衣","云龙梦墨黑",500},
-- [36then"云龙梦月白","锦衣","云龙梦月白",500},

-- 仙玉商城.仙玉商城.灵宝={
-- [1]={"断穹巨剑","灵宝","断穹巨剑",20000},
-- [2]={"静心禅珠","灵宝","静心禅珠",20000},
-- [3]={"宁心道符","灵宝","宁心道符",20000},
-- [4]={"相思寒针","灵宝","相思寒针",20000},
-- [5]={"风舞心经","灵宝","风舞心经",20000},
-- [6]={"锢魂命谱","灵宝","锢魂命谱",20000},
-- [7]={"青狮獠牙","灵宝","青狮獠牙",20000},
-- [8]={"冥火炼炉","灵宝","冥火炼炉",20000},
-- [9]={"缚仙蛛丝","灵宝","缚仙蛛丝",20000},
-- [10]={"煞魂冥灯","灵宝","煞魂冥灯",20000},
-- [11]={"九霄龙锥","灵宝","九霄龙锥",20000},
-- [12]={"化怨清莲","灵宝","化怨清莲",20000},
-- [13]={"真阳令旗","灵宝","真阳令旗",20000},
-- [14]={"天雷音鼓","灵宝","天雷音鼓",20000},
-- [15]={"寒霜盾戟","灵宝","寒霜盾戟",20000},
-- [16]={"乾坤金卷","灵宝","乾坤金卷",20000},
-- [17]={"乾坤木卷","灵宝","乾坤木卷",20000},
-- [18]={"乾坤水卷","灵宝","乾坤水卷",20000},
-- [19]={"乾坤火卷","灵宝","乾坤火卷",20000},
-- [20]={"乾坤土卷","灵宝","乾坤土卷",20000},
-- [21]={"定神仙琴","灵宝","定神仙琴",20000},
-- [22]={"护体灵盾","灵宝","护体灵盾",20000},
-- [23]={"惊兽云尺","灵宝","惊兽云尺",40000},
-- [24]={"战神宝典","灵宝","战神宝典",40000},






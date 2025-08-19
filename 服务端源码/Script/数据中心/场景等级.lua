--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-23 12:36:53
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
function 取随机怪(a,b)
	local 临时信息=取等级怪(取随机数(a,b))
	local 临时模型=取敌人信息(临时信息[取随机数(1,#临时信息)])
	return 临时模型
end

function 取等级怪(lv)
	local em = {}
	if lv <= 5 then
		em = {-500,-492,-488,-480,-520,-508,-516,-504,-512,-484,-472, -476, -496}
	elseif lv > 5 and lv <= 15 then
		em = {-548,-544,-528,-540,-536,-524,-532}
	elseif lv > 15 and lv <= 25 then
		em = {-572,-568,-564,-560,-556,-552}
	elseif lv > 25 and lv <= 35 then
		em = {-596,-592,-584,-588,-600,-580,-576}
	elseif lv > 35 and lv <= 45 then
		em = {-692,-700,-696,-688,-684}
	elseif lv > 45 and lv <= 55 then
		em = {-1492,-1496,-1488,-1484}
	elseif lv > 55 and lv <= 65 then
		em = {-2959,-2984,-1500,-2988,-2980,-2955}
	elseif lv > 65 and lv <= 75 then
		em = {-2967,-2971,-2963,-2975,-2996,-2992,-3004,-3000}
	elseif lv > 75 and lv <= 85 then
		em = {-6988,-6984,-6992,-7000,-6996}
	elseif lv > 85 and lv <= 95 then
		em = {-7958,-7966,-7962,-7974,-7970}
	elseif lv > 95 and lv <= 105 then
		em = {-8000,-7978,-7982,-7986}
	elseif lv > 105 and lv <= 125 then
		em = {-9879,-9895,-9883,-9887,-9899,-9903,-9891,-9907}
	elseif lv > 125 and lv <= 135 then
		em = {-9927,-9931,-9911,-9923,-9919,-9939,-9915,-9935}
	elseif lv > 135 and lv <= 145 then
		em = {-9943,-9947,-9951,-9955}
	elseif lv > 145 and lv <= 155 then
		em = {-9959,-9963,-9967,-9971,-9975,-9979,-9983,-9987}
	elseif lv > 155 then
		em = {-9991,-9995,-9999,40009,30006,130006,130002,30002,29998}
	end
	return em
end

function 取场景等级(map)
	if map == 1506 then--"东海湾"
		return 1,7
	elseif map == 1507 then--"东海海底"
		return 5,9
	elseif map == 1508 then--"沉船"
		return 9,13
	elseif map == 1126 then--"东海岩洞"
		return 5,12
	elseif map == 1193 then--"江南野外"
		return 6,16
	elseif map == 1004 then--"大雁塔一层"
		return 8,18
	elseif map == 1005 then--"大雁塔二层"
		return 12,22
	elseif map == 1006 then--"大雁塔三层"
		return 16,26
	elseif map == 1007 then--"大雁塔四层"
		return 20,30
	elseif map == 1008 then--"大雁塔五层"
		return 24,34
	elseif map == 1090 then--"大雁塔六层"
		return 28,38
	elseif map == 1110 then--"大唐国境"
		return 11,21
	elseif map == 1173 then--"大唐境外"
		return 20,30
	elseif map == 1091 then--"长寿郊外"
		return 26,36
	elseif map == 1512 then--"魔王寨"
		return 32,42
	elseif map == 1140 then--"普陀山"
		return 36,46
	elseif map == 1513 then--"盘丝岭"
		return 38,48
	elseif map == 1131 then--"狮驼岭"
		return 40,50
	elseif map == 1514 then--"花果山"
		return 29,39
	elseif map == 1118 then--"海底迷宫一层"
		return 33,43
	elseif map == 1119 then--"海底迷宫二层"
		return 35,45
	elseif map == 1120 then--"海底迷宫三层"
		return 37,47
	elseif map == 1121 then--"海底迷宫四层"
		return 40,55
	elseif map == 1532 then--"海底迷宫五层"
		return 55,65
	elseif map == 1127 then--"地狱迷宫一层"
		return 33,43
	elseif map == 1128 then--"地狱迷宫二层"
		return 35,45
	elseif map == 1129 then--"地狱迷宫三层"
		return 37,47
	elseif map == 1130 then--"地狱迷宫四层"
		return 40,55
	elseif map == 1202 then--"无名鬼城"
		return 100,110
	elseif map == 1174 then--"北俱芦洲"
		return 40,55
	elseif map == 1177 then--"龙窟一层"
		return 42,52
	elseif map == 1178 then--"龙窟二层"
		return 44,54
	elseif map == 1179 then--"龙窟三层"
		return 46,56
	elseif map == 1180 then--"龙窟四层"
		return 48,58
	elseif map == 1181 then--"龙窟五层"
		return 50,60
	elseif map == 1182 then--"龙窟六层"
		return 60,70
	elseif map == 1183 then--"龙窟七层"
		return 80,90
	elseif map == 1186 then--"凤巢一层"
		return 42,52
	elseif map == 1187 then--"凤巢二层"
		return 44,54
	elseif map == 1188 then--"凤巢三层"
		return 46,56
	elseif map == 1189 then--"凤巢四层"
		return 48,58
	elseif map == 1190 then--"凤巢五层"
		return 50,60
	elseif map == 1191 then--"凤巢六层"
		return 70,80
	elseif map == 1192 then--"凤巢七层"
		return 80,90
	elseif map == 1201 then--"女娲神迹"
		return 100,110
	elseif map == 1207 then--"蓬莱仙岛"
		return 130,145
	elseif map == 1203 then--小西天
		return 115,125
	elseif map == 1204 then--"小雷音寺"
		return 125,135
	elseif map == 1114 then--"月宫"
		return 40,50
	elseif map == 1231 then--"蟠桃园"
		return 150,160
	elseif map == 1221 then--"墨家禁地"
		return 140,150
	elseif map == 1042 then--"解阳山"
		return 80,90
	elseif map == 1041 then--"子母河底"
		return 70,80
	elseif map == 1210 then--"麒麟山"
		return 90,100
	elseif map == 1228 then--"碗子山"
		return 130,140
	elseif map == 1229 then--"波月洞"
		return 150,160
	elseif map == 1233 then--"柳林坡"
		return 150,155
	elseif map == 1232 then--"比丘国"
		return 155,160
	elseif map == 1242 then--须弥东界
		return 170,180
	elseif map == 1605 then--天鸣洞天
		return 50,55
	elseif map == 1223 then--观星台
		return 50,55
	elseif map == 1876 then--南岭山
		return 30,45
	elseif map == 1920 then--"凌云渡"
		return 170,180
	--==================
	end
end
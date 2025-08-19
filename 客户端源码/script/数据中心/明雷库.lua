--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2022-08-11 14:43:16
--======================================================================--
function 引擎.取明雷(map)
	local ems
	if map == 1004 then
		ems = {"羊头怪","赌徒","强盗","骷髅怪","蛤蟆精","狐狸精"}
	elseif  map == 1005 then
	    ems = {"羊头怪","赌徒","强盗","骷髅怪","蛤蟆精","狐狸精"}
	elseif  map == 1006 then
	    ems = {"羊头怪","花妖","骷髅怪","蛤蟆精","狐狸精"}
	elseif  map == 1007 then
	    ems = {"羊头怪","花妖","骷髅怪","蛤蟆精","狐狸精"}
	elseif  map == 1008 then
	    ems = {"羊头怪","花妖","骷髅怪","蛤蟆精","狐狸精"}
	elseif  map == 1090 then
	    ems = {"羊头怪","花妖","大蝙蝠","蛤蟆精","狐狸精"}
	end
	return ems
end
-- 1233
function 引擎.取野怪(map)--########################################################?自己修改?##########################################
	local ems,lvs
	if map == 1231 then
		ems = {-9971,-9975,-9967}--自己
	elseif map == 1221 then
		ems = {-7958,-9943,-9947,-9939,-9955,-9951}--自己
	elseif map == 1177 then
		ems = {-684,-692}
	elseif map == 1191 then
		ems = {-2971,-1484}
	elseif map == 1190 then
		ems = {-1496,-2959}
	elseif map == 1189 then
		ems = {-1496,-2959}
	elseif map == 1228 then
		ems = {-9915,-9911}--自己
	elseif map == 1229 then
		ems = {-9959,-9963,-9923,-9919,-9967}--自己
	elseif map == 1187 then
		ems = {-700,-1492}
	elseif map == 1180 then
		ems = {-1484,-2955}
	elseif map == 1178 then
		ems = {-688,-684}
	elseif map == 1204 then
		ems = {-9887,-9883,-9879,-7958}
	elseif map == 1183 then
		ems = {-2955,-1488,-2963,-2967}
	elseif map == 1182 then
		ems = {-1500,-2967}
	elseif map == 1181 then
		ems = {-1488,-2955}
	elseif map == 1179 then
		ems = {-1484,-1492}
	elseif map == 1232 then
		ems = {-9999,-9995,-9991}
	elseif map == 1202 then
		ems = {-7970,-7974,-7958,-8000,-7986,-7982}
	elseif map == 1201 then
		ems = {-7978,-7966,-7962,-7958}
	elseif map == 1042 then
		ems = {-2996,-3000,-3004,-2992}
	elseif map == 1233 then
		ems = {-9987,-9983,-9979}
	elseif map == 1004 then
		ems = {-548,-544,-540,-536,-524,-520,-516}
	elseif map == 1005 then
		ems = {-548,-544,-540,-536,-524,-520,-516}
	elseif map == 1006 then
		ems = {-548,-544,-540,-536,-524}
	elseif map == 1007 then
		ems = {-548,-544,-540,-536,-524}
	elseif map == 1008 then
		ems = {-548,-544,-540,-536,-524}
	elseif map == 1090 then
		ems = {-508,-544,-540,-536,-524}
	elseif map == 1110 then
		ems = {-504,-484,-516}
	elseif map == 1091 then
		ems = {-560,-568}
	elseif map == 1173 then
		ems = {-532,-528,-524}
	elseif map == 1512 then
		ems = {-572,-540}
	elseif map == 1131 then
		ems = {-700,-696}
	elseif map == 1210 then
		ems = {-7000,-6996,-6992,-6988,-6984}
	elseif map == 1207 then
		ems = {-9934,-9931,-9927,-9907,-7958}
	elseif map == 1203 then
		ems = {-9903,-9899,-9895,-9891,-7958}
	elseif map == 1041 then
		ems = {-2988,-2984,-2980}
	elseif map == 1188 then
		ems = {-1488,-1492}
	elseif map == 1186 then
		ems = {-684,-1496}
	elseif map == 1140 then
		ems = {-588,-596}
	elseif map == 1513 then
		ems = {-592,-536,-524}
	elseif map == 1506 then
		ems = {-488,-472}
	elseif map == 1507 then
		ems = {-476,-472,-488,-492}
	elseif map == 1193 then
		ems = {-500,-496,-480}
	elseif map == 1126 then
		ems = {-512}
	elseif map == 1508 then
		ems = {-472,-476,-492,-488,-512}
	elseif map == 1514 then
		ems = {-528,-532,-568}
	elseif map == 1118 then
		ems = {-556}
	elseif map == 1120 then
		ems = {-600}
	--########################################################?自己修改?##########################################
	elseif map == 1121 then
		ems = {-600,-556}
	elseif map == 1532 then
		ems = {-600,-556}
	elseif map == 1119 then
		ems = {-556,-552}
	elseif map == 1127 then
		ems = {-564,-584}
	elseif map == 1127 then
		ems = {-564,-584}
	elseif map == 1128 then
		ems = {-564}
	elseif map == 1129 then
		ems = {-576,-580,-584}
	elseif map == 1130 then
		ems = {-576,-580}
	elseif map == 1174 then
		ems = {-688,-692,-1496}
	elseif map == 1177 then
		ems = {-684,-692}
	elseif map == 1178 then
		ems = {-684,-688}
	elseif map == 1179 then
		ems = {-1484,-1492}
	elseif map == 1180 then
		ems = {-1484,-2955}
	elseif map == 1181 then
		ems = {-1488,-2955}
	elseif map == 1182 then
		ems = {-1500,-2967}
	elseif map == 1183 then
		ems = {-1488,-2955,-2967,-2963}
	elseif map == 1186 then
		ems = {-684,-1496}
	elseif map == 1187 then
		ems = {-1492,-700}
	elseif map == 1188 then
		ems = {-1492,-1488}
	elseif map == 1189 then
		ems = {-2959,-1496}
	elseif map == 1190 then
		ems = {-2959,-1496}
	elseif map == 1191 then
		ems = {-1484,-2971}
	elseif map == 1192 then
		ems = {-2959,-1484,-2975,-2971,-7958}
	elseif map == 1114 then
		ems = {-596,-592}
	elseif map == 1605 then
		ems = {-596,-592,-696,-700}
	elseif map == 1242 then-- "须弥东界"
		ems = {29998,30002,30006}
	elseif map == 1232 then--"比丘国"
		ems = {-9991,-9999,-9995}
	elseif map == 1233 then--"柳林坡"
		ems = {-9979,-9987,-9983}
	elseif map == 1920 then--"凌云渡"
		ems = {40009,130002,130006}
	elseif map == 1223 then--观星台
		ems = {-1500,-1496,-1492,-1484}
	elseif map == 1876 then--南岭山
		ems = {-684,-588,-560,-544,-536,-540,-532}
	--=================
	end
	--普通  排序是第一个怪物就可以了(他会自动出来宝宝和头领和变异)
	return ems
end

function 引擎.取等级怪(lv)
	local em = {}
	if lv <= 5 then
		em = {-472,-476,-480,-484,-488,-488,-496,-500,-504,-508,-512}
	elseif lv > 5 and lv <= 15 then
		em = {-516,-520,-524,-528,-532,-536,-540,-544,-548}
	elseif lv > 15 and lv <= 25 then
		em = {-552,-556,-560,-564,-568,-572,-576,-580,-584}
	elseif lv > 25 and lv <= 35 then
		em = {-588,-592,-596,-600}
	elseif lv > 35 and lv <= 45 then
		em = {-684,-688,-692,-696,-700,-576,-596,-584,-580}
	elseif lv > 45 and lv <= 55 then
		em = {-1484,-1488,-1492,-1496,}
	elseif lv > 55 and lv <= 65 then
		em = {-1500,-2955,-2959,-2980,-2984,-2988}
	elseif lv > 65 and lv <= 75 then
		em = {-2963,-2967,-2971,-2975,-2992,-2996,-3000}
	elseif lv > 75 and lv <= 85 then
		em = {-6984,-6988,-6992,-6996,-7000}
	elseif lv > 85 and lv <= 95 then
		em = {-7958,-7962,-7966,-7970,-7974}
	elseif lv > 95 and lv <= 105 then
		em = {-7978,-7982,-8000,-7986}
	elseif lv > 105 and lv <= 125 then
		em = {-9899,-9903,-9907}
	elseif lv > 125 and lv <= 135 then
		em = {-9911,-9915,-9919,-9923,-9927,-9931,-9935,-9939,-9895,-9891}
	elseif lv > 135 and lv <= 145 then
		em = {-9943,-9947,-9951,-9955}
	elseif lv > 145 and lv <= 155 then
		em = {-9959,-9963,-9967,-9971,-9975,-9979,-9983,-9987}
	elseif lv > 155 then
		em = {-9991,-9995,-9999}
	end
	return em
end

function 引擎.取场景等级(map)
	if map == 1506 then--"东海湾"
		return 0,9
	elseif map == 1507 then--"东海海底"
		return 2,12
	elseif map == 1508 then--"沉船"
		return 2,12
	elseif map == 1126 then--"东海岩洞"
		return 2,12
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
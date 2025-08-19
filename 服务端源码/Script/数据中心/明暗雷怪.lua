--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-08 21:31:03
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
function 取明雷(map)
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

function 取野怪(map)--########################################################?自己修改?##########################################
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
		ems = {-548,-544,-540,-536,-524,-520,-516,}---99999118 蚩尤
	elseif map == 1005 then
		ems = {-548,-544,-540,-536,-524,-520,-516}--99999118 蚩尤
	elseif map == 1006 then
		ems = {-548,-544,-540,-536,-524}--99999118 蚩尤
	elseif map == 1007 then
		ems = {-548,-544,-540,-536,-524}--99999118
	elseif map == 1008 then
		ems = {-548,-544,-540,-536,-524}--99999118
	elseif map == 1090 then
		ems = {-508,-544,-540,-536,-524}--99999118
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
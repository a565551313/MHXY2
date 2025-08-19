--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-17 21:55:40
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
function 取正常地图(id)
 	if id>=1600 and id <=1620 then
     	return false
  	elseif id==5001 then
     	return false
    elseif id>=6003 and id<=6009 then
    	return false
    elseif id>=6010 and id<=6019 then
    	return false
    elseif id==6020 then
    	return false
    end
  	return true
end

function 取地图名称(id)
	if id>=1600 and id <=1620 then
       return "迷宫"..(id-1600).."层"
	elseif id>=6010 and id<=6019  and id~=6011 then
	    return "帮派竞赛"
	elseif id==6011 then
	    return "帮派奖励"
	elseif id==6020 then
	    return "中立区"
    elseif id==1621 then
	    return "会员福利"
	elseif id==1622 then
	    return "轮回归墟"
	elseif id == 1501 then
		return "建邺城"
	elseif id == 1502 then
		return "建邺兵铁铺"
	elseif id == 1503 then
		return "李记布庄"
	elseif id == 1504 then
		return "回春堂分店"
	elseif id == 1505 then
		return "东升货栈"
	elseif id == 1523 then
		return "合生记"
	elseif id == 1524 then
		return "万宇钱庄"
	elseif id == 1526 or id == 1525 or id == 1527 then
		return "建邺民居"
	elseif id == 1534 then
		return "民居内室"
	elseif id == 1537 then
		return "建邺衙门"
	elseif id == 1506 then
		return "东海湾"
	elseif id == 1116 then
		return "龙宫"
	elseif id == 1126 then
		return "东海岩洞"
	elseif id == 1507 then
		return "东海海底"
	elseif id == 1508 then
		return "海底沉船"
	elseif id == 1509 then
		return "沉船内室"
	elseif id == 1193 then
		return "江南野外"
	elseif id == 1001 then
		return "长安城"
	elseif id == 1002 then
		return "化生寺"
	elseif id == 1198 then
		return "大唐官府"
	elseif id == 1054 then
		return "程咬金府"
	elseif id == 1004 then
		return "大雁塔一层"
	elseif id == 1005 then
		return "大雁塔二层"
	elseif id == 1006 then
		return "大雁塔三层"
	elseif id == 1007 then
		return "大雁塔四层"
	elseif id == 1008 then
		return "大雁塔五层"
	elseif id == 1090 then
		return "大雁塔六层"
	elseif id == 1009 then
		return "大雁塔七层"
	elseif id == 1028 then
		return "长安酒店一楼"
	elseif id == 1029 then
		return "长安酒店二楼"
	elseif id == 1020 then
		return "万胜武器店"
	elseif id == 1017 then
		return "锦绣饰品店"
	elseif id == 1022 then
		return "张记布庄"
	elseif id == 1030 then
		return "云来酒店"
	elseif id == 1043 then
		return "藏经阁"
	elseif id == 1528 then
		return "光华殿"
	elseif id == 1110 then
		return "大唐国境"
	elseif id == 1150 then
		return "凌波城"
	elseif id == 1116 then
		return "龙宫"
	elseif id == 1117 then
		return "水晶宫"
	elseif id == 1122 then
		return "阴曹地府"
	elseif id == 1140 then
		return "普陀山"
	elseif id == 1092 then
		return "傲来国"
	elseif id == 1101 then
		return "傲来武器店"
	elseif id == 1514 then
		return "花果山"
	elseif id == 1174 then
		return "北俱芦洲"
	elseif id == 1091 then
		return "长寿郊外"
	elseif id == 1177 then
		return "龙窟一层"
	elseif id == 1178 then
		return "龙窟二层"
	elseif id == 1179 then
		return "龙窟三层"
	elseif id == 1180 then
		return "龙窟四层"
	elseif id == 1181 then
		return "龙窟五层"
	elseif id == 1182 then
		return "龙窟六层"
	elseif id == 1183 then
		return "龙窟七层"
	elseif id == 1186 then
		return "凤巢一层"
	elseif id == 1187 then
		return "凤巢二层"
	elseif id == 1188 then
		return "凤巢三层"
	elseif id == 1189 then
		return "凤巢四层"
	elseif id == 1190 then
		return "凤巢五层"
	elseif id == 1191 then
		return "凤巢六层"
	elseif id == 1192 then
		return "凤巢七层"
	elseif id == 1142 then
		return "女儿村"
	elseif id == 1143 then
		return "女儿村村长家"
	elseif id == 1127 then
		return "地狱迷宫一层"
	elseif id == 1128 then
		return "地狱迷宫二层"
	elseif id == 1129 then
		return "地狱迷宫三层"
	elseif id == 1130 then
		return "地狱迷宫四层"
	elseif id == 1118 then
		return "海底迷宫一层"
	elseif id == 1119 then
		return "海底迷宫二层"
	elseif id == 1120 then
		return "海底迷宫三层"
	elseif id == 1121 then
		return "海底迷宫四层"
	elseif id == 1532 then
		return "海底迷宫五层"
	elseif id == 1111 then
		return "天宫"
	elseif id == 1070 then
		return "长寿村"
	elseif id == 1135 then
		return "方寸山"
	elseif id == 1137 then
		return "灵台宫"
	elseif id == 1173 then
		return "大唐境外"
	elseif id == 1153 then
		return "金山寺"
	elseif id == 1168 then
		return "江州府"
	elseif id == 1093 then
		return "傲来客栈"
	elseif id == 1123 then
		return "森罗殿"
	elseif id == 1124 then
		return "地藏王府"
	elseif id == 1112 then
		return "凌霄宝殿"
	elseif id == 1512 then
		return "魔王寨"
	elseif id == 1145 then
		return "魔王居"
	elseif id == 1141 then
		return "潮音洞"
	elseif id == 1146 then
		return "五庄观"
	elseif id == 1147 then
		return "乾坤殿"
	elseif id == 1131 then
		return "狮驼岭"
	elseif id == 1132 then
		return "大象洞"
	elseif id == 1133 then
		return "老雕洞"
	elseif id == 1134 then
		return "狮王洞"
	elseif id == 1202 then
		return "无名鬼城"
	elseif id == 1201 then
		return "女娲神迹"
	elseif id == 1138 then
		return "神木林"
	elseif id == 1139 then
		return "无底洞"
	elseif id == 1513 then
		return "盘丝岭"
	elseif id == 1144 then
		return "盘丝洞"
	elseif id == 1205 then
		return "战神山"
	elseif id == 1154 then
		return "神木屋"
	elseif id == 1228 then
		return "碗子山"
	elseif id == 1156 then
		return "琉璃殿"
	elseif id == 1103 then
		return "水帘洞"
	elseif id == 1040 then
		return "西梁女国"
	elseif id == 1208 then
		return "朱紫国"
	elseif id == 1209 then
		return "朱紫国皇宫"
	elseif id == 1226 then
		return "宝象国"
	elseif id == 1227 then
		return "宝象国皇宫"
	elseif id == 1235 then
		return "丝绸之路"
	elseif id == 1042 then
		return "解阳山"
	elseif id == 1041 then
		return "子母河底"
	elseif id == 1210 then
		return "麒麟山"
	elseif id == 1211 then
		return "太岁府"
	elseif id == 1242 then
		return "须弥东界"
	elseif id == 1232 then
		return "比丘国"
	elseif id == 1207 then
		return "蓬莱仙岛"
	elseif id == 1229 then
		return "波月洞"
	elseif id == 1233 then
		return "柳林坡"
	elseif id == 1114 then
		return "月宫"
	elseif id == 1231 then
		return "蟠桃园"
	elseif id == 1203 then
		return "小西天"
	elseif id == 1204 then
		return "小雷音寺"
	elseif id == 1206 then
		return "武神坛"
	elseif id == 1218 then
		return "墨家村"
	elseif id == 1221 then
		return "墨家禁地"
	elseif id == 1920 then
		return "凌云渡"
	elseif id == 1016 then
		return "回春堂药店"
	elseif id == 1033 then
		return "留香阁"
	elseif id == 1024 then
		return "长风镖局"
	elseif id == 1026 then
		return "国子监书库"
	elseif id == 1044 then
		return "金銮殿"
	elseif id == 1400 then
		return "幻境"
	elseif id == 1511 then
		return "蟠桃园"
	elseif id == 1197 then
		return "比武场"
	elseif id == 1113 then
		return "兜率宫"
	elseif id == 1095 then
		return "傲来服饰店"
	elseif id == 1083 then
		return "长寿村服装店"
	elseif id == 1085 then
		return "长寿村武器店"
	elseif id == 1003 then
--		return "桃源村"
	elseif id == 1249 then
		return "女魃墓"
	elseif id == 1250 then
		return "天机城"
	elseif id == 1251 then
		return "幻境花果山"
	elseif id == 1252 then
		return "女魃墓室内"
	elseif id == 1253 then
		return "天机堂"
	elseif id == 1340 then
		return "初级庭院"
	elseif id == 1341 then
		return "中级庭院"


	elseif id == 1342 then--高级庭院
	  return "初级庭院"
	elseif id == 1306 then
	  return "园林水榭"
	elseif id == 1446 then
	  return "农家小院"
	elseif id == 1380 then
	  return "欢乐童年"
	elseif id == 1382 then
	  return "欢乐冬日"
   elseif id == 1892 then
	  return "高级牧场"




	elseif id == 1605 then
		return "天鸣洞天"
	elseif id == 1125 then
		return "轮回司"
	elseif id == 1876 then
	  return "南岭山"
	elseif id == 6001 then
	  return "废弃的御花园"
	elseif id == 6002 then
	  return "乌鸡国皇宫"
	elseif id == 6003 then
	  return "单人竞技赛"
	elseif id == 6004 then
	  return "多人竞技赛"
	elseif id == 6005 then
	  return "神威组"
	elseif id == 6006 then
	  return "天科组"
	elseif id == 6007 then
	  return "天启组"
	elseif id == 6008 then
	  return "天元组"
	elseif id == 6009 then
	  return "首席争霸"
	elseif id == 6021 then
	  return "三清道观"
	elseif id == 6022 then
	  return "道观大殿"
	elseif id == 6023 then
	  return "九霄云外"
	elseif id == 6024 then
	  return "水陆道场"
	elseif id == 6025 then
	  return "繁华京城"
	elseif id == 6026 then
	  return "妖魔巢穴"
	elseif id == 6027 then
	  return "陈家庄"
	elseif id == 6028 then
	  return "普陀山"
	elseif id == 6029 then
	  return "通天河底"
	elseif id == 6030 then
	  return "灵感之腹"
	elseif id == 7001 then
	  return "四方城"
	elseif id == 7002 then
	  return "崔府正厅"
	elseif id == 7003 then
	  return "顶级豪宅"
	elseif id == 7004 then
	  return "沧浪墟"
    elseif id == 5003 then
	  return "妖兽巢穴"

    elseif id == 10000 then
	  return "云影准备室"
    elseif id == 10001 then
	  return "虹光准备室"

    elseif id == 10002 then
	  return "云影之红境"
    elseif id == 10003 then
	  return "云影之橙境"
    elseif id == 10004 then
	  return "云影之黄境"
    elseif id == 10005 then
	  return "云影之绿境"
    elseif id == 10006 then
	  return "云影之蓝境"
    elseif id == 10007 then
	  return "云影之靛境"
    elseif id == 10008 then
	  return "云影之紫境"
    elseif id == 10009 then
	  return "彩虹仙境"
    elseif id == 10012 then
	  return "虹光之红境"
    elseif id == 10013 then
	  return "虹光之橙境"
	elseif id == 10014 then
	  return "虹光之黄境"
	elseif id == 10015 then
	  return "虹光之绿境"
	elseif id == 10016 then
	  return "虹光之蓝境"
	elseif id == 10017 then
	  return "虹光之靛境"
	elseif id == 10018 then
	  return "虹光之紫境"
    elseif id == 2007 then
	  return "鬼蜮深渊"
    elseif id == 2008 then  ---九黎
	  return "九黎城"
	elseif id >= 100000  then
		return "高级庭院"

	else
	  return "未知地图"
	end
end
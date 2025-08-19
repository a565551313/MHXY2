--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-19 03:25:38
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--
function 取Bgm(map)
  if map == 1209 or map==6002 then
    return 1208
  elseif map==6001 then
    return 1131
  elseif map == 1137 then
    return 1135
  elseif map == 1511 then
    return 1231
  elseif map == 1123 or map == 1124 then
    return 1122
  elseif map == 1211 then
    return 1210
  elseif map == 1227 then
    return 1226
  elseif map == 1119 or map == 1120 or map == 1121 or map == 1532 then
    return 1118
  elseif map>=1600 and map<=1620 then
    return 1514
  elseif map>=6003 and map<=6009 then
  	return 1197
  elseif map>=6010 and map<=6019 then
  	return 1876
  elseif map==6020 then
  	return 1514
  elseif map == 6021 then
	return 1204
  elseif map == 6022 then
	return 1137
  elseif map == 6023 then
	return 1111
  elseif map == 6024 then
  	return 1002
  elseif map == 6025 then
  	return 1001
  elseif map == 6026 then
  	return 1211
  elseif map == 6027 then
  	return 1070
  elseif map == 6028 then
  	return 1140
  elseif map == 6029 then
  	return 1116
  elseif map == 6030 then
  	return 1202
  elseif map==5001 then
    return 1042
  elseif map== 7001 then
    return 1205
  elseif map== 7002 then
    return 1170
  elseif map== 7003 then
    return 1412
  elseif map== 7004 then
    return 1041
  elseif map== 8000 then
    return 1208
  elseif map== 8001 then
    return 1876
  elseif map== 8002 then
    return 1876
  elseif map== 10000 then
    return 1197
  elseif map== 10001 then
    return 1197
  elseif map== 10002 then
    return 1142
  elseif map== 10012 then
    return 1142
  elseif map== 10003 then
    return 1131
  elseif map== 10013 then
    return 1131
  elseif map== 10004 then
    return 1218
  elseif map== 10014 then
    return 1218
  elseif map== 10005 then
    return 1514
  elseif map== 10015 then
    return 1514
  elseif map== 10006 then
    return 1116
  elseif map== 10016 then
    return 1116
  elseif map== 10007 then
    return 1211
  elseif map== 10017 then
    return 1211
  elseif map== 10008 then
    return 1114
  elseif map== 10018 then
    return 1114
  elseif map== 10009 then
    return 1201
  end
  return map
end

function 取地图名称(id)
	if id==nil then
	    return "未知"
	end
	if id>=1600 and id <=1620 then
       return "迷宫"..(id-1600).."层"
    elseif id==5001 then
    	return "宝藏山"
    elseif id>=6010 and id<=6019 and id~=6011 then
    	return "帮派竞赛"
   elseif id==6011 then
    	return "帮派奖励"
   	elseif id==6020 then
   		return "中立区"
	end
	if id == 1501 then
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
		return "沉船"
	elseif id == 1509 then
		return "沉船内室"
	elseif id == 1193 then
		return "江南野外"
	elseif id == 1621  then
	    return "会员地图"
	elseif id == 1622  then
	    return "轮回归墟"
	elseif id == 1001 or id == 4001 then
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
	elseif id == 1104 then
		return "傲来药店"
	elseif id == 1105 then
		return "傲来杂货"
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
	elseif id == 1100 then
		return "傲来圣殿"
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
	elseif id == 1081 then
		return "长寿村钱庄"
	elseif id == 1084 then
		return "长寿村辛匠"
	elseif id == 1099 then
		return "傲来钱庄"
	elseif id == 1135 then
		return "方寸山"
	elseif id == 1137 then
		return "灵台宫"
	elseif id == 1223 then
		return "观星台"
	elseif id == 1173 then
		return "大唐境外"
	elseif id == 1153 then
		return "金山寺"
	elseif id == 1168 then
		return "江州府"
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
		return "花果山"
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
	elseif id == 1093 then
		return "傲来国客栈"
	elseif id == 1083 then
		return "长寿村服装店"
	elseif id == 1085 then
		return "长寿村武器店"
	elseif id == 1082 then
		return "长寿村神庙"
	elseif id == 1003 then
		return "桃源村"
	elseif id == 1013 then
		return "广源钱庄"
	elseif id == 1019 then--长安-书香斋
		return "书香斋"
	elseif id == 1025 then--长安-铁铺
		return "冯记铁铺"
	elseif id == 1249 then
		return "女魃墓"
	elseif id == 1216 then
		return "仙缘洞府"
	elseif id == 1250 then
		return "天机城"
	elseif id == 1605 then
		return "天鸣洞天"
	elseif id == 1125 then
		return "轮回司"
	elseif id == 1237 then
		return "四方城"
	elseif id == 1876 then
		return "南岭山"
	--============
	elseif id == 1212 then
		return "琅嬛福地"
	elseif id == 1213 then
		return "炼焰谷地"
	elseif id == 1214 then
		return "冰风秘境"
	elseif id == 1215 then
		return "钟乳石窟"
	elseif id == 1810 then
		return "一级帮派金库_门左"
	elseif id == 1811 then
		return "一级帮派金库_门右"
	elseif id == 1812 then
		return "二、三级帮派金库_门左"
	elseif id == 1813 then
		return "二、三级帮派金库_门右"
	elseif id == 1814 then
		return "帮派金库"
	elseif id == 1815 then
		return "帮派金库"
	elseif id == 1820 then
		return "一级帮派书院_门左"
	elseif id == 1821 then
		return "一级帮派书院_门右"
	elseif id == 1822 then
		return "二、三级帮派书院_门左"
	elseif id == 1823 then
		return "二、三级帮派书院_门右"
	elseif id == 1824 then
		return "帮派书院"
	elseif id == 1825 then
		return "帮派书院"
	elseif id == 1830 then
		return "一级帮派兽室_门左"
	elseif id == 1831 then
		return "一级帮派兽室_门右"
	elseif id == 1832 then
		return "二、三级帮派兽室_门左"
	elseif id == 1833 then
		return "二、三级帮派兽室_门右"
	elseif id == 1834 then
		return "帮派兽室"
	elseif id == 1835 then
		return "帮派兽室"
	elseif id == 1840 then
		return "一级帮派厢房_门左"
	elseif id == 1841 then
		return "一级帮派厢房_门右"
	elseif id == 1842 then
		return "二、三级帮派厢房_门左"
	elseif id == 1843 then
		return "二、三级帮派厢房_门右"
	elseif id == 1844 then
		return "帮派厢房"
	elseif id == 1845 then
		return "帮派厢房_"
	elseif id == 1850 then
		return "一级帮派药房_门左"
	elseif id == 1851 then
		return "一级帮派药房_门右"
	elseif id == 1852 then
		return "二、三级帮派药房_门左"
	elseif id == 1853 then
		return "二、三级帮派药房_门右"
	elseif id == 1854 then
		return "帮派药房"
	elseif id == 1855 then
		return "帮派药房"
	elseif id == 1860 then
		return "一级帮派青龙堂_门左"
	elseif id == 1861 then
		return "一级帮派青龙堂_门右"
	elseif id == 1862 then
		return "二、三级帮派青龙堂_门左"
	elseif id == 1863 then
		return "二、三级帮派青龙堂_门右"
	elseif id == 1864 then
		return "帮派青龙堂"
	elseif id == 1865 then
		return "帮派青龙堂"
	elseif id == 1870 then
		return "一级帮派聚义堂_门左"
	elseif id == 1871 then
		return "一级帮派聚义堂_门右"
	elseif id == 1872 then
		return "二、三级帮派聚义堂_门左"
	elseif id == 1873 then
		return "二、三级帮派聚义堂_门右"
	elseif id == 1874 then
		return "帮派聚义堂"
	elseif id == 1875 then
		return "帮派聚义堂"
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
	elseif id == 1125 then
		return "轮回司"
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


	-- elseif id == 1306 then
	--   return "园林水榭"
	-- elseif id == 1446 then
	--   return "农家小院"
	-- elseif id == 1380 then
	--   return "欢乐童年"
	-- elseif id == 1382 then
	--   return "欢乐冬日"
 --   elseif id == 1892 then
	--   return "高级牧场"


	elseif id == 6036 then
		return "花果山前"
	elseif id == 6037 then
		return "地府"
	elseif id == 6038 then
		return "天庭"
	elseif id == 6039 then
		return "七宝玲珑塔"
	elseif id == 7001 then
		return "四方城"
	elseif id == 7002 then
		return "崔府正厅"
	elseif id == 7003 then
		return "顶级豪宅"
	elseif id == 7004 then
		return "沧浪墟"
   elseif id == 8000 then
		return "跨服争霸准备"
   elseif id == 8001 then
		return "跨服争霸单人"
   elseif id == 8002 then
		return "跨服争霸组队"
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
	elseif id == 5003 then
	  return "妖魔巢穴"

	 elseif id == 1340 then
	  return "初级庭院"
	elseif id == 1341 then
	  return "中级庭院"
	elseif id == 1342 then--高级庭院
	  return "高级庭院"

	elseif id == 1332 then
	  return "普通房屋"


	 elseif id == 1885 then
		return "庭院"
	elseif id == 1401 then
		return "普通民宅"
	elseif id == 1402 then
		return "高级华宅"
	elseif id == 1403 then
		return "顶级豪宅"
	elseif id == 1404 then
		return "普通民宅"--+1J地板
	elseif id == 1405 then
		return "高级华宅"--+1J地板
	elseif id == 1406 then
		return "顶级豪宅"--+1J地板
	elseif id == 1407 then
		return "普通民宅"--+2J地板
	elseif id == 1408 then
		return "高级华宅"--+2J地板
	elseif id == 1409 then
		return "顶级豪宅"--+2J地板
	elseif id == 1410 then
		return "普通民宅"--+3J地板
	elseif id == 1411 then
		return "高级华宅"--+3J地板
	elseif id == 1412 then
		return "顶级豪宅"--+3J地板
	elseif id == 1413 then
		return "海蓝系民宅"
	elseif id == 1414 then
		return "海蓝系华宅"
	elseif id == 1415 then
		return "海蓝系豪宅"
	elseif id == 1420 then
		return "普通庭院"
	elseif id == 1421 then
		return "中级庭院"
	elseif id == 1422 then
		return "高级庭院"
	elseif id == 2007 then
		return "鬼蜮深渊"
	elseif id == 2008 then
		return "九黎城"
	--============================================
	elseif id >= 100000 and tp.房屋数据  then
		if tp.房屋数据.庭院ID == id  then
            if tp.房屋数据.庭院地图==1420 then
				return "初级庭院"
		    elseif tp.房屋数据.庭院地图 == 1421 then
		    	   return "中级庭院"
		    elseif tp.房屋数据.庭院地图 == 1422 then
		    	   return "高级庭院"
            elseif tp.房屋数据.庭院地图 == 1424 then
		    	   return "顶级庭院"
			elseif tp.房屋数据.庭院地图==1306 then
				return "园林水榭"
		    elseif tp.房屋数据.庭院地图 == 1885 then
		    	   return "农家小院"
		    elseif tp.房屋数据.庭院地图 == 1380 then
		    	   return "欢乐童年"
		    elseif tp.房屋数据.庭院地图 == 1382 then
		    	   return "白雪皑皑"
		   end
		elseif tp.房屋数据.房屋ID == id then
			if tp.房屋数据.房屋地图  == 1310 or tp.房屋数据.房屋地图  == 1320 or tp.房屋数据.房屋地图  == 1933 or tp.房屋数据.房屋地图  == 1407 or tp.房屋数据.房屋地图  == 1408 or tp.房屋数据.房屋地图  == 1409  then --高级
				return "大理石"
			elseif tp.房屋数据.房屋地图  == 1311 or tp.房屋数据.房屋地图  == 1321 or tp.房屋数据.房屋地图  == 1935  or tp.房屋数据.房屋地图  == 1404 or tp.房屋数据.房屋地图  == 1405 or tp.房屋数据.房屋地图  == 1406  then
			    return "青砖"
			elseif tp.房屋数据.房屋地图  == 1312 or tp.房屋数据.房屋地图  == 1322 or tp.房屋数据.房屋地图  == 1937 or tp.房屋数据.房屋地图  == 1401 or tp.房屋数据.房屋地图  == 1402 or tp.房屋数据.房屋地图  == 1403  then
			    return "复古"
			elseif tp.房屋数据.房屋地图  == 1313 or tp.房屋数据.房屋地图  == 1323 or tp.房屋数据.房屋地图  == 1939 or tp.房屋数据.房屋地图  == 1410 or tp.房屋数据.房屋地图  == 1411 or tp.房屋数据.房屋地图  == 1412 then
			    return "红地板"
			elseif tp.房屋数据.房屋地图  == 1314 or tp.房屋数据.房屋地图  == 1324 or tp.房屋数据.房屋地图  == 1941 or tp.房屋数据.房屋地图  == 1413 or tp.房屋数据.房屋地图  == 1414 or tp.房屋数据.房屋地图  == 1415 then
			    return "海洋系"
			elseif tp.房屋数据.房屋地图  == 1315 or tp.房屋数据.房屋地图  == 1325 or tp.房屋数据.房屋地图  == 1943  or tp.房屋数据.房屋地图  == 1416 or tp.房屋数据.房屋地图  == 1417 or tp.房屋数据.房屋地图  == 1418 then
			    return "粉红兔"
			elseif tp.房屋数据.房屋地图  == 1316 or tp.房屋数据.房屋地图  == 1326 or tp.房屋数据.房屋地图  == 1945  or tp.房屋数据.房屋地图  == 1330 or tp.房屋数据.房屋地图  == 1331 or tp.房屋数据.房屋地图  == 1332  then
			    return "中国风"
            elseif tp.房屋数据.房屋地图  == 1317 or tp.房屋数据.房屋地图  == 1327 or tp.房屋数据.房屋地图  == 1947  or tp.房屋数据.房屋地图  == 1333 or tp.房屋数据.房屋地图  == 1334 or tp.房屋数据.房屋地图  == 1335  then
			    return "卡通猫"
			elseif tp.房屋数据.房屋地图  == 1318 or tp.房屋数据.房屋地图  == 1328 or tp.房屋数据.房屋地图  == 1949  or tp.房屋数据.房屋地图  == 1413 or tp.房屋数据.房屋地图  == 1337 or tp.房屋数据.房屋地图  == 1338  then
			    return "冰雪屋"
            elseif tp.房屋数据.房屋地图  == 1319 or tp.房屋数据.房屋地图  == 1329 or tp.房屋数据.房屋地图  == 1951  or tp.房屋数据.房屋地图  == 1953 or tp.房屋数据.房屋地图  == 1954 or tp.房屋数据.房屋地图  == 1955  then
			    return "蓝色永恒"
			elseif tp.房屋数据.房屋地图  == 1958 or tp.房屋数据.房屋地图  == 1959 or tp.房屋数据.房屋地图  == 1960  or tp.房屋数据.房屋地图  == 1961 or tp.房屋数据.房屋地图  == 1962 or tp.房屋数据.房屋地图  == 1963  then
			    return "星空蓝"
			elseif tp.房屋数据.房屋地图  == 1970 or tp.房屋数据.房屋地图  == 1969 or tp.房屋数据.房屋地图  == 1968  or tp.房屋数据.房屋地图  == 1967 or tp.房屋数据.房屋地图  == 1966 or tp.房屋数据.房屋地图  == 1965  then
			    return "咖啡屋"

			end

		elseif tp.房屋数据.阁楼ID == id then
			   if tp.房屋数据.阁楼地图  == 1934  then --高级
					return "复古大理石"
				elseif tp.房屋数据.阁楼地图  == 1936 then
				    return "复古青砖"
				elseif tp.房屋数据.阁楼地图  == 1938 then
				    return "复古地板"
				elseif tp.房屋数据.阁楼地图  == 1940 then
				    return "复古红地板"
				elseif tp.房屋数据.阁楼地图  == 1942 then
				    return "海洋系"
				elseif tp.房屋数据.阁楼地图  == 1944 then
				    return "粉红兔"
				elseif tp.房屋数据.阁楼地图  == 1946 then
				    return "中国风"
	            elseif tp.房屋数据.阁楼地图  == 1948 then
				    return "卡通猫"
				elseif tp.房屋数据.阁楼地图  == 1950 then
				    return "冰雪屋"
	            elseif tp.房屋数据.阁楼地图  == 1952 then
				    return "蓝色永恒"
                elseif tp.房屋数据.阁楼地图  == 1964 then
				    return "星空蓝"
				elseif tp.房屋数据.阁楼地图  == 1971 then
				    return "咖啡屋"
				end
		elseif tp.房屋数据.牧场ID == id then
			   return "高级牧场"
		end
	else
		return "未知地图"
	end
end

function 小地图资源加载(map)
	if map==nil then return  end
	if map == 1001 or map == 6025 then
		return '界面修复.wdf',0xCA000001
		--return '物品图标.wdf',0xCEBC4616
	elseif map == 1002 or map == 6024 then
		return '物品图标.wdf',3566134173
	elseif map == 1004 then
		return '物品图标.wdf',3038955283
	elseif map == 1005 then
		return '物品图标.wdf',3043296434
	elseif map == 1006 then
		return '物品图标.wdf',1128733891
	elseif map == 1007 then
		return '物品图标.wdf',3690484265
	elseif map == 1008 then
		return '物品图标.wdf',117994174
	elseif map == 1009 then
		return '物品图标.wdf',2866991463
	elseif map == 1040 then
		return '物品图标.wdf',4269786701
	elseif map == 1041 or map == 7004 then
		return '物品图标.wdf',2914736228
	elseif map == 1042 or map==5001 then
		return '物品图标.wdf',502306430
	elseif map == 1070 or map == 6027 then
		return '物品图标.wdf',2766803400
	elseif map == 1090 or map == 1622 then
		return '物品图标.wdf',975993013
	elseif map == 1091 then
		return '物品图标.wdf',647087968
	elseif map == 1092 then
		return '物品图标.wdf',2930683699
	elseif map == 1110 then
		return '物品图标.wdf',1209177817
	elseif map == 1111 or map == 6023 or map == 6035  or map == 6038 then
		return '物品图标.wdf',2159282308
	elseif map == 1114 or map == 10008 or map == 10018  then
		return '物品图标.wdf',0x6B7904C6--1803093190
	elseif map == 1116 or map == 6029 or map == 10006  or map == 10016 then
		return '物品图标.wdf',545106797
	elseif map == 1118 then
		return '物品图标.wdf',3579377767
	elseif map == 1119 then
		return '物品图标.wdf',2802830440
	elseif map == 1120 then
		return '物品图标.wdf',4174697543
	elseif map == 1121 then
		return '物品图标.wdf',1236030791
	elseif map == 1122 then
		return '物品图标.wdf',2600205256
	elseif map == 1127 then
		return '物品图标.wdf',1795111495
	elseif map == 1128 then
		return '物品图标.wdf',353472097
	elseif map == 1129 then
		return '物品图标.wdf',3380408013
	elseif map == 1130 then
		return '物品图标.wdf',3387504035
	elseif map == 1131  or map==6001  or map==10003  or map==10013 then
		return '物品图标.wdf',1632323059
	elseif map == 1135 then
		return '物品图标.wdf',2990212588
	elseif map == 1138 then
		return '物品图标.wdf',1157479725
	elseif map == 1139 then
		return '物品图标.wdf',2744072561
	elseif map == 1140 or map == 6028 then
		return '物品图标.wdf',3787222136
	elseif map == 1142  or map== 10002 or map== 10012  then
		return '物品图标.wdf',3394273965
	elseif map == 1146 then
		return '物品图标.wdf',206717537
	elseif map == 1150 then
		return '物品图标.wdf',1267498697
	elseif map == 1173 then
		return '物品图标.wdf',1389007272
	elseif map == 1174 then
		return '物品图标.wdf',3293723566
	elseif map == 1177 then
		return '物品图标.wdf',1051142943
	elseif map == 1178 then
		return '物品图标.wdf',4288252057
	elseif map == 1179 then
		return '物品图标.wdf',695155995
	elseif map == 1180 then
		return '物品图标.wdf',584117065
	elseif map == 1181 then
		return '物品图标.wdf',1732546758
	elseif map == 1182 then
		return '物品图标.wdf',3528941268
	elseif map == 1183 then
		return '物品图标.wdf',3940428598
	elseif map == 1186 then
		return '物品图标.wdf',1408014958
	elseif map == 1187 then
		return '物品图标.wdf',2284090720
	elseif map == 1188 then
		return '物品图标.wdf',1381541766
	elseif map == 1189 then
		return '物品图标.wdf',254963317
	elseif map == 1190 then
		return '物品图标.wdf',801213330
	elseif map == 1191 then
		return '物品图标.wdf',2500598663
	elseif map == 1192 then
		return '物品图标.wdf',2730614272
	elseif map == 1193 or map == 1621  then
		return '物品图标.wdf',606476023
	elseif map == 1198 then
		return '物品图标.wdf',544232211
	elseif map == 1201  or map == 10009 then
		return '物品图标.wdf',2027355398
	elseif map == 1202 or map == 6030 then
		return '物品图标.wdf',1070238810
	elseif map == 1203 then
		return '物品图标.wdf',4040069189
	elseif map == 1204 or map == 6021 then
		return '物品图标.wdf',3355516657
	elseif map == 1205 then
		return '物品图标.wdf',3409668280
	elseif map == 1207 then
		return '物品图标.wdf',3262911017
	elseif map == 1208 then
		return '物品图标.wdf',1428468522
	elseif map == 1210 then
		return '物品图标.wdf',664467571
	elseif map == 1211 or map == 6026 or map == 10007 or map == 10017 then
		return '物品图标.wdf',923673984
	elseif map == 1218 or map == 10004 or map == 10014 then
		return '物品图标.wdf',3524163775
	elseif map == 1221 or map == 5003 then
		return '物品图标.wdf',638705710
	elseif map == 1226 then
		return '物品图标.wdf',1186890765
	elseif map == 1228 then
		return '物品图标.wdf',2308357598
	elseif map == 1229 then
		return '物品图标.wdf',2642996577
	elseif map == 1231 then
		return '物品图标.wdf',1530927343
	elseif map == 1232 then
		return '物品图标.wdf',867489325
	elseif map == 1233 then
		return '物品图标.wdf',3059022311
	elseif map == 1235 then
		return '物品图标.wdf',3029783778
	elseif map == 1242 then
		return '物品图标.wdf',1412756833
	elseif map == 1501  then
		return '物品图标.wdf',2697825210
	elseif map == 1506  then
		return '物品图标.wdf',855890337
	elseif map == 1507 then
		return '物品图标.wdf',3363079713
	elseif map == 1508 then
		return '物品图标.wdf',2421848661
	elseif map == 1511 then
		return '物品图标.wdf',3118617574
	elseif map == 1512 then
		return '物品图标.wdf',876001261
	elseif map == 1513 then
		return '物品图标.wdf',3729625326
	elseif map == 1514 or (map>=1600 and map<=1620) or map==6020 or map==6033 or map==6036 or map==10005 or map==10015 then
		return '物品图标.wdf',818673142
	elseif map == 1532 then
		return '物品图标.wdf',1797992103
	elseif map == 1920 then
		return '物品图标.wdf',964351559
	elseif map == 1126 then
		return '物品图标.wdf',0x63033A32
	elseif map == 1003 then
		return '物品图标.wdf',0x1F812A17
	elseif map == 1216 then--仙缘洞府
		return '物品图标.wdf',0x184AA512
	elseif map == 1605 then--天鸣洞天
		return '物品图标.wdf',0x8FA4C62A
	elseif map == 1237 or map == 7001 then--天鸣洞天
		return '物品图标.wdf',0xDFE8D3CD
	elseif map == 1876 or (map>=6010 and map<=6019) or map == 8001 or map == 8002 then--天鸣洞天
		return '物品图标.wdf',0x099565A8
		-----------------------------------------
    elseif map == 1446  then--天鸣洞天
		return '窗口文字.wdf',0x46f99747
    elseif map == 1380  then--天鸣洞天
		return '窗口文字.wdf',0x46f99747
    elseif map == 1382  then--天鸣洞天
		return '窗口文字.wdf',0x1b4a19ea
    elseif map == 1885  then--天鸣洞天
		return '窗口文字.wdf',0x64ebe33d
    elseif map == 1886  then--天鸣洞天
		return '窗口文字.wdf',0x9888189a
    elseif map == 1887  then--天鸣洞天
		return '窗口文字.wdf',0x477d2153
    elseif map == 1888  then--天鸣洞天
		return '窗口文字.wdf',0xdf6d2b20
    elseif map == 1892  then--天鸣洞天
		return '窗口文字.wdf',0x267812dd
    elseif map == 2007 then
		-- return '路飞.wdf',0x00000003
	elseif map == 2008 then
		return '窗口文字.wdf',0x00000020



	end
end

function 取地图坐标生成(地图ID)
	local tx,ty
	local x,y = 0,0
	local 地图={}
	local map打开 = require("script/资源类/MAP")(wdf配置.."/scene/"..地图ID..".map")
	地图.宽度=map打开.Width
	地图.高度=map打开.Height
	地图.行数=map打开.MapRowNum
	地图.列数 =map打开.MapColNum
	local 寻路 = require("Astart类")(地图.列数*16,地图.行数*12,map打开:取障碍())
	local 寻路存储 = {}
	local 高度 = math.floor(地图.高度/20)-10
	local 宽度 = math.floor(地图.宽度/20)-10
	tx = 引擎.取随机整数(10,宽度)
	ty = 引擎.取随机整数(10,高度)
	while(寻路:检查点(tx,ty)~=true) do
		tx = 引擎.取随机整数(1,宽度)
		ty = 引擎.取随机整数(1,高度)
	end
	return {tx,ty}
end
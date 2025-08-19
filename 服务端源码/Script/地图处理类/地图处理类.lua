-- @Author              : GGELUA
-- @Last Modified by    : GGELUA2
-- @Date                : 2024-06-14 13:01:28
-- @Last Modified time  : 2024-06-24 17:26:41

--======================================================================--
--======================================================================--
local 地图处理类 = class()

function 地图处理类:初始化()
  -- self.地图编号={1231,1525,1211,1125,1017,1029,1103,1512,1507,1508,1509,1030,1024,1009,1205,1202,1126,1127,1128,1129,1130,1207,1221,1218,1041,1042,1229,1210,1235,1227,1083,1085,1033,1228,1041,1040,1226,1203,1204,1004,1005,1006,1007,1008,1090,1113,1114,1173,1186,1187,1188,1189,1190,1191,1192,1091,1177,1178,1179,1180,1181,1182,1183,1201,1514,1174,1093,1104,1105,1094,1095,1101,1092,1118,1119,1120,1121,1122,1532,1527,1534,1028,1173,1070,1208,1209,1110,1501,1001,1503,1505,1537,1523,1504,1502,1523,1524,1526,1534,1506,1001,1020,1022,1044,1026,1016,1198,1054,1002,1528,1043,1193,1135,1137,1142,1143,1138,1154,1513,1144,1134,1133,1132,1131,1145,1512,1124,1122,1123,1139,1156,1116,1117,1141,1140,1112,1111,1113,1150,1146,1147}
  local 地图编号={1001,1002,1003,1004,1005,1006,1007,1008,1009,1012,1013,1014,1015,
  1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1028,1029,1030,1031,1032,
  1033,1034,1035,1036,1037,1038,1040,1041,1042,1043,1044,1046,1049,1050,1051,1052,
  1054,1056,1057,1070,1072,1075,1077,1078,1079,1080,1081,1082,1084,1083,1085,1087,
  1090,1091,1092,1093,1094,1095,1098,1099,1100,1101,1103,1104,1105,1106,1107,1110,
  1111,1112,1113,1114,1115,1116,1117,1118,1119,1120,1121,1122,1123,1124,1125,1126,
  1127,1128,1129,1130,1131,1132,1133,1134,1135,1137,1138,1139,1140,1141,1142,1143,
  1144,1145,1146,1147,1149,1150,1152,1153,1154,1155,1156,1165,1167,1168,1170,1171,
  1173,1174,1175,1177,1178,1179,1180,1181,1182,1183,1186,1187,1188,1189,1190,1191,
  1192,1193,1197,1198,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,
  1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,
  1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1241,1242,1243,1245,1246,
  1248,1249,1250,1251,1252,1253,1256,1257,1258,1259,1272,1273,1306,1310,1311,1312,
  1313,1314,1315,1316,1317,1318,1319,1320,1321,1322,1323,1324,1325,1326,1327,1328,
  1329,1330,1331,1332,1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,1343,1380,
  1382,1400,1401,1402,1403,1404,1405,1406,1407,1408,1409,1410,1411,1412,1413,1414,
  1415,1416,1417,1418,1420,1421,1422,1424,1425,1426,1427,1428,1429,1430,1446,1447,
  1501,1502,1503,1504,1505,1506,1507,1508,1509,1511,1512,1513,1514,1523,1524,1525,
  1526,1527,1528,1529,1531,1532,1533,1534,1535,1536,1537,1605,1606,1607,1608,1810,
  1811,1812,1813,1814,1815,1820,1821,1822,1823,1824,1825,1830,1831,1832,1833,1834,
  1835,1840,1841,1842,1843,1844,1845,1850,1851,1852,1853,1854,1855,1860,1861,1862,
  1863,1864,1865,1870,1871,1872,1873,1874,1875,1876,1885,1886,1887,1888,1890,1891,
  1892,1910,1911,1912,1913,1914,1915,1916,1920,1930,1931,1932,1933,1934,1935,1936,
  1937,1938,1939,1940,1941,1942,1943,1944,1945,1946,1947,1948,1949,1950,1951,1952,
  1953,1954,1955,1958,1959,1960,1961,1962,1963,1964,1965,1966,1967,1968,1969,1970,1971,
  2000,2007,2008,4001,5000}
  self.队伍距离=50
  self.NPC列表 ={}
  self.地图玩家={} ----玩家数据
  self.地图单位={} ----活动单位
  self.传送数据={} ---传送圈
  self.地图坐标={} ---坐标类
  self.单位编号={} ---活动单位起始编号
  self.遇怪地图={} --暗雷场景
  for i,v in ipairs(地图编号) do
      self:加载地图(v)
  end
  --加载迷宫地图
  for n=1600,1620 do
    self:加载地图(n,1514)
  end
  self:加载地图(1621,1193)
  self:加载地图(1622,1090)
  self:加载地图(6001,1131)
  self:加载地图(6002,1209)
  --加载比武地图
  for n=6003,6008 do
      self:加载地图(n,1197)
  end
  --首席争霸地图
  self:加载地图(6009,1197)

  --帮派竞赛地图
  for n=6010,6019 do
    self:加载地图(n,1876)
  end
  --帮派竞赛中转站
  self:加载地图(6020,1514)
  --车迟副本
  self:加载地图(6021,1204)
  self:加载地图(6022,1137)
  self:加载地图(6023,1111)

  --水陆大会
  self:加载地图(6024,1002)
  self:加载地图(6025,1001)
  self:加载地图(6026,1211)
  --通天河副本
  self:加载地图(6027,1070)
  self:加载地图(6028,1140)
  self:加载地图(6029,1116)
  self:加载地图(6030,1202)
  --大闹天宫副本
  self:加载地图(6031,1511)
  self:加载地图(6032,1231)
  self:加载地图(6033,1514)
  self:加载地图(6034,1007)
  self:加载地图(6035,1111)
  --齐天大圣副本
  self:加载地图(6036,1514)
  self:加载地图(6037,1122)
  self:加载地图(6038,1111)
  self:加载地图(6039,1009)
  --宝藏山
  self:加载地图(5001,1042)
  --四方城
  self:加载地图(7001,1237)
  --崔府正厅
  self:加载地图(7002,1170)

  self:加载地图(7003,1412)
  --沧浪墟
  self:加载地图(7004,1041)
  collectgarbage("collect")
 --加载副本地图
end



function 地图处理类:加载地图(地图,坐标)
      self.NPC列表[地图] ={}
      self.地图玩家[地图]={}
      self.地图单位[地图]={}
      self.传送数据[地图]={}
      self.单位编号[地图]=1000
      self:加载传送(地图,self:取传送数据(地图))
      self:加载NPC(地图,self:取NPC数据(地图))
      if 坐标 then
          self.地图坐标[地图]=地图坐标类(坐标,self.传送数据[地图])
      else
          self.地图坐标[地图]=地图坐标类(地图,self.传送数据[地图])
      end
      if 取场景等级(地图) then
          self.遇怪地图[地图]=true
      end


end

function 地图处理类:加载NPC(地图,单位)
        if type(单位)=="table" then
            for i,v in pairs(单位) do
                if type(i)=="number" and type(v)=="table" then
                    self.NPC列表[地图][i]=v
                    self.NPC列表[地图][i].编号 = i
                end
            end
            if 单位.名称 and 单位.模型 and 单位.x and 单位.y then
               local 编号 = #self.NPC列表[地图] + 1
               self.NPC列表[地图][编号]={编号=编号}
               for i,v in pairs(单位) do
                   if type(i)~="number" then
                    self.NPC列表[地图][编号][i]=v
                   end
               end
            end
        end
end


function 地图处理类:加载传送(地图,传送)
        if type(传送)=="table" then
            for i,v in pairs(传送) do
                if type(i)=="number" and type(v)=="table" then
                    self.传送数据[地图][i]=v
                    self.传送数据[地图][i].编号 = i
                end
            end
            if 传送.坐标 and 传送.目标 and 传送.x and 传送.y then
               local 编号 = #self.传送数据[地图] + 1
               self.传送数据[地图][编号]={x=传送.x,y=传送.y,目标=传送.目标,坐标=传送.坐标,编号=编号}
            end
        end
end




function 地图处理类:npc传送(id,m,x,y)
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  self:跳转地图(id,m,x,y)-- 玩家数据[id].角色.数据.门派="无"
end

function 地图处理类:门派传送(id,m)
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
    常规提示(id,"只有队长才可使用此项功能！")
    return
  end
  local cs --检查门派传送条件
  if m == "方寸山" then
    cs = {1135,72,63}
  elseif m == "女儿村" then
    cs = {1142,37,37}
  elseif m == "神木林" then
    cs = {1138,46,121}
  elseif m == "大唐官府" then
    cs = {1198,131,82}
  elseif m == "化生寺" then
    cs = {1002,7,88}
  elseif m == "阴曹地府" then
    cs = {1122,101,102}
  elseif m == "长安城" then
    cs = {1001,202,110}
  elseif m == "盘丝洞" then
    cs = {1513,174,31}
  elseif m == "无底洞" then
    cs = {1139,61,125}
  elseif m == "狮驼岭" then
    cs = {1131,109,77}
  elseif m == "魔王寨" then
    cs = {1512,76,29}
  elseif m == "普陀山" then
    cs = {1140,20,18}
  elseif m == "天宫" then
    cs = {1111,175,122}
  elseif m == "凌波城" then
    cs = {1150,33,67}
  elseif m == "五庄观" then
    cs = {1146,26,55}
  elseif m == "龙宫" then
    cs = {1116,71,77}
  elseif m == "天机城" then
    cs = {1250,63,92}
  elseif m == "女魃墓" then
    cs = {1249,51,44}
  elseif m == "花果山" then
    cs = {1251,38,76}
  elseif m == "九黎城" then   ---九黎
    cs = {2008,67,82}
  end
  if #cs==0 then
    return
  else
    self:跳转地图(id,cs[1],cs[2],cs[3])
  end
end

function 地图处理类:明雷遇怪处理(连接id,id,标识)
  if 取队长权限(id)==false then
    return
  elseif not 任务数据[标识] then
    return
  elseif 玩家数据[id].战斗~=0 or 任务数据[标识].战斗 then
    return
  else
    if 玩家数据[id].遇怪时间 == nil then
        玩家数据[id].遇怪时间=os.time()+取随机数(10,20)
    end
    if os.time()>=玩家数据[id].遇怪时间 then
          任务数据[标识].战斗=true
          if 任务数据[标识].类型==103 then
             战斗准备类:创建战斗(id,100007,标识)
          elseif 任务数据[标识].类型==202 then
             战斗准备类:创建战斗(id,100019,标识)
          elseif 任务数据[标识].类型==340 then
              战斗准备类:创建战斗(id,100094,标识)

          -- elseif 任务数据[标识].类型==359 then
          --   战斗准备类:创建战斗(id,100136,标识)
          --   任务数据[标识].战斗=true
          -- elseif 任务数据[标识].类型==360 then
          --   战斗准备类:创建战斗(id,100137,标识)
          --   任务数据[标识].战斗=true
          -- elseif 任务数据[标识].类型==361 then
          --   战斗准备类:创建战斗(id,100138,标识)
          --   任务数据[标识].战斗=true
          elseif 任务数据[标识].类型==6667 then --女儿村
            if 任务数据[标识].名称=="普通山猴" then
                战斗准备类:创建战斗(id,130002,标识)
            else
                战斗准备类:创建战斗(id,130003,标识)
            end

          elseif 任务数据[标识].类型==6668 then
            if 任务数据[标识].名称=="普通护卫者" then
              战斗准备类:创建战斗(id,130004,标识)
            else
              战斗准备类:创建战斗(id,130005,标识)
            end

          elseif 任务数据[标识].类型==6669 then
            if 任务数据[标识].名称=="普通守卫者" then
              战斗准备类:创建战斗(id,130006,标识)
            else
              战斗准备类:创建战斗(id,130007,标识)
            end

          elseif 任务数据[标识].类型==6670 then
            if 任务数据[标识].名称=="普通机器人" or 任务数据[标识].名称=="普通战车" then
              战斗准备类:创建战斗(id,130008,标识)
            else
              战斗准备类:创建战斗(id,130009,标识)
            end

          elseif 任务数据[标识].类型==6671 then
            if 任务数据[标识].名称=="普通小野猪" then
              战斗准备类:创建战斗(id,130010,标识)
            else
              战斗准备类:创建战斗(id,130011,标识)
            end

          elseif 任务数据[标识].类型==6672 then
            if 任务数据[标识].名称=="普通守护伞" then
               战斗准备类:创建战斗(id,130012,标识)
            else
               战斗准备类:创建战斗(id,130013,标识)
            end

          elseif 任务数据[标识].类型==6673 then
            if 任务数据[标识].名称=="普通月宫兔" then
              战斗准备类:创建战斗(id,130014,标识)
            else
              战斗准备类:创建战斗(id,130015,标识)
            end


          end

      end

  end
end

function 地图处理类:数据处理(id,序号,数字id,内容)
  if 数字id==nil or 玩家数据[数字id]==nil then return end
  if 序号==1001 then
        self:移动请求(id,内容,数字id)
  elseif 序号==1002 then
        self:移动坐标刷新(id,数字id,内容)
  elseif 序号==1002.1 then
      if self:取移动限制(数字id) then return end
      if 玩家数据[数字id].自动遇怪 then
          玩家数据[数字id].自动遇怪 = os.time()
      end
      玩家数据[数字id].角色.数据.地图数据.x,玩家数据[数字id].角色.数据.地图数据.y=内容.x,内容.y
      local 地图编号=玩家数据[数字id].角色.数据.地图数据.编号
      for i, v in pairs(self.地图玩家[地图编号]) do
          if 玩家数据[i]~=nil and i~=数字id then
               发送数据(玩家数据[i].连接id,1012,{id=数字id,x=内容.x,y=内容.y})
                if self:取同一地图(地图编号,数字id,i,1) and 玩家数据[数字id].移动数据 and  玩家数据[数字id].移动数据.移动目标 then
                   发送数据(玩家数据[i].连接id,1008,{数字id=数字id,路径={x=玩家数据[数字id].移动数据.移动目标.x,y=玩家数据[数字id].移动数据.移动目标.y,距离=0,数字id=数字id}})
                end
          end
      end
  elseif 序号==1003 then --
          if not 内容.编号 then return end
          local 地图 = 玩家数据[数字id].角色.数据.地图数据.编号
          local 传送数据 = self.传送数据[地图][内容.编号]
          if not 传送数据 then return end
          local 角色xy={x=x,y=y}
          local 对方xy={x=0,y=0}
          对方xy.x,对方xy.y=传送数据.x,传送数据.y
          角色xy.x,角色xy.y=玩家数据[数字id].角色.数据.地图数据.x/20,玩家数据[数字id].角色.数据.地图数据.y/20
          if 取两点距离(对方xy,角色xy)>=20 then
              常规提示(数字id,"#Y/传送阵和你的距离太远了吧")
              return
          else
              self:跳转地图(数字id,传送数据.目标,传送数据.坐标[1],传送数据.坐标[2])
          end
  elseif 序号==1004 then
         local 地图 = 内容.地图
         local 编号 = 内容.编号
         local 标识 = 内容.标识
         if not self.地图单位[地图] or
            not self.地图单位[地图][编号] or
            not 标识 or self.地图单位[地图][编号].id~=标识
         then
              return
         end
         if 玩家数据[数字id].角色.数据.地图数据.编号~=地图 then return end
         local 角色xy={x=x,y=y}
         local 对方xy={x=0,y=0}
         对方xy.x,对方xy.y=self.地图单位[地图][编号].x,self.地图单位[地图][编号].y
         角色xy.x,角色xy.y=玩家数据[数字id].角色.数据.地图数据.x/20,玩家数据[数字id].角色.数据.地图数据.y/20
         if 取两点距离(对方xy,角色xy)>=500 then
            常规提示(数字id,"#Y/怪物和你的距离太远了吧")
            return
        else
            self:明雷遇怪处理(id,数字id,标识)
        end
    --------------------------------------------------------装修家具
  elseif 序号==1005 then
          local 编号=tonumber(内容.编号)
          local 方向 = tonumber(内容.方向)
          local 地图 = 玩家数据[数字id].角色.数据.地图数据.编号
          local 返回数据 = {}
          local 默认x = 内容.x or 玩家数据[数字id].角色.数据.地图数据.x/20
          local 默认y = 内容.y or  玩家数据[数字id].角色.数据.地图数据.y/20
          if 地图 == 玩家数据[数字id].房屋.庭院ID  then
               玩家数据[数字id].房屋.庭院装饰[编号].x = 默认x
               玩家数据[数字id].房屋.庭院装饰[编号].y = 默认y
               玩家数据[数字id].房屋.庭院装饰[编号].方向 = 方向
               返回数据 = {玩家数据[数字id].房屋.庭院装饰,"庭院"}
          elseif 地图 == 玩家数据[数字id].房屋.房屋ID then
                  玩家数据[数字id].房屋.室内装饰[编号].x = 默认x
                  玩家数据[数字id].房屋.室内装饰[编号].y = 默认y
                  玩家数据[数字id].房屋.室内装饰[编号].方向 = 方向
                  返回数据 = {玩家数据[数字id].房屋.室内装饰,"室内"}
          elseif 地图 == 玩家数据[数字id].房屋.阁楼ID then
                  玩家数据[数字id].房屋.阁楼装饰[编号].x = 默认x
                  玩家数据[数字id].房屋.阁楼装饰[编号].y = 默认y
                  玩家数据[数字id].房屋.阁楼装饰[编号].方向 = 方向
                  返回数据 = {玩家数据[数字id].房屋.阁楼装饰,"阁楼"}
          elseif 地图 == 玩家数据[数字id].房屋.牧场ID then
                  玩家数据[数字id].房屋.牧场装饰[编号].x = 默认x
                  玩家数据[数字id].房屋.牧场装饰[编号].y = 默认y
                  玩家数据[数字id].房屋.牧场装饰[编号].方向 = 方向
                  返回数据 = {玩家数据[数字id].房屋.牧场装饰,"牧场"}
          end
          if 返回数据[1] and 返回数据[2] then
                for n, v in pairs(self.地图玩家[地图]) do--向地图内玩家发送新玩家数据
                  if n~=数字id and 玩家数据[n] and self:取同一地图(地图,id,n,1) then
                     发送数据(玩家数据[n].连接id,1029,返回数据)
                  end
               end
              发送数据(玩家数据[数字id].连接id,1029,返回数据)
          end
  elseif 序号==1006 then
         local 编号=tonumber(内容.编号)
         local 地图 = 玩家数据[数字id].角色.数据.地图数据.编号
         local 返回数据 = {}
         local 给予物品 = ""
          if 地图 == 玩家数据[数字id].房屋.庭院ID  then
              给予物品 = 玩家数据[数字id].房屋.庭院装饰[编号].名称
              table.remove(玩家数据[数字id].房屋.庭院装饰,编号)
              for k,v in pairs(玩家数据[数字id].房屋.庭院装饰) do
                  v.编号 = k
              end
              返回数据 = {玩家数据[数字id].房屋.庭院装饰,"庭院"}
          elseif 地图 == 玩家数据[数字id].房屋.房屋ID then
                  给予物品 = 玩家数据[数字id].房屋.室内装饰[编号].名称
                  table.remove(玩家数据[数字id].房屋.室内装饰,编号)
                  for k,v in pairs(玩家数据[数字id].房屋.室内装饰) do
                        v.编号 = k
                  end
                  返回数据 = {玩家数据[数字id].房屋.室内装饰,"室内"}
          elseif 地图 == 玩家数据[数字id].房屋.阁楼ID then
                  给予物品 = 玩家数据[数字id].房屋.阁楼装饰[编号].名称
                  table.remove(玩家数据[数字id].房屋.阁楼装饰,编号)
                  for k,v in pairs(玩家数据[数字id].房屋.阁楼装饰) do
                        v.编号 = k
                  end
                  返回数据 = {玩家数据[数字id].房屋.阁楼装饰,"阁楼"}
          elseif 地图 == 玩家数据[数字id].房屋.牧场ID then
                  给予物品 = 玩家数据[数字id].房屋.牧场装饰[编号].名称
                  table.remove(玩家数据[数字id].房屋.牧场装饰,编号)
                  for k,v in pairs(玩家数据[数字id].房屋.牧场装饰) do
                        v.编号 = k
                  end
                  返回数据 = {玩家数据[数字id].房屋.牧场装饰,"牧场"}
          end
          if 给予物品 and 给予物品~="" then
              玩家数据[数字id].道具:给予道具(数字id,给予物品)
              常规提示(数字id,"#Y你获得了#R"..给予物品)
          end
          if 返回数据[1] and 返回数据[2] then
                for n, v in pairs(self.地图玩家[地图]) do--向地图内玩家发送新玩家数据
                  if n~=数字id and 玩家数据[n] and self:取同一地图(地图,id,n,1) then
                     发送数据(玩家数据[n].连接id,1029,返回数据)
                  end
               end
              发送数据(玩家数据[数字id].连接id,1029,返回数据)
          end
   elseif 序号==1007 then
          -- local 编号=tonumber(内容.编号)
          -- local 方向 = tonumber(内容.方向)
          -- local 地图 = 玩家数据[数字id].角色.数据.地图数据.编号
          -- local 返回数据 = {}
          -- local 默认x = 内容.x or 玩家数据[数字id].角色.数据.地图数据.x/20
          -- local 默认y = 内容.y or  玩家数据[数字id].角色.数据.地图数据.y/20
          -- if 地图 == 玩家数据[数字id].房屋.庭院ID  then
          --      玩家数据[数字id].房屋.庭院装饰[编号].x = 默认x
          --      玩家数据[数字id].房屋.庭院装饰[编号].y = 默认y
          --      玩家数据[数字id].房屋.庭院装饰[编号].方向 = 方向
          --      返回数据 = {玩家数据[数字id].房屋.庭院装饰,"庭院"}
          -- elseif 地图 == 玩家数据[数字id].房屋.房屋ID then
          --         玩家数据[数字id].房屋.室内装饰[编号].x = 默认x
          --         玩家数据[数字id].房屋.室内装饰[编号].y = 默认y
          --         玩家数据[数字id].房屋.室内装饰[编号].方向 = 方向
          --         返回数据 = {玩家数据[数字id].房屋.室内装饰,"室内"}
          -- elseif 地图 == 玩家数据[数字id].房屋.阁楼ID then
          --         玩家数据[数字id].房屋.阁楼装饰[编号].x = 默认x
          --         玩家数据[数字id].房屋.阁楼装饰[编号].y = 默认y
          --         玩家数据[数字id].房屋.阁楼装饰[编号].方向 = 方向
          --         返回数据 = {玩家数据[数字id].房屋.阁楼装饰,"阁楼"}
          -- elseif 地图 == 玩家数据[数字id].房屋.牧场ID then
          --         玩家数据[数字id].房屋.牧场装饰[编号].x = 默认x
          --         玩家数据[数字id].房屋.牧场装饰[编号].y = 默认y
          --         玩家数据[数字id].房屋.牧场装饰[编号].方向 = 方向
          --         返回数据 = {玩家数据[数字id].房屋.牧场装饰,"牧场"}
          -- end
          -- if 返回数据[1] and 返回数据[2] then
          --     发送数据(玩家数据[数字id].连接id,1030,返回数据)
          -- end

  elseif 序号==1008 then
         local 超级 = 内容.超级
         local 地图 = 内容.地图
         发送数据(玩家数据[数字id].连接id,1004,{NPC = self.NPC列表[地图],传送 = self.传送数据[地图],地图=地图,超级=超级})
  end
  -----------------------------------------------------------------------------------------------
end

function 地图处理类:跳转地图(数字id,地图编号,x,y,强制)
  if not  玩家数据[数字id] or 地图编号==1003 then return end
  if  玩家数据[数字id].角色.数据.地图数据.编号==1003 then return end
  if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长==false then return 0 end
  if 玩家数据[数字id].战斗~=0 and 强制==nil then return  end
  if 玩家数据[数字id].摊位数据~=nil then return  end
  if not 玩家数据[数字id].跳转记录 then 玩家数据[数字id].跳转记录={时间=os.clock()-1,记录=0} end
  if os.clock() - 玩家数据[数字id].跳转记录.时间< 0.5 then
      玩家数据[数字id].跳转记录.记录 = 玩家数据[数字id].跳转记录.记录 + 1
      if 玩家数据[数字id].跳转记录.记录>=3 then
          __gge.print(false,6,时间转换(os.time()).."账号:")
          __gge.print(false,11,玩家数据[数字id].账号)
          __gge.print(false,6,"ID:")
          __gge.print(false,11,数字id)
          __gge.print(false,6,"名称:")
          __gge.print(false,11,玩家数据[数字id].角色.数据.名称)
          __gge.print(false,10," 使用外挂无限跳转封禁\n")
          共享货币[玩家数据[数字id].账号]:充值记录("开挂被封禁")
          封禁账号(数字id,"使用外挂")
          return
      end
  elseif os.clock() - 玩家数据[数字id].跳转记录.时间 >300 then
          玩家数据[数字id].跳转记录.记录 = 0
  end
  玩家数据[数字id].跳转记录.时间 = os.clock()
  local x1,y1=x*20,y*20
  玩家数据[数字id].角色.数据.地图数据.x,玩家数据[数字id].角色.数据.地图数据.y=x1,y1
  self:移除玩家(数字id)
  玩家数据[数字id].角色.数据.地图数据.编号=地图编号
  发送数据(玩家数据[数字id].连接id,1005,{地图编号,x,y})
  self:加入玩家(数字id,地图编号,x1,y1)
  if (地图编号==6003 or 地图编号==6004) and 玩家数据[数字id].角色.数据.飞行 then
      玩家数据[数字id].角色.数据.飞行 =false
      self:更新飞行(数字id,false)
      发送数据(玩家数据[数字id].连接id,72)
  end
  if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长 then
    local 队伍id=玩家数据[数字id].队伍
    for n=2,#队伍数据[队伍id].成员数据 do
      local 队员id=队伍数据[队伍id].成员数据[n]
      玩家数据[队员id].角色.数据.地图数据.x,玩家数据[队员id].角色.数据.地图数据.y=x1,y1
      self:移除玩家(队员id)
      玩家数据[队员id].角色.数据.地图数据.编号=地图编号
      发送数据(玩家数据[队员id].连接id,1005,{地图编号,x,y})
      self:加入玩家(队员id,地图编号,x1,y1)
      if (地图编号==6003 or 地图编号==6004) and 玩家数据[队员id].角色.数据.飞行 then
          玩家数据[队员id].角色.数据.飞行 =false
          self:更新飞行(队员id,false)
          发送数据(玩家数据[队员id].连接id,72)
      end
    end
  end
end


function 地图处理类:强制跳转地图(数字id)

  if  玩家数据[数字id].角色.数据.地图数据.编号==1003 then return end
  if 玩家数据[数字id].战斗~=0 then
      战斗准备类.战斗盒子[玩家数据[数字id].战斗].战斗失败 =true
      if 玩家数据[数字id].队伍~=0 and 战斗准备类.战斗盒子[玩家数据[数字id].战斗]~=nil and 战斗准备类.战斗盒子[玩家数据[数字id].战斗].执行等待<0 and 战斗准备类.战斗盒子[玩家数据[数字id].战斗]:取玩家战斗()==false then
          战斗准备类.战斗盒子[玩家数据[数字id].战斗]:结束战斗处理(0,玩家数据[id].队伍,1)
      else
         战斗准备类.战斗盒子[玩家数据[数字id].战斗]:结束战斗处理(0,0,1)
      end
  end
  if 玩家数据[数字id].摊位数据~=nil then
      玩家数据[数字id].摊位数据=nil
      发送数据(玩家数据[数字id].连接id,3518)
      self:取消玩家摊位(数字id)
  end
  self:加入玩家(数字id,1003,0,0)
  if 玩家数据[数字id].队伍~=0  then
      local 队伍id=玩家数据[数字id].队伍
      for n=1,#队伍数据[队伍id].成员数据 do
          local 队员id=队伍数据[队伍id].成员数据[n]
          玩家数据[队员id].角色.数据.地图数据.x,玩家数据[队员id].角色.数据.地图数据.y=x1,y1
          self:移除玩家(队员id)
          玩家数据[队员id].角色.数据.地图数据.编号=1003
          发送数据(玩家数据[队员id].连接id,1005,{1003,0,0})
          self:加入玩家(队员id,1003,0,0)
      end
   else
       玩家数据[数字id].角色.数据.地图数据.x,玩家数据[数字id].角色.数据.地图数据.y=x1,y1
       self:移除玩家(数字id)
       玩家数据[数字id].角色.数据.地图数据.编号=1003
      发送数据(玩家数据[数字id].连接id,1005,{1003,0,0})
  end
end





function 地图处理类:更改模型(id,模型,类型)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      if type(模型) == "string" then
        发送数据(玩家数据[n].连接id,1024,{id=id,变身=模型,变异=nil})
      elseif  type(模型) == "table" then
        发送数据(玩家数据[n].连接id,1024,{id=id,变身=模型[1],变异=模型[2]})
      end
    end
  end
end




function 地图处理类:重置首席争霸赛()
  -- 首席争霸数据={}
  -- 首席排名={}
  -- local 门派=""
  -- local 人数=0
  -- for i,v in pairs(self.地图玩家[6009]) do
  --   -- 人数=人数+1
  --   门派=玩家数据[i].角色.数据.门派
  --   if 首席争霸数据[门派]==nil then
  --     首席争霸数据[门派]={}
  --   end
  --   首席争霸数据[门派][i]={积分=0,奖励=false,id=i,连胜次数=0,等级=玩家数据[i].角色.数据.等级,名称=玩家数据[i].角色.数据.名称,模型=玩家数据[i].角色.数据.模型,染色组=玩家数据[i].角色.数据.染色组,染色方案=玩家数据[i].角色.数据.染色方案}
  --   if 玩家数据[i].角色.数据.装备[3] ~= nil and  玩家数据[i].道具.数据[玩家数据[i].角色.数据.装备[3]] ~= nil then
  --     首席争霸数据[门派][i].武器=玩家数据[i].道具.数据[玩家数据[i].角色.数据.装备[3]].名称
  --     首席争霸数据[门派][i].武器等级=玩家数据[i].道具.数据[玩家数据[i].角色.数据.装备[3]].级别限制
  --     首席争霸数据[门派][i].武器染色方案=玩家数据[i].道具.数据[玩家数据[i].角色.数据.装备[3]].染色方案
  --     首席争霸数据[门派][i].武器染色组=玩家数据[i].道具.数据[玩家数据[i].角色.数据.装备[3]].染色组
  --   end
  --   常规提示(i,"你当前的首席积分为0分，每战胜一名玩家可获得5点积分")
  -- end
  -- -- table.print(首席争霸数据)
  -- for k,v in pairs(首席争霸数据) do
  --   local 人数 = 0
  --   for i,n in pairs(v) do
  --     if 玩家数据[i]~=nil then
  --       人数 = 人数 + 1
  --     end
  --   end
  --   if 人数==1 then
  --      结束首席争霸(1,k)
  --   end
  -- end
end






function 地图处理类:重置坐标(id,x,y)
  玩家数据[id].角色.数据.地图数据.x,玩家数据[id].角色.数据.地图数据.y=x,y
  if 玩家数据[id].子角色操作==nil then
   发送数据(玩家数据[id].连接id,1011,{x=x,y=y})
 end
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for i, v in pairs(self.地图玩家[地图编号]) do
    if i~=id and 玩家数据[i] and 玩家数据[i].子角色操作==nil then
      发送数据(玩家数据[i].连接id,1012,{id=id,x=x,y=y})
    end
  end
end

function 地图处理类:移动坐标刷新(id,数字id,内容)
  if self:取移动限制(数字id) then return end
  local 原始数据 =  玩家数据[数字id].角色.数据.地图数据
  local 角色xy = {x=内容.x,y=内容.y}
   local 对方微调={x=0,y=0}
    if 内容.x>原始数据.x then
        对方微调.x=-2
    else
        对方微调.x =2
    end
    if 内容.y>原始数据.y then
        对方微调.y=-2
    else
       对方微调.y =2
    end
   local 地图=玩家数据[数字id].角色.数据.地图数据.编号
   玩家数据[数字id].角色.数据.地图数据.x,玩家数据[数字id].角色.数据.地图数据.y=内容.x,内容.y
  --  if 玩家数据[数字id].移动数据 and  玩家数据[数字id].移动数据.移动目标 then
  --    local 目标xy = {x=玩家数据[数字id].移动数据.移动目标.x,y=玩家数据[数字id].移动数据.移动目标.y}
  --    if 取两点距离(目标xy,角色xy)>=500 then
  --         for i, v in pairs(self.地图玩家[地图]) do
  --             if 玩家数据[i]~=nil and i~=数字id and self:取同一地图(地图,数字id,i,1) then
  --                发送数据(玩家数据[i].连接id,1008,{数字id=数字id,路径={x=玩家数据[数字id].移动数据.移动目标.x,y=玩家数据[数字id].移动数据.移动目标.y,距离=0,数字id=数字id}})
  --             end
  --         end
  --    end
  -- end
  if 玩家数据[数字id].队伍~=0 and 玩家数据[数字id].队长 and 玩家数据[数字id].移动数据.移动目标 ~= nil then
    local 对方xy={x=0,y=0}
    for n=2,#队伍数据[玩家数据[数字id].队伍].成员数据 do
      local 队员id=队伍数据[玩家数据[数字id].队伍].成员数据[n]
      对方xy.x,对方xy.y=玩家数据[队员id].角色.数据.地图数据.x,玩家数据[队员id].角色.数据.地图数据.y
      local 发送x =(n-1)*对方微调.x
      local 发送y =(n-1)*对方微调.y
      if 取两点距离(角色xy,对方xy)>=self.队伍距离*n+1000 then --超出五倍距离重置坐标
          玩家数据[数字id].移动数据[n]=false
          self:重置坐标(队员id,内容.x+发送x,内容.y+发送y)
          return
      end
      if 取两点距离(角色xy,对方xy)>=self.队伍距离*n then
        if 玩家数据[数字id].移动数据[n]==false or 取两点距离(角色xy,对方xy)>=self.队伍距离*n-self.队伍距离 then
          玩家数据[数字id].移动数据[n]=true
          local 临时数据={x=玩家数据[数字id].移动数据.移动目标.x+发送x,y=玩家数据[数字id].移动数据.移动目标.y+发送y,距离=self.队伍距离*n-self.队伍距离,数字id=队员id}
          发送数据(玩家数据[队员id].连接id,1001,临时数据)
          local 地图编号=玩家数据[数字id].角色.数据.地图数据.编号
          for i, v in pairs(self.地图玩家[地图]) do
            if 玩家数据[i]~=nil and i~=队员id and self:取同一地图(地图,队员id,i,1) then
                 发送数据(玩家数据[i].连接id,1008,{数字id=队员id,路径=临时数据})
            end
          end
        end
      end
    end
  end

  if self.遇怪地图[地图]~=nil and 取队长权限(数字id) then
    if 玩家数据[数字id].遇怪时间 == nil then
        玩家数据[数字id].遇怪时间=os.time()+取随机数(10,20)
    end
    if os.time()>=玩家数据[数字id].遇怪时间 and self:遇怪条件检测(地图,数字id) then
      if 取随机数(1,1000)<=1 then
        战斗准备类:创建战斗(数字id,100225,0)
        else
        战斗准备类:创建战斗(数字id,100001,0)
      end
    else
      self:官职情报收集检测(地图,数字id)
    end
  end
  if 玩家数据[数字id].角色:取任务(111)~=0 and 任务数据[玩家数据[数字id].角色:取任务(111)].分类==2 and 取门派巡逻地图(玩家数据[数字id].角色.数据.门派,地图) and 取随机数()<=10 and (玩家数据[数字id].战斗==nil or 玩家数据[数字id].战斗==0)  then
    战斗准备类:创建战斗(数字id,100015,玩家数据[数字id].角色:取任务(111))
  end--------远方文韵墨香
  if 玩家数据[数字id].角色:取任务(112)~=0 and 任务数据[玩家数据[数字id].角色:取任务(112)].分类==2 and 取文韵巡逻地图(玩家数据[数字id].角色.数据.门派,地图) and 取随机数()<=10 and (玩家数据[数字id].战斗==nil or 玩家数据[数字id].战斗==0)  then
    战斗准备类:创建战斗(数字id,100429,玩家数据[数字id].角色:取任务(112))
  end

  if 玩家数据[数字id].角色:取任务(301)~=0 and 任务数据[玩家数据[数字id].角色:取任务(301)].分类==4 and 取随机数()<=10 and (玩家数据[数字id].战斗==nil or 玩家数据[数字id].战斗==0) then
    战斗准备类:创建战斗(数字id,100034,玩家数据[数字id].角色:取任务(301))
  end

  if 玩家数据[数字id].角色:取任务(302)~=0 and 任务数据[玩家数据[数字id].角色:取任务(302)].分类==4  and 取随机数()<=10 and (玩家数据[数字id].战斗==nil or 玩家数据[数字id].战斗==0) then
    战斗准备类:创建战斗(数字id,100035,玩家数据[数字id].角色:取任务(302))
  end
end


function 地图处理类:官职情报收集检测(地图,id)
  -- print(地图)
  if 地图==1110 or 地图==1514 or 地图==1174 or 地图==1091 or 地图==1173 then
    if 玩家数据[id].角色:取任务(110)~=0 and 任务数据[玩家数据[id].角色:取任务(110)].分类==3 and 任务数据[玩家数据[id].角色:取任务(110)].情报==false and 取随机数()<=20 and (玩家数据[id].战斗==nil or 玩家数据[id].战斗==0) then
       战斗准备类:创建战斗(id,100014,玩家数据[id].角色:取任务(110))
    end
  end
end

function 地图处理类:遇怪条件检测(地图,id)
  if 地图>=1004 and 地图<=1009 then
    return false
  elseif 地图==1090 then
    return false
  elseif 玩家数据[id].战斗~=nil and 玩家数据[id].战斗~=0 then
    return false
  elseif 玩家数据[id].角色:取任务(110)~=0 and 任务数据[玩家数据[id].角色:取任务(110)].分类==3 then
    return false
  elseif 玩家数据[id].角色:取任务(111)~=0 and 任务数据[玩家数据[id].角色:取任务(111)].分类==2 then
    return false
  end
  local 场景等级=取场景等级(地图)
  if 场景等级==nil then
    return false
  elseif 玩家数据[id].角色:取任务(9)~=0 and 玩家数据[id].角色.数据.等级+10>=场景等级 then
    return false
  elseif 玩家数据[id].战斗~=nil and 玩家数据[id].战斗~=0 then
    return false
  end
  return true
end

function 地图处理类:比较距离(id,对方id,距离)
  if 玩家数据[id].角色.数据.地图数据.编号~=玩家数据[对方id].角色.数据.地图数据.编号 then
    return false
  elseif 取两点距离(玩家数据[id].角色.数据.地图数据,玩家数据[对方id].角色.数据.地图数据)>距离 then
    return false
  end
  return true
end

function 地图处理类:取移动限制(id)
  if id==nil or 玩家数据[id]==nil then return true end
  if 玩家数据[id].队伍~=0 and 玩家数据[id].队长==false then
        return true
  elseif 玩家数据[id].摊位数据~=nil then
        return  true
  end
  return false
end
-- function 地图处理类:移动请求(id,内容,数字id)
--   if 玩家数据[数字id]==nil then return end
--   if self:取移动限制(数字id) then --移动限制
--     return
--   else
--     内容.距离=0
--   end
--   if 玩家数据[数字id]~=nil and 玩家数据[数字id].队伍~=0 then
--     玩家数据[数字id].移动数据={}
--     for n=1,#队伍数据[玩家数据[数字id].队伍].成员数据 do
--       玩家数据[数字id].移动数据[n]=false
--     end
--   end
--   if 玩家数据[数字id]~=nil and 玩家数据[数字id].移动数据~=nil then
--     玩家数据[数字id].移动数据.移动目标=内容
--     local 地图编号=玩家数据[数字id].角色.数据.地图数据.编号
--     for n, v in pairs(self.地图玩家[地图编号]) do
--       if n~=数字id and 玩家数据[n]~=nil and self:取同一地图(地图编号,数字id,n,1)  then
--         if 玩家数据[n].子角色操作==nil  then
--            发送数据(玩家数据[n].连接id,1008,{数字id=数字id,路径=内容})
--         end
--       end
--     end
--   end
-- end


function 地图处理类:移动请求(id,内容,数字id)
  if 玩家数据[数字id]==nil then return end
  if not 内容 or not 内容.x or not 内容.y then return end
  if self:取移动限制(数字id) then --移动限制
      return
  else
    内容.距离=0
  end
  玩家数据[数字id].移动数据={}
  玩家数据[数字id].移动数据.移动目标={x=内容.x,y=内容.y,距离=0}
  if 玩家数据[数字id].队伍 and 玩家数据[数字id].队伍~=0 and 队伍数据[玩家数据[数字id].队伍] then
      for n=1,#队伍数据[玩家数据[数字id].队伍].成员数据 do
          玩家数据[数字id].移动数据[n]=false
      end
  end
  local 地图= 玩家数据[数字id].角色.数据.地图数据.编号
  local 路径={数字id=数字id,x=内容.x,y=内容.y,距离=0}
  if 地图~= 0 and self.地图玩家[地图] then
      for n, v in pairs(self.地图玩家[地图]) do
          if n~=数字id and 玩家数据[n]~=nil and self:取同一地图(地图,数字id,n,1)  then
              发送数据(玩家数据[n].连接id,1008,{数字id=数字id,路径=路径})
          end
      end
  end
end





function 地图处理类:移除玩家(id)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if 玩家数据[n]~=nil and n~=id and self:取同一地图(地图编号,id,n,1)  then
      发送数据(玩家数据[n].连接id,1007,{id=id})
    end
  end
  self.地图玩家[地图编号][id]=nil
end

function 地图处理类:更改染色(id,染色组,方案)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
      发送数据(玩家数据[n].连接id,1013,{id=id,染色组=染色组,染色方案=方案})
    end
  end
end

function 地图处理类:更改PK(id,开关)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
      发送数据(玩家数据[n].连接id,1023,{id=id,开关=开关})
    end
  end
end

function 地图处理类:更改强PK(id,开关)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
      发送数据(玩家数据[n].连接id,1025,{id=id,开关=开关})
    end
  end
end

function 地图处理类:更新武器(id,武器)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,1009,{id=id,武器=武器})
    end
  end
end

function 地图处理类:更新副武器(id,武器)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,1009.1,{id=id,武器=武器})
    end
  end
end

function 地图处理类:更新飞行(id,飞行)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,1010.1,{id=id,飞行=飞行})
    end
  end
end

function 地图处理类:更新锦衣(id,锦衣)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,1014,{id=id,锦衣=锦衣})
    end
  end
end

function 地图处理类:更新坐骑(id,坐骑)
    local 地图编号=玩家数据[id].角色.数据.地图数据.编号
    for n, v in pairs(self.地图玩家[地图编号]) do
        if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
          发送数据(玩家数据[n].连接id,1019,{id=id,坐骑=坐骑})
        end
    end
end



function 地图处理类:更新称谓(id,称谓)
    local 地图编号=玩家数据[id].角色.数据.地图数据.编号
    for n, v in pairs(self.地图玩家[地图编号]) do
        if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
            发送数据(玩家数据[n].连接id,1020,{id=id,当前称谓=称谓})
        end
    end
end

function 地图处理类:设置战斗开关(id,逻辑)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n]~=nil and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,4014,{id=id,逻辑=逻辑})
    end
  end
end

function 地图处理类:更改队伍图标(id,逻辑)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1) then
      发送数据(玩家数据[n].连接id,4007,{id=id,逻辑=逻辑})
    end
  end
end

function 地图处理类:加入动画(id,地图编号,x,y,类型)
  --local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  local 角色xy={x=x,y=y}
  local 对方xy={x=0,y=0}
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
      对方xy.x,对方xy.y=玩家数据[n].角色.数据.地图数据.x,玩家数据[n].角色.数据.地图数据.y
      if 取两点距离(角色xy,对方xy)<=1500 then
        发送数据(玩家数据[n].连接id,1010,{id=id,类型=类型})
      end
    end
  end
end

function 地图处理类:删除单位(地图,编号)
      if not self.地图单位[地图] then
        if 地图==nil then
            地图="异常地图"
        end
        __gge.print(true,12,"地图异常数据:"..地图.."\n")
        return
      elseif not self.地图单位[地图][编号] then
           -- if 编号==nil then
           --    编号="编号异常"
           -- end
          -- __gge.print(true,12,"地图异常数据:"..地图..","..编号.."\n")
           return
      end
      local 任务id = self.地图单位[地图][编号].id
      if 任务id and 任务数据[任务id] and 任务数据[任务id].编号==编号 then
          self.地图单位[地图][编号]=nil
          for n, v in pairs(self.地图玩家[地图]) do
              if 玩家数据[v] then
                  发送数据(玩家数据[v].连接id,1016,{编号=编号,序列=任务id})
              end
          end
      end
end

function 地图处理类:添加单位(id)  --15 道士 1014  1015   1015 1000 -1013
  local 地图=任务数据[id].地图编号
  local 编号=0
  for n=1000,self.单位编号[地图] do
      if 编号==0 and self.地图单位[地图][n]==nil then
          编号=n
      end
  end
  if 编号==0 then
      self.单位编号[地图]=self.单位编号[地图]+1
      编号=self.单位编号[地图]
  end
  self.地图单位[地图][编号]={
        id=id,
        编号=编号,
        地图=地图,
        x=任务数据[id].x,
        y=任务数据[id].y,
        名称=任务数据[id].名称,
        模型=任务数据[id].模型,
        事件=任务数据[id].事件 or "单位",
  }
  local 加载信息 = {"变异","称谓","武器","锦衣","方向","染色组","染色方案","行走开关","显示饰品","武器染色组","武器染色方案"}
  for i,v in ipairs(加载信息) do
      self.地图单位[地图][编号][v] = 任务数据[id][v]
  end
  任务数据[id].编号=编号
  for n, v in pairs(self.地图玩家[地图]) do
      if 玩家数据[v] and  self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
        发送数据(玩家数据[v].连接id,1015,self.地图单位[地图][编号])
      end
  end
end

function 地图处理类:更改怪物模型(任务id)
  local 编号 = 任务数据[任务id].编号
  local 地图 = 任务数据[任务id].地图编号
  if 编号 and self.地图单位[地图][编号] and self.地图单位[地图][编号].id==任务id then
      self.地图单位[地图][编号].模型 = 任务数据[任务id].模型
      for k,v in pairs(self.地图玩家[地图]) do
          if 玩家数据[v] and self:取同一地图(地图,v,self.地图单位[地图][编号],2) then
              发送数据(玩家数据[v].连接id,1015.1,self.地图单位[地图][编号])
          end
      end
  end
end




function 地图处理类:设置玩家摊位(id,名称)
  local 地图编号=玩家数据[id].角色.数据.地图数据.编号
  for n, v in pairs(self.地图玩家[地图编号]) do
    if n~=id and 玩家数据[n] and self:取同一地图(地图编号,id,n,1)  then
      发送数据(玩家数据[n].连接id,3519,{id=id,名称=名称})
    end
  end
end

function 地图处理类:取消玩家摊位(id)
    local 地图编号=玩家数据[id].角色.数据.地图数据.编号
    for n, v in pairs(self.地图玩家[地图编号]) do
      if n~=id and 玩家数据[n] and  self:取同一地图(地图编号,id,n,1) then
        发送数据(玩家数据[n].连接id,3519,{id=id})
      end
    end
end


function 地图处理类:设置离线摆摊(id)
      local 地图编号=玩家数据[id].角色.数据.地图数据.编号
      for n, v in pairs(self.地图玩家[地图编号]) do
        if n~=id and 玩家数据[n] and  self:取同一地图(地图编号,id,n,1) then
          发送数据(玩家数据[n].连接id,1032,{id=id})
        end
      end
end

function 地图处理类:取消离线摆摊(id)
      local 地图编号=玩家数据[id].角色.数据.地图数据.编号
      for n, v in pairs(self.地图玩家[地图编号]) do
        if n~=id and 玩家数据[n] and  self:取同一地图(地图编号,id,n,1) then
          发送数据(玩家数据[n].连接id,1033,{id=id})
        end
      end
end

function 地图处理类:当前消息广播(数据,名称,内容,超链,id,特效)
  for n, v in pairs(self.地图玩家[数据.编号]) do
    if 玩家数据[n] and self:取同一地图(数据.编号,id,n,1)  then
      if 取两点距离(数据,玩家数据[n].角色.数据.地图数据)<=1500 then
        发送数据(玩家数据[n].连接id,38,{内容="["..名称.."] "..内容,超链=超链,频道="dq"})
      end
      if n~=id then
        if 玩家数据[n].战斗==0 and 取两点距离(数据,玩家数据[n].角色.数据.地图数据)<=1000 then
          发送数据(玩家数据[n].连接id,1018,{id=id,文本=内容,特效=特效})
        end
      end
    end
  end
end

function 地图处理类:清除地图玩家(编号,目标,x,y)
  for n, v in pairs(self.地图玩家[编号]) do
    self:跳转地图(n,目标,x,y)
  end
end

function 地图处理类:当前消息广播1(编号,内容)
  for n, v in pairs(self.地图玩家[编号]) do
    发送数据(玩家数据[n].连接id,38,{内容=内容,频道="dq"})
  end
end

function 地图处理类:当前消息广播2(编号,内容,任务id)
  for n, v in pairs(self.地图玩家[编号]) do
    if 玩家数据[n].角色:取任务(130)~=0 and 玩家数据[n].角色:取任务(130) == 任务id then
      发送数据(玩家数据[n].连接id,38,{内容=内容,频道="dq"})
    end
  end
end

function 地图处理类:取地图人数(地图编号)
  local 数量=0
  for n, v in pairs(self.地图玩家[地图编号]) do
    数量=数量+1
  end
  return 数量
end



function 地图处理类:取同一地图(地图,id,id1,类型)
        if 地图>=6000 and 地图<=6002 then
           if 类型==1 then
               if 玩家数据[id].角色:取任务(120)~=0 and  玩家数据[id].角色:取任务(120)== 玩家数据[id1].角色:取任务(120) then
                    return true
                else
                    return false
                end
            else
                if 任务数据[玩家数据[id].角色:取任务(120)] ~= nil and 任务数据[玩家数据[id].角色:取任务(120)].副本id ==任务数据[id1.id].副本id then
                   return true
                else
                   return false
                end
            end
        elseif 地图 == 6009 then
               if 玩家数据[id].角色.数据.门派==玩家数据[id1].角色.数据.门派 then
                 return true
              else
                  return false
              end

        elseif 地图 == 1622 then---归墟
              if 类型==1 then
                  if 玩家数据[id].角色:取任务(398)~=0 and 玩家数据[id].角色:取任务(398)== 玩家数据[id1].角色:取任务(398) then
                       return true
                  elseif 玩家数据[id].队伍 and 玩家数据[id].队伍~=0 and 玩家数据[id].队伍==玩家数据[id1].队伍 then
                       return true
                  else
                      return false
                  end
              else
                  if 玩家数据[id].角色:取任务(398) ==id1.id then
                      return true
                    else
                      return false
                  end
              end
        elseif 地图==6020 then----帮派竞赛
               if 类型==1 then
                  if 玩家数据[id].角色.数据.帮派数据.编号>0 and 玩家数据[id].角色.数据.帮派数据.编号== 玩家数据[id1].角色.数据.帮派数据.编号 then
                        return true
                    else
                        return false
                    end
               else
                   return true
               end
        elseif 地图>=6021 and 地图<=6023 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(130)~=0 and  玩家数据[id].角色:取任务(130)== 玩家数据[id1].角色:取任务(130)  then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(130)] ~= nil and 任务数据[玩家数据[id].角色:取任务(130)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                    end
                end
        elseif 地图>=6024 and 地图<=6026 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(150)~=0 and  玩家数据[id].角色:取任务(150)== 玩家数据[id1].角色:取任务(150)  then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(150)] ~= nil and 任务数据[玩家数据[id].角色:取任务(150)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                    end
                end
        elseif 地图>=6027 and 地图<=6030 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(160)~=0 and  玩家数据[id].角色:取任务(160)== 玩家数据[id1].角色:取任务(160) then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(160)] ~= nil and 任务数据[玩家数据[id].角色:取任务(160)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                   end
                end
        elseif  地图>=6031 and 地图<=6035 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(180)~=0 and  玩家数据[id].角色:取任务(180)== 玩家数据[id1].角色:取任务(180) then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(180)] ~= nil and 任务数据[玩家数据[id].角色:取任务(180)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                   end
                end
         elseif  地图>=6036 and 地图<=6039 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(191)~=0 and  玩家数据[id].角色:取任务(191)== 玩家数据[id1].角色:取任务(191) then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(191)] ~= nil and 任务数据[玩家数据[id].角色:取任务(191)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                   end
                end
          elseif  地图>=7001 and 地图<=7004 then
               if 类型==1 then
                   if 玩家数据[id].角色:取任务(7001)~=0 and  玩家数据[id].角色:取任务(7001)== 玩家数据[id1].角色:取任务(7001) then
                       return true
                   else
                       return false
                   end
                else
                   if 任务数据[玩家数据[id].角色:取任务(7001)] ~= nil and 任务数据[玩家数据[id].角色:取任务(7001)].副本id ==任务数据[id1.id].副本id then
                      return true
                    else
                      return false
                   end
                end
          elseif 地图>=1815 and 地图<=1875 then
                  local 帮派编号=玩家数据[id].角色.数据.帮派数据.编号
                  local 帮派编号1=玩家数据[id1].角色.数据.帮派数据.编号
                  if 帮派编号~=nil and 帮派编号1~=nil and 帮派编号==帮派编号1 then
                    return true
                  else
                    return false
                  end
      else
             if 类型~=1 and 玩家数据[id].角色:取任务(398)~=0 and 任务数据[玩家数据[id].角色:取任务(398)] then
                  if 任务数据[id1.id].类型==398 and 玩家数据[id].角色:取任务(398)~=id1.id then
                    return false
                  end
             end
            return true
      end
end

function 地图处理类:加入玩家(id,地图,x,y)
        id=id+0
        玩家数据[id].遇怪时间=os.time()+取随机数(10,20)
        self.地图玩家[地图][id]=id
        玩家数据[id].移动数据 ={}
        发送数据(玩家数据[id].连接id,1003,{NPC = self.NPC列表[地图],传送 = self.传送数据[地图]})
        for n, v in pairs(self.地图单位[地图]) do--场景活动怪物
            if self:取同一地图(地图,id,v,2) then
                发送数据(玩家数据[id].连接id,1015,v)
            end
        end
        --发送数据(玩家数据[id].连接id,1004,self.传送数据[地图编号])
        for n, v in pairs(self.地图玩家[地图]) do--向地图内玩家发送新玩家数据
          if 玩家数据[n] and n~=id and  self:取同一地图(地图,id,n,1) then
              发送数据(玩家数据[n].连接id,1006,玩家数据[id].角色:取地图数据())
              发送数据(玩家数据[id].连接id,1006,玩家数据[n].角色:取地图数据())
              if 玩家数据[n].移动数据 and 玩家数据[n].移动数据.移动目标 then
                  发送数据(玩家数据[id].连接id,1008,{数字id=n,路径=玩家数据[n].移动数据.移动目标})
              end
          end
        end
        if 假人摆摊 then
            摆摊假人类:摊位列表(玩家数据[id].连接id,地图)
        end
        if 走动假人 then
           假人玩家类:发送假人(玩家数据[id].连接id, 地图)
        end

end


function 地图处理类:重连加入(id,地图,x,y)
  id=id+0
  self.地图玩家[地图][id]=id
  发送数据(玩家数据[id].连接id,1003,{NPC = self.NPC列表[地图],传送 = self.传送数据[地图]})
  for n, v in pairs(self.地图单位[地图]) do--场景活动怪物
    if self:取同一地图(地图,id,v,2) then
      发送数据(玩家数据[id].连接id,1015,v)
    end
  end
  for n, v in pairs(self.地图玩家[地图]) do--向地图内玩家发送新玩家数据
      if 玩家数据[n]~=nil and  n~=id and  self:取同一地图(地图,id,n,1) then
        发送数据(玩家数据[id].连接id,1006,玩家数据[n].角色:取地图数据())
      end
  end
  if 假人摆摊 then
      摆摊假人类:摊位列表(玩家数据[id].连接id,地图)
  end
  if 走动假人 then
      假人玩家类:发送假人(玩家数据[id].连接id, 地图)
  end

end


function 地图处理类:取传送数据(地图)
          if 地图 == 1501 then
            return{
                    [1] = {x=115,y=14,目标=1505,坐标={27,33}},     ------------------------------------建邺城进建邺杂货铺
                    [2] = {x=147,y=59,目标=1537,坐标={14,29}},     ------------------------------------建邺城进建邺衙门
                    [3] = {x=128,y=102,目标=1523,坐标={14,24}},    ------------------------------------建邺城进建邺合生记
                    [4] = {x=75.7,y=131.3,目标=1502,坐标={11,19}}, ------------------------------------建邺城进建邺兵铁铺
                    [5] = {x=172,y=108,目标=1503,坐标={14,21}},    ------------------------------------建邺城进建邺布庄
                    [6] = {x=219.7,y=136.2,目标=1504,坐标={22,25}},------------------------------------建邺城进建邺回春堂
                    [7] = {x=242,y=12,目标=1506,坐标={11,37}},     ------------------------------------建邺城进东海湾旧
                    [8] = {x=272,y=113,目标=1506,坐标={10,111}},   ------------------------------------建邺城进东海湾新
                    [9] = {x=237,y=63,目标=1524,坐标={24,27}},     ------------------------------------建邺城进建邺钱庄
                    [10] = {x=4,y=59,目标=1527,坐标={29,27}},      ------------------------------------建邺城进建邺李府
                    [11] = {x=244,y=121,目标=1526,坐标={26,27}},   ------------------------------------建邺城进建邺周猎户家
                    [12] = {x=258,y=55,目标=1525,坐标={15,18}},    ------------------------------------建邺城进建邺普通民居

            }
          elseif 地图 == 1505 then
                  return {x=28,y=35,目标=1501,坐标={118,18}}       ------------------------------------建邺杂货铺出建邺城
          elseif 地图 == 1537 then
                  return {x=13,y=31,目标=1501,坐标={144,64}}        ------------------------------------建邺衙门出建邺城
          elseif 地图 == 1523 then
                  return {x=14,y=29,目标=1501,坐标={125,106}}      ------------------------------------建邺合生记出建邺城
          elseif 地图 == 1502 then
                  return {x=13,y=24,目标=1501,坐标={74,134}}        ------------------------------------建邺兵铁铺出建邺城
          elseif 地图 == 1503 then
                  return {x=13,y=28,目标=1501,坐标={170,111}}      ------------------------------------建邺布庄出建邺城
          elseif 地图 == 1504 then
                  return {x=28.4,y=24.3,目标=1501,坐标={223,141}}  ------------------------------------建邺回春堂出建邺城
          elseif 地图 == 1524 then
                  return {x=20,y=30,目标=1501,坐标={235,68}}       ------------------------------------建邺钱庄出建邺城
          elseif 地图 == 1526 then
                  return {x=32,y=32,目标=1501,坐标={247,126}}      ------------------------------------建邺周猎户家出建邺城
          elseif 地图 == 1525 then
                  return {x=11,y=19,目标=1501,坐标={255,58}}       ------------------------------------建邺普通民居出建邺城
          elseif 地图 == 1527 then
                  return{
                      [1] = {x=35,y=33,目标=1501,坐标={8,64}},     ------------------------------------建邺李府出建邺城
                      [2] = {x=7,y=24,目标=1534,坐标={38,19}}      ------------------------------------建邺李府进建邺李善人家
            }
          elseif 地图 == 1534 then
                  return {x=45,y=26,目标=1527,坐标={10,26}}        ------------------------------------建邺李善人家出建邺李府
          elseif 地图 == 1003 then
                  return {x=17,y=95,目标=1506,坐标={26,10}}        ------------------------------------桃源镇到东海湾
          elseif 地图 == 1506 then
                  return{
                      [1] = {x=4,y=36,目标=1501,坐标={237,17}},    ------------------------------------东海湾进建邺城旧
                      [2] = {x=5,y=112,目标=1501,坐标={268,114}},   ------------------------------------东海湾进建邺城新
                      [3] = {x=89,y=109,目标=1507,坐标={11,19}}    ------------------------------------东海湾进东海海底
            }
          elseif 地图 == 1126 then
                  return {x=10,y=72,目标=1506,坐标={86,89}}        ------------------------------------东海岩洞出东海湾

          elseif 地图 == 1116 then
                  return{
                      [1] = {x=114,y=52,目标=1117,坐标={24,32}},    ------------------------------------龙宫进水晶宫
                      [2] = {x=206,y=6,目标=1118,坐标={10,39}},     ------------------------------------龙宫进海底迷宫一层
                      [3] = {x=132,y=52,目标=1117,坐标={47,32}},    ------------------------------------龙宫进水晶宫1
            }
          elseif 地图 == 1117 then
                  return{
                      [1] = {x=16.4,y=34.6,目标=1116,坐标={109,57}}, ------------------------------------水晶宫出龙宫
                      [2] = {x=50.4,y=33,目标=1116,坐标={137,56}},   ------------------------------------水晶宫出龙宫1
            }
            elseif 地图 == 1118 then
                  return{
                      [1] = {x=5,y=42,目标=1116,坐标={199,9}},       ------------------------------------海底迷宫一层进龙宫
                      [2] = {x=58,y=8,目标=1119,坐标={11,40}},       ------------------------------------海底迷宫一层进海底迷宫二层
                      [3] = {x=14,y=7,目标=1120,坐标={53,36}},       ------------------------------------海底迷宫一层进海底迷宫三层
            }
          elseif 地图 == 1119 then
                  return{
                      [1] = {x=6,y=43,目标=1118,坐标={53,12}},       ------------------------------------海底迷宫二层进海底迷宫一层
                      [2] = {x=53,y=6,目标=1532,坐标={22,40}},       ------------------------------------海底迷宫二层进海底迷宫五层
            }
          elseif 地图 == 1120 then
                  return{
                      [1] = {x=56,y=40,目标=1118,坐标={12,14}},      ------------------------------------海底迷宫三层进海底迷宫一层
                      [2] = {x=57,y=5,目标=1121,坐标={11,36}},       ------------------------------------海底迷宫三层进海底迷宫四层
            }
          elseif 地图 == 1121 then
                  return{
                      [1] = {x=4,y=43,目标=1120,坐标={52,10}},       ------------------------------------海底迷宫四层进海底迷宫三层
                      [2] = {x=55,y=42,目标=1532,坐标={10,10}},      ------------------------------------海底迷宫四层进海底迷宫五层
            }
          elseif 地图 == 1532 then
                  return{
                      [1] = {x=20,y=42,目标=1119,坐标={47,11}},      ------------------------------------海底迷宫五层进海底迷宫二层
                      [2] = {x=4,y=5,目标=1121,坐标={50,37}},        ------------------------------------海底迷宫五层进海底迷宫四层
            }
          elseif 地图 == 1507 then
                  return{
                      [1] = {x=11,y=12.2,目标=1506,坐标={85,107}},   ------------------------------------东海海底进东海湾
                      [2] = {x=89,y=13.8,目标=1508,坐标={27,14}},   ------------------------------------东海海底进沉船
            }
          elseif 地图 == 1508 then
                  return{
                      [1] = {x=22,y=6,目标=1507,坐标={85,10}},       ------------------------------------沉船出东海海底
                      [2] = {x=75,y=69,目标=1509,坐标={14,18}},      ------------------------------------沉船进沉船内室
            }
          elseif 地图 == 1509 then
                  return {x=11,y=14,目标=1508,坐标={70,65}}         ------------------------------------沉船内室出沉船
          elseif 地图 == 1193 then
                  return{
                      [1] = {x=156,y=64,目标=1501,坐标={9,141}},     ------------------------------------江南野外传送建邺城
                      [2] = {x=20,y=10,目标=1001,坐标={532,276}},    ------------------------------------江南野外传送长安
                      [3] = {x=106,y=10,目标=1876,坐标={136,71}},    ------------------------------------江南野外传送南岭山
            }
          elseif 地图 == 1001 then
            return{
                    [1] = {x=530,y=275,目标=1193,坐标={25,17}},     ------------------------------------长安传送江南野外
                    [2] = {x=461,y=112,目标=1028,坐标={17,38}},     ------------------------------------长安传送长安酒店一楼
                    [3] = {x=509,y=6,目标=1002,坐标={10,88}},       ------------------------------------长安传送化生寺
                    [4] = {x=475.6,y=238,目标=1020,坐标={15,21}},   ------------------------------------长安传送万胜兵器铺
                    [5] = {x=388,y=264,目标=1017,坐标={35,27}},     ------------------------------------长安传送锦绣饰品店
                    [6] = {x=368,y=240,目标=1022,坐标={31,23}},     ------------------------------------长安传送张记布庄
                    [7] = {x=436,y=219,目标=1030,坐标={12,22}},     ------------------------------------长安传送云来酒店
                    [8] = {x=447,y=33,目标=1004,坐标={34,58}},      ------------------------------------长安传送大雁塔一层路口1
                    [9] = {x=475,y=33,目标=1004,坐标={103,58}},     ------------------------------------长安传送大雁塔一层路口2
                    [10] = {x=308,y=4,目标=1198,坐标={153,94}},     ------------------------------------长安传送大唐官府
                    [11] = {x=8,y=277,目标=1110,坐标={332,191}},    ------------------------------------长安传送大唐国境
                    [12] = {x=487,y=120.7,目标=1016,坐标={14,25}},  ------------------------------------长安传送回春堂
                    [13] = {x=218,y=243,目标=1033,坐标={47,42}},    ------------------------------------长安传送留香阁
                    [14] = {x=524,y=124,目标=1024,坐标={22,28}},    ------------------------------------长安传送长风镖局
                    [15] = {x=276,y=76,目标=1026,坐标={49,36}},     ------------------------------------长安传送国子监
                    [16] = {x=100.5,y=46.8,目标=1044,坐标={97,76}}, ------------------------------------长安传送金銮殿
                    [17] = {x=523,y=203,目标=1019,坐标={21,26}},    ------------------------------------长安传送书香斋
                    [18] = {x=485,y=182,目标=1025,坐标={23,23}},    ------------------------------------长安传送冯记铁铺
                    [19] = {x=513,y=82,目标=1013,坐标={21,29}},     ------------------------------------长安传送广源钱庄

           }
          elseif 地图 == 1013 then
                  return {x=17,y=31,目标=1001,坐标={510,87}}        ------------------------------------广源钱庄传送长安
          elseif 地图 == 1019 then
                  return {x=15,y=31,目标=1001,坐标={510,210}}       ------------------------------------书香斋传送长安
          elseif 地图 == 1025 then
                  return {x=16,y=24,目标=1001,坐标={482,188}}       ------------------------------------冯记铁铺传送长安
          elseif 地图 == 1044 then
                  return {x=102.5,y=78,目标=1001,坐标={104,51}}     ------------------------------------金銮殿传送长安
          elseif 地图 == 1028 then
                  return{
                      [1] = {x=16,y=40,目标=1001,坐标={458,116}},   ------------------------------------长安酒店一楼传送长安
                      [2] = {x=36,y=14,目标=1029,坐标={41,18}},     ------------------------------------长安酒店一楼传送长安酒店二楼
            }
          elseif 地图 == 1198 then
                  return{
                      [1] = {x=162,y=97.5,目标=1001,坐标={314,10}},  ------------------------------------大唐官府传送长安
                      [2] = {x=77.3,y=56,目标=1054,坐标={35,27.5}},  ------------------------------------大唐官府传送程咬金府
            }
          elseif 地图 == 1029 then
                  return {x=36,y=15,目标=1028,坐标={29,20}}          ------------------------------------长安酒店二楼传送长安酒店一楼
          elseif 地图 == 1054 then
                  return {x=38.5,y=29,目标=1198,坐标={82,60}}        ------------------------------------程咬金府传送大唐官府
          elseif 地图 == 1002 then
                  return{
                      [1] = {x=4,y=92,目标=1001,坐标={492,14}},      ------------------------------------化生寺传送长安
                      [2] = {x=58,y=56,目标=1528,坐标={18,26}},      ------------------------------------化生寺传送光华殿
                      [3] = {x=91,y=40,目标=1043,坐标={7,14}},       ------------------------------------化生寺传送藏经阁
            }
          elseif 地图 == 1043 then
                  return {x=13,y=21,目标=1002,坐标={88,45}}          ------------------------------------藏经阁传送化生寺
          elseif 地图 == 1528 then
                  return {x=16,y=27,目标=1002,坐标={61,61}}          ------------------------------------光华殿传送化生寺
          elseif 地图 == 1004 then
                  return{
                      [1] = {x=30.2,y=59.8,目标=1001,坐标={442,37}}, ------------------------------------大雁塔一层路口1传送长安
                      [2] = {x=108,y=60,目标=1001,坐标={480,37}},    ------------------------------------大雁塔一层路口2传送长安
                      [3] = {x=69,y=4,目标=1005,坐标={65,22}},       ------------------------------------大雁塔一层传送大雁塔二层
            }
          elseif 地图 == 1005 then
                  return{
                      [1] = {x=69,y=19,目标=1004,坐标={73,10}},      ------------------------------------大雁塔二层传送大雁塔一层
                      [2] = {x=79,y=67,目标=1006,坐标={65,67}},      ------------------------------------大雁塔二层传送大雁塔三层
            }
          elseif 地图 == 1006 then
                  return{
                      [1] = {x=72,y=72,目标=1005,坐标={70,73}},      ------------------------------------大雁塔三层传送大雁塔二层
                      [2] = {x=74,y=7,目标=1007,坐标={64,21}},       ------------------------------------大雁塔三层传送大雁塔四层
            }
          elseif 地图 == 1007 then
                  return{
                      [1] = {x=63,y=26,目标=1006,坐标={69,13}},      ------------------------------------大雁塔四层传送大雁塔三层
                      [2] = {x=99,y=21,目标=1008,坐标={88,33}},      ------------------------------------大雁塔四层传送大雁塔五层
            }

          elseif 地图 == 1008 then
                  return{
                      [1] = {x=98,y=30,目标=1007,坐标={103,29}},     ------------------------------------大雁塔五层传送大雁塔四层
                      [2] = {x=13,y=33,目标=1090,坐标={19,37}},      ------------------------------------大雁塔五层传送大雁塔六层
            }
          elseif 地图 == 1090 then
                  return{
                      [1] = {x=15,y=40,目标=1008,坐标={21,45}},      ------------------------------------大雁塔六层传送大雁塔五层
                      [2] = {x=62,y=30,目标=1009,坐标={34,38}},      ------------------------------------大雁塔六层传送大雁塔七层
            }
          elseif 地图 == 1009 then
                  return {x=38,y=34,目标=1090,坐标={67,43}}         ------------------------------------大雁塔七层传送大雁塔六层
          elseif 地图 == 1020 then
                  return {x=15,y=25,目标=1001,坐标={472,242}}       ------------------------------------万胜兵器铺传送长安
          elseif 地图 == 1017 then
                  return {x=39,y=27,目标=1001,坐标={396,269}}       ------------------------------------锦绣饰品店传送长安
          elseif 地图 == 1022 then
                  return {x=35,y=25,目标=1001,坐标={373,246}}       ------------------------------------张记布庄传送长安
          elseif 地图 == 1030 then
                  return {x=12,y=25,目标=1001,坐标={431,225}}       ------------------------------------云来酒店传送长安
          elseif 地图 == 1016 then
                  return {x=10,y=27,目标=1001,坐标={484,127}}       ------------------------------------回春堂传送长安
          elseif 地图 == 1033 then
                  return {x=51,y=43.3,目标=1001,坐标={222,250}}     ------------------------------------留香阁传送长安
          elseif 地图 == 1024 then
                  return{
                      [1] = {x=8,y=25,目标=1001,坐标={522,129}},    ------------------------------------长风镖局传送长安
                      [2] = {x=29,y=36,目标=1001,坐标={522,129}},   ------------------------------------长风镖局传送长安 ----问题
            }
          elseif 地图 == 1026 then
                  return {x=59,y=44,目标=1001,坐标={282,82}}        ------------------------------------国子监传送长安
          elseif 地图 == 1092 then
                  return{
                    [1] = {x=6,y=11,目标=1142,坐标={118,131}},      ------------------------------------傲来国传送女儿村
                    [2] = {x=130,y=109,目标=1101,坐标={13,21}},     ------------------------------------傲来国传送傲来武器店
                    [3] = {x=216,y=9,目标=1514,坐标={12,108}},      ------------------------------------傲来国传送花果山
                    [4] = {x=180.2,y=120.3,目标=1093,坐标={39,32}}, ------------------------------------傲来国传送傲来国客栈
                    [5] = {x=98.1,y=131.8,目标=1105,坐标={29,25}},  ------------------------------------傲来国传送傲来国杂货店
                    [6] = {x=56,y=110.2,目标=1104,坐标={38,33}},    ------------------------------------傲来国传送傲来国药店
                    [7] = {x=30.7,y=78.6,目标=1095,坐标={35,28}},   ------------------------------------傲来国传送傲来国服饰店
                    [8] = {x=138,y=44,目标=1100,坐标={21,29}},      ------------------------------------傲来国传送傲来圣殿
                    [9] = {x=103,y=91,目标=1099,坐标={44,33}},      ------------------------------------傲来国传送傲来钱庄

            }
          elseif 地图 == 1099 then
                  return {x=52,y=37,目标=1092,坐标={106,92}}         ------------------------------------傲来钱庄传送傲来国
          elseif 地图 == 1100 then
                  return {x=16,y=37,目标=1092,坐标={134,48}}         ------------------------------------傲来圣殿传送傲来国
          elseif 地图 == 1093 then
                  return {x=43,y=34,目标=1092,坐标={184,123}}        ------------------------------------傲来国客栈传送傲来国
          elseif 地图 == 1104 then
                  return {x=42,y=35,目标=1092,坐标={57,113}}         ------------------------------------傲来国药店传送傲来国
          elseif 地图 == 1105 then
                  return {x=33,y=28,目标=1092,坐标={99,135}}         ------------------------------------傲来国杂货店传送傲来国
          elseif 地图 == 1095 then
                  return {x=39.3,y=29.7,目标=1092,坐标={33.2,82.5}}  ------------------------------------傲来国服饰店传送傲来国
          elseif 地图 == 1514 then
                  return{
                    [1] = {x=5,y=110,目标=1092,坐标={209,14}},       ------------------------------------花果山传送傲来国
                    [2] = {x=20,y=15,目标=1174,坐标={209,39}},       ------------------------------------花果山传送北俱芦洲
                    [3] = {x=65.5,y=48.4,目标=1103,坐标={11,48}},    ------------------------------------花果山传送水帘洞
                    [4] = {x=103,y=112,目标=1118,坐标={9,41}},       ------------------------------------花果山传送海底迷宫1层

           }
          elseif 地图 == 1103 then
                  return {x=3,y=47,目标=1514,坐标={65,55}}           ------------------------------------水帘洞传送花果山
          elseif 地图 == 1174 then
                  return{
                    [1] = {x=197,y=64,目标=1514,坐标={26,19}},       ------------------------------------北俱芦洲传送花果山
                    [2] = {x=10,y=89,目标=1177,坐标={149,80}},       ------------------------------------北俱芦洲传送龙窟
                    [3] = {x=86,y=19,目标=1186,坐标={70,10}},        ------------------------------------北俱芦洲传送凤巢

           }
          elseif 地图 == 1177 then
                  return{
                      [1] = {x=152,y=87,目标=1174,坐标={16,95}},     ------------------------------------龙窟一层传送北俱芦洲
                      [2] = {x=17,y=24,目标=1178,坐标={126,49}}      ------------------------------------龙窟一层传送龙窟二层
            }
          elseif 地图 == 1178 then
                  return{
                      [1] = {x=130,y=49,目标=1177,坐标={21,30}},     ------------------------------------龙窟二层传送龙窟一层
                      [2] = {x=21,y=65,目标=1179,坐标={11,12}}       ------------------------------------龙窟二层传送龙窟三层
            }
          elseif 地图 == 1179 then
                  return{
                      [1] = {x=10,y=5,目标=1178,坐标={29,63}},       ------------------------------------龙窟三层传送龙窟二层
                      [2] = {x=133,y=59,目标=1180,坐标={14,64}}      ------------------------------------龙窟三层传送龙窟四层
            }
          elseif 地图 == 1180 then
                  return{
                      [1] = {x=4,y=63,目标=1179,坐标={127,54}},      ------------------------------------龙窟四层传送龙窟三层
                      [2] = {x=124,y=44,目标=1181,坐标={121,12}}     ------------------------------------龙窟四层传送龙窟五层
            }
          elseif 地图 == 1181 then
                  return{
                      [1] = {x=131,y=8,目标=1180,坐标={128,48}},      ------------------------------------龙窟五层传送龙窟四层
                      [2] = {x=51,y=61,目标=1182,坐标={88,66}}       ------------------------------------龙窟五层传送龙窟六层
            }
          elseif 地图 == 1182 then
                  return{
                      [1] = {x=120,y=18,目标=1183,坐标={12,15}},     ------------------------------------龙窟六层传送龙窟七层
                      [2] = {x=81,y=65,目标=1181,坐标={44,60}}       ------------------------------------龙窟六层传送龙窟五层
            }
          elseif 地图 == 1183 then
                  return {x=6,y=9,目标=1182,坐标={113,18}}           ------------------------------------龙窟七层传送龙窟六层
          elseif 地图 == 1186 then
                  return{
                      [1] = {x=75,y=6.8,目标=1174,坐标={84,26}},     ------------------------------------凤巢一层传送北俱芦洲
                      [2] = {x=52,y=62,目标=1187,坐标={36,12}}       ------------------------------------凤巢一层传送凤巢二层
            }
          elseif 地图 == 1187 then
                  return{
                      [1] = {x=43.5,y=3,目标=1186,坐标={49,59}},     ------------------------------------凤巢二层传送凤巢一层
                      [2] = {x=121,y=24,目标=1188,坐标={18,17}}      ------------------------------------凤巢二层传送凤巢三层
            }

          elseif 地图 == 1188 then
                  return{
                      [1] = {x=11,y=13,目标=1187,坐标={115,21}},     ------------------------------------凤巢三层传送凤巢二层
                      [2] = {x=123,y=65.5,目标=1189,坐标={23,20}}    ------------------------------------凤巢三层传送凤巢四层
            }
          elseif 地图 == 1189 then
                  return{
                      [1] = {x=11,y=11,目标=1188,坐标={114,61}},     ------------------------------------凤巢四层传送凤巢三层
                      [2] = {x=73.6,y=4,目标=1190,坐标={76,65}}      ------------------------------------凤巢四层传送凤巢五层
            }
          elseif 地图 == 1190 then
                  return{
                      [1] = {x=74,y=68,目标=1189,坐标={70,10}},      ------------------------------------凤巢五层传送凤巢四层
                      [2] = {x=114,y=4,目标=1191,坐标={6,64}}        ------------------------------------凤巢五层传送凤巢六层
            }
          elseif 地图 == 1191 then
                  return{
                      [1] = {x=3.8,y=67,目标=1190,坐标={111,8}},     ------------------------------------凤巢六层传送凤巢五层
                      [2] = {x=122.7,y=27,目标=1192,坐标={12,31}}    ------------------------------------凤巢六层传送凤巢七层
            }
          elseif 地图 == 1192 then
                  return {x=4,y=32,目标=1191,坐标={120,31}}          ------------------------------------凤巢七层传送凤巢六层
          elseif 地图 == 1101 then
                  return {x=11,y=25,目标=1092,坐标={124,113}}        ------------------------------------傲来武器店传送傲来国
          elseif 地图 == 1142 then
                  return{
                      [1] = {x=124,y=134,目标=1092,坐标={13,18}},    ------------------------------------女儿村传送傲来国
                      [2] = {x=14.8,y=18.7,目标=1143,坐标={31,25}}   ------------------------------------女儿村传送女儿村村长家
            }
          elseif 地图 == 1143 then
                  return {x=36,y=26,目标=1142,坐标={18,22}}          ------------------------------------女儿村村长家传送女儿村
          elseif 地图 == 1110 then
                  return{
                    [1] = {x=340,y=186,目标=1001,坐标={10,275}},     ------------------------------------大唐国境传送长安
                    [2] = {x=51,y=9,目标=1122,坐标={137,113}},       ------------------------------------大唐国境传送阴曹地府
                    [3] = {x=4,y=259,目标=1173,坐标={626,23}},       ------------------------------------大唐国境传送大唐境外
                    [4] = {x=123,y=149,目标=1153,坐标={31,25}},      ------------------------------------大唐国境传送金山寺

           }
          elseif 地图 == 1153 then
                  return {x=41,y=28,目标=1110,坐标={133,160}}        ------------------------------------金山寺传送大唐国境
          elseif 地图 == 1168 then
                  return {x=15,y=26,目标=1110,坐标={313,38}}         ------------------------------------江州府传送大唐国境
          elseif 地图 == 1150 then
                  return {x=3,y=93,目标=1110,坐标={181,77}}          ------------------------------------凌波城传送大唐国境
          elseif 地图 == 1140 then
                  return{
                      [1] = {x=88,y=67,目标=1110,坐标={234,277}},     ------------------------------------普陀山传送大唐国境
                      [2] = {x=3,y=5,目标=1141,坐标={46,36}}         ------------------------------------普陀山传送潮音洞
            }
          elseif 地图 == 1141 then
                  return{
                      [1] = {x=58,y=43,目标=1140,坐标={11,13}},       ------------------------------------潮音洞传送普陀山
                      [2] = {x=38.6,y=9.2,目标=1605,坐标={12,87}}   ------------------------------------潮音洞传送天鸣洞天
            }
          elseif 地图 == 1605 then
                  return {x=4,y=92,目标=1141,坐标={37,16}}           ------------------------------------天鸣洞天传送潮音洞
          elseif 地图 == 1122 then
                  return{
                    [1] = {x=146,y=116,目标=1110,坐标={43,13}},      ------------------------------------阴曹地府传送大唐国境
                    [2] = {x=34,y=9,目标=1127,坐标={6,21}},          ------------------------------------阴曹地府传送地狱迷宫一层
                    [3] = {x=30.2,y=51.7,目标=1123,坐标={40,32}},    ------------------------------------阴曹地府传送森罗殿
                    [4] = {x=105,y=66,目标=1125,坐标={24,27}},       ------------------------------------阴曹地府传送轮回司

           }
          elseif 地图 == 1123 then
                  return{
                      [1] = {x=25.9,y=11.5,目标=1124,坐标={35,27}},   ------------------------------------森罗殿传送地藏王府
                      [2] = {x=47,y=33,目标=1122,坐标={34,57}}       ------------------------------------森罗殿传送阴曹地府
            }
           elseif 地图 == 1124 then
                  return {x=41,y=29,目标=1123,坐标={29,14}}          ------------------------------------地藏王府传送森罗殿
           elseif 地图 == 1125 then
                  return {x=29,y=31,目标=1122,坐标={104,72}}         ------------------------------------轮回司传送阴曹地府
          elseif 地图 == 1127 then
                  return{
                      [1] = {x=7,y=13,目标=1122,坐标={29,14}},        ------------------------------------地狱迷宫一层传送阴曹地府
                      [2] = {x=18,y=75,目标=1128,坐标={99,16}}       ------------------------------------地狱迷宫一层传送地狱迷宫二层
            }
          elseif 地图 == 1128 then
                  return{
                    [1] = {x=100,y=11,目标=1127,坐标={17,72}},       ------------------------------------地狱迷宫二层传送地狱迷宫一层
                    [2] = {x=112,y=82,目标=1129,坐标={12,69}},       ------------------------------------地狱迷宫二层传送地狱迷宫三层
                    [3] = {x=114,y=53,目标=1129,坐标={14,24}},       ------------------------------------地狱迷宫二层传送地狱迷宫三层2
            }
          elseif 地图 == 1129 then
                  return{
                    [1] = {x=6,y=70,目标=1128,坐标={102,79}},        ------------------------------------地狱迷宫三层传送地狱迷宫二层2
                    [2] = {x=114,y=83,目标=1130,坐标={15,11}},       ------------------------------------地狱迷宫三层传送地狱迷宫四层
                    [3] = {x=5,y=24,目标=1128,坐标={105,53}},        ------------------------------------地狱迷宫三层传送地狱迷宫二层1
            }
          elseif 地图 == 1130 then
                  return{
                    [1] = {x=6,y=7,目标=1129,坐标={106,83}},         ------------------------------------地狱迷宫四层传送地狱迷宫三层
                    [2] = {x=85,y=33,目标=1202,坐标={16,113}},       ------------------------------------地狱迷宫四层传送无名鬼城
            }
          elseif 地图 == 1202 then
                  return {x=16,y=107,目标=1130,坐标={91,31}}         ------------------------------------无名鬼城传送地狱迷宫四层
          elseif 地图 == 1070 then
                  return{
                    [1] = {x=153,y=205,目标=1091,坐标={151,18}},     ------------------------------------长寿村传送长寿郊外
                    [2] = {x=109,y=5,目标=1135,坐标={10,134}},       ------------------------------------长寿村传送方寸山
                    [3] = {x=74,y=103,目标=1085,坐标={24,21}},       ------------------------------------长寿村传送长寿村武器店
                    [4] = {x=83.8,y=136.8,目标=1083,坐标={12,19}},   ------------------------------------长寿村传送长寿村服装店
                    [5] = {x=128,y=27,目标=1082,坐标={12,16}},       ------------------------------------长寿村传送长寿神庙
                    [6] = {x=144,y=114,目标=1081,坐标={22,18}},      ------------------------------------长寿村传送长寿钱庄
                    [7] = {x=147,y=64,目标=1084,坐标={22,18}},       ------------------------------------长寿村传送长寿辛匠

           }
          elseif 地图 == 1081 then
                  return {x=19,y=20,目标=1070,坐标={146,118}}        ------------------------------------长寿钱庄传送长寿村
          elseif 地图 == 1084 then
                  return {x=19,y=20,目标=1070,坐标={144,70}}         ------------------------------------长寿辛匠传送长寿村
          elseif 地图 == 1082 then
                  return {x=9,y=19,目标=1070,坐标={132,31}}          ------------------------------------长寿神庙传送长寿村
          elseif 地图 == 1083 then
                  return {x=9.9,y=20.7,目标=1070,坐标={87,139}}      ------------------------------------长寿村服装店传送长寿村
          elseif 地图 == 1085 then
                  return {x=27,y=22.4,目标=1070,坐标={69.5,106}}     ------------------------------------长寿村武器店传送长寿村
          elseif 地图 == 1091 then
                  return{
                    [1] = {x=155,y=9,目标=1070,坐标={139,199}},      ------------------------------------长寿郊外传送长寿村
                    [2] = {x=18,y=57,目标=1233,坐标={137,85}},       ------------------------------------长寿郊外传送柳林坡
                    [3] = {x=19,y=140,目标=1235,坐标={591,15}},      ------------------------------------长寿郊外传送丝绸之路
            }
          elseif 地图 == 1135 then
                  return{
                    [1] = {x=5,y=132,目标=1070,坐标={106,12}},       ------------------------------------方寸山传送长寿村
                    [2] = {x=130,y=30,目标=1137,坐标={21,41}},       ------------------------------------方寸山传送灵台宫
                    [3] = {x=164.5,y=149,目标=1223,坐标={50,10}},    ------------------------------------方寸山传送观星台
            }
          elseif 地图 == 1137 then
                  return {x=17.3,y=42.7,目标=1135,坐标={124,35}}     ------------------------------------灵台宫传送方寸山
          elseif 地图 == 1223 then
                  return {x=51,y=4,目标=1135,坐标={154,147}}         ------------------------------------观星台传送方寸山
          elseif 地图 == 1111 then
                  return{
                    [1] = {x=146,y=104,目标=1112,坐标={75,57}},      ------------------------------------天宫传送凌霄宝殿
                    [2] = {x=5,y=99,目标=1231,坐标={143,89}},        ------------------------------------天宫传送蟠桃园
                    [3] = {x=44,y=5,目标=1114,坐标={116,85}},        ------------------------------------天宫传送月宫
                    [4] = {x=27,y=142,目标=1113,坐标={40,26}},       ------------------------------------天宫传送兜率宫

           }
          elseif 地图 == 1112 then
                  return {x=79.3,y=58.4,目标=1111,坐标={148,108}}    ------------------------------------凌霄宝殿传送天宫
          elseif 地图 == 1114 then
                  return {x=124,y=87,目标=1111,坐标={50,9}}          ------------------------------------月宫传送天宫
          elseif 地图 == 1231 then
                  return {x=148,y=90,目标=1111,坐标={12,97}}         ------------------------------------蟠桃园传送天宫
          elseif 地图 == 1113 then
                  return {x=43,y=30,目标=1111,坐标={26,147}}         ------------------------------------兜率宫传送天宫
          elseif 地图 == 1173 then
                  return{
                    [1] = {x=57,y=5,目标=1512,坐标={12,79}},         ------------------------------------大唐境外传送魔王寨
                    [2] = {x=635,y=41,目标=1146,坐标={10,64}},       ------------------------------------大唐境外传送五庄观
                    [3] = {x=4,y=72,目标=1131,坐标={112,14}},        ------------------------------------大唐境外传送狮驼岭
                    [4] = {x=636,y=17,目标=1110,坐标={14,263}},      ------------------------------------大唐境外传送大唐国境
                    [5] = {x=528.5,y=4,目标=1513,坐标={187,140}},    ------------------------------------大唐境外传送盘丝岭
                    [6] = {x=6,y=54,目标=1208,坐标={10,114}},        ------------------------------------大唐境外传送朱紫国
                    [7] = {x=10,y=21,目标=1203,坐标={102,233}},      ------------------------------------大唐境外传送小西天
                    [8] = {x=236,y=13,目标=1218,坐标={77,165}},      ------------------------------------大唐境外传送墨家村

           }
          elseif 地图 == 1512 then
                  return{
                    [1] = {x=13,y=86,目标=1173,坐标={60,12}},        ------------------------------------魔王寨传送大唐境外
                    [2] = {x=94,y=15,目标=1145,坐标={19,27}},        ------------------------------------魔王寨传送魔王居
            }
          elseif 地图 == 1145 then
                  return {x=15,y=29,目标=1512,坐标={88,21}}          ------------------------------------魔王居传送魔王寨
          elseif 地图 == 1146 then
                  return{
                    [1] = {x=4,y=71,目标=1173,坐标={628,45}},        ------------------------------------五庄观传送大唐境外
                    [2] = {x=59,y=35.5,目标=1147,坐标={20,24}},      ------------------------------------五庄观传送乾坤殿
            }
          elseif 地图 == 1147 then
                  return {x=16,y=25,目标=1146,坐标={54,40}}          ------------------------------------乾坤殿传送五庄观
          elseif 地图 == 1131 then
                  return{
                    [1] = {x=125,y=4,目标=1173,坐标={13,68}},        ------------------------------------狮驼岭传送大唐境外
                    [2] = {x=118,y=68,目标=1134,坐标={20,25}},       ------------------------------------狮驼岭传送狮王洞
                    [3] = {x=28,y=11,目标=1132,坐标={20,24}},        ------------------------------------狮驼岭传送大象洞
                    [4] = {x=15,y=56,目标=1133,坐标={9,24}},         ------------------------------------狮驼岭传送老雕洞

           }
          elseif 地图 == 1132 then
                  return {x=29,y=32,目标=1131,坐标={23,18}}          ------------------------------------大象洞传送狮驼岭
          elseif 地图 == 1133 then
                  return {x=10,y=31,目标=1131,坐标={17,63}}          ------------------------------------老雕洞传送狮驼岭
          elseif 地图 == 1134 then
                  return {x=15,y=26,目标=1131,坐标={112,77}}         ------------------------------------狮王洞传送狮驼岭
          elseif 地图 == 1513 then
                  return{
                    [1] = {x=188.5,y=145.55,目标=1173,坐标={533,11}},------------------------------------盘丝岭传送大唐境外
                    [2] = {x=192,y=19,目标=1144,坐标={15,52}},       ------------------------------------盘丝岭传送盘丝洞
            }
          elseif 地图 == 1144 then
                  return {x=11,y=55,目标=1513,坐标={187,24}}         ------------------------------------盘丝洞传送盘丝岭
          elseif 地图 == 1205 then
                  return{
                    [1] = {x=125,y=101,目标=1001,坐标={340,215}},    ------------------------------------战神山传送长安
                    [2] = {x=9,y=100,目标=1138,坐标={61,153}},       ------------------------------------战神山传送神木林
            }
          elseif 地图 == 1138 then
                  return{
                    [1] = {x=77,y=163,目标=1205,坐标={16,99}},       ------------------------------------神木林传送战神山
                    [2] = {x=47.8,y=93,目标=1154,坐标={45.5,38}},    ------------------------------------神木林传送神木屋
            }
          elseif 地图 == 1154 then
                  return {x=48,y=38.5,目标=1138,坐标={49,96}}        ------------------------------------神木屋传送神木林
          elseif 地图 == 1228 then
                  return{
                    [1] = {x=92,y=184,目标=1173,坐标={21,97}},       ------------------------------------碗子山传送大唐境外
                    [2] = {x=3,y=183.2,目标=1226,坐标={148,110}},    ------------------------------------碗子山传送宝象国
                    [3] = {x=69.7,y=12,目标=1229,坐标={13,16}},      ------------------------------------碗子山传送波月洞
            }
          elseif 地图 == 1229 then
                  return {x=7.8,y=11,目标=1228,坐标={64,19}}         ------------------------------------波月洞传送碗子山
          elseif 地图 == 1139 then
                  return{
                    [1] = {x=87,y=39.5,目标=1228,坐标={28,180}},     ------------------------------------无底洞传送碗子山
                    [2] = {x=60,y=116,目标=1156,坐标={9,48}},        ------------------------------------无底洞传送琉璃殿
            }
          elseif 地图 == 1156 then
                  return {x=5,y=49,目标=1139,坐标={59,122}}          ------------------------------------琉璃殿传送无底洞
          elseif 地图 == 1226 then
                  return{
                    [1] = {x=4,y=55,目标=1235,坐标={393,14}},        ------------------------------------宝象国传送丝绸之路
                    [2] = {x=4,y=10,目标=1227,坐标={69,49}},         ------------------------------------宝象国传送宝象国皇宫
                    [3] = {x=126,y=3,目标=1042,坐标={104,91}},       ------------------------------------宝象国传送解阳山
                    [4] = {x=4.75,y=113.3,目标=1210,坐标={54,139}},  ------------------------------------宝象国传送麒麟山
                    [5] = {x=153,y=112.3,目标=1228,坐标={9,184}},    ------------------------------------宝象国传送碗子山

           }
          elseif 地图 == 1227 then
                  return {x=72.5,y=51,目标=1226,坐标={8,15}}         ------------------------------------宝象国皇宫传送宝象国
          elseif 地图 == 1042 then
                  return{
                    [1] = {x=7,y=85.9,目标=1041,坐标={73,12}},       ------------------------------------解阳山传送子母河底
                    [2] = {x=113,y=90,目标=1226,坐标={122,8}},       ------------------------------------解阳山传送宝象国
            }
          elseif 地图 == 1041 then
                  return{
                    [1] = {x=72.5,y=4.5,目标=1042,坐标={13,90}},     ------------------------------------子母河底传送解阳山
                    [2] = {x=15.2,y=86.2,目标=1040,坐标={153,109}},  ------------------------------------子母河底传送西梁女国
            }
          elseif 地图 == 1040 then
                  return {x=156.4,y=111.1,目标=1041,坐标={19,85}}    ------------------------------------西梁女国传送子母河底
          elseif 地图 == 1210 then
                  return{
                    [1] = {x=16,y=17,目标=1211,坐标={52,90}},        ------------------------------------麒麟山传送太岁府
                    [2] = {x=181,y=139,目标=1208,坐标={7,13}},       ------------------------------------麒麟山传送朱紫国
            }
          elseif 地图 == 1211 then
                  return {x=57.5,y=91.3,目标=1210,坐标={23,24}}      ------------------------------------太岁府传送麒麟山
          elseif 地图 == 1235 then
                  return{
                    [1] = {x=214,y=6.5,目标=1242,坐标={74,195}},     ------------------------------------丝绸之路传送须弥东界
                    [2] = {x=348.4,y=92.5,目标=1232,坐标={10,26}},   ------------------------------------丝绸之路传送比丘国
                    [3] = {x=5,y=92,目标=1920,坐标={109,213}},       ------------------------------------丝绸之路传送凌云渡
                    [4] = {x=308,y=3,目标=1208,坐标={152,106}},      ------------------------------------丝绸之路传送朱紫国
                    [5] = {x=391,y=5,目标=1226,坐标={9,53}},         ------------------------------------丝绸之路传送宝象国
                    [6] = {x=596,y=9,目标=1091,坐标={28,138}},       ------------------------------------丝绸之路传长寿郊外

            }
          elseif 地图 == 1232 then
                  return{
                    [1] = {x=3,y=26,目标=1235,坐标={348,88}},        ------------------------------------比丘国传送丝绸之路
                    [2] = {x=36.5,y=3.5,目标=1233,坐标={17,101}},    ------------------------------------比丘国传送柳林坡
            }
          elseif 地图 == 1233 then
                  return{
                    [1] = {x=8,y=102,目标=1232,坐标={38,10}},        ------------------------------------柳林坡传送比丘国
                    [2] = {x=147,y=93,目标=1091,坐标={25,64}},       ------------------------------------柳林坡传送长寿郊外
            }
          elseif 地图 == 1208 then
                  return{
                    [1] = {x=5,y=115.5,目标=1173,坐标={11,46}},      ------------------------------------朱紫国传送大唐境外
                    [2] = {x=3,y=8,目标=1210,坐标={176,139}},        ------------------------------------朱紫国传送麒麟山
                    [3] = {x=148,y=20,目标=1209,坐标={30,56}},       ------------------------------------朱紫国传送朱紫国皇宫
                    [4] = {x=159,y=107,目标=1235,坐标={305,7}},      ------------------------------------朱紫国传送丝绸之路


            }
          elseif 地图 == 1209 then
                  return {x=23,y=61,目标=1208,坐标={143,25}}         ------------------------------------朱紫国皇宫传送朱紫国
          elseif 地图 == 1218 then
                  return{
                    [1] = {x=86,y=163,目标=1173,坐标={229,17}},      ------------------------------------墨家村传送大唐境外
                    [2] = {x=52,y=7,目标=1221,坐标={21,10}},         ------------------------------------墨家村传送墨家禁地
            }
          elseif 地图 == 1221 then
                  return {x=25,y=4,目标=1218,坐标={48,11}}           ------------------------------------墨家禁地传送墨家村
          elseif 地图 == 1203 then
                  return{
                    [1] = {x=104,y=235,目标=1173,坐标={16,25}},      ------------------------------------小西天传送大唐境外
                    [2] = {x=21,y=19,目标=1204,坐标={169,131}},      ------------------------------------小西天传送小雷音寺
            }
          elseif 地图 == 1204 then
                  return {x=174.4,y=133.4,目标=1203,坐标={26,23}}    ------------------------------------小雷音寺传送小西天
          elseif 地图 == 1201 then
                  return {x=40,y=111.5,目标=1174,坐标={20,21}}       ------------------------------------女娲神迹传送北俱芦洲
          elseif 地图 == 1242 then
                  return {x=82,y=196,目标=1235,坐标={214,14}}        ------------------------------------须弥东界传送丝绸之路
          elseif 地图 == 1920 then
                  return {x=114,y=218,目标=1235,坐标={12,91}}        ------------------------------------凌云渡传送丝绸之路
          elseif 地图 == 1209 then
                  return {x=23,y=61,目标=1208,坐标={143,25}}         ------------------------------------朱紫国皇宫传送朱紫国
          elseif 地图 == 1216 then
                  return {x=213,y=46,目标=1208,坐标={77,110}}        ------------------------------------仙缘洞天到朱紫国
          elseif 地图 == 1237 then
                  return {x=242,y=5,目标=1876,坐标={12,97}}          ------------------------------------四方城传送南岭山
          elseif 地图 == 1876 then
                  return{
                    [1] = {x=4,y=99,目标=1237,坐标={235,8}},         ------------------------------------南岭山传送四方城
                    [2] = {x=145,y=72,目标=1193,坐标={102,13}},      ------------------------------------南岭山传送江南野外
            }
          elseif 地图 == 1249 then
                  return{
                    [1] = {x=82,y=25,目标=1252,坐标={25,25}},        ------------------------------------女魃墓传送女魃墓室内
                    [2] = {x=2,y=74,目标=1126,坐标={102,13}},        ------------------------------------女魃墓传送东海岩洞
            }
          elseif 地图 == 1252 then
                  return {x=18,y=28,目标=1249,坐标={76,29}}          ------------------------------------女魃墓室内传送女魃墓
          elseif 地图 == 1250 then
                  return{
                    [1] = {x=137,y=38,目标=1253,坐标={52,130}},      ------------------------------------天机城传送天机堂
                    [2] = {x=17,y=140,目标=1173,坐标={102,13}},      ------------------------------------天机城传送大唐境外
            }
          elseif 地图 == 1253 then
                  return {x=44,y=133,目标=1250,坐标={132,42}}        ------------------------------------天机堂传送天机城
          end


end


function 地图处理类:取NPC数据(地图)
          if 地图 == 1003 then --桃园
              return {
                  -- [1]={名称="夏大叔",模型="男人_苦力",x=37,方向=3,y=85,执行事件="不执行",地图颜色=0},
                  -- [2]={名称="窑窑",模型="女人_绿儿",x=42,方向=2,y=88,执行事件="不执行",地图颜色=0},
                  -- [3]={名称="彤彤",模型="女人_绿儿",x=71,方向=0,y=87,执行事件="不执行",地图颜色=0},
                  -- [4]={名称="萍儿",模型="女人_赵姨娘",x=78,方向=1,y=87,执行事件="不执行",地图颜色=0 },
                  -- [5]={名称="桃源仙女",模型="普陀_接引仙女",x=115,方向=0,y=63,执行事件="不执行",地图颜色=0 },
                  -- [6]={名称="郭大哥",模型="男人_店小二",x=163,方向=0,y=73,执行事件="不执行",地图颜色=0 },
                  -- [7]={名称="狸",模型="狸",x=171,方向=1,y=79,执行事件="不执行",地图颜色=0 },
                  -- [8]={名称="狸",模型="狸",x=170,方向=1,y=70,执行事件="不执行",地图颜色=0 },
                  -- [9]={名称="狸",模型="狸",x=165,方向=0,y=85,执行事件="不执行",地图颜色=0 },
                  -- [10]={名称="谭村长",模型="男人_村长",x=163,方向=1,y=48,执行事件="不执行",地图颜色=0 },
                  -- [11]={名称="玄大夫",模型="男人_药店老板",x=137,方向=1,y=47,执行事件="不执行",地图颜色=0 },
                  -- [12]={名称="雨画师",模型="男人_老书生",x=126,方向=1,y=50,执行事件="不执行",地图颜色=0 },
                  -- [13]={名称="孙厨娘",模型="女人_染色师",x=108,方向=0,y=40,执行事件="不执行",地图颜色=0 },
                  -- [14]={名称="刘大婶",模型="女人_翠花",x=110,方向=0,y=21,执行事件="不执行",地图颜色=0 },
                  -- [15]={名称="小绿",模型="小毛头",x=123,方向=0,y=16,执行事件="不执行",地图颜色=0 },
                  -- [16]={名称="清清",模型="小丫丫",x=128,方向=1,y=14,执行事件="不执行",地图颜色=0 },
                  -- [17]={名称="孙猎户",模型="男人_铁匠",x=164,方向=3,y=18,执行事件="不执行",地图颜色=0 },
                  -- [18]={名称="野猪",模型="野猪",x=171,方向=1,y=14,执行事件="不执行",地图颜色=0 },
                  -- [19]={名称="霞姑娘",模型="女人_丫鬟",x=78,方向=2,y=25,执行事件="不执行",地图颜色=0 },
                  -- [20]={名称="新手接待师",模型="进阶芙蓉仙子",饰品=true,称谓="新手礼包",x=27,方向=1,y=27,执行事件="不执行",地图颜色=3 },
                    -- [21]={名称="狼宝宝",模型="神天兵",武器="狂澜碎岳",染色方案=9,染色组={3,3,3},称谓="→助战获取←",x=51,方向=4,y=9,执行事件="不执行",地图颜色=3 },
                }
          elseif 地图 == 1501 then
                  return {
                          [1] = {名称="宠物仙子",模型="普陀_接引仙女",x=62,y=29,方向=1,执行事件="不执行",地图颜色=0 },
                          [2] = {名称="戏班班主",模型="男人_老伯",x=84,y=31,方向=1,执行事件="不执行",地图颜色=0 },
                          [3] = {名称="吹牛王",模型="男人_苦力",x=88,y=38,方向=1,执行事件="不执行",地图颜色=0 },
                          [4] = {名称="奖励领取",称谓="推广奖励领取员",模型="普陀_接引仙女",x=75,y=42,方向=0,执行事件="不执行",地图颜色=0 },
                          [5] = {名称="飞儿",模型="小孩_飞儿",x=97,y=49,方向=1,执行事件="不执行",地图颜色=0 },
                          [6] = {名称="勾魂马面",模型="马面",x=97,y=12,方向=1,执行事件="不执行",地图颜色=0 },
                          [7] = {名称="王大嫂",模型="女人_王大嫂",x=139,y=14,方向=1,执行事件="不执行",地图颜色=0 },
                          [8] = {名称="海产收购商",模型="男人_钓鱼",x=232,y=13,方向=0,执行事件="不执行",地图颜色=0 },
                          [9] = {名称="老孙头",模型="男人_老孙头",x=224,y=10,方向=1,执行事件="不执行",地图颜色=0 },
                          [10] = {名称="陈长寿",模型="男人_药店老板",x=222,y=20,方向=0,执行事件="不执行",地图颜色=0 },
                          [11] = {名称="罗招弟",模型="小孩_飞儿",x=217,y=29,方向=1,执行事件="不执行",地图颜色=0 },
                          [12] = {名称="牛大胆",模型="男人_道士",x=230,y=38,方向=1,执行事件="不执行",地图颜色=0 },
                          [13] = {名称="装备收购商",模型="男人_苦力",x=238,y=24,方向=1,执行事件="不执行",地图颜色=0 },
                          [14] = {名称="装备鉴定商",模型="男人_苦力",x=243,y=28,方向=1,执行事件="不执行",地图颜色=0 },
                          [15] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=214,y=44,方向=1,执行事件="不执行",地图颜色=0 },
                          [16] = {名称="赵元宝",模型="男人_老伯",x=227,y=79,方向=0,执行事件="不执行",地图颜色=0 },
                          [17] = {名称="小花",模型="普陀_接引仙女",x=204,y=106,方向=0,执行事件="不执行",地图颜色=0 },
                          [18] = {名称="赵捕头",模型="男人_衙役",称谓="新手任务",x=115,y=80,方向=1,执行事件="不执行",地图颜色=0 },
                          [19] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=107,y=87,方向=0,执行事件="不执行",地图颜色=0 },
                          [20] = {名称="张来福",模型="男人_镖头",x=87,y=71,方向=0,执行事件="不执行",地图颜色=0 },
                          [21] = {名称="建邺特产商人",模型="男人_特产商人",x=84,y=77,方向=0,执行事件="不执行",地图颜色=0 },
                          [22] = {名称="马全有",模型="男人_武器店老板",x=49,y=89,方向=1,执行事件="不执行",地图颜色=0 },
                          [23] = {名称="迎客僧",模型="男人_胖和尚",x=10,y=89,方向=0,执行事件="不执行",地图颜色=0 },
                          [24] = {名称="管家",模型="男人_店小二",x=42,y=64,方向=1,执行事件="不执行",地图颜色=0 },
                          [25] = {名称="符全",模型="男人_兰虎",x=18,y=54,方向=0,执行事件="不执行",地图颜色=0 },
                          [26] = {名称="建邺守卫",称谓="传送江南野外",模型="男人_衙役",x=18,y=137,方向=1,执行事件="不执行",地图颜色=0 },
                          [27] = {名称="雷黑子",模型="小孩_雷黑子",x=70,y=133,方向=1,执行事件="不执行",地图颜色=0 },
                          [28] = {名称="教书先生",模型="男人_书生",x=77,y=54,方向=1,执行事件="不执行",地图颜色=0 },
                          [29] = {名称="仓库管理员",模型="仓库保管员",x=52,y=112,方向=0,执行事件="不执行",地图颜色=0},
                            --[30] = {名称="梨园小贩",模型="小孩_飞儿",称谓="建业密探任务",x=49,y=12,方向=1,执行事件="不执行",地图颜色=2},
                            --[31] = {名称="技能指导师",模型="男人_武器店老板",x=73,y=61,方向=1,执行事件="不执行",地图颜色=0},
                            --[32] = {名称="好友推荐人",模型="女人_绿儿",x=202,y=89,方向=0,执行事件="不执行",地图颜色=3},
                            --[33] = {名称="仙族使者",模型="女人_万圣公主",x=190,y=111,方向=1,执行事件="不执行",地图颜色=3},
                            -- [34] = {名称="魔族使者",模型="二大王",x=201,y=116,方向=1,执行事件="不执行",地图颜色=3},
                            --[35] = {名称="人族使者",模型="程咬金",x=181,y=115,方向=0,执行事件="不执行",地图颜色=3},
                            --[36] = {名称="大唐驿使",模型="男人_马副将",x=275,y=73,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3},
                            --[37] = {名称="老胡",模型="男人_店小二",x=54,y=110,方向=0,执行事件="不执行",地图颜色=0},
                            --[38] = {名称="刘老爹",模型="男人_村长",x=32,y=111,方向=0,执行事件="不执行",地图颜色=0},
                            --[39] = {名称="梦幻新手指引",模型="花妖",x=19,y=132,方向=0,执行事件="不执行",地图颜色=3},
                            --[40] = {名称="新手指引",模型="花妖",x=239,y=15,方向=1,执行事件="不执行",地图颜色=0},
                  }
          elseif 地图 == 1525 then
                  return {名称="小宝箱",模型="宝箱",x=19,y=20,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1127 then
                  return {名称="幽冥鬼",模型="巡游天神",x=52,y=31,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1193 then
                  return {
                          [1] = {名称="罗纤纤",模型="女人_丫鬟",x=25,y=29,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="江湖奸商",模型="仓库保管员",x=102,y=23,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="卵二姐",模型="女人_丫鬟",x=23,y=99,方向=1,执行事件="不执行",地图颜色=0},
                          [4] = {名称="樵夫",模型="樵夫",x=134,y=96,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1129 then
                  return {名称="无名野鬼",模型="野鬼",x=64,y=26,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1103 then
                  return {名称="美猴王",模型="孙悟空",称谓="剧情技能",x=62,y=34,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1505 then
                  return {名称="杂货店老板",模型="男人_巫医",x=35,y=26,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1202 then
                  return {名称="小宝箱",模型="宝箱",x=127,y=17,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 ==1208 then
                  return {
                          [1] = {名称="朱紫校尉",模型="校尉",x=138,y=21,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="药店伙计",模型="男人_苦力",x=125,y=97,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="紫阳药师",模型="男人_药店老板",x=144,y=82,方向=2,执行事件="不执行",地图颜色=0},
                          [4] = {名称="端木娘子",模型="女人_栗栗娘",x=97,y=113,方向=1,执行事件="不执行",地图颜色=0},
                          [5] = {名称="朱紫侍卫",模型="校尉",x=21,y=115,方向=1,执行事件="不执行",地图颜色=0},
                          [6] = {名称="朱紫侍卫",模型="校尉",x=7,y=109,方向=1,执行事件="不执行",地图颜色=0},
                          [7] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=9,y=31,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="申太公",模型="男人_村长",x=76,y=105,方向=1,执行事件="不执行",地图颜色=0},
                          [9] = {名称="妖魔亲信",模型="蝴蝶仙子",x=104,y=10,方向=1,变异=true,执行事件="不执行",地图颜色=5},
                          [10] = {名称="土地公公",模型="男人_土地",x=21,y=25,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 ==1040 then
                  return {
                          [1] = {名称="西梁女兵",模型="女兵",x=129,y=104,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="西梁女兵",模型="女兵",x=141,y=99,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="西梁女兵",模型="女兵",x=73,y=107,方向=2,执行事件="不执行",地图颜色=0},
                          [4] = {名称="西梁女兵",模型="女兵",x=67,y=110,方向=2,执行事件="不执行",地图颜色=0},
                          [5] = {名称="驿站老板",称谓="传送朱紫国",模型="男人_驿站老板",x=18,y=71,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="驿站老板",称谓="传送丝绸之路",模型="男人_驿站老板",x=15,y=114,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="二郎神",称谓="渡劫使者",模型="二郎神",x=30,y=17,方向=0,执行事件="不执行",地图颜色=5},
                          [8] = {名称="超凡入圣",称谓="入圣使者",模型="九头精怪",x=19,y=20,方向=0,执行事件="不执行",地图颜色=5},
                          [9] = {名称="九生九死",模型="孙悟空",x=86,y=64,方向=0,执行事件="不执行",地图颜色=5},
                        --[7] = {名称="周某伦",称谓="剧情大师",模型="周杰伦",x=85,y=62,方向=0,执行事件="不执行",地图颜色=5},
                        --[8] = {名称="西凉国王",称谓="69级突破战斗",模型="春十三娘",x=21,y=18,方向=0,执行事件="不执行",地图颜色=5},
                    }
          elseif 地图 == 1215 then
                  return {名称="蜃妖元神",称谓="",模型="炎魔神",x=52,y=32,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1216 then
                  return {
                          [1] = {名称="召唤师",称谓="召唤兽进阶",模型="护卫",x=151,y=59,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="百兽王",称谓="坐骑任务",模型="大大王",x=24,y=84,方向=0,执行事件="不执行",地图颜色=5},
                        --[3] = {名称="桃园仙翁",称谓="坐骑饰品",模型="南极仙翁",x=67,y=94,方向=0,执行事件="不执行",地图颜色=2},
                        --[4] = {名称="仙缘染坊主",称谓="坐骑染色",模型="女人_赵姨娘",x=121,y=61,方向=0,执行事件="不执行",地图颜色=2},
                    }
          elseif 地图 == 1209 then
                  return {
                        --[1] = {名称="朱紫国国王",模型="宝象国国王",x=65,y=39,方向=1,执行事件="不执行",地图颜色=0},
                        --[2] = {名称="阿米国师",模型="小西天和尚",x=53,y=38,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1226 then
                  return {
                          [1] =  {名称="驿站老板",称谓="传送长安城",模型="男人_驿站老板",x=143,y=27,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="镖局学童",模型="男人_店小二",x=54,y=14,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="土地公公",称谓="宝藏山传送员",模型="男人_土地",x=119,y=16,方向=2,执行事件="不执行",地图颜色=0},
                        --[4] = {名称="北斗星君",称谓="玲珑石任务",模型="太白金星",x=103,y=40,方向=1,执行事件="不执行",地图颜色=5},
                        --[5] = {名称="仓库管理员",模型="仓库管理员",x=110,y=44,方向=1,执行事件="不执行",地图颜色=3},
                          [4] = {名称="药店老板",模型="男人_药店老板",x=148,y=67,方向=1,执行事件="不执行",地图颜色=2},
                        --[7] = {名称="花店老板",模型="金圣宫",x=117,y=77,方向=0,执行事件="不执行",地图颜色=0},
                        --[8] = {名称="香料店老板",模型="金圣宫",x=69,y=64,方向=0,执行事件="不执行",地图颜色=0},
                        --[9] = {名称="小木匠",模型="小木匠",x=69,y=68,方向=0,执行事件="不执行",地图颜色=0},
                        --[10] = {名称="武器大师",模型="男人_武器店老板",x=71,y=67,方向=0,执行事件="不执行",地图颜色=0},
                        --[11] = {名称="逍遥游侠",模型="小白龙",x=74,y=65,方向=0,执行事件="不执行",地图颜色=0},
                        --[12] = {名称="霓裳姑娘",模型="灵鼠娃娃",x=43,y=80,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 5001 then
                  return {名称="土地公公",称谓="传送至宝象国",模型="男人_土地",x=76,y=24,方向=2,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1537 then
                  return {
                          [1] = {名称="建邺县令",模型="男人_老书生",x=43,y=17,方向=1,执行事件="不执行",地图颜色=0},
                       -- [1] = {名称="贸易车队总管",模型="男人_老财",x=12,y=28,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="衙役",模型="男人_衙役",x=17,y=24,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="衙役",模型="男人_衙役",x=26,y=20,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="衙役",模型="男人_衙役",x=26,y=29,方向=2,执行事件="不执行",地图颜色=0},
                          [5] = {名称="衙役",模型="男人_衙役",x=33,y=25,方向=2,执行事件="不执行",地图颜色=0},
                          [6] = {名称="简师爷",模型="男人_师爷",x=30,y=19,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1523 then
                  return {名称="当铺老板",模型="男人_特产商人",x=28,y=23,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1502 then
                  return {
                          [1] = {名称="武器店老板",模型="男人_武器店老板",x=22,y=18,方向=1,执行事件="不执行",地图颜色=0},
                          [2]  = {名称="武器店掌柜",模型="男人_老孙头",x=15,y=18,方向=0,执行事件="不执行",地图颜色=0},
                      --  [3]  = {名称="打铁炉",模型="物件_打铁炉",x=19,y=24,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1503 then
                  return {
                          [1] = {名称="服装店老板",模型="男人_服装店老板",x=24,y=23,方向=1,执行事件="不执行",地图颜色=0},
                       -- [2] = {名称="缝纫台",模型="物件_缝纫台",x=28,y=23,方向=1,执行事件="不执行",地图颜色=0},0},
                    }
          elseif 地图 == 1504 then
                  return {名称="药店老板",模型="男人_药店老板",x=28,y=20,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1526 then
                  return {名称="周猎户",模型="男人_兰虎",x=20,y=25,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1524 then
                  return {名称="钱庄老板",模型="男人_财主",x=36,y=23,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1534 then
                  return {名称="李善人",模型="男人_老财",x=21,y=29,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1506 then  -- 东海湾
                  return {
                          [1] = {名称="船夫",称谓="传送傲来国",模型="男人_驿站老板",x=55,y=112,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="云游神医",模型="男人_药店老板",x=75,y=109,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="超级巫医",模型="男人_巫医",x=101,y=104,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="林老汉",称谓="传送东海岩洞",模型="男人_村长",x=91,y=81,方向=1,执行事件="不执行",地图颜色=0},
                          [5] = {名称="老虾",称谓="传送龙宫",模型="虾兵",x=115,y=29,方向=2,执行事件="不执行",地图颜色=0},
                          [6] = {名称="楚恋依",模型="普陀_接引仙女",x=58,y=35,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="海盗头子",模型="强盗",x=18,y=102,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="牛二",模型="男人_老伯",x=59,y=70,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="玉面公主",模型="狐狸精",x=88,y=11,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1110 then   -- 国境
                  return {
                          [1] = {名称="大唐国境土地",称谓="传送凌波城",模型="男人_土地",x=177,y=74,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="普陀山接引仙女",称谓="传送普陀山",模型="普陀_接引仙女",x=229,y=269,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="小二",模型="男人_店小二",x=68,y=268,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="驿站老板",称谓="传送长安城",模型="男人_驿站老板",x=86,y=86,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=35,y=257,方向=1,执行事件="不执行",地图颜色=0},
                          [6] = {名称="者释和尚",模型="男人_胖和尚",x=174,y=248,方向=1,执行事件="不执行",地图颜色=0},
                          [7] = {名称="业释和尚",模型="男人_胖和尚",x=186,y=184,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="海释和尚",模型="男人_胖和尚",x=139,y=157,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="白琉璃",模型="星灵仙子",x=27,y=176,方向=0,执行事件="不执行",地图颜色=0},
                          [10] = {名称="山神",模型="雨师",x=43,y=98,方向=1,执行事件="不执行",地图颜色=0},
                          [11] = {名称="虾兵",模型="虾兵",x=241,y=76,方向=0,执行事件="不执行",地图颜色=0},
                          [12] = {名称="吴老爹",模型="男人_村长",x=312,y=82,方向=0,执行事件="不执行",地图颜色=0},
                          [13] = {名称="小芸芸",模型="女人_丫鬟",x=169,y=33,方向=0,执行事件="不执行",地图颜色=0},
                          [14] = {名称="吴文彩",模型="男人_书生",x=306,y=116,方向=0,执行事件="不执行",地图颜色=0},
                          [15] = {名称="婆婆",模型="女人_孟婆",x=35,y=310,方向=0,执行事件="不执行",地图颜色=0},
                          [16] = {名称="文秀",模型="女人_丫鬟",x=238,y=54,方向=0,执行事件="不执行",地图颜色=0},
                          [17] = {名称="衙役",模型="男人_衙役",x=314,y=37,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1153 then
                  return {
                          [1] = {名称="酒肉和尚",称谓="剧情战斗",模型="雨师",x=38,y=20,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="玄奘",称谓="金蝉子",模型="唐僧",x=13,y=21,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1168 then
                  return {
                          [1] = {名称="刘洪",模型="护卫",x=38,y=20,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="殷温娇",模型="陈妈妈",x=13,y=21,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="江州县令",模型="男人_老书生",x=27,y=21,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1150 then -- 凌波城
                  return {
                          [1] = {名称="二郎神",称谓="门派师傅",模型="二郎神",x=68,y=32,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="哮天犬",模型="哮天犬",x=77,y=36,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="守门天将",模型="天兵",x=6,y=88,方向=1,执行事件="不执行",地图颜色=0},
                          [4] = {名称="守门天将",模型="天兵",x=15,y=93.5,方向=1,执行事件="不执行",地图颜色=0},
                          [5] = {名称="传送天将",称谓="传送长安",模型="天兵",x=44,y=57,方向=1,执行事件="不执行",地图颜色=0},
                          [6] = {名称="破碎星",模型="百足将军",x=26.5,y=55.5,方向=1,执行事件="不执行",地图颜色=0},
                      -- [12] = {名称="荀卿",称谓="凌波城少主",模型="剑侠客",武器="擒龙",x=49,y=65,方向=4,染色方案=2,染色组={3,3,4},执行事件="不执行",地图颜色=0},
                          [7] = {名称="荒芜星",模型="狂豹人形",x=23,y=117,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="刀砧星",模型="鲛人",x=29,y=141,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="反吟星",模型="羊头怪",x=54,y=137,方向=1,执行事件="不执行",地图颜色=0},
                          [10] = {名称="天瘟星",模型="犀牛将军人形",x=93,y=104,方向=1,执行事件="不执行",地图颜色=0},
                          [11] = {名称="伏断星",模型="野猪精",x=100,y=48,方向=0,执行事件="不执行",地图颜色=0},
                          [12] = {名称="凌波城护法",模型="羽灵神",武器="庄周梦蝶",x=44,y=79,方向=1,执行事件="不执行",地图颜色=0},
                          [13] = {名称="羽灵神",称谓="首席弟子",模型="羽灵神",武器="碧海潮生",门派="凌波城",x=34,y=68,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},},
                    }
          elseif 地图 == 1140 then -- 普陀山
                  return {
                          [1] = {名称="接引仙女",称谓="传送长安",模型="普陀_接引仙女",x=8,y=9,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="龙女宝宝",模型="小龙女",x=23,y=29,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="黑熊怪",模型="黑熊精",x=24,y=47,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="普陀山护法",模型="玄彩娥",武器="青藤玉树",x=70,y=50,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="玄彩娥",称谓="首席弟子",模型="玄彩娥",武器="丝萝乔木",门派="普陀山",x=22,y=21,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0}
                    }
          elseif 地图 == 1141 then -- 潮音洞
                  return {
                          [1] = {名称="观音姐姐",称谓="门派师傅",模型="观音姐姐",x=12.5,y=11.5,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="青莲仙女",模型="普陀_接引仙女",x=25,y=33,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1122 then -- 地府
                  return {
                          [1] = {名称="钟馗",称谓="捉鬼任务",模型="男人_钟馗",x=63,y=60,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="马面",模型="马面",x=10,y=87,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="追梦鬼",模型="兔子怪",x=10,y=104,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="地遁鬼",称谓="传送长安",模型="僵尸",x=27.5,y=63.5,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="孟婆",模型="女人_孟婆",x=99.5,y=94.5,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="地府商人",模型="男人_特产商人",x=83,y=108,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="地府货商",模型="男人_老财",x=68,y=73,方向=1,执行事件="不执行",地图颜色=0},
                          [8] = {名称="阴曹地府护法",模型="骨精灵",武器="九阴勾魂",x=62,y=79,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="骨精灵",称谓="首席弟子",模型="骨精灵",武器="忘川三途",门派="阴曹地府",x=41,y=63,方向=0,执行事件="不执行",地图颜色=0},
                            ---染色方案=10,染色组={3,3,4},
                            --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},,
                    }
          elseif 地图 == 1123 then --森罗 3.4 2
                  return {
                          [1] = {名称="判官",模型="男人_判官",x=18,y=20,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="阎罗王",模型="阎罗王",x=22.2,y=26.5,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="转轮王",模型="阎罗王",x=25.6,y=28.5,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="秦广王",模型="阎罗王",x=29,y=30.5,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="初江王",模型="阎罗王",x=32.4,y=32.5,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="宋帝王",模型="阎罗王",x=35.8,y=34.5,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="卞城王",模型="阎罗王",x=31.7,y=21.7,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="平等王",模型="阎罗王",x=35.1,y=23.7,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="泰山王",模型="阎罗王",x=38.5,y=25.7,方向=0,执行事件="不执行",地图颜色=0},
                          [10] = {名称="都市王",模型="阎罗王",x=41.9,y=27.7,方向=0,执行事件="不执行",地图颜色=0},
                          [11] = {名称="忤官王",模型="阎罗王",x=45.3,y=29.7,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1125 then  -- 地藏王府
                  return {
                          [1] = {名称="白无常",模型="白无常",称谓="传送长安",x=20,y=23,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="黑无常",模型="黑无常",称谓="鬼王任务",x=37,y=22,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1124 then
                  return {名称="地藏王",称谓="门派师傅",模型="地藏王",x=32,y=22,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1116 then  -- 龙宫
                  return {
                          [1] = {名称="虾兵",称谓="传送东海湾",模型="虾兵",x=24,y=97,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="蟹将军",模型="蟹将",x=32,y=100,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="虾兵",模型="虾兵",x=40,y=104,方向=1,执行事件="不执行",地图颜色=0},
                          [4] = {名称="传送蟹将",称谓="传送长安",模型="蟹将",x=108,y=60,方向=1,执行事件="不执行",地图颜色=0},
                          [5] = {名称="龟千岁",模型="龟丞相",x=99,y=57,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="小龙女",模型="小龙女",x=96,y=49,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="虾兵",模型="虾兵",x=47,y=21,方向=2,执行事件="不执行",地图颜色=0},
                          [8] = {名称="龟太尉",模型="龟丞相",x=53,y=16,方向=2,执行事件="不执行",地图颜色=0},
                          [9] = {名称="虾兵",模型="虾兵",x=62,y=14,方向=2,执行事件="不执行",地图颜色=0},
                          [10] = {名称="虾兵",模型="虾兵",x=188,y=12,方向=3,执行事件="不执行",地图颜色=0},
                          [11] = {名称="蛤蟆勇士",模型="蛤蟆精",x=195,y=16,方向=3,执行事件="不执行",地图颜色=0},
                          [12] = {名称="虾兵",模型="虾兵",x=203,y=20,方向=3,执行事件="不执行",地图颜色=0},
                          [13] = {名称="虾兵",模型="虾兵",x=188,y=92,方向=0,执行事件="不执行",地图颜色=0},
                          [14] = {名称="虾将军",模型="虾兵",x=195,y=88,方向=0,执行事件="不执行",地图颜色=0},
                          [15] = {名称="虾兵",模型="虾兵",x=203,y=84,方向=0,执行事件="不执行",地图颜色=0},
                          [16] = {名称="万圣公主",模型="女人_万圣公主",x=18,y=50,方向=1,执行事件="不执行",地图颜色=0},
                          [17] = {名称="龙宫护法",模型="龙太子",武器="飞龙在天",x=71,y=78,方向=1,执行事件="不执行",地图颜色=0},
                          [18] = {名称="龙太子",称谓="首席弟子",模型="龙太子",武器="天龙破城",门派="龙宫",x=94,y=68,方向=1,执行事件="不执行",地图颜色=0},
                            ---染色方案=10,染色组={3,3,4},
                            --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                                -- [17] = {名称="小白龙",模型="男人_小白龙",x=81,y=60,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1117 then  -- 水晶宫
                  return {名称="东海龙王",称谓="门派师傅",模型="东海龙王",x=39,y=25,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1507 then  -- 海底
                  return {
                          [1] = {名称="螃蟹精",称谓="传送建邺城",模型="蟹将",x=34,y=31,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="蛤蟆精",模型="蛤蟆精",x=50,y=29,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1514 then  -- 花果山
                  return {
                          [1] = {名称="老马猴",称谓="法术认证",模型="马猴",x=42,y=75,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="猴医仙",模型="长眉灵猴",x=135,y=36,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="老猕猴",称谓="潜能果兑换",模型="马猴",x=44,y=14,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1174 then  -- 北俱芦洲
                  return {
                          [1] = {名称="地遁鬼",模型="兔子怪",称谓="传送长寿郊外",x=195,y=163,方向=2,执行事件="不执行",地图颜色=0},
                          [2] = {名称="女娲神迹传送人",模型="净瓶女娲",称谓="传送女娲神迹",x=13,y=17,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="青琉璃",模型="星灵仙子",x=202,y=35,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="超级巫医",模型="男人_巫医",x=29,y=105,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="龙女妹妹",模型="小龙女",x=138,y=71,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="莽汉",模型="山贼",x=38,y=129,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="北俱商人",模型="男人_特产商人",x=148,y=145,方向=1,执行事件="不执行",地图颜色=0},
                          [8] = {名称="北俱货商",模型="男人_老财",x=198,y=91,方向=1,执行事件="不执行",地图颜色=0},
                          [9] = {名称="驿站老板",称谓="传送长安城",模型="男人_驿站老板",x=93,y=76,方向=0,执行事件="不执行",地图颜色=0},
                          [10] = {名称="雷鸟精",模型="雷鸟人",x=63,y=29,方向=0,执行事件="不执行",地图颜色=0},
                          [11] = {名称="白熊怪",模型="白熊",x=108,y=117,方向=0,执行事件="不执行",地图颜色=0},
                          [12] = {名称="翻天怪",模型="地狱战神",x=181,y=137,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1091 then  -- 长寿郊外
                  return {
                          [1] = {名称="驿站老板",模型="男人_驿站老板",称谓="传送北俱芦洲",x=68,y=88,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="传送天将",模型="男人_将军",称谓="传送天宫",x=22,y=112,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [3] = {名称="西牛贺洲土地",模型="男人_土地",称谓="传送大唐境外",x=90,y=158,方向=2,执行事件="不执行",地图颜色=0},
                          [4] = {名称="鬼谷道人",模型="男人_道士",称谓="降妖除魔",x=133,y=86,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="路人甲",模型="赌徒",x=174,y=119,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1135 then  -- 方寸
                  return {
                          [1] = {名称="接引道童",称谓="传送长安",模型="男人_道童",x=118,y=30,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="觉明",模型="男人_道士",x=62,y=118,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="灵儿",模型="女人_丫鬟",x=50,y=92,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="觉岸",模型="男人_道士",称谓="剧情技能",x=108,y=43,方向=3,执行事件="不执行",地图颜色=0},
                          [5] = {名称="方寸山护法",模型="飞燕女",武器="九天金线",x=46,y=125,方向=1,执行事件="不执行",地图颜色=0},
                          [6] = {名称="偃无师",称谓="首席弟子",模型="偃无师",武器="秋水澄流",门派="方寸山",x=67,y=66,方向=1,执行事件="不执行",地图颜色=0},
                            ---染色方案=10,染色组={3,3,4},
                            --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1173 then  -- 境外
                  return {
                          [1] = {名称="南瞻部洲土地",模型="男人_土地",称谓="传送西牛贺洲",x=44,y=102,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="驿站老板",模型="男人_驿站老板",称谓="传送碗子山",x=13,y=95,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=50,y=49,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="山贼头子",模型="山贼",x=94,y=15,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="牛将军",模型="牛妖",x=79,y=43,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="驿站老板",模型="男人_驿站老板",称谓="传送长安城",x=205,y=93,方向=1,执行事件="不执行",地图颜色=0},
                          [7] = {名称="白衣人",模型="逍遥生",x=234,y=110,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="阿紫",模型="星灵仙子",x=319,y=47,方向=3,执行事件="不执行",地图颜色=0},
                          [9] = {名称="姚太尉",模型="天兵",x=324,y=44,方向=1,执行事件="不执行",地图颜色=0},
                          [10] = {名称="云游僧",模型="空度禅师",x=350,y=89,方向=0,执行事件="不执行",地图颜色=0},
                          [11] = {名称="白鹿精",模型="赌徒",x=354,y=111,方向=2,执行事件="不执行",地图颜色=0},
                          [12] = {名称="玉面狐狸",模型="狐狸精",x=349,y=110,方向=0,执行事件="不执行",地图颜色=0},
                          [13] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=409,y=108,方向=1,执行事件="不执行",地图颜色=0},
                          [14] = {名称="野猪王",模型="野猪",x=480,y=113,方向=0,执行事件="不执行",地图颜色=0},
                          [15] = {名称="偷尸鬼",模型="骷髅怪",x=579,y=98,方向=1,执行事件="不执行",地图颜色=0},
                          [16] = {名称="李彪",模型="强盗",x=588,y=101,方向=0,执行事件="不执行",地图颜色=0},
                          [17] = {名称="刘洪",模型="男人_马副将",x=591,y=104,方向=2,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [18] = {名称="强盗头子",模型="强盗",称谓="剧情技能",x=562,y=33,方向=0,执行事件="不执行",地图颜色=0},
                          [19] = {名称="冤魂",模型="僵尸",x=603,y=19,方向=1,执行事件="不执行",地图颜色=0},
                          [20] = {名称="至尊宝",模型="至尊宝",x=161,y=59,方向=1,执行事件="不执行",地图颜色=0},
                          [21] = {名称="天兵飞剑",模型="天兵",x=246,y=56,方向=1,执行事件="不执行",地图颜色=0},
                          [22] = {名称="卷帘大将",模型="沙僧",x=237,y=64,方向=0,执行事件="不执行",地图颜色=0},
                          [23] = {名称="天蓬元帅",模型="猪八戒",x=396,y=71,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1508 then  -- 沉船
                  return {
                          [1] = {名称="虾精",称谓="传送建邺城",模型="虾兵",x=17,y=16,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="妖风",模型="吸血鬼",x=55,y=31,染色方案=96,染色组={1,1},方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1509 then
                  return {名称="商人的鬼魂",模型="野鬼",x=23,y=27,方向=2,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1001 then  -- 长安
                  return {
                          [1] = {名称="长安导游",模型="男人_书生",x=463,y=262,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="王夫人",模型="女人_王大嫂",x=393,y=231,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="商会总管",模型="仓库保管员",x=329,y=265,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="陈员外",模型="仓库保管员",x=176,y=249,方向=1,执行事件="不执行",地图颜色=0},
                          [5] = {名称="花香香",模型="普陀_接引仙女",x=301,y=256,方向=1,执行事件="不执行",地图颜色=0},
                          [6] = {名称="老花农",模型="男人_村长",x=289,y=249,方向=1,执行事件="不执行",地图颜色=0},
                          [7] = {名称="罗道人",模型="男人_道士",x=258,y=243,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="染色师",模型="女人_染色师",x=290,y=264,方向=0,执行事件="不执行",地图颜色=0},
                          [9] = {名称="驿站老板",称谓="传送大唐国境",模型="男人_驿站老板",x=274,y=238,方向=0,执行事件="不执行",地图颜色=0},
                          [10] = {名称="张老财",模型="男人_老财",x=247,y=253,方向=0,执行事件="不执行",地图颜色=0},
                          [11] ={名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=526,y=95,方向=1,执行事件="不执行",地图颜色=0},
                          [12] = {名称="门派传送人",模型="男人_镖头",x=478,y=246.8,方向=1,执行事件="不执行",地图颜色=0},
                          [13] = {名称="圣山传送人",模型="男人_太上老君",x=350.5,y=205,方向=1,执行事件="不执行",地图颜色=0},
                          [14] = {名称="门派闯关使者",称谓="十五门派闯关活动使者",模型="男人_马副将",显示饰品=true,x=128,y=90,方向=0,执行事件="不执行",地图颜色=0},
                          [15] = {名称="刘副将",模型="男人_马副将",x=147,y=176,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [16] = {名称="兰虎",模型="男人_兰虎",称谓="剧情技能",x=432,y=172,方向=1,执行事件="不执行",地图颜色=0},
                          [17] = {名称="马副将",模型="男人_马副将",称谓="双倍经验",x=197,y=108,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [18] = {名称="御林军",模型="男人_马副将",称谓="精修经验",x=211,y=106,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [19] = {名称="皇宫护卫",称谓="赏金任务",模型="护卫",x=240,y=107,方向=1,执行事件="不执行",地图颜色=0},
                          [20] = {名称="礼部侍郎",称谓="科举大赛",模型="考官2",x=280,y=95,方向=0,执行事件="不执行",地图颜色=0},
                          [21] = {名称="袁天罡",模型="袁天罡",称谓="全功能服务",x=358,y=35,方向=0,执行事件="不执行",地图颜色=0},
                          [22] = {名称="李将军",模型="男人_马副将",称谓="官职任务",x=145,y=84,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [23] = {名称="五行大师",模型="五行大师",称谓="点化套装",x=355,y=160,方向=0,执行事件="不执行",地图颜色=0},
                          [24] = {名称="杜少海",模型="男人_店小二",称谓="初出江湖",x=231,y=104,方向=0,执行事件="不执行",地图颜色=0},
                          [25] = {名称="御林军左统领",模型="护卫",称谓="皇宫飞贼",x=101,y=65,方向=0,执行事件="不执行",地图颜色=0},
                          [26] = {名称="御林军右统领",模型="护卫",x=110,y=49,方向=0,执行事件="不执行",地图颜色=0},
                          [27] = {名称="长安珍品商人",模型="珍品商人",x=193,y=261,方向=1,执行事件="不执行",地图颜色=0},
                          [28] = {名称="装备收购商",模型="男人_苦力",x=419,y=47,方向=1,执行事件="不执行",地图颜色=5},
                          [29] = {名称="装备鉴定商",模型="男人_苦力",x=429,y=51,方向=1,执行事件="不执行",地图颜色=5},
                          [30] = {名称="仓库管理员",模型="仓库保管员",x=449,y=107,方向=0,执行事件="不执行",地图颜色=5},
                          [31] = {名称="符石道人",模型="男人_道童",x=490,y=203,方向=1,执行事件="不执行",地图颜色=5},
                          [32] = {名称="帮派管理员",模型="男人_兰虎",称谓="帮派业务",x=382,y=17,方向=0,执行事件="不执行",地图颜色=0},
                          [33] = {名称="长安商人",模型="男人_特产商人",x=275,y=166,方向=3,执行事件="不执行",地图颜色=0},
                          [34] = {名称="长安货商",模型="男人_老财",x=383,y=120,方向=1,执行事件="不执行",地图颜色=0},
                          [35] = {名称="袁守城",模型="男人_太上老君",x=181,y=263,方向=1,执行事件="不执行",地图颜色=0},
                          [36] = {名称="龙孙",模型="男人_小白龙",x=176,y=267,方向=3,执行事件="不执行",地图颜色=0},
                          [37] = {名称="建房吏",模型="男人_衙役",称谓="房屋建设",x=26,y=213,方向=0,执行事件="不执行",地图颜色=2},
                          [38] = {名称="效果取消熊猫",模型="召唤兽造型进阶",称谓="效果取消师",x=238,y=128,方向=1,执行事件="不执行",地图颜色=2},
                          [39] = {名称="宝石商人",模型="男人_老财",x=497,y=140,方向=1,执行事件="不执行",地图颜色=2},
                          [40] = {名称="相府守卫",模型="护卫",x=177,y=171,方向=0,执行事件="不执行",地图颜色=0},
                          [41] = {名称="相府守卫",模型="护卫",x=195,y=162,方向=0,执行事件="不执行",地图颜色=0},
                          [42] = {名称="节日礼物使者",模型="兔子怪",x=206,y=153,方向=0,执行事件="不执行",地图颜色=3},
                          [43] = {名称="房都尉",模型="男人_马副将",x=375,y=206,方向=0,显示饰品=true,执行事件="不执行",地图颜色=5},
                          [44] = {名称="怜儿姑娘",模型="女人_丫鬟",x=259,y=184,方向=0,执行事件="不执行",地图颜色=0},
                          [45] = {名称="小宝",模型="小孩_飞儿",x=314,y=147,方向=0,执行事件="不执行",地图颜色=0},
                          [46] = {名称="剑会天下主持人",模型="男人_马副将",称谓="剑会天下",x=193,y=114,方向=0,执行事件="不执行",地图颜色=3},
                          [47] = {名称="比武大会主持人",称谓="英雄会比武PVP活动",模型="男人_将军",x=110,y=167,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3},
                          [48] = {名称="月老",称谓="月下老人",模型="男人_太上老君",x=422,y=134,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3},
                          [49] = {名称="轿夫",称谓="家园传送人",模型="男人_兰虎",x=519,y=151,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3},
                          [50] = {名称="召唤兽进阶熊猫",称谓="召唤兽造型师",模型="召唤兽造型进阶",显示饰品=true,x=246,y=124,方向=1,执行事件="不执行",地图颜色=0},
                          [51] = {名称="国子监祭酒",称谓="师徒关系",模型="考官2",x=301,y=91,方向=0,执行事件="不执行",地图颜色=0},
                          [52] = {名称="殷丞相",模型="考官2",x=165,y=143,方向=0,执行事件="不执行",地图颜色=0},
                          [53] = {名称="镇塔童子",模型="毗舍童子",称谓="挑战镇妖塔",显示饰品=true,x=441,方向=1,y=31,执行事件="不执行",地图颜色=3},
                          [54] = {名称="福禄童子",模型="小仙女",称谓="新春活动",x=237,显示饰品=true,方向=1,y=165,执行事件="不执行",地图颜色=3},
                          [55] = {名称="彩虹大使",模型="男人_兰虎",x=134,y=86,任务显示=true,方向=0,执行事件="不执行",地图颜色=3},
                          [56] = {名称="超级青鸾",模型="超级青鸾",称谓="超级神兽",x=382,y=42,方向=0,执行事件="不执行",地图颜色=3},
                          [57] = {名称="超级腾蛇",模型="超级腾蛇",称谓="超级神兽",x=389,y=45,方向=0,执行事件="不执行",地图颜色=3},
                          [58] = {名称="超级赤焰兽",模型="超级赤焰兽",称谓="超级神兽",x=363,y=51,方向=0,执行事件="不执行",地图颜色=3},
                          [59] = {名称="超级神牛",模型="超级神牛",称谓="超级神兽",x=370,y=55,方向=0,执行事件="不执行",地图颜色=3},
                          [60] = {名称="超级泡泡",模型="超级泡泡",称谓="超级神兽",x=381,y=51,方向=0,执行事件="不执行",地图颜色=3},
                          [61] = {名称="超级神虎",模型="超级神虎",称谓="超级神兽",x=394,y=54,方向=0,执行事件="不执行",地图颜色=3},
                          [62] = {名称="超级海豚",模型="超级海豚",称谓="超级神兽",x=381,y=60,方向=0,执行事件="不执行",地图颜色=3},
                          [63] = {名称="超级白泽",模型="超级白泽",称谓="超级神兽",x=397,y=71,方向=0,执行事件="不执行",地图颜色=3},
                          [64] = {名称="超级玉兔",模型="超级玉兔",称谓="超级神兽",x=408,y=64,方向=0,执行事件="不执行",地图颜色=3},
                          [65] = {名称="仓库管理员",模型="仓库保管员",x=348,y=35,方向=0,执行事件="不执行",地图颜色=5},
                          [66] = {名称="伤害测试",称谓="木桩测试",模型="木桩",x=221,y=99,方向=0,执行事件="不执行",地图颜色=5},
                          --  [67] = {名称="挑战门派师傅",模型="普陀_接引仙女",武器="偃月青龙",x=75,y=42,方向=0,执行事件="不执行",地图颜色=0},
                          [67] = {名称="挑战门派师傅",称谓="实力证明",模型="剑侠客",锦衣="浪淘纱",武器="偃月青龙",x=402,y=68,方向=0,执行事件="不执行",地图颜色=0},
                          [68] = {名称="一副欠揍的样子",称谓="实力证明",模型="剑侠客",锦衣="青花瓷",x=200,y=121,方向=0,执行事件="不执行",地图颜色=0},
                          [69]={名称="世界BOSS传送员",模型="男人_将军",称谓="世界BOSS活动",x=252,显示饰品=true,方向=2,y=121,执行事件="不执行",地图颜色=3},
                          [70] = {名称="书生",称谓="仙缘",模型="男人_书生",x=249,y=112,方向=1,执行事件="不执行",地图颜色=0},
                          [71] = {名称="一副可爱的样子",模型="飞燕女",称谓="神器任务",锦衣="青花瓷",x=206,y=118,方向=0,执行事件="不执行",地图颜色=1},
                          [72] = {名称="游奕灵官",称谓="天降辰星",模型="天兵",x=160,y=76,方向=0,执行事件="不执行",地图颜色=0},
                          [73] = {名称="雁塔地宫",模型="男人_马副将",称谓="地宫传送员",x=453,y=37,方向=1,显示饰品=true,执行事件="不执行",地图颜色=0},
                          [74] = {名称="强化符熊猫",称谓="提供各门派强化符",模型="召唤兽造型进阶",显示饰品=true,x=242,y=126,方向=1,执行事件="不执行",地图颜色=0},
                          [75] = {名称="轮回境",称谓="轮回境挑战",模型="男人_书生",显示饰品=true,x=407,y=72,方向=1,执行事件="不执行",地图颜色=0},
                          [76]=  {名称="童子之力",模型="毗舍童子",称谓="童子之力挑战",显示饰品=true,x=413,方向=1,y=76,执行事件="不执行",地图颜色=3},
                          [77]=  {名称="副本BOSS挑战",模型="进阶地狱战神",称谓="副本BOSS挑战",显示饰品=true,x=424,方向=1,y=77,执行事件="不执行",地图颜色=3},
                          [78] = {名称="挑战GM",称谓="实力证明",模型="剑侠客",锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},x=396,y=64,方向=0,执行事件="不执行",地图颜色=0},
                          [79] = {名称="跨服争霸主持人",模型="男人_马副将",称谓="跨服争霸",x=198,y=118,方向=0,执行事件="不执行",地图颜色=3},
                          [80] = {名称="文韵墨香使者",模型="考官2",称谓="文韵墨香",x=217,y=130,方向=3,显示饰品=true,执行事件="不执行",地图颜色=2},
                          [81] = {名称="超级神柚",模型="超级神柚",称谓="超级神兽",x=226,y=110,方向=0,执行事件="不执行",地图颜色=3},  -- [54] = {名称="赌日天",称谓="把你的摇裤儿输脱",模型="男人_老书生",x=232,y=163,方向=1,执行事件="不执行",地图颜色=0},
                          [82] = {名称="超级红孩儿",模型="超级红孩儿",称谓="超级神兽",x=217,y=114,方向=0,执行事件="不执行",地图颜色=3},
                          [83] = {名称="罗刹鬼挑战",模型="青花瓷鬼将",称谓="罗刹鬼挑战",显示饰品=true,x=406,y=79,方向=0,执行事件="不执行",地图颜色=3},
                          [84] = {名称="哪吒",模型="男人_哪吒",称谓="我命由我不由天",显示饰品=true,x=420,y=69,方向=1,执行事件="不执行",地图颜色=3},

                          --  [53] = {名称="游奕灵官",称谓="天降辰星",模型="天兵",x=160,y=76,方向=0,执行事件="不执行",地图颜色=0},
                          --  [55] = {名称="雪人",称谓="新春活动",模型="雪人5",x=437,y=72,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1019 then
                  return {名称="颜如玉",称谓="书呆子",模型="男人_老书生",x=27,y=25,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1015 then
                  return {名称="杂货店老板",模型="男人_巫医",x=21,y=15,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1013 then --广源钱庄
                  return {名称="钱庄老板",模型="男人_财主",x=29,y=25,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1049 then
                  return {
                          [1] = {名称="殷丞相",模型="考官2",x=31,y=29,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="殷夫人",模型="女人_程夫人",x=14,y=36,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1056 then
                  return {名称="秦夫人",模型="女人_程夫人",x=24,y=18,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1057 then
                  return {名称="秦琼",模型="秦琼",x=31,y=29,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1081 then  --长寿村钱庄
                  return {名称="钱庄老板",模型="宝石商人",x=21,y=14,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1084 then  --长寿村民
                  return {名称="鲁成",模型="男人_店小二",x=21,y=14,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1099 then  --傲来钱庄
                  return {名称="钱庄老板",模型="男人_店小二",x=28,y=24,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1025 then  --冯记铁铺
                  return {
                          [1] = {名称="冯铁匠",称谓="铁王",模型="男人_武器店老板",x=25,y=16,方向=1,执行事件="不执行",地图颜色=0},
                            -- [2] = {名称="冯冯",称谓="合成能手",模型="男人_武器店老板",x=22,y=26,方向=2,执行事件="不执行",地图颜色=0},
                          [2] = {名称="打铁炉",模型="物件_打铁炉",x=29,y=19,方向=0,执行事件="物件_打铁炉",地图颜色=0},
                    }
          elseif 地图 == 1033 then
                  return {
                          [1] = {名称="罗百万",模型="罗百万",x=37,y=41,方向=3,执行事件="不执行",地图颜色=0},
                          [2] = {名称="小桃红",模型="少女",x=42,y=39,方向=1,执行事件="不执行",地图颜色=0},
                          [3] = {名称="陈妈妈",模型="陈妈妈",x=33,y=33,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1044 then -- 金銮殿
                  return {
                          [1] = {名称="魏征",模型="考官2",x=70,y=52.5,方向=1,执行事件="不执行",地图颜色=0},
                            -- [2] = {名称="戴胄下属",模型="考官2",x=78.5,y=57.5,方向=1,执行事件="不执行",地图颜色=0},
                          [2] = {名称="房玄龄",模型="考官2",x=78,y=57,方向=1,执行事件="不执行",地图颜色=0},
                            -- [4] = {名称="杜如晦",模型="考官2",x=64.5,y=67,方向=3,执行事件="不执行",地图颜色=0},
                          [3] = {名称="李世民",模型="皇帝",x=49,y=49,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1028 then -- 长安酒店
                  return {
                          [1] = {名称="店小二",称谓="挖宝图任务",模型="男人_店小二",x=12,y=29,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="酒店老板",模型="男人_酒店老板",x=41,y=34,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1198 then -- 大唐官府
                  return {
                          [1] = {名称="传送护卫",称谓="传送长安",模型="护卫",x=72,y=61,方向=0,执行事件="不执行",地图颜色=0},
                          [2] = {名称="程夫人",模型="女人_程夫人",x=28,y=26,方向=0,执行事件="不执行",地图颜色=0},
                          [3] = {名称="丫鬟",模型="女人_丫鬟",x=24,y=28,方向=0,执行事件="不执行",地图颜色=0},
                          [4] = {名称="程府护卫",模型="护卫",x=89,y=95,方向=0,执行事件="不执行",地图颜色=0},
                          [5] = {名称="程府护卫",模型="护卫",x=121.5,y=82.4,方向=0,执行事件="不执行",地图颜色=0},
                          [6] = {名称="程府护卫",模型="护卫",x=128,y=79,方向=0,执行事件="不执行",地图颜色=0},
                          [7] = {名称="程府护卫",模型="护卫",x=155,y=63,方向=0,执行事件="不执行",地图颜色=0},
                          [8] = {名称="大唐官府护法",模型="剑侠客",武器="四法青云",x=139,y=46,方向=1,执行事件="不执行",地图颜色=0},
                          [9] = {名称="剑侠客",称谓="首席弟子",模型="剑侠客",武器="斩妖泣血",门派="大唐官府",x=94,y=65,方向=0,执行事件="不执行",地图颜色=0},
                            ---染色方案=10,染色组={3,3,4},
                            --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1054 then
                  return {名称="程咬金",称谓="门派师傅",模型="程咬金",x=21,y=21,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1016 then --长安药店
                  return {名称="药店老板",模型="男人_药店老板",x=13.5,y=18.7,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1024 then --长安镖局
                  return {名称="郑镖头",称谓="镖王活动",模型="男人_镖头",x=31,y=24,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1020 then --长安兵铁铺
                  return {
                        [1] = {名称="武器店掌柜",模型="男人_老孙头",x=16,y=21,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="武器店老板",模型="男人_武器店老板",x=28,y=21,方向=1,执行事件="不执行",地图颜色=0},
                          -- [3] = {名称="打铁炉",模型="物件_打铁炉",x=30,y=20,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1026 then --国子监
                  return {名称="吴举人",模型="男人_书生",x=26,y=26,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1030 then --云来酒店
                  return {名称="酒店老板",模型="男人_酒店老板",x=38,y=24,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1002 then --化生寺
                  return {
                        [1] = {名称="慧静",模型="男人_胖和尚",x=113,y=47,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="疥癞和尚",模型="男人_胖和尚",称谓="水陆大会",x=37,y=55,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="接引僧",称谓="传送长安",模型="男人_胖和尚",x=58,y=66,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="慧海",模型="男人_胖和尚",x=46,y=60,方向=1,执行事件="不执行",地图颜色=0},
                        [5] = {名称="慧悲",模型="男人_胖和尚",x=20,y=51,方向=2,执行事件="不执行",地图颜色=0},
                        [6] = {名称="空慈方丈",模型="男人_方丈",x=40,y=25,方向=0,执行事件="不执行",地图颜色=0},
                        [7] = {名称="化生寺护法",模型="逍遥生",武器="秋水人家",x=34,y=74,方向=1,执行事件="不执行",地图颜色=0},
                        [8] = {名称="逍遥生",称谓="首席弟子",模型="逍遥生",武器="浩气长舒",门派="化生寺",x=49,y=65,方向=1,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},=0},
                    }
          elseif 地图 == 1004 then
                  return {名称="太乙真人",模型="雨师",x=54,y=49,方向=1,执行事件="不执行",地图颜色=3}
          elseif 地图 == 1005 then
                  return {名称="敖丙",模型="龙太子",x=85,y=23,方向=0,武器="飞龙在天",武器染色方案=20113,武器染色组={[1]=2,[2]=0},锦衣="冰寒绡月白",执行事件="不执行",地图颜色=3}
          elseif 地图 == 1006 then
                  return {名称="申公豹",模型="狂豹人形",x=54,y=36,方向=0,执行事件="不执行",地图颜色=3}
          elseif 地图 == 1007 then
                  return {名称="龙王",模型="东海龙王",x=79,y=41,方向=0,执行事件="不执行",地图颜色=3}
          elseif 地图 == 1008 then
                  return {名称="哪吒",模型="超级红孩儿",x=59,y=36,方向=0,执行事件="不执行",地图颜色=3}
          elseif 地图 == 1009 then
                  return {名称="雁塔地宫使者",模型="男人_将军",x=29,y=24,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3}
          elseif 地图 == 1528 then
                  return {
                        [1] = {名称="慧明",模型="男人_胖和尚",x=14,y=23,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="法明长老",模型="空度禅师",称谓="剧情技能",x=29,y=21,方向=3,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1043 then
                  return {名称="空度禅师",称谓="门派师傅",模型="空度禅师",x=7,y=17,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1017 then --长安饰品店
                  return {名称="饰品店老板",模型="女人_赵姨娘",x=26,y=21,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1022 then --长安衣服店
                  return {
                        [1] = {名称="服装店老板",模型="男人_服装店老板",x=35,y=19,方向=1,执行事件="不执行",地图颜色=0},
                          -- [2] = {名称="张裁缝",模型="男人_服装店老板",x=20,y=20,方向=3,执行事件="不执行",地图颜色=0},
                          -- [3] = {名称="缝纫台",模型="物件_缝纫台",x=16,y=27,方向=3,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1092 then --傲来国
                  return {
                        [1] = {名称="船夫",称谓="传送东海湾",模型="男人_驿站老板",x=150,y=143,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="仙岛引路人",称谓="传送蓬莱仙岛",模型="男人_诗中仙",x=18,y=51,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="驿站老板",称谓="传送长安城",模型="男人_驿站老板",x=63,y=67,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=53,y=119,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="蝴蝶妹妹",称谓="剧情技能",模型="蝴蝶仙子",x=67,y=98,方向=0,执行事件="不执行",地图颜色=0},
                        [6] = {名称="九头精怪",模型="九头精怪",x=47,y=64,方向=0,执行事件="不执行",地图颜色=0},
                        [7] = {名称="报名官",模型="雨师",称谓="游泳比赛",x=144,y=59,方向=2,执行事件="不执行",地图颜色=0},
                        [8] = {名称="偷偷怪",模型="兔子怪",x=107,y=42,方向=1,执行事件="不执行",地图颜色=0},
                        [9] = {名称="金毛猿",模型="马猴",称谓="幻域迷宫",x=202,y=6,方向=0,执行事件="不执行",地图颜色=0},
                        [10] = {名称="傲来珍品商人",模型="珍品商人",x=56,y=38,方向=1,执行事件="不执行",地图颜色=0},
                        [11] = {名称="傲来商人",模型="男人_特产商人",x=180,y=46,方向=1,执行事件="不执行",地图颜色=0},
                        [12] = {名称="傲来货商",模型="男人_老财",x=87,y=41,方向=1,执行事件="不执行",地图颜色=0},
                        [13] = {名称="红毛猿",模型="马猴",x=57,y=47,方向=0,执行事件="不执行",地图颜色=0},
                        --[14] = {名称="刻晴",称谓="赌一赌:单车变路虎",模型="神天兵",锦衣="黑浪淘纱",武器="弑皇",x=112,y=41,方向=4,执行事件="不执行",地图颜色=0},
                        [14] = {名称="渔夫",称谓="钓鱼",模型="男人_钓鱼",x=188,y=135,方向=0,执行事件="不执行",地图颜色=0},
                        --[15] = {名称="八卦炼丹炉",模型="炼丹炉",x=108,y=46,方向=0,执行事件="不执行",地图颜色=0},
                        --[15] = {名称="上古练气士",模型="男人_道士",x=109,y=52,方向=0,执行事件="不执行",地图颜色=0},
                        [15] = {名称="云游道人",模型="男人_道士",x=112,y=38,方向=0,执行事件="不执行",地图颜色=0},
                        [16] = {名称="八卦炼丹炉",模型="炼丹炉",x=109,y=52,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1093 then
                  return {
                        [1] = {名称="王福来",模型="男人_酒店老板",x=21,y=24,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="慕容先生",模型="考官1",x=44,y=18,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1104 then
                  return {名称="沈妙衣",模型="男人_药店老板",x=28,y=21,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1105 then
                  return {名称="杂货店老板",模型="男人_巫医",x=15,y=24,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1101 then
                  return {名称="杜天",模型="男人_兰虎",x=23,y=18,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1095 then
                  return {名称="牛师傅",模型="男人_服装店老板",x=27,y=21,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1142 then --女儿村
                  return {
                        [1] = {名称="接引女使",称谓="传送长安",模型="女人_丫鬟",x=24,y=14,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="翠花",模型="女人_翠花",x=73,y=96,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="栗栗娘",模型="女人_栗栗娘",x=102,y=56,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="柳飞絮",模型="普陀_接引仙女",x=11,y=98,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="绿儿",模型="女人_绿儿",x=77,y=68,方向=1,执行事件="不执行",地图颜色=0},
                        [6] = {名称="翠儿",模型="女人_绿儿",x=34,y=70,方向=1,执行事件="不执行",地图颜色=0},
                        [7] = {名称="女儿村护法",模型="英女侠",武器="金龙双剪",x=81,y=80,方向=1,执行事件="不执行",地图颜色=0},
                        [8] = {名称="英女侠",称谓="首席弟子",模型="英女侠",武器="祖龙对剑",门派="女儿村",x=35,y=34,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1143 then
                  return {名称="孙婆婆",称谓="门派师傅",模型="孙婆婆",x=25,y=20,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1137 then --方寸
                  return {名称="菩提老祖",称谓="门派师傅",模型="菩提老祖",x=45,y=30,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1111 then
                  return {
                        [1] = {名称="守门天将",称谓="传送长寿郊外",模型="天兵",x=242,y=154,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="执法天兵",模型="天兵",x=231.5,y=149.5,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="守门天兵",模型="天兵",x=238.8,y=146,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="接引仙女",称谓="传送长安",模型="芙蓉仙子",x=148.5,y=109.8,方向=0,执行事件="不执行",地图颜色=0},
                        [6] = {名称="守门道童",模型="男人_道童",x=25,y=146.5,方向=0,执行事件="不执行",地图颜色=0},
                        [7] = {名称="守门道童",模型="男人_道童",x=32,y=144,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="千里眼",模型="天兵",x=175,y=102,方向=0,执行事件="不执行",地图颜色=0},
                        [8] = {名称="顺风耳",模型="天兵",x=117,y=113,方向=0,执行事件="不执行",地图颜色=0},
                        [9] = {名称="马真人",称谓="宠物修炼",模型="男人_道士",x=229,y=95,方向=0,执行事件="不执行",地图颜色=0},
                        [10] = {名称="天牢守卫",模型="天将",x=228,y=25,方向=0,执行事件="不执行",地图颜色=0},
                        [11] = {名称="水兵统领",模型="男人_将军",x=175,y=28,方向=1,显示饰品=true,执行事件="不执行",地图颜色=0},
                        [12] = {名称="大力神灵",模型="风伯",x=19,y=39,方向=2,执行事件="不执行",地图颜色=0},
                        [13] = {名称="天宫护法",模型="舞天姬",武器="此最相思",x=195,y=132,方向=0,执行事件="不执行",地图颜色=0},
                        [14] = {名称="舞天姬",称谓="首席弟子",模型="舞天姬",武器="揽月摘星",门派="天宫",x=160,y=113,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},=0},
                    }
          elseif 地图 == 6035 then --梦战天宫
                  return {名称="秋风的回忆",模型="龙太子",染色方案=10,染色组={3,3,4},武器="弑皇",x=89,y=76,方向=4,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1112 then --凌霄殿
                  return {
                        [1] = {名称="杨戬",称谓="降妖伏魔",模型="男人_杨戬",x=54.5,y=53.4,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="李靖",称谓="门派师傅",模型="李靖",x=26,y=43,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="玉皇大帝",模型="男人_玉帝",x=29.8,y=34.8,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="王母娘娘",模型="女人_王母",x=35.0,y=31.5,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="哪吒",模型="男人_哪吒",x=65.7,y=46.8,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1113 then
                  return {
                        [1] = {名称="太上老君",模型="男人_太上老君",x=14,y=20,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="炼丹道士",模型="男人_道士",x=35,y=23,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="金童子",模型="男人_道童",x=23,y=23,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1114 then
                  return {
                        [1] = {名称="吴刚",模型="男人_打铁",x=12,y=60,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="嫦娥",模型="女人_满天星",x=97,y=29,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="康太尉",模型="天兵",x=104,y=35,方向=3,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1512 then --魔王寨
                  return {
                        [1] = {名称="守门牛妖",模型="牛妖",x=13,y=75,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="守门牛妖",模型="牛妖",x=17,y=78,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="传送牛妖",称谓="传送长安",模型="牛妖",x=87,y=13,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="魔王寨护法",模型="巨魔王",武器="晓风残月",x=32,y=43,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="巨魔王",称谓="首席弟子",模型="巨魔王",武器="业火三灾",门派="魔王寨",x=99,y=23,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},,
                    }
          elseif 地图 == 1145 then
                  return {
                        [1] = {名称="牛魔王",称谓="门派师傅",模型="牛魔王",显示饰品=true,x=33,y=21,方向=1,执行事件="不执行",地图颜色=0},
                          -- [2] = {名称="九头精怪",称谓="种族任务",模型="九头精怪",x=17,y=22,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1146 then
                  return {
                        [1] = {名称="接引道童",称谓="传送长安",模型="男人_道童",x=46.5,y=37,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="清风",模型="男人_道童",x=60,y=43,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="五庄观护法",模型="神天兵",武器="九瓣莲花",x=39,y=32,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="神天兵",称谓="首席弟子",模型="神天兵",武器="狂澜碎岳",门派="五庄观",x=36,y=49,方向=1,执行事件="不执行",地图颜色=0},
                        ---染色方案=10,染色组={3,3,4},
                        --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1147 then --乾坤殿
                  return {名称="镇元子",称谓="门派师傅",模型="镇元子",x=25.5,y=20.5,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1131 then --狮驼岭
                  return {
                        [1] = {名称="守山小妖",模型="雷鸟人",x=114,y=8,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="守山小妖",模型="雷鸟人",x=119.2,y=12.5,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="传送小妖",称谓="传送长安",模型="雷鸟人",x=111,y=71,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="狮驼岭护法",模型="虎头怪",武器="元神禁锢",x=90,y=5,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="虎头怪",称谓="首席弟子",模型="虎头怪",武器="碧血干戚",门派="狮驼岭",x=119,y=77,方向=1,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                    }
          elseif 地图 == 1132 then --狮王洞
                  return {名称="二大王",模型="二大王",x=29,y=19,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1133 then --狮王洞
                  return {名称="三大王",模型="三大王",x=25,y=21,方向=1,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1134 then
                  return {名称="大大王",称谓="门派师父",模型="大大王",x=29.2,y=19.2,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1513 then --盘丝岭
                  return {
                        [1] = {名称="女妖",模型="芙蓉仙子",x=110,y=104,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="金琉璃",模型="如意仙子",x=64.5,y=81,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="栗栗儿",模型="女人_丫鬟",x=73,y=85,方向=2,执行事件="不执行",地图颜色=0},
                        [4] = {名称="看门小妖",模型="树怪",x=171.8,y=27.5,方向=1,执行事件="不执行",地图颜色=0},
                        [5] = {名称="看门小妖",模型="树怪",x=180,y=33,方向=1,执行事件="不执行",地图颜色=0},
                        [6] = {名称="引路小妖",称谓="传送长安",模型="蝴蝶仙子",x=180,y=22,方向=1,执行事件="不执行",地图颜色=0},
                        [7] = {名称="盘丝洞护法",模型="狐美人",武器="游龙惊鸿",x=145,y=106,方向=0,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1144 then
                  return {
                        [1] = {名称="春十三娘",模型="春十三娘",x=30,y=42,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="白晶晶",称谓="门派师傅",模型="白晶晶",x=38,y=13,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="狐美人",称谓="首席弟子",模型="狐美人",武器="牧云清歌",门派="盘丝洞",x=24,y=48,方向=1,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1138 then --神木林
                  return {
                        [1] = {名称="引路族民",称谓="传送长安",模型="巫师",x=54,y=92,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="云中月",模型="巫师",x=22,y=68,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="云小奴",模型="女人_云小奴",x=17,y=48,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="满天星",模型="女人_满天星",x=25,y=37,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="神木林护法",模型="巫蛮儿",武器="紫金葫芦",x=42,y=161,方向=0,执行事件="不执行",地图颜色=0},
                        [6] = {名称="巫蛮儿",称谓="首席弟子",模型="巫蛮儿",武器="雪蟒霜寒",门派="神木林",x=50,y=106,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1154 then
                  return {名称="巫奎虎",称谓="门派师傅",模型="巫奎虎",x=33.5,y=32,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1228 then --碗子山
                  return {名称="碗子山土地",模型="男人_土地",称谓="传送无底洞",x=25,y=173,方向=0,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1139 then --无底洞
                  return {
                        [1] = {名称="璎珞",模型="幽萤娃娃",x=85,y=49,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="墨衣",模型="修罗傀儡妖",x=4,y=54,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="红莲",模型="修罗傀儡妖",x=29,y=15,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="接引小妖",称谓="传送长安",模型="幽萤娃娃",x=47,y=120,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="无底洞护法",模型="杀破狼",武器="冥火薄天",x=58,y=86,方向=2,执行事件="不执行",地图颜色=0},
                        [6] = {名称="鬼潇潇",称谓="首席弟子",模型="鬼潇潇",武器="浮生归梦",门派="无底洞",x=60,y=124,方向=1,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
          elseif 地图 == 1156 then
                  return {
                        [1] = {名称="地涌夫人",称谓="门派师傅",模型="地涌夫人",x=49.6,y=27.6,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="灵鼠娃娃",模型="女人_灵鼠娃娃",x=55,y=33,方向=1,执行事件="不执行",地图颜色=0},
                    }
          elseif 地图 == 1235 then --丝绸之路
                  return {名称="驿站老板",称谓="传送西梁女国",模型="男人_驿站老板",x=464,y=92,方向=3,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1210 then --麒麟山
                  return {名称="驿站老板",称谓="传送宝象国",模型="男人_驿站老板",x=70,y=140,方向=2,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1207 then --蓬莱仙岛
                  return {名称="驿站老板",称谓="传送傲来国",模型="男人_驿站老板",x=9.2,y=101.8,方向=2,执行事件="不执行",地图颜色=0}
          elseif 地图 == 1070 then --长寿村
                  return {
                        [1] = {名称="慧觉和尚",模型="男人_胖和尚",称谓="车迟斗法副本",x=120,y=141,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="陆萧然",称谓="任务链",模型="男人_老书生",x=20,y=185,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="蝴蝶女",模型="蝴蝶仙子",称谓="通天河副本",x=47,y=71,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="太白金星",模型="太白金星",称谓="仙族任务",x=53,y=194,方向=1,执行事件="不执行",地图颜色=0},
                        [5] = {名称="海老先生",模型="男人_村长",x=107,y=175,方向=0,执行事件="不执行",地图颜色=0},
                        [6] = {名称="钟书生",模型="男人_书生",x=43,y=51,方向=2,执行事件="不执行",地图颜色=0},
                        [7] = {名称="许姑娘",模型="少女",x=76,y=35,方向=0,执行事件="不执行",地图颜色=0},
                        [8] = {名称="仓库管理员",模型="仓库保管员",x=100,y=149,方向=0,执行事件="不执行",地图颜色=0},
                        [9] = {名称="南极仙翁",模型="南极仙翁",称谓="剧情技能",x=107,y=22,方向=1,执行事件="不执行",地图颜色=0},
                        [10] = {名称="长寿珍品商人",模型="珍品商人",x=109,y=158,方向=0,执行事件="不执行",地图颜色=0},
                        [11] = {名称="长寿商人",模型="男人_特产商人",x=141,y=41,方向=1,执行事件="不执行",地图颜色=0},
                        [12] = {名称="长寿货商",模型="男人_老财",x=54,y=168,方向=1,执行事件="不执行",地图颜色=0},
                        [13] = {名称="许大娘",模型="女人_王大嫂",x=80,y=144,方向=1,执行事件="不执行",地图颜色=0},
                        [14] = {名称="超级巫医",称谓="召唤兽治疗师",模型="男人_巫医",x=126,y=101,方向=1,执行事件="不执行",地图颜色=2},
                        [15] = {名称="毛驴张",模型="男人_老伯",x=76,y=82,方向=1,执行事件="不执行",地图颜色=0},
                        [16] = {名称="凤凰姑娘",模型="普陀_接引仙女",x=25,y=103,方向=0,执行事件="不执行",地图颜色=0},
                        [17] = {名称="马婆婆",模型="女人_孟婆",x=43,y=140,方向=1,执行事件="不执行",地图颜色=2},
                        [18] = {名称="长寿村村长",模型="男人_村长",x=16,y=169,方向=0,执行事件="不执行",地图颜色=0},
                        [19] = {名称="PK申请人",模型="男人_兰虎",称谓="不服就干",x=50,y=113,方向=1,执行事件="不执行",地图颜色=0},
                        [20] = {名称="药店老板",模型="男人_药店老板",x=89,y=192,方向=0,执行事件="不执行",地图颜色=0}
                    }
        elseif 地图 == 1083 then
                  return {名称="裁缝张",模型="男人_服装店老板",x=23.2,y=20,方向=0,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1213 then
                  return {
                        [1] = {名称="子鼠",称谓="十二生肖",模型="鼠先锋",x=114,y=47,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="丑牛",称谓="十二生肖",模型="超级神牛",x=113,y=38,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="寅虎",称谓="十二生肖",模型="超级神虎",x=115,y=28,方向=0,执行事件="不执行",地图颜色=0},
                        [4] = {名称="卯兔",称谓="十二生肖",模型="超级神兔",x=117,y=20,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1085 then
                  return {名称="武器店老板",模型="男人_武器店老板",x=19,y=20,方向=0,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1114 then --月宫
                  return {名称="吴刚",模型="吴刚",x=12,y=63,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1204 then --小雷音寺
                  return {名称="丹青生",模型="男人_书生",x=22,y=48,方向=0,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1875 then--聚义堂
                  return {
                        [1] = {名称="帮派总管",模型="男人_兰虎",x=23,y=22,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="黑色机关人",模型="帮派机关人",x=47,y=29,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1865 then--青龙堂
                  return {
                        [1] = {名称="青龙总管",模型="男人_兰虎",x=18,y=19,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="橙色机关人",模型="帮派机关人",x=30,y=19,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1855 then--药房
                  return {
                        [1] = {名称="药房总管",模型="男人_药店老板",x=20,方向=1,y=16,执行事件="不执行",地图颜色=0},
                        [2] = {名称="红色机关人",模型="帮派机关人",x=15,y=21,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1845 then--厢房
                  return {
                        [1] = {名称="厢房总管",模型="男人_兰虎",x=18,y=18,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="绿色机关人",模型="帮派机关人",x=16,y=23,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1835 then--兽室
                  return {
                        [1] = {名称="帮派守护兽",模型="帮派妖兽",x=20,y=20,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="青色机关人",模型="帮派机关人",x=35,y=22,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1825 then--书院
                  return {
                        [1] = {名称="帮派师爷",模型="男人_师爷",x=15,y=17,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="蓝色机关人",模型="帮派机关人",x=33,y=21,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1815 then--金库
                  return {
                        [1] = {名称="金库总管",模型="男人_兰虎",x=22,y=22,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="紫色机关人",模型="帮派机关人",x=27,y=20,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 2008 then--九黎
                  return {
                        [1] = {名称="刑天",模型="刑天",称谓="门派师傅",x=66,y=60,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="风祖飞廉",模型="风祖飞廉",称谓 = "传送长安",x=75,y=45,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="食铁兽",模型="食铁兽",称谓 = "铸斧转换",x=94,y=83,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="九黎城护法",模型="影精灵",武器="丝萝乔木",x=51,y=120,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="影精灵",称谓="首席弟子",模型="影精灵",武器="丝萝乔木",门派="九黎城",x=68,y=78,方向=0,执行事件="不执行",地图颜色=0},
                          ---染色方案=10,染色组={3,3,4},
                          --锦衣="冰寒绡月白",武器="鸣鸿",武器染色方案=2065,武器染色组={[1]=1,[2]=0},
                    }
        elseif 地图 == 6021 then --车迟副本
                  return {名称="道观",模型="道观",x=88,y=28,方向=0,执行事件="不执行",地图颜色=0}
        elseif 地图 == 6024 then
                  return {
                        [1] = {名称="道场督僧",模型="男人_方丈",x=38,y=61,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="道场童子",模型="男人_胖和尚",x=4,y=86,方向=0,执行事件="不执行",地图颜色=0},
                        [3] = {名称="翼虎将军",模型="噬天虎",x=113,y=12,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="蝰蛇将军",模型="律法女娲",x=122,y=17,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 6025 then
                  return {
                        [1] = {名称="传送侍卫",模型="男人_马副将",x=501,y=6,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="代笔师爷",模型="男人_师爷",x=483,y=125,方向=1,执行事件="不执行",地图颜色=0},
                        [3] = {名称="瓜农",模型="男人_老伯",x=478,y=119,方向=1,执行事件="不执行",地图颜色=0},
                        [4] = {名称="绣娘",模型="女人_染色师",x=459,y=162,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="喜轿轿夫",模型="男人_兰虎",x=483,y=147,方向=0,执行事件="不执行",地图颜色=0},
                        [6] = {名称="卖艺者",模型="男人_苦力",x=430,y=182,方向=0,执行事件="不执行",地图颜色=0},
                        [7] = {名称="乞丐乙",模型="男人_村长",x=455,y=184,方向=1,执行事件="不执行",地图颜色=0},
                        [8] = {名称="阿咪",模型="女人_丫鬟",x=470,y=192,方向=1,执行事件="不执行",地图颜色=0},
                        [9] = {名称="马商",模型="珍品商人",x=407,y=211,方向=1,执行事件="不执行",地图颜色=0},
                        [10] = {名称="小顽童",模型="女人_绿儿",x=401,y=203,方向=1,执行事件="不执行",地图颜色=0},
                        [11] = {名称="卖花童",模型="女人_绿儿",x=420,y=219,方向=1,执行事件="不执行",地图颜色=0},
                        [12] = {名称="丫鬟",模型="女人_丫鬟",x=424,y=222,方向=1,执行事件="不执行",地图颜色=0},
                        [13] = {名称="富家小姐",模型="普陀_接引仙女",x=431,y=225,方向=1,执行事件="不执行",地图颜色=0},
                        [14] = {名称="卖鱼人",模型="男人_苦力",x=442,y=229,方向=1,执行事件="不执行",地图颜色=0},
                        [15] = {名称="面点师傅",模型="男人_苦力",x=443,y=223,方向=1,执行事件="不执行",地图颜色=0},
                        [16] = {名称="针线娘子",模型="女人_王大嫂",x=464,y=240,方向=1,执行事件="不执行",地图颜色=0},
                        [17] = {名称="樵夫",模型="樵夫",x=462,y=262,方向=0,执行事件="不执行",地图颜色=0},
                        [18] = {名称="大财主",模型="男人_老财",x=427,y=228,方向=2,执行事件="不执行",地图颜色=0},
                        [19] = {名称="曾衙役",模型="男人_衙役",x=421,y=225,方向=2,执行事件="不执行",地图颜色=0},
                        [20] = {名称="布陈太医",模型="男人_村长",x=370,y=243,方向=0,执行事件="不执行",地图颜色=0},
                        [21] = {名称="游方郎中",模型="男人_书生",x=389,y=234,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 1249 then
                  return {名称="传送侍卫",称谓="传送至长安",模型="女人_云小奴",x=86,y=29,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1250 then
                  return {名称="传送侍卫",称谓="传送至长安",模型="女人_云小奴",x=137,y=46,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1251 then
                  return {
                        [1] = {名称="齐天大圣",模型="孙悟空",x=91,y=16,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="传送侍卫",称谓="传送至长安",模型="女人_云小奴",x=90,y=24,方向=1,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 1252 then
                  return {名称="天女魃",模型="金圣宫",x=41,y=16,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1253 then
                  return {名称="小夫子",模型="鲁班",x=58,y=127,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 1332 then
                  return {
                        [1] = {名称="女佣",模型="女人_丫鬟",x=31,y=44,方向=3,执行事件="不执行",地图颜色=0},
                        [2] = {名称="管家",模型="男人_师爷",x=46,y=49,方向=2,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 1340 then
                  return {
                        [1] = {名称="看门爬虫",模型="超级神龙",x=16,y=26,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="看门爬虫",模型="超级神龙",x=24,y=32,方向=1,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 1621 then --会员地图
                  return {
                        [1] = {名称="会员福利",模型="超级神柚",x=99,y=109,方向=1,执行事件="不执行",地图颜色=0},
                        [2] = {名称="会员福利",模型="超级神柚",x=36,y=113,方向=3,执行事件="不执行",地图颜色=0},
                        [3] = {名称="会员福利",模型="超级神柚",x=7,y=74,方向=3,执行事件="不执行",地图颜色=0},
                        [4] = {名称="会员福利",模型="超级神柚",x=29,y=19,方向=0,执行事件="不执行",地图颜色=0},
                        [5] = {名称="会员福利",模型="超级神柚",x=103,y=14,方向=1,执行事件="不执行",地图颜色=0},
                        [6] = {名称="会员福利",模型="超级神柚",x=143,y=20,方向=1,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 6037 then
                  return {
                        [1] = {名称="判官",模型="男人_判官",x=47,y=65,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="阎王",模型="阎罗王",x=31,y=53,方向=0,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 6038 then
                  return {
                        [1] = {名称="玉皇大帝",模型="男人_玉帝",x=152,y=108,方向=0,执行事件="不执行",地图颜色=0},
                        [2] = {名称="天蓬元帅",模型="猪八戒",x=247,y=104,方向=3,执行事件="不执行",地图颜色=0},

                   }
        elseif 地图 == 6039 then
                  return {名称="镇塔之神",模型="男人_将军",x=25,y=24,方向=0,显示饰品=true,执行事件="不执行",地图颜色=3}
        elseif 地图 == 10000 then --云影储备室
                  return {名称="传送大使",模型="男人_马副将",x=17,y=54,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0}
        elseif 地图 == 10001 then --虹光储备室
                  return {名称="传送大使",模型="男人_马副将",x=17,y=54,方向=0,显示饰品=true,执行事件="不执行",地图颜色=0}
        elseif 地图 == 10009 then
                  return {名称="超级巫医",模型="男人_巫医",x=89,y=85,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 10002 or 地图 == 10012 then
                  return {
                          [1] ={名称="超级巫医",模型="男人_巫医",x=71,y=89,方向=1,执行事件="不执行",地图颜色=0},
                          [2] ={名称="超级巫医",模型="男人_巫医",x=15,y=46,方向=0,执行事件="不执行",地图颜色=0},
                          [3] ={名称="传送大使",模型="男人_马副将",x=60,y=14,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 10003 or 地图 == 10013 then
                  return {名称="传送大使",模型="男人_马副将",x=112,y=78,方向=1,执行事件="不执行",地图颜色=0}
        elseif 地图 == 10004 or 地图 == 10014 then
                  return {
                          [1] ={名称="超级巫医",模型="男人_巫医",x=18,y=127,方向=0,执行事件="不执行",地图颜色=0},
                          [2] ={名称="超级巫医",模型="男人_巫医",x=70,y=77,方向=1,执行事件="不执行",地图颜色=0},
                          [3] ={名称="传送大使",模型="男人_马副将",x=42,y=13,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 10005 or 地图 == 10015 then
                  return {
                          [1] ={名称="超级巫医",模型="男人_巫医",x=100,y=103,方向=1,执行事件="不执行",地图颜色=0},
                          [2] ={名称="超级巫医",模型="男人_巫医",x=100,y=59,方向=0,执行事件="不执行",地图颜色=0},
                          [3] ={名称="传送大使",模型="男人_马副将",x=82,y=13,方向=0,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 10006 or 地图 == 10016 then
                  return {
                          [1] ={名称="超级巫医",模型="男人_巫医",x=102,y=74,方向=1,执行事件="不执行",地图颜色=0},
                          [2] ={名称="超级巫医",模型="男人_巫医",x=162,y=43,方向=1,执行事件="不执行",地图颜色=0},
                          [3] ={名称="传送大使",模型="男人_马副将",x=190,y=20,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 10007 or 地图 == 10017 then
                  return {
                          [1] ={名称="超级巫医",模型="男人_巫医",x=17,y=41,方向=1,执行事件="不执行",地图颜色=0},
                          [2] ={名称="传送大使",模型="男人_马副将",x=10,y=16,方向=1,执行事件="不执行",地图颜色=0},
                    }
        elseif 地图 == 10008 or 地图 == 10018 then
                  return {名称="传送大使",模型="男人_马副将",x=75,y=16,方向=1,执行事件="不执行",地图颜色=0}



        end



end




function 地图处理类:显示(x,y) end

return 地图处理类
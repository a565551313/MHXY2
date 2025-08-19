--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_世界地图分类小地图 = class()
local tp
local 小地图宽度 = 0
local 小地图高度 = 0

--======================================================================--
function 场景类_世界地图分类小地图:初始化(根)
	self.ID = 59
	self.注释 = "世界地图分类小地图"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.记忆地图 = 0
	self.窗口时间 = 0
	self.目标格子 = 生成XY()
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	tp = 根
	self.标记 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x393947EB)
	self.终点 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xDEE57252)
	self.迷你传送阵 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x558897FF)
	self.NPC查找Q= 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0BC4D521),0,0,4,true,true,"")
	self.普通 = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true)
	self.普通:置根(根)
	self.普通:置偏移(-3,2)
	self.普通显示 = false
	self.选择框显示 = {false,false,false,false,false,false}
	self.选择框组 = {
		[1] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
		[2] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
		[3] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
		[4] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
		[5] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
		[6] = 根._按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0x00000009),0,0,1,true,true),
	}
	for i=1,#self.选择框组 do
		self.选择框组[i]:置根(根)
		self.选择框组[i]:置偏移(-3,2)
	end
	self.偏移X = 0
	self.偏移Y = 0
	self.背景窗口 = tp._自适应.创建(0,1,0,0,3,9)
	self.窗口时间 = 0
	self.目标格子 = nil
	self.xx = 0
	self.yy = 0
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] =  按钮.创建(自适应.创建(12,4,60,20,1,3),0,0,4,true,true," 世界"),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭按钮
	}
	for i=1,1 do
		self.资源组[i]:绑定窗口_(59)
	end
	self.超级传送 = false
end



function 场景类_世界地图分类小地图:打开(map,传送)
		self.额外显示 = nil
		if self.可视 then
			self.可视 = false
			self.普通显示 = false
			self.普通:置打勾框(self.普通显示)
			return
		end
		local Smap,Smapa = 小地图资源加载(map)
		if Smap == nil then
			tp.窗口.消息框:添加文本("此场景无法查看小地图")
		else
			小地图宽度,小地图高度 = 取场景等级宽高(map)
		    self.超级传送 = false
			if 传送~= nil then
				self.超级传送 = 传送
			end
			if self.记忆地图 ~= map then
				self.小地图 = tp.资源:载入(Smap,"网易WDF动画",Smapa)
				self.宽度 = self.小地图:取宽度()
				self.高度 = self.小地图:取高度()
				local fg = {}
				分割字符(tostring(self.高度),fg)
				fg = tonumber(fg[3])
				local v = 15
				if fg == 1 or fg == 3 or fg == 5 or fg == 7 or fg == 9 then
					v = 15
				end
				self.x = self.x or math.floor((全局游戏宽度 - self.宽度) /2)
				self.y = self.y or math.floor((全局游戏高度 - self.高度) /2)
				if self.宽度>= 500 then
					self.背景窗口:置宽高(self.宽度+v+2,self.高度+v+35)
				else
				    self.背景窗口:置宽高(self.宽度+84,self.高度+v+10)
				end
				self.偏移X = (self.宽度 - 20) / 小地图宽度
				self.偏移Y = (self.高度 - 20)/ 小地图高度
				self.记忆地图 = map
			elseif self.记忆地图 == map and self.可视 then
			    self.可视 = false
				return
			end
		end
		self.普通显示 = false
		self.普通:置打勾框(false)
		self.额外显示 =场景取名称(self.记忆地图)
		self.NPC列表 = {}
		if NPC列表[self.记忆地图] then
			self.NPC列表 =DeepCopy(NPC列表[self.记忆地图])
		end
		for k,v in pairs(self.NPC列表) do
			v.xy = 生成XY(v.x * 20,v.y * 20)
		end
		self.传送列表 ={}
		if 传送数据[self.记忆地图] then
			self.传送列表 =DeepCopy(传送数据[self.记忆地图])
		end
		for k,v in pairs(self.传送列表) do
			v.xy = 生成XY(v.x * 20,v.y * 20)
		end
		for i=1,#self.选择框组 do
			self.选择框显示[i] = false
			self.选择框组[i]:置打勾框(false)
		end
		self.可视 = true
		table.insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	return false
end

function 场景类_世界地图分类小地图:清空()
	self.目标格子 = nil
end

function 场景类_世界地图分类小地图:显示(dt,x,y)
	for i=1,#self.资源组 do
	   self.资源组[i]:更新(x,y)
	end
	if self.鼠标 then
		if self.资源组[1]:事件判断() then
			self:打开()
			tp.窗口.世界大地图:打开()
		elseif self.资源组[2]:事件判断() then
			self:打开()
		end
	end
	self.焦点 = false
	for i=1,#self.选择框组 do
		self.选择框组[i]:更新(x,y)
		if self.选择框组[i]:事件判断() then
			self.选择框组[i]:置打勾框(not self.选择框显示[i])
			self.选择框显示[i] = not self.选择框显示[i]
		end
	end
	self.普通:更新(x,y)
	if self.普通:事件判断() then
		self.普通:置打勾框(not self.普通显示)
		self.普通显示 = not self.普通显示
		for i=1,#self.选择框组 do
			self.选择框组[i]:置打勾框(not self.选择框显示[i])
			self.选择框显示[i] = not self.选择框显示[i]
		end
	end
	self.背景窗口:显示(self.x-16,self.y-17)
	self.NPC查找Q:显示(self.x-16,self.y-43)
	if self.普通显示 or self.选择框显示[1] or self.选择框显示[2] or self.选择框显示[3] or self.选择框显示[4] or self.选择框显示[5] or self.选择框显示[6] then
		self.小地图:置颜色(-6579301)
	else
		self.小地图:置颜色(4294967295)
	end
	self.小地图:显示(self.x,self.y)
	if self.额外显示 then
		for k,v in pairs(self.额外显示) do
			if v.等级字体 then
				if v.红字体 then
						tp.字体表.排行字体:置颜色(ARGB(255,255,0,0))
				else
					    tp.字体表.排行字体:置颜色(ARGB(255,45,74,220))
				end
			else
				tp.字体表.排行字体:置颜色(白色)--白色文字
			end
			tp.字体表.排行字体:显示(math.floor(v.x * 2 + self.x),math.floor(v.y * 2 + self.y),v.名称)
		end
	end
	tp.字体表.排行字体:置颜色(4294967295)
	if self.选择框显示[6] and self.传送列表 and self.传送列表[1] then
		self.迷你传送阵:更新(dt)
		for k,v in pairs(self.传送列表) do
		   	self.迷你传送阵:显示(math.floor(v.xy.x * self.偏移X-11 + self.x),math.floor(v.xy.y * self.偏移Y+11 + self.y))
		end
	end
	if self.NPC列表 then
		for k,v in pairs(self.NPC列表) do
			if v.地图颜色 then
				if (v.地图颜色 == 0 or v.地图颜色==1) and self.选择框显示[1] then
					tp.字体表.排行字体:置颜色(0xFFFFFFFF)--白色文字
					tp.字体表.排行字体:显示((math.floor(v.xy.x * self.偏移X + self.x-(tp.字体表.排行字体:取宽度(v.名称)/2)+6)),math.floor(v.xy.y * self.偏移Y + 4 + self.y),v.名称)
		        elseif v.地图颜色 == 2 and self.选择框显示[2] then
		            	tp.字体表.排行字体:置颜色(-256)--白色文字
		            	tp.字体表.排行字体:显示((math.floor(v.xy.x * self.偏移X + self.x-(tp.字体表.排行字体:取宽度(v.名称)/2)+6)),math.floor(v.xy.y * self.偏移Y + 4 + self.y),v.名称)
		        elseif v.地图颜色 == 3 and self.选择框显示[3] then
		            	tp.字体表.排行字体:置颜色(0xFF00FF00)--白色文字
		            	tp.字体表.排行字体:显示((math.floor(v.xy.x * self.偏移X + self.x-(tp.字体表.排行字体:取宽度(v.名称)/2)+6)),math.floor(v.xy.y * self.偏移Y + 4 + self.y),v.名称)
				elseif v.地图颜色 == 4 and self.选择框显示[4] then
		            	tp.字体表.排行字体:置颜色(0xFFFF0000)--白色文字
		            	tp.字体表.排行字体:显示((math.floor(v.xy.x * self.偏移X + self.x-(tp.字体表.排行字体:取宽度(v.名称)/2)+6)),math.floor(v.xy.y * self.偏移Y + 4 + self.y),v.名称)
		        elseif v.地图颜色 == 5 and self.选择框显示[5] then
		            	tp.字体表.排行字体:置颜色(0xFF03A89E)--白色文字
		            	tp.字体表.排行字体:显示((math.floor(v.xy.x * self.偏移X + self.x-(tp.字体表.排行字体:取宽度(v.名称)/2)+6)),math.floor(v.xy.y * self.偏移Y + 4 + self.y),v.名称)
		        end
			end
		end
	end
	local v = self.x + self.背景窗口.宽度 - 48
	local v2 = self.y + self.背景窗口.高度 - 48
	self.资源组[2]:显示(v+16,self.y-16)--关闭按钮
	if self.宽度>= 500 then
		self.普通:显示(self.x-5,v2-3,true)--全部选择框
		for i=1,#self.选择框组 do
			self.选择框组[i]:显示(self.x-5+i*60,v2-3,true)
		end
		tp.字体表.排行字体1:置颜色(0xFF03A89E):显示(self.x +23,v2+2 ,"全部")
		tp.字体表.排行字体1:置颜色(0xFFFFFFFF):显示(self.x +60+23,v2 +2,"普通")
		tp.字体表.排行字体1:置颜色(-256):显示(self.x +120+23,v2+2 ,"商业")
		tp.字体表.排行字体1:置颜色(0xFF00FF00):显示(self.x +180+23,v2 +2,"特殊")
		tp.字体表.排行字体1:置颜色(0xFFFF0000):显示(self.x +240+23,v2 +2,"传送")
		tp.字体表.排行字体1:置颜色(0xFF03A89E):显示(self.x +300+23,v2 +2,"任务")
		tp.字体表.排行字体1:置颜色(0xFFFF00FF):显示(self.x +360+23,v2 +2,"出口")
		self.资源组[1]:显示(v-34,v2)--世界按钮
	else
		self.普通:显示(v-32,self.y + 13,true)--全部选择框
		for i=1,#self.选择框组 do
			self.选择框组[i]:显示(v-32,self.y + 15+i*30,true)
		end
		tp.字体表.排行字体1:置颜色(0xFF03A89E):显示(v-5,self.y + 20,"全部")
		tp.字体表.排行字体1:置颜色(0xFFFFFFFF):显示(v-5,self.y + 52,"普通")
		tp.字体表.排行字体1:置颜色(-256):显示(v-5,self.y + 82,"商业")
		tp.字体表.排行字体1:置颜色(0xFF00FF00):显示(v-5,self.y + 112,"特殊")
		tp.字体表.排行字体1:置颜色(0xFFFF0000):显示(v-5,self.y + 142,"传送")
		tp.字体表.排行字体1:置颜色(0xFF03A89E):显示(v-5,self.y + 172,"任务")
		tp.字体表.排行字体1:置颜色(0xFFFF00FF):显示(v-5,self.y + 202,"出口")
		self.资源组[1]:显示(v-34,v2)
	end

	local 鼠标坐标 = 生成XY(math.floor((x - self.x)/(self.宽度/(小地图宽度/20))),math.floor((y - self.y)/(self.高度/(小地图高度/20))))
		if  self.小地图:是否选中(x,y) and self.鼠标 and not tp.消息栏焦点 then
				tp.提示:自定义(x+6,y+6,string.format("#Y/%d，%d", 鼠标坐标.x,鼠标坐标.y))
				if 引擎.鼠标弹起(0) and not tp.战斗中 and self.鼠标 and self.超级传送 then
					 请求服务(35,{地图=self.记忆地图,飞行坐标=鼠标坐标})
					 self:打开()
				end
		end


end

function 场景类_世界地图分类小地图:检查点(x,y)
	if self.背景窗口:是否选中(x,y) then
		return true
	end
end

function 场景类_世界地图分类小地图:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_世界地图分类小地图:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

function 取场景等级宽高(map)
	if map == 1001 or map == 4001 then
		return 11000,5600
	elseif map == 1002 then
		return 2560,1920
	elseif map == 1003 then
		return 3740,1980
	elseif map == 1004 then
		return 2760,1540
	elseif map == 1005 then
		return 2760,1560
	elseif map == 1006 then
		return 2760,1600
	elseif map == 1007 then
		return 2760,1560
	elseif map == 1008 then
		return 2760,1560
	elseif map == 1009 then
		return 1600,1200
	elseif map == 1012 then
		return 800,600
	elseif map == 1013 then
		return 1060,780
	elseif map == 1014 then
		return 1000,740
	elseif map == 1015 then
		return 800,600
	elseif map == 1016 then
		return 1020,760
	elseif map == 1017 then
		return 1000,740
	elseif map == 1018 then
		return 800,560
	elseif map == 1019 then
		return 1100,820
	elseif map == 1020 then
		return 800,600
	elseif map == 1021 then
		return 1020,760
	elseif map == 1022 then
		return 920,680
	elseif map == 1023 then
		return 800,600
	elseif map == 1024 then
		return 960,720
	elseif map == 1025 then
		return 1020,760
	elseif map == 1026 then
		return 1600,1200
	elseif map == 1028 then
		return 1280,960
	elseif map == 1029 then
		return 1280,960
	elseif map == 1030 then
		return 1000,740
	elseif map == 1031 then
		return 800,600
	elseif map == 1032 then
		return 800,600
	elseif map == 1033 then
		return 1400,1040
	elseif map == 1034 then
		return 880,620
	elseif map == 1035 then
		return 800,600
	elseif map == 1036 then
		return 800,600
	elseif map == 1037 then
		return 1000,740
	elseif map == 1038 then
		return 1280,960
	elseif map == 1040 then
		return 3280,2480
	elseif map == 1041 or map == 7004 then
		return 2560,1920
	elseif map == 1042 then
		return 2560,1920
	elseif map == 1043 then
		return 800,600
	elseif map == 1044 then
		return 2560,1920
	elseif map == 1046 then
		return 800,600
	elseif map == 1049 then
		return 1600,1200
	elseif map == 1050 then
		return 1020,760
	elseif map == 1051 then
		return 1020,760
	elseif map == 1052 then
		return 848,648
	elseif map == 1054 then
		return 1020,760
	elseif map == 1056 then
		return 960,720
	elseif map == 1057 then
		return 1200,900
	elseif map == 1070 then
		return 3200,4200
	elseif map == 1072 then
		return 640,480
	elseif map == 1075 then
		return 800,600
	elseif map == 1077 then
		return 800,600
	elseif map == 1078 then
		return 800,600
	elseif map == 1079 then
		return 800,600
	elseif map == 1080 then
		return 800,600
	elseif map == 1081 then
		return 800,600
	elseif map == 1082 then
		return 640,480
	elseif map == 1083 then
		return 800,600
	elseif map == 1084 then
		return 800,600
	elseif map == 1085 then
		return 800,600
	elseif map == 1087 then
		return 800,600
	elseif map == 1090  or map == 1622 then
		return 2760,1560
	elseif map == 1091 then
		return 3840,3360
	elseif map == 1092 then
		return 4480,3020
	elseif map == 1093 then
		return 1060,720
	elseif map == 1094 then
		return 800,600
	elseif map == 1095 then
		return 1040,740
	elseif map == 1098 then
		return 900,680
	elseif map == 1099 then
		return 1260,800
	elseif map == 1100 then
		return 1200,900
	elseif map == 1101 then
		return 800,600
	elseif map == 1103 then
		return 1800,1360
	elseif map == 1104 then
		return 1100,760
	elseif map == 1105 then
		return 800,600
	elseif map == 1106 then
		return 1160,740
	elseif map == 1107 then
		return 800,600
	elseif map == 1110 then
		return 7040,6720
	elseif map == 1111 then
		return 5060,3360
	elseif map == 1112  then
		return 2000,1500
	elseif map == 1113 then
		return 800,600
	elseif map == 1114 or map== 10008 or map== 10018  then
		return 2560,1920
	elseif map == 1115 then
		return 1600,1100
	elseif map == 1116 or map== 10006 or map== 10016 then
		return 4260,2320
	elseif map == 1117 then
		return 1200,900
	elseif map == 1118 then
		return 1280,960
	elseif map == 1119 then
		return 1280,960
	elseif map == 1120 then
		return 1280,960
	elseif map == 1121 then
		return 1280,960
	elseif map == 1122 then
		return 3200,2400
	elseif map == 1123 then
		return 1200,900
	elseif map == 1124 then
		return 960,720
	elseif map == 1125 then
		return 800,600
	elseif map == 1126 then
		return 2400,1800
	elseif map == 1127 then
		return 2400,1800
	elseif map == 1128 then
		return 2400,1800
	elseif map == 1129 then
		return 2400,1800
	elseif map == 1130 then
		return 2400,1800
	elseif map == 1131 or map== 10003 or map==10013 then
		return 2640,1980
	elseif map == 1132 then
		return 800,600
	elseif map == 1133 then
		return 800,600
	elseif map == 1134 then
		return 1160,780
	elseif map == 1135 then
		return 3760,3360
	elseif map == 1137 then
		return 1500,1120
	elseif map == 1138 then
		return 1760,3500
	elseif map == 1139 then
		return 2040,3420
	elseif map == 1140 then
		return 1920,1440
	elseif map == 1141 then
		return 1280,960
	elseif map == 1142 or  map== 10002 or  map== 10012 then
		return 2560,2880
	elseif map == 1143 then
		return 1024,768
	elseif map == 1144 then
		return 1020,1200
	elseif map == 1145 then
		return 1024,768
	elseif map == 1146 then
		return 2000,1500
	elseif map == 1147 then
		return 1000,680
	elseif map == 1149 then
		return 800,600
	elseif map == 1150 then
		return 2240,3080
	elseif map == 1152 then
		return 800,600
	elseif map == 1153 then
		return 1000,680
	elseif map == 1154 then
		return 1240,1000
	elseif map == 1155 then
		return 860,740
	elseif map == 1156 then
		return 1600,1200
	elseif map == 1165 then
		return 1920,1320
	elseif map == 1167 then
		return 800,600
	elseif map == 1168 then
		return 900,600
	elseif map == 1170 or map== 7002 then
		return 1100,820
	elseif map == 1171 then
		return 640,480
	elseif map == 1173 then
		return 12800,2400
	elseif map == 1174 then
		return 4560,3400
	elseif map == 1175 then
		return 1900,1120
	elseif map == 1177 then
		return 3320,1860
	elseif map == 1178 then
		return 2720,1460
	elseif map == 1179 then
		return 2920,1680
	elseif map == 1180 then
		return 2840,1420
	elseif map == 1181 then
		return 2800,1440
	elseif map == 1182 then
		return 2760,1600
	elseif map == 1183 then
		return 2840,1680
	elseif map == 1186 then
		return 2560,1440
	elseif map == 1187 then
		return 2560,1440
	elseif map == 1188 then
		return 2560,1440
	elseif map == 1189 then
		return 2560,1440
	elseif map == 1190 then
		return 2560,1440
	elseif map == 1191 then
		return 2560,1440
	elseif map == 1192 then
		return 2560,1440
	elseif map == 1193 or map== 1621 then
		return 3200,2400
	elseif map == 1197 or map== 10000 or map== 10001 then
		return 2560,1440
	elseif map == 1198 then
		return 3300,2080
	elseif map == 1201 or map== 10009 then
		return 3840,2880
	elseif map == 1202 then
		return 3840,2880
	elseif map == 1203 then
		return 3200,4800
	elseif map == 1204 then
		return 3840,2880
	elseif map == 1205 then
		return 2560,2880
	elseif map == 1206 or  map== 8000  then
		return 5120,3840
	elseif map == 1207 then
		return 3840,2900
	elseif map == 1208 then
		return 3840,2400
	elseif map == 1209 then
		return 1920,1440
	elseif map == 1210 then
		return 3820,2860
	elseif map == 1211 or map== 10007 or map== 10017 then
		return 1260,1900
	elseif map == 1212 then
		return 2560,1920
	elseif map == 1213 then
		return 2560,1440
	elseif map == 1214 then
		return 2560,1920
	elseif map == 1215 then
		return 2560,1920
	elseif map == 1216 then
		return 4480,2880
	elseif map == 1217 then
		return 5120,4420
	elseif map == 1218 or map== 10004 or map== 10014 then
		return 1920,3360
	elseif map == 1219 then
		return 1580,840
	elseif map == 1220 then
		return 1020,860
	elseif map == 1221 or map==5003 then
		return 3840,2400
	elseif map == 1222 then
		return 900,740
	elseif map == 1223 then
		return 2560,1920
	elseif map == 1224 then
		return 900,900
	elseif map == 1225 then
		return 900,900
	elseif map == 1226 then
		return 3200,2400
	elseif map == 1227 then
		return 1780,1280
	elseif map == 1228 then
		return 1920,3840
	elseif map == 1229 then
		return 1920,2880
	elseif map == 1230 then
		return 5120,3260
	elseif map == 1231 then
		return 3200,1900
	elseif map == 1232 then
		return 3200,1920
	elseif map == 1233 then
		return 3200,2120
	elseif map == 1234 then
		return 1600,1200
	elseif map == 1235 then
		return 12800,1920
	elseif map == 1236 then
		return 1180,880
	elseif map == 1237 or map== 7001 then
		return 5080,2400
	elseif map == 1237100 then
		return 5080,2400
	elseif map == 1238 then
		return 1920,3840
	elseif map == 1239 then
		return 1180,880
	elseif map == 1241 then
		return 3840,2160
	elseif map == 1242 then
		return 2260,4020
	elseif map == 1242001 then
		return 1808,3216
	elseif map == 1242105 then
		return 1808,3216
	elseif map == 1243 then
		return 2920,2320
	elseif map == 1245 then
		return 2000,1440
	elseif map == 1246 then
		return 1380,1440
	elseif map == 1300 then
		return 10880,5760
	elseif map == 1301 then
		return 10880,5760
	elseif map == 1302 then
		return 10880,5760
	elseif map == 1306 then
		return 3000,1800
	elseif map == 1310 then
		return 1600,1200
	elseif map == 1311 then
		return 1600,1200
	elseif map == 1312 then
		return 1600,1200
	elseif map == 1313 then
		return 1600,1200
	elseif map == 1314 then
		return 1600,1200
	elseif map == 1315 then
		return 1600,1200
	elseif map == 1316 then
		return 1600,1200
	elseif map == 1317 then
		return 1600,1200
	elseif map == 1318 then
		return 1600,1200
	elseif map == 1319 then
		return 1600,1200
	elseif map == 1320 then
		return 2100,1560
	elseif map == 1321 then
		return 2100,1560
	elseif map == 1322 then
		return 2100,1560
	elseif map == 1323 then
		return 2100,1560
	elseif map == 1324 then
		return 2100,1560
	elseif map == 1325 then
		return 2100,1560
	elseif map == 1326 then
		return 2100,1560
	elseif map == 1327 then
		return 2100,1560
	elseif map == 1328 then
		return 2100,1560
	elseif map == 1329 then
		return 2100,1560
	elseif map == 1330 then
		return 800,600
	elseif map == 1331 then
		return 1040,780
	elseif map == 1332 then
		return 1600,1200
	elseif map == 1333 then
		return 800,600
	elseif map == 1334 then
		return 1040,780
	elseif map == 1335 then
		return 1600,1200
	elseif map == 1336 then
		return 800,600
	elseif map == 1337 then
		return 1040,780
	elseif map == 1338 then
		return 1600,1200
	elseif map == 1339 then
		return 3840,2400
	elseif map == 1340 then
		return 1280,800
	elseif map == 1341 then
		return 1540,900
	elseif map == 1342 then
		return 2000,1200
	elseif map == 1343 then
		return 3840,2400
	elseif map == 1380 then
		return 3000,1800
	elseif map == 1382 then
		return 3000,1800
	elseif map == 1400 then
		return 1600,1100
	elseif map == 1401 then
		return 800,600
	elseif map == 1402 then
		return 1040,780
	elseif map == 1403 then
		return 1600,1200
	elseif map == 1404 then
		return 800,600
	elseif map == 1405 then
		return 1040,780
	elseif map == 1406 then
		return 1600,1200
	elseif map == 1407 then
		return 800,600
	elseif map == 1408 then
		return 1040,780
	elseif map == 1409 then
		return 1600,1200
	elseif map == 1410 then
		return 800,600
	elseif map == 1411 then
		return 1040,780
	elseif map == 1412 or map== 7003 then
		return 1600,1200
	elseif map == 1413 then
		return 800,600
	elseif map == 1414 then
		return 1040,780
	elseif map == 1415 then
		return 1600,1200
	elseif map == 1416 then
		return 800,600
	elseif map == 1417 then
		return 1040,780
	elseif map == 1418 then
		return 1600,1200
	elseif map == 1420 then
		return 1280,800
	elseif map == 1421 then
		return 1540,900
	elseif map == 1422 then
		return 2000,1200
	elseif map == 1424 then
		return 2000,1200
	elseif map == 1425 then
		return 2000,1200
	elseif map == 1426 then
		return 2000,1200
	elseif map == 1427 then
		return 3000,1800
	elseif map == 1428 then
		return 3000,1800
	elseif map == 1429 then
		return 3000,1800
	elseif map == 1430 then
		return 3000,1800
	elseif map == 1446 then
		return 3000,1800
	elseif map == 1447 then
		return 3000,1800
	elseif map == 1501 then
		return 5760,2880
	elseif map == 1502 then
		return 640,520
	elseif map == 1503 then
		return 720,580
	elseif map == 1504 then
		return 800,600
	elseif map == 1505 then
		return 1000,760
	elseif map == 1506 then
		return 2400,2400
	elseif map == 1507 then
		return 3200,1440
	elseif map == 1508 then
		return 1620,1500
	elseif map == 1509 then
		return 960,720
	elseif map == 1511 then
		return 3200,2400
	elseif map == 1512 then
		return 2400,1800
	elseif map == 1513 then
		return 4000,3000
	elseif map == 1514 or map== 10005 or map== 10015  then
		return 3200,2400
	elseif map == 1523 then
		return 800,600
	elseif map == 1524 then
		return 960,680
	elseif map == 1525 then
		return 640,520
	elseif map == 1526 then
		return 900,740
	elseif map == 1527 then
		return 880,740
	elseif map == 1528 then
		return 1160,780
	elseif map == 1529 then
		return 960,720
	elseif map == 1531 then
		return 1000,760
	elseif map == 1532 then
		return 1280,960
	elseif map == 1533 then
		return 760,540
	elseif map == 1534 then
		return 920,640
	elseif map == 1535 then
		return 1080,760
	elseif map == 1536 then
		return 800,600
	elseif map == 1537 then
		return 1020,760
	elseif map == 1605 then
		return 3000,2000
	elseif map == 1606 then
		return 3000,2000
	elseif map == 1607 then
		return 3000,2000
	elseif map == 1608 then
		return 3000,2000
	elseif map == 1810 then
		return 640,480
	elseif map == 1811 then
		return 640,480
	elseif map == 1812 then
		return 800,600
	elseif map == 1813 then
		return 800,600
	elseif map == 1814 then
		return 960,720
	elseif map == 1815 then
		return 960,720
	elseif map == 1820 then
		return 700,480
	elseif map == 1821 then
		return 700,480
	elseif map == 1822 then
		return 750,500
	elseif map == 1823 then
		return 750,500
	elseif map == 1824 then
		return 800,600
	elseif map == 1825 then
		return 800,600
	elseif map == 1830 then
		return 700,520
	elseif map == 1831 then
		return 700,520
	elseif map == 1832 then
		return 800,600
	elseif map == 1833 then
		return 800,600
	elseif map == 1834 then
		return 800,600
	elseif map == 1835 then
		return 800,600
	elseif map == 1840 then
		return 640,480
	elseif map == 1841 then
		return 640,480
	elseif map == 1842 then
		return 640,480
	elseif map == 1843 then
		return 640,480
	elseif map == 1844 then
		return 800,600
	elseif map == 1845 then
		return 800,600
	elseif map == 1850 then
		return 640,540
	elseif map == 1851 then
		return 640,540
	elseif map == 1852 then
		return 800,600
	elseif map == 1853 then
		return 800,600
	elseif map == 1854 then
		return 750,560
	elseif map == 1855 then
		return 750,560
	elseif map == 1860 then
		return 640,480
	elseif map == 1861 then
		return 640,480
	elseif map == 1862 then
		return 720,540
	elseif map == 1863 then
		return 720,540
	elseif map == 1864 then
		return 800,600
	elseif map == 1865 then
		return 800,600
	elseif map == 1870 then
		return 800,600
	elseif map == 1871 then
		return 800,600
	elseif map == 1872 then
		return 1040,780
	elseif map == 1873 then
		return 1040,780
	elseif map == 1874 then
		return 1200,900
	elseif map == 1875 then
		return 1200,900
	elseif map == 1876  then
		return 3000,2100
	elseif map == 1885 then
		return 2000,1200
	elseif map == 1886 then
		return 2000,1200
	elseif map == 1887 then
		return 2000,1200
	elseif map == 1888 then
		return 2000,1200
	elseif map == 1890 then
		return 1280,800
	elseif map == 1891 then
		return 1540,900
	elseif map == 1892 then
		return 2000,1200
	elseif map == 1910 then
		return 2760,1560
	elseif map == 1911 then
		return 2760,1540
	elseif map == 1912 then
		return 2760,1560
	elseif map == 1913 then
		return 2760,1600
	elseif map == 1914 then
		return 2760,1560
	elseif map == 1915 then
		return 2760,1560
	elseif map == 1916 then
		return 1600,1200
	elseif map == 1920 then
		return 2400,4480
	elseif map == 1920001 then
		return 1920,3584
	elseif map == 1920105 then
		return 1920,3584
	elseif map == 1930 then
		return 3960,2560
	elseif map == 1931 then
		return 3960,2560
	elseif map == 1932 then
		return 3960,2520
	elseif map == 1933 then
		return 2000,1560
	elseif map == 1934 then
		return 2000,1560
	elseif map == 1935 then
		return 2000,1560
	elseif map == 1936 then
		return 2000,1560
	elseif map == 1937 then
		return 2000,1560
	elseif map == 1938 then
		return 2000,1560
	elseif map == 1939 then
		return 2000,1560
	elseif map == 1940 then
		return 2000,1560
	elseif map == 1941 then
		return 2000,1560
	elseif map == 1942 then
		return 2000,1560
	elseif map == 1943 then
		return 2000,1560
	elseif map == 1944 then
		return 2000,1560
	elseif map == 1945 then
		return 2000,1560
	elseif map == 1946 then
		return 2000,1560
	elseif map == 1947 then
		return 2000,1560
	elseif map == 1948 then
		return 2000,1560
	elseif map == 1949 then
		return 2000,1560
	elseif map == 1950 then
		return 2000,1560
	elseif map == 1951 then
		return 2000,1560
	elseif map == 1952 then
		return 2000,1560
	elseif map == 1953 then
		return 800,600
	elseif map == 1954 then
		return 1040,780
	elseif map == 1955 then
		return 1600,1200
	elseif map == 2000 then
		return 2815,1926
	end
end
return 场景类_世界地图分类小地图
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-18 04:29:49
--======================================================================--
local 场景类_小地图 = class()
local tp
local bw = require("gge包围盒")(0,0,0,16)
local box = 引擎.画矩形
function 场景类_小地图:初始化(根)
	self.ID = 1
	self.注释 = "小地图"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.记忆地图 = 0
	self.窗口时间 = 0
	self.目标格子 = 生成XY()
	tp = 根
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	self.标记 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x393947EB)
	self.终点 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xDEE57252)
	self.迷你传送阵 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x558897FF)
	self.NPC查找Q = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0BC4D521),0,0,4,true,true,"")
	self.普通 = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true)
	self.普通:置根(根)
	self.普通:置偏移(-3,2)
	self.传送 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x558897FF)
	self.普通显示 = false
	self.偏移X = 0
	self.偏移Y = 0
	self.背景窗口 = tp._自适应.创建(0,1,0,0,3,9)
	self.背景条=tp._自适应.创建(1,1,44,18,1,3,nil,18)
	self.窗口时间 = 0
	self.目标格子 = nil
	self.xx = 0
	self.yy = 0
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] =  按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"世界"),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭按钮
		[3] = 资源:载入(wdf配置.."/pic/地图小背景.png", "图片"),

	}
	self.普通显示 = false
	self.选择框显示 = {false,false,false,false,false,false}
	self.选择框组 = {
		[1] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
		[2] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
		[3] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
		[4] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
		[5] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),
		[6] = 根._按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x11F8B522),0,0,1,true,true),


	}
	for i=1,#self.选择框组 do
		self.选择框组[i]:置根(根)
		self.选择框组[i]:置偏移(-3,2)
		self.选择框组[i]:绑定窗口_(1)
	end
	文字 = require("gge文字类")(wdf配置.."/font/hkyt.ttf",16,0,true)--(文件,大小,粗体,可描边,抗锯齿)
	文字:置字间距(1)
	文字:置描边颜色(0xFFFFFFFF)--白色 置描边颜色  置阴影颜色
	文字:置颜色(ARGB(255,45,74,220))--0,40,247
	小地图等级 = 根.字体表.排行字体
	self.路点=资源:载入("wdf/pic/路点.png","图片")
	self.小旗子 =资源:载入('登陆资源.wdf',"网易WDF动画",0xDEE57252)
end

function 场景类_小地图:打开(map)
	self.额外显示 = nil
	if not map or self.记忆地图~= map then map =tp.当前地图 end
	local Smap,Smapa = 小地图资源加载(map)
	if Smap == nil then
		if self.可视 then
			self.可视 = false
			self.普通显示 = false
			self.普通:置打勾框(self.普通显示)
		else
			tp.窗口.消息框:添加文本("此场景无法查看小地图")
		end
		return
	else
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
				self.背景窗口:置宽高(self.宽度+v+2,self.高度+v+86)
			else
			    self.背景窗口:置宽高(self.宽度+84,self.高度+v+54)
			end
			self.偏移X = (self.宽度 - 20) / tp.场景.地图.宽度
			self.偏移Y = (self.高度 - 20)/ tp.场景.地图.高度
			self.记忆地图 = map
		elseif self.记忆地图 == map and self.可视 then
		    self.可视 = false
			return
		end
	end

	self.普通显示 = false
	self.普通:置打勾框(false)
	self.地图名称 = 取地图名称(self.记忆地图)
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


	self.lj=self:取dt路径(self.地图名称)
	self.ljsl=#self.lj
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

function 场景类_小地图:清空()
	self.目标格子 = nil
end

function 场景类_小地图:显示(dt,x,y)
	if self.记忆地图==nil then
	    return
	end
	for i=1,2 do
	   self.资源组[i]:更新(x,y)
	end
	self.NPC查找Q:更新(x,y)
	if self.鼠标 then
		if self.资源组[1]:事件判断() then
			self:打开()
			tp.窗口.世界大地图:打开()
		elseif self.资源组[2]:事件判断() then
			self:打开()
		-- 	tp.窗口.世界地图分类小地图:打开(1135)
		end
	end
	if self.NPC查找Q:事件判断() then
	    tp.窗口.小地图NPC:打开()
	end
	self.选中人物 = false
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

	self.背景窗口:显示(self.x-10,self.y-58)
    self.背景条:置宽高(self.背景窗口.宽度-4,18)
    self.背景条:显示(self.x-8,self.y-54)
	tp.窗口标题背景_[4]:显示(self.x+self.背景窗口.宽度/2-72,self.y-58)
	tp.字体表.标题字体:置颜色(白色):显示(self.x+3+self.背景窗口.宽度/2-80+tp.窗口标题背景_[4].宽度/2-tp.字体表.标题字体:取宽度(self.地图名称)/2,self.y-57,self.地图名称)
	if self.lj~=nil and self.ljsl~=nil then
		for n=1,self.ljsl do
		     self.资源组[3]:显示(self.x+n*92-92,self.y-28)
		     tp.字体表.排行字体1:置颜色(白色):显示(self.x+5+(self.资源组[3]:取宽度()/2+19-tp.字体表.排行字体1:取宽度(self.lj[n]))/2+n*92-92,self.y-25,self.lj[n])
	    end
		for n=1,self.ljsl-1 do
	     tp.字体表.标题字体:置颜色(0xFF344779):显示(self.x+75+n*92-92,self.y-25,"〉")
	    end
    end
	self.NPC查找Q:显示(self.x-10,self.y-80)
	if self.普通显示 or self.选择框显示[1] or self.选择框显示[2] or self.选择框显示[3] or self.选择框显示[4] or self.选择框显示[5] or self.选择框显示[6] then
		self.小地图:置颜色(-6579301)
	else
		self.小地图:置颜色(4294967295)
	end
	self.小地图:显示(self.x,self.y)

	--=======地图传送文字名称
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
	local v2 = self.y + self.背景窗口.高度 - 87

	self.资源组[2]:显示(v+18,self.y-54)--关闭按钮
	if self.宽度>= 500 then
		self.普通:显示(self.x-5+10,v2-3,true)--全部选择框
		for i=1,#self.选择框组 do
			self.选择框组[i]:显示(self.x-5+10+i*60,v2-3,true)
		end
		tp.字体表.排行字体1:置颜色(0xFF01FFFF):显示(self.x +23+10,v2+2 ,"全部")
		tp.字体表.排行字体1:置颜色(0xFFFFFFFF):显示(self.x +60+10+23,v2 +2,"普通")
		tp.字体表.排行字体1:置颜色(-256):显示(self.x +120+23+10,v2+2 ,"商业")
		tp.字体表.排行字体1:置颜色(0xFF00FF00):显示(self.x +180+10+23,v2 +2,"特殊")
		tp.字体表.排行字体1:置颜色(0xFFFF0000):显示(self.x +240+10+23,v2 +2,"传送")
		tp.字体表.排行字体1:置颜色(0xFF01FFFF):显示(self.x +300+10+23,v2 +2,"任务")
		tp.字体表.排行字体1:置颜色(0xFFFF01FF):显示(self.x +360+10+23,v2 +2,"出口")
		self.资源组[1]:显示(v-34,v2)--世界按钮
	else
		self.普通:显示(v-32,self.y + 13,true)--全部选择框
		for i=1,#self.选择框组 do
			self.选择框组[i]:显示(v-32,self.y + 15+i*30,true)
		end
		tp.字体表.排行字体1:置颜色(0xFF01FFFF):显示(v-5,self.y + 20,"全部")
		tp.字体表.排行字体1:置颜色(0xFFFFFFFF):显示(v-5,self.y + 52,"普通")
		tp.字体表.排行字体1:置颜色(-256):显示(v-5,self.y + 82,"商业")
		tp.字体表.排行字体1:置颜色(0xFF00FF00):显示(v-5,self.y + 112,"特殊")
		tp.字体表.排行字体1:置颜色(0xFFFF0000):显示(v-5,self.y + 142,"传送")
		tp.字体表.排行字体1:置颜色(0xFF01FFFF):显示(v-5,self.y + 172,"任务")
		tp.字体表.排行字体1:置颜色(0xFFFF01FF):显示(v-5,self.y + 202,"出口")
		self.资源组[1]:显示(v-34,v2)
	end
	if 引擎.鼠标弹起(0) and tp.场景.人物~=nil and (tp.场景.人物.队长开关==nil and #tp.队伍数据 >= 1) then

	else
		if self.目标格子 ~= nil then
			self.终点:显示(self.x + self.目标格子.x,self.y + self.目标格子.y)
		end
		local 角色坐标x = math.floor(tp.角色坐标.x * self.偏移X + self.x)-- + 13 + self.x)
		local 角色坐标y = math.floor(tp.角色坐标.y * self.偏移Y + self.y)--8 + self.y)
		local 鼠标坐标 = 生成XY(math.floor((x - self.x)/(self.宽度/(tp.场景.地图.宽度/20))),math.floor((y - self.y)/(self.高度/(tp.场景.地图.高度/20))))
		self.间隔计次=0
		if tp.场景~=nil and tp.场景.人物~=nil and #tp.场景.人物~=nil then
			for n=1,#tp.场景.人物.目标格子 do
				self.间隔计次=self.间隔计次+1
				if self.间隔计次>=15 and n~=#tp.场景.人物.目标格子 then
					self.临时坐标x=math.floor(tp.场景.人物.目标格子[n].x*20 * self.偏移X + self.x)-- + 13 + self.x)
					self.临时坐标y=math.floor(tp.场景.人物.目标格子[n].y*20 * self.偏移Y + self.y)--8 + self.y)
					self.路点:显示(self.临时坐标x,self.临时坐标y)
				self.间隔计次=0
				elseif n==#tp.场景.人物.目标格子 then
					self.临时坐标x=math.floor(tp.场景.人物.目标格子[n].x*20 * self.偏移X + self.x)-- + 13 + self.x)
					self.临时坐标y=math.floor(tp.场景.人物.目标格子[n].y*20 * self.偏移Y + self.y)--8 + self.y)
					self.小旗子:显示(self.临时坐标x,self.临时坐标y)
				end
			end
			self.标记:显示(角色坐标x,角色坐标y)
			if  self.小地图:是否选中(x,y) and self.鼠标 and not tp.消息栏焦点 and (self.目标格子 == nil or (self.目标格子.x ~= x-self.x and self.目标格子.y ~= y-self.y))  then
				tp.提示:自定义(x+6,y+6,string.format("#Y/%d，%d", 鼠标坐标.x,鼠标坐标.y))
				if 引擎.鼠标弹起(0) and not tp.战斗中 and self.鼠标 and not self.选中人物 then
					tp.运行时间 = tp.运行时间 + 1
					self.窗口时间 = tp.运行时间
					local a = 生成XY(math.floor(tp.角色坐标.x / 20),math.floor(tp.角色坐标.y / 20))
					local 内容={x=鼠标坐标.x,y=鼠标坐标.y,距离=0}
					tp.场景.人物:设置路径(内容)
					客户端:请求服务(1001,鼠标坐标,1)
				end
			end
		end
	end
end
function 场景类_小地图:取dt路径(mc)
	local pz={}
if mc=="长安城" then
		pz={"南瞻部洲","大唐国境",mc}
	elseif mc=="建邺城" then
		pz={"南瞻部洲","大唐国境","长安城","江南野外",mc}
	elseif mc=="东海湾" then
		pz={"南瞻部洲","建邺城",mc}
	elseif mc=="大唐官府" then
		pz={"南瞻部洲","大唐国境","长安城",mc}
	elseif mc=="大雁塔一层" or mc=="大雁塔一层" or mc=="大雁塔二层" or mc=="大雁塔三层" or mc=="大雁塔四层" or mc=="大雁塔五层" or mc=="化生寺"then
		pz={"南瞻部洲","大唐国境","长安城",mc}
	elseif mc=="长寿村" then
		pz={"西牛贺洲",mc}
	elseif mc=="长寿郊外" then
		pz={"西牛贺洲",mc}
	elseif mc=="丝绸之路" then
		pz={"西牛贺洲",mc}
	elseif mc=="西凉女国" then
		pz={"西牛贺洲",mc}
	elseif mc=="朱紫国" then
		pz={"西牛贺洲",mc}
	elseif mc=="碗子山" then
		pz={"西牛贺洲",mc}
	elseif mc=="宝象国" then
		pz={"西牛贺洲","丝绸之路",mc}
	elseif mc=="麒麟山" then
		pz={"西牛贺洲",mc}
	elseif mc=="解阳山" then
		pz={"西牛贺洲",mc}
	elseif mc=="大唐境外" then
		pz={"南瞻部洲",mc}
	elseif mc=="傲来国" then
		pz={"东胜神洲",mc}
	elseif mc=="女儿村" then
		pz={"东胜神洲",mc}
	else
		pz={"东胜神洲",mc}
	end
return pz
end
function 场景类_小地图:检查点(x,y)
	if self.背景窗口:是否选中(x,y) or self.NPC查找Q:是否选中(x,y) then
		return true
	end
end

function 场景类_小地图:初始移动(x,y)
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

function 场景类_小地图:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_小地图
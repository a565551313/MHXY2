--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_世界大地图 = class()
local tp


function 场景类_世界大地图:初始化(根)
	self.ID = 60
	self.x = 137
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "世界大地图"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.超级传送 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.坐标 = {[1]={x=70,y=140},[2]={x=195,y=140},[3]={x=320,y=140},[4]={x=70,y=290},[5]={x=195,y=290},[6]={x=320,y=290}}
end

function 场景类_世界大地图:打开(传送)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		return
	else
		table.insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应= tp._自适应
		self.资源组 = {
		    [1] = 自适应.创建(0,1,670,510,3,9),--黑色条纹背景
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x93E77F54),--516749F4
			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
			[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCC1742A6),0,0,4,true,true,""),--OK--分类c 花果山
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x7FFAB47A),0,0,4,true,true,""),--OK--分类b 长安城
			[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEA1F50E2),0,0,4,true,true,""),--OK--分类d 北俱芦洲
			[7] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCE11152D),0,0,4,true,true,""),--OK
			[8] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0AF24A29),0,0,4,true,true,""),--OK--分类A  朱紫国
			[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF63C410E),0,0,4,true,true,""),--OK
			[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x5ABFF907),0,0,4,true,true,""),--OK
			[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF8A67A7A),0,0,4,true,true,""),--OK
		}
		for i=3,9 do
			self.资源组[i]:绑定窗口_(60)
		end

	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.超级传送 = false
		if 传送~= nil then
			self.超级传送 = 传送
		end
	end
end

function 场景类_世界大地图:显示(dt,x,y)
	for i=3,11 do
	   self.资源组[i]:更新(x,y)
	end
	self.焦点 = false
	if self.鼠标 then
		if self.资源组[3]:事件判断() then--关闭按钮
			self:打开()
		    return
		elseif self.资源组[4]:事件判断() then--分类c 花果山
			self:打开()
			tp.窗口.世界大地图分类c:打开(self.超级传送)
			return
		elseif self.资源组[5]:事件判断() then--分类b 长安
			self:打开()
			tp.窗口.世界大地图分类b:打开(self.超级传送)
			return
		elseif self.资源组[6]:事件判断() then--分类d 北俱芦洲
			self:打开()
			tp.窗口.世界大地图分类d:打开(self.超级传送)
			return
		elseif self.资源组[7]:事件判断() then--龙宫
			self:打开()
			tp.窗口.世界地图分类小地图:打开(1116,self.超级传送)
			return

		elseif self.资源组[8]:事件判断() then--分类A  朱紫国
			self:打开()
			tp.窗口.世界大地图分类a:打开(self.超级传送)
			return

		elseif self.资源组[9]:事件判断() then--月宫
			self:打开()
			tp.窗口.世界地图分类小地图:打开(1114,self.超级传送)
			return

		elseif self.资源组[10]:事件判断() then--天宫
			self:打开()
			tp.窗口.世界地图分类小地图:打开(1111,self.超级传送)
			return

		elseif self.资源组[11]:事件判断() then--蟠桃园
			self:打开()
			tp.窗口.世界地图分类小地图:打开(1231,self.超级传送)
			return

		end
	end

	self.资源组[1]:显示(self.x-15,self.y-15)
	self.资源组[2]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+635,self.y-10)
	self.资源组[4]:显示(self.x + 498,self.y + 162,true)--分类c 花果山
	self.资源组[5]:显示(self.x + 87,self.y + 103,true)--分类b 长安
	self.资源组[6]:显示(self.x + 270,self.y + 10,true)--分类d 北俱芦洲
	self.资源组[7]:显示(self.x + 390,self.y + 376,true)--龙宫
	self.资源组[8]:显示(self.x ,self.y + 55,true)--分类A  朱紫国
	self.资源组[9]:显示(self.x + 73,self.y + 4,true)--
	self.资源组[10]:显示(self.x + 166,self.y + 23,true)
	self.资源组[11]:显示(self.x + 199,self.y-1 ,true)


end

function 场景类_世界大地图:检查点(x,y)
	if self.可视 and  self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_世界大地图:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_世界大地图:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_世界大地图
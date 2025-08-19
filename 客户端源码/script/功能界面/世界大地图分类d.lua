--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_世界大地图分类d = class()
local tp

function 场景类_世界大地图分类d:初始化(根)
	self.ID = 64
	self.x = 137
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "世界大地图分类d"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.坐标 = {[1]={x=70,y=140},[2]={x=195,y=140},[3]={x=320,y=140},[4]={x=70,y=290},[5]={x=195,y=290},[6]={x=320,y=290}}
	self.超级传送 = false
end

function 场景类_世界大地图分类d:打开(传送)
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
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE9EC7A25),
			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭按钮
			[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xA0B51368),0,0,1,true,true),--龙窟
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x13659C02),0,0,1,true,true),--凤巢
			[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEDEEF9AF),0,0,1,true,true),--女娲神殿


		}
		for i=3,6 do
			self.资源组[i]:绑定窗口_(64)
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

function 场景类_世界大地图分类d:显示(dt,x,y)
	for i=3,6 do
	   self.资源组[i]:更新(x,y)
		if self.资源组[i]:是否选中(x,y) then
			self.资源组[i]:置高亮()
		else
			self.资源组[i]:取消高亮()
		end
	end
	self.焦点 = false
	if self.鼠标 then
		if self.资源组[3]:事件判断() then--关闭按钮
			self:打开()
		    return
		elseif self.资源组[4]:事件判断() then--龙窟
			self:打开()
			if not 传送数据[1174] or not NPC列表[1174] then
				请求服务(1008,{地图=1174,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1174,self.超级传送)
			end
			return
		elseif self.资源组[5]:事件判断() then--凤巢
			self:打开()
			if not 传送数据[1174] or not NPC列表[1174] then
				请求服务(1008,{地图=1174,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1174,self.超级传送)
			end
			return
		elseif self.资源组[6]:事件判断() then--女娲神殿
			self:打开()
			if not 传送数据[1201] or not NPC列表[1201] then
				请求服务(1008,{地图=1201,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1201,self.超级传送)
			end
			return
		end
	end


	self.资源组[1]:显示(self.x-15,self.y-15)
	self.资源组[2]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+635,self.y-10)
	self.资源组[4]:显示(self.x + 51,self.y + 166,true)--龙窟
	self.资源组[5]:显示(self.x + 329,self.y + 145,true)--凤巢
	self.资源组[6]:显示(self.x + 160,self.y + 21,true)--女娲神殿



end

function 场景类_世界大地图分类d:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_世界大地图分类d:初始移动(x,y)
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

function 场景类_世界大地图分类d:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_世界大地图分类d
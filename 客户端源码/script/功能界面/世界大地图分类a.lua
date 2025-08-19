--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_世界大地图分类a = class()

local tp


function 场景类_世界大地图分类a:初始化(根)
	self.ID = 61
	self.x = 137
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "世界大地图分类a"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.超级传送 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.坐标 = {[1]={x=70,y=140},[2]={x=195,y=140},[3]={x=320,y=140},[4]={x=70,y=290},[5]={x=195,y=290},[6]={x=320,y=290}}
end

function 场景类_世界大地图分类a:打开(传送)
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
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xBF90A4C2),
			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭按钮
			[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6A154DDE),0,0,1,true,true),--方寸山
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x637B3C48),0,0,1,true,true),--长寿村
			[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0D906C8D),0,0,1,true,true),--宝象国
			[7] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x689EB676),0,0,1,true,true),--朱紫国
			[8] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xE329AD6A),0,0,1,true,true),--西凉女国
			[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x048DA00D),0,0,1,true,true),--麒麟山
			[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xBFF5620B),0,0,1,true,true),--无底洞
			[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x63566DA9),0,0,1,true,true),--比丘国


		}
		for i=3,9 do
			self.资源组[i]:绑定窗口_(61)
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

function 场景类_世界大地图分类a:显示(dt,x,y)
	for i=3,11 do
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
		elseif self.资源组[4]:事件判断() then--分类c 花果山
			self:打开()
			if not 传送数据[1135] or not NPC列表[1135] then
				请求服务(1008,{地图=1135,超级=self.超级传送})
			else
			    tp.窗口.世界地图分类小地图:打开(1135,self.超级传送)
			end
			return
		elseif self.资源组[5]:事件判断() then
			self:打开()
			if not 传送数据[1070] or not NPC列表[1070] then
				请求服务(1008,{地图=1070,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1070,self.超级传送)
			end
			return
		elseif self.资源组[6]:事件判断() then
			self:打开()
			if not 传送数据[1226] or not NPC列表[1226] then
				请求服务(1008,{地图=1226,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1226,self.超级传送)
			end
			return
		elseif self.资源组[7]:事件判断() then
			self:打开()
			if not 传送数据[1208] or not NPC列表[1208] then
				请求服务(1008,{地图=1208,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1208,self.超级传送)
			end
			return
		elseif self.资源组[8]:事件判断() then
			self:打开()
			if not 传送数据[1040] or not NPC列表[1040] then
				请求服务(1008,{地图=1040,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1040,self.超级传送)
			end
			return
		elseif self.资源组[9]:事件判断() then
			self:打开()
			if not 传送数据[1210] or not NPC列表[1210] then
				请求服务(1008,{地图=1210,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1210,self.超级传送)
			end
			return
		elseif self.资源组[10]:事件判断() then
			self:打开()
			if not 传送数据[1139] or not NPC列表[1139] then
				请求服务(1008,{地图=1139,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1139,self.超级传送)
			end
			return
		elseif self.资源组[11]:事件判断() then
			self:打开()
			if not 传送数据[1232] or not NPC列表[1232] then
				请求服务(1008,{地图=1232,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1232,self.超级传送)
			end
			return
		end
	end

	self.资源组[1]:显示(self.x-15,self.y-15)
	self.资源组[2]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+635,self.y-10)
	self.资源组[4]:显示(self.x + 542,self.y + 7,true)--方寸山
	self.资源组[5]:显示(self.x + 414,self.y + 115,true)--长寿村
	self.资源组[6]:显示(self.x + 361,self.y + 190,true)--宝象国
	self.资源组[7]:显示(self.x + 264,self.y + 166,true)--朱紫国
	self.资源组[8]:显示(self.x+488 ,self.y + 335,true)--西凉女国
	self.资源组[9]:显示(self.x + 298,self.y + 269,true)--麒麟山
	self.资源组[10]:显示(self.x + 386,self.y + 220,true)--无底洞
	self.资源组[11]:显示(self.x + 362,self.y+303 ,true)--比丘国

	----下面是旧版数据
	-- self.资源组[4]:显示(self.x + 542,self.y + 7,true)--方寸山
	-- self.资源组[5]:显示(self.x + 414,self.y + 115,true)--长寿村
	-- self.资源组[6]:显示(self.x + 486,self.y + 273,true)--宝象国
	-- self.资源组[7]:显示(self.x + 469,self.y + 328,true)--朱紫国
	-- self.资源组[8]:显示(self.x+456 ,self.y + 199,true)--西凉女国
	-- self.资源组[9]:显示(self.x + 388,self.y + 315,true)--麒麟山
	-- self.资源组[10]:显示(self.x + 226,self.y + 134,true)--无底洞
	-- self.资源组[11]:显示(self.x + 323,self.y+328 ,true)--比丘国


end

function 场景类_世界大地图分类a:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_世界大地图分类a:初始移动(x,y)
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

function 场景类_世界大地图分类a:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_世界大地图分类a
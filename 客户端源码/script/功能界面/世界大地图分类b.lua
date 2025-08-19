--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_世界大地图分类b = class()
local tp


function 场景类_世界大地图分类b:初始化(根)
	self.ID = 62
	self.x = 137
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "世界大地图分类b"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.超级传送 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.坐标 = {[1]={x=70,y=140},[2]={x=195,y=140},[3]={x=320,y=140},[4]={x=70,y=290},[5]={x=195,y=290},[6]={x=320,y=290}}
end

function 场景类_世界大地图分类b:打开(传送)
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
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x0B19A5DC),--长安城
			[3] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭按钮
			[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEA60ABA4),0,0,1,true,true),--小西天
			[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF617F5A9),0,0,1,true,true),--墨家村
			[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x5B96A2DD),0,0,1,true,true),--无名鬼蜮
			[7] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x150B5122),0,0,1,true,true),--魔王寨
			[8] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x9C992236),0,0,1,true,true),--阴曹地府
			[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x991B588D),0,0,1,true,true),--江州
			[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6EA52AE1),0,0,1,true,true),--洪州
			[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xE0C66A6F),0,0,1,true,true),--大唐官府
			[12] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xBF78C1EF),0,0,1,true,true),--狮驼岭
			[13] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFF1D4A14),0,0,1,true,true),--高老庄
			[14] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x301A4FE7),0,0,1,true,true),--盘丝洞
			[15] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x71DF41E1),0,0,1,true,true),--长安城
			[16] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x47FE6497),0,0,1,true,true),--化生寺
			[17] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCA26DE5D),0,0,1,true,true),--五庄观
			[18] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCAF25E94),0,0,1,true,true),--神木林
			[19] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6AB41A9A),0,0,1,true,true),--建邺城
			[20] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xBDAEEA53),0,0,1,true,true),--凌波城
			[21] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xEC9EBCA8),0,0,1,true,true),--普陀山
			[22] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAD1DC28A),0,0,1,true,true),--龙宫
			-- [23] = 资源:载入("wdf/common/kd.wdf","图片"),--女魃墓
			-- [24] = 资源:载入("wdf/common/kb.wdf","图片"),--天机城
		}
		for i=3,22 do
			self.资源组[i]:绑定窗口_(62)
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

function 场景类_世界大地图分类b:显示(dt,x,y)
	for i=3,22 do
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
		elseif self.资源组[4]:事件判断() then--小西天
			self:打开()
			if not 传送数据[1203] or not NPC列表[1203] then
				请求服务(1008,{地图=1203,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1203,self.超级传送)
			end
			return
		elseif self.资源组[5]:事件判断() then--墨家村
			self:打开()
			if not 传送数据[1218] or not NPC列表[1218] then
				请求服务(1008,{地图=1218,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1218,self.超级传送)
			end
			return
		elseif self.资源组[6]:事件判断() then--无名鬼蜮
			self:打开()
			if not 传送数据[1202] or not NPC列表[1202] then
				请求服务(1008,{地图=1202,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1202,self.超级传送)
			end
			return
		elseif self.资源组[7]:事件判断() then--魔王寨
			self:打开()
			if not 传送数据[1512] or not NPC列表[1512] then
				请求服务(1008,{地图=1512,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1512,self.超级传送)
			end
			return
		elseif self.资源组[8]:事件判断() then--阴曹地府n
			self:打开()
			if not 传送数据[1122] or not NPC列表[1122] then
				请求服务(1008,{地图=1122,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1122,self.超级传送)
			end
			return
		elseif self.资源组[9]:事件判断() then--江州
			self:打开()
			if not 传送数据[1110] or not NPC列表[1110] then
				请求服务(1008,{地图=1110,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1110,self.超级传送)
			end
			return
		elseif self.资源组[10]:事件判断() then--洪州
			self:打开()
			if not 传送数据[1110] or not NPC列表[1110] then
				请求服务(1008,{地图=1110,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1110,self.超级传送)
			end
			return
		elseif self.资源组[11]:事件判断() then--大唐官府
			self:打开()
			if not 传送数据[1198] or not NPC列表[1198] then
				请求服务(1008,{地图=1198,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1198,self.超级传送)
			end
			return
		elseif self.资源组[12]:事件判断() then--狮驼岭
			self:打开()
			if not 传送数据[1131] or not NPC列表[1131] then
				请求服务(1008,{地图=1131,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1131,self.超级传送)
			end
			return
		elseif self.资源组[13]:事件判断() then--高老庄
			self:打开()
			if not 传送数据[1173] or not NPC列表[1173] then
				请求服务(1008,{地图=1173,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1173,self.超级传送)
			end
			return
		elseif self.资源组[14]:事件判断() then--盘丝洞
			self:打开()
			if not 传送数据[1513] or not NPC列表[1513] then
				请求服务(1008,{地图=1513,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1513,self.超级传送)
			end
			return
		elseif self.资源组[15]:事件判断() then--长安城
			self:打开()
			if not 传送数据[1001] or not NPC列表[1001] then
				请求服务(1008,{地图=1001,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1001,self.超级传送)
			end
			return
		elseif self.资源组[16]:事件判断() then--化生寺
			self:打开()
			if not 传送数据[1002] or not NPC列表[1002] then
				请求服务(1008,{地图=1002,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1002,self.超级传送)
			end
			return
		elseif self.资源组[17]:事件判断() then--五庄观
			self:打开()
			if not 传送数据[1146] or not NPC列表[1146] then
				请求服务(1008,{地图=1146,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1146,self.超级传送)
			end
			return
		elseif self.资源组[18]:事件判断() then--神木林
			self:打开()
			if not 传送数据[1138] or not NPC列表[1138] then
				请求服务(1008,{地图=1138,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1138,self.超级传送)
			end
			return
		elseif self.资源组[19]:事件判断() then--建邺城
			self:打开()
			if not 传送数据[1501] or not NPC列表[1501] then
				请求服务(1008,{地图=1501,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1501,self.超级传送)
			end
			return
		elseif self.资源组[20]:事件判断() then--凌波城
			self:打开()
			if not 传送数据[1150] or not NPC列表[1150] then
				请求服务(1008,{地图=1150,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1150,self.超级传送)
			end
			return
		elseif self.资源组[21]:事件判断() then--普陀山
			self:打开()
			if not 传送数据[1140] or not NPC列表[1140] then
				请求服务(1008,{地图=1140,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1140,self.超级传送)
			end
			return
		elseif self.资源组[22]:事件判断() then--龙宫
			self:打开()
			if not 传送数据[1116] or not NPC列表[1116] then
				请求服务(1008,{地图=1116,超级=self.超级传送})
			else
				tp.窗口.世界地图分类小地图:打开(1116,self.超级传送)
			end
			return

		end
	end


	self.资源组[1]:显示(self.x-15,self.y-15)
	self.资源组[2]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+635,self.y-10)
	self.资源组[4]:显示(self.x + 51,self.y + 70,true)--小西天
	self.资源组[5]:显示(self.x + 155,self.y + 16,true)--墨家村
	self.资源组[6]:显示(self.x + 274,self.y + 18,true)--无名鬼蜮
	self.资源组[7]:显示(self.x + 189,self.y + 94,true)--魔王寨
	self.资源组[8]:显示(self.x+332 ,self.y + 34,true)--阴曹地府
	self.资源组[9]:显示(self.x + 350,self.y + 114,true)--江州
	self.资源组[10]:显示(self.x + 296,self.y + 129,true)--洪州
	self.资源组[11]:显示(self.x + 451,self.y+101 ,true)--大唐官府
	self.资源组[12]:显示(self.x + 4,self.y+185 ,true)--狮驼岭
	self.资源组[13]:显示(self.x + 106,self.y+232 ,true)--高老庄
	self.资源组[14]:显示(self.x + 213,self.y+194 ,true)--盘丝洞
	self.资源组[15]:显示(self.x + 366,self.y+140 ,true)--长安城
	self.资源组[16]:显示(self.x + 478,self.y+158 ,true)--化生寺
	self.资源组[17]:显示(self.x + 232,self.y+270 ,true)--五庄观
	self.资源组[18]:显示(self.x + 371,self.y+258 ,true)--神木林
	self.资源组[19]:显示(self.x + 470,self.y+231 ,true)--建邺城
	self.资源组[20]:显示(self.x + 372,self.y+314 ,true)--凌波城
	self.资源组[21]:显示(self.x + 332,self.y+411 ,true)--普陀山
	self.资源组[22]:显示(self.x + 470,self.y+374 ,true)--龙宫
	-- self.资源组[23]:显示(self.x + 187,self.y+126 ,true)--女魃墓
	-- self.资源组[24]:显示(self.x + 129,self.y+118 ,true)--天机城

end

function 场景类_世界大地图分类b:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_世界大地图分类b:初始移动(x,y)
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

function 场景类_世界大地图分类b:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_世界大地图分类b
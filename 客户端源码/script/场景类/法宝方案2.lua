local 法宝方案2 = class()
local insert = table.insert
local mousea = 引擎.鼠标弹起

function 法宝方案2:初始化(根)
    self.ID = 42
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = ""
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	local 字体 = tp.字体表.普通字体
	self.法宝数量 = 0
	self.法宝选中 = 0
end

function 法宝方案2:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.背景 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D102)
	self.更换 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D098),0,0,3,true,true,"更换")
	self.关闭 = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x81DD40D3),0,0,3,true,true)
	local 格子 = tp._物品格子
	self.佩戴法宝 = {}
	for n=1,4 do
	    self.佩戴法宝[n] = 格子(0,0,nil,"佩戴法宝")
	end
	self.物品单格子 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D092)
	self.佩戴选中光圈 = 资源:载入('nice.rpk',"网易WDF动画",0x1F73D101)
	self.快速卸下法宝 = {
		[1] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D100),0,0,3,true,true),
		[2] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D100),0,0,3,true,true),
		[3] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D100),0,0,3,true,true),
		[4] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x1F73D100),0,0,3,true,true),
	}
end

function 法宝方案2:打开(x,y,id,注释)
	if self.可视 then
		self.可视 = false
		self.背景=nil
		self.更换=nil
		self.关闭=nil
		self.佩戴法宝=nil
		self.物品单格子=nil
		self.佩戴选中光圈=nil
		self.快速卸下法宝=nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.x = x + 3
		self.y = y - 130
		self.法宝选中 = 0
	    for i=1,4 do
	        self.佩戴法宝[i]:置物品(nil)
	    end
	    self.ID = id
	    self.注释 = 注释
	    self.方案=2
	end
end

function 法宝方案2:更新(x,y)
	self.x = x + 3
	self.y = y - 130
end

function 法宝方案2:显示(dt,x,y)
	local 字体 = tp.字体表.普通字体
	self.焦点 = false
	self.关闭:更新(x,y)
	self.更换:更新(x,y)
 	self.背景:显示(self.x,self.y)
 	self.关闭:显示(self.x+225,self.y+10)
 	self.更换:显示(self.x+82,self.y+100)
 	self.更换:置偏移(29,8)
 	字体:置样式(1)
 	字体:置颜色(白色):显示(self.x+130,self.y+5,self.注释)
 	字体:置颜色(白色):显示(self.x+35,self.y+25,"法宝")
 	字体:置样式(0)
 	for n=1,4 do
 	    self.物品单格子:显示(self.x + 18 + (n-1) * 58 ,self.y + 48)
 	    if self.佩戴法宝[n]~=nil then
	 	    self.佩戴法宝[n]:置坐标(self.x + 20 + (n-1) * 58 ,self.y + 48)
	 		self.佩戴法宝[n]:显示(dt,x,y,true,nil,nil,nil,1)
	 	    if self.佩戴法宝[n].焦点 and not tp.消息栏焦点 then
	 	    	self.佩戴选中光圈:显示(self.x + 7 + (n-1) * 58 ,self.y + 39)
	 	   	end
	 	end
	 	self.快速卸下法宝[n]:更新(x,y)
 		self.快速卸下法宝[n]:显示(self.x + 48 + (n-1) * 58 ,self.y + 78)
 		if self.快速卸下法宝[n]:是否选中(x,y) then
 			tp.提示:自定义(鼠标.x,鼠标.y,"快速卸下法宝")
 		end
 	end
 	if self.关闭:事件判断() then
		self:打开()
	end
end

function 法宝方案2:检查点(x,y)
	if self.可视 and self.背景:是否选中(x,y)  then
		return true
	else
		return false
	end
end
function 法宝方案2:初始移动(x,y)
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

function 法宝方案2:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 法宝方案2
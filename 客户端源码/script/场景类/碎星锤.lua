--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--======================================================================--
local 场景类_碎星锤道具栏 = class()
local require = require
local tp,zts1
local floor = math.floor
local format = string.format
local insert = table.insert

function 场景类_碎星锤道具栏:初始化(根)
	self.x = 89
	self.y = 179
	self.xx = 0
	self.yy = 0
	self.注释 = "碎星锤"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
    zts1 = tp.字体表.描边字体
	self.开始 = 1
	self.结束 = 20
	self.窗口时间 = 0
end

function 场景类_碎星锤道具栏:打开(数据)
	self.数据 = 数据
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		self.物品 = nil
	else
		insert(tp.窗口_,self)
		local 按钮 = require("script/系统类/按钮")
		self.资源组 = {
			[1] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xC6D8094C),
			[2] = 按钮(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4),
			[3] = 按钮(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4),
			[4] = 按钮(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4),
		}
		self.物品 = {}
		local 格子 = tp._物品格子
		for i=1,20 do
	        self.物品[i] = 格子.创建(0,0,i,"道具类")
	    end
		for n=self.开始,self.结束 do
			self.物品[n]:置物品(self.数据.道具.道具[n])
		end
		self.可视 = true
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	end
end

function 场景类_碎星锤道具栏:更新(dt,x,y)

 self.鼠标=self:检查点(x,y)
end
function 场景类_碎星锤道具栏:取可用道具(名称,物品)


end
function 场景类_碎星锤道具栏:显示(dt,x,y)
	if not self.可视 then
		return false
	end
	self.焦点 = false

		if self.鼠标 then
		self.资源组[2]:更新(x,y)
		self.资源组[3]:更新(x,y)
		self.资源组[4]:更新(x,y)
		if self.资源组[2]:事件判断() then
			self:打开()
			return
		elseif self.资源组[3]:事件判断() then

		elseif self.资源组[4]:事件判断() then

		end
	else
		self.资源组[2].焦点 = 0
		if self.开始 ~= 1 then
			self.资源组[3].焦点 = 0
		else
			self.资源组[3].焦点 = 3
		end
		if self.结束 ~= 160 then
			self.资源组[4].焦点 = 0
		else
			self.资源组[4].焦点 = 3
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x + 286,self.y + 6,true)
	self.资源组[3]:显示(self.x + 275,self.y + 38,true)
	self.资源组[4]:显示(self.x + 275,self.y + 221,true)
	zts1:显示(self.x+125,self.y+3,"碎星锤")
	local n = self.开始-1
	local c =  false
	for h=1,4 do
		for l=1,5 do
			n = n + 1
			self.物品[n]:置坐标(l*51-37+self.x+4,h*51+self.y-16)
			self.物品[n]:显示(dt,x,y,self.鼠标,{2})
			if self.物品[n].物品~=nil and self.物品[n].焦点 then
				tp.提示:道具行囊(x,y,self.物品[n].物品)
				if self.物品[n].事件 and self.物品[n].物品.总类 == 2 and self.鼠标 then
                	请求服务(4515,{序列=self.物品[n].物品,序列1=self.数据.编号,序列2=n})
                    self.可视 = false
                    刷新道具逻辑(self.物品[n].物品,n,true)
                end
			end
		end
	end

end

function 场景类_碎星锤道具栏:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
	return false
end

function 场景类_碎星锤道具栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.场景.战斗.移动窗口 = true
	end
	if self.可视 and self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_碎星锤道具栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_碎星锤道具栏
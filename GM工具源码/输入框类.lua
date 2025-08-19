--======================================================================--
--该 文件由GGELUA创建
--
--作者：baidwwy  创建日期：2014-05-29 15:06:58
--======================================================================--
require("gge函数")--分割字符
local 输入框类 = class()

--@参数 文字对象,字体颜色,输入框宽度,输入框高度
function 输入框类:初始化(文字,颜色,宽度,高度)
	self.文字 		= 文字
	self.光标 		= require("gge精灵类").创建(0,0,0,2,高度)
	self.包围盒 	= require ("gge包围盒").创建(0,0,宽度,高度)
	self.闪烁间隔 	= 0.6
	self.计时 		= 0
	self.光标可视 	= true
	self.颜色 		= 颜色

	self.内容 		= {}
	self.长度 		= 0 --用于光标位置显示
	self.显示内容 	= ""
	self.退格时间 	= 0.5
	self.退格速度 	= 0.03
	self.退格计时 	= 0
	self.退格速度计时 	= 0

end

function 输入框类:取光标精灵(v)
	return self.光标
end

function 输入框类:置提示文本(v)
	self.提示文本 = v
end
function 输入框类:取提示文本(v)
	return  self.提示文本
end
function 输入框类:置默认文本(v,c)
	self.默认文本 = v
	self.默认文本颜色 = c
end

function 输入框类:置文本(v)
	self.内容 = {}
	分割字符(v,self.内容)--分割并加入
	self:生成文本()
end

function 输入框类:清空()
	self.内容 = {}
	self:生成文本()
end

function 输入框类:取文本()
	return  self.显示内容
end

function 输入框类:更新(dt)
	--闪烁计算
	self.计时 = self.计时 +dt
	if self.计时 >= self.闪烁间隔 then
		self.计时  = 0
	    self.光标可视 = not self.光标可视
	end
	--获取字符
	local 时间,字符 =  引擎.取输入字符()
	if 时间 ~= 0 and 时间 ~= self.时间 then
		self.时间 = 时间
		if #字符>2 then
			分割字符(字符,self.内容)--分割并加入
		else
			table.insert(self.内容,字符)
		end
		self:生成文本()
	end
	--退格
	if 引擎.按键按下(KEY.BACKSPACE) then
		if #self.内容 >0 then
		    table.remove(self.内容)
		    self:生成文本()
		end
	end
	--按住退格
	if 引擎.按键按住(KEY.BACKSPACE) then
		if #self.内容 >0 then
		    self.退格计时 = self.退格计时 + dt
		    if self.退格计时 > self.退格时间 then
		    	self.退格速度计时 = self.退格速度计时 + dt
		    	if self.退格速度计时>self.退格速度 then
		    		self.退格速度计时 = 0
			        table.remove(self.内容)
			        self:生成文本()
		    	end
		    end
		end
	end
	 if 引擎.按键弹起(KEY.BACKSPACE) then self.退格计时 = 0 end
end

function 输入框类:生成文本()
    self.光标可视 = true
    self.显示内容 = table.concat(self.内容)
    self.长度 = self.文字:取文本宽度(self.显示内容)
end

function 输入框类:显示(x,y)
	self.包围盒:置坐标(x,y)
	if self.光标可视 then
	    self.光标:显示(x+self.长度,y)
	end
	self.文字:置颜色(self.颜色):显示(x,y,self.显示内容)
end


return 输入框类
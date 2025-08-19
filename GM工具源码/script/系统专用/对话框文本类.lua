-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-06-18 02:56:19
-- @最后修改来自: baidwwy
-- @Last Modified time: 2019-08-16 21:24:56
local 丰富文本类 = class()
local 显回调,显内容

function 丰富文本类:初始化(...)
	local arg = {...}
	if type(arg[1]) == 'string' then
		self.宽度 		= arg[4] or 400
		self.高度 		= arg[5] or 200
	else
	    self.宽度 		= arg[1] or 400
		self.高度 		= arg[2] or 200
	end

	self.符号 		= "#"
	self.换行符 	= ""

	self.回调 		= {}
	self.画线 		= require("gge引擎").画线
	self.文字 		= require("gge文字类")()
	self.文字宽度,self.文字高度 	= self.文字:取宽高("A")
	self.行间距 	= 1
	self.元素表 	= {}
	self.显示表 	= {高度 = 0,宽度 = 0}
	self.背景 		= require("Script/系统专用/gge精灵类")()

	self.包围盒 	= require("gge包围盒")(0,0,self.宽度,self.高度)
	self.回调包围盒 = require("gge包围盒")()
	self.默认颜色 	= 0xFFFFFFFF
	self.数量 		= 0
	self.鼠标x 		= 0
	self.鼠标y 		= 0
	self.鼠标弹起 	= false
	self.起始值 	= 0
	self.目标值 	= 0
	self.递增值 	= 1
end

function 丰富文本类:置回调函数(a,b)
	self.回调 = {a,b}
end
function 丰富文本类:置元素函数(v)
	self.元素函数 = v
end
function 丰富文本类:置行距(v)
	self.行间距 	= v
	return self
end
function 丰富文本类:置宽高(w,h)

end
function 丰富文本类:置换行符(v)
	self.换行符 	= v or ''
end
function 丰富文本类:置默认颜色(v)
	self.默认颜色 	= v
end
function 丰富文本类:置文字 (v)
	self.文字 		= v
	self.文字宽度,self.文字高度 	= self.文字:取宽高("A")
	return self
end
function 丰富文本类:置画线 (v)
	self.画线 		= v
	return self
end
function 丰富文本类:置背景 (v)
	self.背景 		= v
	return self
end
function 丰富文本类:添加元素(标识,数据)
	标识 = tostring(标识)
	if type(数据) == 'table' then
	    数据.标识 = 标识
	end
	self.元素表[标识] = 数据
	return self
end
function 丰富文本类:_取元素(标识)--向元素表查找元素，找不到向用户函数获取
	if self.元素表[标识] then
	    return self.元素表[标识]
	elseif self.元素函数 then
		return self.元素函数()
	end
end
function 丰富文本类:_生成段数据(元素,内容)
	local 段数据 = {}
	if type(元素) == 'number' then
		段数据.x 	= 0
		段数据.颜色 = 元素 or self.默认颜色
		段数据.内容 = 内容
		段数据.类型 = 0
		段数据.宽度 = self.文字:取宽度(段数据.内容)
		段数据.高度 = self.文字高度
	else
		段数据.x 	= 0
	    段数据.内容 = 元素
	    段数据.类型 = 1
		段数据.宽度 = 元素:取宽度()
		段数据.高度 = 元素:取高度()
	end
	return 段数据
end
function 丰富文本类:_生成样式(段数据,样式,值)
	if 样式 == 'xx' then --下划线
		段数据.下划线 	= true
	elseif 样式 == 'sx' then --删除线
		段数据.删除线 	= true
	elseif 样式 == 'bj' then --背景颜色
		段数据.背景颜色 = self:_取元素(值)
	elseif 样式 == 'pz' then --碰撞颜色
		段数据.碰撞颜色 = self:_取元素(值)
	elseif 样式 == 'pb' then --碰撞背景颜色
		段数据.碰撞背色 = self:_取元素(值)
	elseif 样式 == 'ht' then --回调标识
		段数据.回调 	= 值 or ''
	elseif 样式 == 'djy' then --段居右
		段数据.居右 = true
	elseif 样式 == 'an' then--按钮
		段数据.按钮 = true
	end
	return 段数据
end
function 丰富文本类:_解析(数据)
	local x 		= 0
	local 行数据  	= {x = 0,宽度 = 0,高度 = self.文字高度,内容 = ''}--行初始化
	if 数据:find('#') then
		for match in (数据.."#"):gmatch("(.-)#") do
		    if match ~= '' then
		    	local 段内容 	= {}--解析前
		    	local 段数据 	= {}--解析后
		        for match2 in (match.."/"):gmatch("(.-)/") do
		        	table.insert(段内容, match2)
		        end
		        local 数量 		= #段内容
		        local 主元素  	= 段内容[1]
		        if 数量 == 1 then --文本或表情
		        	if self:_取元素(主元素) then --存在是非文本
		        		段数据 = self:_生成段数据(self:_取元素(主元素))
		        	else
		        		local _,长度,标识 = 主元素:find('([0-9a-z]*)')--表情和文本同一行 如(#11文本)
		        		if 长度 >0  then
	        			    if self:_取元素(主元素:sub(1,3)) then
		        			    标识 = 主元素:sub(1,3)
		        			    长度 = 3
	        			    elseif self:_取元素(主元素:sub(1,2)) then
		        			    标识 = 主元素:sub(1,2)
		        			    长度 = 2
	        			    elseif self:_取元素(主元素:sub(1,1)) then
		        			    标识 = 主元素:sub(1,1)
		        			    长度 = 1
	        			    end
		        		    if self:_取元素(标识) then
		        		    	主元素 = 主元素:sub(长度+1)
		        		    	段数据 = self:_生成段数据(self:_取元素(标识))
		        		    	段数据.x = x
		        		    	行数据 = self:_添加段数据(行数据,段数据)
		        		    	x = 行数据.宽度
		        		    end
		        		end
		        		段数据 = self:_生成段数据(self.默认颜色,主元素 == '井' and '#' or 主元素)
		        	end
		        elseif 数量 == 2 then--指定颜色文本
		        	段数据 = self:_生成段数据(self:_取元素(主元素),段内容[2] == '井' and '#' or 段内容[2])
		        	if type(self:_取元素(主元素)) == 'table' then
		        		段数据 = self:_生成段数据(self:_取元素(主元素))
	        			local 样式 	= 段内容[2]:match("[a-z]*")
	        			local 值 	= 段内容[2]:match("[a-z]*|(.*)")
	        			段数据 = self:_生成样式(段数据,样式,值)
		        	end
		        else--带有特殊样式的
	        		段数据 = self:_生成段数据(self:_取元素(主元素),段内容[数量])
	        		for i=2,数量-1 do
	        			local 样式 	= 段内容[i]:match("[a-z]*")
	        			local 值 	= 段内容[i]:match("[a-z]*|(.*)")
	        			段数据 = self:_生成样式(段数据,样式,值)
	        			if 样式 == 'jz' then --居中
	        				行数据.居中 = true
	        			elseif 样式 == 'jy' then --居右
	        				行数据.居右 = true
	        			end
	        		end
		        end
		        段数据.x = x
		        if 段数据.居右 then 段数据.x = self.宽度-段数据.宽度 end
		        行数据 = self:_添加段数据(行数据,段数据)
		        x = 行数据.宽度
		    end
		end
	else
		行数据 = self:_添加段数据(行数据,self:_生成段数据(self.默认颜色,数据))
	end

	if 行数据.居中 then 行数据.x = (self.宽度 -行数据.宽度)/2 end
	if 行数据.居右 then 行数据.x = self.宽度 -行数据.宽度 end
	self:_添加行数据(行数据)
end
function 丰富文本类:_复制样式(数据)
	local ret = {}
	for k,v in pairs(数据) do
		ret[k] = v
	end
	ret.x = 0
	return ret
end
function 丰富文本类:_取文本左边(文本,字符数)
	local i = 1
	local ascii = 0
	local ret = ''
	while true do
		ascii = 文本:byte(i)
		if ascii and 字符数 > 0 then
			if ascii < 127 then
				ret = ret ..文本:sub(i, i)
				i = i+1
				字符数 = 字符数 -1
			else
				字符数 = 字符数 -2
				if 字符数 >= 0 then
					ret = ret ..文本:sub(i, i+1)
				    i = i+2
				end
			end
		else
		    break
		end
	end
	return ret,文本:sub(i)
end
function 丰富文本类:_添加行数据(行数据)
	table.insert(self.显示表, 行数据)
	self.显示表.高度  = self.显示表.高度 + 行数据.高度 + self.行间距
	return {x = 0,宽度 = 0,高度 = self.文字高度,内容 = ''}--行初始化
end
function 丰富文本类:_添加段数据(行数据,段数据)
	if 段数据.类型 == 0 then--文本
		if 行数据.宽度 + 段数据.宽度 > self.宽度 then--大于就折行
			local 剩下长度 = math.floor((self.宽度 - 行数据.宽度)/self.文字宽度)
			local 剩下文本 = ''

			段数据.内容,剩下文本 = self:_取文本左边(段数据.内容,剩下长度)
			--段数据.折行 = true --用作判断下行高亮
			table.insert(行数据, 段数据)
			行数据.宽度 = self.宽度
			行数据  	= self:_添加行数据(行数据)

			段数据 		= self:_复制样式(段数据)--上一行的样式
			段数据.内容	= self.换行符..剩下文本
			段数据.宽度 = self.文字:取宽度(段数据.内容)
			行数据 = self:_添加段数据(行数据,段数据)
		else
			--行数据.内容 = 行数据.内容..段数据.内容--无样式，用于搜索
			行数据.宽度 = 行数据.宽度 + 段数据.宽度
			table.insert(行数据, 段数据)--有样式
			--行数据.数量 = #行数据
		end
	else--对象(动画,图片等)
		if 行数据.宽度 + 段数据.宽度 > self.宽度 then--大于就折行
			行数据.宽度 = self.宽度
			行数据  	= self:_添加行数据(行数据)
			if self.换行符 ~='' then 行数据  	= self:_添加段数据(行数据,self:_生成段数据(self.默认颜色,self.换行符)) end
			段数据.x 	= 行数据.宽度
			行数据 = self:_添加段数据(行数据,段数据)
		else
			行数据.宽度 = 行数据.宽度 + 段数据.宽度
			table.insert(行数据, 段数据)
			--行数据.数量 = #行数据
			if 段数据.高度 > 行数据.高度 then
			    行数据.高度 = 段数据.高度
			end
		end
	end
	return 行数据
end
function 丰富文本类:_计算显示模式()
	if self.显示表.高度 > self.高度 then
		local 当前高度 = 0
		self.目标值 = 1
		for i=self.数量,1,-1 do
			当前高度 = 当前高度 + self.显示表[i].高度
			if 当前高度 >self.高度 then
				self.目标值 = i+1
			    break
			end
		end
		self.起始值 = self.数量
		self.递增值 = -1
	else
		self.起始值 = 1
		self.目标值 = self.数量
		self.递增值 = 1
	end
	self.显示模式 = self.递增值 == 1
end
function 丰富文本类:添加文本(数据)
	--数据 = 数据:gsub('/#','/井')
    for match in (数据.."\n"):gmatch("(.-)\n") do
		self:_解析(match)
		self.数量 = #self.显示表
		if self.数量 >200 then
		    table.remove(self.显示表,1)
		    self.数量 = #self.显示表
		end
    end
	self:_计算显示模式()
	return self.显示表.高度,self.显示表[1].宽度
end
function 丰富文本类:清空()
	self.显示表 	= {高度 = 0}
	self.数量 = 0
end
function 丰富文本类:取回调包围盒()
	return self.回调包围盒
end
function 丰富文本类:更新(dt,x,y)
	self.鼠标x,self.鼠标y = x,y
end
function 丰富文本类:显示(x,y)
	--self.包围盒:显示(x,y)

	if (self.数量 > 0) then
		local 起始y = self.显示模式 and 0 or self.高度
		local 画线 	= self.画线
		local 文字 	= self.文字
		local 背景 	= self.背景
		for i=self.起始值,self.目标值,self.递增值 do
			if (self.显示表[i]) then
				local 行数据 = self.显示表[i]
				if (self.显示模式 and i ~= self.起始值 ) then
					起始y = 起始y  + self.行间距 + self.显示表[i-1].高度
				elseif (not self.显示模式 ) then
					起始y = 起始y  - self.行间距 - 行数据.高度
				end
				for i,v in ipairs(行数据) do
					local 显示x		= 行数据.x+x+v.x
					local 显示y0 	= math.floor(起始y + y + (行数据.高度 - v.高度)/2)
					if v.背景颜色 then
						背景:置区域(0,0,v.宽度,v.高度)
							:置颜色(v.背景颜色)
							:显示(显示x,显示y0)
							--:取包围盒():显示()
					end
					local 颜色 = v.颜色
					if v.回调 then
						self.回调包围盒:置坐标宽高(显示x ,显示y0,v.宽度,v.高度)
						--self.回调包围盒:显示()
						if self.回调包围盒:检查点(self.鼠标x,self.鼠标y) then

						    if v.碰撞颜色 then 颜色 = v.碰撞颜色 end
						    if v.碰撞背色 then
								背景:置区域(0,0,v.宽度,v.高度)
									:置颜色(v.碰撞背色)
									:显示(显示x,显示y0)
						    end
						    if v.按钮 and self.鼠标按下 then
						        显示x ,显示y0 = 显示x +1,显示y0+1
						    end
						    if self._消息事件 then
						    	self:_消息事件('回调标识',v.回调,v.内容)
						    end
						    if 引擎.鼠标弹起(键盘符号.左键) then
						    	显回调=v.回调
						    	显内容=v.内容
						    	主界面.界面数据[8]:事件解析(显回调,显内容)
						    	显回调=nil
						    	显内容=nil
						    end
						    颜色=0xFFFFFF00
						end
					end
					if v.类型 == 0 then
						if v.下划线 then
							画线(显示x,显示y0+v.高度,显示x+v.宽度,显示y0+v.高度,颜色)
						end
						if v.删除线 then
							画线(显示x,显示y0+v.高度-5  ,显示x+v.宽度,显示y0+v.高度-5,颜色)
						end
						文字:置颜色(颜色)
						文字:显示(显示x ,显示y0,v.内容)
					else
						v.内容:显示(显示x ,显示y0)
					end
				end
			end
		end
	end
end

return 丰富文本类




-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2015-06-18 02:56:19
-- @最后修改来自: baidwwy
-- @Last Modified time: 2023-10-09 15:01:44
local 丰富文本类 = class()

local type = type
local insert = table.insert
local remove = table.remove
local floor = math.floor
local tostring = tostring
local pairs = pairs
local min = math.min
local max = math.max
local 超链接碰撞 = false
function 丰富文本类:初始化(...)
	local arg = {...}
	if arg[1] == nil then
		return
	end
	self.宽度 		= arg[1]
	self.高度 		= arg[2]
	self.符号 	= "#"
	self.换行符 	= ""
    self.文字 		= tp.字体表.外部文字
	self.文字宽度,self.文字高度 	= 7,15
	self.行间距 		= 1
	self.元素表 		= {P=0xFFFF1493,S=-419495936,X=ARGB(250,250,180,220),W=0xFFFFFFFF,H=0xFF000000,Y=0xFFFFFF00,L=-16776961,R=4294901760,G=4278255360,S=-16466190,Z=-16711681,N=-16777216,C=ARGB(255,125,125,125)}
	self.显示表 		= {高度 = 0,宽度 = 0}
	--亮金黄色：FFFAFAD2
	self.默认颜色 	= 0xFFFFFFFF
	self.默认元素 	= 'W'
	self.行数量 	= 0
	self.起始值 	= 0
	self.目标值 	= 0
	self.递增值 	= 1
	self.物品数据 = {}
	self.id = 0

	self.背景 		= require("gge精灵类")()
	self.画线 		= require("gge引擎").画线

	self.回调 		= {}
	self.回调包围盒 = require("gge包围盒2")()

	self.默认宽度 	= self.宽度

	self.添加记录 	= {}
	self.溢出行数 	= 500--最多存放数量
	self.滚动值 	= 0 --显示偏移
	self.加入 = 0
	for n=0,190 do
		self:添加元素(n,tp.包子表情动画[n])
	end
end

function 丰富文本类:置元素函数(v)
	self.元素函数 = v
end
function 丰富文本类:置加入(v)
	self.加入 = v
end
function 丰富文本类:置行距(v)
	self.行间距 	= v
	return self
end
function 丰富文本类:置宽度(v)
	self.宽度 = v
	self:_计算显示模式()
end
function 丰富文本类:置高度(v)
	self.高度 	= v
	self:_计算显示模式()
end
function 丰富文本类:滚动(v)
	self.滚动值 = self.滚动值+v
	if self.滚动值 < 0 then--到底
		self.滚动值 = 0
	elseif self.滚动值 > self.行数量 then
		self.滚动值 = self.行数量
	end
	self:_计算显示模式()
	return self.滚动值 == 0
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
function 丰富文本类:置画线(v)
	self.画线 		= v
	return self
end
function 丰富文本类:置行度(v)
	self.文字高度 = self.文字高度 + v
end
function 丰富文本类:添加元素(标识,数据,默认)
	标识 = tostring(标识)
	if type(数据) == 'table' then
		数据.标识 = 标识
	end
	if 默认 and type(数据)=='number' then
	    self.默认元素 = 标识
	end
	self.元素表[标识] = 数据
	return self
end
function 丰富文本类:检查元素(标识)
	if self.元素表[标识] then
		return self.元素表[标识]
	elseif self.元素函数 then
		return self.元素函数()
	end
end
function 丰富文本类:_取元素(标识)--向元素表查找元素，找不到向用户函数获取
	if self.元素表[标识] then
		return self.元素表[标识]
	elseif self.元素函数 then
		return self.元素函数()
	else
		return self.元素表[self.默认元素]
	end
end
function 丰富文本类:_生成段数据(元素,内容)
	local 段数据 = {}
	if type(元素) == 'number' then
		段数据.x 	= 0
		段数据.颜色 = 元素
		段数据.内容 = 内容 == '井\0' and '#' or 内容 -- 内容:gsub("井\0","#")
		段数据.类型 = 0
		段数据.宽度 = self.文字:取宽度(段数据.内容)
		段数据.高度 = self.文字高度
	else
		段数据.x 	= 0
	    段数据.内容 = 元素
	    段数据.类型 = 1
	    if 元素.帧数 == 1 then
			段数据.宽度 = 元素:取宽度()
		else
			段数据.宽度 = 元素:取宽度()+2
		end
		段数据.高度 = 元素:取高度()
	end
	return 段数据
end
function 丰富文本类:_生成样式(段数据,内容)
	-- local 样式 	= 内容:match("%l*")
	-- local 值 	= 内容:match("%l*|(.*)")
	local 样式,值 = 内容:match("(%l*)|?(.*)")
	if 样式 == 'n' then--换行
		if 段数据.换行内容 then
				段数据.换行内容 = 段数据.换行内容.."\n"..值
		else
			段数据.换行内容 = 值
		end
	elseif 段数据.类型 == 0 and 样式 ~="jz" and 样式 ~="jy" then --带有/符号的文本
		if 段数据.换行内容 then
			段数据.内容 = " "..段数据.换行内容.."\n"..内容
			段数据.换行内容 = nil
		else
			段数据.内容 = 段数据.内容.."/"..内容
		end

		段数据.宽度 = self.文字:取宽度(段数据.内容)
		段数据.高度 = self.文字:取高度(段数据.内容)
	end
	return 段数据
end
function 丰富文本类:_解析(数据,id)
	local x 		= 0
	local 行数据  	= {x = 0,宽度 = 0,高度 = self.文字高度,内容 = '',id=id}--行初始化
	if 数据:find('#') then
		for m in (数据.."#"):gmatch("(.-)#") do
			if m ~= '' then
				local 段内容,段数据 	= {},{}--解析前,解析后
				local 数量,主元素 = 0
				if m:find('/') then
					for match2 in (m.."/"):gmatch("(.-)/") do
						insert(段内容, match2)
					end
					主元素 	= 段内容[1]
					数量 	= #段内容
				else
					主元素,段内容[2] =m:match("(%w*)(.*)")
					if self:检查元素(主元素) and type(self:_取元素(主元素))~='table' then
						数量 = 2
					else
						数量 = 1
						主元素 = m
					end
				end
				if 数量 == 1 then
					if self:检查元素(主元素) then
						段数据 = self:_生成段数据(self:_取元素(主元素))
					else--表情和文本同一行 如(#11文本)
						local _,长度,标识 = 主元素:find('(%w*)')
						if 长度 >0  then
							if self:检查元素(主元素:sub(1,3)) then
								标识 	= 主元素:sub(1,3)
								主元素 	= 主元素:sub(4)
							elseif self:检查元素(主元素:sub(1,2)) then
								标识 	= 主元素:sub(1,2)
								主元素 	= 主元素:sub(3)
							elseif self:检查元素(主元素:sub(1,1)) then
								标识 	= 主元素:sub(1,1)
								主元素 	= 主元素:sub(2)
							end
						end
						if self:检查元素(标识) and type(self:检查元素(标识))=='table' then
							段数据 		= self:_生成段数据(self:_取元素(标识))
							段数据.x 	= x
							行数据 		= self:_添加段数据(行数据,段数据)
							x = 行数据.宽度
						end
						if  (self:检查元素(标识) and type(self:检查元素(标识))~='table') then
							段数据 = self:_生成段数据(self:_取元素(标识),主元素)
						else
							段数据 = self:_生成段数据(self.默认颜色,主元素)
						end
					end
				elseif 数量 == 2 then--指定颜色文本
					if type(self:_取元素(主元素)) == 'table' then--是否动画
						段数据 = self:_生成段数据(self:_取元素(主元素))
						段数据 = self:_生成样式(段数据,段内容[2])
					else
						段数据 = self:_生成段数据(self:_取元素(主元素),段内容[2])
					end
				else--带有特殊样式的
					段数据 = self:_生成段数据(self:_取元素(主元素),"")
					for i=2,数量 do
						段数据 = self:_生成样式(段数据,段内容[i])
						if 段内容[i] == 'jz' then --居中
							行数据.居中 = true
						elseif 段内容[i] == 'jy' then --居右
							行数据.居右 = true
						end
					end
					if 段数据.类型 == 0 then --带有/符号的文本
						段数据.内容 = 段数据.内容:sub(2)
						段数据.宽度 = self.文字:取宽度(段数据.内容)
					end
				end
				段数据.x = x
				if 段数据.居右 then 段数据.x = self.宽度-段数据.宽度 end
				行数据 = self:_添加段数据(行数据,段数据)
				x = 行数据.宽度
			else
				-- 段数据 = self:_生成段数据(self.默认颜色,'#')
				-- 行数据 = self:_添加段数据(行数据,段数据)
				-- x = 行数据.宽度
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
	insert(self.显示表, 行数据)
	self.显示表.高度  = self.显示表.高度 + 行数据.高度 + self.行间距
	if 行数据.宽度 > self.显示表.宽度 then
			self.显示表.宽度 = 行数据.宽度
	end
	return {x = 0,宽度 = 0,高度 = self.文字高度,内容 = ''}--行初始化
end

function 丰富文本类:_添加段数据(行数据,段数据)
	if 段数据.类型 == 0 then--文本
		if 行数据.宽度 + 段数据.宽度 > self.宽度 then--大于就折行
			local 剩下长度 = floor((self.宽度 - 行数据.宽度)/self.文字宽度)
			local 剩下文本 = ''

			段数据.内容,剩下文本 = self:_取文本左边(段数据.内容,剩下长度)
			--段数据.折行 = true --用作判断下行高亮
			insert(行数据, 段数据)
			行数据.宽度 = self.宽度
			行数据  	= self:_添加行数据(行数据)

			段数据 		= self:_复制样式(段数据)--上一行的样式
			段数据.内容	= self.换行符..剩下文本
			段数据.宽度 = self.文字:取宽度(段数据.内容)
			行数据 = self:_添加段数据(行数据,段数据)
		else
			--行数据.内容 = 行数据.内容..段数据.内容--无样式，用于搜索
			行数据.宽度 = 行数据.宽度 + 段数据.宽度
			insert(行数据, 段数据)--有样式
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
			insert(行数据, 段数据)
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
		local 当前高度,行底部 = 0,self.行数量-self.滚动值
		self.目标值 = 1
		for i=行底部,1,-1 do
			当前高度 = 当前高度 + self.显示表[i].高度+self.行间距
			if 当前高度 >self.高度 then
				self.起始y = 当前高度-self.显示表[i].高度-self.行间距
				self.目标值 = i+1
					break
			end
		end
		self.起始值 = 行底部
		self.递增值 = -1
	else
		self.起始值 = 1
		self.目标值 = self.行数量
		self.递增值 = 1
		self.起始y  = 0
	end
	self.显示模式 = (self.递增值 == 1)
end


function 丰富文本类:置文本(s)
	self:清空()
	self:添加文本(s)
	return self
end

function 丰富文本类:添加文本(数据,物品数据,宽度)
	if 数据 == nil then
	    return
	end
	insert(self.添加记录, 数据)
	self.物品数据[#self.显示表+1]=物品数据
	数据 = 数据:gsub('##','#井\0')
	if 数据:sub(1,1)~='#' then
		数据 = '#'..self.默认元素 .. 数据
	end
	self.宽度 = 宽度 or self.默认宽度
	for match in (数据.."\n"):gmatch("(.-)\n") do
		self:_解析(match)
		self.行数量 = #self.显示表
	end
	self:_计算显示模式()
	return self.显示表.高度
end

function 丰富文本类:清空()
	self.显示表 	= {高度 = 0,宽度 = 0}
	self.行数量 = 0
	self.滚动值 = 0
	self.加入 = 0
	return self
end

function 丰富文本类:更新(dt,x,y)

end

function 丰富文本类:显示(x,y,a)
	self.x,self.y=x,y
	if (self.行数量 > 0) then
		local 起始y = self.起始y
		local 文字 	= self.文字
		local 画线 	= self.画线
		local 背景 	= self.背景
		local g = nil

		for i=self.起始值,self.目标值,self.递增值 do
			local 行数据 = self.显示表[i+self.加入]
			if (self.显示模式 and i ~= self.起始值 ) then
				起始y = 起始y  + self.行间距 + self.显示表[i-1].高度
			elseif (not self.显示模式 ) and 行数据~=nil then
				起始y = 起始y  - self.行间距 - 行数据.高度
			end
			if 行数据~=nil then
				local 包围盒宽度 = 0
				local 值= ""
				 for k,v in ipairs(行数据) do
					if v.内容~="" and v.内容~=nil and type(v.内容)~='table' and k>0 then
						值 	= v.内容:match("(%［.*%］)")
						if 值~= nil then
							if next(self.物品数据) ~= 0 then
							v.回调 = true
							v.回调数据 = self.物品数据[i]
							end
						end
					end
				 end
			     for k,v in ipairs(行数据) do
				    local 显示x		= 行数据.x+x+v.x
					local 显示y0 	= floor(起始y + y + (行数据.高度 - v.高度)/2)
					local 颜色 = v.颜色
					local 显示xx = 显示x
					local 显示yy = 显示y0
					local 显示内容 = v.内容
					local 偏移宽度 = 0
					local 前缀宽度 = 0
					if v.回调 then
						if string.find(显示内容,值,1)~=nil then
							local 临时文本 = 分割文本(显示内容,"［")
							前缀宽度 = self.文字:取宽度(临时文本[1])
						end
						包围盒宽度 = self.文字:取宽度(值)
						self.回调包围盒:置坐标宽高(显示xx+前缀宽度 ,显示yy,包围盒宽度,v.高度)
						local mx,my=引擎.外部.取鼠标坐标()
						if self.回调包围盒:检查点(mx,my) then
							超链接碰撞=true
							tp.窗口.消息框.碰撞数量 =  1
						    if v.碰撞颜色 then 颜色 =  v.碰撞颜色 end
						    if 1==1 then
								背景:置区域(0,0,v.宽度,v.高度)
									:置颜色(v.碰撞颜色)
									:显示(显示x,显示y0)
						    end
						    if 引擎.外部.弹起事件 then
	                            if v.回调数据==nil then
	                                tp.常规提示:打开("#Y/没获取到回调数据")
	                                return
	                            end
						    	 if v.回调数据.寿命 then
						    	    tp.窗口.召唤兽查看栏:打开(v.回调数据)
							    	引擎.外部.弹起事件=nil
						    	 else
						    	    物品链接展示 = true
						    	    物品链接数据 = v.回调数据
							    	引擎.外部.弹起事件=nil
						    	 end
						    end
						else
							超链接碰撞=false
						end
					end
					if g ~= nil and a then
						if 颜色 ~= 4294901760 and 颜色 ~= 4278255360 then
							颜色 = a
						end
						g = nil
					end
					g = 1
					if v.类型 == 0 then
						文字:置颜色(颜色)
						文字:显示(显示x+2 ,显示y0+1,显示内容)
						if 超链接碰撞 then
							文字:置颜色(0xFF00FF00):显示(显示x+2+前缀宽度 ,显示y0+1,值)
						end
					elseif v.类型 == 1 then
						if 显示内容.帧数 == 1 then
							显示内容:显示(显示x+3 ,显示y0+19)
						else
							local sj = max(显示内容.高度,26)
							local yy=0
							 if v.内容.标识  then
							 	for n=121,190 do
								 	if tostring(n)==v.内容.标识 then
								 		 yy=-22
								 		 break
								    end
								end
						     end
							显示内容:显示(显示x+4 ,显示y0+sj+yy)
						end
					end
				end
			end
			-- end
		end
	end
end

function 丰富文本类:检查鼠标()
	return 超链接碰撞
end


return 丰富文本类
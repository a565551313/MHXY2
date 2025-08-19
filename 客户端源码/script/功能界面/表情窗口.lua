--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_消息框窗口 = class()

local floor = math.floor
local tp
local insert = table.insert
local mousea = 引擎.鼠标按下

function 场景类_消息框窗口:初始化(根)
	self.ID = 49
	self.x = 全局游戏宽度-720
	self.y = 全局游戏高度-455
	self.xx = 0
	self.yy = 0
	self.注释 = "消息框窗口"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = false
	local 资源 = 根.资源
	self.资源组 = {
		[1] = 根._自适应.创建(71,1,579,469,3,9)
	}
	self.窗口时间 = 0
	tp = 根
end

function 场景类_消息框窗口:打开()
	if self.可视 then
		self.可视 = false
		 tp.下一次确定 = true
	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end


function 场景类_消息框窗口:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.y = 全局游戏高度-505
	local v = 0
	for i=0,17 do
		tp.包子表情动画[i]:显示(self.x+6+i*32,self.y+32)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				end

				break
			end
		end
	end
	for i=18,35 do
		tp.包子表情动画[i]:显示(self.x+6+(i-18)*32,self.y+82)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
					tp.窗口.消息框.输入:添加文本("#"..i)
				end
				break
			end
		end
	end
	for i=36,49 do
		tp.包子表情动画[i]:显示(self.x+6+(i-36)*41,self.y+132)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				   tp.窗口.消息框.输入:添加文本("#"..i)
				end
				break
			end
		end
	end
	for i=50,63 do
		tp.包子表情动画[i]:显示(self.x+6+(i-50)*42,self.y+182)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				end
				break
			end
		end
	end
	for i=64,77 do
		tp.包子表情动画[i]:显示(floor(self.x+6+(i-64)*41.5),self.y+232)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				 end
				break
			end
		end
	end
	for i=78,89 do
		tp.包子表情动画[i]:显示(self.x+6+(i-78)*47,self.y+282)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				 end
				break
			end
		end
	end
	for i=90,100 do
		tp.包子表情动画[i]:显示(self.x+6+(i-90)*51,self.y+342)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				 end
				break
			end
		end
	end
	for i=101,111 do
		tp.包子表情动画[i]:显示(self.x+8+(i-101)*53,self.y+402)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				 end
				break
			end
		end
	end
	for i=112,120 do
		tp.包子表情动画[i]:显示(self.x+6+(i-112)*58,self.y+462)
		if tp.包子表情动画[i]:是否选中(x,y) and self.鼠标 then
			tp.提示:自定义(x-42,y+27,"键代码#+"..i.."   #"..i)
			if mousea(0) then
				self:打开()
				if tp.窗口.好友消息.可视 then
					tp.窗口.好友消息:输入添加文本("#"..i)
				else
				    tp.窗口.消息框.输入:添加文本("#"..i)
				 end
				break
			end
		end
	end
end


function 场景类_消息框窗口:检查点(x,y)
	return self.可视 and self.资源组[1]:是否选中(x,y)
end

function 场景类_消息框窗口:初始移动(x,y)
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

function 场景类_消息框窗口:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_消息框窗口
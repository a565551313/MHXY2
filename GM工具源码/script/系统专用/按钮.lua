--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 系统类_按钮 = class()

local tp,zts1,zts2
local mouse = 引擎.鼠标按住
local mouses = 引擎.鼠标弹起

local function 取偏移(w,h)
	if w == 55 and h == 28 then
		return 4,0
	elseif w == 78 and h == 34 then
		return 0,3
	elseif w == 31 and h == 31 then
		return -6,0
	elseif w == 37 and h == 26 then
		return -4,-1
	elseif w == 37 and h == 20 then
		return -4,-1
	elseif w == 43 and h == 27 then
		return 0,-1
	elseif w == 90 and h == 28 then
		return 8,0
	elseif w == 55 and h == 22 then
		return 5,0
	elseif w == 100 and h == 22 then
		return 13,0
	else
		return 0,0
	end
end

function 系统类_按钮:初始化(文件,宽度,高度,按钮数量,was,窗口按钮,按钮文字,可移动按钮)
	self.按钮 = 文件
	宽度 = 文件.宽度
	高度 = 文件.高度
	self.偏移x,self.偏移y = 取偏移(宽度,高度)
	self.焦点 = 0
	self.按钮数量 = 按钮数量
	self.按钮文字 = 按钮文字
	self.禁止 = false
	self.事件 = false
	self.按住 = false
	self.窗口按钮 = 窗口按钮
	self.文本栏按钮 = false
	if 可移动按钮 then
		self.确定按下 = false
	end
end
function 系统类_按钮:置偏移(x,y)
	self.偏移x = x
	self.偏移y = y
end

function 系统类_按钮:置根(根)
	tp = 根
	zts1 = tp.字体表.普通字体
	zts2 = tp.字体表.描边字体
end

function 系统类_按钮:更新(x,y,条件)
	if tp==nil then
	    tp=引擎.场景
	end
	self.事件 = false
	if (self.按钮:是否选中(x,y) or self.确定按下) and not tp.第二窗口移动中 then
		local ck
		if ((self.绑定窗口 ~= nil and ((tp.选中窗口 ~= 0 and tp.窗口_[tp.选中窗口].ID == self.绑定窗口) ))) then--or (tp.场景.战斗.选中窗口 ~= 0 and tp.场景.战斗.窗口_[tp.场景.战斗.选中窗口].ID == self.绑定窗口)
			tp.按钮焦点 = true
			ck = true
			if tp.消息栏焦点 and not self.文本栏按钮 then
				ck = nil
			end
		end
		if ((self.绑定窗口 == nil and (not tp.消息栏焦点 or  self.文本栏按钮)  and ((self.窗口按钮 and tp.选中窗口 ~= 0) or (self.窗口按钮 == nil and tp.选中窗口 == 0))) or ck)  then
			tp.按钮焦点 = true
			self.焦点 = 1
			if (引擎.在外部 == nil and self.外部按钮 == nil and mouse(0)) or (引擎.在外部 and self.外部按钮 and 引擎.外部.鼠标按住(0)) then
				self.焦点 = 2
				self.按住 = true
				if self.确定按下 ~= nil and not tp.按下中 then
					self.确定按下 = true
					tp.按下中 = true
				end
			end
			if (引擎.在外部 == nil and self.外部按钮 == nil and mouses(0)) or (引擎.在外部 and self.外部按钮 and 引擎.外部.弹起事件) then
				if (条件 == nil or 条件) then
					self.焦点 = 0
					self.事件 = true
					if self.确定按下 ~= nil then
						self.确定按下 = false
						tp.按下中 = false
					end
					if self.外部按钮 then
						引擎.外部.弹起事件 = nil
					end
				end
			end
		end
	else
		if self.确定按下 ~= nil then
			self.确定按下 = false
			tp.按下中 = false
		end
		self.按住 = false
		self.焦点 = 0
	end
	if (条件 ~= nil and not 条件) then
		self.焦点 = 3
	end
end
function 系统类_按钮:绑定窗口_(窗口ID)
	self.绑定窗口 = 窗口ID
end

function 系统类_按钮:文本栏按钮_(判断)
	self.文本栏按钮 = 判断
end

function 系统类_按钮:置文字(文字)
	self.按钮文字 = 文字
end

function 系统类_按钮:取文字()
	return self.按钮文字
end

function 系统类_按钮:置打勾框(v)
	self.打勾框 = v
	if v then
		self:置文字("√")
	else
		self:置文字("")
	end
end

function 系统类_按钮:是否选中(x,y)
	return self.按钮:是否选中(x,y)
end

function 系统类_按钮:检查点(x,y)
	return self.按钮:是否选中(x,y)
end

function 系统类_按钮:事件判断()
	return self.事件
end

function 系统类_按钮:显示(x,y,mf,mb,col,xsdf,zdjd,ab,ac,ad)
	local fjx = 0
	local fjy = 0
	if xsdf then
		self.焦点 = zdjd
	end
	if self.按钮数量 == 1 then
		self.按钮.当前帧 = 0
		if self.焦点 == 2 then
			fjx = 1
			fjy = 1
		end
	else
		if self.焦点 == 0 then
			self.按钮.当前帧 = ab or 0
		elseif self.焦点 == 1 then
		 	self.按钮.当前帧 = ac or 2
		elseif self.焦点 == 2 then
		 	self.按钮.当前帧 = ad or 1
		 	fjx = 1
		 	fjy = 1
		elseif self.焦点 == 3 then
		 	self.按钮.当前帧 = 3
		end
	end
	self.按钮:更新纹理()
	if self.按钮数量 == 1 or self.按钮数量 == 2 then
		self.按钮:显示(x+fjx,y+fjy)
	else
		self.按钮:显示(x,y)
	end
	if self.按钮文字 ~= nil then
		if mb == nil then
			zts1:置颜色(4294967295)
			zts1:显示(x+8+self.偏移x+fjx,y+4+self.偏移y+fjy,self.按钮文字)
		elseif mb == 122 then
			zts1:置颜色(-16777216)
			zts1:显示(x+8+self.偏移x+fjx,y+4+self.偏移y+fjy,self.按钮文字)
		else
			zts2:显示(x+7+self.偏移x+fjx,y+2+self.偏移y+fjy,self.按钮文字)
		end
	end
end

return 系统类_按钮
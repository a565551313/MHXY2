--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-29 02:19:48
--======================================================================--
local 系统类_常规提示 = class()
local tp
local ff
function 系统类_常规提示:初始化(根)
	self.ID = 123
	self.x = 全局游戏宽度/2-465
	self.y = 全局游戏高度/2-340
	self.xx = 0
	self.yy = 0
	self.注释 = "常规提示"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(6,1,1,1,3,9),
		[2] = 资源:载入('房屋图标.wdf',"网易WDF动画",0x4CFB6A98)
	}
	self.文本 = {}
	ff = 根._丰富文本
	self.窗口时间 = 0
	tp = 根
end

function 系统类_常规提示:打开(txt)
	-- print(111)
	if self.可视 then
		if txt then
		    self:写入(txt)
		    tp.运行时间 = tp.运行时间 + 1
			self.窗口时间 = tp.运行时间
		end
	else
		table.insert(tp.窗口_,self)
		-- if tp.战斗中 then
		--     table.insert(战斗类.窗口,self)
		-- end
		self:写入(txt)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		txt = nil
	end
end

function 系统类_常规提示:显示(x,y)
	if #self.文本==0 then
	    self.可视=false
	    return
	end
	self.焦点 = false

	for n=1,#self.文本 do
		if self.文本[n] ~= nil then
			self.文本[n].tiem = self.文本[n].tiem - 1
			if self.文本[n].tiem <= 0 then
				table.remove(self.文本, n)
			end
		end
	end
	for n=1,#self.文本 do
		if self.文本[n] ~= nil then
			local h=self.文本[n].h
			self.资源组[1]:置宽高(328,h+16)
			self.资源组[1]:显示(self.文本[n].x+self.x,self.文本[n].y+self.y)
			self.文本[n].ffs:显示(self.文本[n].x+6.5+self.x,self.文本[n].y+6.5+self.y)
		end
	end
	if #self.文本>0 then
		self.资源组[2]:更新(x,y)
		self.资源组[2]:显示(self.文本[#self.文本].x-20+self.x,305+self.文本[#self.文本].h+self.y)
	end
end

function 系统类_常规提示:写入(txt)
	if #self.文本 > 5 then
		table.remove(self.文本, 1)
	end
	local txts = {
		x = 310,
		y = 310, --self.h
		tiem = 300+#self.文本*7,
		ffs =  ff(316,300,tp.字体表.道具详情)
	}
	local ab = txts.ffs:添加文本(txt)
	txts.h = ab-6 --这里调整高度
	if #self.文本 > 0 then
		local cs = 1
		local zgd = 300
		for i=1,#self.文本 do
			zgd = zgd - self.文本[i].h - 18
		end
		for i=1,50 do
			self.文本[cs].y = zgd
			zgd = zgd + self.文本[cs].h +18
			cs = cs + 1
			if cs > #self.文本 then
				break
			end
		end
	end
	table.insert(self.文本,txts)
end

function 系统类_常规提示:检查点(x,y)
	if self.可视 and self.资源组[2]:是否选中(x,y)  then
		return true
	end
end

function 系统类_常规提示:初始移动(x,y)
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

function 系统类_常规提示:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end


return 系统类_常规提示
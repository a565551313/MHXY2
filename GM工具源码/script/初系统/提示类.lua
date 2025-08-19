--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2021-05-07 04:54:39
--======================================================================--
local 系统类_提示框 = class()
local floor = math.floor
local format = string.format
local remove = table.remove
local insert = table.insert
local jls = nil
local min = math.min
local gxs = 引擎.取物品功效
local qwp = 引擎.取物品
local tp = nil
local ARGB = ARGB
local pairs = pairs
local ff
function 系统类_提示框:初始化(根)

	ff = 根._丰富文本

	self.介绍文本 = ff(246,480,根.字体表.普通字体)

	self.道具文本 = ff(187,480,根.字体表.普通字体)

	:添加元素("f",0xFFFF6EC7)
	self.文本 = {}
	self.寄存内容 = {}
	self.寄存高度 = {}
	self.最高 = 0
	jls = 根.提示框
	tp = 根

end
function 提示(a)
  tp.提示:写入(a)
end
function 系统类_提示框:显示()
	if #self.文本 == 0 then
		return false
	end
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
			jls:置宽高(300,h+16)
			jls:显示(self.文本[n].x,self.文本[n].y)
			self.文本[n].ffs:显示(self.文本[n].x+6.5,self.文本[n].y+6.5)
		end
	end
end
function 系统类_提示框:写入(txt)
	local yy = 60
	local x = 0
	if #self.文本 > 8 then
		remove(self.文本, 1)
	end
	local txts = {
		x = 20,
		y = 60,
		tiem = 150+#self.文本*7,
		ffs =  ff(290,290)
	}
	if tp.进程 == 1 then
		txts.x = 200
		txts.y = 200
	end
	local ab = txts.ffs:添加文本(txt)
	txts.h = ab-6
	if #self.文本 > 0 then
		local cs = 1
		local zgd = 300
		for i=1,#self.文本 do
			zgd = zgd - self.文本[i].h - 18
		end
		while true do
			self.文本[cs].y = zgd
			zgd = zgd + self.文本[cs].h +18
			cs = cs + 1
			if cs > #self.文本 then
				break
			end
		end
	end
	insert(self.文本,txts)
end
function 系统类_提示框:自定义(x,y,txt)
	local x = x + 25
	local y = y
	self.介绍文本:清空()
	self.介绍文本:添加文本(txt)
	local w = self.介绍文本.显示表.宽度
	local h = self.介绍文本.显示表.高度
	if x + w >= 全局游戏宽度-20 then
		x = 全局游戏宽度-20 - w
	end
	if y + h >= 600 then
		y = y - h - 30
	end
	self.寄存内容 = {}
	self.寄存内容[1] = {}
	self.寄存内容[1].内容 = self.介绍文本
	self.寄存内容[1].x = x + 6
	self.寄存内容[1].y = y + 6
	self.寄存内容.提示坐标 = {[1]=x,[2]=y,[3]=w,[4]=h}
	self.寄存内容.开启提示 = true
end

function 系统类_提示框:清空寄存()
	if #self.寄存内容 ~= 0 then
		self.寄存内容 = {}
	end
end
return 系统类_提示框
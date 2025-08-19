--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:11:31
--======================================================================--
local 场景类_帮派技能学习 = class()

local floor = math.floor
local bw = require("gge包围盒")(0,0,40,40)
local box = 引擎.画矩形
local tp,zys
local ARGB = ARGB
local insert = table.insert

function 场景类_帮派技能学习:初始化(根)
	self.ID = 83
	self.x = 175
	self.y = 83
	self.xx = 0
	self.yy = 0
	self.注释 = "帮派技能学习"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.介绍文本 = 根._丰富文本(400,100,根.字体表.普通字体)
	self.窗口时间 = 0
	self.生活选中=0
	self.状态 = 1
	self.刷新文本 = false

end

function 场景类_帮派技能学习:打开(银子,储备,帮派数据)
	if self.可视 then
		self.介绍文本:清空()
		self.选中师门技能 = nil
		self.选中包含技能 = nil
		self.选中包含技能加入 = nil
		self.师门技能 = nil
		self.包含技能 = nil
		self.刷新文本 = false
		self.可视 = false
		self.资源组 = nil
		self.选中显示2 = nil
		self.辅助技能 = nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		现金 = 银子
		储备金 = 储备
		帮派生活技能 = 帮派数据.技能数据
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	  	self.生活选中=0
		self.可视 = true
	end
end
function 场景类_帮派技能学习:加载资源()
	local 按钮 = tp._按钮
	local 资源 = tp.资源
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x254E7029),
		[2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x2BD1DEF7),0,0,4,true,true,"学习"),
	}
	for n=2,3 do
		self.资源组[n]:绑定窗口_(83)
	end
	self.选中显示2 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x5DC9B461)
	self.辅助技能 = {}
	local jn = tp._技能格子
	for i=1,13 do
	    self.辅助技能[i] = jn(0,0,i,"辅助技能")
	end
end
function 场景类_帮派技能学习:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.生活选中 ~= 0)
	self.焦点 = false
	if self.资源组[2]:事件判断() then
	    self:打开()
	    return
	elseif self.资源组[3]:事件判断() then
		if self.生活选中==0 then
          tp.常规提示:打开("#Y/请先选中要学习的生活技能")
        else
          请求服务(3744,{序列=self.生活选中})
       	end
	end
	local rw = tp.队伍[1]
	-- 显示
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x + 364+116,self.y + 6)
	self.资源组[3]:显示(self.x + 225,self.y + 405,true)
	local fonts = tp.字体表.普通字体
	fonts:置颜色(ARGB(255,0,0,0))

	for i=1,#rw.辅助技能 do
		self.辅助技能[i]:置技能(rw.辅助技能[i])
		local 临时消耗=生活技能消耗(self.辅助技能[i].技能.等级+1,1)
		self.辅助技能[i].技能.原介绍=self.辅助技能[i].技能.介绍
        self.辅助技能[i].技能.介绍=self.辅助技能[i].技能.介绍
	end

	local xx = 0
	local yy = 0
	local 等级上限 = 0
	for n=1,13 do
		local jx = self.x+xx*69+21
		local jy = self.y+yy*80+36
		bw:置坐标(jx+3,jy+2)
		self.辅助技能[n]:置坐标(jx+3,jy+2)
		self.辅助技能[n]:显示(x,y,self.鼠标)
		if self.辅助技能[n].技能 ~= nil then
			zts:置颜色(-16777216)
			zts:显示(jx+3,jy+53,self.辅助技能[n].技能.等级.."/"..帮派生活技能[self.辅助技能[n].技能.名称].当前)
			if bw:检查点(x,y) and not tp.消息栏焦点 and self.鼠标 then
				tp.提示:技能(x,y,self.辅助技能[n].技能)
				if 引擎.鼠标弹起(左键) then self.生活选中=n end
			end
			if self.生活选中 ~= nil and self.生活选中 == n then
			    self.选中显示2:显示(jx+3,jy+3)
			    self.介绍文本:清空()
				self.介绍文本:添加文本("#R "..self.辅助技能[n].技能.名称..'\n')
				self.介绍文本:添加文本("#N/【介绍】"..self.辅助技能[n].技能.介绍)
				if 	self.辅助技能[n].技能.名称 == "强壮"  then
				local 临时消耗=生活技能消耗(self.辅助技能[n].技能.等级+1,2)
				fonts:显示(self.x + 150,self.y + 333,tp.队伍[1].当前经验)
				fonts:显示(self.x + 386,self.y + 333,临时消耗.经验)
				fonts:显示(self.x + 386,self.y + 357,临时消耗.金钱)
				临时消耗.帮贡 = (self.辅助技能[n].技能.等级+1)*5 -200

				fonts:显示(self.x + 150,self.y + 357,临时消耗.帮贡)
				fonts:显示(self.x + 150,self.y + 381,现金)
				fonts:显示(self.x + 386,self.y + 381,储备金)
			else
				local 临时消耗=生活技能消耗(self.辅助技能[n].技能.等级+1,1)
				fonts:显示(self.x + 150,self.y + 333,tp.队伍[1].当前经验)
				fonts:显示(self.x + 386,self.y + 333,临时消耗.经验)
				fonts:显示(self.x + 386,self.y + 357,临时消耗.金钱)
				临时消耗.帮贡 = (self.辅助技能[n].技能.等级+1)*5 -200
				fonts:显示(self.x + 150,self.y + 357,临时消耗.帮贡)
				fonts:显示(self.x + 150,self.y + 381,现金)
				fonts:显示(self.x + 386,self.y + 381,储备金)
        end
		end
		end
		xx = xx + 1
		if xx > 6 then
			xx = 0
			yy = yy + 1
		end
	end
	self.介绍文本:显示(self.x+30,self.y+210)
end

function 场景类_帮派技能学习:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		 return true
	end
end

function 场景类_帮派技能学习:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if  self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 场景类_帮派技能学习:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_帮派技能学习
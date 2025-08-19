--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-01-23 22:19:27
--======================================================================--
local 场景类_技能学习 = class()

local floor = math.floor
local bw = require("gge包围盒")(0,0,164,37)
local box = 引擎.画矩形
local tp,zys
local ARGB = ARGB
local insert = table.insert

function 场景类_技能学习:初始化(根)
	self.ID = 28
	self.x = 220
	self.y = 83
	self.xx = 0
	self.yy = 0
	self.注释 = "技能学习"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.介绍文本 = 根._丰富文本(150,150,根.字体表.普通字体)
	self.窗口时间 = 0
	self.选中 = nil
	self.选中1 = nil
	self.选中包含技能加入 = nil
	self.师门技能 = nil
	self.包含技能 = nil
	self.本次需求 = nil
	self.刷新文本 = false
	tp = 根
	zys = tp.资源
end

function 场景类_技能学习:打开()
	if self.可视 then
		self.介绍文本:清空()
		self.选中师门技能 = nil
		self.选中包含技能 = nil
		self.选中包含技能加入 = nil
		self.师门技能 = nil
		self.包含技能 = nil
		self.刷新文本 = false
		self.可视 = false
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		if tp.队伍[1].门派 == "无门派" then
		    tp.常规提示:打开("#Y/拜入门派才可以学习师门技能")
		    return false
		end
		self:加载数据()
		self.师门技能 = {}
		self.包含技能 = {}
		self.选中 = 0
		self.加入 = 0
		tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end

function 场景类_技能学习:加载数据()
	local 按钮 = tp._按钮
	local 资源 = tp.资源
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5E),
		[2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true),
		[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
		[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
		[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
		[6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
		[7] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5D),0,0,4,true,true,"学习1次"),
		[8] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5D),0,0,4,true,true,"学习10次"),
		[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5D),0,0,4,true,true,"一键学习"),
		[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5D),0,0,4,true,true,"一键全学"),
		[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC5D),0,0,4,true,true,"突破学习"),
	}
	for n=2,11 do
		self.资源组[n]:绑定窗口_(28)
	end
	-- 调整新增按钮的文本居中
	for n=7,11 do
		self.资源组[n]:置偏移(3, 2)  -- 向右偏移3像素使文本更居中
	end
end

function 场景类_技能学习:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.选中 ~= 0 and self.加入 > 0)
	self.资源组[4]:更新(x,y,self.选中 ~= 0 and self.加入 < #tp.队伍[1].师门技能[self.选中].包含技能 - 4)
	self.资源组[5]:更新(x,y,false)
	self.资源组[6]:更新(x,y,false)
	self.资源组[7]:更新(x,y,self.选中 ~= 0 and tp.队伍[1].师门技能[self.选中].等级 < 180)
	self.资源组[8]:更新(x,y,self.选中 ~= 0 and tp.队伍[1].师门技能[self.选中].等级 < 180)
	self.资源组[9]:更新(x,y)
	self.资源组[10]:更新(x,y)
	self.资源组[11]:更新(x,y)
	self.焦点 = false
	if self.鼠标 then
		if self.资源组[2]:事件判断() then
			self:打开()
			return false
		elseif self.资源组[3]:事件判断() then
			self.加入 = self.加入 - 1
		elseif self.资源组[4]:事件判断() then
			self.加入 = self.加入 + 1
		elseif self.资源组[7]:事件判断() then
			请求服务(3711,{序列=self.选中})
			if tp.队伍[1].当前经验 >= self.本次需求.经验 and (tp.金钱 >= self.本次需求.金钱 or tp.储备 >= self.本次需求.金钱) then
				if tp.队伍[1].等级+10 >= tp.队伍[1].师门技能[self.选中].等级 then

					for n=1,#tp.队伍[1].师门技能[self.选中].包含技能 do
					 	if tp.队伍[1].师门技能[self.选中].包含技能[n].学会 then
						 	tp.队伍[1].师门技能[self.选中].包含技能[n].等级 = tp.队伍[1].师门技能[self.选中].等级
						end
					end
					self.介绍文本:清空()
					self.介绍文本:添加文本("#N/【介绍】"..tp.队伍[1].师门技能[self.选中].介绍)
					self.介绍文本:添加文本("#N/【等级】"..tp.队伍[1].师门技能[self.选中].等级)
					self.本次需求 = {经验= 技能消耗.经验[tp.队伍[1].师门技能[self.选中].等级+2],金钱 = 技能消耗.金钱[tp.队伍[1].师门技能[self.选中].等级+2]}
				else
					tp.常规提示:打开("#Y/提高人物的等级才能够升级")
				end
			end
		    elseif self.资源组[8]:事件判断() then
			请求服务(3711.1,{序列=self.选中})
		elseif self.资源组[9]:事件判断() then
			-- 一键学习：单技能升级到角色等级+10
			if self.选中 == 0 then
				tp.常规提示:打开("#Y/请先选择要学习的技能")
			elseif tp.队伍[1].师门技能[self.选中].等级 >= tp.队伍[1].等级 + 10 then
				tp.常规提示:打开("#Y/该技能等级已达到角色等级+10的上限")
			else
				local 目标等级 = math.min(tp.队伍[1].等级 + 10, 180)
				请求服务(3711.2, {序列=self.选中, 目标等级=目标等级})
			end
		elseif self.资源组[10]:事件判断() then
			-- 一键全学：所有师门技能升级到角色等级+10
			if tp.队伍[1].门派 == "无门派" then
				tp.常规提示:打开("#Y/拜入门派才可以学习师门技能")
			else
				local 目标等级 = math.min(tp.队伍[1].等级 + 10, 180)
				请求服务(3711.3, {目标等级=目标等级})
			end
		elseif self.资源组[11]:事件判断() then
			-- 突破学习：当师门技能≥角色等级+10之后每次升级1级，消耗增加5倍
			if self.选中 == 0 then
				tp.常规提示:打开("#Y/请先选择要突破学习的技能")
			elseif tp.队伍[1].师门技能[self.选中].等级 < tp.队伍[1].等级 + 10 then
				tp.常规提示:打开("#Y/技能等级需要达到角色等级+10才能突破学习")
			else
				请求服务(3711.4, {序列=self.选中, 学习次数=1})
			end
		end
	end
	-- 显示
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x + 380,self.y + 3)
	self.资源组[3]:显示(self.x + 368,self.y + 55)
	self.资源组[4]:显示(self.x + 368,self.y + 166)
	self.资源组[5]:显示(self.x + 368,self.y + 192)
	self.资源组[6]:显示(self.x + 368,self.y + 327)
	self.资源组[7]:显示(self.x + 0,self.y + 440,true,true,2)
	self.资源组[8]:显示(self.x + 80,self.y + 440,true,true,2)
	self.资源组[9]:显示(self.x + 160,self.y + 440,true,true,2)
	self.资源组[10]:显示(self.x + 240,self.y + 440,true,true,2)
	self.资源组[11]:显示(self.x + 320,self.y + 440,true,true,2)
	local fonts = tp.字体表.普通字体
	fonts:置颜色(ARGB(255,0,0,0))
	if tp.队伍[1].门派 ~= "无门派" then
		for n=1,7 do
			bw:置坐标(self.x+18,self.y+35+n*40-5)
			if self.选中 ~= n then
				if bw:检查点(x,y) and not tp.消息栏焦点 and self.鼠标 then
					box(self.x+16,self.y+35+n*40-9,self.x+181,self.y+72+n*40-9,ARGB(255,201,207,109))
					if 引擎.鼠标弹起(0) then
						self.选中 = n
						self.加入 = 0
						self.包含技能 = {}
						if #tp.队伍[1].师门技能[self.选中].包含技能 > 0 then
							for i=1,#tp.队伍[1].师门技能[self.选中].包含技能 do
								self.包含技能[i] =  zys:载入(tp.队伍[1].师门技能[self.选中].包含技能[i].资源,"网易WDF动画",tp.队伍[1].师门技能[self.选中].包含技能[i].小模型资源)
							end
						end
						self.介绍文本:清空()
						self.介绍文本:添加文本("#N/【介绍】"..tp.队伍[1].师门技能[self.选中].介绍)
						self.介绍文本:添加文本("#N/【等级】"..tp.队伍[1].师门技能[self.选中].等级)
						self.本次需求 = {经验= 技能消耗.经验[tp.队伍[1].师门技能[self.选中].等级+1],金钱 = 技能消耗.金钱[tp.队伍[1].师门技能[self.选中].等级+1]}
					end
					self.焦点 = true
				end
			else
				local ys = ARGB(255,91,90,219)
				if bw:检查点(x,y) then
					ys = ARGB(255,108,110,180)
					self.焦点 = true
				end
				box(self.x+16,self.y+35+n*40-9,self.x+181,self.y+72+n*40-9,ys)
			end
			local sm = tp.队伍[1].师门技能[n]
			if self.师门技能[n] == nil then
				self.师门技能[n] = zys:载入(sm.资源,"网易WDF动画",sm.小模型资源)
			end
			self.师门技能[n]:显示(self.x+18,self.y+35+n*40-5)
			fonts:显示(self.x + 18+35,self.y + 35 +n*40+2,sm.名称)
			fonts:显示(self.x + 18+112,self.y + 35 +n*40+2 ,sm.等级.."/180")
		end
		-- 技能信息类
		if self.选中 ~= nil and self.选中 ~= 0 then
			if #tp.队伍[1].师门技能[self.选中].包含技能 > 0 then
				for i=1,4 do
					if self.包含技能[i] ~= nil then
						if not tp.队伍[1].师门技能[self.选中].包含技能[i].学会 then
						   self.包含技能[i+self.加入]:灰度级()
					        end
						self.包含技能[i+self.加入]:显示(self.x+208,self.y+i*30+37)

						fonts:显示(self.x+235,self.y+i*30+42,tp.队伍[1].师门技能[self.选中].包含技能[i+self.加入].名称)

						if self.包含技能[i]:是否选中(x,y) and self.鼠标 then
					      tp.提示:技能(x,y,tp.队伍[1].师门技能[self.选中].包含技能[i],tp.队伍[1].师门技能[self.选中].包含技能[i].剩余冷却回合)
			                end
					end
				end
			end
			fonts:显示(self.x + 83,self.y + 355,tp.队伍[1].当前经验)
			fonts:显示(self.x + 83,self.y + 385,tp.金钱)
			fonts:显示(self.x + 83,self.y + 417,tp.存银)
			if self.本次需求 ~= nil then
				fonts:显示(self.x + 290,self.y + 355,self.本次需求.经验)
				fonts:显示(self.x + 290,self.y + 385,self.本次需求.金钱)
			else
				fonts:显示(self.x + 290,self.y + 362,"未学会技能")
				fonts:显示(self.x + 290,self.y + 385,"未学会技能")
			end
			fonts:显示(self.x + 290,self.y + 417,tp.储备)
		end
	end
	self.介绍文本:显示(self.x+205,self.y+205)
end

function 场景类_技能学习:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		 return true
	end
end

function 场景类_技能学习:初始移动(x,y)
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

function 场景类_技能学习:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

-- function 场景类_技能学习:升级技能(技能,需求)
-- 	tp.队伍[1].当前经验 = floor(tp.队伍[1].当前经验 - 需求.经验/3)
-- 	if (tp.储备 or 0) >= 需求.金钱 then
-- 		tp.储备 = floor(tp.储备 - 需求.金钱/3)
-- 	else
-- 	    tp.金钱 = floor(tp.金钱 - 需求.金钱/3)
-- 	end
-- 	技能.等级 = 技能.等级 + 1
-- 	return 技能
-- end

-- function 场景类_技能学习:学习技能(目标技能等级)
-- 	local cc = 0
-- 	local vv = 0
-- 	local 等级 = 目标技能等级
-- 	if 等级 > 0 and 等级 <= 2 then
-- 		cc = 8*(目标技能等级+1)*目标技能等级
-- 	elseif 等级 > 2 and 等级 <= 5 then
-- 		cc = 8*(目标技能等级+1)*目标技能等级+2^目标技能等级
-- 	elseif 等级 > 5 and 等级 <= 11 then
-- 		cc = 目标技能等级*目标技能等级*(目标技能等级+5)
-- 	elseif 等级 > 11 and 等级 <= 18 then
-- 		cc = 目标技能等级*(目标技能等级+1)*10*(1.625+(目标技能等级-12)*0.2)
-- 	elseif 等级 > 18 and 等级 <= 25 then
-- 		cc = 目标技能等级*(目标技能等级+10)*10*(2.37+(目标技能等级-19)*0.25)
-- 	elseif 等级 > 25 and 等级 <= 31 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(94.3+(目标技能等级-26)*5.5)
-- 	elseif 等级 > 25 and 等级 <= 31 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(94.3+(目标技能等级-26)*5.5)
-- 	elseif 等级 > 31 and 等级 <= 40 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(130.22+(目标技能等级-32)*8)
-- 	elseif 等级 > 40 and 等级 <= 50 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(207.4+(目标技能等级-41)*11)
-- 	elseif 等级 > 50 and 等级 <= 60 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(329.41+(目标技能等级-51)*16)
-- 	elseif 等级 > 60 and 等级 <= 70 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(495.2+(目标技能等级-61)*21)
-- 	elseif 等级 > 70 and 等级 <= 80 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(710.93+(目标技能等级-71)*26)
-- 	elseif 等级 > 80 and 等级 <= 90 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(982.9+(目标技能等级-81)*33)
-- 	elseif 等级 > 90 and 等级 <= 100 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(1317.47+(目标技能等级-91)*39)
-- 	elseif 等级 > 100 and 等级 <= 110 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(1720.997+(目标技能等级-101)*47)
-- 	elseif 等级 > 110 and 等级 <= 120 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(2199.87+(目标技能等级-111)*55)
-- 	elseif 等级 > 120 and 等级 <= 130 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(2760.33+(目标技能等级-121)*64)
-- 	elseif 等级 > 130 and 等级 <= 140 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(3409.09+(目标技能等级-131)*73)
-- 	elseif 等级 > 140 and 等级 <= 150 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(4152.37+(目标技能等级-141)*83)
-- 	elseif 等级 > 150 and 等级 <= 155 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(5152.78+(目标技能等级-151)*247)
-- 	elseif 等级 > 155 and 等级 <= 160 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(6557.72+(目标技能等级-156)*417)
-- 	elseif 等级 > 160 and 等级 <= 170 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(8739.79+(目标技能等级-161)*503)
-- 	elseif 等级 > 170 and 等级 <= 174 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(13980.32+(目标技能等级-171)*707)
-- 	elseif 等级 > 174 and 等级 <= 179 then
-- 		cc = 目标技能等级*(目标技能等级-10)*(16804.73+(目标技能等级-175)*918)
-- 	elseif 等级 > 179 then
-- 		cc = 660382434
-- 	end
-- 	if 等级 > 0 and 等级 <= 3 then
-- 		vv = 3*(目标技能等级+1)*目标技能等级
-- 	elseif 等级 > 3 and 等级 <= 9 then
-- 		vv = (目标技能等级+1)*目标技能等级*(3.25+(目标技能等级-4)*0.25)
-- 	elseif 等级 > 9 and 等级 <= 16 then
-- 		vv = (目标技能等级-5)*目标技能等级*(11.12+(目标技能等级-10)*0.4)
-- 	elseif 等级 > 16 and 等级 <= 20 then
-- 		vv = (目标技能等级-10)*目标技能等级*(24.91+(目标技能等级-17)*0.55)
-- 	elseif 等级 > 20 and 等级 <= 30 then
-- 		vv = (目标技能等级-10)*目标技能等级*(27.73+(目标技能等级-21)*1.7)
-- 	elseif 等级 > 30 and 等级 <= 40 then
-- 		vv = (目标技能等级-10)*目标技能等级*(46.24+(目标技能等级-31)*3)
-- 	elseif 等级 > 40 and 等级 <= 50 then
-- 		vv = (目标技能等级-10)*目标技能等级*(77.75+(目标技能等级-41)*4.4)
-- 	elseif 等级 > 50 and 等级 <= 60 then
-- 		vv = (目标技能等级-10)*目标技能等级*(123.51+(目标技能等级-51)*6)
-- 	elseif 等级 > 60 and 等级 <= 70 then
-- 		vv = (目标技能等级-10)*目标技能等级*(185.69+(目标技能等级-61)*7.8)
-- 	elseif 等级 > 70 and 等级 <= 80 then
-- 		vv = (目标技能等级-10)*目标技能等级*(266.59+(目标技能等级-71)*10)
-- 	elseif 等级 > 80 and 等级 <= 90 then
-- 		vv = (目标技能等级-10)*目标技能等级*(368.58+(目标技能等级-81)*12.3)
-- 	elseif 等级 > 90 and 等级 <= 100 then
-- 		vv = (目标技能等级-10)*目标技能等级*(494.04+(目标技能等级-91)*14.8)
-- 	elseif 等级 > 100 and 等级 <= 110 then
-- 		vv = (目标技能等级-10)*目标技能等级*(645.36+(目标技能等级-101)*17.6)
-- 	elseif 等级 > 110 and 等级 <= 120 then
-- 		vv = (目标技能等级-10)*目标技能等级*(824.94+(目标技能等级-111)*20.65)
-- 	elseif 等级 > 120 and 等级 <= 130 then
-- 		vv = (目标技能等级-10)*目标技能等级*(1035.17+(目标技能等级-121)*24)
-- 	elseif 等级 > 130 and 等级 <= 140 then
-- 		vv = (目标技能等级-10)*目标技能等级*(1278.45+(目标技能等级-131)*27.5)
-- 	elseif 等级 > 140 and 等级 <= 150 then
-- 		vv = (目标技能等级-10)*目标技能等级*(1557.17+(目标技能等级-141)*31.3)
-- 	elseif 等级 > 150 and 等级 <= 155 then
-- 		vv = (目标技能等级-10)*目标技能等级*(1932.32+(目标技能等级-151)*92.6)
-- 	elseif 等级 > 155 and 等级 <= 160 then
-- 		vv = (目标技能等级-10)*目标技能等级*(2459.17+(目标技能等级-156)*156.3)
-- 	elseif 等级 > 160 and 等级 <= 170 then
-- 		vv = (目标技能等级-10)*目标技能等级*(3231.07+(目标技能等级-161)*144)
-- 	elseif 等级 > 170 and 等级 <= 175 then
-- 		vv = (目标技能等级-10)*目标技能等级*(4731.98+(目标技能等级-171)*205.3)
-- 	elseif 等级 > 175 and 等级 <= 180 then
-- 		vv = (目标技能等级-10)*目标技能等级*(5825.51+(目标技能等级-176)*283)
-- 	end

-- 	return {经验=floor(cc),金钱=floor(vv)}
-- end

return 场景类_技能学习
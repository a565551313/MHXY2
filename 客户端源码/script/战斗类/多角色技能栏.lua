--======================================================================--
-- @作者: GGE研究群: 342119 466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-08 19:18:28
--======================================================================--
local 场景类_多角色技能栏 = class()
local tp
function 场景类_多角色技能栏:初始化(根)
	self.ID = 670
	self.x = 320
	self.y = 115
	self.xx = 0
	self.yy = 0
	self.注释 = "战斗"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 按钮 = 根._按钮
	local 资源 = 根.资源
	local 自适应 = 根._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,195,490,3,9),
		[2] = 自适应.创建(1,1,191,18,1,3,nil,18),
		[3] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
		[4] =按钮.创建(自适应.创建(12,4,43,20,1,1),0,0,4,true,true,"攻击"),
		[5] =按钮.创建(自适应.创建(12,4,43,20,1,1),0,0,4,true,true,"防御"),

		}
    tp = 根
	self.技能 = {}
	for i=1,30 do
		self.技能[i] = tp._技能格子(0,0,i,"战斗技能栏")
	end
	self.资源组[3]:绑定窗口_(670)
	self.背景 = 1
	self.窗口时间 = 0
	self.已修改={}
	self.参战位置 = 0
	self.循环个数 = 15
	self.显示名称 = nil

end

function 场景类_多角色技能栏:打开(战斗单位,参战位置)
	if self.可视 then
		self.背景 = 1
		self.可视 = false
		self.参战位置 = 0
		战斗类.多角色自动栏.技能设置=false
	else
		for i=1,30 do
			self.技能[i]:置技能(nil)
			self.技能[i].剩余冷却回合 =nil
		end
		local 数量 = 0
		for k,v in ipairs(战斗单位.主动技能) do
			self.技能[k]:置技能(v,true)
			if 战斗单位.技能冷却 and 战斗单位.技能冷却[v.名称] then
				self.技能[k].剩余冷却回合 = 战斗单位.技能冷却[v.名称]
			end
			数量 = 数量 + 1
		end
		if 数量 >= 15 then
			self.背景 = 2
			self.资源组[1]:置宽高(195,490)
			self.循环个数 = 30
			self.y = 65
		else
			self.背景 = 1
		    self.资源组[1]:置宽高(195,280)
		    self.循环个数 = 15
		    self.y = 115
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.可移动 = true
		self.参战位置 = 参战位置
		self.显示名称 = 战斗单位.名称
		self.已修改={}
		self.已修改.id = 战斗单位.数据.id
		self.已修改.类型 = 战斗单位.类型
		self.已修改.认证码 = 战斗单位.数据.认证码
		战斗类.多角色自动栏.技能设置=true
		战斗类.多角色自动栏.门派类型 = ""
	end
end
function 场景类_多角色技能栏:更新()


end

function 场景类_多角色技能栏:显示(dt,x,y)
	if not self.可视 then
		return
	end
	self:检查点(x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:更新1(x,y)
	self.资源组[4]:更新1(x,y)
	self.资源组[5]:更新1(x,y)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	self.资源组[3]:显示(self.x+175,self.y+2)
	 tp.字体表.排行字体:置颜色(白色):显示(self.x + 5,self.y + 3,self.显示名称)


	if self.资源组[3]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[4]:事件判断() then
		self.已修改.参数 =  "攻击"
        多角色操作数据[self.参战位置].参数 = "攻击"
		请求服务(5511,{修改=self.已修改})
		self:打开()
	elseif self.资源组[5]:事件判断() then
		self.已修改.参数 =  "防御"
        多角色操作数据[self.参战位置].参数 = "防御"
		请求服务(5511,{修改=self.已修改})
		self:打开()
	end

	local xx = 0
	local yy = 0
	for w=1,self.循环个数 do
		tp.技能背景:显示(self.x+15+xx*60,self.y+32+yy*42)
		if self.技能[w] then
			self.技能[w]:置坐标(self.x+16+xx*60,self.y+33+yy*42)
			self.技能[w]:显示(x,y,true or self.鼠标)
			if  self.技能[w].剩余冷却回合 ~= nil and self.技能[w].剩余冷却回合>0 then
				self.技能[w].技能.模型:灰度级()
			    if string.len(self.技能[w].剩余冷却回合)>1 then
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+19+xx*60,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				else
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+27+xx*60,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				end
			end
			if self.技能[w].技能 and self.技能[w].焦点 then
				tp.提示:技能(x,y,self.技能[w].技能,self.技能[w].剩余冷却回合)
				if not self.技能[w].剩余冷却回合 or self.技能[w].剩余冷却回合<=0 then
					if self.技能[w].事件 or 引擎.鼠标弹起(右键) then
						self.已修改.参数 =  self.技能[w].技能.名称
						请求服务(5511,{修改=self.已修改})
					    多角色操作数据[self.参战位置].参数 = self.技能[w].技能.名称
					    self:打开()
					end
				end
				self.焦点 = true
			end
			xx = xx + 1
			if xx > 2 then
				xx = 0
				yy = yy + 1
			end
	   end
	end

	if tp.按钮焦点 then
		self.焦点 = true
	end
    if self.资源组[1]:是否选中(x,y) and 引擎.鼠标弹起(右键) and not self.焦点 then
    	self:打开()
    end

	if self.背景==1 then
		self.y = 115
		self.资源组[4]:显示(self.x+35,self.y+250)
		self.资源组[5]:显示(self.x+35+85,self.y+250)
	else
		self.y = 65
		self.资源组[4]:显示(self.x+35,self.y+460)
		self.资源组[5]:显示(self.x+35+85,self.y+460)

	end
end

function 场景类_多角色技能栏:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		self.鼠标=true
		return true
	else
		self.鼠标=false
		return false
	end
end

function 场景类_多角色技能栏:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
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

function 场景类_多角色技能栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end











return 场景类_多角色技能栏
--======================================================================--
-- @作者: GGE研究群: 342119 466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-05-08 21:10:22
--======================================================================--
local 场景类_多角色九黎栏 = class()
local tp
local box = 引擎.画矩形
function 场景类_多角色九黎栏:初始化(根)
	self.ID = 671
	self.x = 320
	self.y = 65
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
		[1] = 自适应.创建(0,1,270,380,3,9),
		[2] = 自适应.创建(1,1,266,18,1,3,nil,18),
		[3] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
		[4] =按钮.创建(自适应.创建(12,4,43,20,1,1),0,0,4,true,true,"攻击"),
		[5] =按钮.创建(自适应.创建(12,4,43,20,1,1),0,0,4,true,true,"防御"),
		[6] =按钮.创建(自适应.创建(12,4,43,20,1,1),0,0,4,true,true,"设置"),
		}
    tp = 根
	self.技能 = {}
	for i=1,10 do
		self.技能[i] = tp._技能格子(0,0,i,"战斗技能栏")
	end
	self.挂机技能 ={}
	self.挂机格子 ={}
	for i=1,9 do
		self.挂机技能[i] = tp._技能格子(0,0,i,"战斗技能栏")
		self.挂机格子[i] = tp.技能背景
	end
	self.资源组[3]:绑定窗口_(671)
	self.窗口时间 = 0
	self.已修改={}
	self.参战位置 = 0
	self.显示名称 = nil
	self.选中技能 = 0

end

function 场景类_多角色九黎栏:打开(战斗单位,参战位置)

	if self.可视 then
		self.可视 = false
		self.选中技能 = 0
		self.参战位置 = 0
		战斗类.多角色自动栏.技能设置=false
	else
		self.参战位置 = 参战位置
		self.显示名称 = 战斗单位.名称
		self.已修改={}
		self.已修改.id = 战斗单位.数据.id
		self.已修改.类型 = 战斗单位.类型
		self.已修改.九黎技能 ={}
		for i=1,10 do
			self.技能[i]:置技能(nil)
			self.技能[i].剩余冷却回合 =nil
		end
		for i=1,9 do
			self.挂机技能[i]:置技能(nil)
			self.挂机技能[i].剩余冷却回合 =nil
		end
		for k,v in ipairs(战斗单位.主动技能) do
			self.技能[k]:置技能(v,true)
			if 战斗单位.技能冷却 and 战斗单位.技能冷却[v.名称] then
				self.技能[k].剩余冷却回合 = 战斗单位.技能冷却[v.名称]
			end
		end
		if 战斗单位.数据.自动指令.九黎挂机 then
			local 挂机数据 = 战斗单位.数据.自动指令.九黎挂机
			for i=2,4 do
				if 挂机数据[i] then
					for k,v in pairs(挂机数据[i]) do
						local 增加 = 0
		                if i==3 then
		                    增加 = 2
		                elseif i==4 then
		                    增加 = 5
		                end
		                self.挂机技能[k+增加]:置技能({名称=v.参数},true)
		                self.已修改.九黎技能[k+增加] = v.参数
						if 战斗单位.技能冷却 and 战斗单位.技能冷却[v.参数]then
							self.挂机技能[k+增加].剩余冷却回合 = 战斗单位.技能冷却[v.参数]
						end
					end
				end
			end
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.选中技能 = 0
		self.可视 = true
		self.可移动 = true
		战斗类.多角色自动栏.技能设置=true
		战斗类.多角色自动栏.门派类型 = "九黎城"
	end
end
function 场景类_多角色九黎栏:更新()


end

function 场景类_多角色九黎栏:显示(dt,x,y)
	if not self.可视 then
		return
	end
	self:检查点(x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:更新1(x,y)
	self.资源组[4]:更新1(x,y)
	self.资源组[5]:更新1(x,y)
	self.资源组[6]:更新1(x,y)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	self.资源组[3]:显示(self.x+250,self.y+2)
	self.资源组[4]:显示(self.x+30,self.y+345)
	self.资源组[5]:显示(self.x+30+85,self.y+345)
	self.资源组[6]:显示(self.x+30+85+85,self.y+345)
	 tp.字体表.排行字体:置颜色(白色):显示(self.x + 5,self.y + 3,self.显示名称)


	if self.资源组[3]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[4]:事件判断() then
		self.已修改.九黎技能 = nil
		self.已修改.参数 =  "攻击"
        多角色操作数据[self.参战位置].参数 = "攻击"
		请求服务(5511,{修改=self.已修改})
		self:打开()
	elseif self.资源组[5]:事件判断() then
		self.已修改.九黎技能 = nil
		self.已修改.参数 =  "防御"
        多角色操作数据[self.参战位置].参数 = "防御"
		请求服务(5511,{修改=self.已修改})
		self:打开()
	elseif self.资源组[6]:事件判断() then
		self.已修改.九黎技能 ={}
		for i=1,9 do
			if self.挂机技能[i] and self.挂机技能[i].技能 then
				self.已修改.九黎技能[i] = self.挂机技能[i].技能.名称
			end
		end
		请求服务(5511,{修改=self.已修改})
		self:打开()
	end


	local xx = 0
	local yy = 0
	for w=1,10 do
		tp.技能背景:显示(self.x+13+xx*50,self.y+32+yy*42)
		if self.技能[w] then
			self.技能[w]:置坐标(self.x+14+xx*50,self.y+33+yy*42)
			self.技能[w]:显示(x,y,true or self.鼠标)
			if self.技能[w].剩余冷却回合 and self.技能[w].剩余冷却回合>0 then
				self.技能[w].技能.模型:灰度级()
			    if string.len(self.技能[w].剩余冷却回合)>1 then
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+17+xx*50,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				else
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+22+xx*50,self.y+38+yy*42,self.技能[w].剩余冷却回合)
				end
			end
			if self.技能[w].技能 and self.技能[w].焦点 then
				tp.提示:技能(x,y,self.技能[w].技能,self.技能[w].剩余冷却回合)
				if not self.技能[w].剩余冷却回合 or self.技能[w].剩余冷却回合<=0 then
					if self.技能[w].事件 or 引擎.鼠标弹起(右键) then
						if not self.选中技能 or self.选中技能 ==0 then
							tp.常规提示:打开("#Y/请先选择下边修改的技能")
						else
							self.挂机技能[self.选中技能].剩余冷却回合 = nil
							self.挂机技能[self.选中技能]:置技能({名称=self.技能[w].技能.名称},true)
							多角色操作数据[self.参战位置].参数 = self.技能[w].技能.名称
						    self.选中技能 = 0
						end
					end
				end
			    self.焦点 = true
			end
			xx = xx + 1
			if xx > 4 then
				xx = 0
				yy = yy + 1
			end
	   end
	end
	tp.字体表.普通字体:置颜色(白色):显示(self.x+23,self.y + 130,"双技能设置")
	for i=1,2 do
		self.挂机格子[i]:显示(self.x+23+(i-1)*60,self.y+150)
		if self.挂机技能[i] then
			self.挂机技能[i]:置坐标(self.x+24+(i-1)*60,self.y+151)
			self.挂机技能[i]:显示(x,y,true or self.鼠标)
			if self.挂机技能[i].剩余冷却回合 and self.挂机技能[i].剩余冷却回合>0 then
				self.挂机技能[i].技能.模型:灰度级()
			    if string.len(self.挂机技能[i].剩余冷却回合)>1 then
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+27+(i-1)*60,self.y+156,self.挂机技能[i].剩余冷却回合)
				else
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+32+(i-1)*60,self.y+156,self.挂机技能[i].剩余冷却回合)
				end
			end
			if self.挂机技能[i].技能 and self.挂机技能[i].焦点 then
				tp.提示:技能(x,y,self.挂机技能[i].技能,self.挂机技能[i].剩余冷却回合)
			end
		end
		if self.挂机格子[i]:是否选中(x,y) then
			self.焦点 = true
			if 引擎.鼠标弹起(左键) then
				self.选中技能 = i
			end
		end
		if self.选中技能 and self.选中技能 == i then
			box(self.x+24+(i-1)*60,self.y+151,self.x+64+(i-1)*60,self.y+191,0xff1E90FF)
		end
	end
	tp.字体表.普通字体:置颜色(白色):显示(self.x+23,self.y + 200,"三技能设置")
	for i=3,5 do
		self.挂机格子[i]:显示(self.x+23+(i-3)*60,self.y+220)
		if self.挂机技能[i] then
			self.挂机技能[i]:置坐标(self.x+24+(i-3)*60,self.y+221)
			self.挂机技能[i]:显示(x,y,true or self.鼠标)
			if self.挂机技能[i].剩余冷却回合 and self.挂机技能[i].剩余冷却回合>0 then
				self.挂机技能[i].技能.模型:灰度级()
			    if string.len(self.挂机技能[i].剩余冷却回合)>1 then
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+27+(i-3)*60,self.y+226,self.挂机技能[i].剩余冷却回合)
				else
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+32+(i-3)*60,self.y+226,self.挂机技能[i].剩余冷却回合)
				end
			end
			if self.挂机技能[i].技能 and self.挂机技能[i].焦点 then
				tp.提示:技能(x,y,self.挂机技能[i].技能,self.挂机技能[i].剩余冷却回合)
			end
		end
		if self.挂机格子[i]:是否选中(x,y) then
			self.焦点 = true
			if 引擎.鼠标弹起(左键) then
				self.选中技能 = i
			end
		end
		if self.选中技能 and self.选中技能 == i then
			box(self.x+24+(i-3)*60,self.y+221,self.x+64+(i-3)*60,self.y+261,0xff1E90FF)
		end



	end
	tp.字体表.普通字体:置颜色(白色):显示(self.x+23,self.y + 270,"四技能设置")
	for i=6,9 do
		self.挂机格子[i]:显示(self.x+23+(i-6)*60,self.y+290)
		if self.挂机技能[i] then
			self.挂机技能[i]:置坐标(self.x+24+(i-6)*60,self.y+291)
			self.挂机技能[i]:显示(x,y,true or self.鼠标)
			if self.挂机技能[i].剩余冷却回合 and self.挂机技能[i].剩余冷却回合>0 then
				self.挂机技能[i].技能.模型:灰度级()
			    if string.len(self.挂机技能[i].剩余冷却回合)>1 then
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+27+(i-6)*60,self.y+296,self.挂机技能[i].剩余冷却回合)
				else
					tp.字体表.冷却字体:置颜色(白色):显示(self.x+32+(i-6)*60,self.y+296,self.挂机技能[i].剩余冷却回合)
				end
			end
			if self.挂机技能[i].技能 and self.挂机技能[i].焦点 then
				tp.提示:技能(x,y,self.挂机技能[i].技能,self.挂机技能[i].剩余冷却回合)
			end
		end
		if self.挂机格子[i]:是否选中(x,y) then
			self.焦点 = true
			if 引擎.鼠标弹起(左键) then
				self.选中技能 = i
			end
		end
		if self.选中技能 and self.选中技能 == i then
			box(self.x+24+(i-6)*60,self.y+291,self.x+64+(i-6)*60,self.y+331,0xff1E90FF)
		end

	end

	if tp.按钮焦点 then
		self.焦点 = true
	end
	if self.资源组[1]:是否选中(x,y)  and not self.焦点 then
		if 引擎.鼠标弹起(右键) then
    		self:打开()
    	elseif 引擎.鼠标弹起(左键) and self.选中技能~=0 then
    			self.选中技能 = 0
    	end
    end



end

function 场景类_多角色九黎栏:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		self.鼠标=true
		return true
	else
		self.鼠标=false
		return false
	end
end

function 场景类_多角色九黎栏:初始移动(x,y)
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

function 场景类_多角色九黎栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end











return 场景类_多角色九黎栏
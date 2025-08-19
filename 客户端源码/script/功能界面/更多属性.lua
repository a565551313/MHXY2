--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-03-01 16:19:06
-- 梦幻西游游戏资源破解 baidwwy@vip.qq.com(313738139) 老毕   和 C++PrimerPlus 717535046 这俩位大神破解所以资源
--======================================================================--

local 场景类_更多属性 = class()
local tp,zts,zts1,zts2,zts3,zts4
local mousea = 引擎.鼠标弹起
local insert = table.insert
local bw = require("gge包围盒")(0,0,242,24)
local box = 引擎.画矩形
local floor = math.floor
local ceil = math.ceil
local min = math.min
local max = math.max
local wbxa = {"物理暴击等级","穿刺等级","狂暴等级"}
local wbxb = {"灵力","法术暴击等级","法术伤害结果"}
local wbxc = {"封印命中等级","治疗能力"}
local sxxx = {"灵力","物理暴击等级","穿刺等级","狂暴等级","法术暴击等级","法术伤害结果","封印命中等级","固定伤害","治疗能力"}
local kxxx = {"抗物理暴击等级","格挡值","抗法术暴击等级","抵抗封印等级","气血回复效果","躲避"}
local xxxz = {"全部","物理","法术","辅助"}

function 场景类_更多属性:初始化(根)
	self.ID = 71
	self.x = 218+(全局游戏宽度-800)/2
	self.y = 75
	self.xx = 0
	self.yy = 0
	self.注释 = "更多属性"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 小型选项栏 = 根._小型选项栏
	tp = 根
	zts = tp.字体表.普通字体__
	zts1 = tp.字体表.普通字体
    local 按钮 = tp._按钮
	self.资源组 = {

		[1] = 资源:载入('房屋图标.wdf',"网易WDF动画",0x00000122),

		[2] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动

		[3] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
		[4] =  根._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,80,2),


		[5] = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000061),0,0,4,true,true),
		[6] = 小型选项栏.创建(自适应.创建(105,1,195,125,3,9),"选项"),

		--[7] = 自适应.创建(35,1,205,19,1,3),

	 }
    for i=2,5 do
		self.资源组[i]:绑定窗口_(self.ID)
	end
	self.窗口时间 = 0
	self.加入 = 0
	self.资源组[4]:置起始点(0)
	self.选项 = "全部"

end

function 场景类_更多属性:打开()
	if self.可视 then
		self.可视 = false
		self.加入 = 0
		self.资源组[4]:置起始点(0)
	else
	if  self.x > 全局游戏宽度 then
    self.x = 218+(全局游戏宽度-800)/2
    end
        self.等级=tp.队伍[1].等级
        self.数据 = tp.队伍[1]
		insert(tp.窗口_,self)
		self.x = tp.窗口.人物状态栏.x-266
		self.y =tp.窗口.人物状态栏.y
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end



function 场景类_更多属性:显示(dt,x,y)
	local bbsa = #sxxx
	if bbsa > 5 then
		self.资源组[4]:置高度(min(floor(93/(bbsa-5)),104))
		self.加入 = min(ceil((bbsa-5)*self.资源组[4]:取百分比()),bbsa-5)
	end
	self.资源组[2]:更新(x,y,self.加入 > 0)
	self.资源组[3]:更新(x,y,self.加入 < bbsa - 5)
	self.资源组[5]:更新(x,y)
	if self.资源组[2]:事件判断() and bbsa>=5 then--上滚动
		self.资源组[4]:置起始点(self.资源组[4]:取百分比转换(self.加入-1,5,bbsa))
	elseif self.资源组[3]:事件判断() and bbsa>=5 then--下滚动

		self.资源组[4]:置起始点(self.资源组[4]:取百分比转换(self.加入+1,5,bbsa))

	elseif(self.资源组[1]:是否选中(x,y) or self.资源组[2]:是否选中(x,y) or self.资源组[4]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 and self.选项 == xxxz[1]  then--鼠标上滚动
		self.资源组[4]:置起始点(self.资源组[4]:取百分比转换(self.加入-1,5,bbsa))
	elseif (self.资源组[1]:是否选中(x,y) or self.资源组[3]:是否选中(x,y) or self.资源组[4]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==-1 and self.加入 < bbsa - 5 and self.选项 == xxxz[1] then--鼠标下滚动
		self.资源组[4]:置起始点(self.资源组[4]:取百分比转换(self.加入+1,5,bbsa))
	elseif self.资源组[5]:事件判断() then
		local tbt = {"全部","物理","法术","辅助"}
		self.资源组[6]:打开(tbt)
		self.资源组[6]:置选中(self.选项)
	elseif self.资源组[6]:事件判断() then
	 	if self.资源组[6].弹出事件=="全部"  then
	 		self.选项 = xxxz[1]
		elseif self.资源组[6].弹出事件=="物理"  then
			self.选项 = xxxz[2]
			self.加入 = 0
		elseif self.资源组[6].弹出事件=="法术"  then
			self.选项 = xxxz[3]
			self.加入 = 0
		elseif self.资源组[6].弹出事件=="辅助"  then
			self.选项 = xxxz[4]
			self.加入 = 0
			end
	    end
		self.焦点 = false
		self.资源组[1]:显示(self.x,self.y)
	if self.选项 == xxxz[1] then
		 bbsa = #sxxx
		for i=1,5 do
			if self.数据[sxxx[i+self.加入]] ~= nil then
				local jx = self.x+18
				local jy = self.y+(i*25)-5
		        zts:置颜色(0xFFFFFFFF)
				zts:显示(jx+3,jy+50,sxxx[i+self.加入])
				if sxxx[i+self.加入] == "物理暴击等级" or sxxx[i+self.加入] == "法术暴击等级" then
					zts:显示(jx+109,jy+50,self.数据[sxxx[i+self.加入]].."(+"..string.format("%.2f",self.数据[sxxx[i+self.加入]]/30).."%)")
	            elseif  sxxx[i+self.加入] == "封印命中等级"  then
					zts:显示(jx+109,jy+50,self.数据[sxxx[i+self.加入]].."(+"..string.format("%.2f",self.数据[sxxx[i+self.加入]]/60).."%)")

				else
					zts:显示(jx+109,jy+50,self.数据[sxxx[i+self.加入]])
				end
		   end
	    end
    elseif self.选项 == xxxz[2] then

    	   bbsa = #wbxa
			for i=1,5 do
				if self.数据[wbxa[i+self.加入]] ~= nil then
					local jx = self.x+18
					local jy = self.y+(i*24)-5
			        zts:置颜色(0xFFFFFFFF)
					zts:显示(jx+3,jy+50,wbxa[i+self.加入])
					if wbxa[i+self.加入] == "物理暴击等级"  then
						zts:显示(jx+109,jy+50,self.数据[wbxa[i+self.加入]].."(+"..string.format("%.2f",self.数据[wbxa[i+self.加入]]/30).."%)")
					else
						zts:显示(jx+109,jy+50,self.数据[wbxa[i+self.加入]])
					end
			   end
		    end
    elseif self.选项 == xxxz[3] then
    	 bbsa = #wbxb
		   for i=1,5 do
				if self.数据[wbxb[i+self.加入]] ~= nil then
					local jx = self.x+18
					local jy = self.y+(i*24)-5
			        zts:置颜色(0xFFFFFFFF)
					zts:显示(jx+3,jy+50,wbxb[i+self.加入])
					if wbxb[i+self.加入] == "法术暴击等级"   then
						zts:显示(jx+109,jy+50,self.数据[wbxb[i+self.加入]].."(+"..string.format("%.2f",self.数据[wbxb[i+self.加入]]/30).."%)")
					else
						 zts:显示(jx+109,jy+50,self.数据[wbxb[i+self.加入]])
					end
			   end
	       end
    elseif self.选项 == xxxz[4] then
    	   bbsa = #wbxc
		   for i=1,5 do
			 if self.数据[wbxc[i+self.加入]] ~= nil then
				local jx = self.x+18
				local jy = self.y+(i*24)-5
		        zts:置颜色(0xFFFFFFFF)
				zts:显示(jx+3,jy+50,wbxc[i+self.加入])
				if wbxc[i+self.加入] == "封印命中等级"   then
					zts:显示(jx+109,jy+50,self.数据[wbxc[i+self.加入]].."(+"..string.format("%.2f",self.数据[wbxc[i+self.加入]]/60).."%)")
				else
					  zts:显示(jx+109,jy+50,self.数据[wbxc[i+self.加入]])
				end
		     end
	      end
    end
	for i=1,6 do
		if self.数据[kxxx[i]] ~= nil then
				local jx = self.x+18
				local jy = self.y+(i*25)+177
				zts:置颜色(0xFFFFFFFF)
				zts:显示(jx+3,jy+50,kxxx[i])
				if kxxx[i] == "抗物理暴击等级" or kxxx[i] == "抗法术暴击等级"  then
					zts:显示(jx+109,jy+50,self.数据[kxxx[i]].."(+"..string.format("%.2f",self.数据[kxxx[i]]/30).."%)")
	            elseif kxxx[i] == "抵抗封印等级" then
					zts:显示(jx+109,jy+50,self.数据[kxxx[i]].."(+"..string.format("%.2f",self.数据[kxxx[i]]/60).."%)")
				else
					zts:显示(jx+109,jy+50,self.数据[kxxx[i]])
			    end
			end
		end

	--self.资源组[2]:显示(self.x+223,self.y+63)
	--self.资源组[3]:显示(self.x+223,self.y+173)
	if bbsa > 5 then
		self.资源组[4]:显示(self.x+206,self.y+80,x,y,self.鼠标)
	end
	--self.资源组[7]:显示(self.x+22,self.y+38)
	self.资源组[5]:显示(self.x+199,self.y+39)
	self.资源组[6]:显示(self.x+15,self.y+63,x,y,self.鼠标)
	zts:置颜色(0xFF000000)
	zts1:显示(self.x+21,self.y+42,self.选项)
	if self.资源组[4].接触 or tp.按钮焦点 then
		self.焦点 = true
	end
end

function 场景类_更多属性:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_更多属性:初始移动(x,y)
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

function 场景类_更多属性:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_更多属性


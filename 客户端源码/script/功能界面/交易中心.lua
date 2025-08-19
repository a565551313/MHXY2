-- @作者: baidwwy
-- @邮箱:  313738139@qq.com
-- @创建时间:   2022-10-25 17:27:10
-- @最后修改来自: baidwwy
-- @Last Modified time: 2025-05-14 01:19:30
local 交易中心 = class()

local 包围盒 = require("gge包围盒")(0,0,520,20)
local 包围盒1 = require("gge包围盒")(0,0,20,140)
local zt = {"装\n备\n相\n关","宠\n物\n相\n关"}
local 选中编号=0
local tp
function 交易中心:初始化(根)
 	self.ID = 6502
	self.x = 202
	self.y = 88
	self.xx = 0
	self.yy = 0
	self.注释 = "交易中心"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.右键关闭=1
	self.窗口时间 = 0
	self.状态=1
	self.子类状态=1
	self.刷新间隔 = os.time()
	self.购买出售间隔 = os.time()
	tp = 根
end

function 交易中心:打开(内容)
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false
	    self.资源组 = nil
	    self.数据 = nil
	    self.名称 = {}
	    self.刷新 = nil
	    内容 = nil
	    按钮 = nil
	    自适应 = nil
	    return
	else
		table.insert(tp.窗口_,self)
	    local 按钮 = tp._按钮
	    local 自适应 = tp._自适应
	    self.资源组 = {
			[1] = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xAABBCC3E),
			[2] = 自适应.创建(34,1,540,230,3,9),--道具列表选择框
			[3] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"取消"),
			[4] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),
			[5] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
			[6] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[7] = 按钮.创建(自适应.创建(13,4,43,21,1,3),0,0,4,true,true,"空1"),
			[8] = 按钮.创建(自适应.创建(12,4,50,20,1,3),0,0,4,true,true,"刷新"),
			[9] = 按钮.创建(自适应.创建(12,4,50,20,1,3),0,0,4,true,true,"购买"),
			[10] = 按钮.创建(自适应.创建(12,4,50,20,1,3),0,0,4,true,true,"出售"),
			[11] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
			[12] = 按钮.创建(自适应.创建(27,4,25,69,4,3),0,0,5,true,true),
			[13] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[14] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[15] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[16] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[17] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[18] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
			[19] = 按钮.创建(自适应.创建(13,4,100,21,1,3),0,0,4,true,true,""),
	    }
     	tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.状态=1
	    self.子类状态 = 1
	    self.分类数据=内容
	    --申请页面数据
	    请求服务(901,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态]})
        --self.数据=内容
        --self.名称={}
        --self.刷新=内容.刷新
        --self.资源组[10].按钮文字="刷新("..self.刷新..")"
        -- for i=1,#self.数据 do
        --   self.名称[#self.名称+1]={名称=self.数据[i].模型,价格=self.数据[i].价格}
        --  -- print(self.数据[i])
        -- end
		self.起点=1
		self.终点=12
		选中编号=0
	end
end

function 交易中心:更新数据(内容)
	self.数据=内容
	self.名称={}
	for i=1,#self.数据 do
		local 临时名称=self.数据[i].名称
		if 临时名称 == "制造指南书" then
			临时名称=self.数据[i].参数一.."级"..tp:取武器子类(self.数据[i].参数二)..临时名称
		elseif 临时名称 == "百炼精铁" then
			临时名称=self.数据[i].参数一.."级"..临时名称
		elseif 临时名称 == "魔兽要诀" or 临时名称 == "高级魔兽要诀" then
			临时名称=self.数据[i].参数一
		end
		self.名称[#self.名称+1]={名称=临时名称,价格=self.数据[i].价格,日涨跌幅=self.数据[i].日涨跌幅}
	 	-- print(self.数据[i])
	end
end

function 交易中心:更新(dt)

end


function 交易中心:显示(dt,x,y)
	self.焦点=false
	--print(8888888)
	self.资源组[1]:显示(self.x,self.y)
	--self.资源组[2]:显示(self.x+100,self.y+60)
	self.资源组[4]:显示(self.x+537,self.y+65)
	self.资源组[5]:显示(self.x+537,self.y+305)
	self.资源组[6]:显示(self.x+542,self.y+3)
	self.资源组[9]:显示(self.x+132,self.y+335)
	self.资源组[10]:显示(self.x+232,self.y+335)
	self.资源组[8]:显示(self.x+332,self.y+335)
	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[8]:更新(x,y)
	self.资源组[9]:更新(x,y,选中编号~=0)
	self.资源组[10]:更新(x,y,选中编号~=0)
  	if self.资源组[4]:事件判断() then
	    if self.起点>1 then
	        self.起点=self.起点-1
	        self.终点=self.终点-1
	 	end
  	elseif self.资源组[5]:事件判断() then
	    if self.终点<#self.名称 then
	        self.起点=self.起点+1
	        self.终点=self.终点+1
	    end
   	elseif self.资源组[6]:事件判断() then
	    self:打开()
	    return
   	elseif self.资源组[8]:事件判断() then
   		if self.刷新间隔 + 5 < os.time() then
   			self.刷新间隔 = os.time()
   			请求服务(901,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态]})
   		else
   			tp.常规提示:打开("#Y请不要频繁刷新#24")
   	 	end
    elseif self.资源组[9]:事件判断() then
		if 选中编号==0 then
			tp.常规提示:打开("#Y请先选择要操作的商品")
		else
			if self.购买出售间隔 + 5 <= os.time() then
				请求服务(902,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态],编号=选中编号})
				self.购买出售间隔 = os.time()
			else
				tp.常规提示:打开("#Y购买频率过高，请等待"..self.购买出售间隔+5-os.time().."秒后再购买#4")
			end
		end
    elseif self.资源组[10]:事件判断() then
		if 选中编号==0 then
			tp.常规提示:打开("#Y请先选择要操作的商品")
		else
			if self.购买出售间隔 + 5 <= os.time() then
				请求服务(903,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态],编号=选中编号})
				self.购买出售间隔 = os.time()
			else
				tp.常规提示:打开("#Y操作频率过高，请等待"..self.购买出售间隔+5-os.time().."秒后再出售#4")
			end
			--请求服务(903,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态],编号=选中编号})
		end
    elseif self.资源组[1]:是否选中(x,y) and 引擎.鼠标弹起(右键) then
    	self:打开()
    	return
    end
	local 字体=tp.字体表.普通字体
	字体:置颜色(白色)

	字体:显示(self.x+245,self.y+5,"交易中心")
	字体:置颜色(黑色)
	字体:显示(self.x+35,self.y+52,"物品名称")
	--字体:显示(self.x+140,self.y+52,"物品类型")
	字体:显示(self.x+235,self.y+52,"出售价格")
	字体:显示(self.x+335,self.y+52,"收购价格")
	字体:显示(self.x+435,self.y+52,"当日涨跌")

	--左侧主菜单
	local ms=nil
	for i=1,2 do
		self.资源组[i+10]:更新(x,y,self.状态 ~= i)
		if self.资源组[i+10]:事件判断() then
			self.状态 = i
			self.子类状态 = 1
			请求服务(901,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态]})
		end
		if self.资源组[i+10].按住 then
			ms = i
		end
		local jx = self.x-23
		local jy = self.y+41+(i-1)*68
		self.资源组[i+10]:显示(jx,jy,nil,nil,nil,self.状态 == i,2)
		tp.字体表.普通字体__:显示(jx+7,jy+6,zt[i])
	end
	--上方子菜单
	for i=1,#self.分类数据[self.状态] do
		self.资源组[12+i]:置文字(self.分类数据[self.状态][i])
		self.资源组[12+i]:更新(x,y,self.子类状态 ~= i)
		if self.资源组[12+i]:事件判断() then
			self.子类状态 = i
			请求服务(901,{大类=self.状态,小类=self.分类数据[self.状态][self.子类状态]})
		end
		self.资源组[12+i]:显示(self.x + 20 + (i-1)*110,self.y + 25,true,nil,nil,self.子类状态 == i,2)
	end
	--字体:显示(self.x+435,self.y+52,"离线日期")
 	--显示12行
 	local 位置=0
 	for n=self.起点,self.终点 do
		位置=位置+1
		--print(self.名称[n])
		if self.名称~=nil and self.名称[n]~=nil then
			local 颜色=黑色
			if 选中编号==n then 颜色=红色 end
			包围盒:置坐标(self.x+20,self.y+62+位置*20)
			if 包围盒:检查点(x,y) then
			--  print(66666)

				if 引擎.鼠标弹起(左键) then
					if 选中编号==n then
						选中编号=0
					else
						选中编号=n
					end
				end
			end
			字体:置颜色(颜色)
			字体:显示(self.x+30,self.y+62+位置*20,self.名称[n].名称)
			字体:显示(self.x+235,self.y+62+位置*20,self.名称[n].价格)
			字体:显示(self.x+335,self.y+62+位置*20,math.floor(self.名称[n].价格*0.8))
			字体:显示(self.x+450,self.y+62+位置*20,self.名称[n].日涨跌幅.."%")
		end
	end
	包围盒1:置坐标(self.x-24,self.y+36)
end

function 交易中心:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and  not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 交易中心:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy


	end
end
function 交易中心:检查点(x,y)
	if self.可视 and (self.资源组[1]:是否选中(x,y) or 包围盒1:检查点(x,y))  then
		return true
	else
		return false
	end
end

return 交易中心
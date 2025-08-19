local 场景类_剑会天下 = class()
local qmx = 引擎.取模型
local tp,jhzts,jhzts1,jhhy
local insert = table.insert
local tx = 引擎.取头像
local dwzy = {0x1A23FA11,0x1A23FA12,0x1A23FA13,0x1A23FA14,0x1A23FA15,0x1A23FA16,0x1A23FA17,0x1A23FA18}
function 场景类_剑会天下:初始化(根)
	self.ID = 97
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "剑会天下"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = false
	self.窗口时间 = 0
	tp = 根
	jhzts = tp.字体表.普通字体
	jhzts1 = tp.字体表.普通字体
	jhhy = tp.字体表.普通字体
end

function 场景类_剑会天下:加载资源()
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	local 资源 = tp.资源
	self.资源组 = {
		[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA01),
		[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA02),
		[3] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA03),0,0,3,true,true),
		[4] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA04),0,0,3,true,true),
		[5] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA05),0,0,3,true,true),
		[6] = 按钮.创建(自适应.创建(38,4,71,22,1,3),0,0,4,true,true,"返回首页"),
		[7] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA06),
		[8] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA10),
		[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA07),0,0,3,true,true),
		[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA08),0,0,3,true,true),
		[11] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x1A23FA09),0,0,3,true,true),
	}


	self.段位组={}
	for n=1,8 do
	    self.段位组[n] = 资源:载入('登陆资源.wdf',"网易WDF动画",dwzy[n])
	end
	for i=3,11 do
		if i~=7 and i~=8 then
	  		self.资源组[i]:绑定窗口_(97)
	  	end
	end
	self.当前积分=0
    self.当前段位 = 1
    self.升级积分=1800
    self.剑会称谓="天梯竞技·新秀"
end

function 场景类_剑会天下:打开(分类) -- 服饰染色 召唤兽染色
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		self:加载资源()
		self.x = (全局游戏宽度/2)-313
		self.y = (全局游戏高度/2)-160
	    tp.运行时间 = tp.运行时间 + 1
	  	self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.界面 = 1
	    self.队伍头像 = {}
	    self.个人头像 = nil
	    self.匹配 = false
	    self.人数 = 1
	end
end

function 场景类_剑会天下:加载数据(内容)
	self.当前积分 = 内容.当前积分 or 1200
    if self.当前积分<1800 then
    	self.升级积分=1800
    	self.当前段位=1
    	self.剑会称谓="剑会天下·新秀"
    elseif self.当前积分<2400 then
    	self.升级积分=2400
    	self.当前段位=2
    	self.剑会称谓="剑会天下·百战"
	elseif self.当前积分<3000 then
		self.升级积分=3000
		self.当前段位=3
		self.剑会称谓="剑会天下·千胜"
	elseif self.当前积分<3600 then
		self.升级积分=3600
		self.当前段位=4
		self.剑会称谓="剑会天下·万军"
	elseif self.当前积分<4200 then
		self.升级积分=4200
		self.当前段位=5
		self.剑会称谓="剑会天下·豪杰"
	elseif self.当前积分<4800 then
		self.升级积分=4800
		self.当前段位=6
		self.剑会称谓="剑会天下·英雄"
	elseif self.当前积分<5400 then
		self.升级积分=5400
		self.当前段位=7
		self.剑会称谓="剑会天下·传说"
	else
		self.升级积分=9999
		self.当前段位=8
		self.剑会称谓="剑会天下·神话"
	end
end

function 场景类_剑会天下:显示(dt,x,y)
	self.焦点 = false
	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[5]:更新(x,y)
	self.资源组[6]:更新(x,y)
	self.资源组[9]:更新(x,y)
	self.资源组[10]:更新(x,y)
	self.资源组[11]:更新(x,y)
	if self.界面 == 1 then
		self.资源组[1]:显示(self.x,self.y)
		self.资源组[3]:显示(self.x+35,self.y+50)
		self.资源组[4]:显示(self.x+380,self.y+48)
		self.资源组[5]:显示(self.x+380,self.y+133)
	elseif self.界面 == 2 then
	    self.资源组[2]:显示(self.x,self.y)
	    self.资源组[6]:显示(self.x+15,self.y+295,nil,nil,nil,self.匹配,1)
	    self.资源组[7]:显示(self.x+40,self.y+40)
	    if tp.队伍数据[1]==nil then
	    	local x = tx(tp.队伍[1].模型)
			self.个人头像 = tp._按钮(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
			self.个人头像:显示(self.x+44,self.y+44)
			for n=1,5 do
		        self.资源组[7]:显示(self.x+270+(n-1)*65,self.y+40)
			end
		    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+45,tp.队伍[1].名称)
		    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+75,"等级:"..tp.队伍[1].等级)
		    jhhy:置颜色(0xff77342c):显示(self.x+170,self.y+75,"门派:"..tp.队伍[1].门派)
		else
			for n=1,5 do
		        self.资源组[7]:显示(self.x+270+(n-1)*65,self.y+40)
		        if tp.队伍数据[n]~=nil then
			        local x = tx(tp.队伍数据[n].模型)
					self.队伍头像[n] = tp._按钮(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
					self.队伍头像[n]:显示(self.x+274+(n-1)*65,self.y+44)
					if self.队伍头像[n]:是否选中(鼠标.x,鼠标.y) then
						local 位置 = "队员"
						if n==1 then
							位置 = "队长"
						end
						tp.提示:自定义(鼠标.x + 5,鼠标.y - 10,"#Y/"..位置.."："..tp.队伍数据[n].名称.."\n#Y/等级:"..tp.队伍数据[n].等级.."\n#Y/门派:"..tp.队伍数据[n].门派)
					end
				end
		    end
		    local x = tx(tp.队伍[1].模型)
			self.个人头像 = tp._按钮(tp.资源:载入(x[7],"网易WDF动画",x[2]),0,0,1)
			self.个人头像:显示(self.x+44,self.y+44)
			jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+45,tp.队伍[1].名称)
		    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+75,"等级:"..tp.队伍[1].等级)
		    jhhy:置颜色(0xff77342c):显示(self.x+170,self.y+75,"门派:"..tp.队伍[1].门派)
		end
	    self.资源组[8]:显示(self.x+35,self.y+105)
	    self.资源组[9]:显示(self.x+260,self.y+106,nil,nil,nil,self.匹配,1)
	    self.资源组[10]:显示(self.x+370,self.y+106,nil,nil,nil,self.匹配,1)
	    self.资源组[11]:显示(self.x+480,self.y+106,nil,nil,nil,self.匹配,1)
	    jhhy:置颜色(0xff77342c):显示(self.x+65,self.y+115,"当前段位:"..self.剑会称谓)
	    jhhy:置样式(1)
	    if self.当前积分>=1900 then
	    	jhhy:置颜色(0xff77342c):显示(self.x+150,self.y+260,"剑会积分:"..self.当前积分)
	    else
	    	jhhy:置颜色(0xff77342c):显示(self.x+150,self.y+260,"剑会积分:"..self.当前积分.."/"..self.升级积分)
	    end
	    jhhy:置样式(0)
	    for n=1,8 do
	    	if n == self.当前段位 then
	    		self.段位组[n]:显示(self.x+90,self.y+133)
	    	end
	    end
	elseif self.界面 == 3 then
	    self.资源组[2]:显示(self.x,self.y)
	    self.资源组[6]:显示(self.x+15,self.y+295,nil,nil,nil,self.匹配,1)
	    jhhy:置颜色(0xff77342c):显示(self.x+45,self.y+55,"剑会天下匹配模式分为：1V1、3V3、5V5")
	    jhhy:置颜色(0xff77342c):显示(self.x+45,self.y+85,"剑会天下段位积分分为：")
	    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+110,"剑会天下·新秀：1200-1799分、剑会天下·百战：1800-2399分、")
	    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+135,"剑会天下·千胜：2400-2999分、剑会天下·万军：3000-3599分、")
	    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+160,"剑会天下·豪杰：3600-4199分、剑会天下·英雄：4200-4799分、")
	    jhhy:置颜色(0xff77342c):显示(self.x+100,self.y+185,"剑会天下·传说：4800-5399分、剑会天下·神话：5400分以上")
	    jhhy:置颜色(0xff77342c):显示(self.x+45,self.y+215,"剑会天下每日奖励分为：每日PK3场奖励（无论输赢）、每日首胜奖励。")
	    jhhy:置颜色(0xff77342c):显示(self.x+45,self.y+245,"剑会天下赛季奖励：每周清空一次，1300分以上每阶段都有赛季奖励。")
	end
	if self.资源组[3]:事件判断() and self.界面==1 then
		self.界面 = 2
	elseif self.资源组[5]:事件判断() and self.界面==1 then
		self.界面 = 3
	elseif self.资源组[4]:事件判断() then
		-- 请求服务(48,{类型=6})
	elseif self.资源组[6]:事件判断() and self.匹配==false and self.界面==2 then
		self.界面 = 1
	elseif self.资源组[6]:事件判断() and self.匹配==false and self.界面==3 then
		self.界面 = 1
	elseif self.资源组[9]:事件判断() and self.匹配==false and self.界面==2 then
		if (tp.队伍数据~=nil and #tp.队伍数据 == 1) or tp.队伍数据[1]==nil then
			self.人数 = 1
			请求服务(66,{人数=self.人数,模式="单人匹配"})
		else
		    tp.常规提示:打开("#Y/请组队单人或者不要组队进行匹配。")
		end
	elseif self.资源组[10]:事件判断() and self.匹配==false and self.界面==2 then
		if tp.队伍数据~=nil and #tp.队伍数据 == 3 then
			self.人数 = 3
			请求服务(66,{人数=self.人数,模式="三人匹配"})
		else
		    tp.常规提示:打开("#Y/请组3人队伍进行匹配，不能少于3人或者超过3人。")
		end
	elseif self.资源组[11]:事件判断() and self.匹配==false and self.界面==2 then
		if tp.队伍数据~=nil and #tp.队伍数据 == 5 then
			self.人数 = 5
			请求服务(66,{人数=self.人数,模式="五人匹配"})
		else
		    tp.常规提示:打开("#Y/请组5人队伍进行匹配，不能少于5人。")
		end
	end
end


function 场景类_剑会天下:检查点(x,y)
	if self.可视 and (self.资源组[1]:是否选中(x,y) or self.资源组[2]:是否选中(x,y))  then
		return true
	end
end

function 场景类_剑会天下:初始移动(x,y)
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

function 场景类_剑会天下:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_剑会天下
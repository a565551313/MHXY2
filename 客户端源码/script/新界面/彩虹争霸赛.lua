local tp,zts
local insert = table.insert
local 彩虹争霸赛 = class()
-- zip = require("ZIP类")()
-- zip:打开("pic/sq/bd.zip","youbingdu1")
function 彩虹争霸赛:初始化(根)
	self.ID = 133
	self.x = 1
	self.y = 80
	self.xx = 0
	self.yy = 0
	self.注释 = "彩虹争霸赛"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	self.云影=500
	self.虹光=500
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,167,90,3,9),--xa新大底图--自适应.创建(0,1,167,90,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[4] = 资源:载入(wdf配置.."/pic/彩虹争霸/111.png","图片"),
		[5] = 资源:载入(wdf配置.."/pic/彩虹争霸/222.png","图片"),
		[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x590CAA9B),

	}
	zts = tp.字体表.普通字体
end

-- function 彩虹争霸赛:加载资源()
-- 	local 资源 = tp.资源
-- 	local 按钮 = tp._按钮
-- 	local 自适应 = tp._自适应
-- 	self.资源组 = {
-- 		[1] = 自适应.创建(99,1,167,90,3,9),--xa新大底图--自适应.创建(0,1,167,90,3,9),
-- 		-- [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
-- 		-- [3] = 自适应.创建(1,1,138,18,1,3,nil,18),
-- 		[2] = 按钮.创建(资源:载入('nice.rpk',"网易WDF动画",0x01343E13),0,0,3,true,true), --J的新关闭按钮
-- 		-- [3] = 资源:载入('pic/标题背景.png',"图片"), --字体背景
-- 		[4] = zip:取精灵([[111.png]]),
-- 		[5] = zip:取精灵([[222.png]]),
-- 		[6] = 资源:载入('wzife.wdf',"网易WDF动画",0x590CAA9B),
-- 	}
-- end

function 彩虹争霸赛:数据处理(数据)
	self.云影 =数据.云影
	self.虹光 =数据.虹光
end

function 彩虹争霸赛:打开()
	if self.可视 then
		self.可视 = false
		return
	else
		insert(tp.窗口_,self)
		-- if tp.战斗中 then
		--     insert(tp.战斗窗口_,self) --测试模式 修改战斗中显示窗口时更改
		-- end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 彩虹争霸赛:显示(dt,x,y)
	self.焦点= false
	self.资源组[2]:更新(x,y)
	self.资源组[6]:更新(dt,3)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+147,self.y+2)
	zts:置样式(0):置颜色(白色):显示(self.x+10,self.y+30,"云影")
	zts:置样式(0):置颜色(白色):显示(self.x+132,self.y+30,"虹光")
	local 总积分 = self.云影 + self.虹光
	local 云影长度 = math.floor(146*(self.云影/总积分))
	local 虹光长度 = 146-云影长度
	self.资源组[4]:置区域(0,0,云影长度,20)
	self.资源组[5]:置区域(云影长度,0,虹光长度,20)
	self.资源组[4]:显示(self.x+11,self.y+55)
	self.资源组[5]:显示(self.x+11+云影长度,self.y+55)
	zts:置颜色(白色):置样式(1):显示(self.x+83,self.y+57,self.云影.."/"..self.虹光)
	zts:显示(self.x+82,self.y+3,"彩虹争霸赛")
	self.资源组[6]:显示(self.x+71,self.y+50)
	zts:置样式(0)
	if self.资源组[2]:事件判断() then
	   self:打开()
	   return
	end
end


function 彩虹争霸赛:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 彩虹争霸赛:初始移动(x,y)
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

function 彩虹争霸赛:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 彩虹争霸赛
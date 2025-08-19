local 场景类_剑会匹配 = class()
local qmx = 引擎.取模型
local tp,jhzts,jhzts1,jhhy
local insert = table.insert
local tx = 引擎.取头像
local rx = {
	飞燕女 = 1,
	骨精灵 = 2,
	鬼潇潇 = 3,
	狐美人 = 4,
	虎头怪 = 5,
	剑侠客 = 6,
	巨魔王 = 7,
	龙太子 = 8,
	杀破狼 = 9,
	神天兵 = 10,
	巫蛮儿 = 11,
	舞天姬 = 12,
	逍遥生 = 13,
	玄彩娥 = 14,
	偃无师 = 15,
	英女侠 = 16,
	羽灵神 = 17,
	桃夭夭 = 18,
	影精灵 = 2,
}
local rxzy = {0x1A23FA19,0x1A23FA20,0x1A23FA21,0x1A23FA22,0x1A23FA23,0x1A23FA24,0x1A23FA25,0x1A23FA26,0x1A23FA27,0x1A23FA28,0x1A23FA29,0x1A23FA30,0x1A23FA31,0x1A23FA32,0x1A23FA33,0x1A23FA34,0x1A23FA35,0x1A23FA36}
function 场景类_剑会匹配:初始化(根)
	self.ID = 98
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "剑会天下"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.右键关闭 = 1
	self.可移动 = false
	self.窗口时间 = 0
	tp = 根
	jhzts = tp.字体表.普通字体
	jhzts1 = tp.字体表.普通字体
	jhhy = tp.字体表.普通字体
end

function 场景类_剑会匹配:加载资源()
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	local 资源 = tp.资源
	self.资源组 = {
		[1] = 自适应.创建(9,1,全局游戏宽度,全局游戏高度,3,9),
		[2] = 按钮.创建(自适应.创建(38,4,71,22,1,3),0,0,4,true,true,"匹配中"),
		[3] = 按钮.创建(自适应.创建(38,4,71,22,1,3),0,0,4,true,true,"取消匹配"),
	}
	self.人像组={}
	for n=1,18 do
	    self.人像组[n] = 资源:载入('登陆资源.wdf',"网易WDF动画",rxzy[n])
	end
	for i=2,3 do
	  	self.资源组[i]:绑定窗口_(98)
	end
end

function 场景类_剑会匹配:打开(数据) -- 服饰染色 召唤兽染色
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
	    self.人数 = 数据.人数
	    self.模式 = 数据.模式
	    self.时间 = 0
	end
end

function 场景类_剑会匹配:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新1(x,y)
	self.资源组[3]:更新1(x,y)
	self.资源组[1]:显示(0,0)
	self.资源组[1]:显示(0,0)
	self.资源组[1]:显示(0,0)
	self.资源组[1]:显示(0,0)
	self.资源组[1]:显示(0,0)
	if self.人数 == 1 then
		self.人像组[rx[tp.队伍[1].模型]]:显示(全局游戏宽度/2-45,全局游戏高度/2-200)
	elseif self.人数 == 3 then
		for n=1,3 do
    		self.人像组[rx[tp.队伍数据[n].模型]]:显示(全局游戏宽度/2-185+(n-1)*138,全局游戏高度/2-200)
    	end
	elseif self.人数 == 5 then
		for n=1,5 do
    		self.人像组[rx[tp.队伍数据[n].模型]]:显示(全局游戏宽度/2-340+(n-1)*138,全局游戏高度/2-200)
    	end
	end
	self.时间 = self.时间 + 1
	if self.时间==0 or self.时间 <=60 then
		self.资源组[2]:置文字("匹配中.")
	elseif self.时间 <=120 then
		self.资源组[2]:置文字("匹配中..")
	elseif self.时间 <=180 then
		self.资源组[2]:置文字("匹配中...")
	elseif self.时间 <= 240 then
		self.时间 = 0
	end
	self.资源组[2]:显示(全局游戏宽度/2-130,全局游戏高度/2+70)
	self.资源组[3]:显示(全局游戏宽度/2+100,全局游戏高度/2+70)
	jhhy:置颜色(黄色):显示(全局游戏宽度/2-65,全局游戏高度/2+110,"当前匹配模式为:"..self.模式)
	if self.资源组[3]:事件判断() then
		请求服务(67,{模式=self.模式})
		-- self:打开()
		return
	end
end


function 场景类_剑会匹配:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 场景类_剑会匹配:初始移动(x,y)
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

function 场景类_剑会匹配:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_剑会匹配
--======================================================================--
local 邀请组队 = class()
local tp,zts
local mousea = 引擎.鼠标弹起
local insert = table.insert
local txs = 引擎.取头像
function 邀请组队:初始化(根)
	self.ID = 143
	self.x = 354
	self.y = 119
	self.xx = 0
	self.yy = 0
	self.注释 = "邀请组队"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = false
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	self.资源组 = {
		[1] = 自适应.创建(6,1,305,84,3,9),
		[2] = 按钮.创建(自适应.创建(12,4,100,20,1,3),0,0,4,true,true,"   接受"),
		[3] = 按钮.创建(自适应.创建(12,4,100,20,1,3),0,0,4,true,true,"   拒绝"),
		[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x0D3EA20B),



	}
   -- self.头像背景 = 资源:载入('pic/txbj.png',"图片")
	self.窗口时间 = 0
	tp = 根
	self.介绍文本 = 根._丰富文本(230,230,tp.字体表.排行字体)
	self.队伍状态 ="邀请入队"

end

function 邀请组队:打开(内容)
	if self.可视 then
		if 内容==nil then
			self.介绍文本:清空()
		    self.可视 = false
		    return
		end
		self.介绍文本:清空()
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间

	else
		insert(tp.窗口_,self)
		self.队伍id=内容.队长id
		self.邀请id=内容.邀请id
		local xx = txs(内容.模型)
		self.头像 = tp.资源:载入(xx[7],"网易WDF动画",xx[2])
		self.名称=内容.名称
		self.等级=内容.等级
		self.队伍状态 =内容.状态
		self.介绍文本:清空()
        if self.队伍状态=="申请入队" and tp.场景.人物.队长开关 then
            self.介绍文本:添加文本("#G"..self.名称.."#Y("..self.等级.."级)#W申请加入你的队伍，是否接受？")
	    elseif self.队伍状态=="邀请入队" then
	    	self.介绍文本:添加文本("#G"..self.名称.."#Y("..self.等级.."级)#W邀请你加入他的队伍，是否接受？")
	    end
	    self.出现时间=os.time()+600

		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end


function 邀请组队:刷新(内容)
		self.队伍id=内容.队长id
		self.邀请id=内容.邀请id
		local xx = txs(内容.模型)
		self.头像 = tp.资源:载入(xx[7],"网易WDF动画",xx[2])
		self.名称=内容.名称
		self.等级=内容.等级
		self.队伍状态 =内容.状态
		self.介绍文本:清空()
		self.出现时间=os.time()+600
		if self.队伍状态=="申请入队" and tp.场景.人物.队长开关 then
            self.介绍文本:添加文本("#G"..self.名称.."#Y("..self.等级.."级)#W申请加入你的队伍，是否接受？")
	    elseif self.队伍状态=="邀请入队" then
	    	self.介绍文本:添加文本("#G"..self.名称.."#Y("..self.等级.."级)#W邀请你加入他的队伍，是否接受？")
	    end
end



function 邀请组队:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(全局游戏宽度-320,全局游戏高度-174)
	--self.头像背景:显示(全局游戏宽度-380+6,全局游戏高度-174+6)
	tp.人物头像背景_:显示(全局游戏宽度-320+6,全局游戏高度-174+16)
	self.头像:显示(全局游戏宽度-320+6,全局游戏高度-174+19)
	self.介绍文本:显示(全局游戏宽度-320+61,全局游戏高度-174+16)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[2]:显示(全局游戏宽度-320+65,全局游戏高度-174+56)
	self.资源组[3]:显示(全局游戏宽度-320+185,全局游戏高度-174+56)
	--self.资源组[4]:显示(全局游戏宽度-320+33,全局游戏高度-174+60)
	if self.资源组[2]:事件判断() then --接受

		if self.队伍状态=="申请入队" and tp.场景.人物.队长开关 then
            请求服务(4016,{队伍id=self.队伍id,对方id=self.邀请id})
	    elseif self.队伍状态=="邀请入队" then
	    	请求服务(4015,{队伍id=self.队伍id,邀请id=self.邀请id})
	    end
        self:打开()
    	return
    elseif self.资源组[3]:事件判断() then
    	if  os.time()<=self.出现时间 then
	    	if self.队伍状态=="申请入队" and tp.场景.人物.队长开关 then
	            请求服务(4018,{队伍id=self.队伍id,对方id=self.邀请id})
		    elseif self.队伍状态=="邀请入队" then
		    	请求服务(4017,{队伍id=self.队伍id,邀请id=self.邀请id})
		    end
		end
    	self:打开()
    	return
	end



end


function 邀请组队:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 邀请组队:初始移动(x,y)
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

function 邀请组队:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 邀请组队
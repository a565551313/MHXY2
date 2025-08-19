local 系统类_每日签到 = class()

local floor = math.floor
local min = math.min
local tp,zts1,zts2,zts111
local xxx = 0
local yyy = 0
local max = 1
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local 奖励物品 = {{名称="秘制红罗羹"},{名称="光芒石"},{名称="魔兽要诀"},{名称="特赦令牌"},{名称="秘制绿罗羹"},{名称="神兜兜"},{名称="召唤兽内丹"},{名称="元宵"},
{名称="黑宝石"},{名称="星辉石"},{名称="高级魔兽要诀"},{名称="5级宝石礼包"},{名称="舍利子"},{名称="秘制绿罗羹"},{名称="特赦令牌"},{名称="神兜兜"},{名称="高级召唤兽内丹"},
{名称="秘制红罗羹"},{名称="魔兽要诀"},{名称="太阳石"},{名称="秘制绿罗羹"},{名称="元宵"},{名称="高级魔兽要诀"},{名称="秘制红罗羹"},{名称="5级宝石礼包"},{名称="神兜兜"},
{名称="秘制绿罗羹"},{名称="特赦令牌"},{名称="太阳石"},{名称="魔兽要诀"},{名称="太阳石"},{名称="秘制红罗羹"},{名称="光芒石"},{名称="魔兽要诀"},{名称="特赦令牌"},
{名称="秘制绿罗羹"},{名称="神兜兜"},{名称="召唤兽内丹"},{名称="元宵"},{名称="黑宝石"},{名称="星辉石"},{名称="高级魔兽要诀"}}

function 系统类_每日签到:初始化(根)
	self.ID = 74
	--宽高 549 431
	self.x = 全局游戏宽度/2-600/2
	self.y = 全局游戏高度/2-432/2
	self.xx = 0
	self.yy = 0
	self.注释 = "每日签到"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.状态 = 1
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zta = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	zts111 = tp.字体表.签到字体
	zts2 = tp.字体表.普通字体__
	self.分类选中=""
	self.子类选中=""
	self.玩法介绍内容=""
	self.丰富文本说明 = 根._丰富文本(476,265)

end

function 系统类_每日签到:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 自适应 = tp._自适应
		local 按钮 = tp._按钮
		self.资源组 = {
			[1] = 资源:载入("wdf/pic/签到界面.png","图片"),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			--[3] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000033),0,0,1,true,true),
			[3] = 资源:载入('房屋图标.wdf',"网易WDF动画",0x10000033),
			[4] = tp.资源:载入('nccmm.npk',"网易WDF动画","32"),
			[5] = 资源:载入("wdf/pic/签到选择.png","图片"),
			[6] = 资源:载入("wdf/pic/未领取.png","图片"),
			[7] = 资源:载入("wdf/pic/领取.png","图片"),
			[8] = 资源:载入("wdf/pic/签到未领取.png","图片"),
			[9] = 资源:载入("wdf/pic/选中.png","图片"),

		}


		self.状态 = 1
		self.加入 = 0
		self.数据=数据
 		self.几号 = self.数据.几号
 		self.月份 = self.数据.月份
 		self.当月天数=self.数据.当月天数
 		local 当前时间 = os.time()
 		self.周几 = os.date("%w",os.time()-(os.date("%d", os.time())-1)*86400)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.起始位置 = self.周几 + 1
		self.上月天数 = os.date("%d",os.time({year=os.date("%Y"),month=os.date("%m"),day=0}))
        self.物品数据 = {}
	    for n = 1,42 do
	        local 物品资料数据=引擎.取物品(奖励物品[n].名称)
	        self.物品数据[n] = tp._物品格子.创建(0,0,i,"VIP系统")
	        self.物品数据[n]:置物品(奖励物品[n],"VIP系统")
	        self.物品数据[n].编号 = n
	        self.物品数据[n].名称=奖励物品[n].名称
	        self.物品数据[n].大模型=tp.资源:载入(物品资料数据[11],"网易WDF动画",物品资料数据[12])
	        self.物品数据[n].介绍 = 物品资料数据[1]
	    end
	end
end

function 系统类_每日签到:刷新(数据)
	self.数据=数据
	self.几号 = self.数据.几号
	self.月份 = self.数据.月份
	self.当月天数=self.数据.当月天数
end


function 系统类_每日签到:显示(dt,x,y)

	self.资源组[2]:更新(x,y)
	--self.资源组[3]:更新(x,y)


	self.丰富文本说明:更新(dt,x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	--elseif self.资源组[3]:事件判断() then
		--请求服务(44,{月份=self.月份,几号=self.几号})


	end
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	tp.字体表.标题字体:显示(self.x+278,self.y+3,"每日签到")
	self.资源组[2]:显示(self.x+601,self.y+5)
	--self.资源组[3]:显示(self.x+15,self.y+340)
	local xx = 0
	local yy = 0
	for i=1,42 do
		if xx>=7 then
		    yy=yy+1
		    xx=0
		end
		if i < self.起始位置+0 then
			-- self.资源组[4]:显示(self.x+16+xx*62,self.y+52+yy*45)
			-- zts111:置颜色(0xFFFFFFFF)
	  --       zts111:置描边颜色(0xFF6699ff)
			-- zts111:显示(self.x+17+xx*85,self.y+85+yy*60,self.上月天数-self.周几+i)
		elseif i >= self.起始位置+0 and i<=self.当月天数+self.周几 then
			self.资源组[5]:显示(self.x+11+xx*86,self.y+85+yy*60)
			zts111:置颜色(白色)
			zts111:置描边颜色(0xFF0066CC)
            zts111:显示(self.x+17+xx*85,self.y+86+yy*60,i-self.周几)
			if self.数据[i-self.周几] then
				self.资源组[3]:显示(self.x+9+xx*87,self.y+85+yy*60)
			    self.资源组[7]:显示(self.x+68+xx*87,self.y+90+30+yy*60)
			    if self.资源组[3]:是否选中(x,y)  then
				    tp.提示:自定义(x,y,"#Y已签到。")
				 end

			else
				self.资源组[8]:显示(self.x+11+xx*86,self.y+85+yy*60)
				self.资源组[6]:显示(self.x+68+xx*87,self.y+90+30+yy*60)
				zts111:置描边颜色(0xFF0066CC)
				zts111:置颜色(白色)
				zts111:显示(self.x+19+xx*85,self.y+88+yy*60,i-self.周几)
				 if self.资源组[8]:是否选中(x,y)  then
				    tp.提示:自定义(x,y,"#Y未签到。")
				  end

			end

		        self.物品数据[i].大模型:显示(self.x+30+xx*85,self.y+85+yy*60)
		        if  self.物品数据[i].大模型:是否选中(x,y) and mouseb(0) then
		          请求服务(47,{月份=self.月份,几号=self.几号})
		        end



		else
			-- 修复：注释掉多余数字渲染，防止界面下方出现1~9等错位数字
			-- self.资源组[4]:显示(self.x+100+xx*62,self.y+500+yy*400)
			-- zts1:显示(self.x+15+xx*85,self.y+400+yy*60,i-self.当月天数-self.周几)
		end
		xx=xx+1
	end


	zts1:置颜色(白色)
	zts1:显示(self.x+492,self.y+26,os.date("%Y", os.time()).."年"..os.date("%m", os.time()).."月"..os.date("%d", os.time()).."日")
	zts1:显示(self.x+512,self.y+26+15,os.date("%X", os.time()))
	zta:置颜色(白色)

end

function 系统类_每日签到:检查点(x,y)
	if self.资源组~= nil   then
		return true
	end
end

function 系统类_每日签到:初始移动(x,y)
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

function 系统类_每日签到:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 系统类_每日签到
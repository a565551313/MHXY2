
local BOOS挑战 = class()
local tp
local zts1,zts
local floor = math.floor
local min = math.min
function BOOS挑战:初始化(根)
  	self.ID = 136
	self.x = 152
	self.y = 88
	self.xx = 0
	self.yy = 0
	self.注释 = "BOOS挑战类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	zts = require("gge文字类").创建(nil,18,true,false,true)
	tp = 根
	zts1 = tp.字体表.普通字体_
end
function BOOS挑战:打开(内容)
	if self.可视 then
		self.可视=false
		self.数据={}
	else
		table.insert(tp.窗口_,self)
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		local 资源 = tp.资源
		self.资源组 = {
			[1]=自适应.创建(0,1,634,453,3,9), --背景
			--[2]=pwd("wyjl"), --动画
			[3]=按钮.创建(自适应.创建(13,4,72,22,1,3),0,0,4,true,true,"开启挑战"),
			[4]=按钮.创建(自适应.创建(13,4,72,22,1,3),0,0,4,true,true,"领取奖励"),
			[5]=自适应.创建(4,1,290,406,3,nil),
			[6]=自适应.创建(2,1,290,152,3,9),
			[7]=资源:载入(wdf配置.."/pic/界面/世界boss经验条.png", "图片"),
			[8]=资源:载入('房屋图标.wdf',"网易WDF动画",0x10000117),
			[9]=资源:载入(wdf配置.."/pic/界面/竖线.png", "图片"),
			[10]=自适应.创建(2,1,290,148,3,9),
			[11]=按钮.创建(资源:载入(tp.打勾框,"网易WDF动画",0x00000009),0,0,1,true,true),
			[12]=资源:载入(wdf配置.."/pic/界面/世界BOSS.png", "图片"),
			[13]=资源:载入(wdf配置.."/pic/界面/名称框.png", "图片"),
		}
		self.数据 = 内容
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视=true
	    self.资源组[11]:置打勾框(tp.窗口.战斗排行框.隐藏)
	end
end

function BOOS挑战:更新(dt)end


function BOOS挑战:显示(dt,x,y)
	self.焦点=false
	self.资源组[3]:更新(x,y,self.数据.开启)
	--self.资源组[2]:更新(dt)
	self.资源组[11]:更新(x,y)
	self.资源组[4]:更新(x,y)
	self.资源组[1]:显示(self.x,self.y)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y)
    tp.字体表.排行字体:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+3,"世界Boss")
	self.资源组[5]:显示(self.x+20,self.y+32)
	self.资源组[9]:显示(self.x+91,self.y+33)
	self.资源组[9]:显示(self.x+165,self.y+33)
	self.资源组[9]:显示(self.x+241,self.y+33)
	self.资源组[6]:显示(self.x+323,self.y+62)
	self.资源组[10]:显示(self.x+323,self.y+262)
	self.资源组[11]:显示(self.x+466,self.y+225)
	self.资源组[12]:显示(self.x+404,self.y+62)
	self.资源组[13]:显示(self.x+380,self.y+181)
	tp.字体表.排行字体1:置颜色(红色):显示(self.x+318,self.y+37,"Boss血量")
	--self.资源组[2]:显示(self.x+125,self.y+325)--动画
	self.资源组[7]:显示(self.x+383,self.y+33)
	self.资源组[3]:显示(self.x+480,self.y+418)
	self.资源组[4]:显示(self.x+362,self.y+418)
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+41,self.y+37,"名称")
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+115,self.y+37,"等级")
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+192,self.y+37,"门派")
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+264,self.y+37,"伤害")
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+326,self.y+230,"活动状态显示:")
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+497,self.y+230,"显示本队伍战斗信息")
	tp.字体表.排行字体1:置颜色(蓝色):显示(self.x+427,self.y+192,"司 法 天 神")
	tp.字体表.排行字体1:置颜色(黑色):显示(self.x+330,self.y+270,"(1)BOSS血量降为0\n即视为结束.同时给予Boss致命一击的队伍会\n有高额奖励哟!")
	tp.字体表.排行字体1:置颜色(黑色):显示(self.x+330,self.y+316,"(2)任务形式：组队任务，可以在BOSS战前\n组好自己的队伍哟.")
	tp.字体表.排行字体1:置颜色(黑色):显示(self.x+330,self.y+349,"(3)等级限制：达到69级，未满69级小朋友\n乖乖抓鬼吧.")
	tp.字体表.排行字体1:置颜色(黑色):显示(self.x+330,self.y+383,"(4)任务描述：用来吓唬小朋友的。")

	if self.数据.排行 ~= nil then
		local yyy=0
		for i=1,#self.数据.排行 do
			if i == 1 then
				zts1:置颜色(红色)
			elseif i == 2 then
				zts1:置颜色(蓝色)
			elseif i == 3 then
				zts1:置颜色(绿色)
			else
				zts1:置颜色(黑色)
			end
			zts1:显示(self.x-5+ ((100 - zts1:取宽度(self.数据.排行[i].名称))/2)+8,self.y+92+yyy*80,self.数据.排行[i].名称)
			zts1:显示(self.x+70+ ((100 - zts1:取宽度(self.数据.排行[i].等级))/2)+8,self.y+92+yyy*80,self.数据.排行[i].等级)
			zts1:显示(self.x+146+ ((100 - zts1:取宽度(self.数据.排行[i].门派))/2)+8,self.y+92+yyy*80,self.数据.排行[i].门派)
			zts1:显示(self.x+219+ ((100 - zts1:取宽度(self.数据.排行[i].伤害))/2)+8,self.y+92+yyy*80,self.数据.排行[i].伤害)
			yyy = yyy + 1
		end
	end
	zts1:置颜色(白色)
	if self.资源组[3]:事件判断() then
		请求服务(56)
	elseif self.资源组[4]:事件判断() then
		请求服务(57)
	elseif self.资源组[11]:事件判断() then
		if tp.窗口.战斗排行框.隐藏 then
				tp.窗口.战斗排行框.隐藏 = false
				tp.常规提示:打开("#Y/战斗伤害排行帮关闭！")
			else
				tp.窗口.战斗排行框.隐藏 = true
				tp.常规提示:打开("#Y/战斗伤害排行帮开启！")
			end
			self.资源组[11]:置打勾框(tp.窗口.战斗排行框.隐藏)
	end
	if self.数据.开启 then
		--zts:置颜色(白色)
		self.资源组[8]:置区域(0,0,min(floor(self.数据.气血.当前 /self.数据.气血.上限 *234),234),16)
        self.资源组[8]:显示(self.x+384,self.y+35)
        tp.字体表.排行字体1:置颜色(白色):显示(self.x+443,self.y+36,self.数据.气血.当前.."/"..self.数据.气血.上限)
        tp.字体表.排行字体1:置颜色(绿色):显示(self.x+415,self.y+230,"进行中")
	else
		tp.字体表.排行字体1:置颜色(红色):显示(self.x+415,self.y+230,"已结束")
	end
   tp.字体表.排行字体1:置颜色(白色)

end

function BOOS挑战:初始移动(x,y)
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

function BOOS挑战:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy


	end
end
function BOOS挑战:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

return BOOS挑战











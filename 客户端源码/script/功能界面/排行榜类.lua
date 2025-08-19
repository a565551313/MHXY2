--======================================================================--
-- @作者: GGE研究群：688742892
-- @创建时间:   2020-04-01 08:30:00
-- @Last Modified time: 2025-01-23 22:02:34
-- @特别声明：本版由优秀跟鱼总合力优化与修复漏洞，添加了各种功能。
--======================================================================--
local 排行榜类 = class()
local insert = table.insert
local zts
local bw = require("gge包围盒")(0,0,20,20)

function 排行榜类:初始化(根)
	self.ID = 56
	self.宽 = 644
    self.高 = 544
    self.x = 全局游戏宽度/2-self.宽/2+50
    self.y = 全局游戏高度/2-self.高/2
    self.临时窗宽=全局游戏宽度
    self.临时窗高=全局游戏高度
	self.xx = 0
	self.yy = 0
	self.注释 = "排行榜"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 滑块 = 根._滑块
	self.资源组 = {
	[1]=资源:载入(wdf配置.."/pic/排行榜.png", "图片"), --背景
	[2]=按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000606),0,0,4,true,true),
	--[3] =  根._滑块.创建(自适应.创建(115,4,10,20,4,3,nil),4,10,290,2),
	[4]=资源:载入(wdf配置.."/pic/11.png", "图片"),
	[5]=资源:载入(wdf配置.."/pic/22.png", "图片"),
	[6]=资源:载入(wdf配置.."/pic/33.png", "图片"),
	}

	self.玩家伤害排行=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
	self.玩家灵力排行=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
	self.玩家师傅排行=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
	self.玩家剑会排行=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
    self.玩家剑会季度=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
    self.玩家镇妖层数=按钮(资源:载入("房屋图标.wdf","网易WDF动画",0X10000030),0,0,4,true,true)
	self.风云榜标题=资源:载入("登陆资源.wdf","网易WDF动画",0X75B260A7) --风云榜标题
    zts = tp.字体表.排行字体1
    self.排行榜数据={}
    self.查看类型="玩家伤害排行"
    self.进程 = 1
    self.加入 = 0
end

function 排行榜类:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y) then
		return true
	else
		return false
	end
end

function 排行榜类:打开(内容)
	if self.临时窗宽~=全局游戏宽度 or self.临时窗高~=全局游戏高度 then
        self.x = 全局游戏宽度/2-self.宽/2+50
        self.y = 全局游戏高度/2-self.高/2
        self.临时窗宽=全局游戏宽度
        self.临时窗高=全局游戏高度
    end
	if self.可视 then
		self.可视=false
		self.排行榜数据={}
		self.加入 = 0
		return
	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视=true
		self.排行榜数据=内容
		self.进程 = 1

		-- 请求服务(39)
	end
end


function 排行榜类:显示(dt,x,y)
	self.焦点=false

	self.玩家伤害排行:更新(x,y,self.进程 ~= 1)
	self.玩家灵力排行:更新(x,y,self.进程 ~= 2)
	self.玩家师傅排行:更新(x,y,self.进程 ~= 3)
	self.玩家剑会排行:更新(x,y,self.进程 ~= 4)
	self.玩家剑会季度:更新(x,y,self.进程 ~= 5)
	self.玩家镇妖层数:更新(x,y,self.进程 ~= 6)

    self.资源组[2]:更新(x,y)

	self.资源组[1]:显示(self.x-50, self.y-20)--背景
	self.风云榜标题:显示(self.x-50+230, self.y-30)
	self.资源组[2]:显示(self.x-50+630, self.y-20+7)
	self.玩家伤害排行:显示(self.x+27, self.y+63,true,nil,nil,self.进程 == 1,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+34, self.y+70,"伤害排行")

	self.玩家灵力排行:显示(self.x+117, self.y+63,true,nil,nil,self.进程 == 2,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+124, self.y+70,"法伤排行")

	self.玩家师傅排行:显示(self.x+207, self.y+63,true,nil,nil,self.进程 == 3,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+214, self.y+70,"收徒排行")

	self.玩家剑会排行:显示(self.x+207+90, self.y+63,true,nil,nil,self.进程 == 4,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+214+90, self.y+70,"剑会排行")

	self.玩家剑会季度:显示(self.x+207+90+90, self.y+63,true,nil,nil,self.进程 == 5,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+214+90+90, self.y+70,"剑会季度")

	self.玩家镇妖层数:显示(self.x+207+90+90+90, self.y+63,true,nil,nil,self.进程 == 6,2)
	tp.字体表.排行字体:置颜色(白色):显示(self.x+214+90+90+90, self.y+70,"镇妖之塔")

	self.资源组[4]:显示(self.x-50+57+33-12, self.y-20+144-5)
	self.资源组[5]:显示(self.x-50+57+33-10, self.y-20+144+29)
	self.资源组[6]:显示(self.x-50+57+33-5, self.y-20+144+30*2)
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+144+32*3,"4")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+144+32*4,"5")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+144+32*5,"6")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+143+32*6,"7")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+143+32*7,"8")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+57+33, self.y-20+140+32*8,"9")
	tp.字体表.排行字体:置颜色(黑色):显示(self.x-50+52+33, self.y-20+139+32*9,"10")
if self.资源组[2]:事件判断() then
			self:打开()
			return false
elseif self.玩家伤害排行:事件判断() then
        self.进程 = 1
elseif self.玩家灵力排行:事件判断() then
		self.进程 = 2
elseif self.玩家师傅排行:事件判断() then
		self.进程 = 3
elseif self.玩家剑会排行:事件判断() then
		self.进程 = 4
elseif self.玩家剑会季度:事件判断() then
		self.进程 = 5
elseif self.玩家镇妖层数:事件判断() then
		self.进程 = 6
end
if self.进程 == 1 then
    tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+140, self.y-20+117,"名 称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+300, self.y-20+117,"I D")
	tp.字体表.排行字体:置颜色(白色):显示(self.x+461, self.y+97,"伤 害")
		self.查看类型="玩家伤害排行"
elseif self.进程 == 2 then
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+140, self.y-20+117,"名 称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+300, self.y-20+117,"I D")
	tp.字体表.排行字体:置颜色(白色):显示(self.x+461, self.y+97,"法 伤")
		self.查看类型="玩家灵力排行"
elseif self.进程 == 3 then
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+10+140, self.y-20+117,"师傅名称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+300, self.y-20+117,"I D")
	tp.字体表.排行字体:置颜色(白色):显示(self.x+461, self.y+97,"出师人数")
	self.查看类型="玩家师傅排行"
elseif self.进程 == 4 then
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+150-50, self.y-20+117,"名 称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+310-100, self.y-20+117,"等 级")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+430-100, self.y-20+117,"门 派")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+560-100, self.y-20+117,"积 分")
	self.查看类型="玩家剑会排行"
elseif self.进程 == 5 then
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+150-50, self.y-20+117,"名 称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+310-100, self.y-20+117,"等 级")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+430-100, self.y-20+117,"积 分")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+67+560-100, self.y-20+117,"是否领取")
	self.查看类型="玩家剑会季度"
elseif self.进程 == 6 then
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20, self.y-20+117,"排 名")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+150-50, self.y-20+117,"名 称")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+310-100, self.y-20+117,"等 级")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+430-100, self.y-20+117,"门 派")
	tp.字体表.排行字体:置颜色(白色):显示(self.x-50+57+20+560-100, self.y-20+117,"层 数")
	self.查看类型="玩家镇妖层数"
end




	self.显示名字={"","","","","","","","","",""}
	self.显示剑会名字={"","","","","","","","","",""}
	self.显示剑会等级={"","","","","","","","","",""}
	self.显示剑会门派={"","","","","","","","","",""}
	self.显示剑会积分={"","","","","","","","","",""}
	self.显示分数={"","","","","","","","","",""}
	self.显示id={"","","","","","","","","",""}
	self.显示出师={"","","","","","","","","",""}

	self.显示剑会名字1={"","","","","","","","","",""}
	self.显示剑会等级1={"","","","","","","","","",""}
	self.显示剑会名字2={"","","","","","","","","",""}
	self.显示剑会等级2={"","","","","","","","","",""}
	self.显示剑会积分1={"","","","","","","","","",""}
	self.显示剑会门派2={"","","","","","","","","",""}
    self.显示剑会领取={"","","","","","","","","",""}
    self.显示镇妖层数={"","","","","","","","","",""}
	if self.排行榜数据[self.查看类型]~= nil then
		if #self.排行榜数据[self.查看类型]>0 then
			local 人数=#self.排行榜数据[self.查看类型]
			if 人数>10 then 人数=0 end
			for i=1,人数 do
				self.显示名字[i]=self.排行榜数据[self.查看类型][i].名称
				self.显示剑会名字[i]=self.排行榜数据[self.查看类型][i].剑会名称
				self.显示剑会等级[i]=self.排行榜数据[self.查看类型][i].剑会等级
				self.显示剑会门派[i]=self.排行榜数据[self.查看类型][i].剑会门派
				self.显示剑会积分[i]=self.排行榜数据[self.查看类型][i].剑会积分

				self.显示剑会名字1[i]=self.排行榜数据[self.查看类型][i].剑会名称1
				self.显示剑会等级1[i]=self.排行榜数据[self.查看类型][i].剑会等级1
				self.显示剑会积分1[i]=self.排行榜数据[self.查看类型][i].剑会积分1
				self.显示剑会领取[i]=self.排行榜数据[self.查看类型][i].是否领取
				self.显示分数[i]=self.排行榜数据[self.查看类型][i].分数
				self.显示出师[i]=self.排行榜数据[self.查看类型][i].出师
                self.显示镇妖层数[i]=self.排行榜数据[self.查看类型][i].层数

				self.显示剑会名字2[i]=self.排行榜数据[self.查看类型][i].剑会名称2
				self.显示剑会等级2[i]=self.排行榜数据[self.查看类型][i].剑会等级2
				self.显示剑会门派2[i]=self.排行榜数据[self.查看类型][i].剑会门派2
				if self.排行榜数据[self.查看类型][i].id ~= nil then
					self.显示id[i]=self.排行榜数据[self.查看类型][i].id
				end
				if self.排行榜数据[self.查看类型][i].出师 ~= nil then
				  self.显示出师[i]=self.排行榜数据[self.查看类型][i].出师
				end
			end
		end
	end

	--显示排名
	--self.起始x=138
	self.起始y=160
	self.高度差=32
	self.文字起始y=129
	self.文字x1=286----ID显示
	self.文字x2=137
	self.文字x3=425
	self.文字x4=445
	self.文字x5=96
	self.文字x6=251-45
	self.文字x7=347-19
	self.文字x8=347+96+13

	self.文字x9=96
	self.文字x10=251-45
	self.文字x11=345-19
	self.文字x12=347+96+13

	self.文字x13=347+96+13
	self.文字x14=96
	self.文字x15=251-45
	self.文字x16=347-19

--镇妖层数
    zts:置颜色(0xFF000033)
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示镇妖层数[2])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示镇妖层数[3])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示镇妖层数[4])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示镇妖层数[5])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示镇妖层数[6])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示镇妖层数[7])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示镇妖层数[8])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示镇妖层数[9])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示镇妖层数[10])
	zts:显示(self.x+self.文字x13-22+((130 - zts:取宽度(self.显示镇妖层数[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示镇妖层数[1])

	 zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会名字2[2])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会名字2[3])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会名字2[4])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会名字2[5])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会名字2[6])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会名字2[7])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会名字2[8])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会名字2[9])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会名字2[10])--ID显示
	zts:显示(self.x+self.文字x14-22+((130 - zts:取宽度(self.显示剑会名字2[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会名字2[1])--ID显示

    zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会等级2[2])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会等级2[3])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会等级2[4])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会等级2[5])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会等级2[6])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会等级2[7])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会等级2[8])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会等级2[9])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会等级2[10])
	zts:显示(self.x+self.文字x15-22+((130 - zts:取宽度(self.显示剑会等级2[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会等级2[1])

    zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会门派2[2])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会门派2[3])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会门派2[4])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会门派2[5])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会门派2[6])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会门派2[7])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会门派2[8])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会门派2[9])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会门派2[10])
	zts:显示(self.x+self.文字x16-22+((130 - zts:取宽度(self.显示剑会门派2[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会门派2[1])
--出师

    zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示出师[2])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示出师[3])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示出师[4])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示出师[5])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示出师[6])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示出师[7])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示出师[8])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示出师[9])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示出师[10])--ID显示
	zts:显示(self.x+self.文字x4-22+((130 - zts:取宽度(self.显示出师[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示出师[1])--ID显示
--剑会
    zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会名字[2])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会名字[3])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会名字[4])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会名字[5])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会名字[6])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会名字[7])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会名字[8])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会名字[9])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会名字[10])--ID显示
	zts:显示(self.x+self.文字x5-22+((130 - zts:取宽度(self.显示剑会名字[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会名字[1])--ID显示

    zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会等级[2])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会等级[3])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会等级[4])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会等级[5])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会等级[6])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会等级[7])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会等级[8])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会等级[9])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会等级[10])
	zts:显示(self.x+self.文字x6-22+((130 - zts:取宽度(self.显示剑会等级[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会等级[1])

    zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会门派[2])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会门派[3])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会门派[4])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会门派[5])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会门派[6])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会门派[7])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会门派[8])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会门派[9])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会门派[10])
	zts:显示(self.x+self.文字x7-22+((130 - zts:取宽度(self.显示剑会门派[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会门派[1])

    zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会积分[2])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会积分[3])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会积分[4])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会积分[5])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会积分[6])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会积分[7])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会积分[8])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会积分[9])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会积分[10])
	zts:显示(self.x+self.文字x8-22+((130 - zts:取宽度(self.显示剑会积分[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会积分[1])
---季度
    zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会名字1[2])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会名字1[3])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会名字1[4])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会名字1[5])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会名字1[6])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会名字1[7])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会名字1[8])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会名字1[9])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会名字1[10])--ID显示
	zts:显示(self.x+self.文字x9-22+((130 - zts:取宽度(self.显示剑会名字1[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会名字1[1])--ID显示

    zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会等级1[2])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会等级1[3])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会等级1[4])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会等级1[5])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会等级1[6])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会等级1[7])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会等级1[8])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会等级1[9])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会等级1[10])
	zts:显示(self.x+self.文字x10-22+((130 - zts:取宽度(self.显示剑会等级1[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会等级1[1])

    zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会积分1[2])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会积分1[3])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会积分1[4])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会积分1[5])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会积分1[6])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会积分1[7])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会积分1[8])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会积分1[9])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会积分1[10])
	zts:显示(self.x+self.文字x11-22+((130 - zts:取宽度(self.显示剑会积分1[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会积分1[1])

	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示剑会领取[2])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示剑会领取[3])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示剑会领取[4])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示剑会领取[5])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示剑会领取[6])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示剑会领取[7])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示剑会领取[8])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示剑会领取[9])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示剑会领取[10])
	zts:显示(self.x+self.文字x12-22+((130 - zts:取宽度(self.显示剑会领取[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示剑会领取[1])
	--结束
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示名字[1])
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[2]))/2)+8,self.y+self.文字起始y+self.高度差*1-5, self.显示id[2])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[3]))/2)+8,self.y+self.文字起始y+self.高度差*2-5, self.显示id[3])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[4]))/2)+8,self.y+self.文字起始y+self.高度差*3-5, self.显示id[4])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[5]))/2)+8,self.y+self.文字起始y+self.高度差*4-5, self.显示id[5])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[6]))/2)+8,self.y+self.文字起始y+self.高度差*5-5, self.显示id[6])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[7]))/2)+8,self.y+self.文字起始y+self.高度差*6-5, self.显示id[7])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[8]))/2)+8,self.y+self.文字起始y+self.高度差*7-5, self.显示id[8])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[9]))/2)+8,self.y+self.文字起始y+self.高度差*8-5, self.显示id[9])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[10]))/2)+8,self.y+self.文字起始y+self.高度差*9-5, self.显示id[10])--ID显示
	zts:显示(self.x+self.文字x1-22+((130 - zts:取宽度(self.显示id[1]))/2)+8,self.y+self.文字起始y+self.高度差*0-5, self.显示id[1])--ID显示
    zts:置颜色(黑色)
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[1]))/2)+8, self.y+self.文字起始y+self.高度差*0-5, self.显示分数[1])
    zts:置颜色(黑色)
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[2]))/2)+8, self.y+self.文字起始y+self.高度差*1-5, self.显示名字[2])
	zts:置颜色(黑色)
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[2]))/2)+8, self.y+self.文字起始y+self.高度差*1-5, self.显示分数[2])
    zts:置颜色(黑色)
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[3]))/2)+8, self.y+self.文字起始y+self.高度差*2-5, self.显示名字[3])
	zts:置颜色(黑色)
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[3]))/2)+8, self.y+self.文字起始y+self.高度差*2-5, self.显示分数[3])
	zts:置颜色(黑色)
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[4]))/2)+8, self.y+self.文字起始y+self.高度差*3-5, self.显示名字[4])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[4]))/2)+8, self.y+self.文字起始y+self.高度差*3-5, self.显示分数[4])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[5]))/2)+8, self.y+self.文字起始y+self.高度差*4-5, self.显示名字[5])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[5]))/2)+8, self.y+self.文字起始y+self.高度差*4-5, self.显示分数[5])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[6]))/2)+8, self.y+self.文字起始y+self.高度差*5-5, self.显示名字[6])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[6]))/2)+8, self.y+self.文字起始y+self.高度差*5-5, self.显示分数[6])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[7]))/2)+8, self.y+self.文字起始y+self.高度差*6-5, self.显示名字[7])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[7]))/2)+8, self.y+self.文字起始y+self.高度差*6-5, self.显示分数[7])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[8]))/2)+8, self.y+self.文字起始y+self.高度差*7-5, self.显示名字[8])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[8]))/2)+8, self.y+self.文字起始y+self.高度差*7-5, self.显示分数[8])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[9]))/2)+8, self.y+self.文字起始y+self.高度差*8-5, self.显示名字[9])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[9]))/2)+8, self.y+self.文字起始y+self.高度差*8-5, self.显示分数[9])
	zts:显示(self.x+self.文字x2-22+((130 - zts:取宽度(self.显示名字[10]))/2)+8, self.y+self.文字起始y+self.高度差*9-5, self.显示名字[10])
	zts:显示(self.x+self.文字x3-22+((130 - zts:取宽度(self.显示分数[10]))/2)+8, self.y+self.文字起始y+self.高度差*9-5, self.显示分数[10])
    zts:置颜色(白色):显示(self.x+10, self.y+429,"玩家进入游戏时排行会自动刷新")


end

function 排行榜类:检查点(x,y)
	if self.资源组[1]:是否选中(x+110,y) or self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 排行榜类:初始移动(x,y)
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

function 排行榜类:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 排行榜类
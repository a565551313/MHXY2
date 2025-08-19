--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_坐骑属性栏 = class()
local tx = 引擎.取头像
local bw = require("gge包围盒")(0,0,140,34)
local box = 引擎.画矩形
local ani = 引擎.取战斗模型
local format = string.format
local floor = math.floor
local min = math.min
local max = math.max
local tp,zts,zts1,zts2,ztstt3
local ceil = math.ceil
local tostring = tostring
local bd0 = {"气血","魔法","攻击","防御","速度","灵力"}
local bd = {"体质","魔力","力量","耐力","敏捷"}
local mousea = 引擎.鼠标按住
local mouseb = 引擎.鼠标弹起
local insert = table.insert
local zqj = 引擎.坐骑库
local tx = 引擎.取头像

function 场景类_坐骑属性栏:初始化(根)
	self.ID = 75
	self.x = 0
	self.y = 35
	self.xx = 0
	self.yy = 0
	self.注释 = "坐骑属性栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('坐骑总控件')
	总控件:置可视(true,true)
	self.名称输入框 = 总控件:创建输入("名称输入",0,0,100,14)
	self.名称输入框:置可视(false,false)
	self.名称输入框:置限制字数(12)
	self.名称输入框:置光标颜色(-16777216)
	self.名称输入框:置文字颜色(-16777216)
	self.临时潜力 = {}
	self.预览属性 = {}
	for i=0,7 do
		self.临时潜力[i] = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
	end
	for i=0,7 do
		self.预览属性[i] = {气血=0,魔法=0,伤害=0,速度=0,灵力=0,防御=0}
	end
	self.加入 = 0
	self.选中 = 0
	self.拽拖计次 = 0
	self.拽拖对象 = 0
	self.拽拖事件 = 0
	self.插入选区 = 0
	self.操作 = nil
	self.头像组 = {}
	self.窗口时间 = 0
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.普通字体__
	zts2 = tp.字体表.描边字体
	ztstt3 = tp.字体表.描边字体
	self.人物坐骑可视 = false
end


function 场景类_坐骑属性栏:打开()
	if self.可视 then
		self.加入 = 0
		self.选中 = 0
		self.拽拖计次 = 0
		self.拽拖对象 = 0
		self.拽拖事件 = 0
		self.插入选区 = 0
		self.头像组 = {}
		self.窗口时间 = 0
		self.名称输入框:置可视(false,false)
		self.可视 = false
		self.资源组[35]:置起始点(0)
		if tp.窗口.坐骑资质栏.可视 then
			tp.窗口.坐骑资质栏:打开()
		end
		if tp.窗口.坐骑技能栏.可视 then
			tp.窗口.坐骑技能栏:打开()
		end
		for i=0,7 do
			if tp.队伍[1] ~= nil and tp.坐骑列表[i] ~= nil and tp.坐骑列表[i].潜力~=nil then
				tp.坐骑列表[i].潜力 = tp.坐骑列表[i].潜力 + (self.临时潜力[i].体质+self.临时潜力[i].魔力+self.临时潜力[i].力量+self.临时潜力[i].耐力+self.临时潜力[i].敏捷)
			end
			self.临时潜力[i] = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
		end
		for i=0,7 do
			self.预览属性[i] = {气血=0,魔法=0,伤害=0,速度=0,灵力=0,防御=0}
		end
		self.资源组 = nil
		self.宝宝头像背景 = nil
		self.宝宝头像背景2 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			[0] = 自适应.创建(1,1,366,18,1,3,nil,18),
			[1] = 自适应.创建(0,1,370,453,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"骑乘 "),
			[4] = 按钮.创建(自适应.创建(12,4,30,20,1,3),0,0,4,true,true,"改 "),
			[5] = 按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
			[6] = 按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
			[7] = 按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
			[8] = 按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
			[9] = 按钮.创建(自适应.创建(25,4,19,19,4,3),0,0,4,true,true),
			[10] = 按钮.创建(自适应.创建(26,4,19,19,4,3),0,0,4,true,true),
			[11] = 按钮.创建(自适应.创建(26,4,19,19,4,3),0,0,4,true,true),
			[12] = 按钮.创建(自适应.创建(26,4,19,19,4,3),0,0,4,true,true),
			[13] = 按钮.创建(自适应.创建(26,4,19,19,4,3),0,0,4,true,true),
			[14] = 按钮.创建(自适应.创建(26,4,19,19,4,3),0,0,4,true,true),
			[15] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"推荐加点"),
			[16] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"预览"),
			[17] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"驯养"),
			[18] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"放生 "),
			[19] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"观看 "),
			[20] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"祥瑞 "),
			[21] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"确认加点"),
			[22] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xB15C5678),0,0,4,true,true,"查看技能"),
			[23] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x363AAF1B),
			[26] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x3906F9F1),--经验
			[27] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动
			[28] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
			[29] = 自适应.创建(34,1,173,142,3,9),--坐骑选择框171,182  --33
			[30] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA19838E8),--自适应.创建(2,1,158,173,3,9),--宠物显示框 158,153
			[31] = 自适应.创建(3,1,109,18,1,3),--属性框1
			[32] = 自适应.创建(3,1,97,18,1,3),--属性框2
			[33] = 自适应.创建(3,1,66,18,1,3),--属性框3 小
			[35] =  tp._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),4,14,143-55,2),
			[37] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"喂养"),
			[38] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"洗点"),
			[39] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE9063B56),--饰品  0x8561289C 空格子  8F00251E项链
		}
		self.宝宝头像背景 = 按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
		self.宝宝头像背景2 = 按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
		self.资源组[24] = nil--坐骑
		self.资源组[25] = nil--饰品
		self.资源组[40] = nil--饰品2
		self.资源组[36] = nil--人物
		self.资源组[22]:置偏移(0,3)
		for i=2,28 do
			if i ~= 23 and i ~= 24 and i ~= 25 and i ~= 26 then
				self.资源组[i]:绑定窗口_(75)
			end
		end
		self.物品 = {}
		local wp = tp._物品格子
		local 底图 =资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
		for i=1,1 do
		    self.物品[i] = wp(0,0,i,"坐骑资质物品",底图)--饰品装备框
		end
		if tp.坐骑列表==nil then
		    tp.坐骑列表={}
		end
		for i=1,#tp.坐骑列表 do
			if tp.坐骑列表[i].参战信息 ~= nil then
				if i > 3 then
					self.加入 = i-3
					self.资源组[35]:置起始点(self.资源组[35]:取百分比转换(self.加入,3,#tp.坐骑列表))
				end
				self.选中 = i
				self.名称输入框:置文本(tp.坐骑列表[self.选中].名称)
				self.名称输入框:置可视(true,true)
				if tp.窗口.坐骑资质栏.可视 then
					tp.窗口.坐骑资质栏:打开(tp.坐骑列表[self.选中])
				end
				if tp.窗口.坐骑技能栏.可视 then
					tp.窗口.坐骑技能栏:打开(tp.坐骑列表[self.选中],self.选中)
				end
				self:置形象()
				self.拽拖计次 = 0
				break
			end
		end
		if tp.坐骑列表[self.选中]~=nil then
		   	self.物品[1]:置物品(tp.坐骑列表[self.选中].饰品物件)
		else
			self.物品[1]:置物品(nil)
		end
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
		self.宝宝头像背景 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
		self.宝宝头像背景2 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
	end
end
function 场景类_坐骑属性栏:置形象()
	if tp.坐骑列表[self.选中]  ~= nil and tp.坐骑列表[self.选中].模型 ~= nil then
		local n = {}
		self.资源组[25] = nil
		self.资源组[40] = nil
		if 引擎.新增坐骑(tp.队伍[1].模型,tp.坐骑列表[self.选中].模型,"站立") then
			n = {}
			n.人物资源 = "xzzq.wdf"
			n.人物站立 = 引擎.新增坐骑(tp.队伍[1].模型,tp.坐骑列表[self.选中].模型,"站立")
			n.坐骑资源 = "xzzq.wdf"
			n.坐骑站立 = 引擎.新增坐骑(tp.队伍[1].模型,tp.坐骑列表[self.选中].模型,"站立")
		else
			n = zqj(tp.队伍[1].模型,tp.坐骑列表[self.选中].模型,tp.坐骑列表[self.选中].饰品 or "空",tp.坐骑列表[self.选中].饰品2 or "空")--ani(tp.坐骑列表[self.选中].模型)
		end
		if  tp.队伍[1].坐骑 ~= nil and tp.坐骑列表[self.选中] ~= nil and tp.队伍[1].坐骑.模型 == tp.坐骑列表[self.选中].模型 then
			self.资源组[36] = tp.资源:载入(n.人物资源,"网易WDF动画",n.人物站立)--人物
			self.资源组[36]:置染色(tp.队伍[1].染色方案,tp.队伍[1].染色组[1],tp.队伍[1].染色组[2],tp.队伍[1].染色组[3])
			self.资源组[36]:置方向(1)
			self.人物坐骑可视 = true
		else
			self.人物坐骑可视 = false
		end
		self.资源组[24] = tp.资源:载入(n.坐骑资源,"网易WDF动画",n.坐骑站立)--坐骑
		self.资源组[24]:置方向(1)
		if tp.坐骑列表[self.选中].饰品 ~= nil then
			self.资源组[25] = tp.资源:载入(n.坐骑饰品资源,"网易WDF动画",n.坐骑饰品站立)--饰品
			self.资源组[25]:置方向(1)
		end
		if tp.坐骑列表[self.选中].饰品2 ~= nil then
			self.资源组[40] = tp.资源:载入(n.坐骑饰品2资源,"网易WDF动画",n.坐骑饰品2站立)--饰品
			self.资源组[40]:置方向(1)
		end
		-- if tp.坐骑列表[self.选中].染色方案 ~= nil then
		-- 	self.资源组[24]:置染色(tp.坐骑列表[self.选中].染色方案,tp.坐骑列表[self.选中].染色组[1],tp.坐骑列表[self.选中].染色组[2],tp.坐骑列表[self.选中].染色组[3])
		-- 	self.资源组[24]:置方向(1)
		-- end
		self.物品[1]:置物品(tp.坐骑列表[self.选中].饰品物件)
	end
end

function 场景类_坐骑属性栏:刷新统御()
	local bbs = tp.坐骑列表
	if self.选中~=nil and self.选中~=0 and bbs[self.选中]~=nil and bbs[self.选中].统御召唤兽~=nil  then
	    if bbs[self.选中].统御召唤兽[1]~=nil then
			local n = tx(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[1]].模型)
			self.宝宝头像背景 = tp._按钮(tp.资源:载入(n[7],"网易WDF动画",n[1]),0,0,1,true,true)
	    else
			self.宝宝头像背景 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
	    end
	    if bbs[self.选中].统御召唤兽[2]~=nil then
			local nn = tx(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[2]].模型)
			self.宝宝头像背景2 = tp._按钮(tp.资源:载入(nn[7],"网易WDF动画",nn[1]),0,0,1,true,true)
	    else
			self.宝宝头像背景2 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
	    end
	else
		self.宝宝头像背景 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
		self.宝宝头像背景2 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
	end
end

function 场景类_坐骑属性栏:显示(dt,x,y)
	-- 变量
	if not self.可视 then return end
	if tp.坐骑列表==nil then
		tp.坐骑列表={}
		self.选中=0
	end
	local bbs = tp.坐骑列表
	local bbsa = #bbs
	local bb,ls,yl
	local rw = tp.队伍[1]
	if self.选中 ~= 0 and bbs[self.选中] ~= nil then
		bb = bbs[self.选中]
		if bb.潜力==nil then
		    bb=nil
		end
		ls = self.临时潜力[self.选中]
		yl = self.预览属性[self.选中]
	else
		self.选中 = 0
	end
	-- 更新
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,bb ~= nil)
	self.资源组[4]:更新(x,y,bb ~= nil)
	for i=5,9 do
	   self.资源组[i]:更新(x,y,bb ~= nil and bb.潜力 > 0,1)
	   if self.资源组[i]:事件判断() then
	   		bb.潜力 = bb.潜力 - 1
	   		ls[bd[i-4]] = ls[bd[i-4]] + 1
	   end
	end
	for i=10,14 do
	   self.资源组[i]:更新(x,y,bb ~= nil and ls[bd[i-9]] ~= nil and ls[bd[i-9]] > 0,1)
	   if self.资源组[i]:事件判断() then
	   		bb.潜力 = bb.潜力 + 1
	   		ls[bd[i-9]] = ls[bd[i-9]] - 1
	   end
	end
	self.资源组[15]:更新(x,y,bb ~= nil and bb.潜力 > 0)
	self.资源组[16]:更新(x,y,false)
	self.资源组[17]:更新(x,y,bb ~= nil)
	self.资源组[18]:更新(x,y,bb ~= nil)
	self.资源组[19]:更新(x,y,false)
	self.资源组[20]:更新(x,y,false)
	self.资源组[21]:更新(x,y,bb ~= nil)
	self.资源组[22]:更新(x,y,bb ~= nil)
	self.资源组[37]:更新(x,y,bb ~= nil)
	self.资源组[38]:更新(x,y,bb ~= nil)
	self.资源组[39]:更新(x,y)
	-- 显示
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[0]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts2:置字间距(3)
	zts2:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"坐骑属性")
	zts2:置字间距(0)
	self.资源组[29]:显示(self.x+12,self.y+29)
	self.资源组[30]:显示(self.x+197,self.y+28)
	zts:置颜色(4294967295)
	ztstt3:显示(self.x+60,self.y+20,"数量："..bbsa.."/7")
	zts:显示(self.x+260,self.y+194,"统御的召唤兽")
	if bb == nil then

	else
		local mx参战等级 =引擎.取头像("泡泡")
		if mx参战等级 ~= nil and mx参战等级.参战等级 ~= nil then
			bb.参战等级 = mx参战等级.参战等级
		end
	end
	--字体名称
	for i=0,4 do
		self.资源组[32]:显示(self.x+54,self.y+246+i*24+24)
		zts:显示(self.x+20,self.y+247+i*24+24,bd[i+1])--bd0[i+1]
	end
	self.资源组[31]:显示(self.x+197+50,self.y+243+24)
	zts:显示(self.x+163+40,self.y+247+24,"成  长")
	self.资源组[31]:显示(self.x+197+50,self.y+243+24+24)
	zts:显示(self.x+163+40,self.y+247+24+24,"环境度")

	self.资源组[33]:显示(self.x+197+50,self.y+243+2*24+24)
	zts:显示(self.x+163+40,self.y+247+2*24+24,"好感度")
	self.资源组[33]:显示(self.x+197+50,self.y+243+3*24+24)
	zts:显示(self.x+163+40,self.y+247+3*24+24,"饱食度")

	self.资源组[33]:显示(self.x+54,self.y+246+5*24+24)--潜力
	zts:显示(self.x+20,self.y+246-48+24,"名称")
	self.资源组[32]:显示(self.x+54,self.y+246-48+24)
	zts:显示(self.x+20,self.y+246-24+24,"等级")
	self.资源组[32]:显示(self.x+54,self.y+246-24+24)
	ztstt3:置颜色(-1404907)
	ztstt3:显示(self.x+20,self.y+367+24,"潜能")
	self.资源组[32]:显示(self.x+197+70,self.y+243+98+24)
	ztstt3:显示(self.x+163+40,self.y+247+98+24,"获得经验")
	self.资源组[32]:显示(self.x+197+70,self.y+243+98+24+24)
	ztstt3:显示(self.x+163+40,self.y+247+98+24+24,"升级经验")
	ztstt3:置颜色(4294967295)
	self.资源组[2]:显示(self.x+349,self.y+2)
	self.资源组[3]:显示(self.x+10,self.y+183)--观看
	self.资源组[4]:显示(self.x+155,self.y+198+24)
	--属性加减开始
	for i=5,9 do
		self.资源组[i]:显示(self.x+153,self.y+243+((i-5)*25+24))
	end
	for i=10,14 do
		self.资源组[i]:显示(self.x+173,self.y+243+((i-10)*25+24))
	end
	self.资源组[15]:显示(self.x+78,self.y+420,true)--推荐加点
	self.资源组[16]:显示(self.x+153,self.y+422,true)--预览
	self.资源组[17]:显示(self.x+220,self.y+420,true)
	self.资源组[18]:显示(self.x+20,self.y+420,true)
	self.资源组[19]:显示(self.x+70,self.y+183,true)--观看
	self.资源组[20]:显示(self.x+130,self.y+183,true)--祥瑞
	self.资源组[21]:显示(self.x+123,self.y+246+5*24+24,true)--确认加点
	self.资源组[22]:显示(self.x+270,self.y+418,true)
	self.资源组[37]:显示(self.x+315,self.y+243+48+24,true)--修炼
	self.资源组[38]:显示(self.x+315,self.y+243+48+24+24,true)--喂养
	self.资源组[39]:显示(self.x+200,self.y+246-38)
	tp.画线:置区域(0,0,15,159-40)--滑块虚线
	tp.画线:显示(self.x+171,self.y+34)
	if bbsa > 3 then
		self.资源组[35]:置高度(min(floor(93/(bbsa-3)),104))
		self.加入 = min(ceil((bbsa-3)*self.资源组[35]:取百分比()),bbsa-3)
	end
	self.资源组[27]:更新(x,y,self.加入 > 0)
	self.资源组[28]:更新(x,y,self.加入 < bbsa - 3)
	self.资源组[27]:显示(self.x+167,self.y+31)
	self.资源组[28]:显示(self.x+167,self.y+193-40)
	if bbsa > 3 then
		self.资源组[35]:显示(self.x+168,self.y+50+15,x,y,self.鼠标)
	end
	-- 真
	zts:置颜色(-16777216)
	for i=1,3 do
		if bbs[i+self.加入] ~= nil then
			local jx = self.x+18
			local jy = self.y+(i*43)-6
			bw:置坐标(jx,jy+1)
			if self.头像组[i+self.加入] == nil then
				local n = tx(bbs[i+self.加入].模型)
				self.头像组[i+self.加入] = tp.资源:载入(n[7],"网易WDF动画",n[1])
			end
			-- 拽拖
			local xz = bw:检查点(x,y)
			if not self.资源组[35].接触 and xz and self.鼠标 and not tp.消息栏焦点 and self.拽拖对象 == 0 then
				if mousea(0) then
					self.拽拖计次 = self.拽拖计次 + 1
					if self.拽拖计次 >= 28 then
						self.拽拖对象 = i+self.加入
						self.拽拖事件 = {self.头像组[i+self.加入]}
						self.拽拖计次 = 0
					end
				end
			end
			-- 其他
			if self.选中 ~= i+self.加入 then
				if not self.资源组[35].接触 and xz and not tp.消息栏焦点 and self.鼠标 then
					if self.拽拖对象 ~= 0 then
						box(jx+70,jy+34,jx+125,jy+39,-16777216)
						self.插入选区 = i+self.加入
					end
					if mouseb(0) and self.拽拖对象 == 0 then
						self.选中 = i+self.加入
						self.名称输入框:置文本(bbs[self.选中].名称)
						self.名称输入框:置可视(true,true)
						if tp.窗口.坐骑资质栏.可视 then
							tp.窗口.坐骑资质栏:打开(bbs[self.选中])
						end
						if tp.窗口.坐骑技能栏.可视 then
							tp.窗口.坐骑技能栏:打开(bbs[self.选中],self.选中)
						end
						self:置形象()
						self.拽拖计次 = 0
						if bbs[self.选中].统御召唤兽~=nil  then
						    if bbs[self.选中].统御召唤兽[1]~=nil and  tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[1]] ~= nil then
								local n = tx(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[1]].模型)
								self.宝宝头像背景 = tp._按钮(tp.资源:载入(n[7],"网易WDF动画",n[1]),0,0,1,true,true)
						    else
								self.宝宝头像背景 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
						    end
						    if bbs[self.选中].统御召唤兽[2]~=nil  and  tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[2]] ~= nil  then
								local nn = tx(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[2]].模型)
								self.宝宝头像背景2 = tp._按钮(tp.资源:载入(nn[7],"网易WDF动画",nn[1]),0,0,1,true,true)
						    else
								self.宝宝头像背景2 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
						    end
						else
							self.宝宝头像背景 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
							self.宝宝头像背景2 = tp._按钮(tp.资源:载入("登陆资源.wdf","网易WDF动画",0xCEC838D7),0,0,1,true,true)
						end
					end
					self.焦点 = true
				end
			else
				if not self.资源组[35].接触 and xz and not tp.消息栏焦点 and self.鼠标 then
					self.焦点 = true
				end
				if self.拽拖对象 ~= i+self.加入 then
					box(jx-1,jy-3,jx+142,jy+41,-10790181)
				end
			end
			self.资源组[23]:显示(jx+1,jy)
			self.头像组[i+self.加入]:显示(jx+4,jy+4)
			if bbs[i+self.加入].参战信息 ~= nil then
				zts:置颜色(-256)
			else
				zts:置颜色(-16777216)
			end
			zts:显示(jx+41,jy+3,bbs[i+self.加入].名称)
			if bbs[i+self.加入].参战等级==nil then
			    zts:显示(jx+41,jy+21,"乘骑等级：--")
			else
				zts:显示(jx+41,jy+21,"乘骑等级："..bbs[i+self.加入].参战等级)
			end

		end
	end
	self.物品[1]:置坐标(self.x+203,self.y+246-38)
	self.物品[1]:显示(dt,x,y,self.鼠标)
	if bb ~= nil and self.物品[1].物品 ~= nil and self.物品[1].焦点 then
		tp.提示:道具行囊(x,y,self.物品[1].物品)
	end
	tp.宠物头像背景_:显示(self.x+203+60,self.y+246-24)
	tp.宠物头像背景_:显示(self.x+203+105,self.y+246-24)
	self.宝宝头像背景:更新(x,y)
	self.宝宝头像背景2:更新(x,y)
	self.宝宝头像背景:显示(self.x+203+63,self.y+246-21,true)
	self.宝宝头像背景2:显示(self.x+203+108,self.y+246-21,true)
	if bb ~= nil then
		local jx = self.x + 280
		local jy = self.y + 145--+25
		tp.影子:显示(jx,jy)
		if self.资源组[24] ~= nil then
			self.资源组[24]:更新(dt)
			self.资源组[24]:显示(jx,jy)
		end
		if self.选中~=0 and tp.坐骑列表 ~= nil and tp.队伍[1].坐骑~=nil  and tp.队伍[1].坐骑.认证码==tp.坐骑列表[self.选中].认证码 then
			self.资源组[3]:置文字("下骑 ")
		else
			self.资源组[3]:置文字("骑乘 ")
		end
		if self.资源组[25] ~= nil then
			self.资源组[25]:更新(dt)
			self.资源组[25]:显示(jx,jy)
		end
		if self.资源组[40] ~= nil then
			self.资源组[40]:更新(dt)
			self.资源组[40]:显示(jx,jy)
		end
		if self.人物坐骑可视 ~= false then
			self.资源组[36]:更新(dt)
			self.资源组[36]:显示(jx,jy)
		end
		-- 文字
		self.名称输入框:置坐标(self.x+58,self.y+246-48+3+24)
		self.控件类:更新(dt,x,y)
		self.控件类:显示(dt,x,y)
		if self.名称输入框._已碰撞 then
			self.焦点 = true
		end
		tp.坐骑列表[self.选中].种类="坐骑"
		if tp.坐骑列表[self.选中].种类 ~= nil then
            ztstt3:显示(self.x+204,self.y+40,tp.坐骑列表[self.选中].种类)
		end
		zts:置颜色(-16777216)
		zts:显示(self.x + 60,self.y + 247-24+2+24,tp.坐骑列表[self.选中].等级)
		--===============
		zts:显示(self.x+197+57,self.y+243+2.5+24,bb.成长)--成长
		zts:显示(self.x+197+57,self.y+243+24+2.5+24,"100")
		zts:显示(self.x+197+57,self.y+243+2*24+2.5+24,"98")
		zts:显示(self.x+197+57,self.y+243+3*24+2.5+24,bb.忠诚)
		-- ls
		zts:显示(self.x + 60,self.y + 247+2+24,bb.体质)--204
		if ls.体质 > 0 then
			zts:置颜色(-65536)
			zts:显示(self.x + 100 + (#tostring(bb.体质)*7) + 1,self.y + 247+2+24,"+"..ls.体质)--204
			zts:置颜色(-16777216)
		end
		zts:显示(self.x + 60,self.y + 271+2+24,bb.魔力)
		if ls.魔力 > 0 then
			zts:置颜色(-65536)
			zts:显示(self.x + 100 + (#tostring(bb.魔力)*7) + 1,self.y + 271+2+24,"+"..ls.魔力)
			zts:置颜色(-16777216)
		end
		zts:显示(self.x + 60,self.y + 296+2+24,bb.力量)
		if ls.力量 > 0 then
			zts:置颜色(-65536)
			zts:显示(self.x + 100 + (#tostring(bb.力量)*7) + 1,self.y + 296+2+24,"+"..ls.力量)
			zts:置颜色(-16777216)
		end
		zts:显示(self.x + 60,self.y + 320+2+24,bb.耐力)
		if ls.耐力 > 0 then
			zts:置颜色(-65536)
			zts:显示(self.x + 100 + (#tostring(bb.耐力)*7) + 1,self.y + 320+2+24,"+"..ls.耐力)
			zts:置颜色(-16777216)
		end
		zts:显示(self.x + 60,self.y + 344+2+24,bb.敏捷)
		if ls.敏捷 > 0 then
			zts:置颜色(-65536)
			zts:显示(self.x + 100 + (#tostring(bb.敏捷)*7) + 1,self.y + 344+2+24,"+"..ls.敏捷)
			zts:置颜色(-16777216)
		end
		zts:显示(self.x + 197+80-7,self.y + 344+24,bb.当前经验.."("..到整数(取百分比转换(bb.当前经验,1,bb.最大经验)*100).."%)")
		zts:显示(self.x + 197+80,self.y + 344+26+24,bb.最大经验)
		zts:显示(self.x + 60,self.y + 367+2+24,bb.潜力)
	end
	if self.宝宝头像背景:是否选中(x,y) and mouseb(1) then
		tp.禁止关闭 = true
		if self.选中~=0 and bbs[self.选中].统御召唤兽~=nil and bbs[self.选中].统御召唤兽[1]~=nil then
			请求服务(91,{序列=self.选中,编号=1})

		end
	elseif self.宝宝头像背景2:是否选中(x,y) and mouseb(1) then
		tp.禁止关闭 = true
		if self.选中~=0 and bbs[self.选中].统御召唤兽~=nil and bbs[self.选中].统御召唤兽[1]~=nil then
			请求服务(91,{序列=self.选中,编号=2})
		end
	elseif tp.禁止关闭 then
		tp.禁止关闭 = false
	end
	if self.宝宝头像背景:事件判断() then
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		end
		if bbs[self.选中].统御召唤兽~=nil and bbs[self.选中].统御召唤兽[1]~=nil and tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[1]] ~= nil then
			tp.窗口.召唤兽查看栏:打开(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[1]])
		else
			if self.选中 > 0 then
				if #tp.队伍[1].宝宝列表 == 0 then
					tp.常规提示:打开("#Y/你没有可以统御的召唤兽！")
					return
				end
				self.可统御信息 ={}
				self.对话信息 = {}
				for i=1,#tp.队伍[1].宝宝列表 do
					if tp.队伍[1].宝宝列表[i] ~= nil then
						self.可统御信息[i]={名称=tp.队伍[1].宝宝列表[i].名称,编号=i}
						table.insert(self.对话信息,tp.队伍[1].宝宝列表[i].名称)
					end
				end
				table.insert(self.对话信息,"算了算了")
				tp.窗口.对话栏:文本("天兵","统御召唤兽","请选择你要统御的召唤兽。",self.对话信息)
				-- tp.常规提示:打开("#Y/改名成功！")
			else
				tp.常规提示:打开("#Y/请选中一个坐骑！")
			end
		end
	elseif self.宝宝头像背景2:事件判断() then
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		end
		if bbs[self.选中].统御召唤兽~=nil and bbs[self.选中].统御召唤兽[2]~=nil and tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[2]] ~= nil then
			tp.窗口.召唤兽查看栏:打开(tp.队伍[1].宝宝列表[bbs[self.选中].统御召唤兽[2]])
		else
			if self.选中 > 0 then
				if #tp.队伍[1].宝宝列表 == 0 then
					tp.常规提示:打开("#Y/你没有可以统御的召唤兽！")
					return
				end
				self.可统御信息 ={}
				self.对话信息 = {}
				for i=1,#tp.队伍[1].宝宝列表 do
					if tp.队伍[1].宝宝列表[i] ~= nil then
						self.可统御信息[i]={名称=tp.队伍[1].宝宝列表[i].名称,编号=i}
						table.insert(self.对话信息,tp.队伍[1].宝宝列表[i].名称)
					end
				end
				table.insert(self.对话信息,"算了算了")
				tp.窗口.对话栏:文本("天兵","统御召唤兽","请选择你要统御的召唤兽。",self.对话信息)
				-- tp.常规提示:打开("#Y/改名成功！")
			else
				tp.常规提示:打开("#Y/请选中一个坐骑！")
			end
		end
	elseif self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组[3]:事件判断() then
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		end
		if self.资源组[3]:取文字()=="骑乘 " then
			请求服务(26,{序列=self.选中})
			--tp.场景.地图:飞行坐骑(true)
		elseif self.资源组[3]:取文字()=="下骑 " then
		    请求服务(27,{序列=0})
--		    tp.场景.地图:飞行坐骑(false)
		end
    elseif self.资源组[20]:事件判断() then
            if self.选中 == 0 then
				tp.常规提示:打开("#Y/请选中一个坐骑！")
				return
			end
			if tp.坐骑列表[self.选中]~=nil and tp.坐骑列表[self.选中].祥瑞 then
				请求服务(116)
			else
			    tp.常规提示:打开("#Y/该坐骑无法设置飞行！")
			end

	elseif self.资源组[4]:事件判断() then
		if self.名称输入框:取文本() == "" then
			tp.常规提示:打开("#Y/请输入需要修改的名字！")
		elseif self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		else
			tp.常规提示:打开("#Y/改名成功！")
			bb.名称 = self.名称输入框:取文本()
			请求服务(89,{序列=self.选中,名称=self.名称输入框:取文本()})
		end
	elseif self.资源组[17]:事件判断() then --坐骑驯养
		if self.选中 == 0 or not self.选中 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		else
			tp.窗口.对话栏:文本("天兵","坐骑驯养","请选择您要进行的操作,单次驯养消耗10W经验、10W银子",{"驯养一次","驯养十次","驯养五十次","算了算了"})

		end

	elseif self.资源组[37]:事件判断() then --坐骑喂养
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		else
			--tp.窗口.对话栏:文本("天兵","坐骑喂养","您确认要喂养该坐骑么,喂养坐骑可以随机提高坐骑饱食度,单次喂养消耗1000银子",{"坐骑喂养","算了算了"})
			请求服务(97,{编号=self.选中})
		end
	elseif self.资源组[38]:事件判断() then --坐骑洗点
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		else
			tp.窗口.对话栏:文本("天兵","坐骑洗点","您确认要为该坐骑进行洗点操作么,每次洗点将会扣除10W银子",{"坐骑洗点","算了算了"})
		end
	elseif self.资源组[15]:事件判断() then
		-- 力耐加点
		-- local zt = 1
		-- while true do
		-- 	if rw.门派 == "大唐官府" or rw.门派 == "狮驼岭" or rw.门派 == "五庄观" or rw.门派 == "凌波城" or rw.门派 == "天宫" then
		-- 	    if zt == 1 then
		-- 			ls.力量  = ls.力量 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 2
		-- 		elseif zt == 2 then
		-- 			ls.力量  = ls.力量 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 3
		-- 		elseif zt == 3 then
		-- 			ls.力量  = ls.力量 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 4
		-- 		elseif zt == 4 then
		-- 			ls.力量  = ls.力量 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 5
		-- 		elseif zt == 5 then
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			ls.体质  = ls.体质  + 1
		-- 			zt = 1
		-- 		end
		-- 	elseif rw.门派 == "方寸山" or rw.门派 == "盘丝洞" then
		-- 		if zt == 1 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 2
		-- 		elseif zt == 2 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 3
		-- 		elseif zt == 3 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 4
		-- 		elseif zt == 4 then
		-- 			ls.耐力  = ls.耐力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 5
		-- 		elseif zt == 5 then
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			ls.体质  = ls.体质  + 1
		-- 			zt = 1
		-- 		end
		-- 	elseif rw.门派 == "女儿村" then
		-- 		if zt == 1 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 2
		-- 		elseif zt == 2 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 3
		-- 		elseif zt == 3 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 4
		-- 		elseif zt == 4 then
		-- 			ls.敏捷  = ls.敏捷 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 5
		-- 		elseif zt == 5 then
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			ls.体质  = ls.体质  + 1
		-- 			zt = 1
		-- 		end
		-- 	elseif rw.门派 == "龙宫" or rw.门派 == "神木林" or rw.门派 == "魔王寨" then
		-- 		if zt == 1 then
		-- 			ls.魔力  = ls.魔力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 2
		-- 		elseif zt == 2 then
		-- 			ls.魔力  = ls.魔力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 3
		-- 		elseif zt == 3 then
		-- 			ls.魔力  = ls.魔力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 4
		-- 		elseif zt == 4 then
		-- 			ls.魔力  = ls.魔力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 5
		-- 		elseif zt == 5 then
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			ls.体质  = ls.体质  + 1
		-- 			zt = 1
		-- 		end
		-- 	elseif rw.门派 == "普陀山" or rw.门派 == "化生寺" or rw.门派 == "无底洞" or rw.门派 == "阴曹地府" then
		-- 		if zt == 1 then
		-- 			ls.体质  = ls.体质 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 2
		-- 		elseif zt == 2 then
		-- 			ls.体质  = ls.体质 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 3
		-- 		elseif zt == 3 then
		-- 			ls.耐力  = ls.耐力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 4
		-- 		elseif zt == 4 then
		-- 			ls.耐力  = ls.耐力 + 1
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			zt = 5
		-- 		elseif zt == 5 then
		-- 			bb.潜力 = bb.潜力 - 1
		-- 			ls.敏捷  = ls.敏捷  + 1
		-- 			zt = 1
		-- 		end
		-- 	end
		-- 	if bb.潜力 <= 0 then
		-- 		break
		-- 	end
		-- end
	elseif self.资源组[16]:事件判断() then
		if bb~=nil then
		    self.预览属性[self.选中] = self:取差异属性(ls,bb)
		end
	elseif self.资源组[18]:事件判断() then
		if self.选中 == 0 or not self.选中 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		else
			tp.窗口.对话栏:文本("天兵","坐骑放生","您确认要放生该坐骑么,一旦放生无法找回",{"坐骑放生","算了算了"})
		end

	elseif self.资源组[21]:事件判断() then
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		end
		if ls ~= nil then
			请求服务(93,{编号=self.选中,加点=ls})
			self.临时潜力[self.选中] = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
			self.预览属性[self.选中] = {气血=0,魔法=0,伤害=0,速度=0,灵力=0,防御=0}
		end
	elseif self.资源组[22]:事件判断() then
		tp.窗口.坐骑技能栏:打开(bb,self.选中)
		tp.窗口.坐骑技能栏.x = self.x + 370
		tp.窗口.坐骑技能栏.y = self.y
	elseif self.资源组[27]:事件判断() then--上滚动
		self.资源组[35]:置起始点(self.资源组[35]:取百分比转换(self.加入-1,3,bbsa))
		self.头像组 = {}
	elseif self.资源组[28]:事件判断() then--下滚动
		self.资源组[35]:置起始点(self.资源组[35]:取百分比转换(self.加入+1,3,bbsa))
		self.头像组 = {}
	elseif(self.资源组[29]:是否选中(x,y) or self.资源组[27]:是否选中(x,y) or self.资源组[35]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then--鼠标上滚动
		self.资源组[35]:置起始点(self.资源组[35]:取百分比转换(self.加入-1,3,bbsa))
		self.头像组 = {}
	elseif (self.资源组[29]:是否选中(x,y) or self.资源组[28]:是否选中(x,y) or self.资源组[35]:是否选中(x,y)) and 引擎.取鼠标滚轮() ==-1 and self.加入 < bbsa - 3 then--鼠标下滚动
		self.资源组[35]:置起始点(self.资源组[35]:取百分比转换(self.加入+1,3,bbsa))
		self.头像组 = {}
	end
	-- 拖拽事件
	if self.拽拖对象 ~= 0 then
		box(x-70,y-25,x+73,y+19,-849650981)
		self.资源组[23]:显示(x-67,y-22)
		self.拽拖事件[1]:显示(x-63,y-18)
		if bbs[self.拽拖对象].参战信息 ~= nil then
			zts:置颜色(-256)
		end
		zts:显示(x-27,y-19,bbs[self.拽拖对象].名称)
		zts:显示(x-27,y,bbs[self.拽拖对象].等级.."级")
		if mouseb(0) then
			if self.鼠标 then
				if self.插入选区 == 0 then
					self.拽拖计次 = 0
					self.拽拖对象 = 0
					self.拽拖事件 = 0
					self.插入选区 = 0
					tp.禁止关闭 = false
				else
					self:排列(self.拽拖对象,self.插入选区)
					self.拽拖计次 = 0
					self.拽拖对象 = 0
					self.拽拖事件 = 0
					self.插入选区 = 0
					tp.禁止关闭 = false
				end
			else
				self.拽拖计次 = 0
				self.拽拖对象 = 0
				self.拽拖事件 = 0
				self.插入选区 = 0
				tp.禁止关闭 = false
			end
		end
		tp.禁止关闭 = true
		self.焦点 = true
	end
	if self.资源组[35].接触 then
		self.焦点 = true
	end
end

function 场景类_坐骑属性栏:取差异属性(sxb,坐骑)
	local sx1 = 坐骑.最大气血
	local sx2 = 坐骑.最大魔法
	local sx3 = 坐骑.伤害
	local sx4 = 坐骑.防御
	local sx5 = 坐骑.速度
	local sx6 = 坐骑.灵力
	if 坐骑.装备属性==nil then
	    坐骑.装备属性={气血=0,魔法=0,命中=0,伤害=0,防御=0,速度=0,躲避=0,灵力=0,体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
	end
	local 体质 = 坐骑.体质 + 坐骑.装备属性.体质 + sxb.体质
	local 魔力 = 坐骑.魔力 + 坐骑.装备属性.魔力 + sxb.魔力
	local 力量 = 坐骑.力量 + 坐骑.装备属性.力量 + sxb.力量
	local 耐力 = 坐骑.耐力 + 坐骑.装备属性.耐力 + sxb.耐力
	local 敏捷 = 坐骑.敏捷 + 坐骑.装备属性.敏捷 + sxb.敏捷
	local 最大气血 = ceil(坐骑.等级*坐骑.体力资质/1000+体质*坐骑.成长*6) + 坐骑.装备属性.气血
	local 最大魔法 = ceil(坐骑.等级*坐骑.法力资质/500+魔力*坐骑.成长*3) + 坐骑.装备属性.魔法
	local 伤害1 = ceil(坐骑.等级*坐骑.攻击资质*(坐骑.成长+1.4)/750+力量*坐骑.成长) + 坐骑.装备属性.伤害
	local 防御1 = ceil(坐骑.等级*坐骑.防御资质*(坐骑.成长+1.4)/1143+耐力*(坐骑.成长-1/253)*253/190)+ 坐骑.装备属性.防御
	local 速度1 = ceil(坐骑.速度资质 * 敏捷/1000)  + 坐骑.装备属性.速度
	local 灵力1 = ceil(坐骑.等级*(坐骑.法力资质+1666)/3333+魔力*0.7+力量*0.4+体质*0.3+耐力*0.2) + 坐骑.装备属性.灵力
	return {气血=最大气血-sx1,魔法=最大魔法-sx2,伤害=伤害1-sx3,防御=防御1-sx4,速度=速度1-sx5,灵力=灵力1-sx6}
end

function 场景类_坐骑属性栏:排列(a,b)
	local bbx = tp.坐骑列表
	local abs = bbx[a]
	local bbs = bbx[b]
	local aba = self.临时潜力[a]
	local bba = self.临时潜力[b]
	local abc = self.预览属性[a]
	local bbc = self.预览属性[b]
	bbx[a] = bbs
	self.临时潜力[a] = bba
	self.预览属性[a] = bbc
	bbx[b] = abs
	self.临时潜力[b] = aba
	self.预览属性[b] = abc
	if self.选中 ~= 0 then
		self.选中 = b
		self:置形象()
		self.名称输入框:置文本(bbx[self.选中].名称)
		self.名称输入框:置可视(true,true)
		if tp.窗口.坐骑资质栏.可视 then
			tp.窗口.坐骑资质栏:打开(bbx[self.选中])
		end
		if tp.窗口.坐骑技能栏.可视 then
			tp.窗口.坐骑技能栏:打开(bbx[self.选中],self.选中)
		end
	end
	self.头像组 = {}
end

function 场景类_坐骑属性栏:放生()
	self.临时潜力[self.选中] = {体质=0,魔力=0,力量=0,耐力=0,敏捷=0}
	self.预览属性[self.选中] = {气血=0,魔法=0,伤害=0,速度=0,灵力=0,防御=0}
	if tp.坐骑列表[self.选中] == tp.队伍[1].参战宝宝 then
		tp.队伍[1].参战宝宝 = nil
	end
	if tp.窗口.道具行囊.可视 and tp.窗口.道具行囊.窗口 == "坐骑" then
		if tp.坐骑列表[self.选中] == tp.坐骑列表[tp.窗口.道具行囊.选中坐骑] then
			tp.窗口.道具行囊.选中坐骑 = 0
			tp.窗口.道具行囊.资源组[4] = nil
			for s=1,3 do
				tp.窗口.道具行囊.坐骑装备[s]:置物品(nil)
			end
		end
	end
	self.名称输入框:置可视(false,false)
	table.remove(tp.坐骑列表, self.选中)
	self.选中 = 0
	self.加入 = min(self.加入 - 1,0)
end

function 场景类_坐骑属性栏:刷新(f)
	if tp.窗口.坐骑资质栏.可视 then
		tp.窗口.坐骑资质栏:打开()
	end
	if tp.窗口.坐骑技能栏.可视 then
		tp.窗口.坐骑技能栏:打开()
	end
	self.加入 = 0
	self.选中 = 0
	self.拽拖计次 = 0
	self.拽拖对象 = 0
	self.拽拖事件 = 0
	self.插入选区 = 0
	self.头像组 = {}
	self.名称输入框:置可视(false,false)
end

function 场景类_坐骑属性栏:检查点(x,y)
	if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_坐骑属性栏:初始移动(x,y)
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

function 场景类_坐骑属性栏:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_坐骑属性栏
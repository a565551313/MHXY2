local bw = require("gge包围盒")(0,0,100,22)
local bw1= require("gge包围盒")(0,0,100,17)
local box = 引擎.画矩形
local floor = math.floor
local tp
local format = string.format
local mousea = 引擎.鼠标弹起
local qzdmx = 引擎.取战斗模型
local xys = 生成XY
local insert = table.insert
local type = type
local min = math.min
local qjq = 取金钱颜色
local zqj = 引擎.坐骑库
local 多角色道具行囊 = class()


function 多角色道具行囊:初始化(根)
	self.ID = 122
	self.x = 150
	self.y = 110
	self.xx = 0
	self.yy = 0
	self.注释 = "多角色道具行囊"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口 = "主人公"
	self.召唤兽 = 0
	tp = 根
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,535,330,3,9),
		[2] = 自适应.创建(2,1,110,110,3,9),
		[3] =自适应.创建(2,1,110,180,3,9),
		[5] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[6] = 按钮.创建(自适应.创建(10,4,55,22,1,3),0,0,4,true,true,"人物"),
		[7] = 按钮.创建(自适应.创建(10,4,55,22,1,3),0,0,4,true,true,"召唤兽"),
		[8] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"提取"),
		[9] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true),
		[10] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true),
		[11] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"道具"),--道具
		[12] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"行囊"),--行囊
		[13] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x18C30C41),0,0,4,true,true),
		[14] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x5F339316),0,0,4,true,true),
		[15] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0AA7176D),0,0,4,true,true),
		[16] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x8773AFEA),0,0,4,true,true),
		[17] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x612D9651),0,0,4,true,true),
		[18] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x27031D21),0,0,4,true,true),

		[30] = 按钮.创建(自适应.创建(10,4,55,22,1,3),0,0,4,true,true,"坐骑"),
		[31] = 按钮.创建(自适应.创建(10,4,55,22,1,3),0,0,4,true,true,"子女"),
		[34] = 自适应.创建(2,1,120,180,3,9),

		[35] = 自适应.创建(3,1,85,18,1,3),-------没用
		[36] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"查看"),
		[37] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"抛弃"),
		[38] = 按钮.创建(自适应.创建(10,4,24,22,1,3),0,0,4,true,true,"1"),
		[39] = 按钮.创建(自适应.创建(10,4,24,22,1,3),0,0,4,true,true,"2"),
		[40] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"锦衣"),
		[41] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"灵饰"),
		[42] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"骑乘"),
		[43] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"查看"),
		[44] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x00D13BBF),0,0,4,true,true,"法宝"),
		--[45] = 资源:载入('登陆资源.wdf',"网易WDF动画",0X419DCF2A),
		[45] = 自适应.创建(3,1,175,18,1,3),
		[46] = 资源:载入('登陆资源.wdf',"网易WDF动画",0X300C54D8),
		[47] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xCF39217A),
		[48] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xFE7DE843),
		[49] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC0520208),
		[50] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"使用"),
        [51] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"修炼"),
        [52] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808),
        [53] = 按钮.创建(自适应.创建(10,4,24,22,1,3),0,0,4,true,true,"3"),
        [54] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"整理"),
        [55] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"仓库"),
        [56] = 按钮.创建(自适应.创建(10,4,37,22,1,3),0,0,4,true,true,"助战"),
        [57] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"回收"),
        [58] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x49D09C8B),0,0,4,true,true),
        [59] = 自适应.创建(1,1,531,18,1,3,nil,18),
        [60] = 自适应.创建(3,1,200,18,1,3),
        [61] = 自适应.创建(2,1,105,230,3,9),
        [62] =  资源:载入('登陆资源.wdf',"网易WDF动画",0x3906F9F1),
        [63] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x22D22D6D),


	}
	for n=5,33 do
		if self.资源组[n] ~= nil and n ~= 19 then
			self.资源组[n]:绑定窗口_(122)
		end
	end
	for n=36,42 do
		self.资源组[n]:绑定窗口_(122)
	end
	self.资源组[53]:绑定窗口_(122)
	self.资源组[54]:绑定窗口_(122)
	self.资源组[55]:绑定窗口_(122)
	self.资源组[56]:绑定窗口_(122)
	self.资源组[57]:绑定窗口_(122)
	for n=50,51 do
		self.资源组[n]:绑定窗口_(122)
	end
	self.页面=0
	self.背包按钮={}
	self.资源组[55]:绑定窗口_(122)

	for n=9,13 do
		--self.背包按钮[n] =按钮.创建(自适应.创建(12,4,30,22,1,3),0,0,4,true,true,n-8)
		self.背包按钮[n]= 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x72116F63),0,0,2,true,true)
		self.背包按钮[n]:绑定窗口_(122)
	end
	--self.背包按钮[14] = 按钮.创建(自适应.创建(12,4,33,22,1,3),0,0,4,true,true,"清")

	self.背包按钮[14] = 按钮.创建(tp.资源:载入('登陆资源.wdf',"网易WDF动画",0x72116F63),0,0,2,true,true)
	self.背包按钮[14]:绑定窗口_(122)



   self.灵饰底图 = {
        [1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x841CBD61),
		[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x9912E8B9),
		[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x5795605E),
		[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xEBD8985D),
      }

      self.锦衣底图 ={
            [1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE3347D1C),
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC0520208),
			[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF55CDE6D),
			[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xCF39217A),
  }

  self.召唤兽底图 ={
            [1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x40C73F26),
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xD09D407F),
			[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE3347D1C),
		}

self.坐骑底图 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x3E1CFEA7)
self.装备底图 ={
            [1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAB3BFB4B),
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x8F00251E),
			[3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xD7321A7B),
			[4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x219FF008),
			[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF611EC24),
			[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF55CDE6D),
		}

	self.法宝按钮=按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"法宝")
	self.法宝按钮:绑定窗口_(122)
	self.资源组[7]:置偏移(-1,0)

	local 格子 = tp._物品格子
	local 底图 = tp.资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
	self.人物装备 = {}
	self.人物装备2 = {}
	self.人物装备3 = {}
	for i=1,6 do
		self.人物装备[i] = 格子(0,0,i,"多角色道具行囊_人物装备",底图)
		self.人物装备2[i] = 格子(0,0,i,"多角色道具行囊_人物装备",底图)
		self.人物装备3[i] = 格子(0,0,i,"多角色道具行囊_人物装备",底图)
		self.人物装备[i]:置物品(nil)
		self.人物装备2[i]:置物品(nil)
		self.人物装备3[i]:置物品(nil)
	end
	self.召唤兽装备 = {}
	for i=1,3 do
		self.召唤兽装备[i] = 格子(0,0,i,"多角色道具行囊_召唤兽装备",底图)
		self.召唤兽装备[i]:置物品(nil)
	end

	self.穿戴饰品={}
	self.穿戴饰品[1]=格子(0,0,1,"多角色道具行囊_召唤兽装备",底图)
	self.穿戴饰品[1]:置物品(nil)

	self.物品 = {}
	for i=1,100 do
		self.物品[i] = 格子.创建(0,0,i,"多角色道具行囊_物品")
		self.物品[i]:置物品(nil)
	end

    self.法宝佩戴={}
    for i=1,3 do
		self.法宝佩戴[i] = 格子.创建(0,0,i,"多角色道具行囊_法宝")
		self.法宝佩戴[i]:置物品(nil)
	end

	self.灵饰佩戴 = {}
	for i=1,4 do
		self.灵饰佩戴[i] = 格子(0,0,i,"多角色道具行囊_灵饰",底图)
		self.灵饰佩戴[i]:置物品(nil)
	end
	self.锦衣佩戴 = {}
	for i=1,4 do
		self.锦衣佩戴[i] = 格子(0,0,i,"多角色道具行囊_锦衣",底图)
		self.锦衣佩戴[i]:置物品(nil)
	end
	self.装备坐标 = {x={10,194,10,194,10,194},y={115,115,170,170,224,224},xx={10,70,130},yy={240,240,240}}
	self.人物装备窗口=1
	self.选中召唤兽 = 0
	self.加入 = 0
	self.结束 = 20
	self.窗口时间 = 0
	self.提示文字 = "鼠标:左键抓取物品,右键装备穿戴，SHIFT+右键提取物品"
	self.当前银行 = "现金"
	self.记录_ = 0
	--tp._物品格子(0,0,i,"多角色兼容",底图):置根(tp)
	zts = tp.字体表.普通字体
	zts1 =tp.字体表.描边字体
	self.展示 = 0
	self.玩家id=0
	self.主人公分类= "灵饰"
end

function 多角色道具行囊:打开(玩家id)
	if self.可视 then
		self.可视 = false
		for i=1,6 do
			self.人物装备[i]:置物品(nil)
			self.人物装备2[i]:置物品(nil)
			self.人物装备3[i]:置物品(nil)
		end
		for i=1,3 do
			self.召唤兽装备[i]:置物品(nil)
		end
	   self.穿戴饰品[1]:置物品(nil)
		for i=1,100 do
			self.物品[i]:置物品(nil)
		end
	    for i=1,3 do
			self.法宝佩戴[i]:置物品(nil)
		end
		for i=1,4 do
			self.灵饰佩戴[i]:置物品(nil)
		end
		for i=1,4 do
			self.锦衣佩戴[i]:置物品(nil)
		end
		self.选中召唤兽 =  0
		self.加入 = 0
		self.开始 = 0
		self.结束 = 20
		self.玩家id=0
		self.页面=0
		self.法宝选中=0
		if tp.窗口.灵饰.可视 then
			tp.窗口.灵饰:打开()
		end
		if tp.窗口.锦衣.可视 then
			tp.窗口.锦衣:打开()
		end
		return
	else
		insert(tp.窗口_,self)
		self.选中召唤兽 = 0
		self.加入 = 0
		self.当前银行 = "现金"
		self.窗口 = "主人公"
		self.玩家id=玩家id
		for s=1,3 do
			self.召唤兽装备[s]:置物品(nil)
		end
		local 站立人物=qzdmx(tp.多角色[self.玩家id].模型)
		self.资源组[4] = tp.资源:载入(站立人物[10],"网易WDF动画",站立人物[6])
		for i=1,6 do
			self.人物装备[i]:置物品(nil)
			self.人物装备[i]:置物品(tp.多角色[self.玩家id].装备[i])
		end
		self.开始 = 1
		self.结束 = 100
		for q=self.开始,self.结束 do
			self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
		end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.点击类型="道具"
	    self.选择类型="道具"
	    self.法宝选中=0
	    if tp.窗口.灵饰.可视 then
			tp.窗口.灵饰:打开()
		end
		if tp.窗口.锦衣.可视 then
			tp.窗口.锦衣:打开()
		end
		for i=1,4 do
			self.灵饰佩戴[i]:置物品(nil)
			if self.玩家id~=0 and  tp.多角色[self.玩家id].灵饰 ~= nil  and tp.多角色[self.玩家id].灵饰[i] ~= nil and  tp.多角色[self.玩家id].灵饰[i].名称 ~= nil then
				self.灵饰佩戴[i]:置物品(tp.多角色[self.玩家id].灵饰[i])
			end
		end
		for i=1,4 do
			self.锦衣佩戴[i]:置物品(nil)
			if tp.多角色[self.玩家id] ~= nil and tp.多角色[self.玩家id].锦衣 ~= nil and tp.多角色[self.玩家id].锦衣[i] ~= nil and  tp.多角色[self.玩家id].锦衣[i].名称 ~= nil then
				self.锦衣佩戴[i]:置物品(tp.多角色[self.玩家id].锦衣[i])
			end
		end

	end
end

function 多角色道具行囊:刷新(玩家id)
	self.玩家id=玩家id
	if self.窗口 == "主人公" then
		local 站立人物 = qzdmx(tp.多角色[self.玩家id].模型)
		self.资源组[4] = tp.资源:载入(站立人物[10],"网易WDF动画",站立人物[6])
		for n=1,6 do
			self.人物装备[n]:置物品(nil)
			if self.玩家id~=0 and tp.多角色[self.玩家id]~=nil then
			   self.人物装备[n]:置物品(tp.多角色[self.玩家id].装备[n])
			end
		end
	end
	self:刷新灵饰()
    self:刷新锦衣()
    self:刷新装备()
    self:刷新坐骑饰品()
    self:置形象()
    self:整体资源刷新()
    self:清除抓取道具()



end


function 多角色道具行囊:刷新灵饰()
 	for i=1,4 do
 		self.灵饰佩戴[i]:置物品(nil)
		if self.玩家id~=0 and  tp.多角色[self.玩家id].灵饰 ~= nil  and  tp.多角色[self.玩家id].灵饰[i] ~= nil and  tp.多角色[self.玩家id].灵饰[i].名称 ~= nil then
			self.灵饰佩戴[i]:置物品(tp.多角色[self.玩家id].灵饰[i])
		end
	end
end


function 多角色道具行囊:刷新锦衣()
	for i=1,4 do
		self.锦衣佩戴[i]:置物品(nil)
		if self.玩家id~=0 and  tp.多角色[self.玩家id] ~= nil and tp.多角色[self.玩家id].锦衣 ~= nil and tp.多角色[self.玩家id].锦衣[i] ~= nil and  tp.多角色[self.玩家id].锦衣[i].名称 ~= nil then
			self.锦衣佩戴[i]:置物品(tp.多角色[self.玩家id].锦衣[i])
		end
	end
end


function 多角色道具行囊:刷新装备()
 	for i=1,6 do
 	   self.人物装备[i]:置物品(nil)
 	   if self.玩家id~=0 and tp.多角色[self.玩家id]~=nil then
		   self.人物装备[i]:置物品(tp.多角色[self.玩家id].装备[i])
		end
	end
end

function 多角色道具行囊:刷新坐骑饰品()
	if self.玩家id~=0 and tp.多角色[self.玩家id]~=nil and self.选中召唤兽~=0  and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽]~=nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件~=nil then
	    self.穿戴饰品[1]:置物品(tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件)
	else
		self.穿戴饰品[1]:置物品(nil)
	end
end


function 多角色道具行囊:置形象()
	self.资源组[99] = nil
	self.资源组[98] = nil
	if self.窗口 == "召唤兽" then
		if self.选中召唤兽 ~= 0 and tp.多角色[self.玩家id].宝宝列表 ~= nil and tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽]  ~= nil then
			local n = qzdmx(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].模型)
			self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			if qzdmx(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].模型.."_饰品") ~= nil and #qzdmx(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].模型.."_饰品") ~= 0 then
				if tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].饰品~=nil then
				n = qzdmx(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].模型.."_饰品")
				self.资源组[98] = tp.资源:载入(n[10],"网易WDF动画",n[6])
				self.资源组[98]:置方向(0)
				else
				local n = qzdmx(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].模型)
				self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
				end
				end
			if tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].染色方案 ~= nil then
				self.资源组[4]:置染色(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].染色方案,tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].染色组[1],tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].染色组[2],tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].染色组[3])
				self.资源组[4]:置方向(0)
			end
			for i=1,3 do
				self.召唤兽装备[i]:置物品(tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].装备[i])
			end
		end
	elseif self.窗口 == "子女" then
		if self.选中召唤兽 ~= 0 and tp.多角色[self.玩家id].子女列表 ~= nil and tp.多角色[self.玩家id].子女列表[self.选中召唤兽] ~= nil then
			local n = qzdmx(tp.多角色[self.玩家id].子女列表[self.选中召唤兽].模型)
			self.资源组[4] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			if tp.多角色[self.玩家id].子女列表[self.选中召唤兽].染色方案 ~= nil then
				self.资源组[4]:置染色(tp.多角色[self.玩家id].子女列表[self.选中召唤兽].染色方案,tp.多角色[self.玩家id].子女列表[self.选中召唤兽].染色组[1],tp.多角色[self.玩家id].子女列表[self.选中召唤兽].染色组[2],tp.多角色[self.玩家id].子女列表[self.选中召唤兽].染色组[3])
				self.资源组[4]:置方向(0)
			end
			for i=1,3 do
				self.召唤兽装备[i]:置物品(tp.多角色[self.玩家id].子女列表[self.选中召唤兽].装备[i])
			end
		end
	elseif self.窗口 == "坐骑" then
		if self.选中召唤兽 ~= 0 and tp.多角色[self.玩家id].坐骑列表 ~= nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽]  ~= nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型 ~= nil then
			local n = {}
			if 引擎.新增坐骑(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,"站立") then
				n = {}
				n.人物资源 = "xzzq.wdf"
				n.人物站立 = 引擎.新增坐骑(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,"站立")
				n.人物行走 = 引擎.新增坐骑(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,"奔跑")
				n.坐骑资源 = "xzzq.wdf"
				n.坐骑行走 = 引擎.新增坐骑(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,"奔跑")
				n.坐骑站立 = 引擎.新增坐骑(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,"站立")
			else
				n = zqj(tp.多角色[self.玩家id].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].模型,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品 or "空")
			end
			self.资源组[4] = tp.资源:载入(n.坐骑资源,"网易WDF动画",n.坐骑站立)
			if tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品  ~= nil then
				self.穿戴饰品[1]:置物品(tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件)
				self.资源组[99] = tp.资源:载入(n.坐骑饰品资源,"网易WDF动画",n.坐骑饰品站立)
				-- if tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件~=nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件.染色方案 ~= nil then
				-- 	self.资源组[99]:置染色(tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件.染色方案,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件.染色组[1],tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件.染色组[2],tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件.染色组[3])
				-- end
			end
			-- if tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].染色方案 ~= nil then
			-- 	self.资源组[4]:置染色(tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].染色方案,tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].染色组[1],tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].染色组[2],tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].染色组[3])
			-- end
		end
	end
end

function 多角色道具行囊:刷新道具资源()
   self.开始 = 1
   self.结束 = 100
	for q=self.开始,self.结束 do
	   self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
	end
end

function 多角色道具行囊:更新法宝经验(数据)
 if self.物品[数据.id]~=nil and self.物品[数据.id].物品~=nil then

     self.物品[数据.id].物品.当前经验=数据.当前经验
     self.物品[数据.id].物品.升级经验=数据.升级经验
     self.物品[数据.id].物品.气血=数据.境界
     self.物品[数据.id].物品.魔法=数据.灵气
 	 end

 end

function 多角色道具行囊:整体资源刷新()
 if self.点击类型 == "道具" then
     self:刷新道具资源()
  elseif self.点击类型 == "法宝"  then
       self:刷新法宝资源()
    elseif self.点击类型 == "行囊"  then
       self:刷新行囊资源()
  end
end

function 多角色道具行囊:刷新行囊资源()
      	self.开始 = 1
	    self.结束 = 20
		for q=self.开始,self.结束 do
		  self.物品[q]:置物品(tp.多角色[self.玩家id].行囊列表[q])
		end
end
 function 多角色道具行囊:清除抓取道具()
	if tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
	   self.物品[tp.场景.抓取物品ID].确定 = false
	end
					--print(tp.场景.抓取物品注释,66)
	tp.场景.抓取物品 = nil
	tp.场景.抓取物品ID = nil
	tp.场景.抓取物品注释 = nil
	tp.场景.抓取物品类型 = nil
end

function 多角色道具行囊:刷新法宝资源()
   	self.开始 = 1
   	self.结束 = 20
	for q=self.开始,self.结束 do
	  self.物品[q]:置物品(tp.多角色[self.玩家id].法宝[q])
	end
  	self.法宝选中=0
  	for i=1,3 do
		self.法宝佩戴[i]:置物品(tp.多角色[self.玩家id].法宝佩戴[i])
	end
end

function 多角色道具行囊:显示(dt,x,y)
	右键弹起=false
	self.焦点 = false
	if (self.窗口 == "召唤兽" or self.窗口 == "子女" or self.窗口 == "主人公") and self.资源组[4] ~= nil then
		self.资源组[4]:更新(dt)
	end

	self.资源组[5]:更新(x,y)
	self.资源组[8]:更新(x,y,self.窗口 == "主人公")
	self.资源组[9]:更新(x,y,self.加入 > 0)
	self.资源组[10]:更新(x,y,(self.窗口 == "召唤兽" and self.加入 <  #tp.多角色[self.玩家id].宝宝列表 - 4) or (self.窗口 == "子女" and self.加入 <  #tp.多角色[self.玩家id].子女列表 - 4) or (self.窗口 == "坐骑" and self.加入 <  #tp.多角色[self.玩家id].坐骑列表 - 4))
	self.资源组[11]:更新(x,y, not (self.点击类型=="道具"),2)
	self.资源组[12]:更新(x,y, not (self.点击类型=="行囊"),2)
	self.法宝按钮:更新(x,y, not (self.点击类型=="法宝"),2)
	self.资源组[54]:更新(x,y)
	self.资源组[55]:更新(x,y)
	self.资源组[50]:更新(x,y, not(self.法宝选中==0),2)
    self.资源组[51]:更新(x,y, not( self.法宝选中==0),2)
    self.资源组[57]:更新(x,y)
    self.资源组[63]:更新(dt)
	local 字体 = tp.字体表.普通字体
	zts1:置描边颜色(-16240640)
	if self.鼠标 then
		if self.资源组[5]:事件判断() then
			self:打开()
			return false
		elseif self.资源组[8]:事件判断() then

			-- if self.当前银行 == "现金" then
			-- 	self.当前银行 = "储备"
			-- elseif self.当前银行 == "储备" then
			-- 	self.当前银行 = "现金"
			-- end
        if  tp.多角色[self.玩家id].银子>=1 then
		   local 事件 = function()
			 请求服务(63,{参数=self.玩家id,文本="提取银子"})
		   end
		   tp.窗口.文本栏:载入("你确定要把该角色的银两全部提取出来么?",nil,true,事件)
		 else
		     tp.常规提示:打开("#Y/该角色已经没有银子了")
		 end

		elseif self.资源组[9]:事件判断() then
			self.加入 = self.加入 - 1
		elseif self.资源组[10]:事件判断() then
			self.加入 = self.加入 + 1
		elseif self.资源组[11]:事件判断() then
			if tp.场景.抓取物品ID==nil then
				self.开始 = 1
				self.结束 = 20
			    请求服务(63,{参数=self.玩家id,文本="打开背包"})
			  	self.点击类型="道具"
			  	if self.窗口=="法宝" then
	             	self.窗口="主人公"
			  	end
			else
				请求服务(63,{参数=self.玩家id,文本="格子互换1",抓取id=tp.场景.抓取物品ID,放置类型="道具",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[12]:事件判断() then
			if tp.场景.抓取物品ID==nil then
				self.开始 = 21
				self.结束 = 40
			    请求服务(63,{参数=self.玩家id,文本="索要行囊"})
			  	self.点击类型="行囊"
			  	self.页面=0
			  	if self.窗口=="法宝" then
	            	self.窗口="主人公"
			  	end
			else
			    请求服务(63,{参数=self.玩家id,文本="格子互换1",抓取id=tp.场景.抓取物品ID,放置类型="行囊",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[13]:事件判断() then
			self.开始 = 41
			self.结束 = 60
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
		elseif self.资源组[14]:事件判断() then
			self.开始 = 61
			self.结束 = 80
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
		elseif self.资源组[15]:事件判断() then
			self.开始 = 81
			self.结束 = 100
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
		elseif self.资源组[16]:事件判断() then
			self.开始 = 101
			self.结束 = 120
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
		elseif self.资源组[17]:事件判断() then
			self.开始 = 121
			self.结束 = 140
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
		elseif self.资源组[18]:事件判断() then
			self.开始 = 141
			self.结束 = 160
			for q=self.开始,self.结束 do
				self.物品[q]:置物品(tp.多角色[self.玩家id].道具列表[q])
			end
     	elseif self.资源组[50]:事件判断() then
	  	 	if self.法宝选中==0 then
             	tp.常规提示:打开("#Y/请先选中要使用的法宝")
         	elseif self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil then
		        tp.常规提示:打开("#Y/未开放法宝使用")
		    end
	  	elseif self.资源组[51]:事件判断() then
	  	 	if self.法宝选中==0 then
	            tp.常规提示:打开("#Y/请先选中要修炼的法宝")
	            return
            elseif self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil and self.物品[self.法宝选中].物品.当前经验~=nil then
            	请求服务(63,{参数=self.玩家id,文本="修炼法宝",序列=self.法宝选中})
	      	else
	          	tp.常规提示:打开("#Y/你没有这样的法宝")
	  	 	end

	  	 	------------------------------------------------------------------------------一键出售----------------------------------------
		elseif self.资源组[57]:事件判断() then  --一键出售

			tp.窗口.多角色回收系统:打开(self.玩家id)
        	请求服务(63,{参数=self.玩家id,文本="回收系统",序列="获取信息"})
------------------------------------------------------------------------------一键出售----------------------------------------

      	elseif self.法宝按钮:事件判断() then
      		if tp.场景.抓取物品ID==nil then
	        	if self.窗口=="法宝" then
	             	self.窗口="主人公"
	             	self.点击类型="道具"
	             	请求服务(63,{参数=self.玩家id,文本="打开背包"})
	            else
	             	self.窗口="法宝"
	             	self.点击类型="法宝"
	             	请求服务(63,{参数=self.玩家id,文本="索要法宝"})
	         	end
			else

			    请求服务(63,{参数=self.玩家id,文本="格子互换1",抓取id=tp.场景.抓取物品ID,放置类型="法宝",抓取类型=self.抓取类型})
			    if tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
					self.物品[tp.场景.抓取物品ID].确定 = false
				end
				tp.场景.抓取物品 = nil
				tp.场景.抓取物品ID = nil
				tp.场景.抓取物品注释 = nil
			end
		elseif self.资源组[38]:事件判断() then
			self.人物装备窗口=1
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[39]:事件判断() then
			self.人物装备窗口=2
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[53]:事件判断() then
			self.人物装备窗口=3
			if tp.窗口.锦衣.可视 then
				tp.窗口.锦衣.可视 = false
			end
			if tp.窗口.灵饰.可视 then
				tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[55]:事件判断() then---仓库
            请求服务(63,{参数=self.玩家id,文本="打开仓库",类型=self.点击类型})
		elseif self.资源组[54]:事件判断() then
			请求服务(63,{参数=self.玩家id,文本="整理背包",类型=self.点击类型})
		end
	end
	self.资源组[1]:显示(self.x,self.y)
	tp.物品界面背景_:显示(self.x+256,self.y+50)
	self.资源组[59]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts:置颜色(白色)
	zts:置字间距(3)
	zts:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"角色道具")
	zts:置字间距(0)
	if self.点击类型~="道具" then
		tp.竖排花纹背景_:置区域(0,0,13,210)
		tp.竖排花纹背景_:显示(self.x+514,self.y+50)
	end



	self.资源组[11]:显示(self.x + 255,self.y + 25,true,nil,nil,self.点击类型=="道具",2)
	self.资源组[12]:显示(self.x + 300,self.y + 25,true,nil,nil,self.点击类型=="行囊",2)
	self.法宝按钮:显示(self.x + 345,self.y + 25,true,nil,nil,self.点击类型=="法宝",2)
	self.资源组[54]:显示(self.x + 390,self.y + 25)
	self.资源组[55]:显示(self.x + 435,self.y + 25)
	self.资源组[57]:显示(self.x + 480,self.y + 25)
	if self.窗口 == "法宝" then
		tp.竖排花纹背景_:置区域(0,0,13,100)
	    tp.竖排花纹背景_:显示(self.x+10,self.y+33)
	    tp.竖排花纹背景_:显示(self.x+210,self.y+33)
	    tp.竖排花纹背景_:显示(self.x+230,self.y+33)

		 self.资源组[46]:显示(self.x + 30,self.y + 25)

		 self.资源组[47]:显示(self.x + 10,self.y + 145)
		 self.资源组[48]:显示(self.x + 73,self.y + 145)
		 self.资源组[49]:显示(self.x + 136,self.y + 145)

		 self.资源组[50]:显示(self.x + 200,self.y + 146)
	     self.资源组[51]:显示(self.x + 200,self.y + 172)
	      self.资源组[45]:显示(self.x+70,self.y + 205)
	      self.资源组[45]:显示(self.x+70,self.y + 235)
	      zts1:置颜色(白色)
	      zts1:显示(self.x + 10,self.y + 207,"升级经验")
	      zts1:显示(self.x + 10,self.y + 237,"当前经验")
	      zts1:显示(self.x + 10,self.y + 267,"人物经验:")
		  self.资源组[62]:置区域(0,0,min(floor(tp.多角色[self.玩家id].当前经验 / tp.多角色[self.玩家id].最大经验 * 240),240),self.资源组[62].高度)
		  self.资源组[62]:显示(self.x+10,self.y+293)
		  zts1:显示(self.x + ((240 - zts1:取宽度(tp.多角色[self.玩家id].当前经验.."/"..tp.多角色[self.玩家id].最大经验))/2)+6,self.y + 292,tp.多角色[self.玩家id].当前经验.."/"..tp.多角色[self.玩家id].最大经验)

     	if self.法宝选中~=0 then
          	if self.物品[self.法宝选中]~=nil and self.物品[self.法宝选中].物品~=nil and self.物品[self.法宝选中].物品.当前经验~=nil then
               zts:置颜色(-16777216)
               zts:显示(self.x+75,self.y+207,self.物品[self.法宝选中].物品.升级经验)
               zts:显示(self.x+75,self.y+237,self.物品[self.法宝选中].物品.当前经验)
          	end
     	end
      local 佩戴坐标={{x=self.x+12,y=self.y+145},{x=self.x+75,y=self.y+145},{x=self.x+138,y=self.y+145}}
      for n=1,3 do
          if self.法宝佩戴[n].物品~=nil then
            self.资源组[52]:显示(佩戴坐标[n].x+2.5,佩戴坐标[n].y+3)
             self.法宝佩戴[n]:置坐标(佩戴坐标[n].x,佩戴坐标[n].y)
             self.法宝佩戴[n]:显示(dt,x,y,true)
             if self.法宝佩戴[n].焦点 and not tp.消息栏焦点 then
                  if self.法宝佩戴[n].物品 ~= nil then
					  tp.提示:道具行囊(x,y,self.法宝佩戴[n].物品)
					end

				  if 引擎.鼠标弹起(右键) then
				      请求服务(63,{参数=self.玩家id,文本="卸下法宝",序列=n})
				  end
             	 end

          	 end

      	 end
      	for n=47,49 do
         	if tp.场景.抓取物品ID~=nil and self.资源组[n]:是否选中(x,y) and 引擎.鼠标弹起(左键) then
            	请求服务(63,{参数=self.玩家id,文本="替换法宝",序列=tp.场景.抓取物品ID,序列1=n-46})
             	tp.场景.抓取物品 = nil
		     	tp.场景.抓取物品ID = nil
		     	tp.场景.抓取物品注释 = nil
		     	self.物品[self.法宝选中].确定=false
		     	self.物品[self.法宝选中]:置物品(tp.多角色[self.玩家id].法宝[self.法宝选中])
         	end
      	end
	elseif self.窗口 == "主人公" then
		self.资源组[2]:显示(self.x+73,self.y + 115)
		if self.资源组[4]~=nil then
			self.资源组[4]:显示(self.x + 129,self.y + 205)
		end
		self.资源组[40]:更新(x,y,self.主人公分类~="锦衣")
		self.资源组[41]:更新(x,y,not self.主人公分类~="灵饰")
		self.资源组[53]:更新(x,y)
		self.资源组[38]:更新(x,y)
		self.资源组[39]:更新(x,y)


		if self.资源组[40]:事件判断() then
			self.主人公分类 ="锦衣"
			if tp.窗口.灵饰.可视 then
			    tp.窗口.灵饰.可视 = false
			end
		elseif self.资源组[41]:事件判断() then
			self.主人公分类 ="灵饰"
			if tp.窗口.锦衣.可视 then
			    tp.窗口.锦衣.可视 = false
			end
		end

		self.资源组[40]:显示(self.x + 130,floor(self.y + 258),nil,true,nil,self.主人公分类=="锦衣",2)--锦衣
		self.资源组[41]:显示(self.x + 70,floor(self.y + 258),nil,true,nil,self.主人公分类=="灵饰",2)--灵饰
		self.资源组[38]:显示(self.x + 70,floor(self.y + 233),nil,true,nil,self.人物装备窗口==1,2)--装备1
		self.资源组[39]:显示(self.x + 115,floor(self.y + 233),nil,true,nil,self.人物装备窗口==2,2)--装备2
		self.资源组[53]:显示(self.x + 162,floor(self.y + 233),nil,true,nil,self.人物装备窗口==3,2)--装备3

		for i=1,4 do
			if self.主人公分类  =="灵饰" then
			self.灵饰底图[i]:显示(self.x-52+i*61,self.y+58)
			   if self.灵饰佩戴[i]~= nil then
					self.灵饰佩戴[i]:置坐标(self.x-50+i*61,self.y+58,nil,nil,4,-1)
					self.灵饰佩戴[i]:显示(dt,x,y,self.鼠标,nil,3)
					if self.灵饰佩戴[i].物品 ~= nil and self.灵饰佩戴[i].焦点 then
						tp.提示:道具行囊(x,y,self.灵饰佩戴[i].物品,true)
					end
					if self.灵饰佩戴[i].事件 then
						if tp.场景.抓取物品 ~= nil and self.灵饰佩戴[i].物品 == nil and self.灵饰佩戴[i].焦点 then

						elseif tp.场景.抓取物品 ~= nil and self.灵饰佩戴[i].物品 ~= nil and self.灵饰佩戴[i].焦点 then

						elseif tp.场景.抓取物品 == nil and self.灵饰佩戴[i].物品 ~= nil and self.灵饰佩戴[i].焦点 then
							请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",灵饰=true,道具=i})
						end
					elseif self.灵饰佩戴[i].右键 then
						if  self.灵饰佩戴[i].物品 ~= nil then
						  请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",灵饰=true,道具=i})
						end
					end

	           end


			elseif  self.主人公分类  ~="灵饰" then
				self.锦衣底图[i]:显示(self.x-52+i*61,self.y+58)
				if self.锦衣佩戴[i]~= nil then
						self.锦衣佩戴[i]:置坐标(self.x-50+i*61,self.y+58,nil,nil,4,-1)
						self.锦衣佩戴[i]:显示(dt,x,y,self.鼠标,nil,3)
						if self.锦衣佩戴[i].物品 ~= nil and self.锦衣佩戴[i].焦点 then
							tp.提示:道具行囊(x,y,self.锦衣佩戴[i].物品,true)
						end

						if self.锦衣佩戴[i].事件 then
							if tp.场景.抓取物品 ~= nil and self.锦衣佩戴[i].物品 == nil and self.锦衣佩戴[i].焦点 then

							elseif tp.场景.抓取物品 ~= nil and self.锦衣佩戴[i].物品 ~= nil and self.锦衣佩戴[i].焦点 then

							elseif tp.场景.抓取物品 == nil and self.锦衣佩戴[i].物品 ~= nil and self.锦衣佩戴[i].焦点 then
								请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",锦衣=true,道具=i})
							end
						elseif self.锦衣佩戴[i].右键 then
							if  self.锦衣佩戴[i].物品 ~= nil then
							   请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",锦衣=true,道具=i})
							end
						end


		           end
			    --do
			end



		end

		for i=1,6 do
			local 补差高度=3
			if i==1 or i == 2 then
			    补差高度=1
			elseif i==5 or i == 6 then
			    补差高度=2
			end
			--tp.物品格子背景_:显示(self.x+self.装备坐标.x[i],self.y+self.装备坐标.y[i]-补差高度)
			self.装备底图[i]:显示(self.x+self.装备坐标.x[i],self.y+self.装备坐标.y[i]-补差高度)
			if self.人物装备窗口 == 2 then
				self.人物装备2[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备2[i]:显示(dt,x,y,self.鼠标,nil,2)
			elseif self.人物装备窗口 == 3 then
				self.人物装备3[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备3[i]:显示(dt,x,y,self.鼠标,nil,3)
			else
				self.人物装备[i]:置坐标(self.x+self.装备坐标.x[i]+2,self.y+self.装备坐标.y[i]-补差高度,nil,nil,4,-1)
				self.人物装备[i]:显示(dt,x,y,self.鼠标,nil,1)
			end
			if self.人物装备[i].物品 ~= nil and self.人物装备[i].焦点 then
				tp.提示:道具行囊(x,y,self.人物装备[i].物品)
			end
			if self.人物装备[i].焦点 then
				self.焦点 = true
			end
			if not tp.消息栏焦点 then
			if tp.场景.抓取物品 == nil and self.人物装备[i].物品 ~= nil and self.人物装备[i].焦点   then
				if mousea(1) then
			    	请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",道具=i})
				end
			end
			-- 事件开始
			if self.人物装备[i].事件 then
				if tp.场景.抓取物品 ~= nil  and self.人物装备[i].焦点 then --and self.人物装备[i].物品 == nil
					请求服务(63,{参数=self.玩家id,文本="佩戴装备",类型=self.点击类型,角色="主角",道具=i})
					tp.场景.抓取物品 = nil
				    tp.场景.抓取物品ID = nil
				    tp.场景.抓取物品注释 = nil
				elseif self.人物装备[i].焦点 and tp.场景.抓取物品 == nil and self.人物装备[i].物品 ~= nil then

				    请求服务(63,{参数=self.玩家id,文本="卸下装备",类型=self.点击类型,角色="主角",道具=i})
				end
			end
			-- 事件结束
		end
	end

	elseif self.窗口 == "召唤兽" or self.窗口 == "子女" then

		self.资源组[3]:显示(self.x+135,self.y+55)
		self.资源组[2]:显示(self.x+15,self.y + 55)


	    if self.窗口 == "子女" then


			self.资源组[36]:更新(x,y,tp.多角色[self.玩家id].子女列表[self.选中召唤兽] ~= nil)
			self.资源组[37]:更新(x,y,tp.多角色[self.玩家id].子女列表[self.选中召唤兽] ~= nil)
			self.资源组[36]:显示(self.x+190,self.y+243)
			self.资源组[37]:显示(self.x+190,self.y+268)
			if self.资源组[36]:事件判断() then
				tp.窗口.召唤兽查看栏:打开(tp.多角色[self.玩家id].子女列表[self.选中召唤兽])
			end
			if self.资源组[37]:事件判断() then
			 --  请求服务(102,{序列=1,参数=self.选中召唤兽})
			end
		end
	    --do
		self.资源组[9]:显示(self.x + 227,self.y + 56,true)
		self.资源组[10]:显示(self.x + 227,self.y + 218,true)
		local 列表 = 0
		字体:置颜色(-16777216)
		local dxs = nil
		if self.窗口 == "召唤兽" then
			dxs = tp.多角色[self.玩家id].宝宝列表
		else
			dxs = tp.多角色[self.玩家id].子女列表
		end
		for m=1,7 do
			if dxs[m + self.加入] ~= nil then
				bw:置坐标(self.x + 152,self.y + 38 + m * 23)
				if self.选中召唤兽 ~= m + self.加入 then
					if bw:检查点(x,y) then
						box(self.x + 139,self.y + 38 + m * 22,self.x + 225,self.y + 38 + m * 22 + 22,-3551379)
						if mousea(0) and self.鼠标 then
							self.选中召唤兽 = m + self.加入
							self:置形象()
						if 引擎.按键按住(0x10) and self.展示 == 0 then
						 self.展示 = 1 --- 限制只能展示一个
						 tp.窗口.消息框.超链接=tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽]
						 tp.窗口.消息框.输入:添加文本("［"..tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].名称.."］")
						  return
						 end
						end
						self.焦点 = true
					end
				else
					local ys = -10790181
					if bw:检查点(x,y) then
						ys = -9670988
						self.焦点 = true
					end
					box(self.x + 139,self.y + 38 + m * 22,self.x + 225,self.y + 38 + m * 22 + 22,ys)
				end
				字体:显示(self.x + 142,self.y + 40 + m * 23,dxs[m + self.加入].名称)
			end
		end
		self.资源组[35]:显示(self.x+45,self.y+175)
		self.资源组[35]:显示(self.x+45,self.y+205)
		 zts1:置颜色(白色)
	     zts1:显示(self.x + 15,self.y + 177,"气血")
	     zts1:显示(self.x + 15,self.y + 207,"魔法")

		if self.窗口 == "召唤兽" and dxs[self.选中召唤兽] ~= nil then
			字体:显示(self.x + 50,self.y + 177,format("%s/%s",tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].气血,tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].最大气血))
			字体:显示(self.x + 50,self.y + 207 ,format("%s/%s",tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].魔法,tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽].最大魔法))
		end
		if self.资源组[4] ~= nil then
			tp.影子:显示(self.x + 65,self.y + 140)
			self.资源组[4]:显示(self.x + 65,self.y + 140)
		end
		if self.资源组[98] ~= nil then
			self.资源组[98]:更新(dt)
			self.资源组[98]:显示(self.x + 65,self.y + 140)
		end
		for i=1,3 do

			self.召唤兽底图[i]:显示(self.x+self.装备坐标.xx[i],self.y+self.装备坐标.yy[i]-2)

			self.召唤兽装备[i]:置坐标(self.x+self.装备坐标.xx[i]+3,self.y+self.装备坐标.yy[i]-2)
			self.召唤兽装备[i]:显示(dt,x,y,self.鼠标)
			if not tp.消息栏焦点 then
				if self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点 then
					tp.提示:道具行囊(x,y,self.召唤兽装备[i].物品)
				end
				if tp.多角色[self.玩家id].宝宝列表[self.选中召唤兽] ~= nil then
					if tp.场景.抓取物品 == nil and self.召唤兽装备[i].物品 ~= nil and self.召唤兽装备[i].焦点  then
						if mousea(1) then
						   请求服务(63,{参数=self.玩家id,文本="卸下bb装备",类型=self.点击类型,角色="bb",道具=i,编号=self.选中召唤兽})
						end
					end
					if self.召唤兽装备[i].事件 then

					end
				end
				if self.召唤兽装备[i].焦点 then
					self.焦点 = true
				end
			end
		end
	elseif self.窗口 == "坐骑" then
		self.资源组[34]:显示(self.x+15,self.y + 55)
		self.资源组[61]:显示(self.x+140,self.y + 55)
		self.资源组[42]:更新(x,y,self.选中召唤兽 ~= 0)
		self.资源组[43]:更新(x,y)
		self.资源组[9]:显示(self.x + 227,self.y + 58,true)
		self.资源组[10]:显示(self.x + 226,self.y + 265,true)
		if self.选中召唤兽~=0 and tp.多角色[self.玩家id].坐骑~=nil and tp.多角色[self.玩家id].坐骑列表 ~= nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽]~=nil and tp.多角色[self.玩家id].坐骑.认证码==tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].认证码  then
			self.资源组[42]:置文字("下骑 ")
		else
			self.资源组[42]:置文字("骑乘 ")
		end


		if self.资源组[42]:事件判断() then
           if self.选中召唤兽 == 0 then
			tp.常规提示:打开("#Y/请选中一个坐骑！")
			return
		   end
		   if self.资源组[42]:取文字()=="骑乘 " then
			  请求服务(63,{参数=self.玩家id,文本="角色乘骑处理",序列=self.选中召唤兽})
		   elseif self.资源组[42]:取文字()=="下骑 " then
			  请求服务(63,{参数=self.玩家id,文本="角色下骑处理",序列=0})
		   end
		elseif self.资源组[43]:事件判断() then
			if tp.窗口.坐骑属性栏.可视 then
				tp.窗口.坐骑属性栏:打开()
			else
			  --  请求服务(96)
			end
		end
		self.资源组[42]:显示(self.x+80,self.y+240)
		self.资源组[43]:显示(self.x+80,self.y+265)
		for m=1,7 do
			if tp.多角色[self.玩家id].坐骑列表[m + self.加入] ~= nil then
				bw1:置坐标(self.x + 145,self.y + 50 + m * 18)
				if self.选中召唤兽 ~= m + self.加入 then
					if bw1:检查点(x,y) then
						box(self.x + 145,self.y + 50 + m * 18,self.x + 225,self.y + 50 + m * 18 + 17,-3551379)
						if mousea(0) and self.鼠标 then
							self.选中召唤兽 = m + self.加入
							self:置形象()
						end
						self.焦点 = true
					end
				else
					local ys = -10790181
					if bw1:检查点(x,y) then
						ys = -9670988
						self.焦点 = true
					end
					box(self.x + 145,self.y + 50 + m * 18,self.x + 225,self.y + 50 + m * 18 + 17,ys)
				end

				if tp.多角色[self.玩家id].坐骑 ~= nil and tp.多角色[self.玩家id].坐骑.模型 == tp.多角色[self.玩家id].坐骑列表[m + self.加入].模型 then
					字体:置颜色(-256)
				else
					字体:置颜色(-16777216)
				end
				字体:显示(self.x + 149,self.y + 51 + m * 18,tp.多角色[self.玩家id].坐骑列表[m + self.加入].模型)
			end
		end
		if self.资源组[4] ~= nil then
			tp.影子:显示(self.x + 65,self.y + 210)
			self.资源组[4]:更新(dt)
			self.资源组[4]:显示(self.x + 65,self.y + 210)
			if self.资源组[99] ~= nil then
				self.资源组[99]:更新(dt)
				self.资源组[99]:显示(self.x + 65,self.y + 210)

			end
		end
		self.坐骑底图:显示(self.x+18,self.y+238)
		if self.穿戴饰品[1].物品~=nil and not tp.消息栏焦点 and self.选中召唤兽~=0 and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽] ~= nil and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件~=nil and self.穿戴饰品[1].焦点 then
		    tp.提示:道具行囊(x,y,self.穿戴饰品[1].物品)
		end
		if  self.穿戴饰品[1].物品~=nil and not tp.消息栏焦点 and self.选中召唤兽~=0 and tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽] ~= nil and  tp.多角色[self.玩家id].坐骑列表[self.选中召唤兽].饰品物件~=nil then
			self.穿戴饰品[1]:置坐标(self.x+19,self.y+239)
			self.穿戴饰品[1]:显示(dt,x,y,self.鼠标)
		end
		if self.穿戴饰品[1].焦点 then
		    self.焦点 = true
	    	if mousea(1) then
				请求服务(63,{参数=self.玩家id,文本="卸下坐骑饰品",类型=1,角色=1,道具=1,编号=self.选中召唤兽})
			end
		end
	end
    if self.窗口~="法宝" then
		 self.资源组[6]:更新(x,y,self.窗口 ~= "主人公")
		 self.资源组[7]:更新(x,y,self.窗口 ~= "召唤兽")
		 self.资源组[30]:更新(x,y,self.窗口 ~= "坐骑")
		 self.资源组[31]:更新(x,y,self.窗口 ~= "子女")
		-- self.资源组[56]:更新(x,y,self.窗口 ~= "助战")
	 end
 if  self.点击类型=="道具" then
    for i=9,13 do
			local jx=self.x+512
			local jy=self.y+58+(i-9)*33
			self.背包按钮[i]:更新(x,y)
    		if 100/20>=i-8 then
				if self.页面==i-9 then
			    	self.背包按钮[i]:显示(jx,jy,nil,nil,nil,true,3)
			    else
			   	    self.背包按钮[i]:显示(jx,jy)
			    end
				if self.背包按钮[i]:事件判断() then
					self.页面=i-9
				end
				zts1:置颜色(白色):显示(jx+4,jy+8,i-8)
			end
		end
    	self.背包按钮[14]:更新(x,y)
    	self.背包按钮[14]:显示(self.x+512,self.y+223)
    	--zts:置颜色(白色):显示(self.x+282,self.y+371,"清")
    	zts1:置颜色(白色):显示(self.x+512,self.y+230,"清")
    	if self.背包按钮[14]:事件判断() then
    		local 事件 = function()
			 请求服务(63,{参数=self.玩家id,文本="清空背包"})
			end
			tp.窗口.文本栏:载入("你确定要把背包未加锁道具全部清空么，清空道具背包后道具无法找回?",nil,true,事件)

		end
		zts1:置颜色(黄色)
	    zts1:显示(self.x + 10,self.y + 300,self.提示文字)
	    zts1:置颜色(白色)

    end





	if self.鼠标 then
		if self.资源组[6]:事件判断() then
			local 站立人物=qzdmx(tp.多角色[self.玩家id].模型)
		    self.资源组[4] = tp.资源:载入(站立人物[10],"网易WDF动画",站立人物[6])
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			for n=1,6 do
				self.人物装备[n]:置物品(tp.多角色[self.玩家id].装备[n])
			end
			self.当前银行 = "现金"
			self.窗口 = "主人公"
			self.选中召唤兽 = 0
			self.加入 = 0
		elseif self.资源组[7]:事件判断() then
			self.资源组[4] = nil
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			self.当前银行 = "现金"
			self.窗口 = "召唤兽"
			self.选中召唤兽 = 0
			self.加入 = 0
		elseif self.资源组[30]:事件判断() then
			self.资源组[4] = nil
			self.窗口 = "坐骑"
			self.选中召唤兽= 0
		elseif self.资源组[31]:事件判断() then
			self.资源组[4] = nil
			for s=1,3 do
				self.召唤兽装备[s]:置物品(nil)
			end
			self.选中召唤兽 = 0
			self.加入 = 0
			self.资源组[4] = nil
			self.窗口 = "子女"
		elseif self.资源组[56]:事件判断() then

		end
	end
	  if self.窗口~="法宝" then
	     self.资源组[6]:显示(self.x+10,self.y + 30,true,nil,nil,self.窗口 == "主人公",2)
	     self.资源组[7]:显示(self.x+70,self.y + 30,true,nil,nil,self.窗口 == "召唤兽",2)
	     self.资源组[30]:显示(self.x+130,self.y + 30,true,nil,nil,self.窗口 == "坐骑",2)
	     self.资源组[31]:显示(self.x+190,self.y + 30,true,nil,nil,self.窗口 == "子女",2)
	    -- self.资源组[56]:显示(self.x+2,self.y + 121,true,nil,nil,self.窗口 == "助战",2)
	 end
	self.资源组[5]:显示(self.x + 516,self.y + 2,true)
	local o = self.开始 - 1 + self.页面*20
	for h=1,4 do
		for l=1,5 do
			o = o + 1
			local 行囊道具id= o
				self.物品[o]:置坐标(l * 51 - 51 + self.x+258,h * 51 -2 + self.y)
				self.物品[o]:显示(dt,x,y,self.鼠标)
				if  self.物品[o]~=nil and self.物品[o].物品~=nil and  self.物品[o].物品.总类 == 2 and self.物品[o].物品.鉴定  and self.物品[o].物品.赐福~=nil then
			 	    self.资源组[63]:显示(l * 51 - 51 + self.x+252,h * 51 -4 + self.y)
				end
			if self.物品[o].焦点 and not tp.消息栏焦点 then
				if self.物品[o].物品 ~= nil then
					tp.提示:道具行囊(x,y,self.物品[o].物品)
					if 引擎.按键按住(KEY.SHIFT) and 引擎.鼠标弹起(1) then
						local 事件 = function()
						 请求服务(63,{参数=self.玩家id,文本="提取道具",类型=self.点击类型,道具=行囊道具id})
						end
						tp.窗口.文本栏:载入("你确定要把改角色这个道具提取出来,绑定道具无法提取?",nil,true,事件)

					   return
				     end
				end
				self.焦点 = true
			end
			if  tp.场景.地图.抓取物品 == nil  and self.物品[o]~=nil and self.物品[o].焦点 and self.物品[o].物品 ~= nil and not tp.消息栏焦点 and self.物品[o].物品.分类 <=12 and self.物品[o].物品.总类~=2 and self.物品[o].物品.总类~="坐骑饰品" then
				if 引擎.鼠标弹起(0x01) and 右键弹起==false then --self.物品[o].右键
                   右键弹起=true
                    if self.窗口 == "法宝" then
                  	   请求服务(63,{参数=self.玩家id,文本="佩戴法宝",类型=self.点击类型,编号=o,窗口=self.窗口,序列=self.选中召唤兽})
                  	end
                   return
				end
			end
			if tp.场景.地图.抓取物品 == nil and self.物品[o].焦点 and self.物品[o].物品 ~= nil then
				if mousea(0) and 引擎.按键按住(0x10) and self.展示 == 0 then
				   self.展示 = 1 --- 限制只能展示一个
				   local 物品信息 ={}
					for k,v in pairs(self.物品[o].物品) do
						if k == "角色限制" then
						   物品信息.角色限制={}
						end
						if k ~= '大模型' and k ~= '小模型' then
						   物品信息[k] = v
						end
					end
				    tp.窗口.消息框.超链接=物品信息
				    tp.窗口.消息框.输入:添加文本("［"..self.物品[o].物品.名称.."］")
				   return
				end

				if mousea(1)  then
					if self.物品[o].物品.总类 == 2 then
						if self.物品[o].物品.鉴定  then
						    if self.窗口 == "主人公" and self.物品[o].物品.分类 < 10 then
								请求服务(63,{参数=self.玩家id,文本="佩戴装备",类型=self.点击类型,角色="主角",道具=o})
							elseif self.窗口 == "召唤兽" and self.选中召唤兽 ~= 0 then
								请求服务(63,{参数=self.玩家id,文本="佩戴bb装备",类型=self.点击类型,角色="bb",道具=o,编号=self.选中召唤兽})
							end
							if self.物品[o].物品 ~= nil and self.物品[o].物品.分类 >= 10 and self.物品[o].物品.分类 <=14 then
								请求服务(63,{参数=self.玩家id,文本="佩戴装备",类型=self.点击类型,角色="主角",道具=o})
							elseif self.物品[o].物品 ~= nil and self.物品[o].物品.分类 >= 15  then
								if self.物品[o].物品.分类 == 15 then
									if tp.多角色[self.玩家id].锦衣[1] == nil then
									    tp.多角色[self.玩家id].锦衣[1] = {}
									end
									tp.多角色[self.玩家id].锦衣[1].名称 = self.物品[o].物品.名称
									tp.场景.人物:置模型()
								elseif self.物品[o].物品.分类 == 16 then
									if tp.多角色[self.玩家id].锦衣[2] == nil then
									    tp.多角色[self.玩家id].锦衣[2] = {}
									end
									tp.多角色[self.玩家id].锦衣[2].名称 = self.物品[o].物品.名称
								    tp.场景.人物:穿戴光环()
								elseif self.物品[o].物品.分类 == 17 then
									if tp.多角色[self.玩家id].锦衣[3] == nil then
									    tp.多角色[self.玩家id].锦衣[3] = {}
									end
									tp.多角色[self.玩家id].锦衣[3].名称 = self.物品[o].物品.名称
								    tp.场景.人物:穿戴足迹()
								end
								 请求服务(63,{参数=self.玩家id,文本="佩戴装备",类型=self.点击类型,角色="主角",道具=o})
							end
						else
							tp.常规提示:打开("#Y/未鉴定的装备无法穿戴")
						end

					elseif self.物品[o].物品.总类 == "坐骑饰品" then
						if self.窗口=="坐骑" and self.选中召唤兽 ~=0 then
						  请求服务(63,{参数=self.玩家id,文本="穿戴坐骑饰品",类型=self.点击类型,角色="坐骑",道具=o,编号=self.选中召唤兽})
						else
							tp.常规提示:打开("#Y/坐骑饰品只能给坐骑使用哦")
						end
					end
				end
			end

			if self.物品[o].事件 then
				if tp.场景.抓取物品 == nil and self.物品[o].物品 ~= nil and 引擎.鼠标弹起(0x00)  then
                 	local 允许拿起=true
                  	if self.窗口=="法宝" then
                  	 	if self.物品[self.法宝选中]~=nil then
                          	self.物品[self.法宝选中].选中=nil
                  	 	end
                     	if self.法宝选中~=o then
                         	self.法宝选中=o
                         	self.物品[o].选中=true
                         	允许拿起=false
                     	end
                  	end
                 	if 允许拿起 then
					  	tp.场景.抓取物品 = self.物品[o].物品
					 	tp.场景.抓取物品ID = o
					 	tp.场景.抓取物品注释 = "多角色道具行囊_物品"
					 	tp.场景.抓取物品类型 = self.选择类型
					 	self.物品[tp.场景.抓取物品ID].确定 = true
					 	self.物品[o]:置物品(nil)
					 	self.抓取类型=self.点击类型
					end
				elseif tp.场景.抓取物品 ~= nil and self.物品[o].物品 == nil and tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
                   请求服务(63,{参数=self.玩家id,文本="格子互换",抓取id=tp.场景.抓取物品ID,放置id=o,放置类型=self.点击类型,抓取类型=self.抓取类型})
					if tp.场景.抓取物品注释 == "多角色道具行囊_物品" then
						self.物品[tp.场景.抓取物品ID].确定 = false
					end
					tp.场景.抓取物品 = nil
					tp.场景.抓取物品ID = nil
					tp.场景.抓取物品注释 = nil
					tp.场景.抓取物品类型 = nil
				elseif tp.场景.抓取物品 ~= nil and self.物品[o].物品 ~= nil and tp.场景.抓取物品注释 == "多角色道具行囊_物品"  then
					local jy = self.物品[o].物品
					local jy1 = tp.场景.抓取物品
					local jy2 = tp.场景.抓取物品ID
					请求服务(63,{参数=self.玩家id,文本="格子互换",抓取id=tp.场景.抓取物品ID,放置id=o,放置类型=self.点击类型,抓取类型=self.抓取类型})
					self.物品[tp.场景.抓取物品ID].确定 = false
					tp.场景.抓取物品 = nil
					tp.场景.抓取物品ID = nil
					tp.场景.抓取物品注释 = nil
					tp.场景.抓取物品类型 = nil
				end
			end

		end
	end
	-- 字体:置颜色(-256)
	-- 字体:显示(self.x + 20,self.y + 435,self.提示文字)
	if not self.鼠标 then
		if mousea(0) and tp.场景.抓取物品 ~= nil and  string.find(tp.场景.抓取物品注释, "多角色")~=nil then
		    self:整体资源刷新()
		    self:清除抓取道具()
		end
	end

	 -- local jq
		-- if self.当前银行 == "现金" then
		-- 	jq = tp.多角色[self.玩家id].银子
		-- elseif self.当前银行 == "储备" then
		-- 	jq = tp.多角色[self.玩家id].储备
		-- elseif self.当前银行 == "积分" then
		-- 	jq = tp.多角色[self.玩家id].积分
		-- end
       -- self.资源组[8]:置文字(self.当前银行)
		self.资源组[8]:显示(self.x + 256,self.y + 270,nil,true)
        self.资源组[60]:显示(self.x+310,self.y+270)
	   --	self.资源组[60]:显示(self.x+310,self.y+300)
	   	字体:置颜色(qjq(tp.多角色[self.玩家id].银子))
	   	字体:显示(self.x + 315,self.y + 273,tp.多角色[self.玩家id].银子)
	   	-- 字体:置颜色(qjq(tp.多角色[self.玩家id].存银))
	    -- 字体:显示(self.x + 315,self.y + 303,tp.多角色[self.玩家id].存银)


	  --self.资源组[58]:显示(self.x+5,self.y+5)

end






function 多角色道具行囊:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 多角色道具行囊:初始移动(x,y)
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

function 多角色道具行囊:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end


return 多角色道具行囊
local 场景类_幻化界面 = class()

local floor = math.floor
local insert = table.insert
local random = 引擎.取随机整数
local mouseb = 引擎.鼠标弹起
local tos = 取金钱颜色
local zts,tp,zts1
local bw = require("gge包围盒")(0,0,100,22)
local box = 引擎.画矩形
local remove = table.remove

function 场景类_幻化界面:初始化(根)
	self.ID = 99
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "幻化"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.状态 = true
	local 格子 = 根._物品格子
	self.物品 = {}
	for i=1,180 do
		self.物品[i] = 格子(0,0,i1,"幻化")
	end
	self.介绍文本 = require("script/系统类/丰富文本")(200,50)
	self.材料 = {}
	self.材料[1] = 格子(self.x+4,self.y,1,"幻化材料")
	self.开始 = 1
	self.结束 = 20
	self.总价 = 0
	self.道具位置 = nil
	self.窗口时间 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	zts2 = tp.字体表.普通字体__
	self.体力消耗=20
	self.消耗强化石=0
	self.需要消耗强化石=0
	self.朱雀石 = 0
	self.白虎石 = 0
	self.青龙石 = 0
	self.玄武石 = 0
	self.最大朱雀石数量 = 0
	self.最大白虎石数量 = 0
	self.最大青龙石数量 = 0
	self.最大玄武石数量 = 0
	self.强化石数量数据 = {朱雀石=0,白虎石=0,青龙石=0,玄武石=0}
    self.成功率=0
    self.新增成功率=0
    self.剩余陨铁=0
   	local wp = 0
end

function 场景类_幻化界面:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,510,320,3,9),
		[2] = 自适应.创建(1,1,506,18,1,3,nil,18),
		[3] = 自适应.创建(2,1,580,345,3,9),
		[4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF70725E9),
		[7] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[8] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[9] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[10] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[11] = 按钮.创建(自适应.创建(12,4,115,20,1,3),0,0,4,true,true,"自动加入强化石"),
		[12] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"幻化"),
		[13] = 自适应.创建(3,1,35,20,1,3),
		[14] = 按钮.创建(自适应.创建(26,4,25,22,4,3),0,0,4,true,true),
		[15] = 按钮.创建(自适应.创建(25,4,25,22,4,3),0,0,4,true,true),
		[16] = 自适应.创建(3,1,35,20,1,3),
		[17] = 按钮.创建(自适应.创建(26,4,25,22,4,3),0,0,4,true,true),
		[18] = 按钮.创建(自适应.创建(25,4,25,22,4,3),0,0,4,true,true),
		[19] = 自适应.创建(3,1,35,20,1,3),
		[20] = 按钮.创建(自适应.创建(26,4,25,22,4,3),0,0,4,true,true),
		[21] = 按钮.创建(自适应.创建(25,4,25,22,4,3),0,0,4,true,true),
		[22] = 自适应.创建(3,1,35,20,1,3),
		[23] = 按钮.创建(自适应.创建(26,4,25,22,4,3),0,0,4,true,true),
		[24] = 按钮.创建(自适应.创建(25,4,25,22,4,3),0,0,4,true,true),
		[25] = 资源:载入('登陆资源.wdf',"网易WDF动画",2289281503),
		[26] = 资源:载入('登陆资源.wdf',"网易WDF动画",2867857574),
		[27] = 资源:载入('登陆资源.wdf',"网易WDF动画",650195920),
		[28] = 资源:载入('登陆资源.wdf',"网易WDF动画",727733710),
		[29] = 自适应.创建(3,1,40,20,1,3),
	}
	self.资源组[4]:绑定窗口_(99)
	for i=11,24 do
		if i~=13 and i~=16 and i~=19 and i~=22 then
			self.资源组[i]:绑定窗口_(99)
		end
	end
end

function 场景类_幻化界面:打开(数据)
	if self.可视 then
		self.介绍文本:清空()
		self.随身 = nil
		self.开始 = 1
		self.结束 = 20
		self.可视 = false
		self.资源组=nil
		return
	else
		self.介绍文本.文字.大小 = 9
		self.介绍文本.文字高度 = 14
		self.介绍文本.文字宽度 = 6
		self.介绍文本:添加文本("#W请选择幻化材料,幻化失败后元身陨铁将会#Y消失#W,强化石可以提高成功率")
		insert(tp.窗口_,self)
		self:加载资源()
		self.刷新数据=数据
		--self.随身 = ss
		self.状态=true
		self.x = (全局游戏宽度/2)-222
		self.y = (全局游戏高度/2)-160
		self.开始 = 1
		self.结束 = 20
		for i=self.开始,self.结束 do
			self.物品[i]:置物品(数据[i])
		end
		self.材料[1]:置物品(nil)
		self.道具位置 = nil
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.消耗体活=20
	    self.消耗强化石=0
	    self.朱雀石 = 0
		self.白虎石 = 0
		self.青龙石 = 0
		self.玄武石 = 0
		self.最大朱雀石数量 = 0
		self.最大白虎石数量 = 0
		self.最大青龙石数量 = 0
		self.最大玄武石数量 = 0
		self.强化石数量数据 = {朱雀石=0,白虎石=0,青龙石=0,玄武石=0}
	    self.需要消耗强化石=0
	    self.成功率=0
	    self.新增成功率=0
	    self.剩余陨铁=0
	    wp = 0
	end
end


function 场景类_幻化界面:刷新道具(数据)
    self.开始 = 1
	self.结束 = 20
	for i=self.开始,self.结束 do
		self.物品[i]:置物品(数据[i])
	end
	self.材料[1]:置物品(nil)
 	self.消耗体活=20
 	self.消耗强化石=0
 	self.需要消耗强化石=0
 	self.朱雀石 = 0
	self.白虎石 = 0
	self.青龙石 = 0
	self.玄武石 = 0
	self.最大朱雀石数量 = 0
	self.最大白虎石数量 = 0
	self.最大青龙石数量 = 0
	self.最大玄武石数量 = 0
	self.强化石数量数据 = {朱雀石=0,白虎石=0,青龙石=0,玄武石=0}
    self.成功率=0
    self.新增成功率=0
    self.剩余陨铁=0
    wp = 0
end

local function 需要消耗强化石(物品)
	if 物品.幻化次数==nil then
		物品.幻化次数=0
	end
	if 物品.幻化次数 <= 10 then
		return 0
	elseif 物品.幻化次数 <= 20 then
		return 20
	elseif 物品.幻化次数 <= 30 then
		return 30
	elseif 物品.幻化次数 <= 40 then
		return 40
	elseif 物品.幻化次数 <= 50 then
		return 50
	elseif 物品.幻化次数 <= 60 then
		return 60
	elseif 物品.幻化次数 <= 70 then
		return 70
	elseif 物品.幻化次数 <= 80 then
		return 80
	elseif 物品.幻化次数 <= 90 then
		return 90
	elseif 物品.幻化次数 <= 100 then
		return 100
	else
		return 120
	end
end

local function 成功率(物品)
	if 物品.幻化次数==nil then
		物品.幻化次数=0
	end
	if 物品.幻化次数 <= 10 then
		return 100
	elseif 物品.幻化次数 <= 20 then
		return 90
	elseif 物品.幻化次数 <= 30 then
		return 85
	elseif 物品.幻化次数 <= 40 then
		return 80
	elseif 物品.幻化次数 <= 50 then
		return 75
	elseif 物品.幻化次数 <= 60 then
		return 70
	elseif 物品.幻化次数 <= 70 then
		return 65
	elseif 物品.幻化次数 <= 80 then
		return 60
	elseif 物品.幻化次数 <= 90 then
		return 55
	elseif 物品.幻化次数 <= 100 then
		return 50
	else
		return 40
	end
end

local function 剩余陨铁()
	local sl = 0
	for n=1,20 do
		if tp.道具列表[n] ~= nil and tp.道具列表[n].名称 == "陨铁" then
			sl = sl + 1
		end
	end
	return sl
end

local function 添加强化石(数量)
	local 已选数量 = 0
	local 相差数量 = 数量
	local 返回数据 = {选择位置={},选择数量={}}
	for n=1,20 do
		if tp.道具列表[n] ~= nil and (tp.道具列表[n].名称 == "朱雀石" or tp.道具列表[n].名称 == "白虎石" or tp.道具列表[n].名称 == "青龙石" or tp.道具列表[n].名称 == "玄武石") then
			if tp.道具列表[n].数量 >= 相差数量 and 已选数量 < 数量 then
				if 已选数量==0 then
					已选数量 = 数量
					返回数据.选择位置[#返回数据.选择位置+1] = n
					返回数据.选择数量[#返回数据.选择数量+1] = 数量
				else
				    已选数量 = 数量
				    返回数据.选择位置[#返回数据.选择位置+1] = n
					返回数据.选择数量[#返回数据.选择数量+1] = 相差数量
					相差数量 = 0
				end
				break
			elseif tp.道具列表[n].数量 < 相差数量 then
				if 已选数量 == 0 then
					已选数量 = tp.道具列表[n].数量
					返回数据.选择位置[#返回数据.选择位置+1] = n
					返回数据.选择数量[#返回数据.选择数量+1] = tp.道具列表[n].数量
					相差数量 = 相差数量 - tp.道具列表[n].数量
				else
				    返回数据.选择位置[#返回数据.选择位置+1] = n
					返回数据.选择数量[#返回数据.选择数量+1] = tp.道具列表[n].数量
					已选数量 = 已选数量 + tp.道具列表[n].数量
					相差数量 = 相差数量 - tp.道具列表[n].数量
				end
			end
		end
	end
	return 返回数据
end

local function 判断强化石数量(数据)
	for n=1,20 do
		if tp.道具列表[n] ~= nil and (tp.道具列表[n].名称 == "朱雀石" or tp.道具列表[n].名称 == "白虎石" or tp.道具列表[n].名称 == "青龙石" or tp.道具列表[n].名称 == "玄武石") then
			if tp.道具列表[n].名称 == "朱雀石" then
				数据.朱雀石 = 数据.朱雀石 + tp.道具列表[n].数量
			elseif tp.道具列表[n].名称 == "白虎石" then
				数据.白虎石 = 数据.白虎石 + tp.道具列表[n].数量
			elseif tp.道具列表[n].名称 == "青龙石" then
				数据.青龙石 = 数据.青龙石 + tp.道具列表[n].数量
			elseif tp.道具列表[n].名称 == "玄武石" then
				数据.玄武石 = 数据.玄武石 + tp.道具列表[n].数量
			end
		end
	end
end

function 场景类_幻化界面:显示(dt,x,y)
	if tp.窗口.摊位出售.可视 then
		tp.常规提示:打开("#Y/摆摊时无法打开幻化界面。")
		self.介绍文本:清空()
    	self:打开()
    	return
	end
	if tp.窗口.交易.可视 then
		tp.常规提示:打开("#Y/交易时无法打开幻化界面。")
		self.介绍文本:清空()
    	self:打开()
    	return
	end
	if tp.窗口.给予.可视 then
		tp.常规提示:打开("#Y/给予时无法打开幻化界面。")
		self.介绍文本:清空()
    	self:打开()
    	return
	end
	self.强化石数量数据 = {朱雀石=0,白虎石=0,青龙石=0,玄武石=0}
	判断强化石数量(self.强化石数量数据)
	local zl = nil
	self.焦点 = false
	self.资源组[4]:更新(x,y)
	self.资源组[11]:更新(x,y)
	self.资源组[12]:更新(x,y)
	self.资源组[14]:更新(x,y,100-self.成功率 >= self.新增成功率 and self.青龙石~=0 and self.材料[1].物品~=nil)
	self.资源组[15]:更新(x,y,self.成功率~=100 and self.材料[1].物品~=nil and self.青龙石 < self.强化石数量数据.青龙石 and self.消耗强化石~= self.需要消耗强化石)
	self.资源组[17]:更新(x,y,100-self.成功率 >= self.新增成功率 and self.白虎石~=0 and self.材料[1].物品~=nil)
	self.资源组[18]:更新(x,y,self.成功率~=100 and self.材料[1].物品~=nil and self.白虎石 < self.强化石数量数据.白虎石 and self.消耗强化石~= self.需要消耗强化石)
	self.资源组[20]:更新(x,y,100-self.成功率 >= self.新增成功率 and self.朱雀石~=0 and self.材料[1].物品~=nil)
	self.资源组[21]:更新(x,y,self.成功率~=100 and self.材料[1].物品~=nil and self.朱雀石 < self.强化石数量数据.朱雀石 and self.消耗强化石~= self.需要消耗强化石)
	self.资源组[23]:更新(x,y,100-self.成功率 >= self.新增成功率 and self.玄武石~=0 and self.材料[1].物品~=nil)
	self.资源组[24]:更新(x,y,self.成功率~=100 and self.材料[1].物品~=nil and self.玄武石 < self.强化石数量数据.玄武石 and self.消耗强化石~= self.需要消耗强化石)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-52,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-22,self.y+2,"幻  化")
	self.资源组[4]:显示(self.x+489,self.y+2)
	self.资源组[5]:显示(self.x+363,self.y+118)
	self.资源组[6]:显示(self.x+20,self.y+35)
	self.资源组[7]:显示(self.x+295,self.y+37)
	self.资源组[8]:显示(self.x+430,self.y+37)
	self.资源组[9]:显示(self.x+295,self.y+170)
	self.资源组[10]:显示(self.x+430,self.y+170)
	self.资源组[25]:显示(self.x+297,self.y+40)
	self.资源组[26]:显示(self.x+433,self.y+40)
	self.资源组[27]:显示(self.x+295,self.y+173)
	self.资源组[28]:显示(self.x+432,self.y+173)
	self.资源组[11]:显示(self.x+305,self.y+285)
	self.资源组[12]:显示(self.x+430,self.y+285)
	self.资源组[13]:显示(self.x+304,self.y+93)
	self.资源组[14]:显示(self.x+282,self.y+93)
	self.资源组[15]:显示(self.x+342,self.y+93)
	self.资源组[16]:显示(self.x+439,self.y+93)
	self.资源组[17]:显示(self.x+417,self.y+93)
	self.资源组[18]:显示(self.x+477,self.y+93)
	self.资源组[19]:显示(self.x+304,self.y+226)
	self.资源组[20]:显示(self.x+282,self.y+226)
	self.资源组[21]:显示(self.x+342,self.y+226)
	self.资源组[22]:显示(self.x+439,self.y+226)
	self.资源组[23]:显示(self.x+417,self.y+226)
	self.资源组[24]:显示(self.x+477,self.y+226)
	if self.资源组[4]:事件判断() then
		self.介绍文本:清空()
		self:打开()
	elseif self.资源组[14]:事件判断() then
		if self.青龙石 > 0 then
			self.青龙石 = self.青龙石 - 1
			self.消耗强化石 = self.消耗强化石 - 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[15]:事件判断() then
		if self.青龙石 < self.强化石数量数据.青龙石 then
			self.青龙石 = self.青龙石 + 1
			self.消耗强化石 = self.消耗强化石 + 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[17]:事件判断() then
		if self.白虎石 > 0 then
			self.白虎石 = self.白虎石 - 1
			self.消耗强化石 = self.消耗强化石 - 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[18]:事件判断() then
		if self.白虎石 < self.强化石数量数据.白虎石 then
			self.白虎石 = self.白虎石 + 1
			self.消耗强化石 = self.消耗强化石 + 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[20]:事件判断() then
		if self.朱雀石 > 0 then
			self.朱雀石 = self.朱雀石 - 1
			self.消耗强化石 = self.消耗强化石 - 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[21]:事件判断() then
		if self.朱雀石 < self.强化石数量数据.朱雀石 then
			self.朱雀石 = self.朱雀石 + 1
			self.消耗强化石 = self.消耗强化石 + 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[23]:事件判断() then
		if self.玄武石 > 0 then
			self.玄武石 = self.玄武石 - 1
			self.消耗强化石 = self.消耗强化石 - 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[24]:事件判断() then
		if self.玄武石 < self.强化石数量数据.玄武石 then
			self.玄武石 = self.玄武石 + 1
			self.消耗强化石 = self.消耗强化石 + 1
			self.新增成功率 = math.floor((self.青龙石 + self.白虎石 + self.朱雀石 + self.玄武石)/2)
		end
	elseif self.资源组[11]:事件判断() then
		if self.材料[1] == nil or self.材料[1].物品 == nil then
			tp.常规提示:打开("#Y/您还未选择需要幻化的装备。")
		elseif self.材料[1].物品.幻化次数 == nil or self.材料[1].物品.幻化次数 <= 10 then
			tp.常规提示:打开("#Y/您选择的装备有10次免费幻化的机会，不需要添加强化石。")
		else
			self.朱雀石 = 0
			self.白虎石 = 0
			self.青龙石 = 0
			self.玄武石 = 0
			self.消耗强化石 = 0
			self.需要消耗强化石 = 0
			self.新增成功率 = 0
			self.需要消耗强化石 = 需要消耗强化石(self.材料[1].物品)
			local 添加强化石数据 = 添加强化石(self.需要消耗强化石)
			for n=1,#添加强化石数据.选择位置 do
			    if tp.道具列表[添加强化石数据.选择位置[n]].名称 == "朱雀石" then
			    	self.朱雀石 = self.朱雀石 + 添加强化石数据.选择数量[n]
			    	self.消耗强化石 = self.消耗强化石 + 添加强化石数据.选择数量[n]
			    elseif tp.道具列表[添加强化石数据.选择位置[n]].名称 == "白虎石" then
			    	self.白虎石 = self.白虎石 + 添加强化石数据.选择数量[n]
			    	self.消耗强化石 = self.消耗强化石 + 添加强化石数据.选择数量[n]
			    elseif tp.道具列表[添加强化石数据.选择位置[n]].名称 == "青龙石" then
			    	self.青龙石 = self.青龙石 + 添加强化石数据.选择数量[n]
			    	self.消耗强化石 = self.消耗强化石 + 添加强化石数据.选择数量[n]
			    elseif tp.道具列表[添加强化石数据.选择位置[n]].名称 == "玄武石" then
			    	self.玄武石 = self.玄武石 + 添加强化石数据.选择数量[n]
			    	self.消耗强化石 = self.消耗强化石 + 添加强化石数据.选择数量[n]
			    end
			end
			self.新增成功率 = math.floor(self.消耗强化石/2)
		end
	elseif self.资源组[12]:事件判断() then
		if self.材料[1] == nil or self.材料[1].物品 == nil then
			tp.常规提示:打开("#Y/您还未选择需要幻化的装备。")
		else
			请求服务(4517,{序列=self.材料[1].道具序列,强化石序列={朱雀石=self.朱雀石,白虎石=self.白虎石,青龙石=self.青龙石,玄武石=self.玄武石}})
		end
	end
	zts:置颜色(-16777216)
	zts:显示(self.x + 314,self.y + 97,floor(self.青龙石 or 0))
	zts:显示(self.x + 449,self.y + 97,floor(self.白虎石 or 0))
	zts:显示(self.x + 314,self.y + 230,floor(self.朱雀石 or 0))
	zts:显示(self.x + 449,self.y + 230,floor(self.玄武石 or 0))
	self.介绍文本:显示(self.x+275,self.y+250)
	zts2:置颜色(白色):显示(self.x+30,self.y+258,"体活消耗:")
	zts2:置颜色(白色):显示(self.x+160,self.y+258,"成功率:")
	zts2:置颜色(白色):显示(self.x+30,self.y+288,"剩余陨铁:")
	zts2:置颜色(白色):显示(self.x+160,self.y+288,"强化石消耗:")
	self.资源组[29]:显示(self.x+90,self.y+255)
	self.资源组[29]:显示(self.x+230,self.y+255)
	self.资源组[29]:显示(self.x+90,self.y+285)
	self.资源组[29]:显示(self.x+230,self.y+285)
	local is = self.开始 - 1
	for h=1,4 do
		for l=1,5 do
			is = is + 1
			self.物品[is]:置坐标((l-1) * 51 + 20 + self.x,(h-1) * 51 + self.y + 35)
			self.物品[is]:显示(dt,x,y,self.鼠标)
		   	if self.物品[is].物品~=nil then
		   		self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2 or self.物品[is].物品.总类 == 66) and self.物品[is].物品.分类 <= 6})
		  	end
		  	if self.物品[is].物品 ~= nil and self.物品[is].焦点 then
				tp.提示:道具行囊(x,y,self.物品[is].物品)
				if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2 or self.物品[is].物品.总类 == 66) and self.物品[is].物品.分类 <= 6) and self.鼠标 then
					if self.材料[1].物品 == nil then
						if self.物品[is].物品.鉴定==false then
							tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
							return
						end
						if self.物品[is].物品.级别限制~=nil and (self.物品[is].物品.级别限制~=150 and self.物品[is].物品.总类 ~= 66) then
							tp.常规提示:打开("#Y/非150级的装备无法进行幻化。")
							return
						end
						wp = self.物品[is].物品
						self.需要消耗强化石 = 需要消耗强化石(wp)
						self.成功率 = 成功率(wp)
						self.剩余陨铁 = 剩余陨铁()
						self.材料[1]:置物品(self.物品[is].物品)
						self.材料[1].道具序列=is
						self.道具位置 = is
						self.物品[is]:置物品(nil)
					end
				end
				刷新道具逻辑(self.物品[is].物品,is,true)
			end
			if self.物品[is].焦点 then
				self.焦点 = true
			end
		end
	end
	self.材料[1]:置坐标(self.x+365,self.y+118)
	self.材料[1]:显示(dt,x,y,self.鼠标)
	if self.材料[1].物品 ~= nil and self.材料[1].焦点 then
		tp.提示:道具行囊(x,y,self.材料[1].物品)
		if mouseb(0) and self.鼠标 then
			if 取物品数量() < 160 then
				增加物品(self.材料[1].物品,nil,nil,self.道具位置)
				self.材料1总价 = 0
				self.材料[1]:置物品(nil)
				self.道具位置=nil
			else
				tp.常规提示:打开("#Y/包裹已满。请及时清理")
			end
		end
	end
	if self.材料[1].焦点 then
		self.焦点 = true
	end
	if self.材料[1].物品 ~= nil then
		zts:置颜色(-16777216)
		zts:显示(self.x+100,self.y+258,self.消耗体活)
		zts:显示(self.x+100,self.y+288,self.剩余陨铁)
		zts:显示(self.x+240,self.y+288,self.消耗强化石)
		if self.新增成功率~=0 then
			zts:置颜色(红色)
		end
		zts:显示(self.x+240,self.y+258,self.成功率 + self.新增成功率)
	end
end

function 场景类_幻化界面:检查点(x,y)
	local n = false
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		n  = true
	end
	return n
end

function 场景类_幻化界面:初始移动(x,y)
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

function 场景类_幻化界面:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end


return 场景类_幻化界面
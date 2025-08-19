
local 场景类_打造 = class()

local floor = math.floor
local insert = table.insert
local random = 引擎.取随机整数
local mouseb = 引擎.鼠标弹起
local tos = 取金钱颜色
local zts,tp,zts1
local bw = require("gge包围盒")(0,0,100,22)
local box = 引擎.画矩形
local remove = table.remove
local 取文字 = {
	[1] = {"强化打造装备"},--"普通打造装备","召唤兽装备","强化打造灵饰","普通打造灵饰",
	[2] = {"宝石","精魄灵石","星辉石","点化石","珍珠","钟灵石"},
	[3] = {"宝石","星辉石","点化石","变身卡"},
	[4] = {"人物装备","人物灵饰","召唤兽装备"},
	[5] = {"熔炼装备","还原装备"},
	[6] = {"分解装备","分解灵犀玉"},
	[7] = {"强化装备","强化灵犀玉"},
}
local 取材料 = {
	[1] = {"制造指南书、百炼精铁","制造指南书、百炼精铁","上古锻造图策、天眼珠","灵饰指南书、元灵晶石","灵饰指南书、元灵晶石"},
	[2] = {"人物装备、宝石","召唤兽装备、精魄灵石","灵饰装备、星辉石","召唤兽装备、点化石","装备、珍珠","灵饰装备、钟灵石"},
	[3] = {"两个同等级宝石","两个同等级星辉石","两个点化石","两张变身卡"},
	[4] = {"人物装备","灵饰装备","召唤兽装备"},
	[5] = {"人物装备、熔炼石","人物装备"},
	[6] = {"装备、分解符","灵犀玉、分解符"},
	[7] = {"装备、强化石、强化符","灵犀玉、强化符"},
}

function 场景类_打造:初始化(根)
	self.ID = 100
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "打造"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true

	self.状态 = "打造"
	local 格子 = 根._物品格子
	self.物品 = {}
	for i=1,180 do
		self.物品[i] = 格子(0,0,i1,"打造")
	end
	self.材料 = {}
	self.材料[1] = 格子(self.x+4,self.y,1,"打造材料")
	self.材料[2] = 格子(self.x+4,self.y,2,"打造材料")
	self.开始 = 1
	self.结束 = 20
	self.总价 = 0
	self.道具位置 = {}
	self.窗口时间 = 0
	self.下拉状态 = true
	self.下拉选中 = ""
	self.下拉选中数值 = 0
	tp = 根
	zts = tp.字体表.普通字体
	zts1 = tp.字体表.描边字体
	self.体力消耗=0
end

function 场景类_打造:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,445,320,3,9),
		[2] = 自适应.创建(1,1,441,18,1,3,nil,18),
		[3] = 自适应.创建(2,1,515,345,3,9),
		[4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF70725E9),
		[7] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"打造"),
		[8] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"镶嵌"),
		[9] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"合成"),
		[10] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"修理"),
		[11] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"熔炼"),
		[12] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"分解"),
		[13] = 自适应.创建(3,1,100,18,1,3),
		[14] = 自适应.创建(3,1,80,18,1,3),
		[15] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"打造"),
		[16] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"镶嵌"),
		[17] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),
		[18] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"合成"),
		[19] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"修理"),
		[20] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"熔炼"),
		[21] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"分解"),
		[22] = 自适应.创建(9,1,100,140,3,9),
		[23] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB17505CF),
		[24] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"强化"),--1
		[25] = 按钮.创建(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"强化"),--2
	}
	self.资源组[4]:绑定窗口_(100)
	for i=7,21 do
		if i~=13 and i~=14 then
			self.资源组[i]:绑定窗口_(100)
		end
	end
end

function 场景类_打造:打开(数据)
	if self.可视 then
		self.随身 = nil
		self.开始 = 1
		self.结束 = 20
		self.可视 = false
		self.资源组=nil
	else
		insert(tp.窗口_,self)
		self:加载资源()
		self.刷新数据=数据
		--self.随身 = ss
		self.状态="打造"
		self.下拉选中 = ""
		self.下拉状态 = true
		self.x = (全局游戏宽度/2)-222
		self.y = (全局游戏高度/2)-160
		self.开始 = 1
		self.结束 = 20
		for i=self.开始,self.结束 do
			self.物品[i]:置根(tp)
			self.物品[i]:置物品(数据[i])
		end

		for i=1,2 do
			self.材料[i]:置物品(nil)
		end
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.消耗体力=0
	    zj=0
	end
end


function 场景类_打造:刷新道具(数据)
    self.开始 = 1
	self.结束 = 20
	for i=self.开始,self.结束 do
		self.物品[i]:置物品(数据[i])
	end

	for i=1,2 do
		self.材料[i]:置物品(nil)
	end

 	self.消耗体力=0
 	zj=0
end

function 场景类_打造:取消耗体力(物品,等级)
   	if (物品.总类 == 5 and (物品.分类 == 1 or 物品.分类 == 2)) then
    	return floor(等级 / 10 + 10)
    elseif (物品.总类 == 5 and (物品.分类 == 20 or 物品.分类 == 21)) then
    	return floor(等级 / 10 + 10)
    elseif (物品.总类 == 5 and 物品.分类 == 499) or (物品.总类 == 2 and (物品.分类 == 1 or 物品.分类 == 2 or 物品.分类 == 3 or 物品.分类 == 4 or 物品.分类 == 5 or 物品.分类 == 6)) then
    	return floor(等级 / 10 + 10)
    elseif 物品.总类 == 3 then
    	return floor(等级 / 10 + 10)
   	elseif (物品.总类 == 2 and (物品.分类 == 7 or 物品.分类 == 8 or 物品.分类 == 9)) or (物品.总类 == 5 and 物品.分类 == 5) then
   		return 0
   	elseif 物品.总类 == 66 or 物品.总类 == 67 then
   	    return 350
   	else
   	    return 0
   	end
end

local function 打造金钱公式(物品,等级)
	if (物品.总类 == 5 and (物品.分类 == 1 or 物品.分类 == 2)) then
    	return floor(等级 * 等级 * 10)
    elseif (物品.总类 == 5 and (物品.分类 == 20 or 物品.分类 == 21)) then
    	return floor(等级 * 等级 * 10)
    elseif (物品.总类 == 5 and 物品.分类 == 499) or (物品.总类 == 2 and (物品.分类 == 1 or 物品.分类 == 2 or 物品.分类 == 3 or 物品.分类 == 4 or 物品.分类 == 5 or 物品.分类 == 6)) then
        return floor(等级 * 等级 * 10)
    elseif 物品.总类 == 3 then
    	return floor(等级 * 等级 * 10)
   	elseif (物品.总类 == 2 and (物品.分类 == 7 or 物品.分类 == 8 or 物品.分类 == 9)) or (物品.总类 == 5 and 物品.分类 == 5) then
   		return floor(等级 * 等级 * 10)
   	elseif 物品.总类 == 66 or 物品.总类 == 67 then
   	    return floor(等级 * 等级 * 10)
   	else
   	    return floor(等级 * 10000)
   	end
end


local function 取可以镶嵌(zb,bs)
	if zb == 1 and (bs == 2 or bs == 3) then
		return true
	elseif zb == 2 and bs == 4 then
		return true
	elseif zb == 3 and (bs == 3 or bs == 5 or bs == 7) then
		return true
	elseif zb == 4 and (bs == 1 or bs == 2 or bs == 4) then
		return true
	elseif zb == 5 and (bs == 1 or bs == 6 or bs == 7) then
		return true
	elseif zb == 6 and (bs == 6 or bs == 7) then
		return true
	end
end

function 场景类_打造:显示(dt,x,y)
	if tp.窗口.道具行囊.可视 then
    	tp.窗口.道具行囊:打开()
	end
	local zl = nil
	self.焦点 = false
	self.资源组[4]:更新(x,y)
	self.资源组[7]:更新(x,y,self.状态~="打造")
	self.资源组[8]:更新(x,y,self.状态~="镶嵌")
	self.资源组[9]:更新(x,y,self.状态~="合成")
	self.资源组[10]:更新(x,y,self.状态~="修理")
	self.资源组[11]:更新(x,y,self.状态~="熔炼")
	self.资源组[12]:更新(x,y,self.状态~="分解")
	self.资源组[24]:更新(x,y,self.状态~="强化")
	self.资源组[25]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[15]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[16]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[18]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[19]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[20]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[21]:更新(x,y,self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil)
	self.资源组[17]:更新(x,y)
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-52,self.y+2)
	zts1:显示(self.x+self.资源组[1].宽度/2-22,self.y+2,"制  造")
	self.资源组[4]:显示(self.x+424,self.y+2)
	self.资源组[5]:显示(self.x+30,self.y+105)
	self.资源组[23]:显示(self.x+90,self.y+105)
	self.资源组[6]:显示(self.x+175,self.y+95)
	self.资源组[7]:显示(self.x+20,self.y+30)
	--self.资源组[8]:显示(self.x+160,self.y+30)
	--self.资源组[9]:显示(self.x+160,self.y+30)
	--self.资源组[10]:显示(self.x+230,self.y+30)
	--self.资源组[11]:显示(self.x+300,self.y+30)
	--self.资源组[24]:显示(self.x+220,self.y+30)
	self.资源组[12]:显示(self.x+90,self.y+30)-----分解选项
	self.资源组[13]:显示(self.x+55,self.y+65)
	self.资源组[14]:显示(self.x+80,self.y+180)
	self.资源组[14]:显示(self.x+80,self.y+205)
	self.资源组[14]:显示(self.x+80,self.y+230)
	self.资源组[14]:显示(self.x+80,self.y+255)
	self.资源组[17]:显示(self.x+145,self.y+65)
	if self.资源组[4]:事件判断() then
		self:打开()
		return
	elseif self.资源组[7]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="打造"
		self.道具位置 = {}
		elseif self.资源组[24]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="强化"
		self.道具位置 = {}
	elseif self.资源组[8]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="镶嵌"
		self.道具位置 = {}
	elseif self.资源组[9]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="合成"
		self.道具位置 = {}
	elseif self.资源组[10]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="修理"
		self.道具位置 = {}
	elseif self.资源组[11]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="熔炼"
		self.道具位置 = {}
	elseif self.资源组[12]:事件判断() then
		for ns=1,2 do
			if 取物品数量() < 160 then
				if self.材料[ns].物品~=nil then
					if self.材料[ns].物品.可叠加 then
						增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
					else
					    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
					end
				end
				if ns == 1 then
					self.材料1总价 = 0
				else
					self.材料2总价 = 0
				end
				self.材料[ns]:置物品(nil)
			end
		end
		zl = nil
		self.下拉选中数值 = 0
		self.下拉选中 = ""
		self.下拉状态 = true
		self.状态="分解"
		self.道具位置 = {}
	elseif self.资源组[17]:事件判断() then
		if self.下拉状态 then
			self.下拉状态 = false
		else
			for ns=1,2 do
				if 取物品数量() < 160 then
					if self.材料[ns].物品~=nil then
						if self.材料[ns].物品.可叠加 then
							增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
						else
						    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
						end
					end
					if ns == 1 then
						self.材料1总价 = 0
					else
						self.材料2总价 = 0
					end
					self.材料[ns]:置物品(nil)
				end
			end
			self.下拉状态 = true
			self.道具位置 = {}
		end
	elseif self.资源组[15]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	elseif self.资源组[16]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	elseif self.资源组[18]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	elseif self.资源组[19]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	elseif self.资源组[20]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	elseif self.资源组[21]:事件判断() then
		请求服务(5000,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
	end
	if self.资源组[25]:事件判断() then
		请求服务(4509,{序列=self.材料[1].道具序列,序列1=self.材料[2].道具序列,打造方式={界面=self.状态,选项=self.下拉选中}})
     end

	if self.状态=="打造" then
		zts:显示(self.x+18,self.y+68,"打造:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[1][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		self.资源组[15]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[1] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[1][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[1][i])
			end
		end
	elseif self.状态=="镶嵌" then
		zts:显示(self.x+18,self.y+68,"镶嵌:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[2][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		-- self.资源组[16]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[2] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[2][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[2][i])
			end
		end
		elseif self.状态=="强化" then
		zts:显示(self.x+18,self.y+68,"强化:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(-16777216)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[7][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(-16777216)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		-- self.资源组[25]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[7] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[7][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:置颜色(白色)
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[7][i])
				zts:置颜色(-16777216)
			end
		end
	elseif self.状态=="合成" then
		zts:显示(self.x+18,self.y+68,"合成:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[3][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		self.资源组[18]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[3] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[3][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[3][i])
			end
		end
	elseif self.状态=="修理" then
		zts:显示(self.x+18,self.y+68,"修理:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[4][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		self.资源组[19]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[4] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[4][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[4][i])
			end
		end
	elseif self.状态=="熔炼" then
		zts:显示(self.x+18,self.y+68,"熔炼:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[5][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		self.资源组[20]:显示(self.x+100,self.y+280)
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[5] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[5][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[5][i])
			end
		end
	elseif self.状态=="分解" then
		zts:显示(self.x+18,self.y+68,"分解:")
		zts:显示(self.x+175,self.y+68,"所需素材:")
		zts:置颜色(黄色)
		zts:显示(self.x+60,self.y+69,self.下拉选中)
		zts:置颜色(红色)
		zts:显示(self.x+230,self.y+68,取材料[6][self.下拉选中数值])
		zts:置颜色(白色)
		zts:显示(self.x+18,self.y+180,"所需资金:")
		zts:显示(self.x+18,self.y+205,"现有资金:")
		zts:显示(self.x+18,self.y+230,"所需体力:")
		zts:显示(self.x+18,self.y+255,"现有体力:")
		zts:置颜色(tos(tp.金钱))
		zts:显示(self.x + 85,self.y + 208,tp.金钱)
		zts:置颜色(黄色)
		zts:显示(self.x + 85,self.y + 258,floor(tp.队伍[1].体力))
		self.资源组[21]:显示(self.x+100,self.y+280) ----------------分解按钮
		if self.下拉状态 then
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			self.资源组[22]:显示(self.x+55,self.y+85)
			for i=1,#取文字[6] do
				bw:置坐标(self.x + 55,self.y + 85 + (i-1)*22)
				if bw:检查点(x,y) then
					box(self.x + 55,self.y + 85 + (i-1)*22,self.x + 155,self.y + 105 + (i-1)*22,-3551379)
					if mouseb(0) and self.鼠标 and not tp.消息栏焦点 then
						self.下拉选中 = 取文字[6][i]
						self.下拉状态 = false
						self.下拉选中数值 = i
					end
				end
				zts:显示(self.x+62,self.y+87+(i-1)*22,取文字[6][i])
			end
		end
	end

	local is = self.开始 - 1
	for h=1,4 do
		for l=1,5 do
			is = is + 1
			self.物品[is]:置坐标(l * 51 + 124 + self.x,h * 51 + self.y + 44)
			self.物品[is]:显示(dt,x,y,self.鼠标)
		   	if self.物品[is].物品~=nil then
		   		if self.下拉选中 ~= "" then
		   			if self.状态=="打造" then
			   			if self.下拉选中 == "强化打造装备" then
			   				self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 5 or self.物品[is].物品.总类 == 67 or self.物品[is].物品.总类 == 66) and (self.物品[is].物品.分类 == 1 or self.物品[is].物品.分类 == 2)})
			   			elseif self.下拉选中 == "普通打造装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 5 and (self.物品[is].物品.分类 == 1 or self.物品[is].物品.分类 == 2)})
						elseif self.下拉选中 == "强化打造灵饰" or self.下拉选中 == "普通打造灵饰" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 5 and (self.物品[is].物品.分类 == 20 or self.物品[is].物品.分类 == 21)})
						elseif self.下拉选中 == "召唤兽装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 3})
						end
					elseif self.状态=="镶嵌" then
						if self.下拉选中 == "宝石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 ~= 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6)})
						elseif self.下拉选中 == "精魄灵石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 11)})
						elseif self.下拉选中 == "钟灵石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10)})
						elseif self.下拉选中 == "星辉石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6) or(self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10)})
						elseif self.下拉选中 == "点化石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 5)})
						elseif self.下拉选中 == "珍珠" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.名称 == "珍珠" or self.物品[is].物品.总类 == 2})
						end
					elseif self.状态=="合成" then
						if self.下拉选中 == "宝石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 ~= 8})
						elseif self.下拉选中 == "星辉石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8})
						elseif self.下拉选中 == "点化石" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 5})
						elseif self.下拉选中 == "变身卡" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 30})
						end
					elseif self.状态=="修理" then
						if self.下拉选中 == "人物装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6})
						elseif self.下拉选中 == "人物灵饰" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10})
						elseif self.下拉选中 == "召唤兽装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6})
						end
					elseif self.状态=="熔炼" then
						if self.下拉选中 == "熔炼装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 499)})
						elseif self.下拉选中 == "还原装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6})
						end
					elseif self.状态=="强化" then
						if self.下拉选中 == "强化装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3)or (self.物品[is].物品.总类 == 33)})
						-- elseif self.下拉选中 == "强化灵犀玉" then
						-- 	self.物品[is]:显示(dt,x,y,self.鼠标,{0,0})
						end
					elseif self.状态=="分解" then
						if self.下拉选中 == "分解装备" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0,(self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3)})
						elseif self.下拉选中 == "分解灵犀玉" then
							self.物品[is]:显示(dt,x,y,self.鼠标,{0,0})
						end
					end
				else
					self.物品[is]:显示(dt,x,y,self.鼠标~=false)
				end
			end
			if self.下拉状态 == false then
				if self.物品[is].物品 ~= nil and self.物品[is].焦点 then
					tp.提示:道具行囊(x,y,self.物品[is].物品)
					if self.状态=="打造" then
						if self.下拉选中 == "强化打造装备" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 5 or self.物品[is].物品.总类 == 67 or self.物品[is].物品.总类 == 66) and (self.物品[is].物品.分类 == 1 or self.物品[is].物品.分类 == 2)) and self.鼠标 then
								if self.物品[is].物品.总类 == 5 then
									zl = self.物品[is].物品.子类
								else
								    zl = self.物品[is].物品.级别限制
								end
								if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "普通打造装备" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 5 and (self.物品[is].物品.分类 == 1 or self.物品[is].物品.分类 == 2)) and self.鼠标 then
								zl = self.物品[is].物品.子类
								if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "强化打造灵饰" or self.下拉选中 == "普通打造灵饰" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 5 and (self.物品[is].物品.分类 == 20 or self.物品[is].物品.分类 == 21)) and self.鼠标 then
								zl = self.物品[is].物品.子类
								if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "召唤兽装备" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 3) and self.鼠标 then
								if self.物品[is].物品.分类 == 10 then
									zl = self.物品[is].物品.级别限制
								end
								if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
					elseif self.状态=="镶嵌" then
						if self.下拉选中 == "宝石" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 ~= 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6)) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
								if self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 >= 1 and self.物品[is].物品.子类 <= 8 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "精魄灵石" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 11)) and self.鼠标 then
								if self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 11 and self.物品[is].物品.子类 >= 1 and self.物品[is].物品.子类 <= 3 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "钟灵石" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10)) and self.鼠标 then
								if self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "星辉石" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8)  or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 10) or (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10)) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
								if self.物品[is].物品.总类 == 5 and self.物品[is].物品.子类 >= 1 and self.物品[is].物品.子类 <= 8 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "点化石" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 5)) and self.鼠标 then
								if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "珍珠" then
							if self.物品[is].事件 and (self.物品[is].物品.名称 == "珍珠" or self.物品[is].物品.总类 == 2) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
								if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
					elseif self.状态=="合成" then
						if self.下拉选中 == "宝石" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 ~= 8) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
								if self.物品[is].物品.子类 >= 1 and self.物品[is].物品.子类 <= 8 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "星辉石" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 6 and self.物品[is].物品.子类 == 8) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
								if self.物品[is].物品.子类 >= 1 and self.物品[is].物品.子类 <= 8 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "点化石" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 5) and self.鼠标 then
		   						zl = self.物品[is].物品.子类
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "变身卡" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 30) and self.鼠标 then
		   						zl = self.物品[is].物品.子类
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
					elseif self.状态=="修理" then
						if self.下拉选中 == "人物装备" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						zl = self.物品[is].物品.级别限制
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "人物灵饰" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 >= 10) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						zl = self.物品[is].物品.级别限制
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "召唤兽装备" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 < 10 and self.物品[is].物品.分类 > 6) and self.鼠标 then
		   						zl = self.物品[is].物品.级别限制
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
					elseif self.状态=="熔炼" then
						if self.下拉选中 == "熔炼装备" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 499)) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "还原装备" then
							if self.物品[is].事件 and (self.物品[is].物品.总类 == 2 and self.物品[is].物品.分类 <= 6) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
						elseif self.状态=="强化" then
						if self.下拉选中 == "强化装备" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3) or (self.物品[is].物品.总类 == 33)) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "强化灵犀玉" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3)) and self.鼠标 then
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self..材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
							end
					elseif self.状态=="分解" then
						if self.下拉选中 == "分解装备" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3)) and self.鼠标 then
								if self.物品[is].物品.鉴定==false then
									tp.常规提示:打开("#Y/该装备未鉴定，无法进行操作。")
									return
								end
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = zl*500
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						elseif self.下拉选中 == "分解灵犀玉" then
							if self.物品[is].事件 and ((self.物品[is].物品.总类 == 2) or (self.物品[is].物品.总类 == 5 and self.物品[is].物品.分类 == 3)) and self.鼠标 then
		   						if self.物品[is].物品.总类 == 2 then
		   							zl = self.物品[is].物品.级别限制
		   						end
		   						if self.材料[1].物品 == nil and self.材料[2].物品 == nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 ~= nil and self.材料[2].物品 == nil then
									self.材料[2]:置物品(self.物品[is].物品)
									self.材料[2].道具序列=is
									self.道具位置[2] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self.材料[2].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[2].物品,zl)
									end
									self.物品[is]:置物品(nil)
								elseif self.材料[1].物品 == nil and self.材料[2].物品 ~= nil then
									self.材料[1]:置物品(self.物品[is].物品)
									self.材料[1].道具序列=is
									self.道具位置[1] = is
									if zl ~= nil then
										self.总价 = 打造金钱公式(self..材料[1].物品,zl)
										self.消耗体力=self:取消耗体力(self.材料[1].物品,zl)
									end
									self.物品[is]:置物品(nil)
								end
							end
						end
					end
					刷新道具逻辑(self.物品[is].物品,is,true)
				end
				if self.物品[is].焦点 then
					self.焦点 = true
				end
			end
		end
	end
	if self.下拉状态 == false then
		for ns=1,2 do
			self.材料[ns]:置坐标(self.x - 25 + (ns * 58),self.y+105)
			self.材料[ns]:显示(dt,x,y,self.鼠标)
			if self.材料[ns].物品 ~= nil and self.材料[ns].焦点 then
				tp.提示:道具行囊(x,y,self.材料[ns].物品)
				if mouseb(0) and self.鼠标 then
					if 取物品数量() < 160 then
						if self.材料[ns].物品.可叠加 then
							增加物品(self.材料[ns].物品,nil,self.材料[ns].物品.数量,self.道具位置[ns])
						else
						    增加物品(self.材料[ns].物品,nil,nil,self.道具位置[ns])
						end
						if ns == 1 then
							self.材料1总价 = 0
						else
							self.材料2总价 = 0
						end
						self.材料[ns]:置物品(nil)
					else
						tp.常规提示:打开("#Y/包裹已满。请及时清理")
					end
					break
				end
			end
			if self.材料[ns].焦点 then
				self.焦点 = true
			end
		end
	end
	if self.材料[1].物品 ~= nil and self.材料[2].物品 ~= nil then
		local zj = self.总价
		if self.随身 == true then
			zj = floor(zj * 0.8)
		end
		zts:置颜色(tos(zj))
		zts:显示(self.x + 85,self.y + 183,zj)
		zts:置颜色(蓝色)
		zts:显示(self.x + 85,self.y + 233,self.消耗体力)
	end
end

function 场景类_打造:检查点(x,y)
	local n = false
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		n  = true
	end
	return n
end

function 场景类_打造:初始移动(x,y)
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

function 场景类_打造:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end


return 场景类_打造
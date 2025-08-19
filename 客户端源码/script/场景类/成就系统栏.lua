--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 14:02:05
--============================,==========================================--
local 场景类_成就系统栏 = class()

local qmx = 引擎.取模型
local zts,zts1,tp
local insert = table.insert

function 场景类_成就系统栏:初始化(根)
	self.ID = 13
	self.x = 135
	self.y = 60
	self.xx = 0
	self.yy = 0
	self.注释 = "成就系统栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = require("gge文字类").创建("wdf/font/hkyt.ttf",14,false,false,true):置行间距(1)
	zts1 = tp.字体表.描边字体
	zts2 = tp.字体表.普通字体____
end

function 场景类_成就系统栏:打开()
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		self.分类 = nil
		return
	else
		insert(tp.窗口_,self)
		self.分类 = 1
		self:加载数据()
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end

function 场景类_成就系统栏:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 自适应.创建(0,1,600,500,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
		[3] = 自适应.创建(2,1,97,97,3,9),
		[4] = 自适应.创建(1,1,596,18,1,3,nil,18),
		[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",1153796395),--书铁
		[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE6490543),
		[7] = 自适应.创建(9,1,250,50,3,9),
		[8] = 资源:载入('登陆资源.wdf',"网易WDF动画",1387446262),--宝石
		[9] = 资源:载入('物品图标.wdf',"网易WDF动画",0xDF37C485),--三界悬赏令
		[10] = 资源:载入('登陆资源.wdf',"网易WDF动画",4271545734),--鬼谷子
		[11] = 资源:载入('登陆资源.wdf',"网易WDF动画",211127435),--宝图
		[12] = 资源:载入('物品图标.wdf',"网易WDF动画",0xEAA6AD2E),--帮派银票
		[13] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF5601CC2),--镇妖塔
		[14] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x2E0BA3E2),--已达成
		[15] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x900D7019)--加油
		}
		self.资源组2 = {
		[1] =  按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"1页"),
		[2] =  按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"2页"),
		[3] =  按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"3页")
		}
		self.资源组3 = {
		[1] = 资源:载入('物品图标.wdf',"网易WDF动画",0x04EDDEC0),
		[2] = 资源:载入('物品图标.wdf',"网易WDF动画",0xC39E889A),
		[3] = 资源:载入('物品图标.wdf',"网易WDF动画",0xF6001248),
		[4] = 资源:载入('物品图标.wdf',"网易WDF动画",0x087F188A),
		[5] = 资源:载入('物品图标.wdf',"网易WDF动画",0x09A396DF),
		[6] = 资源:载入('物品图标.wdf',"网易WDF动画",0x081E1FF5),
		[7] = 资源:载入('物品图标.wdf',"网易WDF动画",0x05A560CE),
		}


end

function 场景类_成就系统栏:显示(dt,x,y)
	self.资源组2[1]:更新(x,y,self.分类 ~= 1)
	self.资源组2[2]:更新(x,y,self.分类 ~= 2)
	self.资源组2[3]:更新(x,y,self.分类 ~= 3)
	local cj = tp.成就
	self.焦点 = false
	self.资源组[2]:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
		return false
	elseif self.资源组2[1]:事件判断() then
	    self.分类 = 1
	elseif self.资源组2[2]:事件判断() then
	    self.分类 = 2
	elseif self.资源组2[3]:事件判断() then
	    self.分类 = 3
	end
	if cj.成就数据.完成桃园==nil then
	cj.成就数据.完成桃园=0
	end
	if cj.成就数据.大海龟==nil then
	cj.成就数据.大海龟=0
	end
    if cj.成就数据.商人鬼魂==nil then
	cj.成就数据.商人鬼魂=0
	end
	if cj.成就数据.野猪==nil then
	cj.成就数据.野猪=0
	end
    if cj.成就数据.酒肉和尚==nil then
	cj.成就数据.酒肉和尚=0
	end
	if cj.成就数据.抓鬼==nil then
	cj.成就数据.抓鬼=0
	end
	if cj.成就数据.师门==nil then
	cj.成就数据.师门=0
	end
	if cj.成就数据.押镖==nil then
	cj.成就数据.押镖=0
	end
	if cj.成就数据.挖宝==nil then
	cj.成就数据.挖宝=0
	end
	if cj.成就数据.官职==nil then
	cj.成就数据.官职=0
	end
    if cj.成就数据.真刘洪==nil then
	cj.成就数据.真刘洪=0
	end
	if cj.成就数据.大战心魔==nil then
	cj.成就数据.大战心魔=0
	end
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[4]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[3]:显示(self.x+self.资源组[1].宽度/2-52,self.y+2)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-22,self.y+2,"成就栏")
	self.资源组[2]:显示(self.x + 579,self.y + 2)
	zts1:置字间距(0)
    if self.分类 == 1 then
	self.资源组[7]:显示(self.x+30,self.y+42)
	self.资源组[6]:显示(self.x + 30,self.y + 42)
	self.资源组3[1]:显示(self.x+30,self.y+42)
	self.资源组[7]:显示(self.x+30,self.y+102)
	self.资源组[6]:显示(self.x + 30,self.y + 102)
	self.资源组3[3]:显示(self.x + 30,self.y + 102)
	self.资源组[7]:显示(self.x+320,self.y+42)
	self.资源组[6]:显示(self.x + 320,self.y + 42)
	self.资源组3[2]:显示(self.x + 322,self.y + 46)
	self.资源组[7]:显示(self.x+320,self.y+102)
	self.资源组[6]:显示(self.x + 320,self.y + 102)
	self.资源组3[4]:显示(self.x + 322,self.y + 106)
    self.资源组[7]:显示(self.x+30,self.y+162)
	self.资源组[6]:显示(self.x + 30,self.y + 162)
	self.资源组3[5]:显示(self.x + 30,self.y + 164)
	self.资源组[7]:显示(self.x+30,self.y+222)
	self.资源组[6]:显示(self.x + 30,self.y + 222)
	self.资源组3[6]:显示(self.x + 30,self.y + 222)
    self.资源组[7]:显示(self.x+30,self.y+282)
	self.资源组[6]:显示(self.x + 30,self.y + 282)
	self.资源组3[7]:显示(self.x + 30,self.y + 282)


	self.资源组[7]:显示(self.x+320,self.y+162)
	self.资源组[6]:显示(self.x + 320,self.y + 162)
	self.资源组[9]:显示(self.x + 320,self.y + 162)
	self.资源组[7]:显示(self.x+320,self.y+222)
	self.资源组[6]:显示(self.x + 320,self.y + 222)
	self.资源组[12]:显示(self.x + 320,self.y + 222)
	self.资源组[7]:显示(self.x+320,self.y+282)
	self.资源组[6]:显示(self.x + 320,self.y + 282)
	self.资源组[10]:显示(self.x + 320,self.y + 282)
	self.资源组[7]:显示(self.x+320,self.y+342)
	self.资源组[6]:显示(self.x + 320,self.y + 342)
	self.资源组[11]:显示(self.x + 320,self.y + 342)
	self.资源组[7]:显示(self.x+320,self.y+402)
	self.资源组[6]:显示(self.x + 320,self.y + 402)
	self.资源组[13]:显示(self.x + 320,self.y + 402)
	zts1:置颜色(白色)
	zts2:置颜色(白色)
	zts2:显示(self.x + 90,self.y + 55,"【初入桃源村】\n完成桃源村系列任务")
	--zts1:显示(self.x + 90,self.y + 57,"抓鬼次数"..cj.成就数据.抓鬼次数.."/100次")
	zts2:显示(self.x + 90,self.y + 117,"【商人的鬼魂】\n完成建邺城系列任务")
	zts2:显示(self.x + 90,self.y + 177,"【玄奘的身世上篇】\n完成酒肉和尚系列任务")
	zts2:显示(self.x + 90,self.y + 237,"【玄奘的身世下篇】\n完成刘洪系列任务")
	zts2:显示(self.x + 90,self.y + 297,"【大战心魔】\n完成卷帘大将系列任务")
	zts1:显示(self.x + 90,self.y + 357,"待补")
	zts1:显示(self.x + 90,self.y + 417,"待补")

	zts2:显示(self.x + 380,self.y + 55,"我不是李永生:"..cj.成就数据.大海龟.."/100次\n获得【大海龟杀手】")
	zts2:显示(self.x + 380,self.y + 117,"猪猪大作战:"..cj.成就数据.野猪.."/100次\n获得【荒漠屠夫】")
	zts2:显示(self.x + 380,self.y + 177,"钟馗小帮手:"..cj.成就数据.抓鬼.."/1000次\n获得【僵尸道长】")
	zts2:显示(self.x + 380,self.y + 237,"首席小弟子:"..cj.成就数据.师门.."/1000次\n获得【首席小弟子】")
	zts2:显示(self.x + 380,self.y + 297,"再世镖王:"..cj.成就数据.押镖.."/1000次\n获得【快递小哥】")
	zts2:显示(self.x + 380,self.y + 357,"盗墓笔记:"..cj.成就数据.挖宝.."/1000次\n获得【摸金校尉】")
	zts2:显示(self.x + 380,self.y + 417,"省委书记:"..cj.成就数据.官职.."/1000次\n获得【当代清官】")
    zts:置颜色(黄色)
    zts:显示(self.x + 30,self.y + 472,"当前成就点为："..cj.成就数据.成就点.." （成就点达到相应点数会获得相应的称号，另有隐藏成就自己发现吧）")
    if cj.成就数据.完成桃园 > 0 then
    	self.资源组[14]:显示(self.x + 250,self.y + 40)
    else
    	self.资源组[15]:显示(self.x + 290,self.y + 67)
    end
    if cj.成就数据.商人鬼魂 > 0 then
    	self.资源组[14]:显示(self.x + 250,self.y + 100)
    else
    	self.资源组[15]:显示(self.x + 290,self.y + 130)
    end
    if cj.成就数据.酒肉和尚 > 0 then
    	self.资源组[14]:显示(self.x + 250,self.y + 160)
    else
    	self.资源组[15]:显示(self.x + 290,self.y + 187)
    end
    if cj.成就数据.真刘洪 > 0 then
    	self.资源组[14]:显示(self.x + 250,self.y + 220)
    else
    	self.资源组[15]:显示(self.x + 290,self.y + 244)
    end
     if cj.成就数据.大战心魔 > 0 then
    	self.资源组[14]:显示(self.x + 250,self.y + 280)
    else
    	self.资源组[15]:显示(self.x + 290,self.y + 301)
    end
    if cj.成就数据.大海龟 < 100 then
    	self.资源组[15]:显示(self.x + 565,self.y + 67)
    else
    	self.资源组[14]:显示(self.x + 540,self.y + 40)
    end
    if cj.成就数据.野猪 < 100 then
    	self.资源组[15]:显示(self.x + 565,self.y + 130)
    else
    	self.资源组[14]:显示(self.x + 540,self.y + 100)
    end
    end
   	self.资源组2[1]:显示(self.x+20,self.y+20,true,nil,nil,self.分类 == 1,2)
	self.资源组2[2]:显示(self.x+65,self.y+20,true,nil,nil,self.分类 == 2,2)
	self.资源组2[3]:显示(self.x+110,self.y+20,true,nil,nil,self.分类 == 3,2)
end

function 场景类_成就系统栏:检查点(x,y)
	if self.可视 and  self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_成就系统栏:初始移动(x,y)
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

function 场景类_成就系统栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_成就系统栏
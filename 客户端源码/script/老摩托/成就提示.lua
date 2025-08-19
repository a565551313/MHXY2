--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2023-09-28 15:04:02
--============================,==========================================--
local 场景类_成就提示栏 = class()

local qmx = 引擎.取模型
local zts,zts,tp
local insert = table.insert

function 场景类_成就提示栏:初始化(根)
	self.ID = 107
	self.x = 300
	self.y = 400
	self.xx = 0
	self.yy = 0
	self.注释 = "成就提示栏"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	zts = require("gge文字类").创建("wdf/font/hkyt.ttf",15,false,false,true):置行间距(1)
	self.显示字符=""
	self.显示字符1=""
	self.打开时间 =os.time()
end

function 场景类_成就提示栏:打开(内容)
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		self.显示字符=""
	    self.显示字符1=""
		return
	else
		insert(tp.窗口_,self)
		self:加载数据()
		-- if tp.宠物.模型 ~= nil then
		-- 	local n = qmx(tp.宠物.模型)
		-- 	self.资源组[6] = tp.资源:载入(n[3],"网易WDF动画",n[1])
		-- 	self.资源组[6]:置方向(4)
		-- end
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.显示字符=内容.内容
        self.显示字符1=内容.内容1
        self.打开时间 =os.time()

	end
end

function 场景类_成就提示栏:刷新(内容)
	   self.显示字符=内容.内容
       self.显示字符1=内容.内容1
       self.打开时间 =os.time()
end


function 场景类_成就提示栏:加载数据()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAAAB0013),
			[2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAAAB0014),
			[5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAAAB0015),
			[6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAAAB0016),

	}

end

function 场景类_成就提示栏:显示(dt,x,y)
	self.焦点 = false
	self.资源组[2]:更新()
	self.资源组[5]:更新()
	self.资源组[6]:更新()
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+35,self.y+35)
	self.资源组[5]:显示(self.x+35,self.y+35)
	self.资源组[6]:显示(self.x,self.y)
	zts:置字间距(0)




    zts:置颜色(黑色)
    zts:置颜色(黑色)
    zts:显示(self.x + 140,self.y+35,self.显示字符)
    zts:显示(self.x + 100,self.y+65,self.显示字符1)


    if os.time()-self.打开时间>=5 then
       self:打开()
       return
    end



		-- zts:显示(self.x + 178,self.y + 72,cw.等级)
		-- zts:显示(self.x + 178,self.y + 98,cw.耐力.."/"..cw.最大耐力)
		-- zts:显示(self.x + 178,self.y + 122,cw.经验.."/"..cw.最大经验)
	--end
end

function 场景类_成就提示栏:检查点(x,y)
	if self.可视 and  self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_成就提示栏:初始移动(x,y)
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

function 场景类_成就提示栏:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_成就提示栏
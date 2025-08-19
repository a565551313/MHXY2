
local 场景类_组合输入框 = class()

local floor = math.floor
local zts,tp
local insert = table.insert
function 场景类_组合输入框:初始化(根)
	self.ID = 45
	self.x = 200
	self.y = 246
	self.xx = 0
	self.yy = 0
	self.注释 = "组合输入框"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('改名总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("输入",0,0,340,14)
	self.输入框:置可视(false,false)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.窗口时间 = 0
	tp = 根
	zts = 根.字体表.普通字体
	self.类型数值 = 0
end

function 场景类_组合输入框:打开(类型,附加)
	if self.可视 then
		self.回调事件 = nil
		self.类型事件 = nil
		self.输入框:置可视(false,false)
		self.可视 = false
		self.资源组 = nil
		self.类型数值=0
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {
			--[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x675760A4),
			[1] = 自适应.创建(0,1,415,125,3,9),
			[2] = 按钮(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"确定"),
			[3] = 按钮(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"取消"),
			[4] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[5] = 自适应.创建(3,1,345,18,1,3),
			[6] = 自适应.创建(1,1,411,18,1,3,nil,18),
		}
		for i=2,3 do
		    self.资源组[i]:绑定窗口_(45)
		end
		self.输入框:置限制字数(15)
		if 类型 == "创建帮派" then
			self.输入框:置限制字数(14)
		elseif 类型 == "帮派宗旨" then
			self.输入框:置限制字数(150)
	    elseif 类型=="藏宝阁提现" then
	    	self.输入框:置限制字数(9)
			self.输入框:置数字模式()
	    elseif 类型=="存钱" then
	    	self.输入框:置限制字数(15)
			self.输入框:置数字模式()
	    elseif 类型=="取钱" then
	    	self.输入框:置限制字数(15)
			self.输入框:置数字模式()
		elseif 类型 == "帮费设置" then
			self.输入框:置限制字数(6)
			self.输入框:置数字模式()
		elseif 类型 == "拆分物品" then
			self.输入框:置限制字数(3)
			self.输入框:置数字模式()
		elseif 类型=="修改分组名称" then
			self.输入框:置限制字数(20)
		end
		self.输入框:置可视(true,true)
		self.回调事件 = 附加
		self.类型事件 = 类型
		self.类型数值=math.floor(string.len(类型)/2)
		tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	end
end


function 场景类_组合输入框:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[6]:显示(self.x+2,self.y+2)
	self.资源组[5]:显示(self.x+36,self.y+68)
    if self.类型数值>0 and self.类型数值<=10 then
       tp.窗口标题背景_[self.类型数值]:显示(self.x+self.资源组[1].宽度/2-tp.窗口标题背景_[self.类型数值].宽度/2,self.y+2)
       zts:置颜色(白色)
       zts:置字间距(3)
       zts:显示(self.x+self.资源组[1].宽度/2-(tp.窗口标题背景_[self.类型数值].宽度/2-30),self.y+3,self.类型事件)
       zts:置字间距(0)
    end
	zts:置颜色(self.回调事件[2])
	zts:显示(self.x+36,self.y+38,self.回调事件[1])
	self.控件类:更新(dt,x,y)
	self.控件类:显示(dt,x,y)
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y)
	self.资源组[4]:更新(x,y)
	if self.资源组[2]:事件判断() then
		if self.类型事件 == "创建帮派" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您要创建的帮派名称！")
			elseif string.len(self.输入框:取文本()) <= 4  then
				tp.常规提示:打开("#Y/最低帮派名称不能少于3个字符！")
			else
				请求服务(6101,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "帮派宗旨" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您要修改的帮派宗旨！")
			elseif string.len(self.输入框:取文本()) <= 2  then
				tp.常规提示:打开("#Y/最低帮派名称不能少于1个字符！")
			else
				请求服务(6105,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end

		elseif self.类型事件 == "改名" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您要修改的名字！")
			elseif string.len(self.输入框:取文本()) <= 2  then
				tp.常规提示:打开("#Y/最低名称不能少于1个字符！")
			else
				请求服务(3776,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "输入安全码" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您的安全码！")
			else
				请求服务(3777,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end

		elseif self.类型事件 == "帮费设置" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您的需要设置的帮费金额！")
			elseif string.len(self.输入框:取文本()) > 6  then
				tp.常规提示:打开("#Y/帮费金额不能大于99W哦")
			else
				请求服务(6115,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
		elseif self.类型事件 == "帮派竞赛报名" then
			if self.输入框:取文本() == "" then
				tp.常规提示:打开("#Y/请输入您要报名的费用！")
			elseif string.len(self.输入框:取文本()) <= 5  then
				tp.常规提示:打开("#Y/最低报名费用不能低于50W或帮派名称错误")
			elseif self.输入框:取文本()<"500000" then
				tp.常规提示:打开("#Y/最低报名费用不能低于50W或帮派名称错误")
			else
				请求服务(42,{文本=self.输入框:取文本()})
				self:打开()
				return false
			end
	    elseif self.类型事件 == "藏宝阁提现" then
			if self.输入框:取文本() == "" then
			 	tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) < 1 then
				tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) > tonumber(self.回调事件[3]) then
				tp.常规提示:打开("#Y/输入的数额错误")
			else
				请求服务(69,{类型=self.回调事件[4],文本="藏宝阁提现",数量=tonumber(self.输入框:取文本())})
				self:打开()
				return false
			end
	    elseif self.类型事件 == "存钱" then
			if self.输入框:取文本() == "" then
			 	tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) < 1 then
				tp.常规提示:打开("#Y/输入的数额错误")
			  elseif tonumber(self.输入框:取文本()) > tonumber(self.回调事件[3]) then
				tp.常规提示:打开("#Y/输入的数额错误")
			else
				请求服务(60,{文本="存钱",数额=tonumber(self.输入框:取文本())})
				self:打开()
				return false
			end
        elseif self.类型事件 == "取钱" then
			if self.输入框:取文本() == "" then
			 	tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) < 1 then
				tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) > tonumber(self.回调事件[3]) then
				tp.常规提示:打开("#Y/输入的数额错误")
			else
				请求服务(60,{文本="取钱",数额=tonumber(self.输入框:取文本())})
				self:打开()
				return false
			end
		elseif self.类型事件 == "拆分物品" then
			if self.输入框:取文本() == "" then
			 	tp.常规提示:打开("#Y/请输入需要拆分的数量！")
			 elseif tonumber(self.输入框:取文本()) < 1 then
				tp.常规提示:打开("#Y/输入的数额错误")
			 elseif tonumber(self.输入框:取文本()) >= tonumber(self.回调事件[3]) then
				tp.常规提示:打开("#Y/输入的数额错误")
			else
				请求服务(3741,{数量=tonumber(self.输入框:取文本())})
				self:打开()
				return false
			end
		elseif self.类型事件 == "修改分组名称" then
			if self.输入框:取文本() == "" then
			 	tp.常规提示:打开("#Y/名称不能为空")
			else
				请求服务(17,{编号=self.回调事件[3],名称=self.输入框:取文本()})
				self:打开()
				return false
			end




		end
	elseif self.资源组[3]:事件判断() then
		self:打开()
		return false
    elseif self.资源组[4]:事件判断() then
		self:打开()
		return false
	end
	self.资源组[2]:显示(self.x+275,self.y+97)
	self.资源组[3]:显示(self.x+350,self.y+97)
	self.资源组[4]:显示(self.x+395,self.y+2)
	self.输入框:置坐标(self.x + 47,self.y + 71)
	if self.输入框._已碰撞 then
		self.焦点 = true
	end
end

function 场景类_组合输入框:检查点(x,y)
	if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_组合输入框:初始移动(x,y)
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

function 场景类_组合输入框:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_组合输入框
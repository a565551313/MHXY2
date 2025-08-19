local 场景类_帮派申请类 = class()
local insert = table.insert
local tp
local mousea = 引擎.鼠标按住
local mouseb = 引擎.鼠标弹起
local bw = require("gge包围盒")(0,0,240,20)
local box = 引擎.画矩形
function 场景类_帮派申请类:初始化(根)
	self.ID = 81
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "帮派申请类"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.本类进程 = 1
	tp = 根
	zts = tp.字体表.普通字体___
	zts2 = tp.字体表.普通字体__
	zts1 = tp.字体表.普通字体
	self.窗口时间 = 0
	self.加入 = 0
	self.选中 = 0
	self.丰富文本 =  require("script/系统类/丰富文本")(300,105)
end

function 场景类_帮派申请类:打开(数据)

	if self.可视 then
		self.可视 = false
		self.帮派数据 = nil
		self.加入 = 0
		self.选中 = 0
		self.资源组 = nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应
		self.资源组 = {

			[1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x10000095), --申请面板
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true), --关闭
			[3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"加入帮派"),
			[4] = 按钮.创建(自适应.创建(20,4,18,19,4,3),0,0,4,true,true),--上滚动
			[5] = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true),--下滚动
			[6] =  tp._滑块.创建(自适应.创建(11,4,7,40,2,3,nil),1,14,65,2),
		}
		for n=2,6 do
		    self.资源组[n]:绑定窗口_(81)
		end
		self.加入 = 0
		self.选中 = 0
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.帮派数据 = 数据
	    if #self.帮派数据>5 then
		    self.资源组[6]:置高度(math.min(math.floor(60/(#self.帮派数据-5)),65))
		end
		self.资源组[6]:置起始点(0)
	end
end

function 场景类_帮派申请类:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x+120,self.y+100)
	local 帮派总数 = #self.帮派数据
	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.选中 ~= 0)

	self.资源组[4]:更新(x,y,self.加入 > 0)
	self.资源组[5]:更新(x,y,self.加入 < 帮派总数 - 5)

	tp.画线:置区域(0,0,15,125)--滑块虚线
	tp.画线:显示(self.x+405,self.y+155)



	if 帮派总数 > 5  then
		self.加入 = math.min(math.ceil((帮派总数-5)*self.资源组[6]:取百分比()),帮派总数-5)
	 	self.资源组[6]:显示(self.x+406,self.y+200,x,y,self.鼠标)
	end
	for i =1 ,5 do
		if self.帮派数据[i+self.加入] ~= nil then
			bw:置坐标(self.x+155,self.y+138+i*22)
			if self.选中 ~= self.加入 + i then
				if bw:检查点(x,y) then  --375 110
					box(self.x + 150,self.y + 135 + i * 22,self.x + 388,self.y + 158 + i * 22,-3551379)
					if mouseb(0) then
						self.选中 = self.加入 + i
						self.丰富文本:清空()
						self.丰富文本:添加文本(self.帮派数据[self.选中].公告)
						self.焦点=true
					end
				end
			else
				box(self.x + 150,self.y + 135 + i * 22,self.x + 388,self.y + 158 + i * 22,-9670988)
			end
			zts:显示(self.x+155,self.y+138+i*22,self.帮派数据[i+self.加入].帮派名称)
			zts:显示(self.x+295,self.y+138+i*22,self.帮派数据[i+self.加入].编号)
			zts:显示(self.x+380,self.y+138+i*22,self.帮派数据[i+self.加入].规模)
		end
	end







	if self.选中 ~= 0 then
		local m = 0
		for i , v in pairs(self.帮派数据[self.选中].管理数据) do
			m = m + 1
			if self.帮派数据[self.选中].管理数据[i] ~= nil then
				if self.帮派数据[self.选中].管理数据[i].是否在线 then
					zts1:置颜色(绿色)
				else
				    zts1:置颜色(黑色)
				end
				zts1:显示(self.x+438,self.y+138+m*22,self.帮派数据[self.选中].管理数据[i].名称)
				zts1:显示(self.x+568,self.y+138+m*22,i)
			end
		end
		zts:显示(self.x+150,self.y+330,"帮主名称: "..self.帮派数据[self.选中].帮派名称)
		zts:显示(self.x+150,self.y+355,"创建日期: "..os.date("%Y", self.帮派数据[self.选中].创建时间).. "年"..os.date("%m", self.帮派数据[self.选中].创建时间).. "月" .. os.date("%d", self.帮派数据[self.选中].创建时间).."日")
		zts:显示(self.x+330,self.y+355,"帮派规模: "..self.帮派数据[self.选中].规模)
		zts:显示(self.x+150,self.y+380,"帮派人数: "..self.帮派数据[self.选中].帮派人数.当前.."/"..self.帮派数据[self.选中].帮派人数.上限)
		zts:显示(self.x+330,self.y+380,"帮派费用: "..self.帮派数据[self.选中].帮派费用.."/周")
		zts:显示(self.x+150,self.y+405,"公告:")
		self.丰富文本:显示(self.x+190,self.y+405)
	end


	if self.资源组[6].接触 then
		self.焦点 = true
	end
	if self.资源组[2]:事件判断() then
		self:打开()
		return 0
	elseif self.资源组[3]:事件判断() then
		if self.选中 == 0 then
			tp.常规提示:打开("#Y/请选择你要申请的帮派!")
		else
			  请求服务(6103,{帮派序号=self.选中})
		end
	elseif self.资源组[4]:事件判断() and self.加入 >0 then
			self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入 -1,0,帮派总数-5))
	elseif self.资源组[5]:事件判断() and 帮派总数 > 5 and self.加入+5<帮派总数 then
			self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入+1,0,帮派总数-5))
	elseif self.资源组[1]:是否选中(x,y) and 引擎.取鼠标滚轮() ==1 and self.加入 > 0 then--鼠标上滚动
			self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入 -1,0,帮派总数-5))
	elseif self.资源组[1]:是否选中(x,y) and 引擎.取鼠标滚轮() ==-1 and 帮派总数 > 5 and self.加入+5<帮派总数 then--鼠标下滚动
				self.资源组[6]:置起始点(self.资源组[6]:取百分比转换(self.加入+1,0,帮派总数-5))




	end
	self.资源组[2]:显示(self.x+650,self.y+105)
	self.资源组[3]:显示(self.x+570,self.y+482)
	self.资源组[4]:显示(self.x+400,self.y+155)
	self.资源组[5]:显示(self.x+400,self.y+263)
end

function 场景类_帮派申请类:检查点(x,y)
	if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 场景类_帮派申请类:初始移动(x,y)
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

function 场景类_帮派申请类:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 场景类_帮派申请类
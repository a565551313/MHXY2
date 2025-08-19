
local 战斗排行框 = class()
local tp
local bw = require("gge包围盒")(0,0,19,19)

function 战斗排行框:初始化(根)
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应= 根._自适应
	self.x=2
	self.y=100
	self.精灵组框 = 自适应.创建(6,1,1,1,3,9)
	self.精灵组框:置宽高(170,220)
	self.关闭 = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true)
	self.隐藏 = true
	self.移动 = false
	tp = 根
	bw:置坐标(self.x+150,self.y+2)
	zts = tp.字体表.排行字体
end


function 战斗排行框:更新(dt)end

function 战斗排行框:刷新数据(内容)
	self.数据 = 内容
end

function 战斗排行框:显示(dt,x,y)
	self.关闭:更新(x,y)
	self.精灵组框:显示(self.x,self.y)
	self.关闭:显示(self.x+150,self.y+2)
	zts:置颜色(红色)
	zts:显示(self.x+5,self.y+5,"队长名称     造成伤害")
	zts:置颜色(绿色)
	if self.数据 ~= nil then
		for i=1,#self.数据 do
		    if self.数据[i] ~= nil then
		    	zts:显示(self.x+5,self.y+10+i*20,self.数据[i].名称.."      "..self.数据[i].伤害)
		    end
		end
	end
	zts:置颜色(白色)
	if bw:检查点(x,y) and 引擎.鼠标弹起(左键) and not self.隐藏 then
		self.隐藏 = true
	end
end

return 战斗排行框
-- @Author: 此套源码仅供学习研究使用,严禁其他非法用途,否则后果自负!
-- @Date:   2021-11-12 22:31:27
-- @Last Modified by:   作者QQ381990860
-- @Last Modified time: 2025-01-23 22:19:27

local 师门选择 = class()
local floor = math.floor
local tp,zts,zt,zts10
local format = string.format
local insert = table.insert

function 师门选择:初始化(根)
    self.x = 134
    self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "师门选择"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	self.窗口时间 = 0
	zts = tp.字体表.签到字体
	zt = tp.字体表.签到字体
    zts10 = tp.字体表.排行字体
    self.进程=1

	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('序号控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("卡号输入",0,0,180,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(30)
	self.输入框:屏蔽快捷键(true)
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)

	self.数量框 = 总控件:创建输入("数量输入",0,0,180,14)
	self.数量框:置可视(false,false)
	self.数量框:置限制字数(10)
	self.数量框:置数字模式()
	self.数量框:屏蔽快捷键(true)
	self.数量框:置光标颜色(-16777216)
	self.数量框:置文字颜色(-16777216)

end

function 师门选择:打开(数据)
	if self.可视 then
		self.可视 = false
		self.资源组=nil
		return
	else
		insert(tp.窗口_,self)
		local 资源 = tp.资源
		local 按钮 = tp._按钮
		local 自适应 = tp._自适应

		self.资源组 = {
            [0] = 自适应.创建(1,1,646,18,1,3,nil,18),
			[1] = 自适应.创建(0,1,650,440,3,9),
            [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true), --关闭按钮
            [3] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"天命门派"),
            [4] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"奇遇门派"),
            [5] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000120),0,0,4,true,true),
            [6] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000121),0,0,4,true,true),
            [7] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000122),0,0,4,true,true),
            [8] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000123),0,0,4,true,true),
            [9] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000124),0,0,4,true,true),

            [10] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000125),0,0,4,true,true),
            [11] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000126),0,0,4,true,true),
            [12] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000127),0,0,4,true,true),
            [13] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000128),0,0,4,true,true),
            [14] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000129),0,0,4,true,true),

            [15] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000130),0,0,4,true,true),
            [16] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000131),0,0,4,true,true),
            [17] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000132),0,0,4,true,true),
            [18] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000133),0,0,4,true,true),
            [19] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000134),0,0,4,true,true),

            [20] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000135),0,0,4,true,true),
            [21] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000136),0,0,4,true,true),
            [22] = 按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000137),0,0,4,true,true),
            [23] = 资源:载入(wdf配置.."/pic/mp/大唐官府.png", "图片"),
            [24] = 资源:载入(wdf配置.."/pic/mp/化生寺.png", "图片"),
            [25] = 资源:载入(wdf配置.."/pic/mp/方寸山.png", "图片"),
            [26] = 资源:载入(wdf配置.."/pic/mp/神木林.png", "图片"),
            [27] = 资源:载入(wdf配置.."/pic/mp/天机城.png", "图片"),
            [28] = 资源:载入(wdf配置.."/pic/mp/女儿村.png", "图片"),
            [29] = 资源:载入(wdf配置.."/pic/mp/狮驼岭.png", "图片"),
            [30] = 资源:载入(wdf配置.."/pic/mp/魔王寨.png", "图片"),
            [31] = 资源:载入(wdf配置.."/pic/mp/阴曹地府.png", "图片"),
            [32] = 资源:载入(wdf配置.."/pic/mp/无底洞.png", "图片"),
            [33] = 资源:载入(wdf配置.."/pic/mp/女魃墓.png", "图片"),
            [34] = 资源:载入(wdf配置.."/pic/mp/盘丝洞.png", "图片"),
            [35] = 资源:载入(wdf配置.."/pic/mp/天宫.png", "图片"),
            [36] = 资源:载入(wdf配置.."/pic/mp/龙宫.png", "图片"),
            [37] = 资源:载入(wdf配置.."/pic/mp/五庄观.png", "图片"),
            [38] = 资源:载入(wdf配置.."/pic/mp/凌波城.png", "图片"),
            [39] = 资源:载入(wdf配置.."/pic/mp/花果山.png", "图片"),
            [40] = 资源:载入(wdf配置.."/pic/mp/普陀山.png", "图片"),
            [41] = 资源:载入('新界面.wdf',"网易WDF动画",0x00000005),---深色长条
            [42] = 按钮.创建(tp.资源:载入('新界面.wdf',"网易WDF动画",0x00000050),0,0,4,true,true),---蓝色按钮
            [43] = 按钮.创建(tp.资源:载入('新界面.wdf',"网易WDF动画",0x00000063),0,0,4,true,true),---红色按钮
            [44]=按钮.创建(自适应.创建(12,4,43,22,1,3),0,0,4,true,true,"体验"),
            [45]=按钮.创建(tp.资源:载入('门派界面.wdf',"网易WDF动画",0x00000119),0,0,4,true,true),




        }
self.加入=0
    for n=44,44 do
      --  self.资源组[n]:置偏移(6,0)
    end

        self.数据=数据
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
        self.进程=1
        self.信息=1


    end
end

function 师门选择:刷新(数据)
    --self.数据.信息 = 数据


end

function 师门选择:显示(dt,x,y)
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[2]:更新(x,y)
    self.资源组[3]:更新(x,y)
    self.资源组[4]:更新(x,y)
    self.资源组[5]:更新(x,y,self.进程 ~= 1)
    self.资源组[6]:更新(x,y,self.进程 ~= 2)
    self.资源组[7]:更新(x,y,self.进程 ~= 3)
    self.资源组[8]:更新(x,y,self.进程 ~= 4)
    self.资源组[9]:更新(x,y,self.进程 ~= 5)
    self.资源组[10]:更新(x,y,self.进程 ~= 6)
    self.资源组[11]:更新(x,y,self.进程 ~= 7)
    self.资源组[12]:更新(x,y,self.进程 ~= 8)
    self.资源组[13]:更新(x,y,self.进程 ~= 9)
    self.资源组[14]:更新(x,y,self.进程 ~= 10)
    self.资源组[15]:更新(x,y,self.进程 ~= 11)
    self.资源组[16]:更新(x,y,self.进程 ~= 12)
    self.资源组[17]:更新(x,y,self.进程 ~= 13)
    self.资源组[18]:更新(x,y,self.进程 ~= 14)
    self.资源组[19]:更新(x,y,self.进程 ~= 15)
    self.资源组[20]:更新(x,y,self.进程 ~= 16)
    self.资源组[21]:更新(x,y,self.进程 ~= 17)
    self.资源组[22]:更新(x,y,self.进程 ~= 18)
    self.资源组[42]:更新(x,y)
    self.资源组[43]:更新(x,y)
    self.资源组[2]:显示(self.x+self.资源组[1].宽度-20,self.y+3)
     self.资源组[0]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-55,self.y)
    zts10:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"师门选择")
    self.资源组[3]:显示(self.x+15,self.y+35)
    self.资源组[4]:显示(self.x+100,self.y+35)
    self.资源组[41]:显示(self.x+340,self.y+35)
    self.资源组[41]:显示(self.x+495,self.y+35)
    self.资源组[42]:显示(self.x+460,self.y+35)
    self.资源组[43]:显示(self.x+614,self.y+35)
    zts:置颜色(白色):显示(self.x+350,self.y+38,"种族")
    zts:置颜色(白色):显示(self.x+505,self.y+38,"性别")
    zts:置颜色(白色):显示(self.x+165,self.y+63,"            等级上限为    级，无法转入奇遇门派，更多详见_梦幻门派!")
    zts:置颜色(绿色):显示(self.x+237,self.y+63,"            175")
    --zts:置颜色(白色):显示(self.x+477,self.y+63,"     梦幻门派")
    --5 22
    if 引擎.取鼠标滚轮()<0 then
       self.加入=(self.加入+1>18-5 and self.加入) or self.加入+1
    elseif 引擎.取鼠标滚轮()>0 then
       self.加入=(self.加入-1>=0 and self.加入-1) or self.加入
    end
    local yyy = 0
    for n=1,5 do
        yyy=n
        n=n+self.加入+4
        self.资源组[n]:显示(self.x + 15,self.y +  yyy* 65 +27)
        if self.资源组[n]:事件判断() then
           self.进程=yyy+self.加入
         --  print(self.进程)
        end
    end

    if self.资源组[2]:事件判断() then
         self:打开()
       return false
    end





if self.进程 == 1 then

    self.资源组[23]:显示(self.x+148,self.y+85)
    self.资源组[45]:显示(self.x+400,self.y+390)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=1})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 2 then
     self.资源组[24]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=2})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 3 then
     self.资源组[25]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=3})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        ----self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 4 then
     self.资源组[26]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=4})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 5 then
     self.资源组[27]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=5})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 6 then
     self.资源组[28]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=6})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 7 then
     self.资源组[29]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=7})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 8 then
     self.资源组[30]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=8})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 9 then
     self.资源组[31]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=9})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 10 then
     self.资源组[32]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=10})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 11 then
     self.资源组[33]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=11})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 12 then
     self.资源组[34]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=12})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 13 then
     self.资源组[35]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=13})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 14 then
     self.资源组[36]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=14})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 15 then
     self.资源组[37]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=15})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 16 then
     self.资源组[38]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=16})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 17 then
     self.资源组[39]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
   if self.资源组[45]:事件判断() then
    请求服务(102,{参数=17})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
if self.进程 == 18 then
     self.资源组[40]:显示(self.x+148,self.y+85)
    --self.资源组[44]:更新(x,y)
    self.资源组[45]:更新(x,y)
    self.资源组[45]:显示(self.x+400,self.y+390)
    if self.资源组[45]:事件判断() then
    请求服务(102,{参数=18})
    end
    local xx = 0
    local yy = 1
    for n=1,3 do
        --self.资源组[44]:显示(self.x + xx * 62 + 553,self.y + yy * 70 +125)
    xx = xx + 1
        if xx >= 1 then
            xx = 0
            yy = yy + 1
        end
    end
    return
end
end


function 师门选择:检查点(x,y)
    if self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
        return true
    end
end

function 师门选择:初始移动(x,y)
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

function 师门选择:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end

return 师门选择
--======================================================================--
--	☆ 作者：飞蛾扑火 QQ：1415559882
--======================================================================--
local 场景类_分区 = class()
local tp


function 场景类_分区:初始化(根)--
	local 资源 = 根.资源

	self.标题背景 = 资源:载入("登陆资源.wdf","网易WDF动画",0xD8632D28)--899E213B  --分区背景
    self.大分区 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xD330CE3F)
    self.大分区选中 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF5674AFF)
    self.小分区= 资源:载入('登陆资源.wdf',"网易WDF动画",0xBD57A592)
	self.上一步 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D29),0,0,3,true,true)
	self.退出游戏 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D22),0,0,3,true,true)
	self.进入游戏 = 根._按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD8632D21),0,0,3,true,true) --下一步
	self.默认背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xBD57A592)
	self.选择服务器  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000027),0,0,3,true,true)
	self.服务器状态2  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000022),0,0,3,true,true)
	self.角色所在服务器  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000016),0,0,3,true,true)
	self.图1标  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000020),0,0,3,true,true)
	self.图2标  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000021),0,0,3,true,true)
	self.选择背景3  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000026),0,0,3,true,true)
	self.大区背景  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000024),0,0,3,true,true)
	self.分区背景  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000025),0,0,3,true,true)
	self.右边分区1 = 资源:载入('界面修复.wdf',"网易WDF动画",0x0E3A7EE6)
	self.右边分区2 = 资源:载入('界面修复.wdf',"网易WDF动画",0xFB057B3D)--红色动态
	self.默认服务器 = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000018),0,0,3,true,true)
	self.网络默认  = 根._按钮(资源:载入('界面修复.wdf',"网易WDF动画",0x00000038),0,0,3,true,true)
	self.默认 = 资源:载入('界面修复.wdf',"网易WDF动画",0x2E588160)
	self.默认X = 资源:载入('界面修复.wdf',"网易WDF动画",0x19243A82)


	tp = 根
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
    self.临时计次O=0
    --================
    self.大分区按钮事件 = 1
    self.小分区按钮事件 = 0
	local file1=分区内容()
	local servertype = 分割文本(file1, "\n")
	self.大分区OL = {}
	self.小分区OL = {}
	self.大分区分类 = {}
	self.小分区分类 = {}
	self.小分区分类背景 = {}
	for n = 1, #servertype do
		local typeA = 分割文本(servertype[n], " ")
		if #typeA == 2 then
		    n = 按钮.创建(自适应.创建(31,4,65,22,1,3),0,0,4,true,true,typeA[2])
		    table.insert(self.大分区OL,n)
		    n={tonumber(typeA[1]),typeA[2]}
		    table.insert(self.大分区分类,n)
		elseif #typeA == 5 then--梦幻的是18
		    n = 按钮.创建(自适应.创建(32,4,65,22,1,3),0,0,4,true,true,typeA[3])
		    table.insert(self.小分区OL,n)
		    n={tonumber(typeA[1]),tonumber(typeA[2]),typeA[3],typeA[4],tonumber(typeA[5])}
		    table.insert(self.小分区分类,n)
		    n=资源:载入('登陆资源.wdf',"网易WDF动画",0xBD57A592) -----------------------------------------------
		    table.insert(self.小分区分类背景,n)
		end
	end
	self.服务器数据={}
	for n=1,#self.小分区分类 do
		self.服务器数据[n]={mc=self.小分区分类[n][3],状态=1,x=0,y=0,背景=0,ip=self.小分区分类[n][4],dk=self.小分区分类[n][5]}
	end
		for n=2,#self.小分区分类 do
		self.服务器数据[n]={mc=self.小分区分类[n][3],状态=1,x=0,y=0,背景=0,ip=self.小分区分类[n][4],dk=self.小分区分类[n][5]}
	end

end






function 场景类_分区:显示(dt,x,y)
	if tp.进程 == 8 then
		引擎.置标题(全局游戏标题.."- 请选择分区")
		self.上一步:更新(x,y)
		self.右边分区1:更新(x,y)
		for n = 1, #self.大分区OL do
			self.大分区OL[n]:更新(x,y)
			self.大分区OL[n].偏移x = -3
		end
		for n = 1, #self.小分区OL do
			self.小分区OL[n]:更新(x,y)
			self.小分区OL[n].偏移x = -3
		end
        self.临时计次O=self.临时计次O+1
        if self.临时计次O==6 then
            self.右边分区2:更新(x,y)
            self.临时计次O=0
        end
		self.退出游戏:更新(x,y)
		if self.进入游戏:事件判断() then
			引擎.置新标题(全局游戏标题)
			tp.进程 = 7
		elseif self.上一步:事件判断() then
			tp.进程 = 1
		elseif self.退出游戏:事件判断() then
		tp.进程 = 7
			-- 引擎关闭开始()
			-- return false
		end
        local msgq宽度 = 800/2
        local msgq高度 = 600/2
         self.服务器状态2:显示(660,80+45)
        self.右边分区2:显示(msgq宽度+275,msgq高度-10)--新区动画
        self.网络默认:显示(msgq宽度+275,msgq高度-10+55)
		self.标题背景:显示(msgq宽度-255-55-92+73,msgq高度-196+30)



		for i=1,7 do
             self.大区背景:显示(40-25+i*70,90+58)
            for n=1,9 do
                 self.大区背景:显示(40-25+i*70,61+58+29+n*29)
            end
        end
        for a=1,7 do
            for b=1,2 do
                self.分区背景:显示(40-26+a*70,322+50+45+b*29)
             end
          end
        for c=1,5 do
		self.选择背景3:显示(40+c*70,439+88)
		end
   		self.选择背景3:显示(490,439+88)
        self.角色所在服务器:显示(108-31,405+95)
        self.图1标:显示(105-22,441+88)
        self.图2标:显示(480-22,441+88)
        self.默认服务器:显示(msgq宽度-220+295,405+95)
		self.上一步:显示(800-130,600-260+80+45)
		self.退出游戏:显示(800-130,600-200+124-5)

		for n = 1, #self.大分区OL do
			if self.大分区OL[n]:事件判断() then
			     self.大分区按钮事件 = n
			     全局大分区 = self.大分区分类[n][2]

            end
		end

		local msgq列 = 1
		for n = 1, #self.大分区OL do
			msgq行=服务区取行(n)
			if self.大分区按钮事件==n then
			    self.大分区选中:显示(msgq宽度-384+msgq列*70,msgq高度-180+msgq行*29)
			end
			self.大分区OL[n]:置字体(tp.字体表.普通字体)
			self.大分区OL[n]:显示(msgq宽度-384+msgq列*70,msgq高度-180+msgq行*29,nil,nil,nil,self.大分区按钮事件==n,2)
			if msgq列 ~=7 then
			    msgq列 = msgq列 +1
			elseif msgq列 ==7  then
				msgq列 = 1
			end
		end

		for n = 1, #self.小分区OL do
            if self.大分区按钮事件 == 到整数(self.小分区分类[n][1]) and self.大分区按钮事件 ~= 0 then
	           	local 坐标调整 = 到整数(self.小分区分类[n][2])
	           	local 小区行数 = 1
	           	if 坐标调整 > 7 then
				  	坐标调整 = 坐标调整 - 7
				  	小区行数 = 2
	            end
                self.小分区OL[n]:置字体(tp.字体表.普通字体)
			    self.小分区OL[n]:显示(15+坐标调整*70,418+小区行数*29,nil,122)
			end
		end
		for n = 1, #self.小分区OL do
			if self.小分区OL[n]:事件判断() then
			     self.小分区按钮事件 = n
			     if self.大分区按钮事件 == 到整数(self.小分区分类[n][1]) and self.小分区分类[n][3]~="" then
			        全局小分区 = self.小分区分类[n][3]
		            self.服务器编号=到整数(self.小分区分类[n][1])
		            self.服务器数据[self.服务器编号].名称=全局小分区
			        系统参数.服务器={名称=self.服务器数据[self.服务器编号].mc,ip=self.服务器数据[n].ip,端口=self.服务器数据[n].dk}
			        tp.登陆.账号输入框:置可视(true,true)
			        tp.登陆.密码输入框:置可视(true,true)
			        tp.进程 = 7
			        客户端:连接处理(系统参数.服务器.ip,系统参数.服务器.端口)
			        全局游戏标题=全局大分区
			     end
            end
            self.小分区OL[n]:置字体(tp.字体表.下拉字体)

		end
	end
end





function 服务区取行(n)
	local msgq行 = 1
	if n<=7  then
		msgq行=1
	elseif n<=14 then
		msgq行=2
	elseif n<=21 then
		msgq行=3
	elseif n<=28 then
		msgq行=4
	elseif n<=35  then
		msgq行=5
	elseif n<=42 then
		msgq行=6
	elseif n<=49  then
		msgq行=7
	elseif n<=56  then
		msgq行=8
	elseif n<=63 then
		msgq行=9
	elseif n<=70  then
		msgq行=10
	elseif n<=77  then
		msgq行=11
	elseif n<=84  then
		msgq行=12
	elseif n<=91  then
		msgq行=13
	elseif n<=98  then
		msgq行=14
	end
	return msgq行
end





return 场景类_分区




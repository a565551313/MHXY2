--
local 多角色回收系统 = class()
local tp,zts1,zt
local insert = table.insert
function 多角色回收系统:初始化(根)
	self.ID = 124
	self.x = 170
	self.y = 100
	self.xx = 0
	self.yy = 0
	self.注释 = "多角色回收系统"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	tp = 根
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应

	self.资源组 = {



		-- [1] = 自适应.创建(0,1,260,340,3,9),
		[1] = 自适应.创建(0,1,490,360,3,9),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
		[3] = 自适应.创建(1,1,486,18,1,3,nil,18),--标题背景

		[4] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---兽决
		[5] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---高级兽决
		[6] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---暗器
		[7] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---环装
		[8] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---二级药
		[9] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---五宝
		[10] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---宝石
		[11] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---超级金柳露
		[12] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---书铁



		[13] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---修练果
		[14] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---强化石
		[15] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---月华露
		[16] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---清灵净瓶
		[17] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---九转金丹
		[18] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---低级内丹
        [19] = 按钮.创建(自适应.创建(30,4,26,26,4,1),0,0,5,true,true),---高级内丹



		}

	self.窗口时间 = 0
	self.玩家id = 0
	self.白布背景=自适应.创建(2,1,470,290,3,9)




	zts1 = tp.字体表.标题字体
	zt = tp.字体表.下拉字体
end



function 多角色回收系统:刷新(数据)
    self.玩家id =数据.角色
	if 数据.自动回收~= nil then
		    if   数据.自动回收.兽决==1 then
		       self.低级兽决=true
		    else
		        self.低级兽决=false
		    end
		    if   数据.自动回收.高级兽决==1 then
		       self.高级兽决=true
		    else
		        self.高级兽决=false
		    end
		    if  数据.自动回收.环装==1 then
		       self.环装=true
		    else
		        self.环装=false
		    end

		     if  数据.自动回收.暗器==1 then
		       self.暗器=true
		    else
		        self.暗器=false
		    end
		    if 数据.自动回收.二级药==1 then
		       self.二级药材=true
		    else
		        self.二级药材=false
		    end

		    if  数据.自动回收.五宝==1 then
		    	self.五宝=true
		    else
		        self.五宝=false
		    end
		    if   数据.自动回收.宝石==1 then
		    	self.宝石=true
		    else
		        self.宝石=false
		    end

		    if   数据.自动回收.超级金柳露==1 then
		    	self.超级柳露=true
		    else
		        self.超级柳露=false
		    end
		    if   数据.自动回收.书铁==1 then
		    	self.书铁=true
		    else
		        self.书铁=false
		    end
		     if 数据.自动回收.修练果==1 then
		    	self.修练果=true
		    else
		        self.修练果=false
		    end
		    if 数据.自动回收.强化石==1 then
		    	self.强化石=true
		    else
		        self.强化石=false
		    end

           if 数据.自动回收.月华露==1 then
		    	self.月华露=true
		    else
		        self.月华露=false
		    end
           if 数据.自动回收.清灵净瓶==1 then
		    	self.清灵净瓶=true
		    else
		        self.清灵净瓶=false
		    end
           if 数据.自动回收.九转金丹==1 then
		    	self.九转金丹=true
		    else
		        self.九转金丹=false
		    end
           if 数据.自动回收.低级内丹==1 then
		     	self.低级内丹=true
		    else
		        self.低级内丹=false
		    end

           if 数据.自动回收.高级内丹==1 then
		    	self.高级内丹=true
		    else
		        self.高级内丹=false
		    end


     end
end


function 多角色回收系统:打开(玩家id)
	if self.可视 then
		self.选中人物 = 0
		self.可视 = false

	else
		insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.低级兽决=false
		self.高级兽决=false
		self.超级柳露=false
		self.宝石=false
		self.五宝=false
		self.二级药材=false
		self.环装=false
	    self.彩果=false
	    self.书铁=false
	    self.玩家id = 玩家id
	end
end

function 多角色回收系统:显示(dt,x,y)
	self.焦点=false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[3]:显示(self.x+2,self.y+2)
	self.白布背景:显示(self.x+10,self.y+50)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts1:置颜色(白色)
	zts1:置字间距(3)
	zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"角色回收")
	zts1:置字间距(0)
	zts1:置颜色(绿色):显示(self.x+30,self.y+30,"回收物品可获得大量金钱.战斗结束后结算并扣除物品")
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x+239,self.y+2)

	if self.资源组[2]:事件判断()  then
		self:打开()
	end
	zt:置颜色(黑色)
	self.资源组[4]:更新(x,y)
       self.资源组[4]:显示(self.x+17,self.y+60,true,nil,nil,self.低级兽决,4)
       zt:显示(self.x+52,self.y+65,"低级兽决")
       zt:显示(self.x+152,self.y+65,"每本1万银子")
       self.资源组[5]:更新(x,y)
       self.资源组[5]:显示(self.x+17,self.y+90,true,nil,nil,self.高级兽决,4)
       zt:显示(self.x+52,self.y+95,"高级兽决")
       zt:显示(self.x+152,self.y+95,"每本5万银子")
       self.资源组[6]:更新(x,y)
       self.资源组[6]:显示(self.x+17,self.y+120,true,nil,nil,self.暗器,4)
       zt:显示(self.x+52,self.y+125,"暗    器")
       zt:显示(self.x+152,self.y+125,"每个1千银子")
       self.资源组[7]:更新(x,y)
       self.资源组[7]:显示(self.x+17,self.y+150,true,nil,nil,self.环装,4)
       zt:显示(self.x+52,self.y+155,"环    装")
       zt:显示(self.x+152,self.y+155,"1万-3万银子")
       self.资源组[8]:更新(x,y)
       self.资源组[8]:显示(self.x+17,self.y+180,true,nil,nil,self.二级药材,4)
       zt:显示(self.x+52,self.y+185,"二    级")
       zt:显示(self.x+152,self.y+185,"每个5千银子")
       self.资源组[9]:更新(x,y)
       self.资源组[9]:显示(self.x+17,self.y+210,true,nil,nil,self.五宝,4)
       zt:显示(self.x+52,self.y+215,"五    宝")
       zt:显示(self.x+152,self.y+215,"每个5千银子")
       self.资源组[10]:更新(x,y)
       self.资源组[10]:显示(self.x+17,self.y+240,true,nil,nil,self.宝石,4)
       zt:显示(self.x+52,self.y+245,"宝    石")
       zt:显示(self.x+152,self.y+245,"每级1万银子")
       self.资源组[12]:更新(x,y)
       self.资源组[12]:显示(self.x+17,self.y+270,true,nil,nil,self.书铁,4)
       zt:显示(self.x+52,self.y+275,"书    铁")
       zt:显示(self.x+152,self.y+275,"每级1千银子")
        self.资源组[11]:更新(x,y)
       self.资源组[11]:显示(self.x+17,self.y+300,true,nil,nil,self.超级柳露,4)
       zt:显示(self.x+52,self.y+305,"超级柳露")
       zt:显示(self.x+152,self.y+305,"每个1万银子")
        self.资源组[13]:更新(x,y)
        self.资源组[13]:显示(self.x+257,self.y+60,true,nil,nil,self.修练果,4)
        zt:显示(self.x+292,self.y+65,"修 练 果")
        zt:显示(self.x+392,self.y+65,"每个十万银子")
		self.资源组[14]:更新(x,y)
        self.资源组[14]:显示(self.x+257,self.y+90,true,nil,nil,self.强化石,4)
        zt:显示(self.x+292,self.y+95,"强 化 石")
        zt:显示(self.x+392,self.y+95,"每个1千银子")
		self.资源组[15]:更新(x,y)
        self.资源组[15]:显示(self.x+257,self.y+120,true,nil,nil,self.月华露,4)
        zt:显示(self.x+292,self.y+125,"月 华 露")
        zt:显示(self.x+392,self.y+125,"每品5两银子")
	    self.资源组[16]:更新(x,y)
        self.资源组[16]:显示(self.x+257,self.y+150,true,nil,nil,self.清灵净瓶,4)
        zt:显示(self.x+292,self.y+155,"清灵净瓶")
        zt:显示(self.x+392,self.y+155,"每个3千银子")
        self.资源组[17]:更新(x,y)
        self.资源组[17]:显示(self.x+257,self.y+180,true,nil,nil,self.九转金丹,4)
        zt:显示(self.x+292,self.y+185,"九转金丹")
        zt:显示(self.x+392,self.y+185,"每品500银子")
        self.资源组[18]:更新(x,y)
        self.资源组[18]:显示(self.x+257,self.y+210,true,nil,nil,self.低级内丹,4)
        zt:显示(self.x+292,self.y+215,"低级内丹")
        zt:显示(self.x+392,self.y+215,"每个1万银子")
       self.资源组[19]:更新(x,y)
       self.资源组[19]:显示(self.x+257,self.y+240,true,nil,nil,self.高级内丹,4)
       zt:显示(self.x+292,self.y+245,"高级内丹")
       zt:显示(self.x+392,self.y+245,"每个3万银子")




       if self.资源组[4]:事件判断() then
      	请求服务(63,{参数=self.玩家id,文本="回收系统",序列="兽决"})
       elseif self.资源组[5]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="高级兽决"})
       elseif self.资源组[6]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="暗器"})
       elseif self.资源组[7]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="环装"})
       elseif self.资源组[8]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="二级药"})
	   elseif self.资源组[9]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="五宝"})
       elseif self.资源组[10]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="宝石"})
       elseif self.资源组[11]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="超级金柳露"})
	   elseif self.资源组[12]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="书铁"})

		 elseif self.资源组[13]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="修练果"})
       elseif self.资源组[14]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="强化石"})
       elseif self.资源组[15]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="月华露"})
       elseif self.资源组[16]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="清灵净瓶"})
	   elseif self.资源组[17]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="九转金丹"})
       elseif self.资源组[18]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="低级内丹"})
       elseif self.资源组[19]:事件判断() then
		请求服务(63,{参数=self.玩家id,文本="回收系统",序列="高级内丹"})

      end


end

function 多角色回收系统:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end

function 多角色回收系统:初始移动(x,y)
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

function 多角色回收系统:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
function 多角色回收系统:更新(dt) end
return 多角色回收系统
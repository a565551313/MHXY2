
local 仙玉商城类 = class()
local tp,zts

function 仙玉商城类:初始化(根)
	self.ID = 66
	self.x = 全局游戏宽度/2-365
	self.y = 65
	self.xx = 0
	self.yy = 0
	self.注释 = "商店"
	tp = 根
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.方向 = 1
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	self.资源组 = {
        [1] = 资源:载入(wdf配置.."/pic/商城1.png", "图片"),
		--[2] = 按钮.创建(资源:载入('商城.wdf',"网易WDF动画",0x00000003),0,0,4,true,true),
		[2] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x00300101),0,0,4,true,true),

		[3] = 按钮.创建(资源:载入('商城.wdf',"网易WDF动画",0x00000001),0,0,4,true,true," 购  买"),
		[4] = 自适应.创建(2,1,562,257,3,9),
		[5] = 自适应.创建(3,1,94,18,1,3),
		[6] = 按钮.创建(资源:载入('商城.wdf',"网易WDF动画",0x00000001),0,0,4,true,true," 上一页"),
		[7] = 按钮.创建(资源:载入('商城.wdf',"网易WDF动画",0x00000001),0,0,4,true,true," 下一页"),
        [8] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"银子商城"),
        [9] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"仙玉商城"),
        [10] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"积分商城"),
        [11] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"锦衣商城"),
        [12] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"神兽商城"),
        [13] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"点卡商城"),
        [14] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000052),0,0,4,true,true,"冒泡框"),
	}
	self.选中显示 = 资源:载入('房屋图标.wdf',"网易WDF动画",0x10000050)
	self.分类按钮 = {
			[1] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"杂货商品"),
			[2] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"锻造商品"),
			[3] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"宝石商品"),
			[4] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"孩子商品"),
			[5] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"仙玉商品"),
			[6] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"宝宝商品"),
			[7] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"法宝商品"),
			[8] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"灵宝商品"),
			[9] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"三级法宝"),
			[10] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"锦衣商品"),
			[11] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"祥瑞商品"),
			[12] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"足迹商品"),
			[13] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"足印商品"),
			[14] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"战锦商品"),
			[15] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"商品详情"),
			[16] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"妖魔积分"),
			[17] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"活跃积分"),
			[18] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"镇妖积分"),
			[19] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"师门积分"),
			[20] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"成就积分"),
			[21] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"副本积分"),
			-- [22] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"一代神兽"),
			-- [23] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"二代神兽"),
			-- [24] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"三代神兽"),
			-- [25] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0x10000047),0,0,3,true,true,"四代神兽"),

      }
    self.覆盖界面 = 资源:载入(wdf配置.."/pic/商城2.png", "图片")
    self.左转 = 按钮.创建(资源:载入('新界面.wdf',"网易WDF动画",0x83000000),0,0,4,true,true)

    self.右转 = 按钮.创建(资源:载入('新界面.wdf',"网易WDF动画",0x84000000),0,0,4,true,true)                                               --按钮.创建(自适应.创建(10,4,20,22,1,3),0,0,4,true,true,">")
    self.黑线 = 资源:载入('房屋图标.wdf',"网易WDF动画",0x00000303)
    self.横条 = 资源:载入('房屋图标.wdf',"网易WDF动画",0x00000302) --下拉
    self.积分按钮 = 按钮.创建(自适应.创建(12,4,74,20,1,3),0,0,4,24,true,"积分查看")
    self.积分界面 = 资源:载入('房屋图标.wdf',"网易WDF动画",0xEE290003)

   self.积分关闭 =按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,24,true)
    self.积分显示=false



    self.大类图标={}
    for i=1,6 do
    	self.大类图标[i]=资源:载入(wdf配置.."/pic/0-"..i..".png", "图片")
    end
	for n=2,3 do
	   self.资源组[n]:绑定窗口_(66)
	end
	for n=6,14 do
	   self.资源组[n]:绑定窗口_(66)
	end
	for i=8,13 do
		self.资源组[i]:置文字颜色(0xFFA2BDE0)
		self.资源组[i]:置偏移(37,4)
	end
	self.资源组[14]:置文字颜色(0xFFA2BDE0)
	self.资源组[14]:置偏移(42,4)
	for i=1,#self.分类按钮 do
		self.分类按钮[i]:置文字颜色(0xFFA2BDE0)
	 	self.分类按钮[i]:置偏移(2,8)

	end
	self.资源组[3]:绑定窗口_(66)
	self.积分按钮:绑定窗口_(66)
	self.左转:绑定窗口_(66)
    self.右转:绑定窗口_(66)
    self.资源组[3]:置偏移(0,2)
    self.左转:置偏移(-2,2)
    self.右转:置偏移(-2,2)
    self.积分按钮:置偏移(-2,-1)
	self.商品 = {}
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('商店总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("数量输入",self.x + 220+3,self.y + 360-52,100,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(4)
	self.输入框:置数字模式()
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(0xFFFFFFFF)
	self.单价 = 0
	self.数量 = 0
	self.总额=tonumber(self.单价*self.数量)
	self.上一次 = 1
	self.窗口时间 = 0
	zts = 根.字体表.普通字体
    self.加入 = 1
	self.状态= "杂货商品"
	self.大类= "银子商城"
	self.焦点1 = false
	self.选择 =0
	self.开始 = 1
	self.结束 = 40
    self.选中 = 0
    self.备注={}
    self.转向 = 4
    self.积分类型 ={"妖魔积分","活跃积分","镇妖积分","师门积分","成就积分","副本积分"}

end


function 仙玉商城类:打开(内容)
	if self.可视 then
		self.可视 = false
        self.商品={}
		self.道具 = nil
		self.方向 = 1
		self.单价 = 0
		self.数量 = 0
        self.选中 = 0
		self.可视 = false
		self.积分显示=false
        self.备注={}
		self.输入框:置焦点(false)
		self.输入框:置可视(false,false)
	else
		self.选择 =0
        self.选中 = 0
		self.加入 = 1
        self.上一次 = 1
		self.开始 = 1
		self.结束 = 40
		self.转向 = 4
		self.数据=内容
		self.状态= "杂货商品"
		self.大类= "银子商城"
	    self.备注={}
		table.insert(tp.窗口_,self)
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true
	    for n=1,#内容.商品 do
	        self.商品[n]={}
	        local 资源=引擎.取物品(内容.商品[n][3])
	        local 动画类型="网易WDF动画"
	        self.商品[n].小动画=tp.资源:载入(资源[11],动画类型,资源[12])
	        self.商品[n].大动画=tp.资源:载入(资源[11],动画类型,资源[13])
	        self.商品[n].名称=内容.商品[n][1]
	        self.商品[n].介绍=内容.商品[n][2]
	        if self.商品[n].介绍=="法宝" or self.商品[n].介绍=="锦衣" or self.商品[n].介绍=="普通" or self.商品[n].介绍=="仙玉"or self.商品[n].介绍=="灵宝" then
	          self.商品[n].介绍=资源[1] or "暂无说明!"
	        end
	        self.商品[n].价格=内容.商品[n][4]
	        self.商品[n].坐骑=false
	        self.商品[n].神兽=false
	        if 资源[2]==2 and 资源[5]==60 then
	          self.商品[n].锦衣=true
	        end
	    end
	end
end



function 仙玉商城类:刷新货币(内容)

  self.数据.仙玉=内容.仙玉
  self.数据.银子=内容.银子
  --self.数据.累充 = 内容.累充
  self.数据.点卡 = 内容.点卡
  self.数据.活跃积分 = 内容.活跃积分
  self.数据.妖魔积分 = 内容.妖魔积分
  self.数据.镇妖积分 = 内容.镇妖积分
  self.数据.师门积分 = 内容.师门积分
  self.数据.成就积分 = 内容.成就积分
  self.数据.副本积分 = 内容.副本积分




end

function 仙玉商城类:刷新(内容)
    self.商品={}
    self.方向 = 1
	self.道具 = nil
    self.单价 = 0
    self.数量 = 0
    self.总额=tonumber(self.单价*self.数量)
    self.上一次 = 1
    self.开始 = 1
    self.加入 = 0
    self.选中 = 0
    self.转向 = 4
	self.输入框:置焦点(false)
	self.输入框:置可视(false,false)
    self.数据=内容
    self.大类 = 内容.大分类
    self.状态 = 内容.分类

    self.备注={}
    for n=1,#内容.商品 do
      self.商品[n]={}
    if 内容.商品[n][3]=="坐骑" then
        local 资源=引擎.取物品(内容.商品[n][1])
        self.商品[n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
        self.商品[n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
        self.商品[n].名称=内容.商品[n][1]
        self.商品[n].介绍=内容.商品[n][2]
        self.商品[n].价格=内容.商品[n][4]
        self.商品[n].坐骑=true
        self.商品[n].神兽=false
    elseif 内容.商品[n][3]=="神兽" then
        local 资源=引擎.取头像(内容.商品[n][1])
        local 资源1 = 引擎.取战斗模型(内容.商品[n][1])
        self.商品[n].小动画=tp.资源:载入(资源[7],"网易WDF动画",资源[2])
        self.商品[n].大动画=tp.资源:载入(资源1[10],"网易WDF动画",资源1[6])
        self.商品[n].名称=内容.商品[n][1]
        self.商品[n].介绍=内容.商品[n][2]
        self.商品[n].造型=内容.商品[n][1]
        if 内容.神兽介绍~=nil and 内容.神兽介绍[n]~=nil then
          self.商品[n].介绍="攻资: "..内容.神兽介绍[n].攻击资质..
                           "\n防资: "..内容.神兽介绍[n].防御资质..
                           "\n体资: "..内容.神兽介绍[n].体力资质..
                           "\n法资: "..内容.神兽介绍[n].法力资质..
                           "\n速资: "..内容.神兽介绍[n].速度资质..
                           "\n躲资: "..内容.神兽介绍[n].躲闪资质..
                           "\n成长: "..内容.神兽介绍[n].成长..
                           "\n#Y/物理技能:\n"..
                           内容.神兽介绍[n].物理技能..
                           "\n#Y/法术技能:\n"..
                           内容.神兽介绍[n].法术技能..
                           "\n#Y/物理固定技能:\n"..
                           内容.神兽介绍[n].物理天生..
                           "\n#Y/法术固定技能:\n"..
                           内容.神兽介绍[n].法术天生
        end
         self.商品[n].类型 ="神兽"
        self.商品[n].价格=内容.商品[n][4]
        self.商品[n].神兽=true
        self.商品[n].坐骑=false
      else
        local 资源=引擎.取物品(内容.商品[n][3])
        local 动画类型="网易WDF动画"

        self.商品[n].小动画=tp.资源:载入(资源[11],动画类型,资源[12])
        self.商品[n].大动画=tp.资源:载入(资源[11],动画类型,资源[13])
        self.商品[n].名称=内容.商品[n][1]
        self.商品[n].介绍=内容.商品[n][2]
        if self.商品[n].介绍=="法宝" or self.商品[n].介绍=="锦衣" or self.商品[n].介绍=="普通" or self.商品[n].介绍=="仙玉" or self.商品[n].介绍=="灵宝" then
          self.商品[n].介绍=资源[1] or "暂无说明!"
        end
        self.商品[n].价格=内容.商品[n][4]
        self.商品[n].坐骑=false
        self.商品[n].神兽=false
        if 资源[2]==2 and 资源[5]==60 and 资源[3]~=nil then
           self.商品[n].锦衣=true
           if 资源[3] == 15 then
           	  self.商品[n].介绍 = self.商品[n].介绍.."\n#S/气血 +10%\n#S/魔法 +10%\n#S/伤害 +5%\n#S/法伤 +5%"
            elseif 资源[3] == 16 then
              self.商品[n].介绍 = self.商品[n].介绍.."\n#S/防御 +5%\n#S/法防 +5%"
            elseif 资源[3] == 17 then
              self.商品[n].介绍 = self.商品[n].介绍.."\n#S/速度 +8%"
            end
        end
      end
    end

    if self.大类=="银子商城" or  self.大类=="仙玉商城"  or  self.大类=="积分商城"  or  self.大类=="点卡商城"  then
    	self.结束 = 40
    else
        self.结束 = 24
    end
    if self.结束>#self.商品 then self.结束=#self.商品 end
end



function 仙玉商城类:显示(dt,x,y)
	for i=8,14 do
	  self.资源组[i]:置字体(tp.字体表.排行字体)
	end


	self.资源组[2]:更新(x,y)
	self.资源组[3]:更新(x,y,self.选中 ~= 0)
	self.积分按钮:更新(x,y)
	self.焦点 = false
	self.焦点1 = false
	self.资源组[1]:显示(self.x-42,self.y-50)
	self.资源组[2]:显示(self.x+715,self.y-36,true)
	self.积分按钮:显示(self.x+625,self.y-33,true)
	if self.资源组[2]:事件判断() then
	  self:打开()
	end
    self.资源组[8]:更新(x,y,self.大类~= "银子商城")
	self.资源组[9]:更新(x,y,self.大类~= "仙玉商城")
	self.资源组[10]:更新(x,y,self.大类~= "积分商城")---new--孩子new
	self.资源组[11]:更新(x,y,self.大类~= "锦衣商城" )
    self.资源组[12]:更新(x,y,self.大类~= "神兽商城" )
    self.资源组[13]:更新(x,y,self.大类~= "点卡商城")
    self.资源组[14]:更新(x,y,self.大类~= "冒泡框")
	self.资源组[6]:更新(x,y,self.开始 ~= 1)
	self.资源组[7]:更新(x,y,#self.商品 > self.结束 )

	if self.资源组[3]:事件判断() then
         请求服务(30.1,{序列=self.状态,序列1=self.选中,数量=self.数量,大类=self.大类})
    elseif self.资源组[6]:事件判断() then
	    if self.大类=="银子商城" or  self.大类=="仙玉商城"  or  self.大类=="积分商城"  or  self.大类=="点卡商城"  then
	    	self.开始 = self.开始 - 40
	    	self.结束 = self.开始 + 39
	    else
	    	self.开始 = self.开始 - 24
		    self.结束 = self.开始 + 23
	    end
    elseif self.资源组[7]:事件判断() then
    	if self.大类=="银子商城" or  self.大类=="仙玉商城"  or  self.大类=="积分商城"  or  self.大类=="点卡商城"  then
	    	self.开始 = self.开始 + 40
	    	self.结束 = self.结束 + 40
	    else
	    	self.开始 = self.开始 + 24
		    self.结束 = self.结束 + 24
	    end
      if self.结束>#self.商品 then self.结束=#self.商品 end
   elseif self.资源组[8]:事件判断() then
        self.状态= "杂货商品"
        self.大类= "银子商城"
        self.商品形象=nil
        请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[9]:事件判断() then
     	self.状态= "仙玉商品"
     	self.大类= "仙玉商城"
     	self.商品形象=nil
      请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[10]:事件判断() then
     	self.状态= "妖魔积分"
     	self.大类= "积分商城"
     	self.商品形象=nil
        请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[11]:事件判断() then
     	self.状态= "锦衣商品"
     	self.大类= "锦衣商城"
     	self.商品形象=nil
       请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[12]:事件判断() then
      	self.状态= "商品详情"
      	self.大类= "神兽商城"
      	self.商品形象=nil
        请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[13]:事件判断() then
     	self.状态= "商品详情"
     	self.大类= "点卡商城"
     	self.商品形象=nil
      请求服务(30,{序列=self.状态,大类=self.大类})
    elseif self.资源组[14]:事件判断() then
     	self.状态= "商品详情"
     	self.大类= "冒泡框"
     	self.商品形象=nil
       请求服务(30,{序列=self.状态,大类=self.大类})
     elseif self.积分按钮:事件判断()  then
	    if  self.积分显示 then
			self.积分显示=false
		else
		    self.积分显示=true
        end
	end
    self.资源组[8]:显示(self.x-41,self.y+15,true,1,nil,self.大类== "银子商城",2)
	self.资源组[9]:显示(self.x-41,self.y+51,true,1,nil,self.大类== "仙玉商城",2)
	self.资源组[10]:显示(self.x-41,self.y+87,true,1,nil,self.大类== "积分商城",2)---new--孩子new
	self.资源组[11]:显示(self.x-41,self.y+123,true,1,nil,self.大类== "锦衣商城",2)
	self.资源组[12]:显示(self.x-41,self.y+159,true,1,nil,self.大类== "神兽商城",2)
	self.资源组[13]:显示(self.x-41,self.y+195,true,1,nil,self.大类== "点卡商城",2)
	self.资源组[14]:显示(self.x-41,self.y+231,true,1,nil,self.大类== "冒泡框",2)
	self.大类图标[1]:显示(self.x-27,self.y+17)
	self.大类图标[2]:显示(self.x-29,self.y+54)
	self.大类图标[3]:显示(self.x-29,self.y+88)
	self.大类图标[4]:显示(self.x-28,self.y+126)
	self.大类图标[5]:显示(self.x-28,self.y+161)
    self.大类图标[2]:显示(self.x-28,self.y+198)
	self.大类图标[6]:显示(self.x-24,self.y+237)


    self.横条:显示(self.x+85,self.y+14)




    for i=1,#self.分类按钮 do
	 	self.分类按钮[i]:置字体(tp.字体表.排行字体1)
	end
	self.资源组[6]:显示(self.x+570,self.y+70,true,1)
	self.资源组[7]:显示(self.x+660,self.y+70,true,1)
	tp.字体表.排行字体1:置颜色(白色):显示(self.x+100,self.y+73, self.大类.." > "..self.状态)
      if self.大类=="银子商城" then
	      	for i=1,4 do
				self.分类按钮[i]:更新(x,y,self.状态~=self.分类按钮[i]:取文字())
				if self.分类按钮[i]:事件判断() then
					self.状态=self.分类按钮[i]:取文字()
					请求服务(30,{序列=self.状态,大类=self.大类})
				end
			end
			self.分类按钮[1]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[1]:取文字(),2)
            self.分类按钮[2]:显示(self.x+164,self.y+13,true,1,nil,self.状态==self.分类按钮[2]:取文字(),2)
            self.分类按钮[3]:显示(self.x+239,self.y+13,true,1,nil,self.状态==self.分类按钮[3]:取文字(),2)
            self.分类按钮[4]:显示(self.x+314,self.y+13,true,1,nil,self.状态==self.分类按钮[4]:取文字(),2)
            for i=1,3 do
               self.黑线:显示(self.x+89+75*i,self.y+23)
            end
      elseif self.大类=="仙玉商城" then
      	     self.分类按钮[2]:更新(x,y,self.状态~=self.分类按钮[2]:取文字())
			 if self.分类按钮[2]:事件判断() then
				self.状态=self.分类按钮[2]:取文字()
				请求服务(30,{序列=self.状态,大类=self.大类})
			 end
      	     for i=4,9 do
				self.分类按钮[i]:更新(x,y,self.状态~=self.分类按钮[i]:取文字())
				if self.分类按钮[i]:事件判断() then
					self.状态=self.分类按钮[i]:取文字()
					请求服务(30,{序列=self.状态,大类=self.大类})
				end
		    end
      	    self.分类按钮[2]:显示(self.x+164,self.y+13,true,1,nil,self.状态==self.分类按钮[2]:取文字(),2)
      	    self.分类按钮[4]:显示(self.x+314,self.y+13,true,1,nil,self.状态==self.分类按钮[4]:取文字(),2)
      	    self.分类按钮[5]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[5]:取文字(),2)
            self.分类按钮[6]:显示(self.x+239,self.y+13,true,1,nil,self.状态==self.分类按钮[6]:取文字(),2)
            self.分类按钮[7]:显示(self.x+389,self.y+13,true,1,nil,self.状态==self.分类按钮[7]:取文字(),2)
            self.分类按钮[8]:显示(self.x+464,self.y+13,true,1,nil,self.状态==self.分类按钮[8]:取文字(),2)
            -- self.分类按钮[9]:显示(self.x+539,self.y+13,true,1,nil,self.状态==self.分类按钮[9]:取文字(),2)
            for i=1,6 do
               self.黑线:显示(self.x+89+75*i,self.y+23)
            end
      elseif self.大类=="锦衣商城" then
      	    for i=10,13 do
				self.分类按钮[i]:更新(x,y,self.状态~=self.分类按钮[i]:取文字())
				if self.分类按钮[i]:事件判断() then
					self.状态=self.分类按钮[i]:取文字()
					请求服务(30,{序列=self.状态,大类=self.大类})
				end
		    end
      	    self.分类按钮[10]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[10]:取文字(),2)
            self.分类按钮[11]:显示(self.x+164,self.y+13,true,1,nil,self.状态==self.分类按钮[11]:取文字(),2)
            self.分类按钮[12]:显示(self.x+239,self.y+13,true,1,nil,self.状态==self.分类按钮[12]:取文字(),2)
            self.分类按钮[13]:显示(self.x+314,self.y+13,true,1,nil,self.状态==self.分类按钮[13]:取文字(),2)
         --   self.分类按钮[14]:显示(self.x+389,self.y+13,true,1,nil,self.状态==self.分类按钮[14]:取文字(),2)
            for i=1,3 do
               self.黑线:显示(self.x+89+75*i,self.y+23)
            end
      elseif self.大类=="积分商城" then
      	    for i=16,21 do
				self.分类按钮[i]:更新(x,y,self.状态~=self.分类按钮[i]:取文字())
				if self.分类按钮[i]:事件判断() then
					self.状态=self.分类按钮[i]:取文字()
					请求服务(30,{序列=self.状态,大类=self.大类})
				end
		    end
      	    self.分类按钮[16]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[16]:取文字(),2)
            self.分类按钮[17]:显示(self.x+164,self.y+13,true,1,nil,self.状态==self.分类按钮[17]:取文字(),2)
            self.分类按钮[18]:显示(self.x+239,self.y+13,true,1,nil,self.状态==self.分类按钮[18]:取文字(),2)
            self.分类按钮[19]:显示(self.x+314,self.y+13,true,1,nil,self.状态==self.分类按钮[19]:取文字(),2)
            self.分类按钮[20]:显示(self.x+389,self.y+13,true,1,nil,self.状态==self.分类按钮[20]:取文字(),2)
            self.分类按钮[21]:显示(self.x+464,self.y+13,true,1,nil,self.状态==self.分类按钮[21]:取文字(),2)
            for i=1,5 do
               self.黑线:显示(self.x+89+75*i,self.y+23)
            end
        elseif self.大类=="神兽商城" then
  --     	    for i=22,25 do
		-- 		self.分类按钮[i]:更新(x,y,self.状态~=self.分类按钮[i]:取文字())
		-- 		if self.分类按钮[i]:事件判断() then
		-- 			self.状态=self.分类按钮[i]:取文字()
		-- 			请求服务(30,{序列=self.状态,大类=self.大类})
		-- 		end
		--     end
  --     	    self.分类按钮[22]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[22]:取文字(),2)
  --           self.分类按钮[23]:显示(self.x+164,self.y+13,true,1,nil,self.状态==self.分类按钮[23]:取文字(),2)
  --           self.分类按钮[24]:显示(self.x+239,self.y+13,true,1,nil,self.状态==self.分类按钮[24]:取文字(),2)
  --           self.分类按钮[25]:显示(self.x+314,self.y+13,true,1,nil,self.状态==self.分类按钮[25]:取文字(),2)
  --           for i=1,3 do
  --              self.黑线:显示(self.x+89+75*i,self.y+23)
  --           end

		-- else
			self.分类按钮[15]:更新(x,y,self.状态~=self.分类按钮[15]:取文字())
		    self.分类按钮[15]:显示(self.x+89,self.y+13,true,1,nil,self.状态==self.分类按钮[15]:取文字(),2)
		end
	if self.大类=="银子商城" or  self.大类=="仙玉商城"  or  self.大类=="积分商城"  or  self.大类=="点卡商城"  then
		    self.资源组[3]:显示(self.x+395,self.y+460,true,1)---购买
			local xx = 0
			local yy = 0
			for i=self.开始,self.结束 do
		        if self.商品[i]~=nil and  self.商品[i].小动画~=nil then
		            self.商品[i].小动画:显示(self.x + xx * 65+101,self.y + yy * 70 +107)
		        end
		        ------------------------------------
                if self.商品[i]~=nil and  self.商品[i].小动画~=nil and self.商品[i].小动画:是否选中(x,y) then
                   self.焦点1 = true
                   tp.提示:商城提示(x,y,self.商品[i].名称,self.商品[i].介绍,self.商品[i].大动画,self.备注[i],self.商品[i].神兽)
                   if self.上一次~=i then
                      self.选中显示:显示(self.x + xx * 65+102,self.y + yy * 70 +105)
                   end
				   if 引擎.鼠标弹起(0) then
					  if self.道具 == nil then
							self.商品[self.上一次].确定 = false
							self.商品[i].确定 = true
							self.上一次 = i
                            self.选中 = i
							self.道具 = self.商品[i]
							self.单价 = tonumber(self.道具.价格)
							self.数量 = 1
							self.输入框:置可视(true,true)
						else
							if self.上一次 == i then
								self.数量 = self.数量 + 1
							else
								self.商品[self.上一次].确定 = false
								self.商品[i].确定 = true
								self.上一次 = i
                                self.选中 = i
								self.道具 = self.商品[i]
								self.单价 = tonumber(self.道具.价格)
								self.数量 = 1
								self.输入框:置可视(true,true)
							end
						end
						self.输入框:置文本(self.数量)
					elseif 引擎.鼠标弹起(1) then
						   if self.道具~= nil then
							  if self.上一次 == i   then
								 self.数量  = self.数量 - 1
							  else
								 self.商品[self.上一次].确定 = false
								 self.商品[i].确定 = true
								 self.上一次 = i
                                 self.选中 = i
								 self.道具 = self.商品[i]
								 self.单价 = tonumber(self.道具.价格)
								 self.数量 = 1
								 self.输入框:置可视(true,true)
							  end
						   end
						   self.输入框:置文本(self.数量)
					end
				end
-----------------------------------------
			    if self.道具~= nil then
			       if self.上一次==i then
			          self.选中显示:显示(self.x + xx * 65+102,self.y + yy * 70 +105)
			       end
			    end
				xx = xx + 1
				if xx >= 10 then
					xx = 0
					yy = yy + 1
				end
			end
			if self.道具 ~= nil then
				zts:置颜色(取金钱颜色(self.单价)):显示(self.x + 490,self.y + 385,self.单价)
				zts:置颜色(0xFFFFFFFF):显示(self.x + 170,self.y + 385,self.道具.名称)
				self.输入框:置坐标(self.x-90,self.y+48)
				if self.输入框:取文本() == "" then
					self.输入框:置文本(1)
				end
				if self.输入框:取文本()+0 > 999 then
					self.输入框:置文本(999)
				end
				if self.输入框:取文本()+0 < 0 then
					self.输入框:置文本(0)
				end
				self.数量 = tonumber(self.输入框:取文本())
				self.总额=tonumber(self.单价*self.数量)
				zts:置颜色(取金钱颜色(self.总额)):显示(self.x + 490,self.y + 420,self.总额)
			end
		   self.控件类:更新(dt,x,y)
		   if self.输入框._已碰撞 then
			  self.焦点 = true
		   end

    elseif self.大类=="神兽商城" then
       self.覆盖界面:显示(self.x+95,self.y+100)
		 self.资源组[3]:显示(self.x+395+125,self.y+450,true,1)---购买
	     self.左转:更新(x,y)
	     self.右转:更新(x,y)
	     self.左转:显示(self.x+135,self.y+380,true,1)
	     self.右转:显示(self.x+265,self.y+380,true,1)
	     if self.左转:事件判断() and self.商品形象~=nil then
	     	self.转向 = self.转向 + 1
	     	if self.转向>=4 then
	     	   self.转向 = 0
	     	end
	     	self.商品形象:置方向(self.转向)
	     elseif self.右转:事件判断() and self.商品形象~=nil then
	     	self.转向 = self.转向 -1
	     	if self.转向< 0 then
	     	   self.转向 = 3
	     	end
	     	self.商品形象:置方向(self.转向)
	     end

		 local xx = 0
		 local yy = 0
		 for i=self.开始,self.结束 do
		        if self.商品[i]~=nil and  self.商品[i].小动画~=nil then
		            self.商品[i].小动画:显示(self.x + xx * 65+367,self.y + yy * 63 +106)
		        end
                if self.商品[i]~=nil and  self.商品[i].小动画~=nil and self.商品[i].小动画:是否选中(x,y) then
                   self.焦点1 = true
                   tp.提示:商城提示(x,y,self.商品[i].名称,self.商品[i].介绍,self.商品[i].大动画,self.备注[i],self.商品[i].神兽)
                   if self.上一次~=i then
                      self.选中显示:显示(self.x + xx * 65+366,self.y + yy * 63 +103)
                   end
				   if 引擎.鼠标弹起(0) then
					  if self.道具 == nil then
							self.商品[self.上一次].确定 = false
							self.商品[i].确定 = true
							self.上一次 = i
                            self.选中 = i
							self.道具 = self.商品[i]
							self.单价 = tonumber(self.道具.价格)
							self.数量 = 1
							self.输入框:置可视(true,true)
						else
							if self.上一次 == i then
								self.数量 = self.数量 + 1
							else
								self.商品[self.上一次].确定 = false
								self.商品[i].确定 = true
								self.上一次 = i
                                self.选中 = i
								self.道具 = self.商品[i]
								self.单价 = tonumber(self.道具.价格)
								self.数量 = 1
								self.输入框:置可视(true,true)
							end
						end
						self:置商品形象(self.商品[i])
						self.输入框:置文本(self.数量)
					elseif 引擎.鼠标弹起(1) then
						   if self.道具~= nil then
							  if self.上一次 == i   then
								 self.数量  = self.数量 - 1
							  else
								 self.商品[self.上一次].确定 = false
								 self.商品[i].确定 = true
								 self.上一次 = i
                                 self.选中 = i
								 self.道具 = self.商品[i]
								 self.单价 = tonumber(self.道具.价格)
								 self.数量 = 1
								 self.输入框:置可视(true,true)
							  end
							  self:置商品形象(self.商品[i])
						   end
						   self.输入框:置文本(self.数量)
					end
				end
-----------------------------------------
			    if self.道具~= nil then
			       if self.上一次==i then
			          self.选中显示:显示(self.x + xx * 65+366,self.y + yy * 63 +103)
			       end
			    end
				xx = xx + 1
				if xx >= 6 then
					xx = 0
					yy = yy + 1
				end
			end
			if self.道具 ~= nil then
				zts:置颜色(取金钱颜色(self.单价)):显示(self.x + 450,self.y + 390,self.单价)
				zts:置颜色(0xFFFFFFFF):显示(self.x + 450,self.y + 360,self.道具.名称)
				self.输入框:置坐标(self.x+195,self.y+53)
				if self.输入框:取文本() == "" then
					self.输入框:置文本(1)
				end
				if self.输入框:取文本()+0 > 999 then
					self.输入框:置文本(999)
				end
				if self.输入框:取文本()+0 < 0 then
					self.输入框:置文本(0)
				end
				self.数量 = tonumber(self.输入框:取文本())
				self.总额=tonumber(self.单价*self.数量)
				zts:置颜色(取金钱颜色(self.总额)):显示(self.x + 635,self.y + 425,self.总额)
			end

			if self.商品形象 ~= nil then
				tp.影子:显示(self.x + 226,self.y +400 )
   			    self.商品形象:更新(dt)
  			    self.商品形象:显示(self.x + 226,self.y +400)
			end
		    self.控件类:更新(dt,x,y)
			if self.输入框._已碰撞 then
			   self.焦点 = true
			end

	else
		 self.覆盖界面:显示(self.x+95,self.y+100)
		 self.资源组[3]:显示(self.x+520,self.y+450,true,1)---购买
	     self.左转:更新(x,y)
	     self.右转:更新(x,y)
	     self.左转:显示(self.x+135,self.y+380,true,1)
	     self.右转:显示(self.x+265,self.y+380,true,1)
	     if self.左转:事件判断() and self.商品形象~=nil then
	     	self.转向 = self.转向 + 1
	     	if self.转向>=5 then
	     	   self.转向 = 1
	     	end
	     	self.商品形象:置方向(self.转向)
	     	if self.武器形象~=nil then
	     		self.武器形象:置方向(self.转向)
	     	end
	     	if self.额外形象~=nil then
	     		self.额外形象:置方向(self.转向)
	     	end
	     elseif self.右转:事件判断() and self.商品形象~=nil then
	     	self.转向 = self.转向 -1
	     	if self.转向<=0 then
	     	   self.转向 = 4
	     	end
	     	self.商品形象:置方向(self.转向)
	     	if self.武器形象~=nil then
	     		self.武器形象:置方向(self.转向)
	     	end
	     	if self.额外形象~=nil then
	     		self.额外形象:置方向(self.转向)
	     	end
	     end

		 local xx = 0
		 local yy = 0
		 for i=self.开始,self.结束 do
		        if self.商品[i]~=nil and  self.商品[i].小动画~=nil then
		            self.商品[i].小动画:显示(self.x + xx * 65+364,self.y + yy * 63 +105)
		        end
		        ------------------------------------
                if self.商品[i]~=nil and  self.商品[i].小动画~=nil and self.商品[i].小动画:是否选中(x,y) then
                   self.焦点1 = true
                   tp.提示:商城提示(x,y,self.商品[i].名称,self.商品[i].介绍,self.商品[i].大动画,self.备注[i],self.商品[i].神兽)
                   if self.上一次~=i then
                      self.选中显示:显示(self.x + xx * 65+366,self.y + yy * 63 +103)
                   end
				   if 引擎.鼠标弹起(0) then
					  if self.道具 == nil then
							self.商品[self.上一次].确定 = false
							self.商品[i].确定 = true
							self.上一次 = i
                            self.选中 = i
							self.道具 = self.商品[i]
							self.单价 = tonumber(self.道具.价格)
							self.数量 = 1
							self.输入框:置可视(true,true)
						else
							if self.上一次 == i then
								self.数量 = self.数量 + 1
							else
								self.商品[self.上一次].确定 = false
								self.商品[i].确定 = true
								self.上一次 = i
                                self.选中 = i
								self.道具 = self.商品[i]
								self.单价 = tonumber(self.道具.价格)
								self.数量 = 1
								self.输入框:置可视(true,true)
							end
						end
						self:置商品形象(self.商品[i])
						self.输入框:置文本(self.数量)
					elseif 引擎.鼠标弹起(1) then
						   if self.道具~= nil then
							  if self.上一次 == i   then
								 self.数量  = self.数量 - 1
							  else
								 self.商品[self.上一次].确定 = false
								 self.商品[i].确定 = true
								 self.上一次 = i
                                 self.选中 = i
								 self.道具 = self.商品[i]
								 self.单价 = tonumber(self.道具.价格)
								 self.数量 = 1
								 self.输入框:置可视(true,true)
							  end
							  self:置商品形象(self.商品[i])
						   end
						   self.输入框:置文本(self.数量)
					end
				end
-----------------------------------------
			    if self.道具~= nil then
			       if self.上一次==i then
			          self.选中显示:显示(self.x + xx * 65+366,self.y + yy * 63 +103)
			       end
			    end
				xx = xx + 1
				if xx >= 6 then
					xx = 0
					yy = yy + 1
				end
			end
			if self.道具 ~= nil then
				zts:置颜色(取金钱颜色(self.单价)):显示(self.x + 450,self.y + 390,self.单价)
				zts:置颜色(0xFFFFFFFF):显示(self.x + 450,self.y + 360,self.道具.名称)
				self.输入框:置坐标(self.x+195,self.y+53)
				if self.输入框:取文本() == "" then
					self.输入框:置文本(1)
				end
				if self.输入框:取文本()+0 > 999 then
					self.输入框:置文本(999)
				end
				if self.输入框:取文本()+0 < 0 then
					self.输入框:置文本(0)
				end
				self.数量 = tonumber(self.输入框:取文本())
                self.总额=tonumber(self.单价*self.数量)
				zts:置颜色(取金钱颜色(self.总额)):显示(self.x + 635,self.y + 425,self.总额)
			end
			if self.武器形象 ~= nil then
   			    self.武器形象:更新(dt)
  			    self.武器形象:显示(self.x + 226,self.y +400 )
			end
			if self.额外形象 ~= nil then
   			    self.额外形象:更新(dt)
  			    self.额外形象:显示(self.x + 226,self.y +400 )
			end

			if self.商品形象 ~= nil then
				if self.大类 =="冒泡框" then
					self.商品形象:更新(dt)
	  			    self.商品形象:显示(self.x + 226-55,self.y +220)
				else
				   tp.影子:显示(self.x + 226,self.y +400 )
	   			   self.商品形象:更新(dt)
	  			   self.商品形象:显示(self.x + 226,self.y +400)
				end
			end
		    self.控件类:更新(dt,x,y)
			if self.输入框._已碰撞 then
			   self.焦点 = true
			end
	end

    zts:置颜色(取金钱颜色(self.数据.银子)):显示(self.x + 300,self.y -28,self.数据.银子)
    if self.大类== "点卡商城" then
	   zts:置颜色(取金钱颜色(self.数据.点卡)):显示(self.x + 125,self.y -28,self.数据.点卡)
	elseif self.大类== "积分商城" then
		zts:置颜色(取金钱颜色(self.数据[self.状态])):显示(self.x + 125,self.y -28,self.数据[self.状态])
	else
	    zts:置颜色(取金钱颜色(self.数据.仙玉)):显示(self.x + 125,self.y -28,self.数据.仙玉)
	end

 if  self.积分显示 then
   	 self.积分界面:显示(self.x+512,self.y-6)
   	 self.积分关闭:更新(x,y)
   	 self.积分关闭:显示(self.x+683,self.y-3)
   	 if self.积分关闭:事件判断()  then
		self.积分显示=false
	 end
	 for i=1,#self.积分类型 do
	 	if self.数据[self.积分类型[i]]~=nil  and  self.数据[self.积分类型[i]]>0 then
	 		 local 字体位数=string.len(tostring(self.数据[self.积分类型[i]]))
	 		 zts:置颜色(0xFF9AC0CD):显示(self.x+658-(字体位数-1)*8,self.y+7+i*35,self.数据[self.积分类型[i]])
		 else
	         zts:置颜色(0xFF9AC0CD):显示(self.x+658,self.y+7+i*35,"0")
	     end
	 end



   end

 zts:置颜色(白色)

 for i=8,14 do
	  self.资源组[i]:置字体(tp.字体表.下拉字体)
	end
	for i=1,#self.分类按钮 do
	 	self.分类按钮[i]:置字体(tp.字体表.下拉字体)
	end
  self.控件类:显示(x,y)

end






function 仙玉商城类:置商品形象(数据)
	self.商品形象 = nil
	self.武器形象 = nil
	self.额外形象 = nil
	self.转向 = 4
	if self.大类 =="锦衣商城" then
		  local v
	      if tp.队伍[1].装备~=nil and tp.队伍[1].装备[3]~=nil then
	         v = tp:取武器子类(tp.队伍[1].装备[3].子类)
	        if tp.队伍[1].装备[3].名称 == "龙鸣寒水" or tp.队伍[1].装备[3].名称 == "非攻" then
	          v = "弓弩1"
	        end
	      end
	      local 造型=tp.队伍[1].模型
	      local 站立人物=引擎.取模型(造型,v)
	      self.商品形象 =  tp.资源:载入(站立人物[3],"网易WDF动画",站立人物[1])
	      self.商品形象:置方向(self.转向)
	      if self.状态== "锦衣商品" and 数据 then
		        local 资源2=引擎.取战斗锦衣素材(数据.名称,tp.队伍[1].模型)
		         if 新加战斗锦衣[数据.名称]~=nil  then
                	资源2 = 引擎.取武器锦衣素材(数据.名称,tp.队伍[1].模型)
		         end
		         if 资源2~=nil and 资源2[5]~=nil and 资源2[1]~=nil then
				    self.商品形象=  tp.资源:载入(资源2[5],"网易WDF动画",资源2[3])
				    self.商品形象:置方向(self.转向)
				end
			elseif  self.状态== "祥瑞商品" and 数据 then
	            local 模型=tp.队伍[1].模型
	            local 坐骑资源 = {}
		        if 引擎.新增坐骑(模型,数据.名称,"奔跑") then
					坐骑资源.坐骑资源 = "xzzq.wdf"
					坐骑资源.坐骑站立 = 引擎.新增坐骑(模型,数据.名称,"站立")
		        else
		       	 	坐骑资源 = 引擎.坐骑库(模型,数据.名称,饰品 or "空")
		       	end
				 self.商品形象  = tp.资源:载入(坐骑资源.坐骑资源,"网易WDF动画",坐骑资源.坐骑站立)
				 self.商品形象:置方向(self.转向)
			elseif self.状态== "足印商品" then
			     local 资源3 = 引擎.取光环(数据.名称)
	            self.武器形象=tp.资源:载入(资源3[4],"网易WDF动画",资源3[1])
	            self.武器形象:置方向(self.转向)
		  	elseif self.状态== "足迹商品" and 数据 then
		            local 资源4=引擎.取足迹(数据.名称)
		            if 资源4~=nil and 资源4[1]~=nil and 资源4[4]~=nil then
		              self.额外形象 =tp.资源:载入(资源4[4],"网易WDF动画",资源4[1])
		              self.额外形象:置方向(self.转向)
		            end
	        end
   elseif self.大类 =="神兽商城" and 数据  then
   	       self.转向 = 0
   	       local 资源1 = 引擎.取战斗模型(数据.造型)
           self.商品形象=tp.资源:载入(资源1[10],"网易WDF动画",资源1[6])
           self.商品形象:置方向(self.转向)
     elseif self.大类 =="冒泡框" and 数据  then
     	    self.商品形象=数据.大动画



	end
end


function 仙玉商城类:检查点(x,y)
  if self.可视 and self.资源组[1]:是否选中(x,y)  then
    return true
  end
  return false
end

function 仙玉商城类:初始移动(x,y)
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

function 仙玉商城类:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end




return 仙玉商城类
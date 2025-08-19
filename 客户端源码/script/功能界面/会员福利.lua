
local 会员福利 = class()
local tp

function 会员福利:初始化(根)
	self.ID = 67
	self.x = 170
	self.y = 97
	self.xx = 0
	self.yy = 0
	self.注释 = "会员福利"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 小型选项栏 = 根._小型选项栏
	local 滑块 = 根._滑块
	tp = 根
	self.资源组 = {
		[1] = 自适应.创建(0,1,540,355,3,9),
		[2] = 自适应.创建(1,1,536,18,1,3,nil,18),
		[3] = 自适应.创建(5,1,306,339,3,9),
		[4] = 按钮.创建(自适应.创建(18,4,16,16,4,1),0,0,4,true,true),
		[5] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"累计充值"),
		[6] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"每日活动"),
		[7] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"卡号充值"),
		[8] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"月卡奖励"),
		[9] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"货币互换"),
		[10] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"首充奖励"),
		[11] = 自适应.创建(105,1,305,90,3,9),


	}
     for i=4,9 do
       self.资源组[i]:绑定窗口_(67)
     end

  self.底图背景 =  自适应.创建(4,1,510,310,3,nil)
  self.物品背景 = 资源:载入(wdf配置.."/pic/打造方格.png", "图片")
  self.输入框背景 = 自适应.创建(3,1,200,18,1,3)
  self.充值按钮 = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"确定充值")
  self.充值按钮:绑定窗口_(67)
  self.宝石字体= tp.字体表.描边字体__
  self.宝石字体:置颜色(0xFFFFFFFF)
  self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)
  self.赞助字体= tp.字体表.赞助字体
  self.赞助字体:置颜色(白色)
  self.赞助字体:置描边颜色(0xFFaf140c)--xFFaf140c)

    self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('会员总控件')
	总控件:置可视(true,true)
	self.输入框 = 总控件:创建输入("卡号输入",0,0,200,14)
	self.输入框:置可视(false,false)
	self.输入框:置限制字数(20)
	self.输入框:置文本("")
	self.输入框:置光标颜色(-16777216)
	self.输入框:置文字颜色(-16777216)
	self.窗口时间 = 0
	self.累计充值 = 0
	self.首充数据={}
	self.首充物品={}
	self.固定显示={}
	self.首充神兽=nil
	self.领取累充 ={}
	self.累充数据={}
	self.累充物品={}
	self.累充召唤兽={}
	self.变色时间=os.time()
    self.字体颜色 = {0xFFFFFF00,0xFFFF0000,0xFFFFFFFF,0xFF00FF00}
    self.初始颜色 = 0xFFFFFF00
    self.开始 = 1
    self.结束 = 3
    self.已领充值=0
    self.判断长度=0
    self.显示档次=1

end





function 会员福利:打开(数据)
	if self.可视 then
		self.分类 = nil
		self.可视 = false
		self.累计充值 = 0
		self.输入框:置焦点(false)
		self.输入框:置可视(false,false)
		self.首充神兽=nil
		self.开始 = 1
        self.结束 = 3
	else
		table.insert(tp.窗口_,self)
		self.分类 = 1
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
		self.开始 = 1
        self.结束 = 3
       self.已领充值=0

		if 数据.累计充值~= nil then
		   self.累计充值 = 数据.累计充值
		end
		if 数据.首充数据~=nil then
		   self.首充数据 = 数据.首充数据
		end
		if 数据.已领充值~=nil then
		   self.已领充值 = 数据.已领充值
		end
		self.首充物品={}
        if 数据.首充数据.物品~=nil and 数据.首充数据.物品数量~=nil  and 数据.首充数据.物品数量+0>0 then
          for i=1,数据.首充数据.物品数量+0 do
            self.首充物品[i] = {}
            local 资源=引擎.取物品(数据.首充数据.物品[i].名称)
            self.首充物品[i].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
            self.首充物品[i].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
            self.首充物品[i].名称=数据.首充数据.物品[i].名称
            self.首充物品[i].数量=数据.首充数据.物品[i].数量
            self.首充物品[i].介绍=资源[1]
          end
        end
        self.固定显示={}
        if 数据.首充数据.经验~=nil and 数据.首充数据.经验>0 then
           self.固定显示[#self.固定显示+1] ="领取经验:"..数额尾数转换(数据.首充数据.经验)
        end
        if 数据.首充数据.储备~=nil and  数据.首充数据.储备>0 then
           self.固定显示[#self.固定显示+1] ="领取储备:"..数额尾数转换(数据.首充数据.储备)
        end
        if 数据.首充数据.银子~=nil and 数据.首充数据.银子>0 then
           self.固定显示[#self.固定显示+1] ="领取银子:"..数额尾数转换(数据.首充数据.银子)
        end
        if 数据.首充数据.仙玉~=nil and 数据.首充数据.仙玉>0 then
           self.固定显示[#self.固定显示+1] ="领取仙玉:"..数额尾数转换(数据.首充数据.仙玉)
        end
        if 数据.首充数据.点卡~=nil and 数据.首充数据.点卡>0 then
           self.固定显示[#self.固定显示+1] ="领取点卡:"..数额尾数转换(数据.首充数据.点卡)
        end

        if 数据.首充数据.召唤兽~="不给"  then
           self.首充神兽 ="领取"..数据.首充数据.类型..":"..数据.首充数据.召唤兽.."一只"
        end
        self.领取累充={}
        self.累充数据={}
        self.累充物品={}
        self.累充召唤兽={}
        self.显示档次=1
        self.判断长度=0
        if 数据.累充数据~=nil then
           self.累充数据=数据.累充数据
           table.sort(self.累充数据,function(a,b) return a.需求充值<b.需求充值 end )
           if self.已领充值>0 then
	           local  获取最小 = {}
	            for i=1,#self.累充数据 do
	            	if self.已领充值<self.累充数据[i].需求充值  then
	            		获取最小[#获取最小+1]={数额=self.累充数据[i].需求充值,编号=i}
	            	end
	            end
	             table.sort(获取最小,function(a,b) return a.数额<b.数额 end )
		         if 获取最小[1]==nil then
			         self.显示档次 = #self.累充数据
			     else
		             self.显示档次 = 获取最小[1].编号
			     end
	        end
           if self.累充数据[self.显示档次]~=nil then
	         self.判断长度 = string.len(self.累充数据[self.显示档次].需求充值)
	       end

        	for i = 1,#self.累充数据 do
              self.领取累充[i] = tp._按钮.创建(tp._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"领取奖励")
              self.领取累充[i]:绑定窗口_(67)
              self.累充物品[i]={}
              self.累充召唤兽[i]={}
              if self.累充数据[i].召唤兽~="不给"  then
	               local 临时资源 = 引擎.取头像(self.累充数据[i].召唤兽)
                   self.累充召唤兽[i].小动画 = tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[2])
                   local n = 引擎.取战斗模型(self.累充数据[i].召唤兽)
			       self.累充召唤兽[i].大动画= tp.资源:载入(n[10],"网易WDF动画",n[6])
			       self.累充召唤兽[i].名称=self.累充数据[i].召唤兽
		           self.累充召唤兽[i].数量=1
		           self.累充召唤兽[i].介绍="#G/领取"..self.累充数据[i].召唤兽类型..":"..self.累充数据[i].召唤兽
	          end



               if self.累充数据[i].物品~=nil and self.累充数据[i].物品数量~=nil  and self.累充数据[i].物品数量+0>0 then
		          for n=1,self.累充数据[i].物品数量+0 do
		            self.累充物品[i][n] = {}
		            local 资源=引擎.取物品(self.累充数据[i].物品[n].名称)
		            self.累充物品[i][n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
		            self.累充物品[i][n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
		            self.累充物品[i][n].名称=self.累充数据[i].物品[n].名称
		            self.累充物品[i][n].数量=self.累充数据[i].物品[n].数量
		            self.累充物品[i][n].介绍=资源[1]
		          end
		        end

            end


        end


	end
end

function 会员福利:刷新(数据)
   if 数据.累计充值~= nil then
	  self.累计充值 = 数据.累计充值
   end
   if 数据.首充数据~=nil then
	  self.首充数据 = 数据.首充数据
   end
   self.已领充值 = 0
   if 数据.已领充值~=nil then
	  self.已领充值 = 数据.已领充值
   end
   self.首充物品={}
   if 数据.首充数据.物品~=nil and  数据.首充数据.物品数量~=nil  and 数据.首充数据.物品数量+0>0   then
      for i=1,数据.首充数据.物品数量+0 do
          self.首充物品[i] = {}
          local 资源=引擎.取物品(数据.首充数据.物品[i].名称)
          self.首充物品[i].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.首充物品[i].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.首充物品[i].名称=数据.首充数据.物品[i].名称
          self.首充物品[i].数量=数据.首充数据.物品[i].数量
          self.首充物品[i].介绍=资源[1]
       end
   end
   self.固定显示={}
   if 数据.首充数据.经验~=nil and 数据.首充数据.经验>0 then
      self.固定显示[#self.固定显示+1] ="领取经验:"..数额尾数转换(数据.首充数据.经验)
   end
   if 数据.首充数据.储备~=nil and  数据.首充数据.储备>0 then
      self.固定显示[#self.固定显示+1] ="领取储备:"..数额尾数转换(数据.首充数据.储备)
   end
   if 数据.首充数据.银子~=nil and 数据.首充数据.银子>0 then
      self.固定显示[#self.固定显示+1] ="领取银子:"..数额尾数转换(数据.首充数据.银子)
   end
   if 数据.首充数据.仙玉~=nil and 数据.首充数据.仙玉>0 then
      self.固定显示[#self.固定显示+1] ="领取仙玉:"..数额尾数转换(数据.首充数据.仙玉)
   end
   if 数据.首充数据.点卡~=nil and 数据.首充数据.点卡>0 then
      self.固定显示[#self.固定显示+1] ="领取点卡:"..数额尾数转换(数据.首充数据.点卡)
   end
   self.首充神兽=nil
   if 数据.首充数据.召唤兽~="不给" then
      self.首充神兽 ="领取"..数据.首充数据.类型..":"..数据.首充数据.召唤兽.."一只"
   end
   self.开始 = 1
   self.结束 = 3
   self.领取累充={}
   self.累充数据={}
   self.累充物品={}
   self.累充召唤兽={}
   self.显示档次=1
   self.判断长度 = 0
   if 数据.累充数据~=nil then
      self.累充数据=数据.累充数据
      self.累充数据=数据.累充数据
      table.sort(self.累充数据,function(a,b) return a.需求充值<b.需求充值 end )
      if self.已领充值>0 then
	     local  获取最小 = {}
	     for i=1,#self.累充数据 do
	         if self.已领充值<self.累充数据[i].需求充值  then
	            获取最小[#获取最小+1]={数额=self.累充数据[i].需求充值,编号=i}
	         end
	     end
	      table.sort(获取最小,function(a,b) return a.数额<b.数额 end )
         if  获取最小[1]==nil then
	         self.显示档次 = #self.累充数据
	     else
             self.显示档次 = 获取最小[1].编号
	     end
	  end

      for i = 1,#self.累充数据 do
          self.领取累充[i] = tp._按钮.创建(tp._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"领取奖励")
          self.领取累充[i]:绑定窗口_(67)
          self.累充物品[i]={}
          self.累充召唤兽[i]={}
          if self.累充数据[i].召唤兽~="不给"  then
	         local 临时资源 = 引擎.取头像(self.累充数据[i].召唤兽)
             self.累充召唤兽[i].小动画 = tp.资源:载入(临时资源[7],"网易WDF动画",临时资源[2])
             local n = 引擎.取战斗模型(self.累充数据[i].召唤兽)
			 self.累充召唤兽[i].大动画= tp.资源:载入(n[10],"网易WDF动画",n[6])
			 self.累充召唤兽[i].名称=self.累充数据[i].召唤兽
		     self.累充召唤兽[i].数量=1
		     self.累充召唤兽[i].介绍="#G/领取"..self.累充数据[i].召唤兽类型..":"..self.累充数据[i].召唤兽
	       end
           if self.累充数据[i].物品~=nil and self.累充数据[i].物品数量~=nil  and self.累充数据[i].物品数量+0>0 then
		      for n=1,self.累充数据[i].物品数量+0 do
		          self.累充物品[i][n] = {}
		          local 资源=引擎.取物品(self.累充数据[i].物品[n].名称)
		          self.累充物品[i][n].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
		          self.累充物品[i][n].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
		          self.累充物品[i][n].名称=self.累充数据[i].物品[n].名称
		          self.累充物品[i][n].数量=self.累充数据[i].物品[n].数量
		          self.累充物品[i][n].介绍=资源[1]
		      end
		   end
      end
   end
end

function 会员福利:显示(dt,x,y)
	self.焦点 = false
	 self.资源组[4]:更新(x,y)
	-- self.资源组[5]:更新(x,y,self.分类 ~= 1)
	-- self.资源组[6]:更新(x,y)
	-- self.资源组[7]:更新(x,y,self.分类 ~= 2)
	-- self.资源组[8]:更新(x,y)
	-- self.资源组[9]:更新(x,y)
	-- self.资源组[10]:更新(x,y)

    if self.资源组[4]:事件判断() then
		self:打开()
	-- elseif self.资源组[5]:事件判断() then
	-- 	self.分类 = 1
	-- elseif self.资源组[6]:事件判断() then
	-- 	请求服务(45,{文本="打开"})
	-- elseif self.资源组[7]:事件判断() then
	-- 	self.分类 = 2
	-- elseif self.资源组[8]:事件判断() then
	-- 	请求服务(45,{文本="查看会员"})
	-- elseif self.资源组[9]:事件判断() then
	-- 	请求服务(45,{文本="查看兑换"})
 --    elseif self.资源组[10]:事件判断() then
	-- 	self.分类 =3


	end
	self.资源组[1]:显示(self.x,self.y)
	-- tp.竖排花纹背景1_:置区域(0,0,18,341)
	-- tp.竖排花纹背景1_:显示(self.x+111,self.y+22)
    self.资源组[2]:显示(self.x+2,self.y+2)
	tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	tp.字体表.标题字体:置字间距(0)
	tp.字体表.标题字体:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"累计充值")
	 self.资源组[4]:显示(self.x+520,self.y+2)
	-- self.资源组[5]:显示(self.x+21,self.y+80,true,nil,nil,self.分类 == 1,2)
	-- self.资源组[6]:显示(self.x+21,self.y+120)
	-- self.资源组[7]:显示(self.x+21,self.y+240,true,nil,nil,self.分类 == 2,2)
	-- self.资源组[8]:显示(self.x+21,self.y+160)
	-- self.资源组[9]:显示(self.x+21,self.y+200)
	-- self.资源组[10]:显示(self.x+21,self.y+40,true,nil,nil,self.分类 == 3,2)



	--if self.分类==1 then
	   self.底图背景:显示(self.x+15,self.y+30)
	   tp.字体表.标题字体:置颜色(黑色):显示(self.x+30,self.y+322,"当前累计充值：")
	   tp.字体表.标题字体:置颜色(红色):显示(self.x+135,self.y+324,self.累计充值)
        if self.累充数据[self.显示档次]~=nil then
		   self.判断长度 = string.len(self.累充数据[self.显示档次].需求充值)
           self.赞助字体:置颜色(白色):显示(self.x+203-(self.判断长度*5),self.y+35,"赞助"..self.累充数据[self.显示档次].需求充值.."$超值大礼包")
           local 动态 = 60
		   if self.累充数据[self.显示档次].货币数量>0 then
			   tp.字体表.标题字体:置颜色(蓝色):显示(self.x+30,self.y+60,"获得"..self.累充数据[self.显示档次].货币类型.."奖励:"..数额尾数转换(self.累充数据[self.显示档次].货币数量))
			   动态 = 85
		    end

		        local zx = 0
	            local zy = 0
	            if self.累充数据[self.显示档次].召唤兽~="不给" then
		       	   if self.累充召唤兽[self.显示档次].小动画~=nil then
		       	     	self.物品背景:显示(self.x+33,self.y+动态)
		       	      self.累充召唤兽[self.显示档次].小动画:显示(self.x+36,self.y+动态+2)
		       	       self.宝石字体:显示(self.x+45,self.y+动态+35,self.累充数据[self.显示档次].召唤兽类型)
		       	      if  self.累充召唤兽[self.显示档次].小动画:是否选中(x,y) then
		                  tp.提示:商城提示(x,y,self.累充召唤兽[self.显示档次].名称,self.累充召唤兽[self.显示档次].介绍,self.累充召唤兽[self.显示档次].大动画,nil,true)
		              end
		              zx=1
		       	   end
		       end
              if self.累充数据[self.显示档次].物品数量>0 then
			        for n =1,self.累充数据[self.显示档次].物品数量 do



			           if self.累充物品[self.显示档次]~=nil and self.累充物品[self.显示档次][n]~=nil and self.累充物品[self.显示档次][n].小动画~=nil then
			           	  self.物品背景:显示(self.x+33+zx*60,self.y+动态+zy*60)
			              self.累充物品[self.显示档次][n].小动画:显示(self.x+34+zx*60,self.y+动态+zy*60)
			              self.宝石字体:显示(self.x+53+zx*60,self.y+动态+34+zy*60,"x"..self.累充物品[self.显示档次][n].数量)
			              if self.累充物品[self.显示档次][n].小动画:是否选中(x,y) then
			                 tp.提示:商城提示(x,y,self.累充物品[self.显示档次][n].名称,self.累充物品[self.显示档次][n].介绍,self.累充物品[self.显示档次][n].大动画)
			              end
			           end
			           zx = zx + 1
			           if zx >=8 then
			              zx = 0
			              zy =zy +1
			           end

			        end
		       end

		         if self.领取累充[self.显示档次]~=nil then
		          self.领取累充[self.显示档次]:更新(x,y,self.累充数据[self.显示档次].需求充值>self.已领充值)
		          self.领取累充[self.显示档次]:显示(self.x+245,self.y+300,true,nil,nil,self.累计充值<self.累充数据[self.显示档次].需求充值,3)
		          if self.累充数据[self.显示档次].需求充值<=self.已领充值 then
		             self.领取累充[self.显示档次].按钮文字="已领奖励"
		          else
		          	self.领取累充[self.显示档次].按钮文字="领取奖励"
		          end
		          if self.领取累充[self.显示档次]:事件判断() and self.累计充值>=self.累充数据[self.显示档次].需求充值 then
		          	if self.显示档次 <= 1 then
		          		请求服务(36,{领取= "领取累充",文本=self.累充数据[self.显示档次].文本,编号=self.累充数据[self.显示档次].编号})
		          	else
		          		if self.已领充值>=self.累充数据[self.显示档次-1].需求充值 then
			          	    请求服务(36,{领取= "领取累充",文本=self.累充数据[self.显示档次].文本,编号=self.累充数据[self.显示档次].编号})
		          	    else
		          	    	local 事件 = function()
			                   请求服务(36,{领取= "领取累充",文本=self.累充数据[self.显示档次].文本,编号=self.累充数据[self.显示档次].编号})
			                end
			                tp.窗口.文本栏:载入("您是否领取#R/"..self.累充数据[self.显示档次].需求充值.."#H/的赞助奖励,#R/注意:你的#Y/"..self.累充数据[self.显示档次-1].需求充值.."#R/赞助奖励还未领取，领取#Y/"..self.累充数据[self.显示档次].需求充值.."#R/的赞助奖励后#Y/"..self.累充数据[self.显示档次-1].需求充值.."#R/的赞助奖励将无法领取",nil,true,事件)




		          	    end
		          	end
		          end
		       end

	           if  self.资源组[1]:是否选中(x,y) then
			        if 引擎.取鼠标滚轮() <0 and self.显示档次<#self.累充数据 then--鼠标上滚动
			            self.显示档次=self.显示档次 + 1
			             if  self.显示档次>#self.累充数据 then
			                self.显示档次=#self.累充数据
			            end
			          elseif 引擎.取鼠标滚轮() > 0  and self.显示档次>1  then--鼠标下滚动
			            self.显示档次=self.显示档次 - 1
			            if self.显示档次 <=1 then--关闭按钮
			                self.显示档次 = 1
			            end
			         end
			    end
			    if self.显示档次<#self.累充数据 then
				   local  箭头y = 34
				   if  os.time()-self.变色时间>=1 then
					   self.变色时间 = os.time()
					   self.初始颜色=self.字体颜色[取随机数(1,#self.字体颜色)]
					   if  箭头y == 34 then
					       箭头y = 36
					   else
					       箭头y = 34
					   end
					end
				   tp.字体表.普通字体:置颜色(self.初始颜色):显示(self.x+480,self.y+箭头y,"↓↓↓")
				 end

                   tp.字体表.标题字体:置颜色(白色)

        end






------------------------------------------------------

	 --    local  箭头y = 25
	 --    if  os.time()-self.变色时间>=1 then
	 --        self.变色时间 = os.time()
	 --        self.初始颜色=self.字体颜色[取随机数(1,#self.字体颜色)]
	 --        if  箭头y == 25 then
	 --          箭头y = 29
	 --        else
	 --          箭头y = 25
	 --        end
	 --    end
  --       tp.字体表.标题字体:置颜色(self.初始颜色):显示(self.x+400,self.y+箭头y,"↓↓↓")
		-- local zy = 0
	 --    for i=1,3 do
	 --       self.资源组[11]:显示(self.x+138,self.y+50+zy*105)
	 --       引擎.画线(self.x+143,self.y+75+zy*105,self.x+438,self.y+75+zy*105,0xFFFFFFFF)
	 --       zy =zy +1
	 --    end


	   -- local jy = 0
	   --  for i = self.开始,self.结束 do
	   --     if self.累充数据[i]~=nil then
	   --     	  if self.累充数据[i].货币数量>0 then
		  --      	   if self.累充数据[i].召唤兽~="不给" then
			 --          tp.字体表.标题字体:置颜色(绿色):显示(self.x+143,self.y+54+jy*105,"赞助"..self.累充数据[i].需求充值.."获得:"..self.累充数据[i].货币类型..数额尾数转换(self.累充数据[i].货币数量).."↓↓→→")
			 --        else
			 --          tp.字体表.标题字体:置颜色(绿色):显示(self.x+143,self.y+54+jy*105,"赞助"..self.累充数据[i].需求充值.."获得:"..self.累充数据[i].货币类型..数额尾数转换(self.累充数据[i].货币数量).."↓↓")
			 --       end
		  --     else
		  --      	  if self.累充数据[i].召唤兽~="不给" then
		  --             tp.字体表.标题字体:置颜色(绿色):显示(self.x+143,self.y+54+jy*105,"赞助"..self.累充数据[i].需求充值.."获得↓↓→→")
			 --      else
			 --           tp.字体表.标题字体:置颜色(绿色):显示(self.x+143,self.y+54+jy*105,"赞助"..self.累充数据[i].需求充值.."获得↓↓")
			 --      end
		  --      end

		  --      if self.累充数据[i].召唤兽~="不给" then
		  --      	   tp.物品格子背景_:显示(self.x+385,self.y+54+jy*105)
		  --      	   if self.累充召唤兽[i].小动画~=nil then
		  --      	      self.累充召唤兽[i].小动画:显示(self.x+388,self.y+57+jy*105)
		  --      	       self.宝石字体:显示(self.x+400,self.y+90+jy*105,self.累充数据[i].召唤兽类型)
		  --      	      if  self.累充召唤兽[i].小动画:是否选中(x,y) then
		  --                 tp.提示:商城提示(x,y,self.累充召唤兽[i].名称,self.累充召唤兽[i].介绍,self.累充召唤兽[i].大动画,nil,true)
		  --             end

		  --      	   end

		  --      end

		  --      if self.领取累充[i]~=nil then
		  --         self.领取累充[i]:更新(x,y,self.累充数据[i].需求充值>self.已领充值)
		  --         self.领取累充[i]:显示(self.x+392,self.y+110+jy*105,true,nil,nil,self.累计充值<self.累充数据[i].需求充值,3)
		  --         if self.领取累充[i]:事件判断() and self.累计充值>=self.累充数据[i].需求充值 then
		  --         	local 事件 = function()
		  --                 请求服务(36,{领取= "领取累充",文本=self.累充数据[i].文本,编号=i})
		  --           end
		  --           tp.窗口.文本栏:载入("你确定领取该档次奖励么?,如果上一档次奖励未领取，领取该档次奖励后会失效，上一档次奖励将无法领取",nil,true,事件)

		  --         end
		  --      end

		  --       local jx = 0
		  --       for n =1,self.累充数据[i].物品数量 do
		  --          tp.物品格子背景_:显示(self.x+143+jx*60,self.y+80+jy*105)
		  --          if self.累充物品[i]~=nil and self.累充物品[i][n]~=nil and self.累充物品[i][n].小动画~=nil then
		  --            self.累充物品[i][n].小动画:显示(self.x+144+jx*60,self.y+81+jy*105)

		  --             self.宝石字体:显示(self.x+163+jx*60,self.y+115+jy*105,"x"..self.累充物品[i][n].数量)
		  --             if self.累充物品[i][n].小动画:是否选中(x,y) then
		  --                tp.提示:商城提示(x,y,self.累充物品[i][n].名称,self.累充物品[i][n].介绍,self.累充物品[i][n].大动画)
		  --             end

		  --          end

		  --         jx = jx +1
		  --       end
		  --      jy = jy +1
		  --  end
	   --  end

	   --    if  self.资源组[1]:是否选中(x,y) or self.资源组[4]:是否选中(x,y) then
		  --       if 引擎.取鼠标滚轮() >0 and  self.结束>3 then--鼠标上滚动
		  --           self.开始=self.开始 - 1
		  --            self.结束 = self.开始 +2
		  --            if  self.结束>#self.累充物品 then
		  --               self.结束=#self.累充物品
		  --               self.开始 = self.结束 - 2
		  --           end
		  --         elseif 引擎.取鼠标滚轮() <0  and self.开始<#self.累充物品-2 then--鼠标下滚动
		  --           self.开始=self.开始 + 1
		  --           self.结束 = self.开始 +2
		  --           if self.开始 <=1 then--关闭按钮
		  --               self.开始 = 1
		  --               self.结束=3
		  --           end
		  --        end
		  --   end



	   --  if  self.资源组[1]:是否选中(x,y) or self.资源组[4]:是否选中(x,y) then
	   --      if 引擎.取鼠标滚轮() >0 and  self.结束>3 then--鼠标上滚动
	   --          self.开始=self.开始 - 1
	   --           self.结束 = self.开始 +2
	   --           if  self.结束>#self.消费说明 then
	   --              self.结束=#self.消费说明
	   --              self.开始 = self.结束 - 2
	   --          end
	   --        elseif 引擎.取鼠标滚轮() <0  and self.开始<#self.消费说明-2 then--鼠标下滚动
	   --          self.开始=self.开始 + 1
	   --          self.结束 = self.开始 +2
	   --          if self.开始 <=1 then--关闭按钮
	   --              self.开始 = 1
	   --              self.结束=3
	   --          end
	   --       end
	   --  end

     --
 --   elseif self.分类 == 3 then
 --   	if self.首充数据~=nil then
	--    	 if self.首充数据.消费说明~=nil then
	--        tp.字体表.普通字体:置颜色(白色):显示(self.x+220,self.y+35, self.首充数据.消费说明)
	--    	 end

	--    	  if self.固定显示~=nil and  #self.固定显示>0 then
	-- 	        local yy = 0
	-- 	        for i=1,#self.固定显示,2 do
	-- 	            if self.固定显示[i]~=nil and self.固定显示[i+1]~=nil  then
	-- 	              tp.字体表.普通字体:置颜色(绿色):显示(self.x+147,self.y+72+yy*23,self.固定显示[i].."      "..self.固定显示[i+1])
	-- 	            elseif self.固定显示[i]~=nil   then
	-- 	              tp.字体表.普通字体:置颜色(绿色):显示(self.x+147,self.y+72+yy*23,self.固定显示[i])
	-- 	            end
	-- 	          yy =yy +1
	-- 	        end
	--        end

	--       local 动态 = 72
	--       if #self.固定显示>=1 then
	--       	if #self.固定显示%2==0 then
	--            动态=动态+23*#self.固定显示/2
	--          else
	--          	动态=动态+23*math.floor(#self.固定显示/2+1)

	--          end
	--       end
	--       if self.首充神兽~=nil then
	--       	tp.字体表.普通字体:置颜色(绿色):显示(self.x+147,self.y+动态,self.首充神兽)
	--       	动态 = 动态 + 23
	--       end
	--     if self.首充物品~=nil and #self.首充物品>0 then
	--       local zx = 0
	--       local zy = 0
	--       for i=1,#self.首充物品 do
	--           if self.首充物品[i]~=nil  and self.首充物品[i].小动画~=nil then
	--             tp.物品格子背景_:显示(self.x+147+zx*75,self.y+动态-3+zy*70)
	--             self.首充物品[i].小动画:显示(self.x+147+zx*75,self.y+动态+zy*70)
	--             self.宝石字体:显示(self.x+167+zx*75,self.y+动态+33+zy*70,"x"..self.首充物品[i].数量)
	--               if  self.首充物品[i].小动画:是否选中(x,y) then
	--                   tp.提示:商城提示(x,y,self.首充物品[i].名称,self.首充物品[i].介绍,self.首充物品[i].大动画)
	--               end

	--               zx = zx + 1
	--               if zx >=4 then
	--                 zx = 0
	--                 zy =zy +1
	--               end
	--           end
	--         end

	--     end
	--     tp.字体表.普通字体:置颜色(白色)







 --   	end

 --   elseif self.分类 == 2 then
 --   	    self.资源组[3]:显示(self.x+137,self.y+32)
	--    	tp.字体表.普通字体:置颜色(黑色):显示(self.x+152,self.y+137,"输入卡号:")
	--    	self.输入框背景:显示(self.x+225,self.y+135)
	--    	self.输入框:置坐标(self.x+228,self.y+138)
	--    	self.输入框:置可视(true,true)
	--    	self.充值按钮:更新(x,y)
	--    	self.充值按钮:显示(self.x+260,self.y+170)
	--    	 if (引擎.按键按住(KEY.CTRL) and 引擎.按键按住(KEY.V)) then
	-- 			self.输入框:置文本(取剪贴板())
	-- 		end

 --       if self.充值按钮:事件判断() then
 --       	if self.输入框:取文本() =="" or self.输入框:取文本() == nil then
 --       		tp.常规提示:打开("#Y/你还未输入卡号")
 --       		return
 --       	end
	--        	请求服务(36,{领取= self.充值按钮:取文字(),卡号 = self.输入框:取文本()})
	--        	return
	--      end






	--   self.控件类:更新(dt,x,y)
	-- 	if self.输入框._已碰撞 then
	-- 	 self.焦点 = true
	-- 	end
	-- 	self.控件类:显示(x,y)

	-- end




end

function 会员福利:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 会员福利:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not 引擎.消息栏焦点 then
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
function 会员福利:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end
return 会员福利
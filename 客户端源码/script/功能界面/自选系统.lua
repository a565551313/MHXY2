local 自选系统 = class()

local floor = math.floor
local min = math.min
local tp,zts1,zts2
local xxx = 0
local yyy = 0
local max = 1
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local wz = require("gge文字类")

function 自选系统:初始化(根)
	self.ID = 110
	--宽高 549 431
	self.文字类=wz
	self.x = 300
	self.y = 150
	self.xx = 0
	self.yy = 0
	self.注释 = "自选系统"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.状态 = 1
	self.窗口时间 = 0
	tp = 根
	zts2 = tp.字体表.普通字体
	local 资源 = tp.资源
    local 自适应 = tp._自适应
	local 按钮 = tp._按钮
	self.资源组 = {
			[1] = 自适应.创建(0,1,300,185,3,9),
			[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
			[3] = 自适应.创建(1,1,296,18,1,3,nil,18),--标题背景
			[4] = 按钮.创建(自适应.创建(12,4,48,20,1,3),0,0,4,true,true,"确定"),
			[5]= 自适应.创建(3,1,200,18,1,3),
			[6]= 自适应.创建(3,1,100,18,1,3),
			}

	self.特技下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.特技下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,300,3,9),"") --分类选项
	self.特效下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.特效下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,185,145,3,9),"") --分类选项


	self.双加1下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.双加1下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,85,105,3,9),"") --分类选项

	self.双加2下拉 = 按钮.创建(自适应.创建(21,4,18,19,4,3),0,0,4,true,true) --子类下拉按钮
	self.双加2下拉列表= 根._小型选项栏.创建(自适应.创建(105,1,85,105,3,9),"") --分类选项

	self.双加1=""
	self.双加2=""
	self.已选特效=""
	self.已选特技=""
	self.装备特效 = {"无级别限制","神佑","珍宝","必中","神农","简易","绝杀","专注","精致","再生"}
	self.装备特技 = {"气疗术","心疗术","命疗术","凝气诀","气归术","命归术","四海升平","回魂咒","起死回生",
                      "水清诀","冰清诀","玉清诀","晶清诀","弱点击破","冥王暴杀","放下屠刀","河东狮吼","碎甲术",
                      "破甲术","破血狂攻","慈航普渡","笑里藏刀","罗汉金钟","破碎无双","圣灵之甲","野兽之力","琴音三叠"}

  self.级别 = 0
  self.部位="随机"
end

function 自选系统:打开(数据)

	if self.可视 then
		self.可视 = false
		self.已选特效=""
	    self.已选特技=""
	    self.部位="随机"
	    self.双加1=""
	    self.双加2=""
		return
	else
		insert(tp.窗口_,self)
		self.级别= 数据.级别
		self.已选特效=""
	    self.已选特技=""
	    self.部位="随机"
	    self.双加1=""
	    self.双加2=""
	    if self.双加1下拉列表.可视 then
	     	self.双加1下拉列表:打开()
	    end
	    if self.双加2下拉列表.可视 then
	     	self.双加2下拉列表:打开()
	    end
	    if self.特技下拉列表.可视 then
	     	self.特技下拉列表:打开()
	    end
	    if self.特效下拉列表.可视 then
	     	self.特效下拉列表:打开()
	    end
	    if 数据.部位~=nil then
	    	self.部位=数据.部位
	    end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end


function 自选系统:显示(dt,x,y)

	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
	zts2:置字间距(2)
	zts2:置颜色(白色)
	zts2:显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"自选礼包")
	zts2:置字间距(0)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x+285,self.y+2)
	self.资源组[4]:更新(x,y)
	self.资源组[4]:显示(self.x+135,self.y+150)
	self.双加1下拉:更新(x,y,self.部位=="武器" or self.部位=="衣服" or self.部位=="随机")
	self.双加2下拉:更新(x,y,self.部位=="武器" or self.部位=="衣服" or self.部位=="随机")
	self.特技下拉:更新(x,y)
	self.特效下拉:更新(x,y)
	if self.资源组[2]:事件判断() then
		self:打开()
	elseif self.资源组[4]:事件判断() then
		if self.已选特技== nil or self.已选特技==""  then
			tp.常规提示:打开("#Y/请选择特技")
		elseif self.已选特效== nil or self.已选特效==""  then
			tp.常规提示:打开("#Y/请选择特效")
		else
		  请求服务(3740,{等级=self.级别,特技 =self.已选特技,特效=self.已选特效,双加1=self.双加1,双加2=self.双加2})
		  self:打开()
		end

	end
	zts2:显示(self.x+10,self.y+32,"当前部位:  "..self.部位.."    礼包等级: "..self.级别.." 级")
	zts2:显示(self.x+10,self.y+62,"双加")
	zts2:显示(self.x+150,self.y+62,"双加")
	zts2:显示(self.x+10,self.y+92,"选择特技")
	zts2:显示(self.x+10,self.y+122,"选择特效")
	self.资源组[5]:显示(self.x+75,self.y+90)
	self.资源组[5]:显示(self.x+75,self.y+120)
	self.资源组[6]:显示(self.x+45,self.y+60)
	self.资源组[6]:显示(self.x+185,self.y+60)
	self.双加1下拉:显示(self.x+127,self.y+62)
	self.双加2下拉:显示(self.x+267,self.y+62)
	self.特技下拉:显示(self.x+257,self.y+92)
	self.特效下拉:显示(self.x+257,self.y+122)


	self.双加1下拉列表:显示(self.x+45,self.y+80,x,y,true)
 	self.双加2下拉列表:显示(self.x+185,self.y+80,x,y,true)
 	self.特技下拉列表:显示(self.x+75,self.y+114,x,y,true)
 	self.特效下拉列表:显示(self.x+75,self.y+144,x,y,true)


	  zts2:置颜色(黑色)
	  if   self.双加1~=nil and   self.双加1~="" then
	  	zts2:显示(self.x+50,self.y+62,self.双加1)
	  end

	  if  self.双加2~=nil and  self.双加2~="" then
	  	  zts2:显示(self.x+190,self.y+62,self.双加2)
	  end




	  if   self.已选特技~=nil and   self.已选特技~="" then
	  	zts2:显示(self.x+80,self.y+92,self.已选特技)
	  end

	  if  self.已选特效~=nil and   self.已选特效~="" then
	  	  zts2:显示(self.x+80,self.y+122,self.已选特效)
	  end


	 if  self.特技下拉:事件判断() then
      	 self.特技下拉列表:打开(self.装备特技)
     elseif self.特效下拉:事件判断() then
      	  self.特效下拉列表:打开(self.装备特效)
     elseif self.双加1下拉:事件判断() then
     	 local 临时列表 = {"体质","力量","耐力","魔力","敏捷"}
     	 if self.双加2~=nil and self.双加2~="" then
     	 	for i=1,#临时列表 do
     	 		if 临时列表[i]==self.双加2 then
     	 			table.remove(临时列表, i)
     	 			break
     	 		end
     	 	end
     	 end
     	 self.双加1下拉列表:打开(临时列表)
      elseif self.双加2下拉:事件判断() then
      	 local 临时列表 = {"体质","力量","耐力","魔力","敏捷"}
      	 if self.双加1~=nil and self.双加1~="" then
     	 	for i=1,#临时列表 do
     	 		if 临时列表[i]==self.双加1 then
     	 			table.remove(临时列表, i)
     	 			break
     	 		end
     	 	end
     	 end
      	  self.双加2下拉列表:打开(临时列表)

      elseif self.特技下拉列表:事件判断() then
		  self.已选特技=self.特技下拉列表.弹出事件
		  self.特技下拉列表.弹出事件=nil
	  elseif self.特效下拉列表:事件判断() then
		  self.已选特效=self.特效下拉列表.弹出事件
		  self.特效下拉列表.弹出事件=nil
	  elseif self.双加1下拉列表:事件判断() then
	  	  if self.双加2~=nil and self.双加2~="" and self.双加2==self.双加1下拉列表.弹出事件 then
	  	  	tp.常规提示:打开("#Y/两个双加属性不可以一样")
	  	  else
			  self.双加1=self.双加1下拉列表.弹出事件
		  end
		  self.双加1下拉列表.弹出事件=nil

	 elseif self.双加2下拉列表:事件判断() then
	 	 if self.双加1~=nil and self.双加1~="" and self.双加1==self.双加2下拉列表.弹出事件 then
	 	 	tp.常规提示:打开("#Y/两个双加属性不可以一样")
	  	  else
			  self.双加2=self.双加2下拉列表.弹出事件
		  end
		  self.双加2下拉列表.弹出事件=nil

	  end







end












function 自选系统:检查点(x,y)
	if self.资源组[1] ~= nil and  self.资源组[1]:是否选中(x,y) then
		return true
	end
end

function 自选系统:初始移动(x,y)
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

function 自选系统:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 自选系统
--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2024-05-31 17:13:02
--============================,==========================================--
local 超级兽决获得 = class()


local zts,tp
local insert = table.insert

function 超级兽决获得:初始化(根)
	self.ID = 151
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "超级兽决获得"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
			[1] = 资源:载入(wdf配置.."/pic/超级兽决背景.png","图片"),
			[2] = 资源:载入(wdf配置.."/pic/超级兽决关闭.png","图片"),
			[3] = 资源:载入(wdf配置.."/pic/超级兽决名称.png","图片"),
	}

	self.字体 = tp.字体表.普通字体
	self.打开时间 =os.time()
end

function 超级兽决获得:打开(名称)
	if self.可视 then
		self.可视 = false
		return
	else

		self:刷新(名称)
		insert(tp.窗口_,self)
	    tp.运行时间 = tp.运行时间 + 1
	    self.窗口时间 = tp.运行时间
	    self.可视 = true
	    self.x=math.floor(全局游戏宽度/2-220)
		self.y =math.floor(全局游戏高度/2-140)
        self.打开时间 =os.time()

	end
end

function 超级兽决获得:刷新(名称)
	      self.显示名称=""
	     self.显示背景=false

	     if 名称~=nil then
	     	local  临时名称 = 分割字符(名称)
	     	if #临时名称>4 then
	     		self.显示背景=true
	     	end
	     	for i=1,#临时名称 do
	     		self.显示名称=self.显示名称..临时名称[i].."\n"
	     	end
	     end
         self.打开时间 =os.time()
end




function 超级兽决获得:显示(dt,x,y)
	self.焦点 = false

	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:显示(self.x+405,self.y+28)
	if self.资源组[2]:是否选中(x,y) and 引擎.鼠标弹起(0)  then--鼠标上滚
	   self:打开()
       return
	end
	if self.显示背景 then
		self.资源组[3]:显示(self.x+300,self.y+93)
	end

 	self.字体:置颜色(黄色):显示(self.x+306,self.y+107,self.显示名称)





    if os.time()-self.打开时间>=5 then
       self:打开()
       return
    end



end

function 超级兽决获得:检查点(x,y)
	if self.可视 and  self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 超级兽决获得:初始移动(x,y)
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

function 超级兽决获得:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 超级兽决获得
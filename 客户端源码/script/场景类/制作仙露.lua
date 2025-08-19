--======================================================================--
local 制作仙露 = class()
local floor = math.floor
local insert = table.insert
local zts,tp,zts1



local 可选项目 ={}
function 制作仙露:初始化(根)
	self.ID = 150
	self.x = 200
	self.y = 156
	self.xx = 0
	self.yy = 0
	self.注释 = "制作仙露"
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

		[1] = 资源:载入(wdf配置.."/pic/仙露丸子合成.png","图片"),
		[2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
	    [3] =  按钮.创建(自适应.创建(12,4,80,20,1,1),0,0,4,true,true,"确定制作"),


	}
    self.资源组[2]:绑定窗口_(150)
    self.资源组[3]:绑定窗口_(150)

    local 丸子资源=引擎.取物品("仙露小丸子")
	self.丸子动画= 资源:载入(丸子资源[11],"网易WDF动画",丸子资源[12])
	local 神兽资源=引擎.取物品("神兽涎")
	self.神兽动画= 资源:载入(神兽资源[11],"网易WDF动画",神兽资源[12])



	local 格子 = tp._物品格子
	self.物品 = {}
	for i=1,100 do
		self.物品[i] = 格子(0,0,i,"仙露制作")
	end


	zts1 = tp.字体表.描边字体
	zts = tp.字体表.普通字体
	self.宝石字体= tp.字体表.描边字体__
	self.宝石字体:置颜色(0xFFFFFFFF)
	self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)



end

function 制作仙露:打开()
	if self.可视 then
		self.可视 = false
		return
	else
		self.丸子需求=10
		self.神兽需求=1
		self.需求体力=100
		self:刷新道具()
		insert(tp.窗口_,self)
	    tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
	    self.可视 = true

	end
end







function 制作仙露:刷新道具()


	self.丸子数量=0
	self.神兽数量=0
	self.当前体力= tp.队伍[1].体力 or 0
	for n=1,100 do
		self.物品[n]:置物品(tp.道具列表[n])
		if tp.道具列表[n]~=nil and tp.道具列表[n].名称=="仙露小丸子" then
			self.丸子数量=self.丸子数量+tp.道具列表[n].数量
		elseif tp.道具列表[n]~=nil and tp.道具列表[n].名称=="神兽涎" then
			self.神兽数量=self.神兽数量+tp.道具列表[n].数量
		end
	end




end




function 制作仙露:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x + 450,self.y+2)
	self.资源组[3]:更新(x,y,self.丸子数量>=self.丸子需求 and self.神兽数量>=self.神兽需求 and self.当前体力>=self.需求体力)
    self.资源组[3]:显示(self.x + 67,self.y+218)

     if self.资源组[3]:事件判断() then
          请求服务(3747)
     elseif self.资源组[2]:事件判断() then
			self:打开()
     end
		self.丸子动画:显示(self.x+43,self.y+75)
        local 丸子字体 = self.丸子数量.."/"..self.丸子需求
        local 丸子坐标=math.floor(string.len(丸子字体)*3)
        self.宝石字体:显示(self.x+64-丸子坐标,self.y+110,丸子字体)

        self.神兽动画:显示(self.x+133,self.y+75)
        local 神兽字体 = self.神兽数量.."/"..self.神兽需求
        local 神兽坐标=math.floor(string.len(神兽字体)*3)
        self.宝石字体:显示(self.x+154-神兽坐标,self.y+110,神兽字体)


       zts:置颜色(黑色):显示(self.x+90,self.y+168,self.需求体力)
	   zts:置颜色(黑色):显示(self.x+90,self.y+195,self.当前体力)



     local xxx = 0
		local yyy = 0
	    for n= 1, 20 do
		    self.物品[n]:置坐标(self.x+207+xxx*51,self.y+33+yyy*51)
			if self.物品[n].物品~=nil then
			    self.物品[n]:显示(dt,x,y,self.鼠标)
			    if self.物品[n].物品.名称~="仙露小丸子" and self.物品[n].物品.名称~="神兽涎" then
		         		tp.物品格子禁止_:显示(self.x+212+xxx*51,self.y+38+yyy*51)
		         end
			    if self.物品[n].焦点 and self.鼠标  and not tp.消息栏焦点 then
					 tp.提示:道具行囊(x,y,self.物品[n].物品)
				end
			end
				xxx = xxx + 1
				if xxx>=5 then
					xxx = 0
					yyy = yyy +1
			    end
		end








end
function 制作仙露:检查点(x,y)


	if self.可视  and self.资源组[1]:是否选中(x,y)  then
       self.焦点 =false
		return true
	end
	return false
end




function 制作仙露:初始移动(x,y)

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

function 制作仙露:开始移动(x,y)
	if self.可视 and self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end










return 制作仙露
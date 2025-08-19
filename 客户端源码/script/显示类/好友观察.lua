local 好友观察 = class()

local tp,zts,zts1
local tx = 引擎.取头像
local mouseb = 引擎.鼠标弹起
local insert = table.insert
local qms = 引擎.取模型
local zqj = 引擎.坐骑库
local bw = require("gge包围盒")
local zts
local tp;
local qms = 引擎.取模型
local mouseb = 引擎.鼠标弹起
local zqj = 引擎.坐骑库
local 临时资源
local 临时资源包
local n,m
function 好友观察:初始化(根)
  self.ID = 106
  self.x = 100
  self.y = 100
  self.xx = 0
  self.yy = 0
  self.注释 = "好友查看类"
  self.可视 = false
  self.鼠标 = false
  self.焦点 = false
  self.可移动 = true
  local 资源 = 根.资源
  local 按钮 = 根._按钮
  local 自适应 = 根._自适应
  self.资源组 = {
      [1] = 自适应.创建(0,1,250,310,3,9),
      [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
      [3] = 自适应.创建(1,1,246,18,1,3,nil,18),   --标题头  -4
      [4] = 自适应.创建(2,1,128,160,3,9),
      [5] = 自适应.创建(2,1,238,90,3,9),
    }
    self.装备底图 ={
            [1] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAB3BFB4B),
      [2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x8F00251E),
      [3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xD7321A7B),
      [4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x219FF008),
      [5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF611EC24),
      [6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF55CDE6D),
    }
    self.装备坐标={
    [1]={x=10,y=30},   --头盔
    [2]={x=194,y=30},    --项链
    [3]={x=10,y=85},    --武器
    [4]={x=194,y=85},   --衣服
    [5]={x=10,y=140},  --腰带
    [6]={x=194,y=140}   --鞋子
}


  self.资源组[2]:绑定窗口_(106)
  self.窗口时间 = 0
  tp = 根
  zts = tp.字体表.普通字体
  zts1 = tp.字体表.描边字体
	self.物品数据 = {}
	local 格子 = 根._物品格子
  local 底图 =资源:载入('登陆资源.wdf',"网易WDF动画",0xA393A808)
	for i=1,6 do
		self.物品数据[i] = 格子.创建(0,0,i,"出售",底图)
	end


 end



function 好友观察:置人物形象(人物)
  self.武器模型 = nil
  self.模型身体 = nil
  self.光环 = nil
  local 是否战斗锦衣 = false
  local v
  if 人物.装备[3]~=nil then
         v = tp:取武器子类(人物.装备[3].子类)
          if 人物.装备[3].名称 == "龙鸣寒水" or 人物.装备[3].名称 == "非攻" then
            v = "弓弩1"
          end
      end
      local 资源 = 引擎.取模型(人物.模型,v)
      if 人物.锦衣[1] ~= nil and 人物.锦衣[1].名称 ~= nil then
        local 锦衣名称 = 人物.锦衣[1].名称
        if 锦衣名称=="青春" or 锦衣名称=="素颜" or 锦衣名称=="绝色" or 锦衣名称=="春秋" or  锦衣名称=="夏蚕"
          or 锦衣名称=="星河" or 锦衣名称=="白峨" or 锦衣名称=="糖果" or 锦衣名称=="青涩" or 锦衣名称=="傲然"
          or 锦衣名称=="牛仔" or  锦衣名称=="试剑" or 锦衣名称=="骨龙战骑" or 锦衣名称=="水嘟嘟·钻白" or 锦衣名称=="斗战神"
          or  锦衣名称=="斗战胜佛" or  锦衣名称=="八部天龙马·玄" or  锦衣名称=="龙凰·桃" or  锦衣名称=="龙凰·皑"  then
          资源 =引擎.取战斗锦衣素材(人物.锦衣[1].名称,人物.模型)
            self.模型身体 =  tp.资源:载入(资源[5],"网易WDF动画",资源[3])
            self.模型身体:置方向(4)
            是否战斗锦衣 = true
        elseif 新加战斗锦衣[锦衣名称]~=nil  then
          local m =""
          if 人物.装备[3] ~= nil then
              m = tp:取武器附加名称(人物.装备[3].子类,人物.装备[3].级别限制,人物.装备[3].名称)
          end
           local 模型类型 = 取角色锦衣武器类型(self.模型,m)
                 资源 = 引擎.取武器锦衣素材(人物.锦衣[1].名称,人物.模型,模型类型)
                 self.模型身体 =  tp.资源:载入(资源[5],"网易WDF动画",资源[3])
             self.模型身体:置方向(4)
        end
      else
            self.模型身体 =  tp.资源:载入(资源[3],"网易WDF动画",资源[1])
            self.模型身体:置方向(4)
      end
      if 人物.锦衣[2] ~= nil and 人物.锦衣[2].名称 ~= nil and self.模型身体~= nil then
          local 资源3 = 引擎.取光环(人物.锦衣[2].名称)
          self.光环=tp.资源:载入(资源3[4],"网易WDF动画",资源3[1])
      end

      if 人物.装备[3] ~= nil then
        local m = tp:取武器附加名称(人物.装备[3].子类,人物.装备[3].级别限制,人物.装备[3].名称)
        local n = 引擎.取模型(m.."_"..人物.模型)
         self.武器模型 = tp.资源:载入(n[3],"网易WDF动画",n[1])
        if 人物.装备[3].染色方案~=0 and 人物.装备[3].染色组~=nil and 人物.装备[3].染色组~=0  and #人物.装备[3].染色组>0 then
            self.武器模型:置染色(人物.装备[3].染色方案,人物.装备[3].染色组[1],人物.装备[3].染色组[2],人物.装备[3].染色组[3])
        end
        self.武器模型:置方向(4)
        if 是否战斗锦衣 then
          self.武器模型 = nil
        end
      end




end






function 好友观察:打开(数据)
  if self.可视 then
    self.可视 = false
  else

    insert(tp.窗口_,self)
    self.选中 = 0
    self.加入 = 0
    tp.运行时间 = tp.运行时间 + 1
    self.窗口时间 = tp.运行时间
    self.可视 = true
    self.数据=数据
		for i=1,6 do
			self.物品数据[i]:置物品(self.数据.装备[i])
		end
    self:置人物形象(self.数据)
  end
end
function 好友观察:显示(dt,x,y)
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    self.资源组[2]:更新(x,y)
    self.资源组[2]:显示(self.x+230,self.y+2)
    self.资源组[4]:显示(self.x+62,self.y+32)
    self.资源组[5]:显示(self.x+6,self.y+198)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts1:置颜色(白色)
    zts1:置字间距(3)
    zts1:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"查看装备")
    zts1:置字间距(0)

    if self.资源组[2]:事件判断()  then
       self:打开()
    end
    for i=1,6 do
          self.装备底图[i]:显示(self.x+self.装备坐标[i].x-2,self.y+self.装备坐标[i].y)
      		if self.物品数据[i].物品 ~= nil then
        		self.物品数据[i]:置坐标(self.x+self.装备坐标[i].x,self.y+self.装备坐标[i].y)
        		self.物品数据[i]:显示(dt,x,y,self.鼠标)
        			if self.物品数据[i].焦点 and self.物品数据[i].物品 ~= nil then
        				tp.提示:道具行囊(x,y,self.物品数据[i].物品)
        			end
      		end
      end

     if self.模型身体~=nil then
        if  self.光环~=nil then
            self.光环:更新(dt)
            self.光环:显示(self.x + 125,self.y + 165)
        end
        tp.影子:显示(self.x + 120,self.y + 168)
        self.模型身体:更新(dt)
        self.模型身体:显示(self.x + 125,self.y + 165)
        if  self.武器模型~=nil then
            self.武器模型:更新(dt)
            self.武器模型:显示(self.x + 125,self.y + 165)
        end

      end
      zts:置颜色(蓝色)
      zts:显示(self.x+20,self.y+215,"名称:"..self.数据.名称)
      zts:显示(self.x+20,self.y+239,"I D:"..self.数据.id)
      zts:显示(self.x+20,self.y+260,"等级:"..self.数据.等级)
      zts:置颜色(白色)



end

function 好友观察:检查点(x,y)
	if self.资源组[1]:是否选中(x,y)  then
		return true
	end
end

function 好友观察:初始移动(x,y)
	tp.运行时间 = tp.运行时间 + 1
	if not tp.消息栏焦点 then
  		self.窗口时间 = tp.运行时间
 	end
	if not self.焦点 then
		tp.移动窗口 = true
	end
	if self.鼠标 and not self.焦点 then
		self.xx = x - self.x
		self.yy = y - self.y
	end
end

function 好友观察:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy
	end
end

return 好友观察
-- @Author: 作者QQ2308873645
-- @Date:   2021-11-27 13:12:32
-- @Last Modified by:   作者QQ381990860
-- @Last Modified time: 2025-01-23 22:26:01
local 每日查看 = class()
local tp,zts

function 每日查看:初始化(根)
    self.ID = 112
    self.x = 180
    self.y = 90
    self.xx = 0
    self.yy = 0
    self.注释 = "每日查看"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 资源 = 根.资源
    local 按钮 = 根._按钮
    local 自适应 = 根._自适应
    self.资源组 = {
        [1] = 自适应.创建(0,1,540,335,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
        [3] = 自适应.创建(1,1,536,18,1,3,nil,18),

    }

    self.月卡领取 = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"领取奖励")
    -- self.月卡按钮 = {
    --     [1] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"领取奖励"),
    --     [2] = 按钮.创建(自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"购买月卡"),
    -- }

    -- for i=1,2 do
    --     self.月卡按钮[i]:绑定窗口_(672)
    -- end
    self.物品背景 = 资源:载入(wdf配置.."/pic/打造方格.png", "图片")
    self.底图背景 =  自适应.创建(4,1,510,290,3,nil)

    self.输入框背景 = 自适应.创建(3,1,225,18,1,3)
    self.兑换按钮={}



    tp = 根
    self.宝石字体= tp.字体表.描边字体__
    self.宝石字体:置颜色(0xFFFFFFFF)
    self.宝石字体:置描边颜色(0xfff741940)--xFFaf140c)
    zts=tp.字体表.标题字体

    self.资源组[2]:绑定窗口_(112)
    self.窗口时间 = 0

    self.标题名称="查看会员"
    self.月卡 = {}
    self.购买时间 = "未购买会员卡"
    self.到期时间 = "未购买会员卡"
    self.领取时间 = "未领取奖励"
    self.玩家货币=0
    self.月卡物品={}
    self.消费说明=""
    --self.固定显示={}
    self.月卡价格 = 0
    self.月卡货币 = "银子"
    self.控件类 = require("ggeui/加载类")()
    local 总控件 = self.控件类:创建控件('充值兑换控件')
    总控件:置可视(true,true)
    self.输入框 = {}
    for i = 1,10 do
       self.输入框[i] = 总控件:创建输入("兑换数量输入"..i,0,0,210,14)
       self.输入框[i]:置可视(false,false)
       self.输入框[i]:置光标颜色(-16777216)
       self.输入框[i]:置数字模式()
       self.输入框[i]:置文字颜色(-16777216)
    end
    self.兑换数据 = {}






end

function 每日查看:打开(数据)

    if self.可视 then
        self.可视 = false
        for i = 1,10 do
          self.输入框[i]:置焦点(false)
          self.输入框[i]:置可视(false,false)
        end
    else
        table.insert(tp.窗口_,self)
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
        self.标题名称 = 数据.标题
        if 数据.消费说明~=nil then
          self.消费说明 =数据.消费说明
        end
        if 数据.月卡价格~= nil then
          self.月卡价格 = 数据.月卡价格
        end
        if 数据.月卡货币~=nil then
          self.月卡货币 = 数据.月卡货币
        end
        if 数据.月卡 ~= nil then
             self.月卡 = 数据.月卡
             self.月卡.购买时间 = self.月卡.购买时间 + 0
             self.月卡.到期时间 = self.月卡.到期时间 +0
            if self.月卡.购买时间 == 0 then
               self.购买时间 = "未购买月卡"
            else
              self.购买时间 = os.date("%Y", self.月卡.购买时间).."年"..os.date("%m", self.月卡.购买时间).."月"..os.date("%d", self.月卡.购买时间).."日"
            end
            if self.月卡.到期时间 == 0 then
               self.到期时间 = "未购买月卡"
            else
               self.到期时间 = os.date("%Y", self.月卡.到期时间).."年"..os.date("%m", self.月卡.到期时间).."月"..os.date("%d", self.月卡.到期时间).."日"
            end
               self.领取时间 = self.月卡.当前领取
            if self.领取时间 ==  os.date("%j")  then
               self.领取时间 = "已领取奖励"
            else
               self.领取时间 = "未领取奖励"
            end
        end
        if 数据.玩家货币~= nil then
          self.玩家货币 = 数据.玩家货币
        end
        self.月卡物品={}
        if 数据.物品~=nil and 数据.物品数量~=nil  and 数据.物品数量+0>0 then
          for i=1,数据.物品数量+0 do
            self.月卡物品[i] = {}
            local 资源=引擎.取物品(数据.物品[i].名称)
            self.月卡物品[i].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
            self.月卡物品[i].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
            self.月卡物品[i].名称=数据.物品[i].名称
            self.月卡物品[i].数量=tonumber(数据.物品[i].数量)
            self.月卡物品[i].介绍=资源[1]
          end

        end
       -- self.固定显示={}

        if 数据.经验~=nil and 数据.经验>0 then
         -- self.固定显示[#self.固定显示+1] ="领取经验:"..数额尾数转换(数据.经验)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙丹")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="经验"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.经验)
          self.月卡物品[临时编号].介绍="#Y/领取经验:"..数额尾数转换(数据.经验)
        end

        if 数据.储备~=nil and  数据.储备>0 then
        --  self.固定显示[#self.固定显示+1] ="领取储备:"..数额尾数转换(数据.储备)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("储备")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="储备"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.储备)
          self.月卡物品[临时编号].介绍="#Y/领取储备:"..数额尾数转换(数据.储备)
        end

        if 数据.银子~=nil and 数据.银子>0 then
        --  self.固定显示[#self.固定显示+1] ="领取银子:"..数额尾数转换(数据.银子)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("银子")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="银子"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.银子)
          self.月卡物品[临时编号].介绍="#Y/领取银子:"..数额尾数转换(数据.银子)
        end

        if 数据.仙玉~=nil and 数据.仙玉>0 then
         -- self.固定显示[#self.固定显示+1] ="领取仙玉:"..数额尾数转换(数据.仙玉)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙玉")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="仙玉"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.仙玉)
          self.月卡物品[临时编号].介绍="#Y/领取仙玉:"..数额尾数转换(数据.仙玉)
        end

        if 数据.点卡~=nil and 数据.点卡>0 then
        --  self.固定显示[#self.固定显示+1] ="领取点卡:"..数额尾数转换(数据.点卡)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙玉")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="点卡"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.点卡)
          self.月卡物品[临时编号].介绍="#Y/领取点卡:"..数额尾数转换(数据.点卡)
        end
           if 数据.抓鬼~=nil and 数据.抓鬼>0 then
           -- self.固定显示[#self.固定显示+1] ="领取抓鬼:"..数额尾数转换(数据.抓鬼)
              local 临时编号 = #self.月卡物品+1
              self.月卡物品[临时编号]={}
              local 资源=引擎.取物品("会员卡")
              self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
              self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
              self.月卡物品[临时编号].名称="自动抓鬼"
              self.月卡物品[临时编号].数量=数额尾数转换(数据.抓鬼)
              self.月卡物品[临时编号].介绍="#Y/领取抓鬼:"..数额尾数转换(数据.抓鬼)
        end
        self.兑换数据 = {}
        self.兑换按钮 = {}
        if 数据.配置数据~=nil and #数据.配置数据>0 then
           self.兑换数据 = 数据.配置数据
            for i = 1,#数据.配置数据 do
              self.输入框[i]:置文本("")
              self.输入框[i]:置数字模式()
              self.输入框[i]:置可视(false,false)
              self.兑换按钮[i] = tp._按钮.创建(tp._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"确定兑换")
              self.兑换按钮[i]:绑定窗口_(112)
            end
         end

  end


end

function 每日查看:刷新(数据)
       self.标题名称 = 数据.标题
        if 数据.消费说明~=nil then
          self.消费说明 =数据.消费说明
        end
        if 数据.月卡价格~= nil then
          self.月卡价格 = 数据.月卡价格
        end
        if 数据.月卡货币~=nil then
          self.月卡货币 = 数据.月卡货币
        end
        if 数据.月卡 ~= nil then
             self.月卡 = 数据.月卡
             self.月卡.购买时间 = self.月卡.购买时间 + 0
             self.月卡.到期时间 = self.月卡.到期时间 +0
            if self.月卡.购买时间 == 0 then
               self.购买时间 = "未购买月卡"
            else
              self.购买时间 = os.date("%Y", self.月卡.购买时间).."年"..os.date("%m", self.月卡.购买时间).."月"..os.date("%d", self.月卡.购买时间).."日"
            end
            if self.月卡.到期时间 == 0 then
               self.到期时间 = "未购买月卡"
            else
               self.到期时间 = os.date("%Y", self.月卡.到期时间).."年"..os.date("%m", self.月卡.到期时间).."月"..os.date("%d", self.月卡.到期时间).."日"
            end
               self.领取时间 = self.月卡.当前领取
            if self.领取时间 ==  os.date("%j")  then
               self.领取时间 = "已领取奖励"
            else
               self.领取时间 = "未领取奖励"
            end
        end
        if 数据.玩家货币~= nil then
          self.玩家货币 = 数据.玩家货币
        end
        self.月卡物品={}
        if 数据.物品~=nil and 数据.物品数量~=nil  and 数据.物品数量+0>0 then
          for i=1,数据.物品数量+0 do
            self.月卡物品[i] = {}
            local 资源=引擎.取物品(数据.物品[i].名称)
            self.月卡物品[i].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
            self.月卡物品[i].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
            self.月卡物品[i].名称=数据.物品[i].名称
            self.月卡物品[i].数量=tonumber(数据.物品[i].数量)
            self.月卡物品[i].介绍=资源[1]
          end
        end
       -- self.固定显示={}

        if 数据.经验~=nil and 数据.经验>0 then
         -- self.固定显示[#self.固定显示+1] ="领取经验:"..数额尾数转换(数据.经验)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙丹")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="经验"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.经验)
          self.月卡物品[临时编号].介绍="#Y/领取经验:"..数额尾数转换(数据.经验)
        end

        if 数据.储备~=nil and  数据.储备>0 then
        --  self.固定显示[#self.固定显示+1] ="领取储备:"..数额尾数转换(数据.储备)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("储备")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="储备"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.储备)
          self.月卡物品[临时编号].介绍="#Y/领取储备:"..数额尾数转换(数据.储备)
        end

        if 数据.银子~=nil and 数据.银子>0 then
        --  self.固定显示[#self.固定显示+1] ="领取银子:"..数额尾数转换(数据.银子)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("银子")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="银子"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.银子)
          self.月卡物品[临时编号].介绍="#Y/领取银子:"..数额尾数转换(数据.银子)
        end

        if 数据.仙玉~=nil and 数据.仙玉>0 then
         -- self.固定显示[#self.固定显示+1] ="领取仙玉:"..数额尾数转换(数据.仙玉)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙玉")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="仙玉"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.仙玉)
          self.月卡物品[临时编号].介绍="#Y/领取仙玉:"..数额尾数转换(数据.仙玉)
        end

        if 数据.点卡~=nil and 数据.点卡>0 then
        --  self.固定显示[#self.固定显示+1] ="领取点卡:"..数额尾数转换(数据.点卡)
          local 临时编号 = #self.月卡物品+1
          self.月卡物品[临时编号]={}
          local 资源=引擎.取物品("仙玉")
          self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
          self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
          self.月卡物品[临时编号].名称="点卡"
          self.月卡物品[临时编号].数量=数额尾数转换(数据.点卡)
          self.月卡物品[临时编号].介绍="#Y/领取点卡:"..数额尾数转换(数据.点卡)
        end
        if 数据.抓鬼~=nil and 数据.抓鬼>0 then
           -- self.固定显示[#self.固定显示+1] ="领取抓鬼:"..数额尾数转换(数据.抓鬼)
              local 临时编号 = #self.月卡物品+1
              self.月卡物品[临时编号]={}
              local 资源=引擎.取物品("会员卡")
              self.月卡物品[临时编号].小动画=tp.资源:载入(资源[11],"网易WDF动画",资源[12])
              self.月卡物品[临时编号].大动画=tp.资源:载入(资源[11],"网易WDF动画",资源[13])
              self.月卡物品[临时编号].名称="自动抓鬼"
              self.月卡物品[临时编号].数量=数额尾数转换(数据.抓鬼)
              self.月卡物品[临时编号].介绍="#Y/领取抓鬼:"..数额尾数转换(数据.抓鬼)
        end
        self.兑换数据 = {}
        self.兑换按钮 = {}
        for i=1,10 do
          self.输入框[i]:置文本("")
          self.输入框[i]:置数字模式()
          self.输入框[i]:置可视(false,false)
        end
        if 数据.配置数据~=nil and #数据.配置数据>0 then
           self.兑换数据 = 数据.配置数据
            for i = 1,#数据.配置数据 do
              self.兑换按钮[i] = tp._按钮.创建(tp._自适应.创建(12,4,72,20,1,3),0,0,4,true,true,"确定兑换")
              self.兑换按钮[i]:绑定窗口_(112)
            end
         end
end



function 每日查看:显示(dt,x,y)
    self.资源组[2]:更新(x,y)
    self.月卡领取:更新(x,y)
    if self.资源组[2]:事件判断()  then
       self:打开()
    end
    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    self.资源组[2]:显示(self.x+520,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    zts:置字间距(3)
    zts:置颜色(白色):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"每日福利")
    zts:置字间距(0)
 if self.标题名称 =="查看会员" then
  self.底图背景:显示(self.x+15,self.y+30)
    -- zts:置颜色(白色):显示(self.x+15,self.y+30,self.消费说明..":"..self.月卡价格..self.月卡货币)

    -- zts:置颜色(白色):显示(self.x+15,self.y+55,"办理会员时间:")
    -- self.输入框背景:显示(self.x+110,self.y+52)
    -- zts:置颜色(黑色):显示(self.x+115,self.y+55,self.购买时间)
    -- zts:置颜色(白色):显示(self.x+15,self.y+80,"会员到期时间:")
    -- self.输入框背景:显示(self.x+110,self.y+78)
    -- zts:置颜色(黑色):显示(self.x+115,self.y+80,self.到期时间)
    zts:置颜色(黑色):显示(self.x+15,self.y+37,"今日奖励领取: "..self.领取时间)
   -- self.输入框背景:显示(self.x+110,self.y+102)
   -- zts:置颜色(黑色):显示(self.x+15,self.y+145,self.领取时间)
    zts:置颜色(红色):显示(self.x+15,self.y+60,"今日福利:")

    self.月卡领取:显示(self.x+240,self.y+290)
    if self.月卡领取:事件判断()  then
      请求服务(45,{文本="领取奖励"})
    end


   zts:置颜色(白色)



    if self.月卡物品~=nil and #self.月卡物品>0 then
      local zx = 0
      local zy = 0
      for i=1,#self.月卡物品 do
          if self.月卡物品[i]~=nil  and self.月卡物品[i].小动画~=nil then
            self.物品背景:显示(self.x+41+zx*80,self.y+80+zy*70)
            self.月卡物品[i].小动画:显示(self.x+41+zx*80,self.y+80+zy*70)
            if type(self.月卡物品[i].数量) == "string" then
              self.宝石字体:显示(self.x+50+zx*80,self.y+80+33+zy*70,self.月卡物品[i].数量)
            else
              self.宝石字体:显示(self.x+55+zx*80,self.y+80+33+zy*70,"x"..self.月卡物品[i].数量)
            end
              if  self.月卡物品[i].小动画:是否选中(x,y) then
                  tp.提示:商城提示(x,y,self.月卡物品[i].名称,self.月卡物品[i].介绍,self.月卡物品[i].大动画)
              end

              zx = zx + 1
              if zx >=6 then
                zx = 0
                zy =zy +1
              end
          end
        end
    end





  -- zts:显示(self.x+15,self.y+400,"当前玩家"..self.月卡货币..":"..self.玩家货币)


 elseif self.标题名称 =="查看兑换" then
    if self.兑换数据~=nil and #self.兑换数据>0 then
      for i=1,#self.兑换数据 do
        zts:显示(self.x+15,self.y-15+i*50,self.兑换数据[i].需求.."兑换"..self.兑换数据[i].给予.."   当前比例:1/"..self.兑换数据[i].比例)
        self.输入框背景:显示(self.x+15,self.y+5+i*50)
        self.输入框[i]:置坐标(self.x+20,self.y+8+i*50)
        self.输入框[i]:置可视(true,true)
        self.兑换按钮[i]:更新(x,y)
        self.兑换按钮[i]:显示(self.x+260,self.y+6+i*50)
        if self.兑换按钮[i]:事件判断()  then
          if self.输入框[i]:取文本() =="" or self.输入框[i]:取文本() == nil or tonumber(self.输入框[i]:取文本())<=0 then
            tp.常规提示:打开("#Y/你请输入兑换数额")
          elseif tonumber(self.输入框[i]:取文本())<self.兑换数据[i].最低 then
            tp.常规提示:打开("#Y/最少兑换#R/"..self.兑换数据[i].最低.."#Y/数额的#R/"..self.兑换数据[i].需求)
          else
            请求服务(45,{文本="兑换货币",编号=i,数额=tonumber(self.输入框[i]:取文本())})
         end

        end



      end
      zts:显示(self.x+15,self.y+390,"输入框中需填入扣除数额,\n填入的数额必须达到最低兑换限额")
      self.控件类:更新(dt,x,y)
      self.控件类:显示(x,y)
    end

end










end


function 每日查看:检查点(x,y)
  if self.可视 and self.资源组[1]:是否选中(x,y)  then
    return true
  end
  return false
end

function 每日查看:初始移动(x,y)
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

function 每日查看:开始移动(x,y)
  if self.鼠标 then
    self.x = x - self.xx
    self.y = y - self.yy
  end
end


return 每日查看
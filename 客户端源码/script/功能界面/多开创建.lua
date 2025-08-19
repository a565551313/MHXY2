
local 多开创建 = class()

local mouseb = 引擎.鼠标弹起
local box = 引擎.画矩形
local tp,zts,zts1
local insert = table.insert
function 多开创建:初始化(根)
    self.ID = 119
    self.x = 220+(全局游戏宽度-800)/2
    self.y = 140
    self.xx = 0
    self.yy = 0
    self.注释 = "多开创建"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 按钮 = 根._按钮
    local 资源 = 根.资源
    local 自适应 = 根._自适应
    tp = 根
    zts = tp.字体表.普通字体

    self.资源组={

      [1] = 自适应.创建(0,1,320,340,3,9),
         [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
         [3] = 自适应.创建(1,1,316,18,1,3,nil,18),--标题背景
         [4] = 自适应.创建(3,1,220,18,1,3),
         [5]=按钮.创建(自适应.创建(12,4,70,20,1,3),0,0,4,true,true,"创建角色"),
    }




    self.种族底图= 资源:载入(wdf配置.."/pic/转门派/人魔仙.png","图片")
    self.白底图 = 自适应.创建(4,1,300,300,3,nil)
    self.性别 = "男"
    self.性别切换 = 按钮.创建(资源:载入('迭代.wdf',"网易WDF动画",0X70E79D5D),0,0,4,true,true)
    self.性别切换:绑定窗口_(119)
    self.头像底图 = 资源:载入(wdf配置.."/pic/打造方格.png","图片")
    self.分类= 1

     self.人={
     男 = {"逍遥生","剑侠客","偃无师"},
     女 = {"飞燕女","英女侠","巫蛮儿"}
  }
    self.仙={
     男 = {"羽灵神","神天兵","龙太子"},
     女 = {"舞天姬","玄彩娥","桃夭夭"}
  }

    self.魔={
    男 ={"巨魔王","虎头怪","杀破狼"},
    女 ={"狐美人","骨精灵","鬼潇潇"}
  }
  self.人头像={}
  self.人头像.男={}
  for i=1,3 do
    local tx = 引擎.取头像(self.人.男[i])
    self.人头像.男[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.人头像.男[i].描述 = self.人.男[i]
  end
    self.人头像.女={}
  for i=1,3 do
    local tx = 引擎.取头像(self.人.女[i])
    self.人头像.女[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.人头像.女[i].描述 = self.人.女[i]
  end

  self.仙头像={}
  self.仙头像.男={}
  for i=1,3 do
    local tx = 引擎.取头像(self.仙.男[i])
    self.仙头像.男[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.仙头像.男[i].描述 = self.仙.男[i]
  end
    self.仙头像.女={}
  for i=1,3 do
    local tx = 引擎.取头像(self.仙.女[i])
    self.仙头像.女[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.仙头像.女[i].描述 = self.仙.女[i]
  end

  self.魔头像={}
  self.魔头像.男={}
  for i=1,3 do
    local tx = 引擎.取头像(self.魔.男[i])
    self.魔头像.男[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.魔头像.男[i].描述 = self.魔.男[i]
  end
    self.魔头像.女={}
  for i=1,3 do
    local tx = 引擎.取头像(self.魔.女[i])
    self.魔头像.女[i]=资源:载入(tx[7],"网易WDF动画",tx[2])
    self.魔头像.女[i].描述 = self.魔.女[i]
  end

    self.控件类 = require("ggeui/加载类")()
    local 总控件 = self.控件类:创建控件('多开创建姓名控件')
    总控件:置可视(true,true)
    self.姓名 = 总控件:创建输入("输入",0,0,220,16)
    self.姓名:置可视(false,false)
    self.姓名:置限制字数(20)
    self.姓名:置光标颜色(-16777216)
    self.姓名:置文字颜色(-16777216)
    self.选中=nil



    --self.选择账号栏 = tp._滑块diy.创建(5,180,115,2,tp)
end


function 多开创建:打开()


    if self.可视 then
        self.可视 = false
        self.选中=nil
        self.姓名:置可视(false,false)
    else

        insert(tp.窗口_,self)
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
        self.性别 = "男"
        self.姓名:置可视(false,false)
        self.姓名:置文本("")

    end
end



function 多开创建:显示(dt,x,y)

    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[5]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
    zts:置颜色(0xFFFFFFFF):显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"多角色创建")
    self.资源组[2]:更新(x,y)
    self.资源组[2]:显示(self.x+300,self.y+2)
    self.白底图:显示(self.x+10,self.y+30)
    if self.资源组[2]:事件判断()  then
        self:打开()

    end
 if self.分类 == 1 then
        self.种族底图:显示(self.x+30,self.y+70)
        self.性别切换:更新(x,y)
        self.性别切换:显示(self.x+255,self.y+32)
        if self.性别切换:事件判断() then
              if self.性别 =="男" then
                  self.性别 = "女"
              else
                  self.性别 ="男"
             end
        end
        zts:置颜色(0xFFFFFFFF):显示(self.x+285,self.y+35,self.性别)
        zts:置颜色(0xFFFFFFFF):显示(self.x+20,self.y+35,"请选择角色模型:")
        local xx = 0
        for i=1,3 do
          for n=1,3 do
             self.头像底图:显示(self.x+21+i*75,self.y-25+n*90)
          end
          self.人头像[self.性别][i]:显示(self.x+25+i*75,self.y+70)
          self.魔头像[self.性别][i]:显示(self.x+25+i*75,self.y+160)
          self.仙头像[self.性别][i]:显示(self.x+25+i*75,self.y+250)
          if  self.人头像[self.性别][i]:是否选中(x,y) then
                tp.提示:自定义(x,y,"#Y/角色:"..self.人头像[self.性别][i].描述)
                if 引擎.鼠标弹起(左键) then
                    self.选中 = self.人头像[self.性别][i].描述
                    self.分类=2
                end
          end
          if  self.魔头像[self.性别][i]:是否选中(x,y) then
                tp.提示:自定义(x,y,"#Y/角色:"..self.魔头像[self.性别][i].描述)
                if 引擎.鼠标弹起(左键) then
                    self.选中 = self.魔头像[self.性别][i].描述
                    self.分类=2
                end
          end
          if  self.仙头像[self.性别][i]:是否选中(x,y) then
               tp.提示:自定义(x,y,"#Y/角色:"..self.仙头像[self.性别][i].描述)
                if 引擎.鼠标弹起(左键) then
                    self.选中 = self.仙头像[self.性别][i].描述
                    self.分类=2
                end
          end
        end


    else
         if self.选中 ~=nil then
            zts:置颜色(0xFFFFFFFF):显示(self.x+20,self.y+35,"当前选择模型: "..self.选中.."         切换模型")
         else
             self.分类=1
         end
          self.性别切换:更新(x,y)
          self.性别切换:显示(self.x+285,self.y+32)
            if self.性别切换:事件判断() then
               self.选中 = nil
               self.分类=1
            end


          self.资源组[5]:更新(x,y)
          self.资源组[4]:显示(self.x+50,self.y+140)
          zts:置颜色(黑色):显示(self.x+50,self.y+110,"请输入角色姓名:")
          self.姓名:置可视(true,true)
          self.姓名:置坐标(self.x+55,self.y+143)
          self.资源组[5]:显示(self.x+115,self.y+170)
          if  self.资源组[5]:事件判断() then
              local 文本规范 = 分割文本(self.姓名:取文本()," ")
              if 文本规范[2]~= nil then
                 tp.常规提示:打开("#R/输入的姓名不能有空格")
                  return
               end
               if self.选中 == nil then
                    tp.常规提示:打开("#R/请选择角色")
                  return
              end
              if self.姓名:取文本() == nil or self.姓名:取文本() == "" then
                     tp.常规提示:打开("#R/请输入角色名")
                    return
              end
                请求服务(63,{参数=tp.队伍[1].数字id,文本="创建角色",模型=self.选中,名称=self.姓名:取文本()})
          end
          self.控件类:更新(dt,x,y)
          self.控件类:显示(x,y)
          if self.姓名._已碰撞 then
            self.焦点 = true
          end

    end



    -- self.资源组[23]:显示(self.x+100,self.y+120)
    -- self.资源组[22]:更新(x,y)
    -- self.资源组[22]:显示(self.x+330,self.y+120)








--     for i = 4 ,21 do
--         self.资源组[i]:更新(x,y,self.选中~=self.资源组[i]:取文字())
--     end

--     local xx = 0
--     local yy = 1
--     for i = 4 ,21 do
--         self.资源组[i]:显示(self.x+20+xx*63,self.y+yy*30)
--         xx = xx +1
--         if xx >= 6 then
--             xx = 0
--             yy = yy +1
--         end
--     end

--      for i = 4 ,21 do
--         if self.资源组[i]:事件判断()  then
--             self.选中 = self.资源组[i]:取文字()
--         end

--     end

--     if self.资源组[22]:事件判断()  then
--         local 文本规范 = 分割文本(self.姓名:取文本()," ")
--         if 文本规范[2]~= nil then
--             tp.常规提示:打开("#R/输入的姓名不能有空格")
--             return
--         end
--         if self.选中 == nil then
--              tp.常规提示:打开("#R/请选择角色")
--             return
--         end

--         if self.姓名:取文本() == nil or self.姓名:取文本() == "" then
--              tp.常规提示:打开("#R/请输入角色名")
--             return
--         end
--         请求服务(63,{参数=tp.队伍[1].数字id,文本="创建角色",模型=self.选中,名称=self.姓名:取文本()})
--     end



zts:置颜色(0xFFFFFFFF)

end

function 多开创建:检查点(x,y)
    if self.可视 and self.资源组[1]:是否选中(x,y)  then
        return true
    else
        return false
    end
end

function 多开创建:初始移动(x,y)
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

function 多开创建:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end
function 多开创建:更新(dt) end


return 多开创建
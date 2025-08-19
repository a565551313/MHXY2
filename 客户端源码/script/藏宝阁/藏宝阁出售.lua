
local 藏宝阁出售 = class()
local bw = require("gge包围盒")(0,0,110,40)
local mouseb = 引擎.鼠标弹起
local box = 引擎.画矩形
local tp,zts,zts1
local insert = table.insert
function 藏宝阁出售:初始化(根)
    self.ID = 114
    self.x = 240+(全局游戏宽度-800)/2
    self.y = 170
    self.xx = 0
    self.yy = 0
    self.注释 = "藏宝阁出售"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 按钮 = 根._按钮
    local 资源 = 根.资源
    local 自适应 = 根._自适应
    tp = 根
    zts = tp.字体表.普通字体
    zts1 = tp.字体表.普通字体
    self.资源组={

         [1] = 自适应.创建(0,1,300,320,3,9),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),--关闭
        [3] = 自适应.创建(1,1,296,18,1,3,nil,18),--标题背景
        [4] = 自适应.创建(2,1,255,250,3,9),
        [5] = 自适应.创建(3,1,180,18,1,3),
        [6] = 按钮.创建(自适应.创建(13,4,45,23,1,3),0,0,4,true,true,"上架"),

    }
    self.头像背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x363AAF1B)
    self.上按钮= 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xFD3D61F2),0,0,4,true,true)--上按钮
    self.下按钮 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x09217E13),0,0,4,true,true)--下按钮



    self.道具按钮 ={
        [1] = 按钮.创建(自适应.创建(10,4,22,22,1,3),0,0,4,true,true,"1"),
        [2] = 按钮.创建(自适应.创建(10,4,22,22,1,3),0,0,4,true,true,"2"),
        [3] = 按钮.创建(自适应.创建(10,4,22,22,1,3),0,0,4,true,true,"3"),
        [4] = 按钮.创建(自适应.创建(10,4,22,22,1,3),0,0,4,true,true,"4"),
        [5] = 按钮.创建(自适应.创建(10,4,22,22,1,3),0,0,4,true,true,"5"),
        }
    self.上按钮:绑定窗口_(114)
    self.下按钮:绑定窗口_(114)
    self.资源组[2]:绑定窗口_(114)
    self.资源组[6]:绑定窗口_(114)
    for i=1,5 do
        self.道具按钮[i]:绑定窗口_(114)
    end

    self.boxh=40
    self.boxw=225
    self.数据={}
    self.窗口时间 = 0
    self.选中=0
    self.头像组={}
    self.类型 = 1
    self.物品 = {}
    local 格子 = 根._物品格子
    for i=1,100 do
        self.物品[i] = 格子(0,0,i,"物品")
    end
    self.开始 = 1
    self.结束 = 20
    self.控件类 = require("ggeui/加载类")()
    local 总控件 = self.控件类:创建控件('藏宝阁上架商品')
    总控件:置可视(true,true)
    self.输入框 = 总控件:创建输入("藏宝阁上架输入",0,0,176,16)
    self.输入框:置可视(false,false)
    self.输入框:置数字模式()
    self.输入框:置限制字数(20)
    self.输入框:置光标颜色(-16777216)
    self.输入框:置文字颜色(-16777216)



    --self.选择账号栏 = tp._滑块diy.创建(5,180,115,2,tp)
end


function 藏宝阁出售:打开(数据)


    if self.可视 then
        self.可视 = false
        self.选中=nil
    else
        if 数据 == nil then 数据 = {} end
        self.数据=数据
        self.头像组={}
        self.类型 = 数据.类型
        self.选中=nil
        insert(tp.窗口_,self)

         if self.类型 ==1 then
            self.开始 = 1
            self.结束 = 20
            for i=self.数据.开始,self.数据.结束 do
            self.物品[i]:置物品(self.数据.数据[i])

           end

        else
            self.开始 = 1
            self.结束 = 6
            for n=1,#self.数据.数据 do
                local tx=引擎.取头像(self.数据.数据[n].模型)
                self.头像组[n]=tp.资源:载入(tx[7],"网易WDF动画",tx[1])
            end
       end
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
        self.输入框:置可视(true,true)
        self.输入框:置文本("")


    end
end

function 藏宝阁出售:刷新(数据)

        self.数据=数据
        self.头像组={}
         if self.类型 ==1 or self.类型 ==3 then
            for i=self.数据.开始,self.数据.结束 do
            self.物品[i]:置物品(self.数据.数据[i])
           end
           self.类型 =1
        else
            for n=1,#self.数据.数据 do
                local tx=引擎.取头像(self.数据.数据[n].模型)
                self.头像组[n]=tp.资源:载入(tx[7],"网易WDF动画",tx[1])
            end
            self.类型 =2
       end
       self.选中=0

end

function 藏宝阁出售:显示(dt,x,y)

    self.焦点 = false

    if self.类型 == 1 then
        self.资源组[1]:置宽高(300,310)
        tp.竖排花纹背景1_:置区域(0,0,18,225)
    else
        self.资源组[1]:置宽高(300,330)
        tp.竖排花纹背景1_:置区域(0,0,18,250)
    end
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[3]:显示(self.x+2,self.y+2)
    tp.窗口标题背景_[5]:显示(self.x+self.资源组[1].宽度/2-68,self.y+2)
    zts1:置颜色(白色)
    zts1:置字间距(3)
    zts1:显示(self.x+self.资源组[1].宽度/2-38,self.y+2,"藏宝阁出售")
    zts1:置字间距(0)

     self.资源组[2]:更新(x,y)
    self.资源组[2]:显示(self.x+281,self.y+2)
    tp.竖排花纹背景1_:显示(self.x+3,self.y+35)
    tp.竖排花纹背景1_:显示(self.x+280,self.y+35)
     self.控件类:更新(dt,x,y)
     self.输入框:置可视(true,true)
     self.资源组[6]:更新(x,y)

    if self.资源组[2]:事件判断()  then
        self:打开()
    elseif self.资源组[6]:事件判断()  then---------上架按钮
        if tonumber(self.输入框:取文本()) == nil  then
            tp.常规提示:打开("#Y/请正确输入出售价格！")
         else
            请求服务(69,{类型=self.类型,文本="上架商品",编号=self.选中,价格=self.输入框:取文本()})
        end
    end




    if self.类型 == 1 then
           tp.物品界面背景_:显示(self.x+22,self.y+35)
           self.资源组[5]:显示(self.x+50,self.y+275)
           self.控件类:显示(x,y)
           self.输入框:置坐标(self.x+52,self.y+278)
           self.资源组[6]:显示(self.x+240,self.y+275)
           zts:置颜色(0xFFFFFFFF):显示(self.x+10,self.y+278,"价格:")
           local zx = 0
           for i=1,5 do
               local 开始数值 = i*20-19
               self.道具按钮[i]:更新(x,y)
               self.道具按钮[i]:显示(self.x + 38 +zx * 50,self.y + 245,nil,true,nil,self.开始==开始数值,2)
               if self.道具按钮[i]:事件判断() then
                  self.开始 = i*20-19
                  self.结束 = i*20
               end
               zx = zx + 1
           end
            local xx = 0
            local yy = 0
            for i=self.开始,self.结束 do
                self.物品[i]:置坐标(22 + self.x+xx*51,35 + self.y+yy*51)
                self.物品[i]:显示(dt,x,y,self.鼠标)
                if self.物品[i].焦点 then
                    if self.物品[i].物品 ~= nil then

                        tp.提示:道具行囊(x,y,self.物品[i].物品)
                        if self.物品[i].事件 then
                             if self.物品[self.选中]~= nil then
                                self.物品[self.选中].选中=nil
                            end
                            self.物品[i].选中=true
                            self.选中 = i
                        end
                    end
                end
                xx = xx + 1
                if xx == 5 then
                    xx = 0
                    yy = yy + 1
                end
            end


    else

           self.资源组[4]:显示(self.x+22,self.y+35)
           self.资源组[5]:显示(self.x+50,self.y+295)
           self.控件类:显示(x,y)
           self.输入框:置坐标(self.x+52,self.y+298)
           self.资源组[6]:显示(self.x+240,self.y+295)
           zts:置颜色(0xFFFFFFFF):显示(self.x+10,self.y+298,"价格:")
           self.上按钮:更新(x,y)
           self.下按钮:更新(x,y)
           self.上按钮:显示(self.x+260,self.y+35)
           self.下按钮:显示(self.x+260,self.y+266)
           tp.画线:置区域(0,0,15,211)
           tp.画线:显示(self.x+264,self.y+55)
            if self.上按钮:事件判断() then
                if self.开始 == 1 then
                    tp.常规提示:打开("#Y/已经到最顶层了")
                 else
                   self.开始 = self.开始 -1
                   self.结束 = self.结束 -1
                 end

            elseif self.下按钮:事件判断() then
                if self.结束 == #self.数据.数据 then
                    tp.常规提示:打开("#Y/已经到最低层了")
                 else
                    self.开始 = self.开始 + 1
                    self.结束 = self.结束 + 1
                 end

            end
            local XX = 1
            for n=self.开始,self.结束 do
                if self.头像组[n]~=nil then
                    local zx,zy = self.x+25,self.y+XX*self.boxh
                    self.头像背景:显示(zx,zy+1)
                    self.头像组[n]:显示(zx+3,zy+4)
                    bw:置坐标(zx,zy)
                    if bw:检查点(x,y) then
                        if mouseb(0) then
                            self.选中 = self.数据.数据[n].认证码
                        end
                        box(zx,zy,zx+self.boxw,zy+self.boxh,-1677721856)
                    end
                    if self.选中 == self.数据.数据[n].认证码 then
                        box(zx,zy,zx+self.boxw,zy+self.boxh,1677721855)
                    end
                    zts:置颜色(黑色):显示(zx+45,zy+5,"姓名:"..self.数据.数据[n].名称)
                    zts:置颜色(黑色):显示(zx+45,zy+25,"等级:"..self.数据.数据[n].等级)
                    zts:置颜色(黑色):显示(zx+145,zy+25,"种类:"..self.数据.数据[n].种类)
                    XX= XX+1
                end
           end
    end

    if self.输入框._已碰撞 then
        self.焦点 = true
    end

end

function 藏宝阁出售:检查点(x,y)
    if self.可视 and self.资源组[1]:是否选中(x,y)  then
        return true
    else
        return false
    end
end

function 藏宝阁出售:初始移动(x,y)
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

function 藏宝阁出售:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end
function 藏宝阁出售:更新(dt) end


return 藏宝阁出售
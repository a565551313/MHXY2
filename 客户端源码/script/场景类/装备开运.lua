
local 场景类_装备开运 = class()
local mousea = 引擎.鼠标弹起
local format = string.format
local min = math.min
local insert = table.insert
local floor = math.floor
local min = math.min
local js = {"所需现金","现有现金","所需体力","现有体力"}
local mouseb = 引擎.鼠标弹起
local tp
function 场景类_装备开运:初始化(根)
    self.ID = 72
    self.x = 193
    self.y = 81
    self.xx = 0
    self.yy = 0
    self.注释 = "装备开运"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    tp = 根
    zts = tp.字体表.普通字体
    zts1 = tp.字体表.描边字体
    self.材料1位置 = nil
    self.类型 = 1
end
function 场景类_装备开运:打开(数据)
    self.数据 = 数据
    if self.可视 then
        --self.状态 = 1
        self.类型 = 1
        self.窗口 = nil
        self.可视 = false
        self.开始 = 1
        self.结束 = 20
        self.可视 = false
        self.资源组 = nil
        self.物品 = nil
        self.材料 = nil
        return
    else

        insert(tp.窗口_,self)
        local 资源 = tp.资源
        local 按钮 = tp._按钮
        local 自适应 = tp._自适应
        local 按钮 = require("script/系统类/按钮")
            self.资源组 = {
            [0] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
            [1] = 自适应.创建(0,1,301,401,3,9), -- 297
            [2] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x284B91F0),
            [3] = 自适应.创建(3,1,120,18,1,3),
            [4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0xCE137B78),
            [5] = 自适应.创建(1,1,297,18,1,3,nil,18),
            [6] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xF11233BB),0,0,4,true,true), --关闭按钮
            [10] = 按钮(自适应.创建(12,4,55,20,1,3),0,0,4,true,true,"开运"),
            }
        local 格子 = tp._物品格子
        self.材料 = {}
        self.材料[1] = 格子(self.x+4,self.y,2,"打造材料")
        self.物品 = {}
        for i=1,20 do
            self.物品[i] = 格子.创建(0,0,i,"道具类")
        end
        self.类型 = 数据.类型
        self.材料[1].物品 = nil
        self.开始 = 1
        self.结束 = 20
        for q=self.开始,self.结束 do
            self.物品[q]:置物品(self.数据.道具.道具[q])
        end
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
    end


end

function 场景类_装备开运:刷新(数据)
    self.数据.道具.银子 = 数据.银子
    self.数据.道具.体力 = 数据.体力
end

local function 打造金钱公式(a)
    if a <= 40 then
      return floor((a*100+2000))
    elseif a > 40 and a <= 90 then
      return floor(((a-50)*1000+10000))
    elseif a >= 100 then
      return floor(((a-100)*45000+3000000))
    end
end

function 场景类_装备开运:显示(dt,x,y)

    self.焦点 = false
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[10]:更新(x,y,self.材料[1].物品 ~= nil)

    self.资源组[0]:更新(x,y)

    self.资源组[5]:显示(self.x+2,self.y+2)
    self.资源组[0]:显示(self.x+280,self.y+2)
    tp.窗口标题背景_[4]:显示(self.x+self.资源组[1].宽度/2-60,self.y+2)
    tp.底图背景:置区域(0,0,170,18)
    tp.底图背景:显示(self.x+110,self.y+370)
    zts:置字间距(3)
    zts:显示(self.x+self.资源组[1].宽度/2-30,self.y+2,"装备开运")
    zts:置字间距(0)

    self.资源组[2]:显示(self.x+20,self.y+50)
    for i =1,4 do
        self.资源组[3]:显示(self.x+170,self.y+i*30)
        zts:显示(self.x+100,self.y+i*30,js[i])
        zts1:显示(self.x+30,self.y+32,"装备")
        zts:置颜色(黄色)
        zts:显示(self.x+180,self.y+62,floor(self.数据.道具.银子))
        zts:置颜色(0xFFFFFF00)
        zts:显示(self.x+180,self.y+122,floor(self.数据.道具.体力))
        zts:置颜色(0xFFFFFFFF)
        if self.材料[1].物品 ~= nil then
            self.消耗体力 = (self.材料[1].物品.开运孔数.当前 + 1) * 30
            self.消耗银子 = (self.材料[1].物品.开运孔数.当前 + 1) * 1000000
            zts:显示(self.x+180,self.y+32,self.消耗银子)
            zts:显示(self.x+180,self.y+92,self.消耗体力)
        end
    end
    self.资源组[4]:显示(self.x+24,self.y+157)
    self.资源组[10]:显示(self.x+18,self.y+100)
    if self.鼠标 then
        if self.资源组[10]:事件判断() then
            if self.类型 == 1 then
                请求服务(4502,{序列=self.材料1位置})
            else
                请求服务(4502.1,{序列=self.材料1位置})
            end
        end
    end

    local o = self.开始 - 1
    for h=1,4 do
        for l=1,5 do
            o = o + 1
            self.物品[o]:置坐标(l * 51 - 29 + self.x+4,h * 51 + 106 + self.y)
            self.物品[o]:显示(dt,x,y,self.鼠标,{2})
            if self.物品[o].物品 ~= nil and self.物品[o].焦点 then
                tp.提示:道具行囊(x,y,self.物品[o].物品)
                if self.物品[o].事件 and self.物品[o].物品.总类 == 2 and self.鼠标 then
                    if self.物品[o].物品.鉴定 == true then
                        if self.物品[o].物品.总类 == 2 then
                            zl = self.物品[o].物品.级别限制
                        end
                        if self.材料[1].物品 == nil then
                            self.材料[1]:置物品(self.物品[o].物品)
                            if zl ~= nil then
                                self.总价 = 打造金钱公式(zl)
                            end
                            self.材料1位置 = o
                            self.物品[o]:置物品(nil)
                        else
                            tp.常规提示:打开("#Y/请先卸下道具")
                        end
                    else
                        tp.常规提示:打开("#Y/未鉴定物品无法开孔")
                    end
                    刷新道具逻辑(self.物品[o].物品,o,true)
                end
            end
        end
    end
    self.材料[1]:置坐标(self.x+18 ,self.y+50)
    self.材料[1]:显示(dt,x,y,self.鼠标,false)
    if self.材料[1].物品 ~= nil and self.材料[1].焦点 then
            tp.提示:道具行囊(x,y,self.材料[1].物品)
            if mouseb(0) and self.鼠标 then
                if 取物品数量() < 160 then
                        tp.道具列表[self.材料1位置] = self.材料[1].物品
                        -- if 新道具行囊 then
                        --     tp.窗口.新道具行囊.物品[self.材料1位置]:置物品(tp.道具列表[self.材料1位置])
                        -- else
                        --     tp.窗口.道具行囊.物品[self.材料1位置]:置物品(tp.道具列表[self.材料1位置])
                        -- end
                        刷新道具逻辑(tp.道具列表[self.材料1位置],self.材料1位置,true)
                        self.材料1总价 = 0
                        self.材料[1]:置物品(nil)
                else
                    tp.常规提示:打开("#Y/包裹已满。请及时清理")
                end
            end
    end
    if self.资源组[0]:事件判断() then
        self.可视 = false
    end

end
function 场景类_装备开运:打造成功()
    self.材料[1]:置物品(nil)
end

function 场景类_装备开运:检查点(x,y)
    if self.可视 and self.资源组 ~= nil and self.资源组[1]:是否选中(x,y)  then
        return true
    end
end

function 场景类_装备开运:初始移动(x,y)
    tp.运行时间 = tp.运行时间 + 1
    if not tp.消息栏焦点 then
        self.窗口时间 = tp.运行时间
    end
    if not self.焦点 then
        tp.移动窗口 = false
    end
    if self.可视 and self.鼠标 and  not self.焦点 then
        self.xx = x - self.x
        self.yy = y - self.y
    end
end

function 场景类_装备开运:开始移动(x,y)
    if self.可视 and self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end


return 场景类_装备开运
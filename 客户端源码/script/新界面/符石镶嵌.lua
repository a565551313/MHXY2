local 场景类_符石镶嵌 = class()

local floor = math.floor
local format = string.format
local mousea = 引擎.鼠标弹起
local tp,zts1,zts2,zts3
local insert = table.insert


function 场景类_符石镶嵌:初始化(根)
    self.ID = 127
    self.xx = 0
    self.yy = 0
    self.注释 = "符石镶嵌"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    local 资源 = 根.资源
    local 按钮 = 根._按钮
    local 自适应 = 根._自适应
    self.资源组 = {
        [0] = 自适应.创建(109,1,348,27,1,3,60),
        [1] = 自适应.创建(100,1,350,480,3,9),
        -- [1] = 自适应.创建(0,1,350,478,3,9),
        -- [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
        [2] = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x01343E13,9393),0,0,3,true,true),
        [3] = 自适应.创建(1,1,99,18,1,3,nil,18),
        [4] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF),
        [5] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF),
        [6] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF),
        [7] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF),
        [8] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF),
        [9] = 按钮.创建(自适应.创建(38,4,55,22,1,1),0,0,4,true,true,"镶嵌"),
        [10] = 资源:载入('登陆资源.wdf',"网易WDF动画",0X22D22D6D), -- 蓝色方框
        [11] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BF), -- 星位
        [12] = 资源:载入('登陆资源.wdf',"网易WDF动画",1917526931), -- 介绍背景
        [13] = 资源:载入('登陆资源.wdf',"网易WDF动画",0XF11233BE), -- 符石背景
        [14] = 按钮.创建(自适应.创建(38,4,55,22,1,1),0,0,4,true,true,"还原"),
        [15] = 自适应.创建(102,1,130,19,1,3,27),
    }
    self.触摸光环 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x01343E12)
    self.反转动画 = 资源:载入('登陆资源.wdf',"网易WDF动画",0X48E7419E)
    self.资源组[2]:绑定窗口_(self.ID)
    self.资源组[9]:绑定窗口_(self.ID)
    self.资源组[14]:绑定窗口_(self.ID)
    self.介绍文本 = 根._丰富文本(200,300,根.字体表.普通字体)
    self.介绍文本2 = 根._丰富文本(200,300,根.字体表.普通字体)
    self.大模型 = nil
    self.装备格子 = nil
    self.物品 = {}
    self.物品2 = nil
    self.可镶嵌 = false
    self.可清空 = false
    self.动效开关 =false
    self.星石动画 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x4CBA3800) -- boom
    local 格子 = 根._物品格子
    for i=1,5 do
        self.物品[i] = 格子(0,0,i,"道具行囊_符石")
    end
    self.物品2 = 格子(0,0,i,"道具行囊_符石")
    tp = 根
    zts1 = tp.字体表.描边字体
    zts2 = tp.字体表.道具字体
    zts3 = tp.字体表.普通字体____
    self.窗口时间 = 0
    self.装备 = nil
    self.发送内容={}
end

function 场景类_符石镶嵌:打开(数据)
    if self.可视 then
        for i=1,5 do
            self.物品[i]:置物品(nil)
            self.物品[i].不可替换=nil
            self.物品2:置物品(nil)
            self.物品2.不可替换=nil
        end
        self.鼠标 = false
        self.可视 = false
    else
        if 数据==nil then
            return
        end
        insert(tp.窗口_,self)
        self:刷新符石(数据)
        self.x = 全局游戏宽度-360
        self.y = (全局游戏高度/2)-239
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.可视 = true
    end
end

function 场景类_符石镶嵌:刷新符石(数据,是否)
	-- table.print(数据)
    self.装备 = 数据
    请求服务(3699)
    for i=1,5 do
        self.物品[i]:置物品(nil)
        self.物品[i].不可替换=nil
    end
    self.物品2:置物品(nil)
    self.物品2.不可替换=nil
    local item = tp._物品.创建()
    item:置对象(数据.名称)
    self.道具资源 = item
    self.大模型 = tp.资源:载入(self.道具资源.资源,"网易WDF动画",self.道具资源.大模型资源)
    self.介绍文本:清空()
    self.介绍文本2:清空()
    self.发送内容={}
    self.介绍文本:添加文本(format("#G/开运孔数：%s",self.装备.开运孔数.当前.."孔/"..self.装备.开运孔数.上限.."孔"))
    if self.装备.星位~=nil then
        for n=1,5 do
            if self.装备.星位[n]~=nil then
                local 组合语句="#G符石："
                local 计数 = 1
                for k,v in pairs(self.装备.星位[n].符石属性) do
                    if 计数 == 1 then
                        组合语句=组合语句..k.." +"..v.." "
                    else
                        组合语句=组合语句..k.." +"..v
                    end
                    计数=计数+1
                end
                self.介绍文本2:添加文本(组合语句)
                local 符石 = tp._物品.创建()
                符石:置对象(self.装备.星位[n].名称)
                符石.子类 = self.装备.星位[n].子类
                符石.颜色 = self.装备.星位[n].颜色
                符石.符石属性 = self.装备.星位[n].符石属性
                self.物品[n]:置物品(符石)
            end
        end
    end
    if self.装备.星位组 then
        if self.装备.星位~=nil and self.装备.星位[6] ~= nil then
            local 符石 = tp._物品.创建()
            符石:置对象(self.装备.星位[6].名称)
            符石.类型 = self.装备.星位[6].阴阳
            local 临时属性 = ""
            for k,v in pairs(self.装备.星位[6].符石属性) do
                临时属性 = k.." +"..v
            end
            self.介绍文本2:添加文本("#G/星位: "..临时属性)
            符石.sx = 临时属性
            self.物品2:置物品(符石)

            if self.装备.星位[6].相互~=nil then
                local 临时属性 = ""
                for k,v in pairs(self.装备.星位[6].相互) do
                    临时属性 = k.." +"..v
                end
                self.介绍文本2:添加文本("#G/星相互合: "..临时属性)
            end
        else
            self.介绍文本2:添加文本("#G/星位: 已开")
        end
    end
    if self.装备.星位~=nil and self.装备.星位.组合~=nil then
        self.介绍文本2:添加文本(format("#X/符石组合： %s",self.装备.星位.组合))
        self.介绍文本2:添加文本(format("#X/门派条件： %s",self.装备.星位.门派 or "无"))
        self.介绍文本2:添加文本(format("#X/部位条件： %s",取符石部位(self.装备.星位.部位)))
        self.介绍文本2:添加文本(format("#X/%s",取符石组合说明(self.装备.星位.组合,self.装备.星位.组合等级)))
    end
    if 是否 then
        self.动效开关 = true
    end
end

function 场景类_符石镶嵌:符石预览()
    请求服务(3699)
    self.介绍文本:清空()
    self.介绍文本2:清空()
    self.介绍文本:添加文本(format("#G/开运孔数：%s",self.装备.开运孔数.当前.."孔/"..self.装备.开运孔数.上限.."孔"))
    local 物品表 = {}
    local 等级计算 = 0
    for i=1,5 do
        if self.物品[i].物品~=nil then
            物品表[i]={}
            物品表[i].颜色=self.物品[i].物品.颜色
            等级计算 = 等级计算 + self.物品[i].物品.子类
            local  组合语句="#G符石："
            local 计数 = 1
            for k,v in pairs(self.物品[i].物品.符石属性) do
                if 计数 == 1 then
                    组合语句=组合语句..k.." +"..v.." "
                else
                    组合语句=组合语句..k.." +"..v
                end
                计数=计数+1
            end
            self.介绍文本2:添加文本(组合语句)
        end
    end
    if self.装备.星位组 then
        if self.装备.星位~=nil and self.装备.星位[6] ~= nil then
            local 临时属性 = ""
            for k,v in pairs(self.装备.星位[6].符石属性) do
                临时属性 = k.." +"..v
            end
            self.介绍文本2:添加文本("#G/星位: "..临时属性)
            if 等级计算~=0 then
                if 等级计算%2==0 then
                    if self.装备.星位[6].阴阳==2 then
                         self.介绍文本2:添加文本("#G/星相互合: "..取星位相互(self.装备.分类).." +2")
                    end
                else
                    if self.装备.星位[6].阴阳==1 then
                        self.介绍文本2:添加文本("#G/星相互合: "..取星位相互(self.装备.分类).." +2")
                    end
                end
            end
        else
            self.介绍文本2:添加文本("#G/星位: 已开")
        end
    end
    local 临时组合 = 取星位组合(物品表)
    if 临时组合~=nil then
        self.介绍文本2:添加文本(format("#X/符石组合： %s",临时组合.组合))
        self.介绍文本2:添加文本(format("#X/门派条件： %s",临时组合.门派 or "无"))
        self.介绍文本2:添加文本(format("#X/部位条件： %s",取符石部位(临时组合.部位)))
        self.介绍文本2:添加文本(format("#X/%s",取符石组合说明(临时组合.组合,临时组合.等级)))
    end
end

function 场景类_符石镶嵌:显示(dt,x,y)
    self.焦点 = false
    self.资源组[2]:更新(x,y)
    self.资源组[10]:更新(dt)

    --
    if not 判断是否为空表(self.发送内容) then
        self.可镶嵌 = true
        self.可清空 = true
    else
        self.可镶嵌 = false
        self.可清空 = false
    end
    self.资源组[9]:更新(x,y,self.可镶嵌 == true)
    self.资源组[14]:更新(x,y,self.可清空 == true)
    if self.资源组[2]:事件判断() then
        self:打开()
        return false
    elseif self.资源组[9]:事件判断() then
        请求服务(3801,{内容=self.发送内容})
        self.发送内容={}
    elseif self.资源组[14]:事件判断() then
        self:刷新符石(self.装备)
    end
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[0]:显示(self.x+1,self.y+1)
    self.资源组[2]:显示(self.x+331,self.y+2)
    self.资源组[12]:显示(self.x+15,self.y+30)
    self.资源组[13]:显示(self.x+10,self.y+298)
    self.资源组[9]:显示(self.x+100,self.y+450)
    self.资源组[14]:显示(self.x+195,self.y+450)
    self.资源组[15]:显示(self.x+110,self.y+1)
    zts3:置颜色(白色):置样式(1):置字间距(0):显示(self.x+174,self.y+2,"符石镶嵌")
    self.大模型:显示(self.x+15,self.y+77)
    zts2:置字间距(3)
    zts2:置颜色(0xFFffdf49)
    zts2:显示(self.x+135,self.y+33,self.道具资源.名称)
    self.介绍文本:显示(self.x+135,self.y+62)
    self.介绍文本2:显示(self.x+135,self.y+self.介绍文本.显示表.高度 + 62)
    local xx = 0
    local yy = 1
    local py = 14
    if self.装备.星位组 ~= nil then
        self.资源组[11]:显示(self.x+149,self.y+288+py)
        self.物品2:置坐标(self.x+152,self.y+302)
        self.物品2:显示(dt,x,y,self.鼠标,nil,nil,nil,1)
        if self.物品2.焦点 and not tp.消息栏焦点 then
            self.触摸光环:显示(self.x+149,self.y+288+py)
        end
        if tp.场景.抓取物品==nil and self.物品2.物品 ~= nil and self.物品2.焦点 and self.发送内容[6]==nil then
            tp.提示:道具行囊(x,y,self.物品2.物品,true)
            self.反转动画:更新(dt)
            self.反转动画:显示(self.x+177,self.y+315+py)
        end
        if self.物品2.事件 then
            if tp.场景.抓取物品 ~= nil and self.物品2.焦点 and tp.场景.抓取物品.总类 == 889 and tp.场景.抓取物品.分类 == 91 then
                if tp.场景.抓取物品.子类 == self.装备.分类 then
                    self.物品2:置物品(tp.场景.抓取物品)
                    self:符石预览()
                    self.发送内容[6]={背包类型=tp.场景.抓取物品类型,物品id=tp.场景.抓取物品ID,方式="镶嵌"}
                    self.物品2.确定 = false
                    tp.窗口.道具行囊.物品[tp.场景.抓取物品ID].确定 = false
                    tp.场景.抓取物品 = nil
                    tp.场景.抓取物品ID = nil
                    tp.场景.抓取物品注释 = nil
                else
                    tp.常规提示:打开("#Y/这个装备不可以镶嵌这个星石")
                end
            else
                if tp.场景.抓取物品 ~= nil and self.物品2.焦点  then
                    if  tp.场景.抓取物品.名称=="未激活的星石" then
                        tp.常规提示:打开("#Y/该星石尚为激活不能镶嵌")
                    else
                        tp.常规提示:打开("#Y/只能镶嵌星石，请确认物品是否正确")
                    end
                elseif tp.场景.抓取物品 == nil and self.物品2.焦点 and  self.物品2.物品~=nil and self.物品2.物品.类型~=nil then
                    请求服务(3802)
                end
            end
        end
    end
    for i=1,self.装备.开运孔数.当前 do
        xx = xx + 1
        if i ~= 2 and  i~=4 then
            self.资源组[3+i]:显示(self.x+(60*i)-31,self.y+347+py)
            if self.物品[i].焦点 and not tp.消息栏焦点 then
                 self.触摸光环:显示(self.x+(60*i)-32,self.y+347+py)
            end
        else
            self.资源组[3+i]:显示(self.x+(60*i)-31,self.y+372+py)
            if self.物品[i].焦点 and not tp.消息栏焦点 then
                 self.触摸光环:显示(self.x+(60*i)-32,self.y+372+py)
            end
        end
        if i ~= 2 and  i~=4 then
            self.物品[i]:置坐标(self.x+(60*i)-28,self.y+346+py)
        else
            self.物品[i]:置坐标(self.x+(60*i)-28,self.y+370+py)
        end
        self.物品[i]:显示(dt,x,y,self.鼠标,nil,nil,nil,1)
        if self.物品[i].物品 ~= nil and not self.物品[i].不可替换 then
            if i ~= 2 and  i~=4 then
                self.资源组[10]:显示(self.x+(60*i)-36,self.y+344+py)
            else
                self.资源组[10]:显示(self.x+(60*i)-36,self.y+369+py)
            end
        end
        if self.物品[i].物品 ~= nil and self.物品[i].焦点 then
            tp.提示:道具行囊(x,y,self.物品[i].物品,true)
        end
        if xx >= 2 then
            xx = 0
            yy = yy + 1
        end
        if self.物品[i].事件 then
            if tp.场景.抓取物品 ~= nil  and self.物品[i].焦点 and tp.场景.抓取物品.总类 == 889 and tp.场景.抓取物品.分类 == 88 and tp.场景.抓取物品.子类 < 4 then
                self.物品[i]:置物品(tp.场景.抓取物品)
                self.发送内容[i]={背包类型=tp.场景.抓取物品类型,物品id=tp.场景.抓取物品ID,方式="镶嵌"}
                self:符石预览()
                self.物品[i].不可替换 =  true
                self.物品[i].确定 = false
                if 新道具行囊 then
                     tp.窗口.新道具行囊.物品[tp.场景.抓取物品ID].确定 = false
                else
                     tp.窗口.道具行囊.物品[tp.场景.抓取物品ID].确定 = false
                end
                tp.场景.抓取物品 = nil
                tp.场景.抓取物品ID = nil
                tp.场景.抓取物品注释 = nil
            else
                if tp.场景.抓取物品 ~= nil and self.物品[i].焦点 then
                    if  tp.场景.抓取物品.名称=="一级未激活符石" or tp.场景.抓取物品.名称=="二级未激活符石"
                        or tp.场景.抓取物品.名称=="三级未激活符石" then
                        tp.常规提示:打开("#Y/该符石尚为激活不能镶嵌")
                    else
                        tp.常规提示:打开("#Y/只能镶嵌符石，请确认物品是否正确")
                    end
                end
            end
        -- elseif tp.场景.抓取物品 == nil  and self.物品[i].物品 ~= nil and self.物品[i].焦点 then
        --     if 引擎.鼠标弹起(0x01) then
        --         self.物品[i]:置物品(nil)
        --         self.请求服务[i]={方式="扣除"}
        --         self:符石预览()
        --     end
        end
    end
    -- self.星石动画:更新(dt)
    -- self.星石动画:显示(self.x+180,self.y+333)
    if self.动效开关 then
        self.星石动画:更新(dt)
         self.星石动画:显示(self.x+180,self.y+333)
        if self.星石动画.当前帧==self.星石动画.结束帧 then
            self.动效开关 = false
            self.星石动画.当前帧 = 0
        end
    end
end

function 场景类_符石镶嵌:检查点(x,y)
    if self.资源组[1]:是否选中(x,y)  then
        return true
    end
end

function 场景类_符石镶嵌:初始移动(x,y)
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

function 场景类_符石镶嵌:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end

return 场景类_符石镶嵌
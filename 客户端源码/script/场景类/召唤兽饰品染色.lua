
local 场景类_召唤兽饰品染色 = class()
local floor = math.floor
local tp,zts,zts1,bb
local format = string.format
local insert = table.insert


function 场景类_召唤兽饰品染色:初始化(根)
    self.ID = 25
    self.x = 311
    self.y = 95
    self.xx = 0
    self.yy = 0
    self.注释 = "饰品染色"
    self.可视 = false
    self.鼠标 = false
    self.焦点 = false
    self.可移动 = true
    self.窗口时间 = 0
    tp = 根
    self.选中染色=0
    self.染色数据={}
    self.改变 = false
    zts = 根.字体表.普通字体
    zts1 = 根.字体表.描边字体
    self.方向 = 0
end




function 场景类_召唤兽饰品染色:打开(b,l,c)
    if b~=nil and self.可视 then self.可视=false end
    if b~=nil and (not 引擎.取战斗模型(b.模型.."_饰品")  or #引擎.取战斗模型(b.模型.."_饰品")<=0) then self.可视=false end
    if self.可视 then
        if b ~= nil and bb ~= b then
        	bb = b
			self:置形象()
			tp.运行时间 = tp.运行时间 + 1
		    self.窗口时间 = tp.运行时间
		    return false
		end
        self.可视 = false
        self.资源组=nil
        self.染色组=nil
        return
    else
    	bb = b
        insert(tp.窗口_,self)
        self:加载数据()
        tp.运行时间 = tp.运行时间 + 1
        self.窗口时间 = tp.运行时间
        self.选中染色=0
        self.染色数据={}
        if bb.饰品染色方案~=nil and bb.饰品染色方案~=0 then
	        self.染色数据.id=bb.饰品染色方案
	    	self.染色数据[1]=bb.饰品染色组[1]
	    	self.染色数据[2]=bb.饰品染色组[2]
	    	self.染色数据[3]=bb.饰品染色组[3]
	    end
        self.可视 = true
        self.资源组[10]:置起始点(0)
        self.计次=0
        self.改变 = false
        --self.仙玉 = 内容.仙玉+0
        self.方向 = 0
        self:置形象()
        self.x = tp.窗口.召唤兽查看栏.x+100
		self.y =tp.窗口.召唤兽查看栏.y-80

    end
end

function 场景类_召唤兽饰品染色:加载数据()
    local 资源 = tp.资源
    local 按钮 = tp._按钮
    local 自适应 = tp._自适应
    local 滑块 = tp._滑块
    self.资源组 = {
        [1] = 资源:载入(wdf配置.."/pic/界面/主武器染色.png", "图片"),
        [2] = 按钮.创建(自适应.创建(18,4,16,16,4,3),0,0,4,true,true),
        [3] = 资源:载入('登陆资源.wdf',"网易WDF动画",0x5B52CB27),
        [4] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"还原"),
        [5] = 按钮.创建(自适应.创建(12,4,43,20,1,3),0,0,4,true,true,"染色"),
        [8] = 资源:载入(wdf配置.."/pic/界面/武器染色.png", "图片"),
        [9] = 按钮.创建(资源:载入('UI.wdf',"网易WDF动画",0x00000072),0,0,4,true,true),
        [10] = 滑块.创建(自适应.创建(11,4,8,30,2,3,nil),1,233,10,1), --滑块
        --[10] =滑块.创建(资源:载入(tp.滑块资源,"网易WDF动画",0x8D4BBC26),1,233,10,1), --音效滑块

        [11] = 资源:载入(wdf配置.."/pic/界面/染色背景.png", "图片"),
        [15] = 资源:载入(wdf配置.."/pic/界面/染色条.png", "图片"),
        [16] = 自适应.创建(3,1,120,18,1,3),
        [17] = 资源:载入(wdf配置.."/pic/界面/染色小背景.png", "图片"),
    }
end

function 场景类_召唤兽饰品染色:置形象()
        self.资源组[6] = nil
        self.资源组[7] = nil
        local n = 引擎.取战斗模型(bb.模型)
        self.资源组[7] = tp.资源:载入(n[10],"网易WDF动画",n[6])
        if  bb.染色方案 and bb.染色方案~=0 and bb.染色组 and bb.染色组~=0 and #bb.染色组>0 then
        	self.资源组[7]:置染色(bb.染色方案,bb.染色组[1],bb.染色组[2],bb.染色组[3])
        end
        self.资源组[7]:置方向(self.方向)
        if 引擎.取战斗模型(bb.模型.."_饰品") ~= nil and #引擎.取战斗模型(bb.模型.."_饰品") >0 then
			n = 引擎.取战斗模型(bb.模型.."_饰品")
			self.资源组[6] = tp.资源:载入(n[10],"网易WDF动画",n[6])
			self.资源组[6]:置染色(self.染色数据.id,self.染色数据[1],self.染色数据[2],self.染色数据[3])
        	self.资源组[6]:置方向(self.方向)
		end
end




function 场景类_召唤兽饰品染色:显示(dt,x,y)
    self.焦点 = false
    self.资源组[2]:更新(x,y)
    self.资源组[4]:更新(x,y)
    self.资源组[5]:更新(x,y)
    self.资源组[9]:更新(x,y)
    self.资源组[1]:显示(self.x,self.y)
    self.资源组[17]:显示(self.x+342,self.y+25)
    self.资源组[8]:显示(self.x+27,self.y+62)
    self.资源组[4]:显示(self.x + 320,self.y + 242)
    self.资源组[5]:显示(self.x + 388,self.y + 242)
    self.资源组[11]:显示(self.x+250,self.y+55)
    self.资源组[10]:显示(self.x+255,self.y+60,x,y,self.鼠标)
    self.资源组[15]:显示(self.x+310,self.y+127)
    self.资源组[16]:显示(self.x+313+24,self.y+166+15)
    self.资源组[16]:显示(self.x+313+24,self.y+191+15)

    zts:置颜色(白色):显示(self.x+226,self.y+3,self.注释)
    zts:置颜色(白色):显示(self.x+253,self.y+127,"五彩织")
    zts:置颜色(白色):显示(self.x+243+24,self.y+167+15,"所需彩果")
    zts:置颜色(白色):显示(self.x+243+24,self.y+192+15,"所需彩果")
    tp.字体表.排行字体:置颜色(黑色):显示(self.x+347,self.y+184,"20")
    tp.字体表.排行字体:置颜色(黑色):显示(self.x+347,self.y+209,"20")
    zts:置颜色(白色):显示(self.x+252,self.y+27,"选中颜色为：")
    zts:置颜色(白色):显示(self.x+300+ ((100 - zts:取宽度(self.选中染色))/2)+8,self.y+28,self.选中染色)
    self.资源组[2]:显示(self.x + 486,self.y+4 )
    self.资源组[9]:显示(self.x + 110,self.y +240)
    if self.资源组[10].接触 then
        self.选中染色 = math.ceil(80*self.资源组[10]:取百分比())
        if self.选中染色 <= 0 then
            self.选中染色 = 1
        end
        self.焦点 = true
        self.改变 = true
    end
    if self.改变 and not self.焦点 and self.选中染色 and 染色方案[self.选中染色] ~= nil then
         self.染色数据.id=染色方案[self.选中染色].id
         self.染色数据[1]=染色方案[self.选中染色].方案[1]
         self.染色数据[2]=染色方案[self.选中染色].方案[2]
         self.染色数据[3]=染色方案[self.选中染色].方案[3]
         self:置形象()
         self.改变 = false
    end

    if self.鼠标 then
        if self.资源组[2]:事件判断() then
            self:打开()
            return false
        elseif self.资源组[4]:事件判断() then
            self.选中染色=0
            self.染色数据={}
            if bb.饰品染色方案~=nil and bb.饰品染色方案~=0 then
		        self.染色数据.id=bb.饰品染色方案
		    	self.染色数据[1]=bb.饰品染色组[1]
		    	self.染色数据[2]=bb.饰品染色组[2]
		    	self.染色数据[3]=bb.饰品染色组[3]
		    end
            self.资源组[10]:置起始点(0)
            self:置形象()
        elseif self.资源组[5]:事件判断() then
            if tp.队伍[1].装备[3]==nil or tp.队伍[1].装备[3]==0 then
                tp.常规提示:打开("#y/你要染色的武器呢？")
                return
            end
            if self.选中染色~=0 then
                 self.染色数据.id=染色方案[self.选中染色].id
                 self.染色数据[1]=染色方案[self.选中染色].方案[1]
                 self.染色数据[2]=染色方案[self.选中染色].方案[2]
                 self.染色数据[3]=染色方案[self.选中染色].方案[3]
                 self:置形象()
            end
        	请求服务(5012,{序列=bb.认证码,序列1=self.染色数据.id,序列2=self.染色数据[1],序列3=self.染色数据[2],序列4=self.染色数据[3]})
        elseif self.资源组[9]:事件判断() then
            self.方向 = self.方向 - 1
            if self.方向<0 then
                self.方向=3
            end
            self:置形象()
        end
    end
    if self.资源组[7] ~= nil then
        self.资源组[7]:更新(dt)
        self.资源组[7]:显示(self.x + 120,self.y+195)
    end
    if self.资源组[6] ~= nil then
        tp.影子:显示(self.x + 120,self.y+195)
        self.资源组[6]:更新(dt)
        self.资源组[6]:显示(self.x + 120,self.y+195)
    end

    tp.字体表.普通字体:置颜色(白色)
    -- 字体:显示(self.x + 25,self.y + 38,bb.模型)


end

function 场景类_召唤兽饰品染色:检查点(x,y)
    if self.资源组~=nil and self.资源组[1]:是否选中(x,y)  then
        return true
    end
end

function 场景类_召唤兽饰品染色:初始移动(x,y)
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

function 场景类_召唤兽饰品染色:开始移动(x,y)
    if self.鼠标 then
        self.x = x - self.xx
        self.y = y - self.yy
    end
end

return 场景类_召唤兽饰品染色
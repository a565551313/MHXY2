
local 神器更换五行 = class()
local insert = table.insert
local mouseb = 引擎.鼠标弹起
local mousea = 引擎.鼠标按住
local qjq = 取金钱颜色
local tp,ghwxzt

local 神器属性 = {
		大唐官府 = {"伤　　害","物理暴击"},化生寺 = {"防　　御","治疗能力"},方寸山 = {"封印命中","法术伤害"},女儿村 = {"封印命中","固定伤害"},天宫 = {"法术伤害","封印命中"},
		普陀山 = {"固定伤害","治疗能力"},龙宫 = {"法术伤害","法术暴击"},五庄观 = {"伤　　害","封印命中"},魔王寨 = {"法术伤害","法术暴击"},狮驼岭 = {"伤　　害","物理暴击"},
		盘丝洞 = {"封印命中","法术防御"},阴曹地府 = {"伤　　害","法术防御"},神木林 = {"法术伤害","法术暴击"},凌波城 = {"伤　　害","物理暴击"},无底洞 = {"封印命中","治疗能力"},
		花果山 = {"伤　　害","物理暴击"},九黎城 = {"伤　　害","物理暴击"}
	}


local 神器图 = {
                天宫   = {"861333DE","D3F019A9","D90C5658"},
                龙宫   = {"C163A3CB","C5A94CBC","64893E31"},
                化生寺 = {"BCD2FD04","94748447","23906569"},
		        方寸山 = {"F4468EB3","7ADF0AD5","6AD0DD5B"},
		        女儿村 = {"2FE3D5CB","AE659408","478C415A"},
		        普陀山 = {"ACD7AC8C","A26045E7","AF7234E1"},
		        五庄观 = {"7C4D3F9D","0A7537A9","F9CE015C"},
				魔王寨 = {"01AC0038","01AC0039","01AC0040"},
				狮驼岭 = {"898E3905","C621DCE5","768B550B"},
				盘丝洞 = {"767F7971","72527A8B","9F45CA15"},
				神木林 = {"01AC0038","96D9A247","1934A199"},
				凌波城 = {"C068EA63","8794D94E","C0AA056C"},
				无底洞 = {"2034FC4A","0CBEA6CD","FFC9DADB"},
				花果山 = {"861333DE","D3F019A9","D90C5658"},
				大唐官府 = {"467F2FCB","732620A1","AF99EF70"},
		        阴曹地府 = {"E4E601D2","04847348","8F90B0F7"},
		        九黎城 = {"E4E601D2","04847348","8F90B0F7"},
	}

local 五行图 = {
		金 = "01AC0010",木 = "01AC0011",水 = "01AC0012",火 = "01AC0013",土 = "01AC0014"
	}

local 神器图坐标 = {{292,32},{430,32}}

local 五行坐标 = {{405,153},{473,219},{407,286},{338,221}}
local 新五行坐标 = {{403,152},{471,218},{405,285},{336,220}}

function 神器更换五行:初始化(根)
 	self.ID = 140
	self.x = 0
	self.y = 0
	self.xx = 0
	self.yy = 0
	self.注释 = "神器更换五行"
	self.可视 = false
	self.鼠标 = false
	self.焦点 = false
	self.可移动 = true
	self.窗口时间 = 0
	tp = 根
end

function 神器更换五行:加载资源()
	local 资源 = tp.资源
	local 按钮 = tp._按钮
	local 自适应 = tp._自适应
	self.资源组 = {
		[1] = 资源:载入('wdf/pic/神器素材/sqbj.png',"图片"),--zip:取精灵([[sqbj.png]]),
		[2] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","20FD5715"),0,0,3,true,true),
		[3] = 资源:载入('wdf/pic/神器素材/tbwzbj.png',"图片"),--zip:取精灵([[tbwzbj.png]]),
		[4] = 资源:载入('新加界面.npk',"网易WDF动画","258AF3A3"),
		[5] = 资源:载入('新加界面.npk',"网易WDF动画","C057E026"),
		[6] = 资源:载入('wdf/pic/神器素材/sqzbbj.png',"图片"),--zip:取精灵([[sqzbbj.png]]),
		[7] = 资源:载入('wdf/pic/神器素材/swbj.png',"图片"),--zip:取精灵([[swbj.png]]),
		[8] = 资源:载入('新加界面.npk',"网易WDF动画","42DE086A"),
		[9] = 资源:载入('新加界面.npk',"网易WDF动画","C840D36F"),
		[10] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0008"), --消耗底框
		[11] = 资源:载入('新加界面.npk',"网易WDF动画","E4C15C10"),
		[12] = 资源:载入('新加界面.npk',"网易WDF动画","ACEB1F9B"),
		[13] = 资源:载入('新加界面.npk',"网易WDF动画","F3A1A9B3"),
		[14] = 资源:载入('新加界面.npk',"网易WDF动画","A0FB07B8"),
		[15] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0007"), --小斜正方形
		[16] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0015"),0,0,3,true,true), --更换五行按钮
		[17] = 资源:载入('新加界面.npk',"网易WDF动画","01AC0007"), --小斜正方形
		[18] = 资源:载入('新加界面.npk',"网易WDF动画","BCA98FEB"),
		[19] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0036"),0,0,3,true,true), --放弃本次按钮
		[20] = 按钮.创建(资源:载入('新加界面.npk',"网易WDF动画","01AC0035"),0,0,3,true,true), --保存结果按钮
	}
	for n=2,20 do
		if self.资源组[n]~= nil and (n==2 or n==16 or n==19 or n==20) then
			self.资源组[n]:绑定窗口_(self.ID)
		end
	end
	ghwxzt = tp.字体表.普通字体
end

function 神器更换五行:打开(数据)
 	if self.可视 then
		self.可视 = false
		self.新五行属性 = nil

		self.神器属性 = nil
		self.神器显示图 = nil
		self.五行显示图 = nil
		return
	else
		insert(tp.窗口_,self)
		if self.资源组==nil then
		    self:加载资源()
		end
		self.更换时间 = 0
		self.更换等待 = false
		self.左等待时间 = 0
		self.右等待时间 = 0
		self.透明度 = 0
		self.x = (全局游戏宽度/2)-324
		self.y = (全局游戏高度/2)-242
		self.神器属性 = 数据
		self.神器显示图 = {}
		self.主显示部件 = 1
		self.副显示部件 = {2,3}
		self.是否解封 = {false,false,false}
		self.五行显示图 = {}
		for n=1,3 do
			self.五行显示图[n] = {}
			-- if 神器图[tp.队伍[1].门派][2]~=nil then
			-- 	if tp.队伍[1].门派=="神木林" then
			-- 	    if n==1 then
			-- 	        self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[tp.队伍[1].门派][1][n]),0,0,3,true,true)
			-- 	    else
			-- 	    	self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[tp.队伍[1].门派][1][n]),0,0,3,true,true)
			-- 	    end
			--     else
			--     	self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[tp.队伍[1].门派][1][n]),0,0,3,true,true)
			-- 	end
			-- 	-- self.神器显示图[n] = tp._按钮.创建(tp.资源:载入(神器图[tp.队伍[1].门派][2][1] or "新加界面.npk","网易WDF动画",神器图[tp.队伍[1].门派][1][n]),0,0,3,true,true)
			-- else

			    self.神器显示图[n] = tp._按钮.创建(tp.资源:载入("新加界面.npk","网易WDF动画",神器图[tp.队伍[1].门派][n]),0,0,3,true,true)

			--end
			if self.神器属性.神器解锁[n]~=nil then
				for j=1,4 do
					self.五行显示图[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画",五行图[self.神器属性.神器解锁[n].神器五行[j]])
				end
			end
			if self.神器属性.神器解锁[n]~=nil then
				self.是否解封[n] = true
			end
		end
		tp.运行时间 = tp.运行时间 + 1
		self.窗口时间 = tp.运行时间
		self.可视 = true
	end
end

function 神器更换五行:新五行(数据)
	self.新五行属性 = 数据
	self.新五行图 = {}
	for n=1,4 do
		self.新五行图[n] = tp.资源:载入('新加界面.npk',"网易WDF动画",五行图[self.新五行属性[n]])
	end
	self.更换时间 = 110
end

function 神器更换五行:更新(数据)
	self.神器属性 = 数据
	for n=1,3 do
		if self.神器属性.神器解锁[n]~=nil then
			for j=1,4 do
				self.五行显示图[n][j] = tp.资源:载入('新加界面.npk',"网易WDF动画",五行图[self.神器属性.神器解锁[n].神器五行[j]])
			end
		end
	end
	self.更换等待 = false
	self.左等待时间 = 0
	self.右等待时间 = 0
	self.透明度 = 0
	self.更换时间 = 0
	self.资源组[18].当前帧 = 0
end

function 神器更换五行:显示(dt,x,y)
	self.焦点 = false
	self.资源组[1]:显示(self.x,self.y)
	self.资源组[5]:更新(dt)
	self.资源组[5]:显示(self.x - 90,self.y - 70)
	self.资源组[7]:显示(self.x + 215,self.y + 35)
	self.资源组[3]:显示(self.x + 175,self.y - 5)
	self.资源组[2]:更新(x,y)
	self.资源组[2]:显示(self.x + 585,self.y - 5)
	self.资源组[4]:显示(self.x + 283,self.y)
	self.资源组[6]:显示(self.x + 20,self.y + 80)
	self.资源组[8]:显示(self.x + 45,self.y + 205)
	self.资源组[9]:显示(self.x + 73,self.y + 240)
	self.资源组[10]:显示(self.x + 123,self.y + 270)
	self.资源组[10]:显示(self.x + 123,self.y + 300)

	if self.更换时间~= 0 or self.更换等待 then
		if self.左等待时间< self.更换时间 then
			self.左等待时间 = self.左等待时间 + 3
			self.右等待时间 = self.右等待时间 + 4
		else
			self.更换等待 = true
			self.更换时间 = 0
		end
		if self.透明度 < 255 then
			self.透明度 = self.透明度 + 5
		end
		if self.更换等待 then
			self.资源组[18]:更新(dt)
			self.资源组[18]:显示(self.x + 380,self.y + 201)
		end
		self.资源组[12]:置颜色(ARGB(self.透明度,255,255,255))
		self.资源组[17]:置颜色(ARGB(self.透明度,255,255,255))
		self.资源组[12]:显示(self.x + 311 + self.右等待时间,self.y + 119)
		self.资源组[17]:显示(self.x + 395 + self.右等待时间,self.y + 145)
		self.资源组[17]:显示(self.x + 397 + self.右等待时间,self.y + 278)
		self.资源组[17]:显示(self.x + 328 + self.右等待时间,self.y + 213)
		self.资源组[17]:显示(self.x + 463 + self.右等待时间,self.y + 211)
		self.资源组[14]:显示(self.x + 389 + self.右等待时间,self.y + 217)
		for j=1,4 do
			self.新五行图[j]:置颜色(ARGB(self.透明度,255,255,255))
		    self.新五行图[j]:显示(self.x+新五行坐标[j][1] + self.右等待时间,self.y+新五行坐标[j][2])
		end

		self.资源组[11]:显示(self.x + 313 - self.左等待时间,self.y + 120)
		self.资源组[15]:显示(self.x + 397 - self.左等待时间,self.y + 146)
		self.资源组[15]:显示(self.x + 399 - self.左等待时间,self.y + 279)
		self.资源组[15]:显示(self.x + 330 - self.左等待时间,self.y + 214)
		self.资源组[15]:显示(self.x + 465 - self.左等待时间,self.y + 212)
		self.资源组[13]:显示(self.x + 394 - self.左等待时间,self.y + 217)
	else
	    self.资源组[11]:显示(self.x + 313,self.y + 120)
		self.资源组[15]:显示(self.x + 397,self.y + 146)
		self.资源组[15]:显示(self.x + 399,self.y + 279)
		self.资源组[15]:显示(self.x + 330,self.y + 214)
		self.资源组[15]:显示(self.x + 465,self.y + 212)
		self.资源组[13]:显示(self.x + 394,self.y + 217)
	end



	if self.更换等待 then
		self.资源组[19]:更新(x,y)
		self.资源组[20]:更新(x,y)
		self.资源组[19]:显示(self.x + 270,self.y + 340)
		self.资源组[20]:显示(self.x + 450,self.y + 340)
	else
		self.资源组[16]:更新(x,y,self.更换时间==0 and self.是否解封[self.主显示部件])
	    self.资源组[16]:显示(self.x + 340,self.y + 340)
	end
	ghwxzt:置颜色(白色):显示(self.x + 78, self.y + 85,"金：速　　度")
	ghwxzt:置颜色(白色):显示(self.x + 78, self.y + 110,"木：气　　血")
	ghwxzt:置颜色(白色):显示(self.x + 78, self.y + 135,"水："..神器属性[tp.队伍[1].门派][1])
	ghwxzt:置颜色(白色):显示(self.x + 78, self.y + 160,"火："..神器属性[tp.队伍[1].门派][2])
	ghwxzt:置颜色(白色):显示(self.x + 78, self.y + 185,"土：抵抗封印")

	for n=1,3 do
		self.神器显示图[n]:更新(x,y)
	end
    self.神器显示图[self.主显示部件]:显示(self.x + 363,self.y + 42,nil,nil,nil,true,4)
    for n=1,2 do
    	self.神器显示图[self.副显示部件[n]]:显示(self.x + 神器图坐标[n][1],self.y + 神器图坐标[n][2])
    	if self.神器显示图[self.副显示部件[n]]:事件判断() then
    		if self.更换等待 then
    			tp.常规提示:打开("#Y/请先放弃或者保存新的五行。")
    		else
	    		local 加入 = self.主显示部件
	    		self.主显示部件 = self.副显示部件[n]
	    		self.副显示部件[n] = 加入
	    	end
    	end
    end
    if self.神器属性.神器解锁[self.主显示部件]~=nil then
	    for j=1,4 do
	    	self.五行显示图[self.主显示部件][j]:显示(self.x+五行坐标[j][1] - self.左等待时间,self.y+五行坐标[j][2])
	    end
	end

	ghwxzt:置颜色(白色):显示(self.x + 60, self.y + 273,"体力消耗")
	ghwxzt:置颜色(白色):显示(self.x + 60, self.y + 303,"金钱消耗")
	ghwxzt:置颜色(黑色):显示(self.x + 130, self.y + 274,50)
	ghwxzt:置颜色(qjq(800000)):显示(self.x + 130, self.y + 304,800000)


	if self.资源组[2]:事件判断() then
		self.可视 = false
	elseif self.资源组[16]:事件判断() and self.更换时间 == 0 and not self.更换等待 then --更换五行按钮
		请求服务(6225)
		-- self.更换时间 = 110
	elseif self.资源组[19]:事件判断() and self.更换等待 then --放弃本次按钮
		self.更换等待 = false
		self.左等待时间 = 0
		self.右等待时间 = 0
		self.透明度 = 0
		self.更换时间 = 0
		self.资源组[18].当前帧 = 0
	elseif self.资源组[20]:事件判断() and self.更换等待 then --保存结果按钮
		请求服务(6226,{神器部件=self.主显示部件,五行=self.新五行属性})
	end
end

function 神器更换五行:初始移动(x,y)
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

function 神器更换五行:开始移动(x,y)
	if self.鼠标 then
		self.x = x - self.xx
		self.y = y - self.yy


	end
end
function 神器更换五行:检查点(x,y)
	if self.可视 and self.资源组[1]:是否选中(x,y)  then
		return true
	else
		return false
	end
end
return 神器更换五行
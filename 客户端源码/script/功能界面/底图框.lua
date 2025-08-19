--======================================================================--

--======================================================================--
local 系统类_底图框 = class()
local 矩阵 = require("gge包围盒")(650,587,350,35)
local tp;
local keyaz = 引擎.按键按住
local keyax = 引擎.按键按下
local keytq = 引擎.按键弹起
local KEY = KEY

function 系统类_底图框:初始化(根)
	local 按钮 = 根._按钮
	local 资源 = 根.资源
	self.UI_底图 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x3D1FA249)
	self.UI_攻击 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6BBC42FA),0,0,4,true)
	self.UI_道具 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0E53F705),0,0,4,true)
	self.UI_给予 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x7E4DE3DE),0,0,4,true)
	self.UI_交易 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCAB0B8B4),0,0,4,true)
	self.UI_队伍 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x0D3EA20B),0,0,4,true)
	self.UI_宠物 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x187ABFC8),0,0,4,true)
	self.UI_任务 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xA15292B2),0,0,4,true)
	self.UI_帮派 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xC35B2EC3),0,0,4,true)
	self.UI_快捷 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xBB6E607E),0,0,4,true)
	self.UI_好友 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x7C7A64D9),0,0,4,true)
	self.UI_成就 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x8B3AADDA),0,0,4,true)
	self.UI_动作 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x548156A0),0,0,4,true)
	self.UI_系统 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x5116F7DF),0,0,4,true)
	self.好友闪烁 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x6A062464)
	self.申请闪烁 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x0D3EA20B)
	--self.梦幻精灵 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE404DAEC)
   -- self.梦幻精灵 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x2B44FFFB)
	tp = 根
    self.精灵动图 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x7F09EF0A)

end

function 系统类_底图框:显示(dt,x,y)
	self.UI_攻击:更新(x,y,not tp.战斗中)
	self.UI_道具:更新(x,y,not tp.战斗中)
	self.UI_给予:更新(x,y,not tp.战斗中)
	self.UI_交易:更新(x,y,not tp.战斗中)
	self.UI_队伍:更新(x,y,not tp.战斗中)
	self.UI_宠物:更新(x,y,not tp.战斗中)
	self.UI_任务:更新(x,y,not tp.战斗中)
	self.UI_帮派:更新(x,y)
	self.UI_快捷:更新(x,y)
		self.UI_好友:更新(x,y)
		self.UI_成就:更新(x,y,not tp.战斗中)
		self.UI_动作:更新(x,y,not tp.战斗中)
		self.UI_系统:更新(x,y)
		--self.梦幻精灵:更新(dt)
		self.好友闪烁:更新(dt)
		self.申请闪烁:更新(dt)
		--self.精灵动图:更新(dt)
		if (keyaz(KEY.ALT) and keyax(KEY.F4)) then
			错误关闭数=100
			引擎关闭开始()
		end
		if not tp.战斗中 then
			if (keyaz(KEY.ALT) and keyax(KEY.Z))  then
				请求服务(15)
		elseif (keyaz(KEY.ALT) and keyax(KEY.U)) then
			if tp.窗口.坐骑属性栏.可视 then
				tp.窗口.坐骑属性栏:打开()
			else
			    请求服务(96)
			end
		elseif self.UI_攻击:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.A))  then
			tp.鼠标.置鼠标("平时攻击")
		elseif (self.UI_动作:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.D))) and not tp.消息栏焦点 then
				--请求服务(200)
				请求服务(69,{文本="打开"})
      elseif (self.UI_成就:事件判断() or (keyaz(KEY.ALT) and keyax(KEY._1)))  and not tp.消息栏焦点 then
			-- if tp.窗口.成就系统栏.可视==false then
   --              请求服务(22.1)
   --          else
   --              tp.窗口.成就系统栏:打开()
   --          end
                if tp.窗口.多开系统.可视 then
				   tp.窗口.多开系统:打开()
				else
				   请求服务(63,{参数=tp.队伍[1].数字id,文本="获取角色信息"})
			    end

		elseif self.UI_帮派:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.B)) and not tp.消息栏焦点 then
			if tp.窗口.帮派查看.可视 then
				tp.窗口.帮派查看:打开()
			else
				请求服务(6102)
			end
		-- elseif (self.梦幻精灵:是否选中(x,y) and 引擎.鼠标弹起(0)) or (keyaz(KEY.ALT) and keyax(KEY.D)) and not tp.消息栏焦点 then
		-- 	if tp.窗口.仙玉商城类.可视 then
		-- 	    tp.窗口.仙玉商城类:打开()
		-- 	else
		-- 		请求服务(29)
		-- 	end
		elseif self.UI_道具:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.E)) and not tp.消息栏焦点  then
			if 新道具行囊 then
				if tp.窗口.新道具行囊.可视 then
					tp.窗口.新道具行囊:打开()
				else
					请求服务(3699)
				end
			else
			  if tp.窗口.道具行囊.可视 then
					tp.窗口.道具行囊:打开()
				else
					请求服务(3699)
				end
			end
		elseif (keyaz(KEY.ALT) and keytq(KEY.W)) and not tp.消息栏焦点  then
			if tp.窗口.人物状态栏.可视==false then
                请求服务(7)
                tp.窗口.人物状态栏:打开()
            else
                tp.窗口.人物状态栏:打开()
            end
		elseif self.UI_宠物:事件判断() or ( keyaz(KEY.ALT) and keyax(KEY.O)) and not tp.消息栏焦点 then
			if tp.窗口.宠物状态栏.可视==false then
                请求服务(5006)
            else
                tp.窗口.宠物状态栏:打开()
            end
		elseif (keyaz(KEY.ALT) and keyax(KEY.R)) and not tp.消息栏焦点  then
			if tp.窗口.召唤兽属性栏.可视==false then
                请求服务(5001)
            else
                tp.窗口.召唤兽属性栏:打开()
            end
        elseif self.UI_快捷:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.C)) and not tp.消息栏焦点  then
			if tp.快捷技能显示 then
			    tp.快捷技能显示 = not tp.快捷技能显示
			elseif not tp.快捷技能显示 then
				local xsf = false
				for i=1,8 do
					if tp.窗口.快捷技能栏.技能格子~=nil and tp.窗口.快捷技能栏.技能格子[i]~=nil and tp.窗口.快捷技能栏.技能格子[i].技能~=nil then
					    xsf = true
					end
				end
				if not xsf then
				    请求服务(28)
				end
				tp.快捷技能显示 = not tp.快捷技能显示
			end
		elseif self.UI_任务:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.Q)) and not tp.消息栏焦点 and not tp.战斗中 then
		    if tp.窗口.任务栏.可视==false then
			  	请求服务(10)
		  	else
			  	tp.窗口.任务栏:打开()
		  	end
	    elseif self.UI_给予:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.G)) and not tp.消息栏焦点  then
			tp.鼠标.置鼠标("给予")
        elseif self.UI_交易:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.X)) and not tp.消息栏焦点  then
			 tp.鼠标.置鼠标("交易")
        elseif (self.好友闪烁:是否选中(x,y) and 引擎.鼠标弹起(0)) or self.UI_好友:事件判断() or( keyaz(KEY.ALT) and keyax(KEY.F)) and not tp.消息栏焦点  then
            if tp.窗口.好友列表.可视 then
                tp.窗口.好友列表:打开()
            else
			    请求服务(16)
		    end
   --      elseif (keyaz(KEY.ALT) and keyax(KEY.V)) and 调试模式  then
			-- 请求服务(99998)
		elseif (self.申请闪烁:是否选中(x,y) and 引擎.鼠标弹起(0)) or self.UI_队伍:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.T)) and not tp.消息栏焦点  then
			if tp.窗口.队伍栏.可视==false then
               请求服务(4001)
            else
              tp.窗口.队伍栏:打开()
            end
            申请队伍=false
		elseif self.UI_系统:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.S)) and not tp.消息栏焦点  then
			tp.窗口.系统设置:打开()
		elseif (keytq(KEY.ESCAPE))  then
		elseif keyax(KEY.F9) then
			if 玩家显示开关 then
			    玩家显示开关=false
			    玩家加载开关=false
			    for i,v in pairs(tp.场景.玩家) do
					tp.场景.玩家[i].玩家["静立"] = nil
					tp.场景.玩家[i].玩家["行走"] = nil
				end
				tp.常规提示:打开("#Y/玩家动画已经屏蔽,再次按下重新加载玩家动画.....")
			else
				玩家加载开关=true
				玩家显示开关=true
				for i,v in pairs(tp.场景.玩家) do
					tp.场景.玩家[i]:置人物模型()
				end
				tp.常规提示:打开("#Y/玩家动画已经重新加载,请稍后.....")
			end
		elseif keyax(KEY.F10) then
			if 玩家摊位显示开关 then
			    玩家摊位显示开关=false
			else
				玩家摊位显示开关=true
			end
        -- elseif keyax(KEY.F11) then
       	--        tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称, "请选择传送类型",{"场景传送","超级传送"})
		elseif (keyaz(KEY.CTRL) and keyax(KEY.Z))  then
			if 全局游戏宽度<=800 then
				引擎.置宽高(1200,math.ceil(读配置("./config.ini","mhxy","高度")) or 720)
				全局游戏宽度=1200
				全局游戏高度=math.ceil(读配置("./config.ini","mhxy","高度")) or 720
			elseif 全局游戏宽度<=1200 and 全局游戏宽度>=800 then
				引擎.置宽高(1280,math.ceil(读配置("./config.ini","mhxy","高度")) or 720)
				全局游戏宽度=1280
				全局游戏高度=math.ceil(读配置("./config.ini","mhxy","高度")) or 720
			elseif 全局游戏宽度>=1280 then
				引擎.置宽高(800,math.ceil(读配置("./config.ini","mhxy","高度")) or 720)
				全局游戏宽度=800
				全局游戏高度=math.ceil(读配置("./config.ini","mhxy","高度")) or 720
			end
			withs = 全局游戏宽度
			hegts = 全局游戏高度
			with = 全局游戏宽度/2
			hegt = 全局游戏高度/2
			if 全局游戏宽度 < 849 then
				全局游戏宽度=800
			end
			if 全局游戏高度 < 618 then
				全局游戏高度=620
			end
			--=========
			if 全局游戏宽度 > 1281 then
				全局游戏宽度=1280
			end
			if 全局游戏高度 > 822 then
				全局游戏高度=820
			end
			写配置("./config.ini","mhxy","宽度",全局游戏宽度)
			写配置("./config.ini","mhxy","高度",全局游戏高度)
			tp.场景.过度纹理 = require("gge纹理类")():渲染目标(全局游戏宽度,全局游戏高度)
		elseif (keyaz(KEY.CTRL) and keyax(KEY.X))  then
			if 全局游戏高度<=620 then
				引擎.置宽高(math.ceil(读配置("./config.ini","mhxy","宽度")) or 800,600)
				全局游戏宽度=math.ceil(读配置("./config.ini","mhxy","宽度")) or 800
				全局游戏高度=720
			elseif 全局游戏高度==720 then
				引擎.置宽高(math.ceil(读配置("./config.ini","mhxy","宽度")) or 800,600)
				全局游戏宽度=math.ceil(读配置("./config.ini","mhxy","宽度")) or 800
				全局游戏高度=820
			elseif 全局游戏高度>=768 then
				引擎.置宽高(math.ceil(读配置("./config.ini","mhxy","宽度")) or 800,600)
				全局游戏宽度=math.ceil(读配置("./config.ini","mhxy","宽度")) or 800
				全局游戏高度=620
			end
			withs = 全局游戏宽度
			hegts = 全局游戏高度
			with = 全局游戏宽度/2
			hegt = 全局游戏高度/2
			if 全局游戏宽度 < 799 then
				全局游戏宽度=800
			end
			if 全局游戏高度 < 599 then
				全局游戏高度=600
			end
			--======
			if 全局游戏宽度 > 1281 then
				全局游戏宽度=1280
			end
			if 全局游戏高度 > 822 then
				全局游戏高度=820
			end
			写配置("./config.ini","mhxy","宽度",全局游戏宽度)
			写配置("./config.ini","mhxy","高度",全局游戏高度)
			wbgb = true
			tp.场景.过度纹理 = require("gge纹理类")():渲染目标(全局游戏宽度,全局游戏高度)
		end
	else
		if self.UI_快捷:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.C)) and not tp.消息栏焦点  then
			请求服务(12)
		elseif self.UI_任务:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.Q)) and not tp.消息栏焦点 and not tp.战斗中 then
		    if tp.窗口.任务栏.可视==false then
			  	请求服务(10)
		  	else
			  	tp.窗口.任务栏:打开()
		  	end
		elseif (self.好友闪烁:是否选中(x,y) and 引擎.鼠标弹起(0)) or self.UI_好友:事件判断() or( keyaz(KEY.ALT) and keyax(KEY.F)) and not tp.消息栏焦点  then
            if tp.窗口.好友列表.可视 then
                tp.窗口.好友列表:打开()
            else
			    请求服务(16)
		    end
		elseif self.UI_系统:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.S)) and not tp.消息栏焦点  then
			tp.窗口.系统设置:打开()
		end
	end
	self.UI_底图:显示(全局游戏宽度-350,全局游戏高度-63)
	self.UI_攻击:显示(全局游戏宽度-346,全局游戏高度-34,true)
	self.UI_道具:显示(全局游戏宽度-320,全局游戏高度-34,true)
	self.UI_给予:显示(全局游戏宽度-294,全局游戏高度-34,true)
	self.UI_交易:显示(全局游戏宽度-269,全局游戏高度-34,true)
	self.UI_队伍:显示(全局游戏宽度-243,全局游戏高度-34,true)
	self.UI_宠物:显示(全局游戏宽度-218,全局游戏高度-34,true)
	self.UI_任务:显示(全局游戏宽度-191,全局游戏高度-34,true)
	self.UI_帮派:显示(全局游戏宽度-164,全局游戏高度-34,true)
	self.UI_快捷:显示(全局游戏宽度-137,全局游戏高度-34,true)
	self.UI_好友:显示(全局游戏宽度-110,全局游戏高度-34,true)
	-- if tp.窗口.任务栏:是否有该任务("罗羹效果") then
	-- 	self.罗羹效果:显示(全局游戏宽度-120,60)
	-- end
	if not tp.战斗中 and 消息闪烁 then
	  self.好友闪烁:显示(全局游戏宽度-110,全局游戏高度-34)
    end
    if not tp.战斗中 and 申请队伍 then
        self.申请闪烁:显示(全局游戏宽度-243,全局游戏高度-34)
    end
	self.UI_成就:显示(全局游戏宽度-81,全局游戏高度-31,true)
	self.UI_动作:显示(全局游戏宽度-53,全局游戏高度-34,true)
	self.UI_系统:显示(全局游戏宽度-26,全局游戏高度-34,true)

	--self.梦幻精灵:显示(全局游戏宽度-55,全局游戏高度-110)



	if self:检查点(x,y) then
		tp.按钮焦点 = true
	end
	if self.UI_攻击:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷键:ALT+A")
    elseif self.UI_道具:是否选中(x,y)  then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+E")
    elseif self.UI_给予:是否选中(x,y)  then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+G")
    elseif self.UI_交易:是否选中(x,y)  then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+X")
    elseif self.UI_队伍:是否选中(x,y) or self.申请闪烁:是否选中(x,y)  then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+T")
    elseif self.UI_宠物:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+O")
    elseif self.UI_任务:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+Q")
    elseif self.UI_帮派:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+B")
    elseif self.UI_快捷:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+C")
    elseif self.UI_好友:是否选中(x,y) or self.好友闪烁:是否选中(x,y)  then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+F")
    elseif self.UI_成就:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"多开快捷键:ALT+1")
    elseif self.UI_动作:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"藏宝阁:ALT+D")
    elseif self.UI_系统:是否选中(x,y) then
        tp.提示:自定义(x-42,y+27,"快捷键:ALT+S")
    -- elseif self.梦幻精灵:是否选中(x,y)  then
    --     tp.提示:自定义(x-42,y+27,"快捷键:ALT+D")
	end
end

function 系统类_底图框:检查点(x,y)
	return 矩阵:检查点(x,y)
end

return 系统类_底图框
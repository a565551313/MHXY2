--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-06-16 00:52:07
--======================================================================--
local 系统类_时辰 = class()

local floor = math.floor
local ARGB = ARGB
local require = require
local 矩阵 = require("gge包围盒")(0,0,115,95)
local tp
local zt
local format = string.format
local keyaz = 引擎.按键按住
local keyax = 引擎.按键按下
local keytq = 引擎.按键弹起


function 系统类_时辰:初始化(根)
	self.序列=1
	local 按钮 = 根._按钮
	local 自适应 = 根._自适应
	local 资源 = 根.资源
	-- self.背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xF6A5602D)
	-- self.白昼 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAA23B98F)
	-- self.黑昼 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x82DB3814)
	self.小人跑步 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xAC307575)
	self.小人走路 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xC7BEBF45)




	self.背景 = 资源:载入('房屋图标.wdf',"网易WDF动画",0xDE3F48B7)
	self.白昼 = 资源:载入('房屋图标.wdf',"网易WDF动画",0x9DF6DEBC).精灵
	self.黑昼 = 资源:载入('房屋图标.wdf',"网易WDF动画",0x99738F4C).精灵
	-- self.小人跑步 = 资源:载入('wzife.wdf',"网易WDF动画",0xAC307575)
	-- self.小人走路 = 资源:载入('wzife.wdf',"网易WDF动画",0xC7BEBF45)

	--self.排行 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x30712485),0,0,4)
	self.排行 =按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4)
	self.收缩 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6C566DEA),0,0,4)
	self.缩放 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xD5E6B287),0,0,4)
	self.世界 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xCA5242C2),0,0,4)
	--self.日历 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0xAD514E92),0,0,4)
	--self.查询 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x6ECBCED7),0,0,4)
	self.日历 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0xAF63A102),0,0,4)--
	self.查询 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0xF05DB752),0,0,4)--梦幻指引

	-- self.梦幻指引 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0xF05DB752),0,0,4)--
	-- self.梦幻日历 = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0xAF63A102),0,0,4)--



	--self.指引箭头 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE832C9D7)
    self.多开系统 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x99998890),0,0,4,true)
	self.剑会 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)
	self.商城 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)
	-- self.自动抓鬼 = 按钮.创建(资源:载入('状态图标.wdf',"网易WDF动画",0x00000021),0,0,4,true)
	-- self.日常福利 = 按钮.创建(资源:载入('状态图标.wdf',"网易WDF动画",0x00000023),0,0,4,true)
	-- self.藏宝阁 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x99998891),0,0,4,true)
    self.抽奖 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)
 	self.会员 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)
	self.充值 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)
	self.累充 = 按钮.创建(资源:载入('登陆资源.wdf',"网易WDF动画",0x48D2590A),0,0,4,true)



--7F09EF0A 蓝色转圈 --99998892--罗盘 99998888--蓝猪

	self.地图 = nil
	self.偏移 = nil
	self.计时 = 0
	self.计次 = 150
	self.偏移坐标 = 0
	self.偏移时间 = 0
	self.灯笼 = {}
    self.白昼:置区域(self.计次,0,80,30)
	for n=1,3 do
	   self.灯笼[n] = 按钮.创建(资源:载入('房屋图标.wdf',"网易WDF动画",0xBAF6A95D),0,0,2)
	end
	tp = 根
	zt = tp.字体表.描边字体
	sj = tp.字体表.时间字体
	-- local g = {0xB9FD3C98,0xFE026DC3,0xCDB4C444,0xDFE4105D,0xA66B9C4,0x5A94EB4C,0xD2A6E5EC,0xEEADB7F5,0x399E1F40,0x6FFBDFD8,0xDEBA9F52,0x49D3DE80}
	-- self.时辰={}
	-- for n=1,12 do
 --      self.时辰[n]=资源:载入('登陆资源.wdf',"网易WDF动画",g[n])
	-- end
	local g = {0x361FA820,0xC0A66903,0xD1D11294,0xAA7DEB05,0x21274A87,0x09C4978D,0xC9E2F072,0x2ACB36B2,0xC26BF189,0x1AA170AE,0x7921D3A3,0xEA7CAB84}
	self.时辰={}
	for n=1,12 do
      self.时辰[n]=资源:载入('房屋图标.wdf',"网易WDF动画",g[n])
	end
end

function 系统类_时辰:刷新()
	self.地图 = 取地图名称(tp.当前地图)
	self.偏移 = 60 - #self.地图*3.72
end

function 系统类_时辰:显示(dt,x,y)
	if 矩阵:检查点(x,y) then
		tp.选中UI = true
	end

	self.计时 = self.计时 + dt
	if self.计时 >= 1 then
		self.计次 = self.计次 - 1
		self.计时 = 0
	end
	if 日夜=="黑夜" then
		self.黑昼:置区域(self.计次,0,80,30)
		self.黑昼:显示(14,32 + self.偏移坐标)
	else
		self.白昼:置区域(self.计次,0,80,30)
		self.白昼:显示(14,32 + self.偏移坐标)
	end

	self.背景:显示(0,0 + self.偏移坐标)
	if 引擎.场景.场景.人物~=nil and 引擎.场景.场景.人物.行为 == "行走" then
		self.小人跑步:更新(dt)
	    self.小人跑步:显示(58,60 + self.偏移坐标)
	    i=1
	else
		self.小人走路:更新(dt)
		self.小人走路:显示(58,60 + self.偏移坐标)
	end
	self.收缩:更新(x,y)
	self.收缩:显示(3,64 + self.偏移坐标)
	if self.收缩:事件判断() then
		if self.偏移坐标 == 0 then
			self.偏移坐标 = -64
			矩阵:置坐标(0,-64)
		else
		    self.偏移坐标 = 0
		    矩阵:置坐标(0,0)
		end
	end



	if self.偏移坐标 == 0 then

	     for n=1,3 do
		   self.灯笼[n]:更新(x,y)
		   self.灯笼[n]:显示(93,17+((n-1)*18))
		end



		self.排行:更新(x,y)
		--self.世界:更新(x,y)
		self.日历:更新(x,y)
		self.查询:更新(x,y)
		self.剑会:更新(x,y)
		self.商城:更新(x,y)
		-- self.日常福利:更新(x,y)
		-- self.藏宝阁:更新(x,y)
		-- self.自动抓鬼:更新(x,y)
		 self.抽奖:更新(x,y)
		-- self.多开系统:更新(x,y)
		 self.会员:更新(x,y)
		 self.充值:更新(x,y)
		 self.累充:更新(x,y)

		if self.日历:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.V)) and not tp.战斗中 then
		   请求服务(40,{获取="打开"})

		 -- tp.窗口.梦幻指引:打开()
		end
		--self.世界:显示(30,42 + self.偏移坐标)
		self.查询:显示(1,78 + self.偏移坐标)
		self.日历:显示(58,78 + self.偏移坐标)


        if  not tp.战斗中 then
        	self.剑会:显示(1,85 + self.偏移坐标+20)
			sj:显示(10,87 + self.偏移坐标+20,"剑会天下")
        	self.商城:显示(1,108 + self.偏移坐标+25)
			sj:显示(10,110 + self.偏移坐标+25,"快捷商城")
        	self.会员:显示(1,130 + self.偏移坐标+30)
			sj:显示(10,132 + self.偏移坐标+30,"会员功能")
			self.排行:显示(1,152 + self.偏移坐标+35)
			sj:显示(10,154 + self.偏移坐标+35,"梦幻排行")
			self.充值:显示(1,174 + self.偏移坐标+40)
			sj:显示(10,176 + self.偏移坐标+40,"仙玉充值")
			self.累充:显示(1,196 + self.偏移坐标+45)
			sj:显示(10,198 + self.偏移坐标+45,"累充礼包")
			-- self.多开系统:显示(85,57 + self.偏移坐标)
			-- self.日常福利:显示(20,105 + self.偏移坐标)
			-- self.藏宝阁:显示(150,0 + self.偏移坐标)
			self.抽奖:显示(1,218 + self.偏移坐标+50)
			sj:显示(10,220 + self.偏移坐标+50,"转盘抽奖")
			-- self.自动抓鬼:显示(97,100+ self.偏移坐标)

	    end








	end
	if self.排行:事件判断() and not tp.战斗中 then
		if tp.窗口.排行榜.可视==false then
			请求服务(39)
		else
			tp.窗口.排行榜:打开()
		end

	-- 	-- if tp.窗口.多开系统.可视 then
	-- 	--    tp.窗口.多开系统:打开()
	-- 	-- else
	-- 	--    请求服务(63,{参数=tp.队伍[1].数字id,文本="获取角色信息"})
	--  --    end


	-- elseif self.世界:事件判断() and not tp.战斗中 then
	-- 	tp.窗口.世界大地图:打开()
	-- else

   elseif self.查询:事件判断()  and not tp.战斗中 and not tp.消息栏焦点  then

   	请求服务(46)
		--tp.窗口.小地图:打开(tp.当前地图)
	elseif self.剑会:事件判断() and not tp.战斗中 then
            请求服务(65)
    elseif self.商城:事件判断() and not tp.战斗中 then
    	--tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称, "请选择传送类型",{"场景传送","超级传送"})

    	if tp.窗口.仙玉商城类.可视 then
			    tp.窗口.仙玉商城类:打开()
			else
				请求服务(29)
			end

    elseif self.灯笼[1]:事件判断() and not tp.战斗中 then
		-- if tp.窗口.任务栏.可视==false then
		-- 	请求服务(10)
		-- else
		-- 	tp.窗口.任务栏:打开()
		-- end
		tp.窗口.CDK充值:打开()
	elseif self.灯笼[2]:事件判断() and not tp.战斗中 then
		-- tp.窗口.世界大地图:打开()
      请求服务(61,{文本="打开"})
	elseif (self.灯笼[3]:事件判断() or keytq(KEY.TAB)) and not tp.战斗中 and not tp.消息栏焦点  then
		tp.窗口.小地图:打开(tp.当前地图)
    elseif self.会员:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.K)) and not tp.战斗中 then
		 请求服务(81)
		     elseif self.充值:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.K)) and not tp.战斗中 then
		 tp.窗口.CDK充值:打开()
		     elseif self.累充:事件判断() or (keyaz(KEY.ALT) and keyax(KEY.K)) and not tp.战斗中 then
		 		  请求服务(36,{领取= "打开"})

	-- elseif self.日常福利:事件判断() and not tp.战斗中 then
	-- 	请求服务(36,{领取= "打开"})
 --    elseif self.自动抓鬼:事件判断() and not tp.战斗中 then
	-- 	tp.窗口.对话栏:文本(tp.队伍[1].模型,tp.队伍[1].名称,"是否开启自动抓鬼(鬼王),每次接取任务扣除1次自动抓鬼",{"自动抓鬼","自动鬼王","我们后会有期"})
 --    elseif self.藏宝阁:事件判断() and not tp.战斗中 then
	-- 	请求服务(69,{文本="打开"})
	elseif self.抽奖:事件判断() and not tp.战斗中 then
	请求服务(61,{文本="打开"})
 --    elseif self.多开系统:事件判断() and not tp.战斗中 then
 --    	if tp.窗口.多开系统.可视 then
	-- 	   tp.窗口.多开系统:打开()
	-- 	else
	-- 	   请求服务(63,{参数=tp.队伍[1].数字id,文本="获取角色信息"})
	--     end

	end


	if self.序列>=5 and self.序列<=10 then
	    日夜="白天"
	else
		日夜="黑夜"
	end



	-- self.时辰[self.序列]:显示(39,7.5 + self.偏移时间)
	-- sj:置字间距(0)
	-- sj:置颜色(白色):显示(75,5.5+self.偏移时间,os.date("%X", os.time()))
	-- local xy = "["..floor(tp.角色坐标.x/20)..","..floor(tp.角色坐标.y/20).."]"
	-- if self.偏移~=nil then
	--    zt:置字间距(0)
	--    zt:置颜色(白色):显示(self.偏移-19,23.5 + self.偏移坐标,self.地图..xy)
	-- end

	self.时辰[self.序列]:显示(1.3,21.5 + self.偏移坐标)
    if self.偏移~=nil then
      zt:置字间距(0)
	   zt:显示(self.偏移-1,13.5 + self.偏移坐标,self.地图)
	end
	local xy = "X:"..floor(tp.角色坐标.x/20).." Y:"..floor(tp.角色坐标.y/20)
	zt:显示(floor(61 - zt:取宽度(xy) / 2)-1.5,62 + self.偏移坐标,xy)



	if self.排行:是否选中(x,y) then
       tp.提示:自定义(x-42,y+27,"排行榜")
	elseif self.日历:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"梦幻指引")
	-- elseif self.世界:是否选中(x,y) then
	-- 	tp.提示:自定义(x-42,y+27,"快捷键:ALT+M")
	elseif self.查询:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷键:Tab")
	elseif self.剑会:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"剑会天下")
	elseif self.商城:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷商城")
	elseif self.会员:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"快捷功能")
			elseif self.充值:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"仙玉充值")
					elseif self.累充:是否选中(x,y) then
		tp.提示:自定义(x-42,y+27,"累充礼包")
 --    elseif self.日常福利:是否选中(x,y) then
	-- 	tp.提示:自定义(x-42,y+27,"福利界面")
 --    elseif self.藏宝阁:是否选中(x,y) then
	-- 	tp.提示:自定义(x-42,y+27,"藏宝阁")
	-- elseif self.自动抓鬼:是否选中(x,y) then
	-- 	tp.提示:自定义(x-42,y+27,"自动抓鬼")
elseif self.抽奖:是否选中(x,y) then
tp.提示:自定义(x-42,y+27,"搏一搏,单车变摩托")
 --    elseif self.多开系统:是否选中(x,y) then
	-- 	tp.提示:自定义(x-42,y+27,"角色多开")

	end

	-- if 日夜=="黑夜" then
	-- 	self.黑昼:显示(18,7.5 + self.偏移坐标)
	-- 	return
	-- else
	-- 	self.白昼:显示(18,7.5 + self.偏移坐标)
	-- 	return
	-- end

end

function 系统类_时辰:检查点(x,y)
	return 矩阵:检查点(x,y)
end

return 系统类_时辰
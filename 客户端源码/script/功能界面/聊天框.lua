--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19
-- @Last Modified time: 2025-02-10 22:36:37
--======================================================================--
local 系统类_消息框 = class()
local bw = require("gge包围盒")(0,0,19,19)
local bw1 = require("gge包围盒")(0,0,19,21)
local bw2 = require("gge包围盒")(0,0,12,12)
local bw3 = require("gge包围盒")(0,0,30,26)
local w = 390
local h = 127
local x = 0
local y = 全局游戏高度-165
local y1 = y
local xx,yy,yyy = 0,0,0
local tp
local floor  = math.floor
local mousea = 引擎.鼠标按下
local mouseb = 引擎.鼠标弹起
local keyb   = 引擎.按键按下
local format = string.format
wbgb按钮开关 =nil

function 系统类_消息框:初始化(根)
	local 资源 = 根.资源
	local 按钮 = 根._按钮
	self.丰富文本 =  根._丰富文本(400,h)
	    :添加元素("xt",资源:载入('登陆资源.wdf',"网易WDF动画",0x43700E25)) --系统
		:添加元素("sj",资源:载入('登陆资源.wdf',"网易WDF动画",0x1B1DCE56)) --世界
		:添加元素("dq",资源:载入('登陆资源.wdf',"网易WDF动画",0x65C5B7EE)) --当前
		:添加元素("sl",资源:载入('登陆资源.wdf',"网易WDF动画",0xF9ADC3DA)) --私聊
		:添加元素("cy",资源:载入('登陆资源.wdf',"网易WDF动画",0x6A92C472)) --传音
		:添加元素("dt",资源:载入('登陆资源.wdf',"网易WDF动画",0xFC41B9B4)) --大唐
		:添加元素("hs",资源:载入('登陆资源.wdf',"网易WDF动画",0x0902DAF6)) --化生
		:添加元素("lg",资源:载入('登陆资源.wdf',"网易WDF动画",0x212E3A85)) --龙宫
		:添加元素("tg",资源:载入('登陆资源.wdf',"网易WDF动画",0x2BF201B4)) --天宫
		:添加元素("pts",资源:载入('登陆资源.wdf',"网易WDF动画",0x4100814A)) --普陀
		:添加元素("fc",资源:载入('登陆资源.wdf',"网易WDF动画",0x81B9B7F2)) --方寸
		:添加元素("st",资源:载入('登陆资源.wdf',"网易WDF动画",0xA5F25FB3)) --狮驼
		:添加元素("mw",资源:载入('登陆资源.wdf',"网易WDF动画",0xADE6DAA4)) --魔王
		:添加元素("ne",资源:载入('登陆资源.wdf',"网易WDF动画",0xB3296C64)) --女儿
		:添加元素("ps",资源:载入('登陆资源.wdf',"网易WDF动画",0xEDE8EA9A)) --盘丝
		:添加元素("wz",资源:载入('登陆资源.wdf',"网易WDF动画",0x2535CF6D)) --五庄
		:添加元素("df",资源:载入('登陆资源.wdf',"网易WDF动画",0x46C2DDA3)) --地府
		:添加元素("lb",资源:载入('登陆资源.wdf',"网易WDF动画",0x000C253D)) --凌波
		:添加元素("wd",资源:载入('登陆资源.wdf',"网易WDF动画",0x4E6A12A9)) --无底
		:添加元素("sm",资源:载入('登陆资源.wdf',"网易WDF动画",0x114ABFFE)) --神木
		:添加元素("gm",资源:载入('登陆资源.wdf',"网易WDF动画",0xE8897A81)) --GM
	    :添加元素("cw",资源:载入('登陆资源.wdf',"网易WDF动画",0xCD23D726))	--传闻
	    :添加元素("bp",资源:载入('登陆资源.wdf',"网易WDF动画",0xAD9D6490)) --帮派
	    :添加元素("dw",资源:载入('登陆资源.wdf',"网易WDF动画",0xF9858C95)) --队伍
	    :添加元素("hd",资源:载入('登陆资源.wdf',"网易WDF动画",0x285527E7)) --活动
	    :添加元素("fq",资源:载入('登陆资源.wdf',"网易WDF动画",0x29F78369)) --夫妻
	-- self.丰富文本外框 =  根._丰富文本(250,h)
	self.丰富文本外框 =  require("script/系统类/丰富文本类外部")(250,h)
	    :添加元素("xt",资源:载入('登陆资源.wdf',"网易WDF动画",0x43700E25)) --系统
		:添加元素("sj",资源:载入('登陆资源.wdf',"网易WDF动画",0x1B1DCE56)) --世界
		:添加元素("dq",资源:载入('登陆资源.wdf',"网易WDF动画",0x65C5B7EE)) --当前
		:添加元素("sl",资源:载入('登陆资源.wdf',"网易WDF动画",0xF9ADC3DA)) --私聊
		:添加元素("cy",资源:载入('登陆资源.wdf',"网易WDF动画",0x6A92C472)) --传音
		:添加元素("dt",资源:载入('登陆资源.wdf',"网易WDF动画",0xFC41B9B4)) --大唐
		:添加元素("hs",资源:载入('登陆资源.wdf',"网易WDF动画",0x0902DAF6)) --化生
		:添加元素("lg",资源:载入('登陆资源.wdf',"网易WDF动画",0x212E3A85)) --龙宫
		:添加元素("tg",资源:载入('登陆资源.wdf',"网易WDF动画",0x2BF201B4)) --天宫
		:添加元素("pts",资源:载入('登陆资源.wdf',"网易WDF动画",0x4100814A)) --普陀
		:添加元素("fc",资源:载入('登陆资源.wdf',"网易WDF动画",0x81B9B7F2)) --方寸
		:添加元素("st",资源:载入('登陆资源.wdf',"网易WDF动画",0xA5F25FB3)) --狮驼
		:添加元素("mw",资源:载入('登陆资源.wdf',"网易WDF动画",0xADE6DAA4)) --魔王
		:添加元素("ne",资源:载入('登陆资源.wdf',"网易WDF动画",0xB3296C64)) --女儿
		:添加元素("ps",资源:载入('登陆资源.wdf',"网易WDF动画",0xEDE8EA9A)) --盘丝
		:添加元素("wz",资源:载入('登陆资源.wdf',"网易WDF动画",0x2535CF6D)) --五庄
		:添加元素("df",资源:载入('登陆资源.wdf',"网易WDF动画",0x46C2DDA3)) --地府
		:添加元素("lb",资源:载入('登陆资源.wdf',"网易WDF动画",0x000C253D)) --凌波
		:添加元素("wd",资源:载入('登陆资源.wdf',"网易WDF动画",0x4E6A12A9)) --无底
		:添加元素("sm",资源:载入('登陆资源.wdf',"网易WDF动画",0x114ABFFE)) --神木
		:添加元素("gm",资源:载入('登陆资源.wdf',"网易WDF动画",0xE8897A81)) --GM
	    :添加元素("cw",资源:载入('登陆资源.wdf',"网易WDF动画",0xCD23D726))	--传闻
	    :添加元素("bp",资源:载入('登陆资源.wdf',"网易WDF动画",0xAD9D6490)) --帮派
	    :添加元素("dw",资源:载入('登陆资源.wdf',"网易WDF动画",0xF9858C95)) --队伍
	    :添加元素("hd",资源:载入('登陆资源.wdf',"网易WDF动画",0x285527E7)) --活动
	    :添加元素("fq",资源:载入('登陆资源.wdf',"网易WDF动画",0x29F78369)) --夫妻
		self.背景 = 根._自适应.创建(71,1,125,23,3,9)
		self.精灵组框 = 根._自适应.创建(105,1,1,1,3,9)
		self.精灵组框:置宽高(400+10,h+15)
		self.精灵组框:置颜色(0xFF336666)



	self.频道背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xB39D470E)
	self.输入背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x4BC54173)
	self.输入背景1 = 资源:载入(wdf配置.."/pic/底图聊天框.png", "图片")
	self.表情开关 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x590CAA9B)
	self.表情开关.当前帧 = 2
	self.表情开关:更新纹理()
	self.频道名字 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x3EFEA3B2),0,0,1)
	self.按钮_下 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xF21AD59C),0,0,1,true)
	-- self.按钮_左拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x5A8515D4),0,0,1,true)
	self.按钮_左拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x55AB686A),0,0,1,true)
	-- self.按钮_上拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x2544285A),0,0,1,true)
	self.按钮_上拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x9C6CABF6),0,0,1,true)
	-- self.按钮_下拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xA0617E8C),0,0,1,true)
	self.按钮_下拉 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x2BA6891C),0,0,1,true)
	-- self.按钮_清屏 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x2B24A44E),0,0,1,true)
	self.按钮_清屏 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xAEB2E8AC),0,0,1,true)
	-- self.按钮_禁止 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x1122D737),0,0,1,true)
	self.按钮_禁止 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x1122D737),0,0,1,true)
	-- self.按钮_锁定 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x020FDFE9),0,0,1,true)
	self.按钮_锁定 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x9B8428CC),0,0,1,true)
	self.按钮_移动 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x32BE710D),0,0,1,true,nil,true)
	-- self.按钮_查询 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x1AA0EBD4),0,0,1,true)
	self.按钮_查询 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x2E6E37A3),0,0,1,true)
	self.按钮_拉伸 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD209A05E),0,0,1,true,nil,true)
	self.喇叭 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0xD150CE5B),0,0,1,true)

	self.按钮_拉伸.确定按下 = false
	self.按钮_移动.确定按下 = false
	self.按钮_颜色框 = 按钮(资源:载入('登陆资源.wdf',"网易WDF动画",0x9D123E79),0,0,1,true)
	self.控件类 = require("ggeui/加载类")()
	local 总控件 = self.控件类:创建控件('创建控件')
	总控件:置可视(true,true)
	self.输入 = 总控件:创建输入("创建输入",102,全局游戏高度-19,348,14)

	self.输入:置可视(true,true)
	self.输入:置限制字数(120)
	self.输入:置光标颜色(4294967295)
	self.输入:置文字颜色(4294967295)
	self.qqy=全局游戏高度-19
	self.隐藏 = false
	self.移动 = false
	self.可移动 = false
	self.可拉伸 = false
	self.禁止 = false
	self.计时 = 0
	self.颜色开始 = false
	self.表情开始 = false
	self.外部聊天 = false
	self.颜色精灵 = require("gge精灵类")(0,0,0,12,12)
	self.颜色表 = {{"#R/",0xFFFF0000,"红色"},{"#C/",0xFFFF9932,"橙色"},{"#Y/",0xFFFFFF00,"黄色"},{"#G/",0xFF00FF00,"绿色"},{"#P/",0xFF00FFFF,"青色"},{"#B/",0xFF03A89E,"蓝色"},{"#F/",0xFFFF00FF,"紫色"},{"#W/",0xFFFFFFFF,"白色"}}
	tp = 根
	self.本页临时高度 = 全局游戏高度
    self.频道={}
    local x频道 = {0X3EFEA3B2,0X177C94C8,0X53B4E145,0X43A27A6,0XEB0A7DDA,0X1346424F,0X1961D39F,0X1FF1384F,0X4705033A,0X74158BD0,0X9FE6A010,0x6A92C472}
    for n=1,#x频道 do
      self.频道[n]=资源:载入('登陆资源.wdf',"网易WDF动画",x频道[n])
    end
	self.序列=1
	self.频道开关=false
	self.发言记录={}
	self.超链接={}
	self.超链接记录={}
	self.包围盒 = require("gge包围盒2")(0,405,10,10)

	self.分割 = 资源:载入('登陆资源.wdf',"网易WDF动画",0xE03A06B3)
	self.头像 = {}
    self.头像图标 = {}
    self.头像提示 = {}
    self.头像背景 = 资源:载入('登陆资源.wdf',"网易WDF动画",0x360B8373)
    self.法术状态 = {}
	for i=1,5 do
		self.头像[i] = false
		self.头像图标[i] = nil
		self.头像提示[i] = nil
		self.法术状态[i] = {}
	end


end

function 系统类_消息框:检查点()
	if self.包围盒:检查点(鼠标.x,鼠标.y) or self.丰富文本:检查鼠标() then
		return true
	else
		return false
	end
end

function 系统类_消息框:添加文本(文本,频道,超链)
	if self.禁止 then
		return
	end
	if 频道 == "" or 频道==nil then
		self.丰富文本:添加文本(文本)
		self.丰富文本外框:添加文本(文本)
	else
		self.丰富文本:添加文本("#"..(频道 or "系统").."/#W/"..文本,超链)
		self.丰富文本外框:添加文本("#"..(频道 or "系统").."/#W/"..文本,超链)
	end
end


function 系统类_消息框:添加战斗状态(玩家)
	if not self.外部聊天 or not tp.战斗中 then
		return
	end
	for i=1 ,#玩家 do
		self.头像[i] = true
	    self.头像图标[i]=nil
	    local n = 引擎.取头像(玩家[i].模型)
		self.头像[i]=true
		self.头像图标[i] = tp.资源:载入(n[7],"网易WDF动画",n[2])
		self.头像提示[i] = 玩家[i].名称
		if 玩家[i].法术状态~= nil  then
			self.法术状态[i] = {}
			 for n, v in pairs(玩家[i].法术状态) do
				 	local f = 引擎.取状态图标(n)-----从做
					if n == "战意" or n=="超级战意" or n=="风灵" or n=="剑意"  or n=="符咒"  then
						if v>0 then
						    self.法术状态[i][#self.法术状态[i]+1]={名称=n,回合=v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
						end
					elseif n == "灵药红" or n=="灵药蓝" or n=="灵药黄" then
						if v>0 then
							f = 引擎.取状态图标("灵药")
							local 是否有灵药 = 0
							for k=1,#self.法术状态[i] do
								if self.法术状态[i][k].名称 =="灵药" then
									是否有灵药 = k
							    end

							end
							if 是否有灵药==0 then
								 if n=="灵药红" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="灵药",回合="红:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="灵药蓝" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="灵药",回合="蓝:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="灵药黄" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="灵药",回合="黄:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
						         end
						     else
						     	 if n=="灵药红" then
						     	 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 红:"..v
								 elseif n=="灵药蓝" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 蓝:"..v
								 elseif n=="灵药黄" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 黄:"..v
						         end
						     end
                        end
                    elseif n == "雷法崩裂" or n=="雷法震煞" or n=="雷法坤伏" or n=="雷法翻天" or n=="雷法倒海" then
						if v>0 then
							f = 引擎.取状态图标("雷法")
							local 是否有灵药 = 0
							for k=1,#self.法术状态[i] do
								if self.法术状态[i][k].名称 =="雷法" then
									是否有灵药 = k
							    end
							end
							if 是否有灵药==0 then
								if n=="雷法崩裂" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="雷法",回合="崩:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="雷法震煞" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="雷法",回合="震:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="雷法坤伏" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="雷法",回合="坤:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="雷法翻天" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="雷法",回合="天:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="雷法倒海" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="雷法",回合="海:"..v,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
						         end
						     else
						         if n=="雷法崩裂" then
						     	 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 崩:"..v
								 elseif n=="雷法震煞" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 震:"..v
								 elseif n=="雷法坤伏" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 坤:"..v
								 elseif n=="雷法翻天" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 天:"..v
								 elseif n=="雷法倒海" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 海:"..v
						         end
						     end
                        end
                    elseif n == "五行珠金" or n=="五行珠木" or n=="五行珠水" or n=="五行珠火" or n=="五行珠土" then
						if v>0 then
							f = 引擎.取状态图标("五行珠")
							local 是否有灵药 = 0
							for k=1,#self.法术状态[i] do
								if self.法术状态[i][k].名称 =="五行珠" then
									是否有灵药 = k
							    end
							end
							if 是否有灵药==0 then
								 if n=="五行珠金" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="五行珠",回合="金",显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="五行珠木" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="五行珠",回合="木",显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="五行珠水" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="五行珠",回合="水",显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="五行珠火" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="五行珠",回合="火",显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
								 elseif n=="五行珠土" then
								 	self.法术状态[i][#self.法术状态[i]+1]={名称="五行珠",回合="土",显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
						         end
						     else
						         if n=="五行珠金" then
						     	 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 金"
								 elseif n=="五行珠木" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 木"
								 elseif n=="五行珠水" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 水"
								 elseif n=="五行珠火" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 火"
								 elseif n=="五行珠土" then
								 	self.法术状态[i][是否有灵药].回合=self.法术状态[i][是否有灵药].回合.." 土"
						         end
						     end

                        end
                    elseif n == "人参娃娃" then
                       	     if v.回合>0 then
                       	     	self.法术状态[i][#self.法术状态[i]+1]={名称=n,回合=v.回合,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}
                       	     end
	                elseif v.回合 then
	                	self.法术状态[i][#self.法术状态[i]+1]={名称=n,回合=v.回合,显示=true,图标 = tp.资源:载入(f[2],"网易WDF动画",f[1])}

	              end
			 end
		end
	end

end






function 系统类_消息框:清空内容()
	self.丰富文本:清空()
	self.丰富文本外框:清空()
end

function 系统类_消息框:取高度()
	return h
end

function 系统类_消息框:显示(dt,mx,my)
	self.可移动 = false
	self.可拉伸 = false
	self.控件类:更新(dt,mx,my)
	self.按钮_下:更新(mx,my)
	self.按钮_左拉:更新(mx,my)
	self.按钮_上拉:更新(mx,my)
	self.按钮_下拉:更新(mx,my)
	self.频道名字:更新(mx,my)
	self.按钮_移动:更新(mx,my)
	self.按钮_查询:更新(mx,my)
	self.按钮_禁止:更新(mx,my)
	self.按钮_锁定:更新(mx,my)
	self.按钮_清屏:更新(mx,my)
	self.按钮_拉伸:更新(mx,my)
	self.按钮_颜色框:更新(mx,my)
	self.喇叭:更新(mx,my)
    if self.本页临时高度~=全局游戏高度 then
        y = 全局游戏高度-165
        self.本页临时高度 = 全局游戏高度
        y1 = y
    end
	local qqqqy=全局游戏高度-19-self.qqy
	if self.按钮_下:事件判断() then
		self.隐藏 = not self.隐藏
	elseif self.按钮_左拉:事件判断() and not self.频道[self.序列]:是否选中(mx,my) then
		self.外部聊天 = self.外部聊天 == false
		if self.外部聊天 then
			引擎.外部 = require("script/功能界面/聊天框外部")(tp)
			-- self.丰富文本:置宽度(250)
			self.丰富文本外框:置高度(全局游戏高度-20)--600
			if self.丰富文本外框.滚动值 > 0 then
				self.丰富文本外框:滚动(-self.丰富文本外框.滚动值)
			end
			if self.丰富文本外框.滚动值 < #self.丰富文本外框.显示表 - floor(h/25) then
				self.丰富文本外框:滚动(self.丰富文本外框.滚动值)
			end
			self.按钮_左拉.外部按钮 = true
			self.按钮_上拉.外部按钮 = true
			self.按钮_下拉.外部按钮 = true
			self.按钮_移动.外部按钮 = true
			self.按钮_查询.外部按钮 = true
			self.按钮_禁止.外部按钮 = true
			self.按钮_锁定.外部按钮 = true
			self.按钮_清屏.外部按钮 = true
			self.按钮_移动.确定按下 = nil
		end
	elseif self.按钮_下拉:事件判断() then
		if self.丰富文本.滚动值 > 0 then
			self.丰富文本:滚动(-1)
		end
	elseif self.按钮_上拉:事件判断() then
		if self.丰富文本.滚动值 < #self.丰富文本.显示表 - floor(h/25) then
			self.丰富文本:滚动(1)
		end
	elseif self.按钮_禁止:事件判断() then
		self.禁止 = false
	elseif self.按钮_清屏:事件判断() then
		self:清空内容()
	elseif self.按钮_颜色框:事件判断() then
		self.颜色开始 = self.颜色开始 == false
	end

	if  self.外部聊天 and tp.战斗中 then      --------------假人修复
    	self.丰富文本外框:置高度(全局游戏高度/2-20)--600
    else
    	self.丰富文本外框:置高度(全局游戏高度-20)--600
    end

	if not self.外部聊天 then
		-- 窗口拉伸
		bw1:置坐标(x,y-22)
		if (bw1:检查点(mx,my) or self.按钮_拉伸.确定按下) and not tp.选中UI then
			tp.按钮焦点 = true
			self.可拉伸 = true
		end
		if mousea(0) and self.可拉伸 then
			yyy = my - y
		    self.移动 = true
		elseif mouseb(0) or tp.隐藏UI or tp.消息栏焦点 then
			self.移动 = false
		end
		if self.移动 and self.可拉伸 then
		    local ys = y
			local lsy = my - yyy
			local lsh = h + (ys-lsy)
			local pd = (y - ys) > 0
			if lsh < 127 then
				lsh = 127
			elseif lsh > 291 then
				lsh = 291
			end
			h = lsh
			y = y1-h+127
			self.丰富文本:置高度(h)
			if #self.丰富文本.显示表 - floor(h/25) >= self.丰富文本.滚动值 and pd then
				self.丰富文本:滚动(-1)
			end
			tp.选中UI = true
			self.精灵组框:置宽高(400+10,h+15)
		end
		-- 窗口移动
		bw:置坐标(x+82,y+90+(h-97))
		if (bw:检查点(mx,my) or self.按钮_移动.确定按下) and not tp.选中UI then
			tp.按钮焦点 = true
			self.可移动 = true
		end
		if mousea(0) and self.可移动 then
		    xx = mx - x
		    yy = my - y
		    self.移动 = true
		elseif mouseb(0) or tp.隐藏UI or tp.消息栏焦点 then
			self.移动 = false
		end
		if self.移动 and self.可移动 then
			x = mx - xx
			y = my - yy
			y1 = y+h-127
			tp.选中UI = true
		end
		self.精灵组框:显示(x,y)
		self.丰富文本:显示(x + 4,y+2)
		self.按钮_拉伸:显示(x,y-22,true)
		self.按钮_左拉:显示(x + 13 + 30,y + 90+(h-97),true)
		self.按钮_上拉:显示(x + 36 + 30,y + 90+(h-97),true)
		self.按钮_下拉:显示(x + 59 + 30,y + 90+(h-97),true)
		self.按钮_移动:显示(x + 83 + 30,y + 90+(h-97),true)
		self.按钮_查询:显示(x + 106 + 30,y + 90+(h-97),true)
		self.按钮_禁止:显示(x + 129 + 30,y + 90+(h-97),true)
		self.按钮_锁定:显示(x + 153 + 30,y + 90+(h-97),true)
		self.按钮_清屏:显示(x + 175 + 30,y + 90+(h-97),true)
		self.喇叭:显示(x + 28,y -22,true)
	end
		if self.喇叭:事件判断() then
  	       tp.窗口.传音飞鸽:打开()
	   end
	self.输入背景:显示(0,全局游戏高度-23)
	self.输入背景1:显示(40,全局游戏高度-23)
	if self.输入背景:是否选中(mx,my) and not tp.选中UI then
		tp.按钮焦点 = true
	end
	self.控件类:显示(mx,my)
	self.频道[self.序列]:显示(0,全局游戏高度-22)
	if self.频道[self.序列]:是否选中(mx,my) then
		tp.按钮焦点 = true
		if 引擎.鼠标弹起(左键) then
			if self.频道开关 then
				self.频道开关=false
			else
				self.频道开关=true
			end
		end
	end
	if self.频道开关 then
		for n=1,#self.频道 do
			self.频道[n]:显示(0,全局游戏高度-25-n*22)
			if self.频道[n]:是否选中(mx,my) then
				tp.按钮焦点 = true
				if 引擎.鼠标弹起(左键) then
					self.序列=n
					self.频道开关=false
				end
			end
		end
	end
	self.频道背景:显示(0,全局游戏高度-13)
	-- self.频道名字:显示(0,全局游戏高度-23)
	self.频道背景:显示(0,全局游戏高度-32)
	self.按钮_颜色框:显示(410,全局游戏高度-23,true)
	self.表情开关:显示(420,全局游戏高度-2)
    if qqqqy~=self.qqy then
        self.输入:置坐标(0,qqqqy)
    end
	if  keyb(KEY.ENTER) and tp.窗口.好友消息.可视==false  then
		if self.输入:取文本() == "" then
			tp.常规提示:打开("#Y/温馨提示：你还未输入内容")
		else
			请求服务(6001,{频道=self.序列,文本=self.输入:取文本(),self.超链接})
			self.发言记录[#self.发言记录+1]=self.输入:取文本()
			self.超链接记录[#self.超链接记录+1] = self.超链接
			if #self.发言记录>20 then
             table.remove(self.发言记录,1)
             table.remove(self.超链接记录,1)
			end
			self.发言序列=#self.发言记录
			self.输入:置文本("")
			--self.上次链接数据 = table.copy(self.超链接)
			self.超链接 = {}
			tp.窗口.道具行囊.展示 = 0
			-- self.输入:置焦点(false)
		end
	end
	if 引擎.按键弹起(键盘符号.上) and self.发言序列~=nil then
		if self.发言序列<=0 then
			return
		end
		self.输入:置文本(self.发言记录[self.发言序列])
		self.超链接 = self.超链接记录[self.发言序列]
		self.发言序列=self.发言序列-1
	elseif 引擎.按键弹起(键盘符号.下) and self.发言序列~=nil then
		if self.发言序列>#self.发言记录 then
			return
		end
		self.发言序列=self.发言序列+1
		self.输入:置文本(self.发言记录[self.发言序列])
	end
	bw3:置坐标(420,全局游戏高度-29)
	if bw3:检查点(mx,my) and not tp.选中UI then
		self.表情开关:更新(dt)
		tp.按钮焦点 = true
		tp.提示:自定义(mx,my,"快捷键:ALT+ -")
		if mousea(0) then
			tp.窗口.表情窗口:打开()--打开表情窗口
		end
	else
		if self.表情开关.当前帧 ~= 2 then
			self.表情开关.当前帧 = 2
			self.表情开关:更新纹理()
		end
	end
	if self.颜色开始 then
		self.背景:显示(410,全局游戏高度-54)
		for n=1,#self.颜色表 do
			self.颜色精灵:置颜色(self.颜色表[n][2])
			bw2:置坐标(398+n*15,全局游戏高度-48)
			self.颜色精灵:显示(398+n*15,全局游戏高度-48)
			if bw2:检查点(mx,my) and not tp.选中UI then
				tp.提示:自定义(mx+1,my+1,format("#W/%s",self.颜色表[n][3]))
				tp.按钮焦点 = true
				if mousea(0) then
				   self.输入:添加文本(self.颜色表[n][1])
				   self.颜色开始 = false
				   tp.下一次确定 = true
				   break
				end
			end
		end
	end
	if tp.下一次确定 then
		self.计时 = self.计时 + 1
		if self.计时 == 10 then
			self.计时 = 0
			tp.下一次确定 = false
		end
	end
end

return 系统类_消息框
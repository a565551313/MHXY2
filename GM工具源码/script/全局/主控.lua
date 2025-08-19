--======================================================================--
-- @作者: GGE研究群: 342119466
-- @创建时间:   2018-03-03 02:34:19//

--======================================================================--
local 场景类_场景 = class()
local ceil = math.ceil
local floor = math.floor
local sort = table.sort
local require = require
local pairs = pairs
local insert = table.insert
local txk = 引擎.特效库
local mousea = 引擎.鼠标按下
local mouseb = 引擎.鼠标弹起
local ARGB = ARGB
local type = type
local remove = table.remove
local xys = 生成XY
function 场景类_场景:初始化()
	tp = self
	self.资源 = require("script/资源类/加载类")(self)
	self.资源:打开()
	self._自适应 = require("script/系统类/自适应")
	self._按钮 = require("script/系统类/按钮")
	self._小型选项栏 = require("script/系统类/小型选项栏")
	self._丰富文本 = require("script/系统类/丰富文本")
	self._列表 = require("script/系统类/列表")
	self._滑块 =  require("script/系统类/滑块")
	self.画线 = tp.资源:载入('gj.wdf',"网易WDF动画",0xA1442425)
	local wz = require("gge文字类")
	self.文字类=wz
	self.字体表 = {
		普通字体 = wz.创建(nil,20,true,true,false),  --ggeobj:初始化(文件,大小,粗体,可描边,抗锯齿)
		名称字体 = wz.创建(nil,16,false,false,false),
	}

	图像类 = require("gge图像类1")

	require("script/全局/变量2")

	ffi = require("ffi")
	f函数=require("ffi函数2")
	资源char = ffi.new('char[10485760]')
	资源p = tonumber(ffi.cast("intptr_t",资源char))
	FMOD类2	= require("FMOD类5")
	FMOD类3  = require("FMOD类5")
	local fc = self._自适应.创建()

	fc:加载(self)

	self.提示框 = self._自适应.创建(6,1,1,1,3,9)

	--客户端=require("script/网络/hp").创建()

	 客户端=require("script/ForYourOwnUse/服务连接")

	self.鼠标 = require("script/初系统/鼠标").创建(self)

	self.提示 = require("script/初系统/提示类").创建(self)

	self.登陆 = require("script/初系统/登陆").创建(self)
	self.功能界面 = require("script/初系统/功能界面").创建(self)
	self.进程 = 0

end

function 场景类_场景:显示(dt,x,y)
	if self.进程 == 0 then
		self.登陆:显示(dt,x,y)
	elseif self.进程 == 1 then --进入处理命令
		self.功能界面:显示(dt,x,y)
	end
	if #self.提示.寄存内容 > 0 then
		if self.提示.寄存内容.开启提示 then
			self.提示框:置宽高(self.提示.寄存内容.提示坐标[3]+15,self.提示.寄存内容.提示坐标[4]+12)
			self.提示框:显示(self.提示.寄存内容.提示坐标[1],self.提示.寄存内容.提示坐标[2])
		end
		for i=1,#self.提示.寄存内容 do
			if self.提示.寄存内容[i].内容 ~= nil then
			    self.提示.寄存内容[i].内容:显示(self.提示.寄存内容[i].x,self.提示.寄存内容[i].y)
			else
				if self.提示.寄存内容[i].文字 ~= nil then
				 	self.提示.寄存内容[i].文字:置颜色(self.提示.寄存内容[i].颜色):显示(self.提示.寄存内容[i].坐标[1],self.提示.寄存内容[i].坐标[2],self.提示.寄存内容[i].文本)
				end
			end
		end
		self.提示:清空寄存()
	end
	self.提示:显示()
	self.鼠标:更新(dt,x,y)
	self.鼠标:显示(dt,x,y)
end

return 场景类_场景